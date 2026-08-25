local UICompTrinketBindChoosenList, Super = NewViewComponent("UICompTrinketBindChoosenList", UICompChoosedTrinketListBase)

function UICompTrinketBindChoosenList:ctor(uiNode, view)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Team_Item_Suit_BookmarkResource(uiNode)
end

function UICompTrinketBindChoosenList:OnBuildComponent()
  Super.OnBuildComponent(self)
  self:SetText(self.ui.Text_Title, LT.Text("TrinketChoosenTitle"))
end

function UICompTrinketBindChoosenList:RegisterEvents()
  Super.RegisterEvents(self)
  self:_HideNode(self.ui.Btn_Suit)
  self:_HideNode(self.ui.Image_Suit)
  self:_HideNode(self.ui.Image_Quantity)
end

function UICompTrinketBindChoosenList:_HideNode(go)
  if not go or IsNil(go) then
    return
  end
  go:SetActive(false)
end

function UICompTrinketBindChoosenList:GetModel()
  return TrinketBindModel.Instance
end

function UICompTrinketBindChoosenList:GetFilterTrinksList()
  do return TrinketBindModel.Instance.GetFilterTrinksList end
  return TrinketBindModel.Instance.GetFilterTrinksList, TrinketBindModel.Instance
end

function UICompTrinketBindChoosenList:IsTrinketChoosing(uid)
  return TrinketBindModel.Instance:GetCurChoosenTrinketUid() == uid
end

function UICompTrinketBindChoosenList:ChooseTrinket(uid)
  TrinketBindModel.Instance:SetCurChoosenTrinketUid(uid)
end

function UICompTrinketBindChoosenList:GetTrinketOwnerTid(uid)
  do return TrinketBindModel.Instance.GetTrinketOwnerTid, TrinketBindModel.Instance end
  return TrinketBindModel.Instance.GetTrinketOwnerTid, TrinketBindModel.Instance, uid
end

function UICompTrinketBindChoosenList:GetCurPartType()
  do return TrinketBindModel.Instance.GetCurPartType end
  return TrinketBindModel.Instance.GetCurPartType, TrinketBindModel.Instance
end

return UICompTrinketBindChoosenList
