local RedDotComponent, Super = System.NewComponent("RedDotComponent")
local redDotMap = {
  [CommonDefine.RedDotType.Dot] = "Group_RedDot",
  [CommonDefine.RedDotType.Num] = "Group_RedDot_Num",
  [CommonDefine.RedDotType.TextNew] = "Group_New"
}

function RedDotComponent:ctor(res, redDotType, Fn, showFn)
  Super.ctor(self)
  self.ui = Com_RedDotResource(res)
  self.redDotType = redDotType or CommonDefine.RedDotType.Dot
  self.Fn = Fn
  self.showFn = showFn
  self.redDotMap = redDotMap
end

function RedDotComponent:OnBind(binder)
  self.binder = binder
  self.ui.uiNode:SetActive(true)
  self.curNode = self.ui[self.redDotMap[self.redDotType]]
  if self.Fn then
    if self.curNode then
      binder:BindToVisible(self.curNode, self.Fn)
    end
    for redDotType, node in ipairs(self.redDotMap) do
      if redDotType ~= self.redDotType then
        binder:SetActive(self.ui[node], false)
      end
    end
  end
  if self.showFn then
    self.binder:BindToRaw(function(_, ret, _)
      for redDotType, node in ipairs(self.redDotMap) do
        if redDotType == self.redDotType and true == ret then
          binder:SetActive(self.ui[node], true)
        else
          binder:SetActive(self.ui[node], false)
        end
      end
      if ret == RedPointDataUtils.RedAttrType.IsNew then
        self.ui.Group_New:SetActive(true)
      elseif ret == RedPointDataUtils.RedAttrType.Red then
        self.ui.Group_RedDot:SetActive(true)
      elseif type(ret) == "number" then
        self.ui.Group_RedDot_Num:SetActive(true)
        self.binder:SetText(self.ui.Text_RedDot_Num, ret or 0)
      end
    end, function()
      do return end
      return self.showFn, nil
    end)
  end
end

function RedDotComponent:SetRedDotShow(redDotType, show)
  local currNode = self.curNode or self.ui[self.redDotMap[redDotType]]
  self.binder:SetActive(currNode, show)
end

return RedDotComponent
