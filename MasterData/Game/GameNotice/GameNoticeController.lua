local GameNoticeController = class("GameNoticeController", ControllerBase)
local base = ControllerBase
local rapidjson = require("rapidjson")
local GameNoticeData = require("Game.GameNotice.GameNoticeData")
local GameNoticEnum = require("Game.GameNotice.GameNoticEnum")
local cs_MicaSDKManager = CS.MicaSDKManager.Instance
local cs_HttpDownloadHelper = CS.HttpDownloadHelper.Instance

function GameNoticeController:OnInit()
  self.jsonUrl = nil
  self.noticeHtml = nil
  self:_InitRedDot()
end

function GameNoticeController:LoadGameNoticeDatas(loadCallback)
  self.gameNoticDatas = nil
  self._loadOver = false
  self._loadCallback = loadCallback
  if self.jsonUrl == nil or self.noticeHtml == nil then
    self:LoadUrl()
  end
  if isGameDev then
    print("GameNoticeController jsonUrl:" .. tostring(self.jsonUrl))
  end
  if self.jsonUrl == nil then
    self._loadOver = false
    if self._loadCallback ~= nil then
      self._loadCallback(false)
    end
    return
  end
  if self._onJsonFormUrlCallback == nil then
    self._onJsonFormUrlCallback = BindCallback(self, self._OnGNJsonFormUrlCallback)
  end
  self:GetJsonFromURL(self.jsonUrl, self._onJsonFormUrlCallback, 5)
end

function GameNoticeController:LoadUrl()
  if not cs_MicaSDKManager:IsUseSdk() then
    return
  end
  self.jsonUrl = cs_MicaSDKManager.gameResUrls.GetNoticeUrl
  self.noticeHtml = cs_MicaSDKManager.gameResUrls.GetNoticeHtmlUrl
end

function GameNoticeController:_OnGNJsonFormUrlCallback(jsonTable)
  self._hasValidData = false
  if jsonTable == nil or jsonTable.code ~= 0 or jsonTable.data == nil then
    if self._loadCallback ~= nil then
      self._loadCallback(false)
    end
    return
  end
  local originData = {}
  self.gameNoticDatas = {}
  local useFulNameList = {}
  local noticeIds = {}
  for _, jsonData in ipairs(jsonTable.data.list) do
    local noticeData = GameNoticeData.CreateData(jsonData)
    if not noticeData:IsOutOfDate() then
      if noticeData:HasBannerPicName() then
        table.insert(useFulNameList, noticeData.picName)
      end
      if self.gameNoticDatas[noticeData.type] == nil then
        self.gameNoticDatas[noticeData.type] = {}
      end
      table.insert(self.gameNoticDatas[noticeData.type], noticeData)
      table.insert(originData, noticeData)
    end
    noticeIds[noticeData.idx] = false
  end
  self._hasValidData = 0 < #originData
  self:TryDeleteOutOfDataImg(useFulNameList)
  self._dataModel = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  if self._dataModel == nil then
    if self._loadCallback ~= nil then
      self._loadCallback(false)
    end
    return
  end
  self._dataModel:DiffLocalGNReadData(noticeIds)
  self._loadOver = true
  self:_InitNewDic()
  if self._loadCallback ~= nil then
    self._loadCallback(true)
  end
end

function GameNoticeController:GetEncryptHtmlUrl(gameNoticeIdx)
  if self.noticeHtml == nil then
    warn("GameNoticeController noticeHtml is nil")
    self.noticeHtml = ""
  end
  local url = self.noticeHtml .. "&notice_id=" .. tostring(gameNoticeIdx)
  return url
end

function GameNoticeController:HasNoticData()
  return self._loadOver and self.gameNoticDatas ~= nil and self._hasValidData
end

function GameNoticeController:GetNoticDataList(eNoticType)
  return self.gameNoticDatas[eNoticType]
end

function GameNoticeController:GetNoticData(eNoticType, index)
  return self.gameNoticDatas[eNoticType][index]
end

