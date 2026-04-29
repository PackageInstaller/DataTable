_class("SkillEffectCalc_CalEdgePos", Object)
SkillEffectCalc_CalEdgePos = SkillEffectCalc_CalEdgePos

function SkillEffectCalc_CalEdgePos:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_CalEdgePos:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
    if result then
      table.insert(results, result)
    end
  end
  return results
end

function SkillEffectCalc_CalEdgePos:_CalculateSingleTarget(skillEffectCalcParam, defenderEntityID)
  local param = skillEffectCalcParam.skillEffectParam
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local eTarget = self._world:GetEntityByID(defenderEntityID)
  local posCaster = casterEntity:GridLocation().Position
  local farestIdx = 1
  local posArr, dirArr
  local area = casterEntity:BodyArea():GetArea()
  local lbsvc = self._world:GetService("BoardLogic")
  local boardMaxX = lbsvc:GetCurBoardMaxX()
  local boardMaxY = lbsvc:GetCurBoardMaxY()
  if #area == 4 then
    local maxX, maxY = boardMaxX - 1, boardMaxY - 1
    local center4PosArr = {
      {x = 4, y = maxY},
      {x = maxX, y = 5},
      {x = 5, y = 1},
      {x = 1, y = 4}
    }
    local clampX, clampY = {
      3,
      maxX - 2
    }, {
      3,
      maxY - 2
    }
    dirArr = {
      {x = 0, y = -1},
      {x = -1, y = 0},
      {x = 0, y = 1},
      {x = 1, y = 0}
    }
    posArr, farestIdx = self:CalNewPosArr(casterEntity, eTarget, center4PosArr, clampX, clampY)
  else
    Log.debug("### bodyarea == 1")
  end
  local skillResult = SkillEffectResultCalEdgePos:New(farestIdx, posArr, dirArr)
  return skillResult
end

function SkillEffectCalc_CalEdgePos:CalNewPosArr(casterEntity, eTarget, center4PosArr, clampX, clampY)
  local mathService = self._world:GetService("Math")
  local utilDataSvc = self._world:GetService("UtilData")
  local centerPos = utilDataSvc:GetBoardCenterPos()
  local arr = {}
  local farestIdx = 1
  local distance = 0
  local vTC = eTarget:GridLocation().Position - centerPos
  for i, v in ipairs(center4PosArr) do
    local odd = i % 2 == 1
    local newPos = Vector2(v.x, v.y)
    if odd then
      newPos.x = mathService:ClampValue(v.x + vTC.x, clampX[1], clampX[2])
    else
      newPos.y = mathService:ClampValue(v.y + vTC.y, clampY[1], clampY[2])
    end
    table.insert(arr, newPos)
    local newDistance = Vector2.Distance(eTarget:GridLocation().Position, newPos)
    if distance < newDistance then
      distance = newDistance
      farestIdx = i
    end
  end
  return arr, farestIdx
end
