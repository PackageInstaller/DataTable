require("scope_base")
_class("SkillScopeCalculator_NearestInSquareRing", SkillScopeCalculator_Base)
SkillScopeCalculator_NearestInSquareRing = SkillScopeCalculator_NearestInSquareRing

function SkillScopeCalculator_NearestInSquareRing:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  if not self._gridFilter._world then
    return SkillScopeResult:New(SkillScopeType.NearestInSquareRing, {}, {}, {})
  end
  local world = self._gridFilter._world
  local nRingLength = scopeParam[1]
  local nTargetLimit = scopeParam[2]
  local buffEffectTypeForExtraRing = scopeParam[3]
  if buffEffectTypeForExtraRing and 0 < buffEffectTypeForExtraRing then
    local isPreviewChain = false
    local previewEntity = world:GetPreviewEntity()
    if previewEntity then
      local previewChainPathCmpt = previewEntity:PreviewChainPath()
      if previewChainPathCmpt and previewChainPathCmpt:IsLinkLine() then
        isPreviewChain = true
        local chainPathList = previewChainPathCmpt:GetPreviewChainPath()
        if chainPathList and 0 < #chainPathList then
          local utilDataSvc = world:GetService("UtilData")
          local trapCount = 0
          for _, pos in ipairs(chainPathList) do
            local maintainColorTrapList = utilDataSvc:FindMaintainColorTrapByPos(pos)
            if 0 < #maintainColorTrapList then
              trapCount = trapCount + 1
            end
          end
          nRingLength = nRingLength + trapCount
        end
      end
    end
    if not isPreviewChain then
      local buffSvc = world:GetService("BuffLogic")
      local curLayerCount = buffSvc:GetBuffLayer(casterEntity, buffEffectTypeForExtraRing)
      nRingLength = nRingLength + curLayerCount
    end
  end
  local tv2RingWholeRange = ComputeScopeRange.ComputeRange_SquareRing(centerPos, #bodyArea, nRingLength)
  local monsterIDArray = self._gridFilter:SelectNearestMonsterInRangeOnPos(casterEntity, centerPos, nTargetLimit, tv2RingWholeRange)
  local monsterPosList = {}
  for i, id in ipairs(monsterIDArray) do
    local entity = self._gridFilter._world:GetEntityByID(id)
    local bodyAreaCmpt = entity:BodyArea()
    local pos = entity:GetGridPosition()
    local areaArray = bodyAreaCmpt:GetArea()
    for _, area in ipairs(areaArray) do
      table.insert(monsterPosList, Vector2(pos.x + area.x, pos.y + area.y))
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.NearestInSquareRing, centerPos, monsterPosList, monsterPosList, monsterIDArray)
  return result
end
