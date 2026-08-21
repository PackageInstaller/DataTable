require("play_skill_phase_base_r")
_class("PlaySkillChargePhase", PlaySkillPhaseBase)
PlaySkillChargePhase = PlaySkillChargePhase

function PlaySkillChargePhase:PlayFlight(TT, casterEntity, phaseParam)
  local chargeAnim = phaseParam:GetAnim()
  casterEntity:SetAnimatorControllerTriggers({chargeAnim})
  local delay = phaseParam:GetDelay()
  if 0 < delay then
    YIELD(TT, delay)
  end
  local effectService = self._world:GetService("Effect")
  local effIds = phaseParam:GetEffIds()
  if effIds then
    for i, v in ipairs(effIds) do
      effectService:CreateEffect(v, casterEntity)
    end
  end
end
