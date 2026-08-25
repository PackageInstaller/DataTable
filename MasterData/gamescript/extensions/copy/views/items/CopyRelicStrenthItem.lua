local CopyRelicStrenthItem, Super = NewViewComponent("CopyRelicStrenthItem")

function CopyRelicStrenthItem:ctor(uiNode, view, relicData, shopUid)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dbgcopy_Item_RelicPreviewResource(uiNode)
  self.relicData = relicData
  self.relicData.shopUid = shopUid
  self.relicTid = relicData.relicTid
  self.relicCfg = RelicCfgUtils.GetCfg(self.relicTid)
  self.shopUid = shopUid
end

function CopyRelicStrenthItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnBtnClick))
end

function CopyRelicStrenthItem:OnEnterComponent()
  self:SetImage(self.ui.Image_Relic, self.relicCfg.Icon)
  local extraCost = 0
  if self.shopUid then
    local shopData = ShopDataUtils.GetShopData(self.shopUid)
    extraCost = shopData and shopData.enhanceRelicExtraCost
  end
  self:SetText(self.ui.Text_CostNum, (self.relicCfg.RelicUpgradeCost or 0) + extraCost)
end

function CopyRelicStrenthItem:_OnBtnClick()
  UIManager.Instance:Reopen(Urls.CopyRelicStrengthConfirmView, self.relicData)
end

return CopyRelicStrenthItem
