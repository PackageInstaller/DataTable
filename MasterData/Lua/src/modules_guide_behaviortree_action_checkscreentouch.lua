local this = L_BevTree:registClass("guide.checkScreenTouch", L_BevTree.action)

function this:param()
  self.detectUIName = ""
end

function this:parse()
  self.detectUIName = self:getParam("detectUIName")
end

function this:registerTouch(operator)
  self.handler = self.handler or L_CommonUtil.handle(self.onTouchEvent, self)
  C_ScreenTouch.OnUI_Touch(operator, self.handler)
end

function this:onTouchEvent(gesture)
  if string.isEmpty(self.detectUIName) then
    self.result = L_BevTree.taskResult.Success
  else
    local touchObj = gesture:GetCurrentFirstPickedUIElement()
    local bFound = false
    if touchObj ~= nil then
      bFound = self:checkUITouched(touchObj)
    end
    if bFound then
      self.result = L_BevTree.taskResult.Success
      self:registerTouch("-")
    end
  end
end

function this:checkUITouched(obj)
  if obj.name == self.detectUIName then
    return true
  end
  if obj.transform.parent == nil then
    return false
  end
  if self.tree.targetListItem ~= nil and self.tree.targetListItem.name == obj.name then
    return true
  end
  return self:checkUITouched(obj.transform.parent)
end

function this:onEnter()
  self:registerTouch("+")
  self.result = L_BevTree.taskResult.Running
end

function this:execute()
  return self.result
end

function this:onFinish()
end

return this
