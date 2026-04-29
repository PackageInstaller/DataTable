_class("BuffLogicDeathToDeath", BuffLogicBase)
BuffLogicDeathToDeath = BuffLogicDeathToDeath

function BuffLogicDeathToDeath:Constructor(buffInstance, logicParam)
  self._skillID = logicParam.skillID
end

function BuffLogicDeathToDeath:DoLogic(notify)
  local e = self._buffInstance:Entity()
  e:Attributes():SetSimpleAttribute("BuffDeathToDeath", 1)
  local skillLogicSvc = self._world:GetService("SkillLogic")
  skillLogicSvc:CalcSkillEffect(e, self._skillID)
  local result = e:SkillContext():GetResultContainer()
  if self._world:RunAtServer() then
    local damageResults = e:SkillContext():GetResultContainer():GetEffectResultByArray(SkillEffectType.Damage)
    if damageResults and 0 < #damageResults then
      local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
      for _, result in ipairs(damageResults) do
        local target = self._world:GetEntityByID(result:GetTargetID())
        if 0 < result:GetTotalDamage() and 0 >= target:Attributes():GetCurrentHP() and target:Attributes():GetAttribute("BuffDeathToDeath") == nil then
          sMonsterShowLogic:_DoLogicDead(target)
        end
      end
    end
  end
  return BuffResultDeathToDeath:New(e:GetID(), self._skillID, result)
end
