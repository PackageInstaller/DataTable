local PhoneGiftCtrl = class("PhoneGiftCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local JumpUtil = require("Game.Common.Utils.JumpUtil")
local LocalData = require("GameCore.Data.LocalData")
local newDayTime = UTILS.GetDayRefreshTimeOffset()
PhoneGiftCtrl._mapNodeConfig = {
  txtGiftTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Phone_Gift_Send_Title"
  },
  txtPresentTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dating_Send_Gift_Title"
  },
  loopsvGiftList = {
    sNodeName = "svGiftList",
    sComponentName = "LoopScrollView"
  },
  goEmpty = {sNodeName = "Empty", sComponentName = "GameObject"},
  txtArea = {
    sComponentName = "TMP_Text",
    sLanguageId = "Phone_Gift_Send_List_Area"
  },
  btnSource = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Source"
  },
  imgSourceIcon = {nCount = 2, sComponentName = "Image"},
  txtSource = {nCount = 2, sComponentName = "TMP_Text"},
  txtCharLandmark = {sComponentName = "TMP_Text"},
  imgAffinity = {sComponentName = "Image"},
  txtAffinityLevel = {sComponentName = "TMP_Text"},
  txtLevelCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dating_Affinity_Level"
  },
  txtAffinityLevelCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dating_Send_Gift_Tacit"
  },
  txtGiftCount = {sComponentName = "TMP_Text"},
  rectPreProgress = {
    sNodeName = "imgPreProgress",
    sComponentName = "RectTransform"
  },
  rectProgress = {
    sNodeName = "imgProgress",
    sComponentName = "RectTransform"
  },
  goAffinityInfo = {
    sNodeName = "goAffinityinfo",
    sComponentName = "GameObject"
  },
  btnPresent = {
    sComponentName = "UIButton",
    callback = "OnBtn_ClickSendGift"
  },
  txtBtnPresent = {
    sComponentName = "TMP_Text",
    sLanguageId = "Phone_Gift_Send_Btn"
  },
  btnPresentGray = {
    sComponentName = "UIButton",
    callback = "OnBtn_ClickSendGift"
  },
  txtBtnPresentGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "Phone_Gift_Send_Btn"
  },
  txtProgress = {
    sNodeName = "txtProgress",
    sComponentName = "TMP_Text"
  },
  t_common_04 = {}
}
PhoneGiftCtrl._mapEventConfig = {
  [EventId.AffinityChange] = "OnEvent_AffinityChange",
  [EventId.IsNewDay] = "OnEvent_NewDay"
}

function PhoneGiftCtrl:Awake()
  self.progressBarWidth = 487.66
  self.progressBarMinWidth = 0
  self.tbGridCtrl = {}
  self.tbChooseItem = {}
  self.nCurChosenIdx = 0
  self.lastChosenItem = 0
  self.nLastChosenItem = 0
  self.nMaxSendGiftCount = tonumber(ConfigTable.GetConfigNumber("AffinityGiftSendCount"))
end

function PhoneGiftCtrl:OnEnable()
  self:InitEmptyJumpTo()
end

function PhoneGiftCtrl:OnDisable()
  if self.tbGridCtrl then
    for k, v in pairs(self.tbGridCtrl) do
      self:UnbindCtrlByNode(v)
    end
  end
  self.tbGridCtrl = {}
end

function PhoneGiftCtrl:InitEmptyJumpTo()
  self.tbJumpTo = ConfigTable.GetConfigArray("PhoneGiftJumpTo", ",")
  if self.tbJumpTo ~= nil then
    for k, v in ipairs(self._mapNode.btnSource) do
      v.gameObject:SetActive(self.tbJumpTo[k] ~= nil)
      if self.tbJumpTo[k] ~= nil then
        local mapCfgJump = ConfigTable.GetData("JumpTo", tonumber(self.tbJumpTo[k]))
        if mapCfgJump ~= nil then
          NovaAPI.SetTMPText(self._mapNode.txtSource[k], mapCfgJump.Desc)
          self:SetPngSprite(self._mapNode.imgSourceIcon[k], mapCfgJump.Icon)
        end
      end
    end
  end
end

function PhoneGiftCtrl:GetGiftFavourLevelById(itemId)
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

