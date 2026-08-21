require("scope_base")
_class("SkillScopeCalculator_SquareRing", SkillScopeCalculator_Base)
SkillScopeCalculator_SquareRing = SkillScopeCalculator_SquareRing

function SkillScopeCalculator_SquareRing:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local params = scopeParam
  local casterPos = centerPos
  if centerPos._className then
  else
    casterPos = centerPos[1]
  end
  local ringCount = params[1]
  local bSelf = params[2] or 0
  local ringCountRemove = params[3] or 0
  local bodyAreaCount = params[4] or #bodyArea
  local previewAddRingByPathMaintainColorTrap = params[5] or 0
  local world = self._gridFilter._world
  if world and previewAddRingByPathMaintainColorTrap and 0 < previewAddRingByPathMaintainColorTrap then
    local previewEntity = world:GetPreviewEntity()
    if previewEntity then
      local previewChainPathCmpt = previewEntity:PreviewChainPath()
      if previewChainPathCmpt then
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
          ringCount = ringCount + trapCount
        end
      end
    end
  end
  local listTotalData = ComputeScopeRange.ComputeRange_SquareRing(casterPos, bodyAreaCount, ringCount)
  local listTotalDataRemove = {}
  if 0 < ringCountRemove then
    listTotalDataRemove = ComputeScopeRange.ComputeRange_SquareRing(casterPos, bodyAreaCount, ringCountRemove)
  end
  local listAttackData = {}
  for key, value in ipairs(listTotalData) do
    local isValidGrid = self._gridFilter:IsValidPiecePos(value)
    if isValidGrid and not table.intable(listTotalDataRemove, value) then
      listAttackData[#listAttackData + 1] = value
    end
  end
  if bSelf ~= 0 then
    for key, value in pairs(bodyArea) do
      listAttackData[#listAttackData + 1] = value + casterPos
      listTotalData[#listTotalData + 1] = value + casterPos
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.SquareRing, casterPos, listAttackData, listTotalData)
  return result
end
