local redDotMap = {
  [CommonDefine.RedDotType.Dot] = "Group_RedDot",
  [CommonDefine.RedDotType.Num] = "Group_RedDot_Num",
  [CommonDefine.RedDotType.TextNew] = "Group_New"
}
local UICompRedDot, Super = NewViewComponent("UICompRedDot")

function UICompRedDot:ctor(uiNode, view, redDotType, Fn, showFn)
  Super.ctor(self, uiNode, view)
  self.ui = Com_RedDotResource(uiNode)
  self.redDotType = redDotType
  self.Fn = Fn
  self.showFn = showFn
  self.redDotMap = redDotMap
end

function UICompRedDot:OnEnterComponent()
  self.redDotBinder = self.binder:createChild()
  self.ui.uiNode:SetActive(true)
  self.curNode = self.ui[self.redDotMap[self.redDotType]]
  if self.Fn then
    if self.curNode then
      self.redDotBinder:BindToVisible(self.curNode, self.Fn)
    end
    for redDotType, node in ipairs(self.redDotMap) do
      if redDotType ~= self.redDotType then
        self.redDotBinder:SetActive(self.ui[node], false)
      end
    end
  end
  if self.showFn then
    self.redDotBinder:BindToRaw(function(_, ret, _)
      for redDotType, node in ipairs(self.redDotMap) do
        self.redDotBinder:SetActive(self.ui[node], false)
      end
      if ret == RedPointDataUtils.RedAttrType.IsNew then
        self.ui.Group_New:SetActive(true)
      elseif ret == RedPointDataUtils.RedAttrType.Red then
        self.ui.Group_RedDot:SetActive(true)
      elseif type(ret) == "number" then
        self.ui.Group_RedDot_Num:SetActive(true)
        self.self.redDotBinder:SetText(self.ui.Text_RedDot_Num, ret or 0)
      end
    end, function()
      do return end
      return self.showFn, nil
    end)
  end
end

function UICompRedDot:OnExitComponent()
  if self.redDotBinder then
    self.redDotBinder:teardown()
    self.redDotBinder = nil
  end
  Super.OnExitComponent(self)
end

function UICompRedDot:SetRedDotShow(redDotType, show)
  local currNode = self.curNode or self.ui[self.redDotMap[redDotType]]
  currNode:SetActive(show)
end

return UICompRedDot
