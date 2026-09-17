local this = L_BevTree:registClass("guide.forceCastSkillAction", L_BevTree.action)

function this:param()
  self.isActive = 0
end

function this:parse()
  local tempIsActive = self:getParam("isActive", true)
  self.isActive = tempIsActive ~= nil and tempIsActive ~= 0
  printf("guide", "是否强制禁止释放技能：" .. tostring(self.isActive))
end

function this:onEnter()
  L_GuideManager:setForceNotCastSkill(self.isActive)
end

function this:execute()
  return L_BevTree.taskResult.Success
end

function this:onFinish()
end

return this
