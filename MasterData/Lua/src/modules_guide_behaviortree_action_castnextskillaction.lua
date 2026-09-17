local this = L_BevTree:registClass("guide.castNextSkillAction", L_BevTree.action)
local tag = this:getName()

function this:param()
  self.configId = ""
  self.skillId = ""
  self.skillIndex = ""
  self.isPet = 0
  self.skillSlot = 0
end

function this:parse()
  self.configId = self:getParam("configId", true)
  self.skillId = self:getParam("skillId", true)
  self.skillIndex = self:getParam("skillIndex", true)
  self.isPet = self:getParam("isPet", true)
  self.skillSlot = self:getParam("skillSlot", true)
end

function this:onEnter()
end

function this:onFinish()
  self:resumeWorld()
end

function this:onReset()
  self:resumeWorld()
end

function this:execute()
  local mainControl = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  if mainControl == nil then
    return L_BevTree.taskResult.Success
  end
  if math.isEmpty(self.isPet) then
    if math.isEmpty(self.configId) or math.isEmpty(self.skillId) then
      return L_BevTree.taskResult.Failure
    end
    local heroId = mainControl.data.configId
    if self.configId ~= heroId then
      return L_BevTree.taskResult.Failure
    end
    self:castSkill(mainControl, self.skillId, self.skillIndex)
  else
    if not AzurWorld.playerMgr.myPlayerData:GetPetEntity(AzurWorld.playerMgr.myPlayerData.formationMainControlIndex) then
      return L_BevTree.taskResult.Success
    end
    local petEntity = AzurWorld.playerMgr.myPlayerData:GetPetEntity(AzurWorld.playerMgr.myPlayerData.formationMainControlIndex)
    if petEntity == nil then
      return L_BevTree.taskResult.Success
    end
    local skillProperty = petEntity.data.skillProperty
    local skill = skillProperty:GetSkillBySlot(self.skillSlot)
    local skillId = skill.id
    self:castSkill(petEntity, skillId, self.skillIndex)
  end
  return L_BevTree.taskResult.Success
end

function this:castSkill(entity, skillId, skillIndex)
  self:resumeWorld()
  CS.Lens.Gameplay.Modules.BigWorld.SkillUtility.CastNextSkill(entity, skillId, skillIndex)
end

function this:resumeWorld()
  if not self.resume then
    L_GuideManager:setWorldPause(false, self.tree.param.guideId)
    self.resume = true
  end
end

return this
