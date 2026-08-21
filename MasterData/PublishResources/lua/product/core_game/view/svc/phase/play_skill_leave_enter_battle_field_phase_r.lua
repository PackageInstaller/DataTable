require("play_skill_phase_base_r")
_class("PlaySkillLeaveEnterBattleFieldPhase", PlaySkillPhaseBase)
PlaySkillLeaveEnterBattleFieldPhase = PlaySkillLeaveEnterBattleFieldPhase

function PlaySkillLeaveEnterBattleFieldPhase:PlayFlight(TT, casterEntity, phaseParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local leaveEnterBattleFieldResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.LeaveEnterBattleField)
  if not leaveEnterBattleFieldResult then
    return
  end
  local boardServiceRender = self._world:GetService("BoardRender")
  local gridPos = boardServiceRender:GetRealEntityGridPos(casterEntity)
  local isLeave = leaveEnterBattleFieldResult:IsLeave()
  if isLeave then
    casterEntity:AddGridMove(100000, Vector2(5, 100), gridPos)
  else
    local pos = leaveEnterBattleFieldResult:EnterPos() or Vector2(5, 8)
    local dir = leaveEnterBattleFieldResult:EnterDir() or Vector2(0, -1)
    casterEntity:AddGridMove(100000, pos, gridPos)
    casterEntity:SetDirection(dir)
  end
end
