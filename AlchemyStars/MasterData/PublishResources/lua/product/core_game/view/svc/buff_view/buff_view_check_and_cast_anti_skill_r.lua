_class("BuffViewCheckAndCastAntiSkill", BuffViewBase)
BuffViewCheckAndCastAntiSkill = BuffViewCheckAndCastAntiSkill

function BuffViewCheckAndCastAntiSkill:IsNotifyMatch(notify)
  return true
end

function BuffViewCheckAndCastAntiSkill:PlayView(TT, notify)
  local result = self._buffResult
  local entityID = result:GetEntityID()
  local resultBuffSeq = result:GetBuffSeq()
  local skillResult = result:GetSkillResult()
  local skillID = result:GetSkillID()
  if skillID then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateAntiActiveSkill, entityID, 0)
    local skillHolder = self._entity
    skillHolder:SkillRoutine():SetResultContainer(skillResult)
    local playSkillSvc = self._world:GetService("PlaySkill")
    local configSvc = self._world:GetService("Config")
    local skillConfigData = configSvc:GetSkillConfigData(skillID)
    local skillPhaseArray = skillConfigData:GetSkillPhaseArray()
    playSkillSvc:_SkillRoutineTask(TT, skillHolder, skillPhaseArray, skillID)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateAntiActiveSkill, entityID)
end
