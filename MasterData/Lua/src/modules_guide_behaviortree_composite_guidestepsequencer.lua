local this = L_BevTree:registClass("guide.guideStepSequencer", L_BevTree.composite)
local tag = this:getName()
local _guideGroupTpl = L_GameTpl:getGuideGroupTpl()

function this:param()
  self.guideStep = -1
  self.isAutoSaveOnFinish = 1
end

function this:parse()
  self.guideStep = self:getParam("guideStep", true)
  self.isAutoSaveOnFinish = self:getParam("isAutoSaveOnFinish", true)
  self._hasCompleted = false
end

function this:onEnter()
  self._hasCompleted = L_GuideStore:isGuideStepComplete(self.tree.param.guideId, self.guideStep)
  local tpl = _guideGroupTpl:getTplById(self.tree.param.guideId)
  if _guideGroupTpl:getIsRepeat(tpl) then
    self._hasCompleted = false
  end
  if self._hasCompleted == true then
    printf(tag, "行为树id：" .. self.tree.param.guideId .. " 步骤：" .. self.guideStep .. " 完成")
  elseif not L_GuideManager:isOnDebugMode() then
    local guideGroupTpl = L_GameTpl:getGuideGroupTpl()
    local tpl = guideGroupTpl:getTplById(self.tree.param.guideId)
    local guideType = guideGroupTpl:getGuideType(tpl)
    local eventData = {
      act_type = 1,
      guide_id = self.guideStep,
      guide_group_id = self.tree.param.guideId,
      guide_type = guideType
    }
    L_GameUtil.logEvent(L_Const.logEventName.guide, eventData)
  end
end

function this:canRunChildren()
  return self._hasCompleted == false
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
  if self._hasCompleted == false and self.isAutoSaveOnFinish == 1 and self.guideStep > 0 and self.lastResult == L_BevTree.taskResult.Success and not L_GuideManager:isOnDebugMode() then
    L_GuideManager:saveStepId(self.tree.param.guideId, self.guideStep)
  end
end

function this:moveNext()
  if self._hasCompleted == true or self.lastResult == L_BevTree.taskResult.Failure or self.lastResult == L_BevTree.taskResult.Running then
    return false
  end
  self.childIndex = self.childIndex + 1
  return self.childIndex <= #self.children
end

return this
