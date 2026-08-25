local UICompTrinketSuitPlanItem, Super = NewViewComponent("UICompTrinketSuitPlanItem")

function UICompTrinketSuitPlanItem:ctor(uiNode, view, planData)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Team_Item_SuitResource(uiNode)
  self.planData = planData
end

function UICompTrinketSuitPlanItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnClickPlan))
end

function UICompTrinketSuitPlanItem:OnEnterComponent()
  self:_RefreshPlanInfo()
end

function UICompTrinketSuitPlanItem:_RefreshPlanInfo()
  self.ui.Btn_Click:SetActive(true)
  self.ui.Btn_Sub_Subtract:SetActive(false)
  self.ui.Image_Select_Bg:SetActive(false)
  self.ui.Image_Tick:SetActive(false)
  self:SetText(self.ui.Text_Name, self.planData.name)
  local isEquiping = AwakerTrinketExtModel.Instance:IsEquipingPlan(self.planData.id)
  self.ui.Image_Current:SetActive(isEquiping)
  local curPlanId = AwakerTrinketExtModel.Instance:GetChooseSuitPlanId()
  self.ui.Group_Sub_Select:SetActive(curPlanId == self.planData.id)
  local trinkets = AwakerTrinketExtModel.Instance:GetPlanTrinkets(self.planData.id)
  self:AddViewComponentOnce(self.ui.Group_Parts, UICompTrinketsIcon, trinkets)
  if isEquiping then
    self.ui.Image_Circularhead:SetActive(false)
  else
    local awakerTid = AwakerTrinketExtModel.Instance:GetTrinketPlanOwnerTid(self.planData.id)
    if 0 == awakerTid then
      self.ui.Image_Circularhead:SetActive(false)
    else
      self.ui.Image_Circularhead:SetActive(true)
      local iconPath = AwakerDataUtils.GetCircleHeadIcon(awakerTid)
      self:SetImage(self.ui.Image_Circularhead, iconPath)
    end
  end
  local isEmptyTrinkets = true
  for i, uid in pairs(trinkets or {}) do
    local trinket = ItemDataUtils.GetItemByUid(uid)
    if trinket then
      isEmptyTrinkets = false
    end
  end
  if isEmptyTrinkets then
    self.binder:SetText(self.ui.Text_Number, "")
  else
    self.binder:SetText(self.ui.Text_Number, AwakerTrinketDataUtils.GetTrinketSuitCompletionRate(trinkets) .. "%")
  end
end

function UICompTrinketSuitPlanItem:_OnClickPlan()
  AwakerTrinketExtModel.Instance:SetChooseSuitPlanId(self.planData.id)
end

return UICompTrinketSuitPlanItem
