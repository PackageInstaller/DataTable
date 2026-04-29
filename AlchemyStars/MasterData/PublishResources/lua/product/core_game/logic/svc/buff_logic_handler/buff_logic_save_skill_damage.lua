require("buff_logic_base")
_class("BuffLogicSaveSkillDamage", BuffLogicBase)
BuffLogicSaveSkillDamage = BuffLogicSaveSkillDamage

function BuffLogicSaveSkillDamage:Constructor(buffInstance, logicParam)
end

function BuffLogicSaveSkillDamage:DoOverlap(logicParam, context)
  self:DoLogic()
end

function BuffLogicSaveSkillDamage:DoLogic(notify)
  local context = self._buffInstance:Context()
  if not context then
    return
  end
  local e = self._buffInstance:Entity()
  if e:HasDeadMark() then
    return
  end
  local casterEntity = context.casterEntity
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if not damageResultArray or #damageResultArray == 0 then
    return
  end
  local curSaveSkillDamage = e:BuffComponent():GetBuffValue("SaveSkillDamage") or 0
  for _, v in ipairs(damageResultArray) do
    local damageResult = v
    local targetEntityID = damageResult:GetTargetID()
    if targetEntityID == e:GetID() then
      local damageInfo = damageResult:GetDamageInfo(1)
      curSaveSkillDamage = curSaveSkillDamage + damageInfo:GetDamageValue()
    end
  end
  e:BuffComponent():SetBuffValue("SaveSkillDamage", curSaveSkillDamage)
  return true
end

_class("BuffLogicCleanSaveSkillDamage", BuffLogicBase)
BuffLogicCleanSaveSkillDamage = BuffLogicCleanSaveSkillDamage

function BuffLogicCleanSaveSkillDamage:Constructor(buffInstance, logicParam)
end

function BuffLogicCleanSaveSkillDamage:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("SaveSkillDamage", 0)
end
