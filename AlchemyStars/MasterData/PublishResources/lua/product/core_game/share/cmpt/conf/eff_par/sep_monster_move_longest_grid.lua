require("skill_damage_effect_param")
_class("SkillEffectMonsterMoveLongestGridParam", SkillDamageEffectParam)
SkillEffectMonsterMoveLongestGridParam = SkillEffectMonsterMoveLongestGridParam

function SkillEffectMonsterMoveLongestGridParam:Constructor(t)
  self._findType = t.findType or MonsterMoveLongestGridFindType.Normal
  self._resetGrid = t.resetGrid or 1
  if self._findType == MonsterMoveLongestGridFindType.Spiral then
    self._runCountList = t.runCountList
    if not self._runCountList and type(self._runCountList) ~= "table" then
      Log.fatal("Need runCountList Param")
    end
    self._beginLineCount = t.beginLineCount
    if not self._beginLineCount then
      Log.fatal("Need beginLineCount Param")
    end
  end
  if self._findType == MonsterMoveLongestGridFindType.MoreSpTraps then
    self._lineCount = t.lineCount
    self._lineNeedTrapID = t.lineNeedTrapID
    if not (self._lineCount and self._lineNeedTrapID) or type(self._lineNeedTrapID) == "table" then
      Log.fatal("Need LineCount Param")
    end
  end
  self._arrivePosType = t.arrivePosType or MonsterMoveLongestGridArrivePosType.Normal
  self._flushTrapIDs = {}
  for _, id in ipairs(t.flushTrapIDs) do
    self._flushTrapIDs[id] = true
  end
  local disableDieSkill = t.disableDieSkill or 1
  if disableDieSkill == 1 then
    self._disableDieSkill = true
  else
    self._disableDieSkill = false
  end
  if self._arrivePosType == MonsterMoveLongestGridArrivePosType.NormalAndAttackAtSpTraps then
    self._attackTrapIDs = {}
    for _, id in ipairs(t.attackTrapIDs) do
      self._attackTrapIDs[id] = true
    end
  end
  self._finishType = t.finishType or MonsterMoveLongestGridMoveFinishType.None
  if self._finishType == MonsterMoveLongestGridMoveFinishType.ResetGridAndSummonTraps then
    self._finalAttackPercent = t.finalAttackPercent
  end
  if self._finishType == MonsterMoveLongestGridMoveFinishType.ResetGridAndSummonTraps or self._finishType == MonsterMoveLongestGridMoveFinishType.NoTrapsSummonTraps then
    self._summonTrapID = t.summonTrapID
    self._transferDisabled = t.transferDisabled == 1
  end
  if self._finishType == MonsterMoveLongestGridMoveFinishType.NoTrapsSummonTraps then
    self._summonTrapCount = t.summonTrapCount
    self._summonScopeRingCount = t.summonScopeRingCount
  end
end

function SkillEffectMonsterMoveLongestGridParam:IsTransferDisabled()
  return self._transferDisabled
end

function SkillEffectMonsterMoveLongestGridParam:GetSummonTrapCount()
  return self._summonTrapCount
end

function SkillEffectMonsterMoveLongestGridParam:GetArrivePosType()
  return self._arrivePosType
end

function SkillEffectMonsterMoveLongestGridParam:GetFindType()
  return self._findType
end

function SkillEffectMonsterMoveLongestGridParam:GetAttackTrapIDs()
  return self._attackTrapIDs
end

function SkillEffectMonsterMoveLongestGridParam:GetFinishType()
  return self._finishType
end

function SkillEffectMonsterMoveLongestGridParam:GetSummonTrapID()
  return self._summonTrapID
end

function SkillEffectMonsterMoveLongestGridParam:GetFlushTrapIDs()
  return self._flushTrapIDs
end

function SkillEffectMonsterMoveLongestGridParam:GetEffectType()
  return SkillEffectType.MonsterMoveLongestGrid
end

function SkillEffectMonsterMoveLongestGridParam:GetLineCount()
  return self._lineCount
end

function SkillEffectMonsterMoveLongestGridParam:GetLineNeedTrapID()
  return self._lineNeedTrapID
end

function SkillEffectMonsterMoveLongestGridParam:GetDisableDieSkill()
  return self._disableDieSkill
end

function SkillEffectMonsterMoveLongestGridParam:IsResetGrid()
  return self._resetGrid == 1
end

function SkillEffectMonsterMoveLongestGridParam:GetRunCountList()
  return self._runCountList
end

function SkillEffectMonsterMoveLongestGridParam:GetFinalAttackPercent()
  return self._finalAttackPercent
end

function SkillEffectMonsterMoveLongestGridParam:GetSummonScopeRingCount()
  return self._summonScopeRingCount
end

function SkillEffectMonsterMoveLongestGridParam:GetBeginLineCount()
  return self._beginLineCount
end

local MonsterMoveLongestGridFindType = {
  Normal = 1,
  MoreSpTraps = 2,
  Spiral = 3
}
_enum("MonsterMoveLongestGridFindType", MonsterMoveLongestGridFindType)
local MonsterMoveLongestGridArrivePosType = {Normal = 1, NormalAndAttackAtSpTraps = 2}
_enum("MonsterMoveLongestGridArrivePosType", MonsterMoveLongestGridArrivePosType)
local MonsterMoveLongestGridMoveFinishType = {
  None = 1,
  ResetGridAndSummonTraps = 2,
  NoTrapsSummonTraps = 3
}
_enum("MonsterMoveLongestGridMoveFinishType", MonsterMoveLongestGridMoveFinishType)
