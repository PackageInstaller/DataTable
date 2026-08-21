require("skill_damage_effect_param")
local MovePathType = {
  Far = 1,
  NearCross = 2,
  NearAround = 3
}
_enum("MovePathType", MovePathType)
_class("SkillEffectParam_MonsterMoveGridByParam", SkillDamageEffectParam)
SkillEffectParam_MonsterMoveGridByParam = SkillEffectParam_MonsterMoveGridByParam

function SkillEffectParam_MonsterMoveGridByParam:Constructor(t)
  self._moveType = t.moveType or MovePathType.Far
  self._resetGrid = t.resetGrid or 1
  self._partnerMonsterClassIDList = t.partnerID or {}
  self._attackSkillID = t.attackSkillID or 0
end

function SkillEffectParam_MonsterMoveGridByParam:GetEffectType()
  return SkillEffectType.MonsterMoveGridByParam
end

function SkillEffectParam_MonsterMoveGridByParam:GetMoveType()
  return self._moveType
end

function SkillEffectParam_MonsterMoveGridByParam:GetAttackSkillID()
  return self._attackSkillID
end

function SkillEffectParam_MonsterMoveGridByParam:GetPartnerIDList()
  return self._partnerMonsterClassIDList
end

function SkillEffectParam_MonsterMoveGridByParam:IsResetGrid()
  return self._resetGrid == 1
end
