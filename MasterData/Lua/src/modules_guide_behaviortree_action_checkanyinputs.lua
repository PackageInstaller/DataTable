local this = L_BevTree:registClass("guide.checkAnyInputs", L_BevTree.action)

function this:param()
  self.isOnlyTouch = 0
  self.detectKeycode = ""
end

function this:parse()
  self.isOnlyTouch = self:getParam("isOnlyTouch", true)
  self.detectKeycode = self:getParam("detectKeycode")
end

function this:onEnter()
  if string.isEmpty(self.detectKeycode) then
    self.tempPressKeys = {"guide_all"}
  else
    self.tempPressKeys = string.split(self.detectKeycode, "|")
  end
  L_GuideManager:registerInputAction(self.tempPressKeys)
  self.result = L_BevTree.taskResult.Running
end

function this:execute()
  if self.result == L_BevTree.taskResult.Running then
    local isInputActionTriggered = L_GuideManager:isInputActionTriggered()
    if isInputActionTriggered then
      self.result = L_BevTree.taskResult.Success
    end
  end
  return self.result
end

function this:onFinish()
end

function this:dealDetectInputAction()
  return L_GuideManager:isInputActionTriggered()
end

return this
