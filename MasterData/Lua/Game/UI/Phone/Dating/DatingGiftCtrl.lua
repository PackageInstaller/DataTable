local DatingGiftCtrl = class("DatingGiftCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
DatingGiftCtrl._mapNodeConfig = {
  txtTips = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dating_Finish_Send_Gift_Tip"
  },
  loopsvGiftList = {
    sNodeName = "svGiftList",
    sComponentName = "LoopScrollView"
  },
  goEmpty = {sNodeName = "Empty", sComponentName = "GameObject"},
  txtEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Phone_Gift_Send_List_Empty"
  },
  imgAffinity = {sComponentName = "Image"},
  txtAffinityLevelCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dating_Send_Gift_Tacit"
  },
  txtLevelCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dating_Affinity_Level"
  },
  txtAffinityLevel = {sComponentName = "TMP_Text"},
  txtGiftCount = {sComponentName = "TMP_Text"},
  rectPreProgress = {
    sNodeName = "imgPreProgress",
    sComponentName = "RectTransform"
  },
  rectProgress = {
    sNodeName = "imgProgress",
    sComponentName = "RectTransform"
  },
  txtProgress = {
    sNodeName = "txtProgress",
    sComponentName = "TMP_Text"
  },
  t_common_04 = {},
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dating_Send_Gift_Title"
  },
  btnPresent = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Present"
  },
  txtBtnPresent = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dating_Gift_Send_Btn"
  },
  btnEnd = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_End"
  },
  txtBtnEnd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dating_Gift_Abandon_Btn"
  },
  btnPresentGray = {sComponentName = "UIButton"},
  txtBtnPresentGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dating_Gift_Send_Btn"
  },
  btnEndGray = {sComponentName = "UIButton"},
  txtBtnEndGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dating_Gift_Abandon_Btn"
  }
}
DatingGiftCtrl._mapEventConfig = {
  [EventId.AffinityChange] = "OnEvent_AffinityChange"
}

function DatingGiftCtrl:GetGiftFavourLevel(itemList)
  if self.PreferenceData == nil then
    return 2
  end
  local nLevel = 0
  for _, v in ipairs(itemList) do
    local itemData = ConfigTable.GetData("AffinityGift", v.Tid)
    for k, v in ipairs(itemData.Tags) do
      for k1, v1 in ipairs(self.PreferenceData.PreferTags) do
        if v == v1 and nLevel < 1 then
          nLevel = 1
          break
        end
      end
    end
    for k, v in ipairs(itemData.Tags) do
      for k1, v1 in ipairs(self.PreferenceData.HateTags) do
        if v == v1 and nLevel < 3 then
          nLevel = 3
          break
        end
      end
    end
  end
  if nLevel == 0 then
    nLevel = 2
  end
  return nLevel
end

function DatingGiftCtrl:GetGiftFeedbackLevel(tbItems)
  local nLevel = self:GetGiftFavourLevel(tbItems)
  for _, v in ipairs(tbItems) do
    local itemData = ConfigTable.GetData_Item(v.Tid)
    if itemData.Rarity <= GameEnum.itemRarity.SR and nLevel == 1 then
      nLevel = 1
    elseif itemData.Rarity == GameEnum.itemRarity.R and nLevel == 1 or itemData.Rarity <= GameEnum.itemRarity.SR and nLevel == 2 then
      nLevel = 2
    elseif itemData.Rarity == GameEnum.itemRarity.R and nLevel == 2 or nLevel == 3 then
      nLevel = 3
    end
  end
  return nLevel
end

function DatingGiftCtrl:RefreshAffinityLevel()
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
  self._mapNode.rectProgress.gameObject:SetActive(0 < self.curFavourExp or self.curFavourLevel >= self.MaxAffinityLevel)
  NovaAPI.SetTMPText(self._mapNode.txtAffinityLevel, self.curFavourLevel)
  self:SetPngSprite(self._mapNode.imgAffinity, curData.AffinityLevelIcon .. "_s")
end

function DatingGiftCtrl:RefreshSendGift()
  self.nCharId = self._panel.nCharId
  local mapCharDesc = ConfigTable.GetData("CharacterDes", self.nCharId)
  if mapCharDesc ~= nil then
    self.PreferenceData = {
      PreferTags = mapCharDesc.PreferTags,
      HateTags = mapCharDesc.HateTags
    }
  end
  self.tbChooseItem = {}
  self._mapNode.rectPreProgress.gameObject:SetActive(false)
  local affinityData = PlayerData.Char:GetCharAffinityData(self.nCharId)
  self.curFavourLevel = affinityData.Level
  self.curFavourExp = affinityData.Exp
  self.preFavourLevel = self.curFavourLevel
  self.preFavourExp = self.curFavourExp
  self:RefreshAffinityLevel()
  NovaAPI.SetTMPText(self._mapNode.txtGiftCount, orderedFormat(ConfigTable.GetUIText("Phone_Gift_Send_Day_Count_2"), 0, self.nMaxSendGiftCount))
  self:RefreshItemList()
end

function DatingGiftCtrl:RefreshItemList()
  self.tbItemData = {}
  local tbAllItem = {}
  local listCount = 0
  
  local function foreachAffinityGift(mapData)
    local nCount = PlayerData.Item:GetItemCountByID(mapData.Id)
    if 0 < nCount then
      local itemData = ConfigTable.GetData_Item(mapData.Id)
      if itemData ~= nil then
        table.insert(tbAllItem, {
          nTid = itemData.Id,
          nRarity = itemData.Rarity,
          nCount = nCount,
          nExpire = itemData.ExpireType,
          favourLevel = self:GetGiftFavourLevelById(itemData.Id)
        })
        listCount = listCount + nCount
      end
    end
  end
  
  ForEachTableLine(DataTable.AffinityGift, foreachAffinityGift)
  self._mapNode.goEmpty:SetActive(listCount == 0)
  self._mapNode.loopsvGiftList.gameObject:SetActive(0 < listCount)
  if 0 < listCount then
    for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
      self:UnbindCtrlByNode(objCtrl)
      self.tbGridCtrl[nInstanceId] = nil
    end
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
end

