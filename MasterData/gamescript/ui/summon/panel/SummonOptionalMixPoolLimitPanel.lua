local SummonOptionalMixPoolLimitPanel, Super = System.NewClass("SummonOptionalMixPoolLimitPanel", SummonOptionalLimitPanel)
SummonOptionalMixPoolLimitPanel.uiResCls = UI_Summon_Popup_OptionalMixPoolLimitResource

function SummonOptionalMixPoolLimitPanel:ctor(viewData)
  viewData = viewData or {}
  viewData.isCategorySelect = true
  Super.ctor(self, viewData)
  self._categoryTabList = {}
end

function SummonOptionalMixPoolLimitPanel:OnBind(binder)
  Super.OnBind(self, binder)
  self:_RefreshCategoryTabs()
end

function SummonOptionalMixPoolLimitPanel:_RefreshView()
  Super._RefreshView(self)
  self:_RefreshCategoryTabs()
end

function SummonOptionalMixPoolLimitPanel:_RefreshCategoryTabs()
  if not self.ui.Group_Pool or not self.ui.Item_MixPool then
    return
  end
  local itemGo = self.ui.Item_MixPool
  self.binder:SetActive(itemGo, false)
  local selectNum = SummonCategorySelectDataUtils.GetSelectNum(self.poolTid)
  local model = SummonCategorySelectModel.Instance
  for slot = 1, selectNum do
    local tab = self._categoryTabList[slot]
    if not tab then
      local gameObj = self.binder:Instantiate(itemGo, self.ui.Group_Pool.transform)
      self.binder:SetActive(gameObj, true)
      tab = self.binder:BindComponent(SummonMixPoolCategoryTabComp(gameObj, self.poolTid, slot, System.fn(self, self._OnClickCategoryTab)))
      self._categoryTabList[slot] = tab
    else
      self.binder:SetActive(tab.ui.uiNode, true)
    end
    tab:UpdateTab(model:GetDraftItemTid(slot), slot == self.slot)
  end
  for slot = selectNum + 1, #self._categoryTabList do
    local tab = self._categoryTabList[slot]
    if tab then
      self.binder:SetActive(tab.ui.uiNode, false)
    end
  end
end

function SummonOptionalMixPoolLimitPanel:_OnClickCategoryTab(slot)
  if slot == self.slot then
    return
  end
  local selectedTid = SummonCategorySelectDataUtils.GetListItemTid(self:_GetSelectedItemTidList(), 1)
  if selectedTid then
    SummonCategorySelectController.Instance:OnSelectForSlot(self.slot, selectedTid)
  end
  self:SwitchCategorySlot(slot)
end

return SummonOptionalMixPoolLimitPanel
