local CharAdvanceCtrl = class("CharAdvanceCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
CharAdvanceCtrl._mapNodeConfig = {
  txtTitleRank = {
    sComponentName = "TMP_Text",
    sLanguageId = "Template_CharRank"
  },
  txtLv = {sComponentName = "TMP_Text"},
  txtLvMax = {nCount = 2, sComponentName = "TMP_Text"},
  goAdvanceStar = {
    sCtrlName = "Game.UI.TemplateEx.TemplateStarAdvanceCtrl"
  },
  goProperty = {},
  trProperty = {sComponentName = "Transform"},
  AdvanceBuffList = {
    sNodeName = "AdvanceBuffList",
    sComponentName = "LoopScrollView"
  },
  goMat = {
    nCount = 4,
    sCtrlName = "Game.UI.TemplateEx.TemplateMatCtrl"
  },
  btnAdd = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tips"
  },
  btnAdvance = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Advance"
  },
  txtBtnAdvance = {
    sComponentName = "TMP_Text",
    sLanguageId = "Btn_AdvanceUp"
  },
  txtAdvanceTips = {sComponentName = "TMP_Text"},
  imgCostIcon = {sComponentName = "Image"},
  txtCostCount = {sComponentName = "TMP_Text"},
  btnAutoFill = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AutoFill"
  },
  txtBtnAutoFill = {
    sComponentName = "TMP_Text",
    sLanguageId = "AutoDevelopment_Btn_Fill"
  },
  txtBuffHeight = {sComponentName = "TMP_Text"},
  rtTxtBuffHeight = {
    sNodeName = "txtBuffHeight",
    sComponentName = "RectTransform"
  },
  txtBuffHeightAfter = {sComponentName = "TMP_Text"},
  rtTxtBuffHeightAfter = {
    sNodeName = "txtBuffHeightAfter",
    sComponentName = "RectTransform"
  }
}
CharAdvanceCtrl._mapEventConfig = {}

function CharAdvanceCtrl:_CalcGridHeight(sContent)
  NovaAPI.SetTMPText(self._mapNode.txtBuffHeight, sContent)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtTxtBuffHeight)
  local nH = self._mapNode.rtTxtBuffHeight.rect.height
  return nH
end

function CharAdvanceCtrl:_CalcGridHeightAfter(sContent)
  NovaAPI.SetTMPText(self._mapNode.txtBuffHeightAfter, sContent)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtTxtBuffHeightAfter)
  local nH = self._mapNode.rtTxtBuffHeightAfter.rect.height + 14
  return nH
end

function CharAdvanceCtrl:InitData(nCharId, mapCurLevel, nMaxAdvance)
  self.nCharId = nCharId
  self.mapLevel = mapCurLevel
  self.nMaxAdvance = nMaxAdvance
  self.mapChar = PlayerData.Char:GetCharDataByTid(self.nCharId)
  self.mapAttrBefore = nil
  self.mapAttrAfter = nil
  self.tbMat = {}
  self.nAdvanceGold = 0
  local nAdvanceId = 100 * self.nCharId + self.mapChar.nAdvance + 1
  local mapCfgData = ConfigTable.GetData("CharacterAdvance", nAdvanceId)
  self.AdvanceUpData = mapCfgData
  if type(mapCfgData) == "table" then
    for i = 1, 4 do
      local item = {}
      local nItemId = mapCfgData["Tid" .. i]
      local nItemNum = mapCfgData["Qty" .. i]
      if type(nItemId) == "number" and type(nItemNum) == "number" and 0 < nItemId and 0 < nItemNum then
        item.nItemId = nItemId
        item.nItemNum = nItemNum
        table.insert(self.tbMat, item)
      end
    end
    self.nAdvanceGold = mapCfgData.GoldQty
  end
  local nAdvance = self.mapChar.nAdvance
  if self.nMaxAdvance ~= nAdvance then
    local nGrade = ConfigTable.GetData_Character(nCharId).Grade
    local mapData = CacheTable.GetData("_CharRaritySequence", nGrade)
    if mapData ~= nil and mapData[nAdvance] ~= nil then
      local tbNeedMat = {}
      for _, v in ipairs(self.tbMat) do
        table.insert(tbNeedMat, {
          nId = v.nItemId,
          nCount = v.nItemNum
        })
      end
      self.tbFillStep, self.tbUseItem, self.tbShowNeedItem = PlayerData.Item:AutoFillMat(tbNeedMat)
      local nHasCoin = PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.Gold)
      local bAbleAutoFill = next(self.tbUseItem) ~= nil and nHasCoin >= self.nAdvanceGold
      self.nNeedWorldClass = mapData[nAdvance + 1].WorldClassLimit
      local nCurWorldClass = PlayerData.Base:GetWorldClass()
      self._mapNode.btnAdvance.gameObject:SetActive(nCurWorldClass >= self.nNeedWorldClass and not bAbleAutoFill)
      self._mapNode.btnAutoFill.gameObject:SetActive(nCurWorldClass >= self.nNeedWorldClass and bAbleAutoFill)
      self._mapNode.txtAdvanceTips.gameObject:SetActive(nCurWorldClass < self.nNeedWorldClass)
      if nCurWorldClass < self.nNeedWorldClass then
        NovaAPI.SetTMPText(self._mapNode.txtAdvanceTips, orderedFormat(ConfigTable.GetUIText("Char_Advance_WorldClass_Limit"), self.nNeedWorldClass))
      end
    else
      self._mapNode.btnAdvance.gameObject:SetActive(false)
      self._mapNode.btnAutoFill.gameObject:SetActive(false)
      self._mapNode.txtAdvanceTips.gameObject:SetActive(false)
    end
  end
