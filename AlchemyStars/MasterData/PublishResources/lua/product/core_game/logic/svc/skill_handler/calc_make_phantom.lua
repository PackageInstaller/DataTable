_class("SkillEffectCalc_MakePhantom", Object)
SkillEffectCalc_MakePhantom = SkillEffectCalc_MakePhantom

function SkillEffectCalc_MakePhantom:Constructor(world)
  self._world = world
end

function SkillEffectCalc_MakePhantom:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillParam = skillEffectCalcParam.skillEffectParam
  local caster = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local pos = self:FindLocationsForPhantom(caster)
  local attrCmpt = caster:Attributes()
  local hpPercent = caster:Attributes():GetCurrentHP() / attrCmpt:CalcMaxHp()
  return SkillMakePhantomEffectResult:New(skillEffectCalcParam.casterEntityID, hpPercent, skillParam:GetTargetID(), pos, caster:GridLocation():GetGridDir())
end

function SkillEffectCalc_MakePhantom:FindLocationsForPhantom(caster)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local bodyArea = caster:BodyArea():GetArea()
  local pos = caster:GetGridPosition()
  
  local function comparer(pos1, pos2)
    local dis1 = math.abs(pos1.x - pos.x) + math.abs(pos1.y - pos.y)
    local dis2 = math.abs(pos2.x - pos.x) + math.abs(pos2.y - pos.y)
    if dis1 > dis2 then
      return 1
    else
      return -1
    end
  end
  
  local boardMaxX = boardServiceLogic:GetCurBoardMaxX()
  local boardMaxY = boardServiceLogic:GetCurBoardMaxY()
  local validPos = {}
  for x = 1, boardMaxX do
    for y = 1, boardMaxY do
      local cur = Vector2(x, y)
      local bodyAreaCheckOk = true
      for index, bodyOff in ipairs(bodyArea) do
        local bodyPos = cur + bodyOff
        if boardServiceLogic:IsPosBlock(bodyPos, BlockFlag.SummonTrap) then
          bodyAreaCheckOk = false
        end
      end
      if bodyAreaCheckOk then
        validPos[#validPos + 1] = cur
      end
    end
  end
  local heap = Heap:New(Heap.CPM_CUSTOM, comparer)
  local filter = {}
  filter.X = {}
  filter.Y = {}
  for _, area in ipairs(bodyArea) do
    local p = pos + area
    filter.X[p.x] = true
    filter.Y[p.y] = true
  end
  for _, p in ipairs(validPos) do
    local valid = true
    for __, area in ipairs(bodyArea) do
      local _temp = p + area
      if filter.X[_temp.x] or filter.Y[_temp.y] or not table.icontains(validPos, _temp) then
        valid = false
        break
      end
    end
    if valid then
      heap:Enqueue(p)
    end
  end
  local target = heap:Peek()
  if target then
    return target
  end
  heap = Heap:New(Heap.CPM_CUSTOM, comparer)
  for _, p in ipairs(validPos) do
    if not filter.X[p.x] and not filter.Y[p.y] and table.icontains(validPos, p) then
      heap:Enqueue(p)
    end
  end
  target = heap:Peek()
  if target then
    return target
  end
  heap = Heap:New(Heap.CPM_CUSTOM, comparer)
  for _, p in ipairs(validPos) do
    heap:Enqueue(p)
  end
  target = heap:Peek()
  if target then
    return target
  end
  Log.fatal("[幽灵] 找不到幻象生成位置")
  return nil
end
