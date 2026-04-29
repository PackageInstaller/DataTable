require("scope_base")
_class("SkillScopeCalculator_PickUpCrossAndDirToSector", SkillScopeCalculator_Base)
SkillScopeCalculator_PickUpCrossAndDirToSector = SkillScopeCalculator_PickUpCrossAndDirToSector

function SkillScopeCalculator_PickUpCrossAndDirToSector:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity, calcEffectFcuntion)
  local maxAngle = scopeParam[1] or 45
  local attackGridPosList = {}
  local pickUpCenterPos = centerPos[1]
  local pickUpSecondPos = centerPos[2]
  local activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
  if not pickUpSecondPos and activeSkillPickUpComponent then
    pickUpCenterPos = activeSkillPickUpComponent:GetFirstValidPickUpGridPos()
    pickUpSecondPos = activeSkillPickUpComponent:GetLastPickUpGridPos()
  end
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  if not activeSkillPickUpComponent and not pickUpSecondPos and previewPickUpComponent then
    pickUpCenterPos = previewPickUpComponent:GetFirstValidPickUpGridPos()
    pickUpSecondPos = previewPickUpComponent:GetLastPickUpGridPos()
  end
  local pickUpDir = pickUpSecondPos - pickUpCenterPos
  attackGridPosList = self:_CalcScopeWithDirAngle(casterPos, pickUpCenterPos, pickUpDir, maxAngle)
  local result = SkillScopeResult:New(SkillScopeType.PickUpCrossAndDirToSector, centerPos, attackGridPosList, attackGridPosList)
  return result
end

function SkillScopeCalculator_PickUpCrossAndDirToSector:_CalcScopeWithDirAngle(casterPos, selPos, dir, maxAngle)
  local addGridList = {}
  local world = self._gridFilter._world
  local boardService = world:GetService("BoardLogic")
  local pieceXYMap = boardService.GridTiles
  local mainDir = selPos - casterPos
  for gridX, tableY in pairs(pieceXYMap) do
    for gridY, _ in pairs(tableY) do
      local gridPos = Vector2(gridX, gridY)
      local selToGrid = gridPos - selPos
      local casterToGrid = gridPos - casterPos
      local exDirToGridAngle = Vector2.Angle(dir, selToGrid)
      exDirToGridAngle = math.floor(exDirToGridAngle + 0.5)
      if exDirToGridAngle <= 90 then
        local mianDirToGridAngle = Vector2.Angle(mainDir, casterToGrid)
        mianDirToGridAngle = math.floor(mianDirToGridAngle + 0.5)
        if maxAngle >= mianDirToGridAngle then
          table.insert(addGridList, gridPos)
        end
      end
    end
  end
  return addGridList
end
