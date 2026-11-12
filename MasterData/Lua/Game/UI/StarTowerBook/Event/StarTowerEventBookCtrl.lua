local StarTowerEventBookCtrl = class("StarTowerEventBookCtrl", BaseCtrl)
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local typeof = _ENV.typeof
local Path = require("path")
local Offset = CS.Actor2DOffsetData
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
StarTowerEventBookCtrl._mapNodeConfig = {
  tabLsv = {
    sComponentName = "LoopScrollView"
  },
  trSv = {sNodeName = "tabLsv", sComponentName = "Transform"},
  txtCollectCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Event_Book_Collect"
  },
  txtCollect = {sComponentName = "TMP_Text"},
  txtEventName = {sComponentName = "TMP_Text"},
  eventDescSv = {sComponentName = "ScrollRect"},
  txtEventDesc = {sComponentName = "TMP_Text"},
  goArea = {},
  txtAreaCn = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Event_Book_Source"
  },
  txtArea = {nCount = 2, sComponentName = "TMP_Text"},
  txtProc = {sComponentName = "TMP_Text"},
  btnReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Receive"
  },
  imgReceived = {},
  txtReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Event_Book_Received"
  },
  goEventLock = {},
  goEventUnlock = {},
  UIParticle = {nCount = 2},
  imgReward = {nCount = 2, sComponentName = "Image"},
  txtRewardCount = {sComponentName = "TMP_Text"},
  rtActor2D = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  },
  rtTxtAreaCn2 = {
    sNodeName = "txtAreaCn2",
    sComponentName = "RectTransform"
  },
  btnReceiveAllEvent = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ReceiveAll"
  },
  TMPReceiveAllEventTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Btn_ReceiveAll"
  }
}
StarTowerEventBookCtrl._mapEventConfig = {}
StarTowerEventBookCtrl._mapRedDotConfig = {}

function StarTowerEventBookCtrl:UnRegisterRedDot()
end

function StarTowerEventBookCtrl:Init()
  self.nSelectIndex = 1
  self.nSelectEventId = 0
  self:RefreshEventList()
  self:RefreshSelectEvent()
end

function StarTowerEventBookCtrl:Back()
  self:UnRegisterRedDot()
  EventManager.Hit("ChangeStarTowerBookPanel", AllEnum.StarTowerBookPanelType.Main)
end

function StarTowerEventBookCtrl:RefreshSelectEvent()
  local eventData = self.mapEventBook[self.nSelectIndex]
  if eventData ~= nil then
    self._mapNode.goEventLock.gameObject:SetActive(eventData.Status == AllEnum.BookQuestStatus.UnComplete)
    self._mapNode.goEventUnlock.gameObject:SetActive(eventData.Status ~= AllEnum.BookQuestStatus.UnComplete)
    NovaAPI.SetVerticalNormalizedPosition(self._mapNode.eventDescSv, 1)
    NovaAPI.SetTMPText(self._mapNode.txtEventName, eventData.CfgData.Name)
    NovaAPI.SetTMPText(self._mapNode.txtEventDesc, eventData.CfgData.Story)
    NovaAPI.SetTMPText(self._mapNode.txtArea[1], eventData.CfgData.Source)
    NovaAPI.SetTMPText(self._mapNode.txtArea[2], eventData.CfgData.Source)
    NovaAPI.SetTMPText(self._mapNode.txtProc, orderedFormat(ConfigTable.GetUIText("StarTower_Event_Book_EventProc") or "", eventData.nCurProgress, eventData.nGoal))
    self._mapNode.imgReceived.gameObject:SetActive(eventData.Status == AllEnum.BookQuestStatus.Received)
    self._mapNode.imgReward[1].gameObject:SetActive(eventData.Status ~= AllEnum.BookQuestStatus.Received)
    self._mapNode.imgReward[2].gameObject:SetActive(eventData.Status == AllEnum.BookQuestStatus.Received)
    for _, v in ipairs(self._mapNode.UIParticle) do
      v.gameObject:SetActive(eventData.Status == AllEnum.BookQuestStatus.Complete)
    end
    local nRewardId = eventData.CfgData.ItemId
    local itemCfg = ConfigTable.GetData_Item(nRewardId)
    if itemCfg ~= nil then
      self:SetPngSprite(self._mapNode.imgReward[1], itemCfg.Icon)
      self:SetPngSprite(self._mapNode.imgReward[2], itemCfg.Icon)
    end
    local nCount = eventData.CfgData.ItemQty
    NovaAPI.SetTMPText(self._mapNode.txtRewardCount, "x" .. nCount)
    local nCharId = eventData.CfgData.NPCId
    local nType = eventData.CfgData.Type
    if nCharId ~= nil then
      local trans = self._mapNode.rtActor2D
      local trPanelOffset = trans:GetChild(0)
      local trOffset = trPanelOffset:GetChild(0)
      local imgBody = trOffset:GetChild(0):GetComponent("Image")
      local imgFace = trOffset:GetChild(1):GetComponent("Image")
      local nShowPanelId = self:GetPanelId()
      local tbPanelOffsetData = Actor2DManager.GetMapPanelConfig(nShowPanelId)
      local x, y, s = 0, 0, 1
      if tbPanelOffsetData ~= nil then
        if 0 < tbPanelOffsetData.nReuse then
          x = tbPanelOffsetData.v3PanelOffset.x
          y = tbPanelOffsetData.v3PanelOffset.y
          s = tbPanelOffsetData.v3PanelOffset.z
        end
        if s <= 0 then
          s = 1
        end
      end
      trPanelOffset.localPosition = Vector3(x * 100, y * 100, 0)
      trPanelOffset.localScale = Vector3(s, s, 1)
      local v3OffsetPos, v3OffsetScale = self:GetCharPortrait(imgBody, imgFace, nCharId, nType)
      trOffset.localScale = v3OffsetScale
      trOffset.localPosition = v3OffsetPos
    end
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    NovaAPI.SetScrollRectVertical(self._mapNode.eventDescSv, true)
  end
  
  cs_coroutine.start(wait)