function DatingGiftCtrl:RefreshItemGrid(grid)
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

function DatingGiftCtrl:GetGiftFavourLevelById(itemId)
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

function DatingGiftCtrl:GetCharAffinityAnim(nLevel, nNewLevel)
  local sVoKey = ""
  if nLevel == 1 then
    sVoKey = self.nFirstStageVoKey
  elseif nLevel == 2 then
    sVoKey = self.nSecondStageVoKey
  elseif nLevel == 3 then
    sVoKey = self.nThirdStageVoKey
  end
  if sVoKey ~= "" then
    return sVoKey
  end
end

function DatingGiftCtrl:PlayPreProgressAnim(mapBefore, mapAfter)
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

function DatingGiftCtrl:PlayProgressAnim(mapBefore, mapAfter)
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
end

function DatingGiftCtrl:Awake()
  self._mapNode.btnPresentGray.gameObject:SetActive(false)
  self._mapNode.btnEndGray.gameObject:SetActive(false)
  self.tbGridCtrl = {}
  self.nMaxSendGiftCount = ConfigTable.GetConfigNumber("Dating_Max_Send_Gift_Count")
  self.nPresentAddition = ConfigTable.GetConfigNumber("Dating_Gift_Favorability_Addition")
  self.progressBarWidth = 400
  self.progressBarMinWidth = 23
  self.nFirstStageVoKey = ConfigTable.GetConfigValue("CharGiftFirstStageVoKey")
  self.nSecondStageVoKey = ConfigTable.GetConfigValue("CharGiftSecondStageVoKey")
  self.nThirdStageVoKey = ConfigTable.GetConfigValue("CharGiftThirdStageVoKey")
end

function DatingGiftCtrl:OnEnable()
end

function DatingGiftCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function DatingGiftCtrl:OnDestroy()
end

function DatingGiftCtrl:OnBtnClick_End()
  EventManager.Hit("CloseDatingPanel")
end

function DatingGiftCtrl:OnBtnClick_Present()
  if #self.tbItemData == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Gift_Send_Item_Empty"))
    return
  end
  if self.tbChooseItem == nil or next(self.tbChooseItem) == nil then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Gift_Send_Not_Select"))
    return
  end
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
  
  local function callback(msgData)
    local level = self:GetGiftFeedbackLevel(tbSendItems)
    local nNewLevel = level
    if msgData.Info ~= nil then
      nNewLevel = msgData.Info.AffinityLevel
    end
    local sVoiceKey = self:GetCharAffinityAnim(level, nNewLevel)
    if sVoiceKey ~= nil then
      EventManager.Hit("DatingSendGiftFinish", sVoiceKey, msgData, self.curFavourLevel)
    end
    self._mapNode.btnPresentGray.gameObject:SetActive(true)
    self._mapNode.btnEndGray.gameObject:SetActive(true)
    self._mapNode.btnPresent.gameObject:SetActive(false)
    self._mapNode.btnEnd.gameObject:SetActive(false)
    self:RefreshSendGift()
  end
  
  if 0 < #tbSendItems then
    PlayerData.Dating:SendDatingSendGiftMsg(self.nCharId, tbSendItems, callback)
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Gift_Send_Not_Select"))
  end
end

function DatingGiftCtrl:OnBtn_ClickItemGrid(grid)
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
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Gift_Send_Max_Count"))
      return
    end
    self.tbChooseItem[nIndex] = {
      nTid = mapItem.nTid,
      itemCtrl = itemCtrl
    }
    itemCtrl:SetMultiSelected_Blue(true)
  end
  self:OnItemChosen()
end

function DatingGiftCtrl:OnItemChosen()
  local mapCharAffinity = ConfigTable.GetData("CharAffinityTemplate", self.nCharId)
  if mapCharAffinity == nil then
    return
  end
  local nSelectCount = 0
  local addedExp = 0
  for nIndex, v in pairs(self.tbChooseItem) do
    local data = ConfigTable.GetData("AffinityGift", v.nTid)
    local level = self:GetGiftFavourLevelById(v.nTid)
    local AffinityGiftPreferenceProp = ConfigTable.GetConfigNumberArray("AffinityGiftPreferenceProp")
    local nExp = data.BaseAffinity * (AffinityGiftPreferenceProp[level] / 100 + 1)
    addedExp = addedExp + nExp * self.nPresentAddition
    nSelectCount = nSelectCount + 1
  end
  NovaAPI.SetTMPText(self._mapNode.txtGiftCount, orderedFormat(ConfigTable.GetUIText("Phone_Gift_Send_Day_Count_1"), nSelectCount, self.nMaxSendGiftCount))
  if self.curFavourLevel >= self.MaxAffinityLevel then
    return
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

function DatingGiftCtrl:OnEvent_AffinityChange(charId, curLevel, lastFavourLevel)
  if self.nCharId == nil then
    return
  end
  local affinityData = PlayerData.Char:GetCharAffinityData(self.nCharId)
  self.curFavourLevel = curLevel
  self.curFavourExp = affinityData.Exp
  self._mapNode.rectProgress.gameObject:SetActive(true)
  self._mapNode.rectPreProgress.gameObject:SetActive(false)
  self:RefreshAffinityLevel()
end

return DatingGiftCtrl
