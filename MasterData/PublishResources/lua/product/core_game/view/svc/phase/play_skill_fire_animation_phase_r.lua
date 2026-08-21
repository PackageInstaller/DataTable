require("play_skill_phase_base_r")
_class("PlaySkillFireAnimationPhase", PlaySkillPhaseBase)
PlaySkillFireAnimationPhase = PlaySkillFireAnimationPhase

function PlaySkillFireAnimationPhase:PlayFlight(TT, casterEntity, phaseParam)
  local phaseParam = phaseParam
  local effectService = self._world:GetService("Effect")
  local attackAnimName = phaseParam:GetAnimationName()
  casterEntity:SetAnimatorControllerTriggers({attackAnimName})
  local effFire = phaseParam:GetEffectFireID()
  effectService:CreateEffect(effFire, casterEntity)
  local effBomb = phaseParam:GetEffectBombID()
  effectService:CreateEffect(effBomb, casterEntity)
  local castGridLocation = casterEntity:GridLocation()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local posArr = {}
  local resultSummonArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonEverything)
  for i, v in ipairs(resultSummonArray) do
    local pos = v:GetGridPos()
    table.insert(posArr, pos)
  end
  local effFire = {}
  for i, v in ipairs(posArr) do
    local e = effectService:CreateWorldPositionEffect(32, castGridLocation.Position, false)
    table.insert(effFire, e)
  end
  local delay = phaseParam:GetBombDelayMS()
  if 0 < delay then
    YIELD(TT, delay)
  end
  local attackEffectCount = phaseParam:GetCastEffectCount()
  local boardServiceRender = self._world:GetService("BoardRender")
  YIELD(TT)
  local flyTime = phaseParam:GetFlyTime()
  for i, v in ipairs(posArr) do
    local eff = effFire[i]
    eff:SetViewVisible(true)
    local view = eff:View()
    local go = view:GetGameObject()
    local tran = go.transform
    tran.position = tran.position + Vector3.up * 2
    local startPos = tran.position
    local endPos = boardServiceRender:GridPos2RenderPos(v)
    tran:DOJump(endPos, 10, 1, flyTime * 0.001):SetEase(DG.Tweening.Ease.InOutSine)
  end
  YIELD(TT, flyTime)
  for i, v in ipairs(effFire) do
    self._world:DestroyEntity(v)
  end
end