function PhoneGiftCtrl:Refresh(nCharId)
  self._mapNode.rectPreProgress.gameObject:SetActive(false)
  self.nCharId = nCharId
  local cfgData = PlayerData.Phone:GetAvgContactsData(self.nCharId)
  if cfgData ~= nil then
    NovaAPI.SetTMPText(self._mapNode.txtCharLandmark, orderedFormat(ConfigTable.GetUIText("Phone_Gift_Send_Char"), cfgData.landmark))
  end
  local affinityData = PlayerData.Char:GetCharAffinityData(self.nCharId)
  self.curFavourLevel = affinityData.Level
  self.curFavourExp = affinityData.Exp
  self.preFavourLevel = self.curFavourLevel
  self.preFavourExp = self.curFavourExp
  NovaAPI.SetTMPText(self._mapNode.txtAffinityLevel, self.curFavourLevel)
  local mapCharAffinity = ConfigTable.GetData("CharAffinityTemplate", self.nCharId)
  if mapCharAffinity == nil then
    return
  end
  local templateId = mapCharAffinity.TemplateId
  self.MaxAffinityLevel = PlayerData.Char:GetMaxAffinityLevel(templateId)
  local percent = 0
  local level = self.curFavourLevel >= self.MaxAffinityLevel and self.MaxAffinityLevel or self.curFavourLevel + 1
  local data = CacheTable.GetData("_AffinityLevel", templateId)[level]
  local curData = CacheTable.GetData("_AffinityLevel", templateId)[self.curFavourLevel]
  if self.curFavourLevel >= self.MaxAffinityLevel then
    percent = 1
  else
    percent = self.curFavourExp / data.NeedExp
  end
  local sizeDelta = self._mapNode.rectProgress.sizeDelta
  sizeDelta.x = self.progressBarWidth * percent < self.progressBarMinWidth and self.progressBarMinWidth or self.progressBarWidth * percent
  self._mapNode.rectProgress.sizeDelta = sizeDelta
  if self.curFavourLevel >= self.MaxAffinityLevel then
    NovaAPI.SetTMPText(self._mapNode.txtProgress, ConfigTable.GetUIText("Phone_Gift_Affinity_Max_Level"))
  else
    NovaAPI.SetTMPText(self._mapNode.txtProgress, string.format("%d/%d", self.curFavourExp, data.NeedExp))
  end
  self._mapNode.rectProgress.gameObject:SetActive(self.curFavourExp > 0 or self.curFavourLevel >= self.MaxAffinityLevel)
  self:SetPngSprite(self._mapNode.imgAffinity, curData.AffinityLevelIcon .. "_s")
  local curCount = PlayerData.Base:GetSendGiftCount()
  NovaAPI.SetTMPText(self._mapNode.txtGiftCount, orderedFormat(ConfigTable.GetUIText("Phone_Gift_Send_Day_Count_1"), curCount, self.nMaxSendGiftCount))
  local mapCharDesc = ConfigTable.GetData("CharacterDes", self.nCharId)
  if mapCharDesc ~= nil then
    self.PreferenceData = {
      PreferTags = mapCharDesc.PreferTags,
      HateTags = mapCharDesc.HateTags
    }
  end
  self:RefreshItemList()
end

