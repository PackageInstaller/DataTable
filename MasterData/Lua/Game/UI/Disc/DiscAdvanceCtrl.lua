local DiscAdvanceCtrl = class("DiscAdvanceCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
DiscAdvanceCtrl._mapNodeConfig = {
  txtTitleRank = {sComponentName = "TMP_Text", sLanguageId = "Disc_Level"},
  txtLv = {sComponentName = "TMP_Text"},
  txtLvMax = {nCount = 2, sComponentName = "TMP_Text"},
  goAdvanceStar = {
    sCtrlName = "Game.UI.TemplateEx.TemplateStarAdvanceCtrl"
  },
  goPropertyLong = {},
  goPropertyLongNote = {},
  goBuff = {},
  trProperty = {sComponentName = "Transform"},
  txtUnlockDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_UnlockLVDesc"
  },
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
    sLanguageId = "Outfit_Btn_Promote"
  },
  btnAutoFill = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AutoFill"
  },
  txtBtnAutoFill = {
    sComponentName = "TMP_Text",
    sLanguageId = "AutoDevelopment_Btn_Fill"
  },
  imgCostIcon = {sComponentName = "Image"},
  txtCostCount = {sComponentName = "TMP_Text"},
  txtAdvanceTips = {sComponentName = "TMP_Text"},
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
DiscAdvanceCtrl._mapEventConfig = {
  CraftingSuccess = "OnEvent_ItemChanged",
  ConsumableUsed = "OnEvent_ItemChanged",
  AutoFillSuccess = "OnEvent_ItemChanged"
}

function DiscAdvanceCtrl:_CalcGridHeight(sContent)
  NovaAPI.SetTMPText(self._mapNode.txtBuffHeight, sContent)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtTxtBuffHeight)
  local nH = self._mapNode.rtTxtBuffHeight.rect.height
  return nH
end

function DiscAdvanceCtrl:_CalcGridHeightAfter(sContent)
  NovaAPI.SetTMPText(self._mapNode.txtBuffHeightAfter, sContent)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtTxtBuffHeightAfter)
  local nH = self._mapNode.rtTxtBuffHeightAfter.rect.height + 14
  return nH
end

function DiscAdvanceCtrl:InitData()
  self.mapAttrBefore = nil
  self.mapAttrAfter = nil
  self.tbUpgradeNote = nil
  self.tbMat = {}
end

function DiscAdvanceCtrl:Refresh()
  self:InitData()
  local mapDisc = PlayerData.Disc:GetDiscById(self._panel.nId)
  self:RefreshLv(mapDisc)
  self:RefreshAttr(mapDisc)
  self:RefreshCoin(mapDisc)
  self:RefreshMat(mapDisc)
  self:RefreshBuffInfo(mapDisc)
end

function DiscAdvanceCtrl:RefreshLv(mapDisc)
  self.nNextMaxLv = PlayerData.Disc:GetMaxLv(mapDisc.nRarity, mapDisc.nPhase + 1)
  NovaAPI.SetTMPText(self._mapNode.txtLv, mapDisc.nLevel)
  NovaAPI.SetTMPText(self._mapNode.txtLvMax[1], "/" .. mapDisc.nMaxLv)
  NovaAPI.SetTMPText(self._mapNode.txtLvMax[2], self.nNextMaxLv)
  self._mapNode.goAdvanceStar:SetStar(mapDisc.nPhase, mapDisc.nMaxPhase, mapDisc.nPhase + 1)
end

