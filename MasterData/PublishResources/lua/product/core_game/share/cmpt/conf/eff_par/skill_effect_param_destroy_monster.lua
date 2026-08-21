require("skill_damage_effect_param")
_class("SkillEffectDestroyMonsterParam", SkillEffectParamBase)
SkillEffectDestroyMonsterParam = SkillEffectDestroyMonsterParam

function SkillEffectDestroyMonsterParam:Constructor(t)
  self._destroyType = t.destroyType or SkillEffectDestroyMonsterType.Self
  self._monsterClassIdDic = {}
  if type(t.monsterClassID) == "number" then
    self._monsterClassIdDic[t.monsterClassID] = true
  elseif type(t.monsterClassID) == "table" then
    for _, id in ipairs(t.monsterClassID) do
      self._monsterClassIdDic[id] = true
    end
  end
end

function SkillEffectDestroyMonsterParam:GetEffectType()
  return SkillEffectType.DestroyMonster
end

function SkillEffectDestroyMonsterParam:GetDestroyType()
  return self._destroyType
end

function SkillEffectDestroyMonsterParam:GetMonsterClassIdDic()
  return self._monsterClassIdDic
end

local SkillEffectDestroyMonsterType = {
  Self = 1,
  MySummonMonster = 2,
  InRangeSpecificClass = 3,
  TargetMonster = 4
}
_enum("SkillEffectDestroyMonsterType", SkillEffectDestroyMonsterType)