end

function StarTowerEventBookCtrl:GetCharPortrait(imgBody, imgFace, nCharId, nType)
  local nSkinId = 0
  if nType == 1 then
    nSkinId = ConfigTable.GetData_Character(nCharId).DefaultSkinId
  else
    nSkinId = ConfigTable.GetData("StarTowerNPC", nCharId).NPCSkin
  end
  
  local function GetName(sPortrait, Face)
    local sFileFullName = Path.basename(sPortrait)
    local sFileExtName = Path.extension(sPortrait)
    local sFileName = string.gsub(sFileFullName, sFileExtName, "")
    sFileName = string.gsub(sFileName, "_a", "")
    local sBodyName = string.format("%s_%s", sFileName, "001")
    local sFaceName = string.format("%s_%s", sFileName, Face)
    return sBodyName, sFaceName
  end
  
  local function GetSprite(sPortrait, sName)
    local _sPath = string.format("%s/atlas_png/a/%s.png", Path.dirname(sPortrait), sName)
    return self:LoadAsset(_sPath, typeof(Sprite))
  end
  
  local mapSkinData
  if nType == 1 then
    mapSkinData = ConfigTable.GetData("CharacterSkin", nSkinId)
  else
    mapSkinData = ConfigTable.GetData("NPCSkin", nSkinId)
  end
  if mapSkinData == nil then
    return Vector3.zero, Vector3.one
  end
  local sAssetPath = mapSkinData.Portrait
  local sFace = "002"
  local sBodyName, sFaceName = GetName(sAssetPath, sFace)
  NovaAPI.SetImageSpriteAsset(imgBody, GetSprite(sAssetPath, sBodyName))
  NovaAPI.SetImageSpriteAsset(imgFace, GetSprite(sAssetPath, sFaceName))
  NovaAPI.SetImageNativeSize(imgBody)
  NovaAPI.SetImageNativeSize(imgFace)
  local objOffset = self:LoadOffset(mapSkinData.Offset)
  local nX, nY = 0, 0
  local s, x, y = objOffset:GetOffsetData(self:GetPanelId(), indexOfPose("a"), true, nX, nY)
  local v3OffsetPos = Vector3(x * 100, y * 100, 0)
  local v3OffsetScale = Vector3(s, s, 1)
  return v3OffsetPos, v3OffsetScale
end

function StarTowerEventBookCtrl:LoadOffset(sPath)
  return self:LoadAsset(sPath, typeof(Offset))
end