function DiscAdvanceCtrl:RefreshAttr(mapDisc)
  self.mapAttrBefore = mapDisc.mapAttrBase
  self.mapAttrAfter = PlayerData.Disc:GetAttrBase(mapDisc.nAttrBaseGroupId, mapDisc.nPhase + 1, mapDisc.nLevel, mapDisc.nAttrExtraGroupId, mapDisc.nStar)
  delChildren(self._mapNode.trProperty)
  for _, mapAttachAttr in pairs(AllEnum.AttachAttr) do
    local mapAttr = self.mapAttrBefore[mapAttachAttr.sKey]
    if mapAttr.Value > 0 then
      local goItemObj = instantiate(self._mapNode.goPropertyLong, self._mapNode.trProperty)
      goItemObj:SetActive(true)
      local ctrlItem = self:BindCtrlByNode(goItemObj, "Game.UI.TemplateEx.TemplatePropertyCtrl")
      local bValueChanged = self.mapAttrAfter[mapAttachAttr.sKey].Value ~= mapAttr.Value
      if bValueChanged then
        ctrlItem:SetItemProperty(mapAttr.Key, mapAttr.Value, self.mapAttrAfter[mapAttachAttr.sKey].Value, true)
      else
        ctrlItem:SetItemProperty(mapAttr.Key, mapAttr.Value, nil, true)
      end
    end
  end
  self.tbUpgradeNote = PlayerData.Disc:GetUpgradeNote(self._panel.nId)
  for _, v in pairs(self.tbUpgradeNote) do
    local goItemObj = instantiate(self._mapNode.goPropertyLongNote, self._mapNode.trProperty)
    goItemObj:SetActive(true)
    local ctrlItem = self:BindCtrlByNode(goItemObj, "Game.UI.TemplateEx.TemplatePropertyCtrl")
    ctrlItem:SetNote(v[1], v[2], v[3])
  end
end

function DiscAdvanceCtrl:RefreshCoin(mapDisc)
  local nGoldCost = mapDisc.nPromoteGoldReq
  self:SetSprite_Coin(self._mapNode.imgCostIcon, AllEnum.CoinItemId.Gold)
  local nHasCoin = PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.Gold)
  NovaAPI.SetTMPText(self._mapNode.txtCostCount, math.ceil(nGoldCost))
  NovaAPI.SetTMPColor(self._mapNode.txtCostCount, nGoldCost <= nHasCoin and Blue_Normal or Red_Unable)
end

function DiscAdvanceCtrl:RefreshMat(mapDisc)
  self.tbMat = mapDisc.tbPromoteItemInfoReq
  local nMatCount = #self.tbMat
  for i = 1, 4 do
    self._mapNode.btnAdd[i].interactable = i <= nMatCount
    if i <= nMatCount then
      self._mapNode.goMat[i]:SetMat(self.tbMat[i].nItemId, self.tbMat[i].nItemNum)
    else
      self._mapNode.goMat[i]:SetMat(0)
    end
  end
  local nWorldClassLimit = 0
  
  local function foreachPromoteLimit(mapData)
    if mapData.Rarity == mapDisc.nRarity and tonumber(mapData.Phase) == mapDisc.nPhase + 1 then
      nWorldClassLimit = mapData.WorldClassLimit
    end
  end
  
  ForEachTableLine(DataTable.DiscPromoteLimit, foreachPromoteLimit)
  local nCurWorldClass = PlayerData.Base:GetWorldClass()
  if nWorldClassLimit > nCurWorldClass then
    self._mapNode.btnAdvance.gameObject:SetActive(false)
    self._mapNode.btnAutoFill.gameObject:SetActive(false)
    self._mapNode.txtAdvanceTips.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtAdvanceTips, orderedFormat(ConfigTable.GetUIText("Disc_Advance_WorldClass_Limit"), nWorldClassLimit))
    return
  end
  local tbNeedMat = {}
  for _, v in ipairs(self.tbMat) do
    table.insert(tbNeedMat, {
      nId = v.nItemId,
      nCount = v.nItemNum
    })
  end
  self.tbFillStep, self.tbUseItem, self.tbShowNeedItem = PlayerData.Item:AutoFillMat(tbNeedMat)
  local nHasCoin = PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.Gold)
  local bAbleAutoFill = next(self.tbUseItem) ~= nil and nHasCoin >= mapDisc.nPromoteGoldReq
  self._mapNode.btnAdvance.gameObject:SetActive(not bAbleAutoFill)
  self._mapNode.btnAutoFill.gameObject:SetActive(bAbleAutoFill)
  self._mapNode.txtAdvanceTips.gameObject:SetActive(false)
