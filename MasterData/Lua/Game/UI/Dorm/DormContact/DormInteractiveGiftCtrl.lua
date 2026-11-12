local DormInteractiveGiftCtrl = class("DormInteractiveGiftCtrl", BaseCtrl)
local newDayTime = UTILS.GetDayRefreshTimeOffset()
local LocalData = require("GameCore.Data.LocalData")
DormInteractiveGiftCtrl._mapNodeConfig = {
  loopsvGiftList = {
    sNodeName = "svGiftList",
    sComponentName = "LoopScrollView"
  },
  btnPresent = {
    sComponentName = "UIButton",
    callback = "OnBtn_ClickSendGift"
  },
  btnPresentGray = {sComponentName = "UIButton"},
  goEmpty = {sNodeName = "Empty"},
  txtGiftCount = {sComponentName = "TMP_Text"},
  btnDetails = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Details"
  },
  txtEmptyCount = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_GiftEmptyTitle"
  },
  txtBtnPresent = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_Contact_BtnSendGift"
  },
  txtBtnPresentGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_Contact_BtnSendGift"
  }
}
DormInteractiveGiftCtrl._mapEventConfig = {}
DormInteractiveGiftCtrl._mapRedDotConfig = {}

function DormInteractiveGiftCtrl:Awake()
end

function DormInteractiveGiftCtrl:FadeIn()
end

function DormInteractiveGiftCtrl:FadeOut()
end

function DormInteractiveGiftCtrl:OnEnable()
  self.tbGridCtrl = {}
  self.tbChooseItem = {}
  self.addedLevel = 0
  self.parent = nil
  self.curFavourExp = 0
  self.animator = self.gameObject:GetComponent("Animator")
end

function DormInteractiveGiftCtrl:OnDisable()
  if self.tbGridCtrl then
    for k, v in pairs(self.tbGridCtrl) do
      self:UnbindCtrlByNode(v)
    end
  end
  self.tbGridCtrl = {}
  self.gameObject:SetActive(false)
end

function DormInteractiveGiftCtrl:OnDestroy()
end

function DormInteractiveGiftCtrl:OnRelease()
end

function DormInteractiveGiftCtrl:OpenGiftChoose(nCharId, parent)
  self.nCharId = nCharId
  self.parent = parent
  local mapCharAffinity = ConfigTable.GetData("CharAffinityTemplate", self.nCharId)
  if mapCharAffinity == nil then
    return
  end
  local templateId = mapCharAffinity.TemplateId
  self.MaxAffinityLevel = PlayerData.Char:GetMaxAffinityLevel(templateId)
  local affinityData = PlayerData.Char:GetCharAffinityData(nCharId)
  self.curFavourLevel = affinityData.Level
  self.curFavourExp = affinityData.Exp
  self.nMaxSendGiftCount = PlayerData.PlayerDormData:GetCharGiftCountDay(nCharId)
  local mapCharDesc = ConfigTable.GetData("CharacterDes", self.nCharId)
  if mapCharDesc ~= nil then
    self.PreferenceData = {
      PreferTags = mapCharDesc.PreferTags,
      HateTags = mapCharDesc.HateTags
    }
  end
  self:RefreshItemList()
  self:SetDaySendCount()
end

