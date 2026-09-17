local this = L_BevTree:registClass("guide.setHighLevelSkill", L_BevTree.action)

function this:param()
  self.skillType = 0
  self.resume = 0
end

function this:parse()
  self.skillType = self:getParam("skillType", true) or 0
  self.resume = self:getParam("resume", true) or 0
end

function this:onEnter()
end

function this:onFinish()
end

function this:onReset()
end

function this:execute()
  local controlEntity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  if controlEntity == nil then
    return L_BevTree.taskResult.Running
  end
  CS.Lens.Gameplay.Modules.BigWorld.SkillUtility.SetForceReceiveInput(controlEntity, self.skillType, self.resume ~= 0)
  printf("guide 设置技能打断", string.format("type: %s,  resume: %s (rusme不为0的时候是打断)", self.skillType, self.resume))
  return L_BevTree.taskResult.Success
end

return this