end

function DiscAdvanceCtrl:RefreshBuffInfo(mapDisc)
  local buffCount = 0
  self.tbGridHeight = {}
  self.mapPreviewDesc = {}
  self.tbDesc = {}
  local AdvanceDescFront, AdvanceDescAfter = "", ""
  if mapDisc.nRarity == GameEnum.itemRarity.SSR then
    local nLimit = ConfigTable.GetConfigNumber("DiscL2dUnlock")
    if nLimit == mapDisc.nPhase + 1 then
      AdvanceDescFront = ConfigTable.GetUIText("Disc_Advance_L2dUnlock1")
      AdvanceDescAfter = ConfigTable.GetUIText("Disc_Advance_L2dUnlock2")
      table.insert(self.tbDesc, {sFront = AdvanceDescFront, sAfter = AdvanceDescAfter})
    end
  end
  if AdvanceDescFront ~= "" or AdvanceDescAfter ~= "" then
    buffCount = buffCount + 1
    local nMaxHeight = math.max(self:_CalcGridHeight(AdvanceDescFront), self:_CalcGridHeightAfter(AdvanceDescAfter))
    table.insert(self.tbGridHeight, nMaxHeight)
    table.insert(self.mapPreviewDesc, {sFront = AdvanceDescFront, sAfter = AdvanceDescAfter})
  end
  if 0 < buffCount then
    local goGrid = instantiate(self._mapNode.goBuff, self._mapNode.trProperty)
    goGrid:SetActive(true)
    local txtBuff = goGrid.transform:Find("txtBuff")
    if txtBuff ~= nil then
      NovaAPI.SetTMPText(txtBuff:GetComponent("TMP_Text"), self.mapPreviewDesc[1].sFront)
    end
    local txtBuffContent = goGrid.transform:Find("txtBuffContent")
    if txtBuffContent ~= nil then
      NovaAPI.SetTMPText(txtBuffContent:GetComponent("TMP_Text"), self.mapPreviewDesc[1].sAfter)
    end
  end
end

function DiscAdvanceCtrl:Awake()
end

function DiscAdvanceCtrl:OnEnable()
end

function DiscAdvanceCtrl:OnDisable()
end

function DiscAdvanceCtrl:OnDestroy()
end

function DiscAdvanceCtrl:OnBtnClick_Advance(btn)
  local mapDisc = PlayerData.Disc:GetDiscById(self._panel.nId)
  for _, mapMat in pairs(self.tbMat) do
    local nHas = PlayerData.Item:GetItemCountByID(mapMat.nItemId)
    if nHas < mapMat.nItemNum then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("OUTFIT_04"))
      return
    end
  end
  if mapDisc.nPromoteGoldReq > PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.Gold) then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("OUTFIT_06"))
    return
  end
  
  local function callback()
    local mapData = {
      nLevel = mapDisc.nLevel,
      nLevelMax = self.nNextMaxLv,
      mapAttrBefore = self.mapAttrBefore,
      mapAttrAfter = self.mapAttrAfter,
      tbDesc = self.tbDesc,
      nPhase = mapDisc.nPhase,
      nMaxPhase = mapDisc.nMaxPhase,
      tbUpgradeNote = self.tbUpgradeNote
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.DiscSucBar, mapData, AllEnum.DiscSucBar.Advance)
    EventManager.Hit("DiscRefresh")
  end
  
  PlayerData.Disc:SendDiscPromoteReq(self._panel.nId, callback)
end

function DiscAdvanceCtrl:OnBtnClick_AutoFill()
  EventManager.Hit(EventId.OpenPanel, PanelId.FillMaterial, self.tbFillStep, self.tbUseItem, self.tbShowNeedItem)
end

function DiscAdvanceCtrl:OnBtnClick_Tips(btn, nIndex)
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

function DiscAdvanceCtrl:OnEvent_ItemChanged()
  local mapDisc = PlayerData.Disc:GetDiscById(self._panel.nId)
  self:RefreshMat(mapDisc)
end

return DiscAdvanceCtrl