end

function CharAdvanceCtrl:Refresh(nCharId, mapCurLevel, nMaxAdvance)
  self:InitData(nCharId, mapCurLevel, nMaxAdvance)
  self:RefreshLv()
  self:RefreshAttr()
  self:RefreshBuffInfo()
  self:RefreshCoin()
  self:RefreshMat()
end

function CharAdvanceCtrl:RefreshLv()
  NovaAPI.SetTMPText(self._mapNode.txtLv, self.mapLevel.nLevel)
  NovaAPI.SetTMPText(self._mapNode.txtLvMax[1], "/" .. self.mapLevel.nMaxLevel)
  NovaAPI.SetTMPText(self._mapNode.txtLvMax[2], orderedFormat(ConfigTable.GetUIText("CharDev_UnlockLVDesc"), self.mapLevel.nNextMaxLv))
  self._mapNode.goAdvanceStar:SetStar(self.mapChar.nAdvance, self.nMaxAdvance, self.mapChar.nAdvance + 1)
end

function CharAdvanceCtrl:RefreshAttr()
  self.mapAttrBefore = PlayerData.Char:GetCharCfgAttr({1, 2}, self.nCharId, self.mapChar.nAdvance, self.mapChar.nLevel)
  self.mapAttrAfter = PlayerData.Char:GetCharCfgAttr({1, 2}, self.nCharId, self.mapChar.nAdvance + 1, self.mapChar.nLevel)
  delChildren(self._mapNode.trProperty)
  for _, mapAttachAttr in ipairs(AllEnum.AttachAttr) do
    local mapAttr = self.mapAttrBefore[mapAttachAttr.sKey]
    if mapAttr and mapAttr.Value > 0 then
      local goItemObj = instantiate(self._mapNode.goProperty, self._mapNode.trProperty)
      goItemObj:SetActive(true)
      local ctrlItem = self:BindCtrlByNode(goItemObj, "Game.UI.TemplateEx.TemplatePropertyCtrl")
      local bValueChanged = self.mapAttrAfter[mapAttachAttr.sKey].Value ~= mapAttr.Value
      if bValueChanged then
        ctrlItem:SetItemProperty(mapAttr.Key, mapAttr.Value, self.mapAttrAfter[mapAttachAttr.sKey].Value)
      else
        ctrlItem:SetItemProperty(mapAttr.Key, mapAttr.Value)
      end
    end
  end
end

function CharAdvanceCtrl:RefreshBuffInfo()
  local buffCount = 0
  self.tbGridHeight = {}
  local mapAllPreview = PlayerData.Char:GetCharAdvancePreview(self.nCharId, self.mapChar.nAdvance + 1)
  local mapPreview = {}
  for _, v in ipairs(mapAllPreview) do
    if v.nType ~= AllEnum.CharAdvancePreview.LevelMax then
      table.insert(mapPreview, v)
    end
  end
  self.mapPreviewDesc = {}
  for _, v in ipairs(mapPreview) do
    local AdvanceDescFront, AdvanceDescAfter = "", ""
    if v.nType == AllEnum.CharAdvancePreview.SkillLevelMax then
      AdvanceDescFront = ConfigTable.GetUIText("CharAdvance_Preview_Skill_LevelMax")
      AdvanceDescAfter = orderedFormat(ConfigTable.GetUIText("CharAdvance_Preview_Level"), v.nMaxSkillLevel)
    elseif v.nType == AllEnum.CharAdvancePreview.SkinUnlock then
      AdvanceDescFront = ConfigTable.GetUIText("CharAdvance_Preview_SkinUnlock_1")
      AdvanceDescAfter = ConfigTable.GetUIText("CharAdvance_Preview_SkinUnlock_2")
    end
    if AdvanceDescFront ~= "" or AdvanceDescAfter ~= "" then
      buffCount = buffCount + 1
      local nMaxHeight = math.max(self:_CalcGridHeight(AdvanceDescFront), self:_CalcGridHeightAfter(AdvanceDescAfter))
      table.insert(self.tbGridHeight, nMaxHeight)
      table.insert(self.mapPreviewDesc, {sFront = AdvanceDescFront, sAfter = AdvanceDescAfter})
    end
  end
  if 0 < buffCount then
    self._mapNode.AdvanceBuffList:InitEx(self.tbGridHeight, self, self.OnGridRefresh)
  end
  self._mapNode.AdvanceBuffList.gameObject:SetActive(0 < buffCount)
