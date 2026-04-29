require("base_ins_r")
RenderSortSummonTrapPattern = {Monster2900241 = 1}
_class("DataSortSummonTrapResultInstruction", BaseInstruction)
DataSortSummonTrapResultInstruction = DataSortSummonTrapResultInstruction

function DataSortSummonTrapResultInstruction:Constructor(paramList)
  self._pattern = tonumber(paramList.pattern)
end

function DataSortSummonTrapResultInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local cRoutine = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = cRoutine:GetEffectResultByArrayAll(SkillEffectType.SummonTrap)
  if not resultArray then
    return
  end
  local offsetPos = casterEntity:GetRenderGridPosition()
  if not offsetPos then
    return
  end
  if self._pattern == RenderSortSummonTrapPattern.Monster2900241 then
    self:_SortMonster2900241(casterEntity)
  end
end

local function V2DirClean(meta)
  local v2 = Vector2.zero
  if meta.x > 0 then
    v2.x = 1
  elseif meta.x < 0 then
    v2.x = -1
  end
  if 0 < meta.y then
    v2.y = 1
  elseif 0 > meta.y then
    v2.y = -1
  end
  return v2
end

function DataSortSummonTrapResultInstruction:_SortMonster2900241(casterEntity)
  local world = casterEntity:GetOwnerWorld()
  local cLocation = casterEntity:Location()
  local v2meta = cLocation:GetRenderGridDirection()
  local v2dir = V2DirClean(v2meta)
  local brSvc = world:GetService("BoardRender")
  local v2GridPos = casterEntity:GetGridPosition()
  local cRoutine = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = cRoutine:GetEffectResultByArrayAll(SkillEffectType.SummonTrap)
  local tGridList = {}
  for _, result in ipairs(resultArray) do
    table.insert(tGridList, result:GetPos())
  end
  local sequence
  if v2dir == Vector2.up then
    sequence = {
      v2GridPos + Vector2.New(-1, 0),
      v2GridPos + Vector2.New(-1, 1),
      v2GridPos + Vector2.New(-1, 2),
      v2GridPos + Vector2.New(0, 2),
      v2GridPos + Vector2.New(1, 2),
      v2GridPos + Vector2.New(2, 2),
      v2GridPos + Vector2.New(2, 1),
      v2GridPos + Vector2.New(2, 0),
      v2GridPos + Vector2.New(2, -1),
      v2GridPos + Vector2.New(1, -1),
      v2GridPos + Vector2.New(0, -1),
      v2GridPos + Vector2.New(-1, -1)
    }
  elseif v2dir == Vector2.down then
    sequence = {
      v2GridPos + Vector2.New(2, 1),
      v2GridPos + Vector2.New(2, 0),
      v2GridPos + Vector2.New(2, -1),
      v2GridPos + Vector2.New(1, -1),
      v2GridPos + Vector2.New(0, -1),
      v2GridPos + Vector2.New(-1, -1),
      v2GridPos + Vector2.New(-1, 0),
      v2GridPos + Vector2.New(-1, 1),
      v2GridPos + Vector2.New(-1, 2),
      v2GridPos + Vector2.New(0, 2),
      v2GridPos + Vector2.New(1, 2),
      v2GridPos + Vector2.New(2, 2)
    }
  elseif v2dir == Vector2.left then
    sequence = {
      v2GridPos + Vector2.New(1, -1),
      v2GridPos + Vector2.New(0, -1),
      v2GridPos + Vector2.New(-1, -1),
      v2GridPos + Vector2.New(-1, 0),
      v2GridPos + Vector2.New(-1, 1),
      v2GridPos + Vector2.New(-1, 2),
      v2GridPos + Vector2.New(0, 2),
      v2GridPos + Vector2.New(1, 2),
      v2GridPos + Vector2.New(2, 2),
      v2GridPos + Vector2.New(2, 1),
      v2GridPos + Vector2.New(2, 0),
      v2GridPos + Vector2.New(2, -1)
    }
  else
    sequence = {
      v2GridPos + Vector2.New(0, 2),
      v2GridPos + Vector2.New(1, 2),
      v2GridPos + Vector2.New(2, 2),
      v2GridPos + Vector2.New(2, 1),
      v2GridPos + Vector2.New(2, 0),
      v2GridPos + Vector2.New(2, -1),
      v2GridPos + Vector2.New(1, -1),
      v2GridPos + Vector2.New(0, -1),
      v2GridPos + Vector2.New(-1, -1),
      v2GridPos + Vector2.New(-1, 0),
      v2GridPos + Vector2.New(-1, 1),
      v2GridPos + Vector2.New(-1, 2)
    }
  end
  table.sort(resultArray, function(a, b)
    return table.ikey(sequence, a:GetPos()) < table.ikey(sequence, b:GetPos())
  end)
end