function StarTowerEventBookCtrl:RefreshEventList()
  self.mapEventBook = PlayerData.StarTowerBook:GetAllEventBookData()
  for nIndex, v in ipairs(self.mapEventBook) do
    if RedDotManager.GetValid(RedDotDefine.StarTowerBook_Event_Reward, v.Id) then
      self.nSelectIndex = nIndex
      break
    end
  end
  for nInstanceId, objCtrl in pairs(self.mapGrids) do
    self:UnbindCtrlByNode(objCtrl)
    self.mapGrids[nInstanceId] = nil
  end
  if self.nSelectIndex == 1 then
    self._mapNode.tabLsv:SetAnim(0.02)
  end
  self._mapNode.tabLsv:Init(#self.mapEventBook, self, self.OnRefreshGrid, self.OnGridBtnClick)
  self._mapNode.tabLsv:SetScrollGridPos(self.nSelectIndex - 1, 0.1, 0)
  local nAllCount = 0
  local nCount = 0
  local bShowAllReceive = false
  for _, v in pairs(self.mapEventBook) do
    nAllCount = nAllCount + 1
    if v.Status ~= AllEnum.BookQuestStatus.UnComplete then
      nCount = nCount + 1
    end
    if v.Status == AllEnum.BookQuestStatus.Complete then
      bShowAllReceive = true
    end
  end
  self._mapNode.btnReceiveAllEvent.gameObject:SetActive(bShowAllReceive)
  NovaAPI.SetTMPText(self._mapNode.txtCollect, string.format("%s/%s", nCount, nAllCount))
end

function StarTowerEventBookCtrl:OnRefreshGrid(goGrid, gridIndex)
  local nInstanceID = goGrid:GetInstanceID()
  if nil == self.mapGrids[nInstanceID] then
    self.mapGrids[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.StarTowerBook.Event.EventBookTogItemCtrl")
  end
  local nIndex = gridIndex + 1
  local eventData = self.mapEventBook[nIndex]
  self.mapGrids[nInstanceID]:InitItem(eventData)
  self.mapGrids[nInstanceID]:SetSelect(self.nSelectIndex == nIndex)
end

function StarTowerEventBookCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local eventData = self.mapEventBook[nIndex]
  if self.nSelectEventId == eventData.Id then
    return
  end
  local nInstanceId = goGrid:GetInstanceID()
  local goSelect = self._mapNode.trSv:Find("Viewport/Content/" .. self.nSelectIndex - 1)
  if goSelect then
    self.mapGrids[goSelect.gameObject:GetInstanceID()]:SetSelect(false)
  end
  self.mapGrids[nInstanceId]:SetSelect(true)
  self.nSelectIndex = nIndex
  self.nSelectEventId = eventData.Id
  self:RefreshSelectEvent()
end

function StarTowerEventBookCtrl:Awake()
  self.nSelectEventId = 0
  self.nSelectIndex = 0
  self.mapGrids = {}
end

function StarTowerEventBookCtrl:OnEnable()
end

function StarTowerEventBookCtrl:OnDisable()
  self:UnRegisterRedDot()
  for nInstanceId, objCtrl in pairs(self.mapGrids) do
    self:UnbindCtrlByNode(objCtrl)
    self.mapGrids[nInstanceId] = nil
  end
  self.mapGrids = {}
end

function StarTowerEventBookCtrl:OnDestroy()
end

function StarTowerEventBookCtrl:OnRelease()
end

function StarTowerEventBookCtrl:OnBtnClick_Receive()
  local eventData = self.mapEventBook[self.nSelectIndex]
  if eventData ~= nil and eventData.Status == AllEnum.BookQuestStatus.Complete then
    local function callback()
      self.mapEventBook = PlayerData.StarTowerBook:GetAllEventBookData()
      
      self:RefreshSelectEvent()
    end
    
    PlayerData.Quest:ReceiveStarTowerEventReward(eventData.Id, callback)
  end
end

function StarTowerEventBookCtrl:OnBtnClick_ReceiveAll()
  local function callback()
    self.mapEventBook = PlayerData.StarTowerBook:GetAllEventBookData()
    
    self:RefreshSelectEvent()
    self._mapNode.btnReceiveAllEvent.gameObject:SetActive(false)
  end
  
  PlayerData.Quest:ReceiveStarTowerEventReward(0, callback)
end

return StarTowerEventBookCtrl
