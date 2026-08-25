local TurntableRatePanel, Super = System.NewClass("TurntableRatePanel", ActivityBasePanel)
TurntableRatePanel.uiResCls = UI_Events_Popup_ClotherLotteryRateResource
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local DestroyImmediate = CS.UnityEngine.Object.DestroyImmediate

function TurntableRatePanel:ctor(rateList1, rateList2)
  Super.ctor(self)
  self.rateList1 = rateList1
  self.rateList2 = rateList2
  self.rateList = nil
end

function TurntableRatePanel:OnBind(binder)
  self.binder = binder
  self.binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:BindToggle()
  self:RefreshRateItems()
end

function TurntableRatePanel:BindToggle()
  self.binder:BindToZ1Toggle(self.ui.Btn_CurRate, nil, System.fn(self, self.OnToggleCurRate))
  self.binder:BindToZ1Toggle(self.ui.Btn_InitRate, nil, System.fn(self, self.OnToggleInitRate))
  self.binder:SetZ1Toggle(self.ui.Btn_CurRate, true)
  self:OnToggleCurRate()
end

function TurntableRatePanel:OnToggleCurRate()
  self.rateList = self.rateList1
  self:RefreshRateItems()
end

function TurntableRatePanel:OnToggleInitRate()
  self.rateList = self.rateList2
  self:RefreshRateItems()
end

function TurntableRatePanel:RefreshRateItems()
  self.binder:SetText(self.ui.Text_RateTip, LT.Text("TurntableProbabilityDesc"))
  self.tipHeight = StrUtils.SetPreferredHeight(self.ui.Text_RateTip) + 40
  if not self.rateList then
    return
  end
  CS.Framework.TransformUtil.SetAnchoredPos(self.ui.Image_Title.transform, 0, self.tipHeight * -1)
  CS.Framework.TransformUtil.SetAnchoredPos(self.ui.Group_Category.transform, 0, self.tipHeight * -1)
  CS.Framework.TransformUtil.SetAnchoredPos(self.ui.Group_Items.transform, 504, self.tipHeight * -1)
  self.groupTf = self.ui.Group_Category.transform
  self.childTf = self.ui.Group_Items.transform
  self:DestroyRateItems()
  self.groupItemListMap = {}
  self.ui.Cell_Item:SetActive(true)
  local groupItem, childItem
  local colomn = 2
  for _, rateData in ipairs(self.rateList) do
    if rateData.groupName then
      self:CheckToCreateEmptyChildItem(groupItem, groupItem and self.groupItemListMap[groupItem], colomn)
      groupItem = self:CreateGroupRateItem(rateData, self.groupTf)
      self.groupItemListMap[groupItem] = {}
    else
      childItem = self:CreateChildRateItem(rateData, self.childTf)
      if groupItem and childItem and self.groupItemListMap[groupItem] then
        table.insert(self.groupItemListMap[groupItem], childItem)
      end
    end
  end
  self:CheckToCreateEmptyChildItem(groupItem, groupItem and self.groupItemListMap[groupItem], colomn)
  self.ui.Cell_Item:SetActive(false)
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Items)
  self:ResizeContent()
  FrameWaiter.OnNextFrame(System.fn(self, self.ResizeContent))
end

function TurntableRatePanel:DestroyRateItems()
  for groupItem, childItemList in pairs(table.clone(self.groupItemListMap or {})) do
    for _, childItem in ipairs(childItemList) do
      DestroyImmediate(childItem)
    end
    DestroyImmediate(groupItem)
  end
end

function TurntableRatePanel:CreateGroupRateItem(rateData, parentTf)
  local groupItem = self.binder:Instantiate(self.ui.Cell_Item, parentTf)
  self:FillData(groupItem, rateData)
  return groupItem
end

function TurntableRatePanel:CreateChildRateItem(rateData, parentTf)
  local childItem = self.binder:Instantiate(self.ui.Cell_Item, parentTf)
  self:FillData(childItem, rateData)
  return childItem
end

function TurntableRatePanel:CheckToCreateEmptyChildItem(groupItem, groupItemList, colomn)
  if not groupItemList then
    return
  end
  local tailCount = #groupItemList % colomn
  if 0 == tailCount then
    return
  end
  for i = tailCount + 1, colomn do
    local emptyItem = self.binder:Instantiate(self.ui.Cell_Item, self.ui.Group_Items.transform)
    self:FillData(emptyItem, {content = ""})
    table.insert(groupItemList, emptyItem)
  end
end

function TurntableRatePanel:FillData(itemGo, rateData)
  local textTf = itemGo.transform:Find("Text_Content")
  assert(textTf, "Text_Content is not found")
  self.binder:SetText(textTf.gameObject, rateData.groupName or rateData.content)
  itemGo.name = rateData.groupName or rateData.content
end

function TurntableRatePanel:ResizeContent()
  LateUpdateBeat.Instance:Remove(self.ResizeContent, self)
  UpdateBeat.Instance:Remove(self.ResizeContent, self)
  local contentHeight = 0
  for groupItem, childItemList in pairs(self.groupItemListMap) do
    local firstChildItem = childItemList[1]
    local tailChildItem = childItemList[#childItemList]
    groupItem.transform.anchoredPosition = Vector2(0, firstChildItem.transform.anchoredPosition.y)
    local tailHeight = tailChildItem.transform.sizeDelta.y
    local bottomPosY = tailChildItem.transform.anchoredPosition.y - tailHeight
    local topPosY = firstChildItem.transform.anchoredPosition.y
    local height = math.abs(bottomPosY - topPosY)
    groupItem.transform.sizeDelta = Vector2(groupItem.transform.sizeDelta.x, height)
    contentHeight = contentHeight + height
  end
  self.ui.Content.transform.sizeDelta = Vector2(self.ui.Content.transform.sizeDelta.x, contentHeight + self.tipHeight)
end

function TurntableRatePanel:OnUnbind()
  Super.OnUnbind(self)
  LateUpdateBeat.Instance:Remove(self.ResizeContent, self)
  UpdateBeat.Instance:Remove(self.ResizeContent, self)
end

return TurntableRatePanel
