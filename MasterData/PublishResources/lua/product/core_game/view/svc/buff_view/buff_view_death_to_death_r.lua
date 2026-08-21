_class("BuffViewDeathToDeath", BuffViewBase)
BuffViewDeathToDeath = BuffViewDeathToDeath

function BuffViewDeathToDeath:PlayView(TT)
  local result = self._buffResult
  local skillID = result:GetSkillID()
  local eid = result:GetEntityID()
  local skillHolder = self._world:GetEntityByID(eid)
  local skillResult = result:GetSkillResult()
  skillHolder:SkillRoutine():SetResultContainer(skillResult)
  local playSkillSvc = self._world:GetService("PlaySkill")
  local configSvc = self._world:GetService("Config")
  local skillConfigData = configSvc:GetSkillConfigData(skillID, skillHolder)
  local skillPhaseArray = skillConfigData:GetSkillPhaseArray()
  playSkillSvc:_SkillRoutineTask(TT, skillHolder, skillPhaseArray, skillID)
end
