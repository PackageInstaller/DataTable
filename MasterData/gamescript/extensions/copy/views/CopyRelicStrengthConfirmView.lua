local OriginColor, NotEnoughColor
local CopyRelicStrengthConfirmView, Super = NewClass("CopyRelicStrengthConfirmView", BaseView)
CopyRelicStrengthConfirmView.uiResCls = UI_Dbgcopy_Panel_RelicStrengthResource

function CopyRelicStrengthConfirmView:ctor(relicData)
  Super.ctor(self)
  self.relicData = relicData
  self.relicTid = relicData.relicTid
  self.relicCfg = RelicCfgUtils.GetCfg(self.relicTid)
  OriginColor = "#FFFFFF"
  NotEnoughColor = StrUtils.GetWordsEffectColor(DT.WordsEffectConfig.Shop3)
end

function CopyRelicStrengthConfirmView:OnEnterView()
  Super.OnEnterView(self)
  self:SetActive(self.ui.UI_VX_Creation_Update01, false)
  self:RefreshView()
end

function CopyRelicStrengthConfirmView:RegisterEvents()
  self:BindEvent(EventMgr.Instance.OnDMoneyGoldChange, System.fn(self, self.RefreshCostInfo))
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnClickConfirm))
end

function CopyRelicStrengthConfirmView:_OnClickConfirm()
  if not self:_CheckCurrencyEnough() then
    Alert.ShowStr(LT.Text("StorePhiloStoneLack"))
    return
  end
  
  local function callback()
    self:SetActive(self.ui.UI_VX_Creation_Update01, false)
    self:SetActive(self.ui.UI_VX_Creation_Update01, true)
    self.timer = self:BindTimer(1, 0, nil, function()
      self:Close()
    end)
  end
  
  WorldstageReqUtils.ReqOnEnhanceRelic(self.relicTid, callback)
end

function CopyRelicStrengthConfirmView:_GetCost()
  local extraCost = 0
  if self.relicData.shopUid then
    local shopData = ShopDataUtils.GetShopData(self.relicData.shopUid)
    extraCost = shopData and shopData.enhanceRelicExtraCost
  end
  return (self.relicCfg.RelicUpgradeCost or 0) + extraCost
end

function CopyRelicStrengthConfirmView:_CheckCurrencyEnough()
  local costNum = self:_GetCost()
  local haveNum = WorldstageDMoneyDataUtils.GetGold()
  return costNum <= haveNum
end

function CopyRelicStrengthConfirmView:RefreshView()
  self:RefreshRelicComp()
  self:RefreshCostInfo()
  self:SetButtonText(self.ui.Btn_Cancel, LT.Text("UniversalCancelButton"))
  self:SetButtonText(self.ui.Btn_Confirm, LT.Text("UniversalConfirmButton"))
  self:SetButtonState(self.ui.Btn_Cancel, CommonDefine.BtnType.High)
  self:SetButtonState(self.ui.Btn_Confirm, CommonDefine.BtnType.High)
end

function CopyRelicStrengthConfirmView:RefreshCostInfo()
  local showCostNum = LT.Text(self:_GetCost())
  local showCostColor = self:_CheckCurrencyEnough() and OriginColor or NotEnoughColor
  self:SetText(self.ui.Text_CostNum, string.format("<color=%s>%s</color>", showCostColor, showCostNum))
end

function CopyRelicStrengthConfirmView:RefreshRelicComp()
  self:AddViewComponent(self.ui.Item_CurRelic, CopyRelicStrenthPreviewItem, self.relicTid)
  local upgradeRelicTid = self.relicCfg.RelicUpgrade
  if upgradeRelicTid then
    self:AddViewComponent(self.ui.Item_StrengthRelic, CopyRelicStrenthPreviewItem, upgradeRelicTid)
  end
end

return CopyRelicStrengthConfirmView
