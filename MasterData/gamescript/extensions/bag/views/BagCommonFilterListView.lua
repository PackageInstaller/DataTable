local BagCommonFilterListView, Super = NewClass("BagCommonFilterListView", BaseView)
BagCommonFilterListView.uiResCls = UI_Common_Filter_List_1_OptimizedResource

function BagCommonFilterListView:ctor(position, curType, sortTypeList, selectedFunc, closeFunc)
  Super.ctor(self)
  self.position = position
  self.sortTypeList = sortTypeList
  self.curType = curType
  self.selectedFunc = selectedFunc
  self.closeFunc = closeFunc
end

function BagCommonFilterListView:RegisterEvents()
  self:AddButtonClickListener(self.ui.ClickMask, function()
    if self.closeFunc then
      self.closeFunc()
    end
    self:Close()
  end)
end

function BagCommonFilterListView:OnEnterView()
  Super.OnEnterView(self)
  self:_RefreshFilters()
  self.ui.UI_Common_Filter_List.transform.position = self.position
end

function BagCommonFilterListView:_RefreshFilters()
  local contentTrans = self.ui.Content.transform
  local cnt = #self.sortTypeList
  local childCount = contentTrans.childCount
  while cnt > childCount do
    Instantiate(self.ui.UI_Common_Toggle_Filter_Item, contentTrans)
    childCount = childCount + 1
  end
  for index = 1, cnt do
    local go = contentTrans:GetChild(index - 1).gameObject
    go:SetActive(true)
    local sortTypeData = self.sortTypeList[index]
    local sortType = sortTypeData.type or index
    local sortTypeName = sortTypeData.name
    local uiRes = UI_Common_Filter_List_ItemResource(go)
    self:AddButtonClickListener(uiRes.Btn_Click, function()
      if self.selectedFunc then
        self.selectedFunc(sortType)
      end
      self:Close()
    end)
    self:SetText(uiRes.Text_Name, sortTypeName)
    local isSelected = sortType == self.curType
    local texColorType = CommonDefine.ColorType.Dark
    local btnState = CommonDefine.Z1ButtonState.Normal
    if isSelected then
      texColorType = CommonDefine.ColorType.Light
      btnState = CommonDefine.Z1ButtonState.High
    end
    self:SetTextColorType(uiRes.Text_Name, texColorType)
    self:SetButtonState(uiRes.Btn_Click, btnState)
    self.binder:UpdateLocalizedTextAndResouce(go)
  end
  for i = cnt + 1, childCount do
    local go = contentTrans:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
end

return BagCommonFilterListView
