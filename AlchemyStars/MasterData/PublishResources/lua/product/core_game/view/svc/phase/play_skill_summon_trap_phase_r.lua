require("play_skill_phase_base_r")
_class("PlaySkillSummonTrapPhase", PlaySkillPhaseBase)
PlaySkillSummonTrapPhase = PlaySkillSummonTrapPhase

function PlaySkillSummonTrapPhase:PlayFlight(TT, casterEntity, phaseParam)
  local summonTrapParam = phaseParam
  local showTime = summonTrapParam:GetShowTimeDelay()
  if 0 < showTime then
    YIELD(TT, showTime)
  end
  local trapServiceRender = self._world:GetService("TrapRender")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonTrap)
  if not resultArray then
    Log.fatal("### PlaySkillSummonTrapPhase SummonTrap result nil")
    return
  end
  for _, result in ipairs(resultArray) do
    local trapIDList = result:GetTrapIDList()
    for i = 1, #trapIDList do
      local trapEntity = self._world:GetEntityByID(trapIDList[i])
      trapServiceRender:CreateSingleTrapRender(TT, trapEntity, true)
      trapEntity:SetPosition(Vector2(result:GetPos().x, result:GetPos().y))
    end
  end
end
