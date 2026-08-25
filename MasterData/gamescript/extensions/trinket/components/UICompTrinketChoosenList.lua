local TrinketChoosenType = CommonDefine.TrinketChoosenType
local UICompTrinketChoosenList, Super = NewViewComponent("UICompTrinketChoosenList", UICompChoosedTrinketListBase)

function UICompTrinketChoosenList:ctor(uiNode, view)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Team_Item_Suit_BookmarkResource(uiNode)
  self.showBoundTrinketCellTag = true
  self.showBoundTrinketUrQuality = true
end

function UICompTrinketChoosenList:OnBuildComponent()
  Super.OnBuildComponent(self)
  self:SetText(self.ui.Text_Title, LT.Text("TrinketChoosenTitle"))
  self:SetText(self.ui.TogglePart_Text_Select_Normal, LT.Text("TrinketChoosenSuitTitle"))
  self:SetText(self.ui.TogglePart_Text_Select_Highlight, LT.Text("TrinketChoosenSuitTitle"))
  self:SetText(self.ui.TogglePart_Text_Normal, LT.Text("TrinketChoosenPartTitle"))
  self:SetText(self.ui.TogglePart_Text_Highlight, LT.Text("TrinketChoosenPartTitle"))
  self:SetText(self.ui.Text_C_Quantity, LT.Text("TrinketSuitPlanNum"))
end

function UICompTrinketChoosenList:RegisterEvents()
  Super.RegisterEvents(self)
  self:_CreateSuitsTableview()
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Parts, System.fn(self, self._OnClickSingleTrinket))
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Suit, System.fn(self, self._OnClickTrinketSuitPlan))
end

function UICompTrinketChoosenList:_CreateSuitsTableview()
  self.suitListView = self:CreateTableview(self.ui.ScrollView_Suit, function()
    return self.suitsViewData and #self.suitsViewData or 0
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Team_Item_Suit)
    local suitData = self.suitsViewData[index]
    self:AddViewComponentOnce(cell.gameObject, UICompTrinketSuitPlanItem, suitData)
    return cell
  end)
end

function UICompTrinketChoosenList:_RefreshSuitNumText()
  local maxTrinketPlanNum = DT.GetConstant("MaximumNumberOfTrinketPlan") or 0
  local curTrinketPlanNum = AwakerTrinketExtModel.Instance:GetCurPlansCount()
  self:SetText(self.ui.Text_Quantity, curTrinketPlanNum)
  self:SetText(self.ui.Text_Base, "/" .. maxTrinketPlanNum)
end

function UICompTrinketChoosenList:_RefreshSuitView()
  local curTrinketPlanNum = AwakerTrinketExtModel.Instance:GetCurPlansCount()
  local isEmpty = 0 == curTrinketPlanNum
  self.ui.Text_C_Suit:SetActive(isEmpty)
  self.ui.Btn_Added:SetActive(isEmpty)
  self.ui.Btn_Equipment_2:SetActive(not isEmpty)
  self.ui.Btn_Save:SetActive(not isEmpty)
  self.ui.ScrollView_Suit:SetActive(not isEmpty)
  if isEmpty then
    return
  end
  self.suitsViewData = AwakerTrinketExtModel.Instance:GetPlansList()
  self.suitListView:SetOffsetWithoutRefresh(0)
  self.suitListView:ReloadData()
end

function UICompTrinketChoosenList:_OnClickSingleTrinket(isOn)
  self:LocalNotify(NotifyId.OnCloseTrinketDetailsTips)
  if isOn then
    AwakerTrinketExtModel.Instance:SetCurTrinketChoosenType(TrinketChoosenType.SingleTrinket)
  end
end

function UICompTrinketChoosenList:_OnClickTrinketSuitPlan(isOn)
  self:LocalNotify(NotifyId.OnCloseTrinketDetailsTips)
  if isOn then
    AwakerTrinketExtModel.Instance:SetCurTrinketChoosenType(TrinketChoosenType.TrinketSuit)
  end
end

function UICompTrinketChoosenList:RefreshTableview()
  local curChoosenType = AwakerTrinketExtModel.Instance:GetCurTrinketChoosenType()
  local isSingleTrinket = curChoosenType == TrinketChoosenType.SingleTrinket
  if isSingleTrinket then
    self.trinketListView:Refresh()
  else
    self.suitListView:Refresh()
  end
end

function UICompTrinketChoosenList:RefreshView()
  local curChoosenType = AwakerTrinketExtModel.Instance:GetCurTrinketChoosenType()
  local isSingleTrinket = curChoosenType == TrinketChoosenType.SingleTrinket
  self:SetZ1Toggle(self.ui.Btn_Parts, isSingleTrinket, true)
  self:SetZ1Toggle(self.ui.Btn_Suit, not isSingleTrinket, true)
  self.ui.Image_Parts:SetActive(isSingleTrinket)
  self.ui.Image_Suit:SetActive(not isSingleTrinket)
  self.ui.Image_Quantity:SetActive(not isSingleTrinket)
  if isSingleTrinket then
    self.ui.Group_Btn_Location:SetActive(true)
    self:SetText(self.ui.Text_Title, LT.Text("TrinketChoosenTitle"))
    Super.RefreshView(self)
  else
    self:SetText(self.ui.Text_Title, LT.Text("SuitPlanChoosenTitle"))
    self.ui.Text_C_Null:SetActive(false)
    self.ui.Group_Btn_Location:SetActive(false)
    self.ui.Group_Trinket_Bag_Toggle:SetActive(false)
    self:_RefreshSuitView()
    self:_RefreshSuitNumText()
  end
end

function UICompTrinketChoosenList:GetFilterTrinksList()
  do return AwakerTrinketExtModel.Instance.GetFilterTrinksList end
  return AwakerTrinketExtModel.Instance.GetFilterTrinksList, AwakerTrinketExtModel.Instance
end

function UICompTrinketChoosenList:OnClickTrinketPartType(partType)
  AwakerTrinketExtModel.Instance:SetCurPartType(partType)
end

function UICompTrinketChoosenList:IsTrinketChoosing(uid)
  return AwakerTrinketExtModel.Instance:GetCurChoosenTrinketUid() == uid
end

function UICompTrinketChoosenList:ChooseTrinket(uid)
  AwakerTrinketExtModel.Instance:SetCurChoosenTrinketUid(uid)
end

function UICompTrinketChoosenList:GetTrinketOwnerTid(uid)
  local ownerTid = AwakerTrinketExtModel.Instance:GetTrinketOwnerTid(uid)
  if ownerTid and 0 ~= ownerTid then
    return ownerTid
  end
  do return AwakerTrinketExtModel.Instance.GetBoundTrinketOwnerTid, AwakerTrinketExtModel.Instance end
  return AwakerTrinketExtModel.Instance.GetBoundTrinketOwnerTid, AwakerTrinketExtModel.Instance, uid
end

function UICompTrinketChoosenList:GetCurPartType()
  do return AwakerTrinketExtModel.Instance.GetCurPartType end
  return AwakerTrinketExtModel.Instance.GetCurPartType, AwakerTrinketExtModel.Instance
end

function UICompTrinketChoosenList:GetModel()
  return AwakerTrinketExtModel.Instance
end

return UICompTrinketChoosenList
