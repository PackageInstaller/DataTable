require("scope_base")
_class("SkillScopeCalculator_Boss2904001TeleportPreview", SkillScopeCalculator_Base)
SkillScopeCalculator_Boss2904001TeleportPreview = SkillScopeCalculator_Boss2904001TeleportPreview

function SkillScopeCalculator_Boss2904001TeleportPreview:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local distance = scopeParam[1]
  local attackRange = {}
  local wholeRange = {}
  for _, v2Body in ipairs(bodyArea) do
    local v2AbsBody = v2Body + casterPos
    for offsetX = -distance, distance do
      for offsetY = -distance, distance do
        local v2 = Vector2.New(v2AbsBody.x + offsetX, v2AbsBody.y + offsetY)
        if distance >= Vector2.Distance(v2, v2AbsBody) then
          self:_InsertTargetGrid(attackRange, v2, wholeRange)
        end
      end
    end
  end
  return SkillScopeResult:New(SkillScopeType.Boss2904001TeleportPreview, casterPos, attackRange, wholeRange)
end