function GameNoticeController:_InitNewDic()
  self._hasNewDic = {}
  for typeId, list in pairs(self.gameNoticDatas) do
    local hasNewList = {}
    for index, data in ipairs(list) do
      if self:ContainGameNoticeIsNew(data.idx) then
        table.insert(hasNewList, index)
      end
    end
    if 0 < #hasNewList then
      self._hasNewDic[typeId] = hasNewList
    end
    self:_RefreshNoticeTypeRedDot(typeId, #hasNewList)
  end
end

function GameNoticeController:GetNewGNType()
  if self._hasNewDic ~= nil then
    local count = table.count(self._hasNewDic)
    if 2 <= count or count == 0 or self._hasNewDic[GameNoticEnum.eNoticType.activity] ~= nil then
      return GameNoticEnum.eNoticType.activity
    end
  end
  return GameNoticEnum.eNoticType.system
end

function GameNoticeController:GetNewGNDataIndex(eNoticType)
  if self._hasNewDic[eNoticType] == nil then
    return 1
  end
  return self._hasNewDic[eNoticType][1]
end

function GameNoticeController:HasGameNoticData(eNoticType)
  return self.gameNoticDatas[eNoticType] ~= nil
end

function GameNoticeController:SetGameNoticeIsRead(eNoticType, index)
  local gameNoticeData = self:GetNoticData(eNoticType, index)
  local list = self._hasNewDic[eNoticType]
  if list == nil then
    self:_RefreshNoticeTypeRedDot(eNoticType, 0)
  else
    local delIdx
    for k, v in ipairs(list) do
      if index == v then
        delIdx = k
        break
      end
    end
    if delIdx ~= nil then
      table.remove(list, delIdx)
      self:_RefreshNoticeTypeRedDot(eNoticType, #list)
    end
  end
  PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SaveIsReadGameNotice(gameNoticeData.idx)
end

function GameNoticeController:SaveModelData()
  PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
end

function GameNoticeController:ContainGameNoticeIsNew(gameNoticeIdx)
  return not PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):ContainGameNoticeIsRead(gameNoticeIdx)
end

function GameNoticeController:SaveTimestamp()
  local timestamp = math.floor(PlayerDataCenter.timestamp)
  PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SaveGameNoticeTimestamp(timestamp)
end

function GameNoticeController:CanAutoPushGameNotice()
  local saveTimestamp = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetGameNoticeTimestamp()
  if saveTimestamp == 0 or saveTimestamp == nil then
    return true
  end
  local saveTimeDate = TimeUtil:TimestampToDate(TimeUtil:TimpApplyLogicOffset(saveTimestamp))
  local curTimestamp = math.floor(PlayerDataCenter.timestamp)
  local curTimeDate = TimeUtil:TimestampToDate(TimeUtil:TimpApplyLogicOffset(curTimestamp))
  local isDay = saveTimeDate.day == curTimeDate.day
  local isMonth = saveTimeDate.month == curTimeDate.month
  local isYear = saveTimeDate.year == curTimeDate.year
  if isDay and isMonth and isYear then
    return false
  end
  return true
end

function GameNoticeController:_InitRedDot()
  for _, typeID in pairs(GameNoticEnum.eNoticType) do
    RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.GameNotice, typeID)
  end
end

function GameNoticeController:_RefreshNoticeTypeRedDot(typeId, count)
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.GameNotice, typeId)
  if ok then
    node:SetRedDotCount(count)
  end
end

function GameNoticeController:GetJsonFromURL(url, callback, timeout)
  cs_HttpDownloadHelper:GetStringFromUrl(url, function(str)
    if string.IsNullOrEmpty(str) then
      warn("banner error url:" .. tostring(url))
      callback(nil)
      return
    end
    local tab = rapidjson.decode(str)
    callback(tab)
  end, timeout)
end

function GameNoticeController:GetNoticPicFromHTTP(url, fileName, callback)
  if string.IsNullOrEmpty(url) then
    warn("GetNoticPicFromHTTP url Address is null")
    return
  end
  if string.IsNullOrEmpty(fileName) then
    warn("GetNoticPicFromHTTP fileName is null")
    return
  end
  cs_HttpDownloadHelper:GetImgFromUrl(url, PathConsts:GetPersistentNoticeCachePath(fileName), function(Sprite)
    if Sprite == nil then
      if isGameDev then
        error("banner error url:" .. tostring(url) .. " sprite fileName:" .. tostring(fileName))
      end
      callback(nil)
    end
    callback(Sprite)
  end)
end

function GameNoticeController:TryDeleteOutOfDataImg(useFulNameList)
  cs_HttpDownloadHelper:DeleteImgNotUseful(PathConsts.PersistentNoticeCachePath, useFulNameList)
end

function GameNoticeController:OnDelete()
  base.OnDelete(self)
end

return GameNoticeController
