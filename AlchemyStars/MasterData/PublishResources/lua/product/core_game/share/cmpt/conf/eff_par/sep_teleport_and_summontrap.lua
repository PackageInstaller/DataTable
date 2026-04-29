require("skill_effect_param_base")
_class("SkillEffectParamTeleportAndSummonTrap", SkillEffectParamBase)
SkillEffectParamTeleportAndSummonTrap = SkillEffectParamTeleportAndSummonTrap

function SkillEffectParamTeleportAndSummonTrap:Constructor(t)
  self._trapID = t.trapID
  self._trapCount = t.trapCount
  self._teleportParam = t.teleportParam
  self._gridAreaArray = {}
  self:InitArea(t.area)
end

function SkillEffectParamTeleportAndSummonTrap:InitArea(area)
  for i, param in ipairs(area) do
    local areaList = {}
    local xBegin = param.x[1]
    local xEnd = param.x[2]
    local yBegin = param.y[1]
    local yEnd = param.y[2]
    for x = xBegin, xEnd do
      for y = yBegin, yEnd do
        table.insert(areaList, Vector2(x, y))
      end
    end
    table.insert(self._gridAreaArray, areaList)
  end
end

function SkillEffectParamTeleportAndSummonTrap:GetGridAreaArray()
  return self._gridAreaArray
end

function SkillEffectParamTeleportAndSummonTrap:GetTrapID()
  return self._trapID
end

function SkillEffectParamTeleportAndSummonTrap:GetEffectType()
  return SkillEffectType.TeleportAndSummonTrap
end

function SkillEffectParamTeleportAndSummonTrap:GetTeleportCountByHPPercent(hpPercent)
  for i, param in ipairs(self._teleportParam) do
    if hpPercent > param.hp_percent[1] then
      return param.teleportCount
    end
  end
end

function SkillEffectParamTeleportAndSummonTrap:GetTrapCount()
  return self._trapCount
end
