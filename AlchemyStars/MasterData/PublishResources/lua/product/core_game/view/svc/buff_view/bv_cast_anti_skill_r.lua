_class("BuffViewCastAntiSkill", BuffViewBase)
BuffViewCastAntiSkill = BuffViewCastAntiSkill

function BuffViewCastAntiSkill:PlayView(TT, notify)
  local result = self._buffResult
  local skillID = result:GetSkillID()
  local startTask = result:GetStartTask()
  local skillHolder = self._world:GetEntityByID(result:GetSkillHolderID())
  local skillResult = result:GetSkillResult()
  skillHolder:SkillRoutine():SetResultContainer(skillResult)
  local playSkillSvc = self._world:GetService("PlaySkill")
  local configSvc = self._world:GetService("Config")
  local skillConfigData = configSvc:GetSkillConfigData(skillID, skillHolder)
  local skillPhaseArray = skillConfigData:GetSkillPhaseArray()
  if startTask == 0 then
    playSkillSvc:_SkillRoutineTask(TT, skillHolder, skillPhaseArray, skillID)
  else
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      playSkillSvc:_SkillRoutineTask(TT, skillHolder, skillPhaseArray, skillID)
    end)
  end
end
