_class("SkillEffectCalc_KillPlayer", Object)
SkillEffectCalc_KillPlayer = SkillEffectCalc_KillPlayer

function SkillEffectCalc_KillPlayer:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_KillPlayer:DoSkillEffectCalculator(skillEffectCalcParam)
  local range = skillEffectCalcParam.skillRange
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local gridPos = teamEntity:GetGridPosition()
  if table.Vector2Include(range, gridPos) then
    local attributeCmpt = teamEntity:Attributes()
    attributeCmpt:Modify("HP", 0)
    teamEntity:AddTeamDeadMark()
  end
end
