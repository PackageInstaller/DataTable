local this = L_BevTree:registClass("guide.guideTreeSequencer", L_BevTree.composite)
local tag = this:getName()
local _guideGroupTpl = L_GameTpl:getGuideGroupTpl()

function this:param()
  self.isAutoSaveOnFinish = 1
end

function this:parse()
  self._hasCompleted = false
  self.isAutoSaveOnFinish = self:getParam("isAutoSaveOnFinish", true) or 1
end

function this:onEnter()
  self._hasCompleted = L_GuideStore:isGuideStepComplete(self.tree.param.guideId, 0)
  local tpl = _guideGroupTpl:getTplById(self.tree.param.guideId)
  if _guideGroupTpl:getIsRepeat(tpl) then
    self._hasCompleted = false
  end
end

function this:execute(childResult)
  if self._hasCompleted == true then
    return L_BevTree.taskResult.Success
  end
  if childResult == L_BevTree.taskResult.Failure or childResult == L_BevTree.taskResult.Running then
    return childResult
  end
  return L_BevTree.taskResult.Success
end

function this:onFinish()
  if self._hasCompleted == false and not L_GuideManager:isOnDebugMode() and self.isAutoSaveOnFinish == 1 and self.lastResult == L_BevTree.taskResult.Success then
    L_GuideManager:saveStepId(self.tree.param.guideId, 0)
  end
  if L_GuideManager:isOnDebugMode() or self.isAutoSaveOnFinish ~= 1 or self.lastResult == L_BevTree.taskResult.Failure then
    if self.lastResult == L_BevTree.taskResult.Failure then
      C_MJLog.LogInfo(string.format("[GuideRace] event=guideTreeFailure guideId=%s nodeId=%s result=Failure action=endGuide", tostring(self.tree.param.guideId), tostring(self.id)), C_ELogModule.Guide)
    end
    L_GuideManager:endGuide(self.tree.param.guideId)
  end
  if self.lastResult == L_BevTree.taskResult.Failure then
    printf("guide提示", "引导树以失败结束： " .. self.id)
    C_InputManager.DisableHighLevelControl()
  end
  L_GuideManager:setGuideDebug(false)
end

function this:moveNext()
  if self.lastResult == L_BevTree.taskResult.Failure or self.lastResult == L_BevTree.taskResult.Running then
    return false
  end
  self.childIndex = self.childIndex + 1
  return self.childIndex <= #self.children
end

return this
