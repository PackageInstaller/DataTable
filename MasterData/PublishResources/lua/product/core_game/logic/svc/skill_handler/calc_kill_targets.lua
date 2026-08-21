_class("SkillEffectCalc_KillTargets", Object)
SkillEffectCalc_KillTargets = SkillEffectCalc_KillTargets

function SkillEffectCalc_KillTargets:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
  self._monsterShowLogic = self._world:GetService("MonsterShowLogic")
end

function SkillEffectCalc_KillTargets:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterID = skillEffectCalcParam.casterEntityID
  local targetIDs = skillEffectCalcParam.targetEntityIDs
  local result = SkillEffectKillTargetsResult:New()
  local calcDamageService = self._world:GetService("CalcDamage")
  for i, targetID in ipairs(targetIDs) do
    if targetID ~= -1 then
      local targetEntity = self._world:GetEntityByID(targetID)
      targetEntity:Attributes():Modify("HP", 0)
      if targetEntity:HasMonsterID() then
        calcDamageService:_DisableMonsterAI(targetEntity)
        self._monsterShowLogic:AddMonsterDeadMark(targetEntity)
        result:AddTargetID(targetID)
      end
    end
  end
  return result
end
