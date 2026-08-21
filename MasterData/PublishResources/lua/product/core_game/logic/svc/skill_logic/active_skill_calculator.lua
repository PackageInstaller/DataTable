_class("ActiveSkillCalculator", Object)
ActiveSkillCalculator = ActiveSkillCalculator

function ActiveSkillCalculator:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  self._skillLogicService = self._world:GetService("SkillLogic")
  self._foreachEffectCalculator = ForEachEffectCalculator:New(world)
end

function ActiveSkillCalculator:DoCalculateSkill(casterEntity)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local attackRange = skillEffectResultContainer:GetScopeResult():GetAttackRange()
  local logger = self._world:GetMatchLogger()
  local casterEntityID = casterEntity:GetID()
  logger:BeginSkill(casterEntityID, casterEntity:GridLocation():GetGridPos(), skillID, attackRange)
  self._foreachEffectCalculator:DoSkillEffectCalculate(casterEntity)
  logger:EndSkill(casterEntityID)
end
