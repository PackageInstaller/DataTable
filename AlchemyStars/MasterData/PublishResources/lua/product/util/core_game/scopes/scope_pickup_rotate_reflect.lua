require("scope_base")
_class("SkillScopeCalculator_PickUpRotateReflect", SkillScopeCalculator_Base)
SkillScopeCalculator_PickUpRotateReflect = SkillScopeCalculator_PickUpRotateReflect

function SkillScopeCalculator_PickUpRotateReflect:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local world = self._gridFilter._world
  local utilData = world:GetService("UtilData")
  local activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  local renderPickUpComponent = casterEntity:RenderPickUpComponent()
  local reflectDir
  if activeSkillPickUpComponent then
    reflectDir = activeSkillPickUpComponent:GetReflectDir()
  elseif previewPickUpComponent then
    reflectDir = previewPickUpComponent:GetReflectDir()
  end
  local reflectPos = CalcReflectPos(casterPos, centerPos, reflectDir)
  local resultScope = {}
  local distance = {}
  
  local function isValidPos(pos)
    return utilData:IsValidPiecePos(pos)
  end
  
  local range1 = self:CalcLine(casterPos, centerPos, false, isValidPos)
  table.appendArray(resultScope, range1)
  local dmax = 0
  for i, pos in ipairs(range1) do
    local dx = math.abs(pos.x - casterPos.x)
    local dy = math.abs(pos.y - casterPos.y)
    local d = math.max(dx, dy)
    distance[#distance + 1] = d
    dmax = d
  end
  local range2 = self:CalcLine(centerPos, reflectPos, true, isValidPos)
  table.appendArray(resultScope, range2)
  for i, pos in ipairs(range2) do
    local dx = math.abs(pos.x - centerPos.x)
    local dy = math.abs(pos.y - centerPos.y)
    local d = math.max(dx, dy)
    distance[#distance + 1] = d + dmax
  end
  local result = SkillScopeResult:New(SkillScopeType.PickUpRotateReflect, centerPos, resultScope, resultScope)
  result:SetSpecialScopeResult(distance)
  if activeSkillPickUpComponent then
    activeSkillPickUpComponent:SetReflectPos(reflectPos)
    if renderPickUpComponent then
      renderPickUpComponent:SetReflectPos(reflectPos)
    end
  elseif previewPickUpComponent then
    previewPickUpComponent:SetReflectPos(reflectPos)
  end
  return result
end

function SkillScopeCalculator_PickUpRotateReflect:CalcLine(fromPos, toPos, extend, isValidPos)
  if fromPos == toPos then
    return {fromPos}
  end
  local world = self._gridFilter._world
  local boardServiceLogic = world:GetService("BoardLogic")
  local maxX = boardServiceLogic:GetCurBoardMaxX()
  local maxY = boardServiceLogic:GetCurBoardMaxY()
  local range = {}
  local calcX, calcY = self:CalcLineFunction(fromPos, toPos)
  local extendToPos = Vector2(toPos.x, toPos.y)
  local dirX = toPos.x - fromPos.x
  local dirY = toPos.y - fromPos.y
  if dirX < 0 then
    dirX = -1
    if extend then
      local y0 = calcY(0)
      if 0 <= y0 and y0 <= 9 then
        extendToPos.x = 1
        extendToPos.y = math.ceil(y0)
      end
    end
  end
  if 0 <= dirX then
    if extend and 0 < dirX then
      local y9 = calcY(9)
      if 0 <= y9 and y9 <= 9 then
        extendToPos.x = 9
        extendToPos.y = math.ceil(y9)
      end
    end
    dirX = 1
  end
  if dirY < 0 then
    dirY = -1
    if extend then
      local x0 = calcX(0)
      if 0 <= x0 and x0 <= 9 then
        extendToPos.x = math.ceil(x0)
        extendToPos.y = 1
      end
    end
  end
  if 0 <= dirY then
    if extend and 0 < dirY then
      local x9 = calcX(9)
      if 0 <= x9 and x9 <= 9 then
        extendToPos.x = math.ceil(x9)
        extendToPos.y = 9
      end
    end
    dirY = 1
  end
  if extend then
    toPos = extendToPos
  end
  
  local function isLineAcrossGrid(x, y)
    local pts = {}
    local x0 = calcX(y - 1)
    if x0 >= x - 1 and x >= x0 then
      pts[#pts + 1] = x0 * 100 + y - 1
    end
    local x1 = calcX(y)
    if x1 >= x - 1 and x >= x1 then
      pts[#pts + 1] = x1 * 100 + y
    end
    local y0 = calcY(x - 1)
    if y0 >= y - 1 and y >= y0 then
      pts[#pts + 1] = (x - 1) * 100 + y0
    end
    local y1 = calcY(x)
    if y1 >= y - 1 and y >= y1 then
      pts[#pts + 1] = x * 100 + y1
    end
    pts = table.unique(pts)
    return 1 < #pts
  end
  
  for x = fromPos.x, toPos.x, dirX do
    for y = fromPos.y, toPos.y, dirY do
      if isLineAcrossGrid(x, y) then
        local pos = Vector2(x, y)
        if isValidPos(pos) then
          range[#range + 1] = pos
        end
      end
    end
  end
  return range
end

function SkillScopeCalculator_PickUpRotateReflect:CalcLineFunction(fromPos, toPos)
  local fx = fromPos.x - 0.5
  local tx = toPos.x - 0.5
  local fy = fromPos.y - 0.5
  local ty = toPos.y - 0.5
  local k, b, calcX, calcY
  if fx == tx then
    function calcX(y)
      return fx
    end
    
    function calcY(x)
      return fy
    end
  elseif fy == ty then
    function calcX(y)
      return fx
    end
    
    function calcY(x)
      return fy
    end
  else
    k = (ty - fy) / (tx - fx)
    b = fy - k * fx
    
    function calcX(y)
      return (y - b) / k
    end
    
    function calcY(x)
      return k * x + b
    end
  end
  return calcX, calcY
end
