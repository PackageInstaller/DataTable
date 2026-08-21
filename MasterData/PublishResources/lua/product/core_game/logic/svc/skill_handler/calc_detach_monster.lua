require("calc_base")
_class("SkillEffectCalcDetachMonster", SkillEffectCalc_Base)
SkillEffectCalcDetachMonster = SkillEffectCalcDetachMonster

function SkillEffectCalcDetachMonster:Constructor(world)
  self._world = world
end

function SkillEffectCalcDetachMonster:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
    if result then
      table.insert(results, result)
    end
  end
  return results
end

function SkillEffectCalcDetachMonster:_CalculateSingleTarget(skillEffectCalcParam, targetID)
  local skillParam = skillEffectCalcParam:GetSkillEffectParam()
  local casterID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterID)
  local aiComponent = casterEntity:AI()
  local attachMonsterID = aiComponent:GetRuntimeData("AttachMonsterID")
  local attachMonsterEntity = self._world:GetEntityByID(attachMonsterID)
  local attachMonsterPos = attachMonsterEntity:GetGridPosition()
  casterEntity:SetGridPosition(attachMonsterPos)
  aiComponent:SetRuntimeData("AttachMonsterID", nil)
  aiComponent:SetRuntimeData("Target", nil)
  local battleStatCmpt = self._world:BattleStat()
  local round = battleStatCmpt:GetCurWaveTotalRoundCount()
  local waveIndex = battleStatCmpt:GetCurWaveIndex()
  local curState = self._world:GameFSM():CurStateID()
  if curState == GameStateID.MonsterTurn then
    round = round + 1
  end
  aiComponent:SetRuntimeData("DetachBeginRunRound", round)
  aiComponent:SetRuntimeData("DetachBeginWaveIndex", waveIndex)
  return SkillEffectDetachMonsterResult:New(attachMonsterPos, attachMonsterID)
end