function DormInteractiveGiftCtrl:RefreshItemList()
  self.tbItemData = {}
  self.tbChooseItem = {}
  local listCount = 0
  local tbAllItem = {}
  
  local function foreachAffinityGift(mapData)
    local count = PlayerData.Item:GetItemCountByID(mapData.Id)
    local itemData = ConfigTable.GetData_Item(mapData.Id)
    if itemData ~= nil then
      local favourLevel = self:GetGiftFavourLevel(mapData.Tags)
      if 0 < count then
        table.insert(tbAllItem, {
          nTid = itemData.Id,
          nRarity = itemData.Rarity,
          nCount = count,
          nExpire = itemData.ExpireType,
          favourLevel = favourLevel
        })
      end
    end
  end
  
  ForEachTableLine(DataTable.AffinityGift, foreachAffinityGift)
  self._mapNode.goEmpty:SetActive(#tbAllItem == 0)
  self._mapNode.loopsvGiftList.gameObject:SetActive(0 < #tbAllItem)
  self.tbItemData = {}
  if 0 < #tbAllItem then
    table.sort(tbAllItem, function(a, b)
      if a.favourLevel == b.favourLevel then
        if a.nRarity == b.nRarity then
          return a.nTid < b.nTid
        end
        return a.nRarity < b.nRarity
      end
      return a.favourLevel < b.favourLevel
    end)
    for _, v in ipairs(tbAllItem) do
      for i = 1, v.nCount do
        listCount = listCount + 1
        table.insert(self.tbItemData, {
          nTid = v.nTid,
          nRarity = v.nRarity,
          nCount = 1,
          nExpire = v.nExpire,
          favourLevel = v.favourLevel
        })
      end
    end
    self._mapNode.loopsvGiftList:Init(listCount, self, self.RefreshItemGrid, self.OnBtnClickItemGrid)
  end
  self._mapNode.btnPresentGray.gameObject:SetActive(#self.tbItemData == 0)
  self._mapNode.btnPresent.gameObject:SetActive(#self.tbItemData > 0)
end

function DormInteractiveGiftCtrl:RefreshItemGrid(grid)
  local nIndex = tonumber(grid.name) + 1
  local mapItem = self.tbItemData[nIndex]
  local nInstanceID = grid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    local itemObj = grid.transform:Find("btnGrid/AnimRoot/tc_item_02")
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(itemObj, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  self.tbGridCtrl[nInstanceID]:SetItem(mapItem.nTid, mapItem.nRarity, nil, mapItem.nExpire)
  local imgAffinityLevel = grid.transform:Find("btnGrid/AnimRoot/tc_item_02/imgAffinityGiftLevel"):GetComponent("Image")
  local level = mapItem.favourLevel
  self:SetAtlasSprite(imgAffinityLevel, "11_ico", "zs_present_heart_" .. level)
  if self.tbChooseItem ~= nil and self.tbChooseItem.nIdx == nIndex then
    self.tbGridCtrl[nInstanceID]:SetMultiSelected_Blue(true)
  end
end

function DormInteractiveGiftCtrl:OnBtnClickItemGrid(grid)
  local nInstanceID = grid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    return
  end
  local nIndex = tonumber(grid.name) + 1
  local mapItem = self.tbItemData[nIndex]
  local itemCtrl = self.tbGridCtrl[nInstanceID]
  if self.tbChooseItem ~= nil and self.tbChooseItem[nIndex] ~= nil then
    itemCtrl:SetMultiSelected_Blue(false)
    self.tbChooseItem[nIndex] = nil
  else
    local nCount = 0
    if self.tbChooseItem ~= nil then
      for nIndex, v in pairs(self.tbChooseItem) do
        if v ~= nil then
          nCount = nCount + 1
        end
      end
    end
    if nCount >= self.nMaxSendGiftCount then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Gift_Send_Day_Count_Max"))
      return
    end
    self.tbChooseItem[nIndex] = {
      nTid = mapItem.nTid,
      itemCtrl = itemCtrl
    }
    itemCtrl:SetMultiSelected_Blue(true)
  end
  self:OnItemChosen()
  self:SetDaySendCount()
end

function DormInteractiveGiftCtrl:GetGiftFavourLevelById(itemId)
  if self.PreferenceData == nil then
    return 2
  end
  local itemData = ConfigTable.GetData("AffinityGift", itemId)
  for k, v in ipairs(itemData.Tags) do
    for k1, v1 in ipairs(self.PreferenceData.PreferTags) do
      if v == v1 then
        return 1
      end
    end
  end
  for k, v in ipairs(itemData.Tags) do
    for k1, v1 in ipairs(self.PreferenceData.HateTags) do
      if v == v1 then
        return 3
      end
    end
  end
  return 2
end

function DormInteractiveGiftCtrl:OnItemChosen()
  local mapCharAffinity = ConfigTable.GetData("CharAffinityTemplate", self.nCharId)
  if mapCharAffinity == nil then
    return
  end
  if self.curFavourLevel >= self.MaxAffinityLevel then
    return
  end
  local nSelectCount = 0
  local addedExp = 0
  for nIndex, v in pairs(self.tbChooseItem) do
    local data = ConfigTable.GetData("AffinityGift", v.nTid)
    local level = self:GetGiftFavourLevelById(v.nTid)
    local AffinityGiftPreferenceProp = ConfigTable.GetConfigNumberArray("AffinityGiftPreferenceProp")
    local nExp = data.BaseAffinity * (AffinityGiftPreferenceProp[level] / 100 + 1)
    addedExp = addedExp + nExp
  end
  local mapCharAffinity = ConfigTable.GetData("CharAffinityTemplate", self.nCharId)
  if mapCharAffinity == nil then
    return
  end
  local templateId = mapCharAffinity.TemplateId
  local addedLevel = self.curFavourLevel
  local preFinalExp = addedExp + self.curFavourExp
  if 0 < addedExp then
    while 0 < preFinalExp and not (addedLevel >= self.MaxAffinityLevel) do
      local needExp = CacheTable.GetData("_AffinityLevel", templateId)[addedLevel + 1].NeedExp
      preFinalExp = preFinalExp - needExp
      if 0 <= preFinalExp then
        addedLevel = addedLevel + 1
        if addedLevel >= self.MaxAffinityLevel then
          preFinalExp = CacheTable.GetData("_AffinityLevel", templateId)[self.MaxAffinityLevel].NeedExp
          break
        end
      else
        preFinalExp = preFinalExp + needExp
        break
      end
    end
  end
  self.addedLevel = addedLevel
end

function DormInteractiveGiftCtrl:GetGiftFavourLevel(tags)
  if self.PreferenceData == nil then
    return 2
  end
  for k, v in ipairs(tags) do
    for k1, v1 in ipairs(self.PreferenceData.PreferTags) do
      if v == v1 then
        return 1
      end
    end
  end
  for k, v in ipairs(tags) do
    for k1, v1 in ipairs(self.PreferenceData.HateTags) do
      if v == v1 then
        return 3
      end
    end
  end
  return 2
end

function DormInteractiveGiftCtrl:SetDaySendCount()
  local nCount = 0
  if self.tbChooseItem ~= nil then
    for nIndex, v in pairs(self.tbChooseItem) do
      if v ~= nil then
        nCount = nCount + 1
      end
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtGiftCount, orderedFormat(ConfigTable.GetUIText("Phone_Gift_Send_Day_Count_1"), nCount, self.nMaxSendGiftCount))
end

function DormInteractiveGiftCtrl:Exit()
  if self.tbGridCtrl then
    for k, v in pairs(self.tbGridCtrl) do
      self:UnbindCtrlByNode(v)
    end
  end
  self.tbGridCtrl = {}
  self.animator:Play("DormGift_out")
  self:AddTimer(1, 0.3, function()
    self.gameObject:SetActive(false)
  end, true, true, true, nil)
end

function DormInteractiveGiftCtrl:OnBtn_ClickSendGift()
  if #self.tbItemData == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Gift_Send_Item_Empty"))
    return
  end
  if self.tbChooseItem == nil or next(self.tbChooseItem) == nil then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Gift_Send_Not_Select"))
    return
  end
  local sendCount = PlayerData.PlayerDormData:GetCharGiftCountDay(self.nCharId)
  if sendCount < 1 then
    local tips = ConfigTable.GetUIText("Gift_Send_Day_Count_Max")
    EventManager.Hit(EventId.OpenMessageBox, tips)
    return
  end
  
  local function sendGift()
    local tempCount = {}
    for nIndex, v in pairs(self.tbChooseItem) do
      if tempCount[v.nTid] == nil then
        tempCount[v.nTid] = 0
      end
      tempCount[v.nTid] = tempCount[v.nTid] + 1
    end
    local tbGift = {}
    for nTid, nCount in pairs(tempCount) do
      table.insert(tbGift, {Tid = nTid, Qty = nCount})
    end
    local nRoomId = self._panel.nCurRoom
    if self.parent ~= nil then
      self.parent:SendGiftResult(nRoomId, self.nCharId, tbGift)
    end
  end
  
  if self.curFavourLevel >= self.MaxAffinityLevel then
    local TipsTime = LocalData.GetPlayerLocalData("PhoneGiftMax_Tips_Time")
    local _tipDay = 0
    if TipsTime ~= nil then
      _tipDay = tonumber(TipsTime)
    end
    local curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
    local fixedTimeStamp = curTimeStamp + newDayTime * 3600
    local nYear = tonumber(os.date("!%Y", fixedTimeStamp))
    local nMonth = tonumber(os.date("!%m", fixedTimeStamp))
    local nDay = tonumber(os.date("!%d", fixedTimeStamp))
    local nowD = nYear * 366 + nMonth * 31 + nDay
    if nowD == _tipDay then
      sendGift()
    else
      local sTip = ConfigTable.GetUIText("PhoneGift_Send_Max_Tip")
      local isSelectAgain = false
      
      local function confirmCallback()
        if isSelectAgain then
          local _curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
          local _fixedTimeStamp = _curTimeStamp + newDayTime * 3600
          local _nYear = tonumber(os.date("!%Y", _fixedTimeStamp))
          local _nMonth = tonumber(os.date("!%m", _fixedTimeStamp))
          local _nDay = tonumber(os.date("!%d", _fixedTimeStamp))
          local _nowD = _nYear * 366 + _nMonth * 31 + _nDay
          LocalData.SetPlayerLocalData("PhoneGiftMax_Tips_Time", tostring(_nowD))
        end
        sendGift()
      end
      
      local function againCallback(isSelect)
        isSelectAgain = isSelect
      end
      
      local msg = {
        nType = AllEnum.MessageBox.Char,
        sContent = sTip,
        nCharId = self.nCharId,
        callbackConfirm = confirmCallback,
        callbackAgain = againCallback
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    end
    return
  end
  sendGift()
end

function DormInteractiveGiftCtrl:OnBtnClick_Details()
  local msg = {
    nType = AllEnum.MessageBox.Desc,
    sContent = ConfigTable.GetUIText("Dorm_GiftDesc")
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

return DormInteractiveGiftCtrl
