_class("BuffViewCastSkillWithAttribute", BuffViewBase)
BuffViewCastSkillWithAttribute = BuffViewCastSkillWithAttribute

function BuffViewCastSkillWithAttribute:PlayView(TT, notify)
  local result = self._buffResult
  local skillID = result:GetSkillID()
  local skillHolder = self._world:GetEntityByID(result:GetSkillHolderID())
  local skillResult = result:GetSkillResult()
  skillHolder:SkillRoutine():SetResultContainer(skillResult)
  local playSkillSvc = self._world:GetService("PlaySkill")
  local configSvc = self._world:GetService("Config")
  local skillConfigData = configSvc:GetSkillConfigData(skillID, skillHolder)
  local skillPhaseArray = skillConfigData:GetSkillPhaseArray()
  playSkillSvc:_SkillRoutineTask(TT, skillHolder, skillPhaseArray, skillID)
end

_class("BuffViewCastSkill_ByAction", BuffViewBase)
BuffViewCastSkill_ByAction = BuffViewCastSkill_ByAction

function BuffViewCastSkill_ByAction:PlayView(TT, notify)
  local result = self._buffResult
  local skillID = result:GetSkillID()
  local entity = self._entity
  local skillResult = result:GetSkillResult()
  entity:SkillRoutine():SetResultContainer(skillResult)
  local playSkillSvc = self._world:GetService("PlaySkill")
  local configSvc = self._world:GetService("Config")
  local skillConfigData = configSvc:GetSkillConfigData(skillID, entity)
  local skillPhaseArray = skillConfigData:GetSkillPhaseArray()
  playSkillSvc:_SkillRoutineTask(TT, entity, skillPhaseArray, skillID)
end
