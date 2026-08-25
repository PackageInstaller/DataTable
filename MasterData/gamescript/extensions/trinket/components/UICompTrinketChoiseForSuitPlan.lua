local UICompTrinketChoiseForSuitPlan, Super = NewViewComponent("UICompTrinketChoiseForSuitPlan", UICompChoosedTrinketListBase)

function UICompTrinketChoiseForSuitPlan:ctor(uiNode, view)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Team_Item_Suit_BookmarkResource(uiNode)
  self.showBoundTrinketCellTag = true
end

function UICompTrinketChoiseForSuitPlan:OnBuildComponent()
  Super.OnBuildComponent(self)
  self:SetText(self.ui.Text_Title, LT.Text("TrinketSuitEditTitle"))
end

function UICompTrinketChoiseForSuitPlan:GetFilterTrinksList()
  do return EditTrinketSuitPlanModel.Instance.GetFilterTrinksList end
  return EditTrinketSuitPlanModel.Instance.GetFilterTrinksList, EditTrinketSuitPlanModel.Instance
end

function UICompTrinketChoiseForSuitPlan:OnClickTrinketPartType(partType)
  EditTrinketSuitPlanModel.Instance:SetCurEditingPartType(partType)
end

function UICompTrinketChoiseForSuitPlan:IsTrinketChoosing(uid)
  return EditTrinketSuitPlanModel.Instance:GetCurEditingChoosingTrinketUid() == uid
end

function UICompTrinketChoiseForSuitPlan:ChooseTrinket(uid)
  EditTrinketSuitPlanModel.Instance:SetCurEditingChoosingTrinketUid(uid)
end

function UICompTrinketChoiseForSuitPlan:GetTrinketOwnerTid(uid)
  return 0
end

function UICompTrinketChoiseForSuitPlan:GetCurPartType()
  do return EditTrinketSuitPlanModel.Instance.GetCurEditingPartType end
  return EditTrinketSuitPlanModel.Instance.GetCurEditingPartType, EditTrinketSuitPlanModel.Instance
end

function UICompTrinketChoiseForSuitPlan:GetModel()
  return EditTrinketSuitPlanModel.Instance
end

function UICompTrinketChoiseForSuitPlan:IsTrinketInOtherPlan(uid)
  do return EditTrinketSuitPlanModel.Instance.IsTrinketInOtherPlan, EditTrinketSuitPlanModel.Instance end
  return EditTrinketSuitPlanModel.Instance.IsTrinketInOtherPlan, EditTrinketSuitPlanModel.Instance, uid
end

return UICompTrinketChoiseForSuitPlan
