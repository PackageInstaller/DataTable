local SummonMixPoolCategoryTabComp, Super = System.NewComponent("SummonMixPoolCategoryTabComp")
SummonMixPoolCategoryTabComp.uiResCls = UI_Summon_Item_MixPoolResource

function SummonMixPoolCategoryTabComp:ctor(uiNode, poolId, slot, clickFunc)
  Super.ctor(self)
  self.ui = SummonMixPoolCategoryTabComp.uiResCls(uiNode)
  self.poolId = poolId
  self.slot = slot
  self.clickFunc = clickFunc
  self.itemTid = nil
  self.isSelected = false
end

function SummonMixPoolCategoryTabComp:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self._OnClick))
  if self.ui.Com_RedDot then
    binder:SetActive(self.ui.Com_RedDot, false)
  end
  if self.ui.UI_Common_Item_Hint then
    binder:SetActive(self.ui.UI_Common_Item_Hint, false)
  end
  self:_RefreshTab()
end

function SummonMixPoolCategoryTabComp:_OnClick()
  if self.clickFunc then
    self.clickFunc(self.slot)
  end
end

function SummonMixPoolCategoryTabComp:_SafeSetImage(imageGo, path)
  if not imageGo then
    return
  end
  if not SummonCategorySelectDataUtils.IsValidImagePath(path) then
    self.binder:SetActive(imageGo, false)
    return
  end
  self.binder:SetActive(imageGo, true)
  self.binder:SetImage(imageGo, path)
end

function SummonMixPoolCategoryTabComp:_RefreshTab()
  if self.ui.Image_Select then
    self.binder:SetActive(self.ui.Image_Select, self.isSelected)
  end
  if self.ui.Image_PoolSuffix then
    self.binder:SetActive(self.ui.Image_PoolSuffix, false)
  end
  local hasAwaker = self.itemTid ~= nil
  if self.ui.Group_Awaker then
    self.binder:SetActive(self.ui.Group_Awaker, false)
  end
  if self.ui.Group_Weapon then
    self.binder:SetActive(self.ui.Group_Weapon, false)
  end
  if self.ui.Group_Pool then
    self.binder:SetActive(self.ui.Group_Pool, true)
  end
  if self.ui.Group_Got then
    self.binder:SetActive(self.ui.Group_Got, hasAwaker)
  end
  local iconPath = SummonCategorySelectDataUtils.GetSelectTypeIcon(self.poolId, self.slot)
  self:_SafeSetImage(self.ui.Image_Pool, iconPath)
end

function SummonMixPoolCategoryTabComp:UpdateTab(itemTid, isSelected)
  self.itemTid = itemTid
  self.isSelected = true == isSelected
  if self.binder then
    self:_RefreshTab()
  end
end

return SummonMixPoolCategoryTabComp
