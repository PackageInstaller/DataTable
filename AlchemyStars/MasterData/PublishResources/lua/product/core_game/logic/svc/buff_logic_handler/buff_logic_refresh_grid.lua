_class("BuffLogicRefreshGrid", BuffLogicBase)
BuffLogicRefreshGrid = BuffLogicRefreshGrid

function BuffLogicRefreshGrid:Constructor(buffInstance, logicParam)
  self._count = logicParam.count
  self._target = logicParam.target
end

function BuffLogicRefreshGrid:DoLogic()
  local e = self._buffInstance:Entity()
  local world = self._buffInstance:World()
  local boardService = world:GetService("BoardLogic")
  local randomSvc = self._world:GetService("RandomLogic")
  local petPos = e:GetGridPosition()
  local utilData = world:GetService("UtilData")
  local gridList = {}
  for x = -1, 1 do
    for y = -1, 1 do
      local pos = Vector2(x + petPos.x, y + petPos.y)
      if utilData:IsValidPiecePos(pos) and pos ~= petPos then
        table.insert(gridList, pos)
      end
    end
  end
  local refreshList = self:_GetRandomList(gridList, randomSvc)
  for _, pos in ipairs(refreshList) do
    boardService:SetPieceTypeLogic(self._target, pos)
  end
  local buffResult = BuffResultRefreshGrid:New(refreshList, self._target)
  return buffResult
end

function BuffLogicRefreshGrid:_GetRandomList(list, randomSvc)
  local hadRefreshList = {}
  for i = 1, 100 do
    local randomIndex = randomSvc:LogicRand(1, #list)
    local randomPos = list[randomIndex]
    if not table.intable(hadRefreshList, randomPos) then
      table.insert(hadRefreshList, randomPos)
    end
    if #hadRefreshList == self._count then
      break
    end
  end
  return hadRefreshList
end