function PhoneGiftCtrl:RefreshItemList()
  self.tbItemData = {}
  self.tbChooseItem = {}
  local listCount = 0
  local tbAllItem = {}
  
  local function foreachAffinityGift(mapData)
    local count = PlayerData.Item:GetItemCountByID(mapData.Id)
    local itemData = ConfigTable.GetData_Item(mapData.Id)
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
    self._mapNode.loopsvGiftList:Init(listCount, self, self.RefreshItemGrid, self.OnBtn_ClickItemGrid)
  end
  self._mapNode.btnPresentGray.gameObject:SetActive(#self.tbItemData == 0)
  self._mapNode.btnPresent.gameObject:SetActive(#self.tbItemData > 0)
end

function PhoneGiftCtrl:RefreshItemGrid(grid)
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
  for nIdx, v in pairs(self.tbChooseItem) do
    if v ~= nil and v.nTid == mapItem.nTid and nIdx == nIndex then
      self.tbGridCtrl[nInstanceID]:SetMultiSelected_Blue(true)
    end
  end
end

function PhoneGiftCtrl:GetGiftFavourLevel(tags)
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

function PhoneGiftCtrl:OnItemChosen()
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
    nSelectCount = nSelectCount + 1
  end
  NovaAPI.SetTMPText(self._mapNode.txtGiftCount, orderedFormat(ConfigTable.GetUIText("Phone_Gift_Send_Day_Count_1"), nSelectCount + PlayerData.Base:GetSendGiftCount(), self.nMaxSendGiftCount))
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
  local sizeDelta = self._mapNode.rectPreProgress.sizeDelta
  local percent = 0
  if addedLevel > self.curFavourLevel then
    self._mapNode.rectProgress.gameObject:SetActive(false)
    percent = preFinalExp / CacheTable.GetData("_AffinityLevel", templateId)[addedLevel + 1 > self.MaxAffinityLevel and self.MaxAffinityLevel or addedLevel + 1].NeedExp
  else
    self._mapNode.rectProgress.gameObject:SetActive(true)
    percent = (self.curFavourExp + addedExp) / CacheTable.GetData("_AffinityLevel", templateId)[addedLevel + 1 > self.MaxAffinityLevel and self.MaxAffinityLevel or addedLevel + 1].NeedExp
  end
  if 1 <= percent then
    percent = 1
  end
  sizeDelta.x = self.progressBarWidth * percent
  self._mapNode.rectPreProgress.sizeDelta = sizeDelta
  local nShowFinalExp = self.curFavourExp + addedExp
  if addedLevel >= self.MaxAffinityLevel then
    NovaAPI.SetTMPText(self._mapNode.txtProgress, ConfigTable.GetUIText("Phone_Gift_Affinity_Max_Level"))
  else
    NovaAPI.SetTMPText(self._mapNode.txtProgress, string.format("%d/%d", nShowFinalExp, CacheTable.GetData("_AffinityLevel", templateId)[addedLevel + 1 > self.MaxAffinityLevel and self.MaxAffinityLevel or addedLevel + 1].NeedExp))
  end
  NovaAPI.SetTMPText(self._mapNode.txtAffinityLevel, addedLevel)
  self._mapNode.rectPreProgress.gameObject:SetActive(0 < addedExp)
  local mapLevelBefore = {
    nLevel = self.preFavourLevel,
    nMaxLevel = self.MaxAffinityLevel,
    nExp = self.preFavourExp,
    nMaxExp = CacheTable.GetData("_AffinityLevel", templateId)[self.curFavourLevel + 1 > self.MaxAffinityLevel and self.MaxAffinityLevel or self.curFavourLevel + 1].NeedExp
  }
  self.preFavourLevel = addedLevel
  self.preFavourExp = preFinalExp
  local mapLevelAfter = {
    nLevel = addedLevel,
    nMaxLevel = self.MaxAffinityLevel,
    nExp = preFinalExp,
    nMaxExp = CacheTable.GetData("_AffinityLevel", templateId)[addedLevel + 1 > self.MaxAffinityLevel and self.MaxAffinityLevel or addedLevel + 1].NeedExp
  }
  self:PlayPreProgressAnim(mapLevelBefore, mapLevelAfter)
end

function PhoneGiftCtrl:PlayPreProgressAnim(mapBefore, mapAfter)
  local bMaxLv = mapAfter.nLevel == mapAfter.nMaxLevel
  local nAddLevel = mapAfter.nLevel - mapBefore.nLevel
  local nAddCount = 0
  if nAddLevel == 0 then
    nAddCount = 1
  elseif 0 < mapAfter.nExp and not bMaxLv then
    nAddCount = nAddLevel + 1
  else
    nAddCount = nAddLevel
  end
  local nAniTime = 0.2
  if nAddCount < 6 then
    nAniTime = 0.2
  elseif 6 <= nAddCount then
    nAniTime = 0.1
  end
  local nBeforeToMaxTime = nAniTime * (1 - mapBefore.nExp / mapBefore.nMaxExp)
  local nBeforeToAfterTime = nAniTime * ((mapAfter.nExp - mapBefore.nExp) / mapAfter.nMaxExp)
  local nZeroToAfterTime = nAniTime * mapAfter.nExp / mapAfter.nMaxExp
  local nAllTime = 0
  local height = self._mapNode.rectPreProgress.sizeDelta.y
  local sequence = DOTween.Sequence()
  for i = 1, nAddCount - 1 do
    local nTime = i == 1 and nBeforeToMaxTime or nAniTime
    nAllTime = nAllTime + nTime
    sequence:Append(self._mapNode.rectPreProgress:DOSizeDelta(Vector2(self.progressBarWidth, height), nTime))
    sequence:AppendCallback(function()
      self._mapNode.rectPreProgress.sizeDelta = Vector2(0, height)
    end)
  end
  if bMaxLv then
    local nTime = 1 < nAddCount and nAniTime or nBeforeToMaxTime
    nAllTime = nAllTime + nTime
    sequence:Append(self._mapNode.rectPreProgress:DOSizeDelta(Vector2(self.progressBarWidth, height), nTime))
  elseif mapAfter.nExp > 0 then
    local nTime = 1 < nAddCount and nZeroToAfterTime or nBeforeToAfterTime
    nAllTime = nAllTime + nTime
    local width = self.progressBarWidth * mapAfter.nExp / mapAfter.nMaxExp
    sequence:Append(self._mapNode.rectPreProgress:DOSizeDelta(Vector2(width, height), nTime))
  elseif mapAfter.nExp == 0 then
    local nTime = 1 < nAddCount and nAniTime or nBeforeToMaxTime
    nAllTime = nAllTime + nTime
    sequence:Append(self._mapNode.rectPreProgress:DOSizeDelta(Vector2(self.progressBarWidth, height), nTime))
    sequence:AppendCallback(function()
      self._mapNode.rectPreProgress.sizeDelta = Vector2(0, height)
    end)
  end
  sequence:SetUpdate(true)
  nAllTime = nAllTime + 0.2
  EventManager.Hit(EventId.TemporaryBlockInput, nAllTime)
end

function PhoneGiftCtrl:PlayProgressAnim(mapBefore, mapAfter, callback)
  local bMaxLv = mapAfter.nLevel == mapAfter.nMaxLevel
  local nAddLevel = mapAfter.nLevel - mapBefore.nLevel
  local nAddCount = 0
  if nAddLevel == 0 then
    nAddCount = 1
  elseif 0 < mapAfter.nExp then
    nAddCount = nAddLevel + 1
  else
    nAddCount = nAddLevel
  end
  local nAniTime = 0.2
  if nAddCount < 6 then
    nAniTime = 0.2
  elseif 6 <= nAddCount then
    nAniTime = 0.1
  end
  local nBeforeToMaxTime = nAniTime * (1 - mapBefore.nExp / mapBefore.nMaxExp)
  local nBeforeToAfterTime = nAniTime * ((mapAfter.nExp - mapBefore.nExp) / mapAfter.nMaxExp)
  local nZeroToAfterTime = nAniTime * mapAfter.nExp / mapAfter.nMaxExp
  local nAllTime = 0
  local heigth = self._mapNode.rectPreProgress.sizeDelta.y
  local sequence = DOTween.Sequence()
  for i = 1, nAddCount - 1 do
    local nTime = i == 1 and nBeforeToMaxTime or nAniTime
    nAllTime = nAllTime + nTime
    sequence:AppendCallback(function()
      WwiseAudioMgr:PlaySound("ui_common_levelUp")
    end)
    sequence:Append(self._mapNode.rectProgress:DOSizeDelta(Vector2(self.progressBarWidth, heigth), nTime))
    sequence:AppendCallback(function()
      self._mapNode.rectProgress.sizeDelta = Vector2(0, heigth)
    end)
  end
  if bMaxLv then
    local nTime = 1 < nAddCount and nAniTime or nBeforeToMaxTime
    nAllTime = nAllTime + nTime
    sequence:AppendCallback(function()
      WwiseAudioMgr:PlaySound("ui_common_levelUp")
    end)
    sequence:Append(self._mapNode.rectProgress:DOSizeDelta(Vector2(self.progressBarWidth, heigth), nTime))
  elseif mapAfter.nExp > 0 then
    local nTime = 1 < nAddCount and nZeroToAfterTime or nBeforeToAfterTime
    nAllTime = nAllTime + nTime
    sequence:AppendCallback(function()
      WwiseAudioMgr:PlaySound("ui_common_levelUp")
    end)
    local width = self.progressBarWidth * mapAfter.nExp / mapAfter.nMaxExp
    sequence:Append(self._mapNode.rectProgress:DOSizeDelta(Vector2(width, heigth), nTime))
  elseif mapAfter.nExp == 0 then
    local nTime = 1 < nAddCount and nAniTime or nBeforeToMaxTime
    nAllTime = nAllTime + nTime
    sequence:AppendCallback(function()
      WwiseAudioMgr:PlaySound("ui_common_levelUp")
    end)
    sequence:Append(self._mapNode.rectProgress:DOSizeDelta(Vector2(self.progressBarWidth, heigth), nTime))
    sequence:AppendCallback(function()
      self._mapNode.rectProgress.sizeDelta = Vector2(0, heigth)
    end)
  end
  sequence:SetUpdate(true)
  nAllTime = nAllTime + 0.2
  EventManager.Hit(EventId.TemporaryBlockInput, nAllTime)
  self:AddTimer(1, nAllTime, callback, true, true, true)
end

function PhoneGiftCtrl:OnBtn_ClickSendGift()
  if #self.tbItemData == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Gift_Send_Item_Empty"))
    return
  end
  if self.tbChooseItem == nil or next(self.tbChooseItem) == nil then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Gift_Send_Not_Select"))
    return
  end
  local sendCount = PlayerData.Base:GetSendGiftCount()
  if sendCount >= tonumber(self.nMaxSendGiftCount) then
    local tips = ConfigTable.GetUIText("Gift_Send_Day_Count_Max")
    EventManager.Hit(EventId.OpenMessageBox, tips)
    return
  end
  
  local function sendGift()
    local tbItems = {}
    local tbSendItems = {}
    for nIndex, v in pairs(self.tbChooseItem) do
      if nil == tbItems[v.nTid] then
        tbItems[v.nTid] = 1
      else
        tbItems[v.nTid] = tbItems[v.nTid] + 1
      end
    end
    for nId, nCount in pairs(tbItems) do
      table.insert(tbSendItems, {Tid = nId, Qty = nCount})
    end
    local mapMsg = {
      CharId = self.nCharId,
      Items = tbSendItems
    }
    
    local function successCallback(_, mapMainData)
      if mapMainData ~= nil then
        NovaAPI.SetTMPText(self._mapNode.txtGiftCount, orderedFormat(ConfigTable.GetUIText("Phone_Gift_Send_Day_Count_1"), mapMainData.SendGiftCnt, self.nMaxSendGiftCount))
      end
      if self.curFavourLevel == self.MaxAffinityLevel then
        EventManager.Hit("RefreshCharList", true)
        local mapCharAffinity = ConfigTable.GetData("CharAffinityTemplate", self.nCharId)
        if mapCharAffinity == nil then
          return
        end
        local templateId = mapCharAffinity.TemplateId
        local nMaxExp = CacheTable.GetData("_AffinityLevel", templateId)[self.MaxAffinityLevel].NeedExp
        EventManager.Hit(EventId.OpenPanel, PanelId.CharFavourLevelUp, self.nCharId, self.curFavourLevel, self.curFavourLevel, nMaxExp, nMaxExp)
      end
    end
    
    HttpNetHandler.SendMsg(NetMsgId.Id.char_affinity_gift_send_req, mapMsg, nil, successCallback)
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

function PhoneGiftCtrl:OnBtn_ClickItemGrid(grid)
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
    self:OnItemChosen()
  else
    local nCount = 0
    if self.tbChooseItem ~= nil then
      for nIndex, v in pairs(self.tbChooseItem) do
        if v ~= nil then
          nCount = nCount + 1
        end
      end
    end
    local nSendCount = PlayerData.Base:GetSendGiftCount()
    if nCount + nSendCount >= self.nMaxSendGiftCount then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Gift_Send_Day_Count_Max"))
      return
    end
    self.tbChooseItem[nIndex] = {
      nTid = mapItem.nTid,
      itemCtrl = itemCtrl
    }
    itemCtrl:SetMultiSelected_Blue(true)
    self:OnItemChosen()
  end
end

function PhoneGiftCtrl:OnBtnClick_Source(btn, nIdx)
  if self.tbJumpTo[nIdx] ~= nil then
    JumpUtil.JumpTo(tonumber(self.tbJumpTo[nIdx]))
  end
end

function PhoneGiftCtrl:OnEvent_AffinityChange(charId, curLevel, lastFavourLevel)
  if self.nCharId == nil or self._panel.nCurTog ~= AllEnum.PhoneTogType.Gift then
    return
  end
  local lastExp = self.curFavourExp
  local affinityData = PlayerData.Char:GetCharAffinityData(self.nCharId)
  self.curFavourExp = affinityData.Exp
  self.curFavourLevel = affinityData.Level
  EventManager.Hit("RefreshCharList", false)
  EventManager.Hit(EventId.OpenPanel, PanelId.CharFavourLevelUp, charId, curLevel, lastFavourLevel, self.curFavourExp, lastExp)
end

function PhoneGiftCtrl:OnEvent_NewDay()
  local curCount = 0
  NovaAPI.SetTMPText(self._mapNode.txtGiftCount, orderedFormat(ConfigTable.GetUIText("Phone_Gift_Send_Day_Count_1"), curCount, self.nMaxSendGiftCount))
end

return PhoneGiftCtrl