end

function CharAdvanceCtrl:OnGridRefresh(goGrid, gridIndex)
  local index = gridIndex + 1
  if self.mapPreviewDesc[index] ~= nil then
    local txtBuff = goGrid.transform:Find("txtBuff")
    if txtBuff ~= nil then
      NovaAPI.SetTMPText(txtBuff:GetComponent("TMP_Text"), self.mapPreviewDesc[index].sFront)
    end
    local txtBuffContent = goGrid.transform:Find("txtBuffContent")
    if txtBuffContent ~= nil then
      NovaAPI.SetTMPText(txtBuffContent:GetComponent("TMP_Text"), self.mapPreviewDesc[index].sAfter)
    end
  end
  local imageBar = goGrid.transform:Find("Image")
  imageBar.gameObject:SetActive(1 < index)
  local bOpen = false
  local goLock = goGrid.transform:Find("goIconlock")
  if goLock ~= nil then
    goLock.gameObject:SetActive(not bOpen)
  end
  local goUnlock = goGrid.transform:Find("goIconOpen")
  if goUnlock ~= nil then
    goUnlock.gameObject:SetActive(bOpen)
  end
end

function CharAdvanceCtrl:RefreshCoin()
  self:SetSprite_Coin(self._mapNode.imgCostIcon, AllEnum.CoinItemId.Gold)
  local nHasCoin = PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.Gold)
  NovaAPI.SetTMPText(self._mapNode.txtCostCount, math.ceil(self.nAdvanceGold))
  NovaAPI.SetTMPColor(self._mapNode.txtCostCount, nHasCoin >= self.nAdvanceGold and Blue_Normal or Red_Unable)
end

function CharAdvanceCtrl:RefreshMat()
  local nMatCount = #self.tbMat
  for i = 1, 4 do
    self._mapNode.btnAdd[i].interactable = i <= nMatCount
    if i <= nMatCount then
      self._mapNode.goMat[i]:SetMat(self.tbMat[i].nItemId, self.tbMat[i].nItemNum)
    else
      self._mapNode.goMat[i]:SetMat(0)
    end
  end
end

function CharAdvanceCtrl:Awake()
end

function CharAdvanceCtrl:OnEnable()
end

function CharAdvanceCtrl:OnDisable()
end

function CharAdvanceCtrl:OnDestroy()
end

function CharAdvanceCtrl:OnBtnClick_Advance(btn)
  for _, mapMat in pairs(self.tbMat) do
    local nHas = PlayerData.Item:GetItemCountByID(mapMat.nItemId)
    if nHas < mapMat.nItemNum then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("CHARUP_03"))
      return
    end
  end
  if self.nAdvanceGold > PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.Gold) then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("CHARUP_04"))
    return
  end
  
  local function callback()
    local mapData = {
      nLevel = self.mapLevel.nLevel,
      nLevelMax = self.mapLevel.nNextMaxLv,
      mapAttrBefore = self.mapAttrBefore,
      mapAttrAfter = self.mapAttrAfter,
      tbDesc = self.mapPreviewDesc,
      nAdvance = self.mapChar.nAdvance,
      nMaxAdvance = self.nMaxAdvance
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.CharSucBar, mapData, false)
    EventManager.Hit("CharDevelopmentRefresh")
    if not PlayerData.CharSkin:CheckNewSkin() then
      PlayerData.Voice:PlayCharVoice("exCharUp", self.nCharId)
    end
  end
  
  PlayerData.Char:CharAdvance(self.nCharId, callback)
end

function CharAdvanceCtrl:OnBtnClick_AutoFill()
  EventManager.Hit(EventId.OpenPanel, PanelId.FillMaterial, self.tbFillStep, self.tbUseItem, self.tbShowNeedItem)
end

function CharAdvanceCtrl:OnBtnClick_Tips(btn, nIndex)
  if self.tbMat[nIndex] and self.tbMat[nIndex].nItemId > 0 then
    local mapData = {
      nTid = self.tbMat[nIndex].nItemId,
      nNeedCount = self.tbMat[nIndex].nItemNum,
      bShowDepot = true,
      bShowJumpto = true
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
  end
end

return CharAdvanceCtrl
