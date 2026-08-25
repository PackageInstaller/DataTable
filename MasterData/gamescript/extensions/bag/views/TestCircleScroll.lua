local TestCircleScroll, Super = NewClass("TestCircleScroll", BaseView)
TestCircleScroll.uiResCls = TestCircleScrollResource

function TestCircleScroll:ctor()
  Super.ctor(self)
  self.strList = {
    "瑞幸1",
    "喜茶2",
    "星巴克3",
    "奈雪4",
    "喜茶5",
    "星巴克6",
    "奈雪7",
    "喜茶8",
    "星巴克9",
    "奈雪10",
    "喜茶11",
    "星巴克12",
    "奈雪13",
    "奈雪14",
    "奈雪15"
  }
end

function TestCircleScroll:OnBuildView()
  self:_RegisterTableviewEvents()
  self.tabView:ReloadData()
end

function TestCircleScroll:_RegisterTableviewEvents()
  self.tabView = self:CreateTableview(self.ui.ScrollView, function()
    return self.strList and #self.strList or 0
  end, function(view, index)
    local cell = self:DequeueCell(view, self.ui.Item)
    local str = self.strList[index]
    local gameObject = cell.gameObject
    local textGameObject = gameObject.transform:Find("Text").gameObject
    self:SetText(textGameObject, str)
    return cell
  end, function()
    return 300, 150
  end)
  self.cirlcleScroll = AddLuaCompOnce(self.ui.ScrollView, LuaSectorScroll)
  self.cirlcleScroll:InitSector(20, System.fn(self, self.OnCenterCellChange))
end

function TestCircleScroll:OnCenterCellChange(index, preIndex)
  local cell = self.tabView:GetCellAtIndex(index)
  if cell then
    local gameObject = cell.gameObject
    local textGameObject = gameObject.transform:Find("Text").gameObject
    self:SetTextColorByHtml(textGameObject, "#ffff00")
  end
  local preCell = preIndex and self.tabView:GetCellAtIndex(preIndex)
  if preCell then
    local gameObject = preCell.gameObject
    local textGameObject = gameObject.transform:Find("Text").gameObject
    self:SetTextColorByHtml(textGameObject, "#ffffff")
  end
end

return TestCircleScroll
