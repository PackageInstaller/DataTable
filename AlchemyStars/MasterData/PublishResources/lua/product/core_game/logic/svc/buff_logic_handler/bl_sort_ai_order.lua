_class("BuffLogicSortAI", BuffLogicBase)
BuffLogicSortAI = BuffLogicSortAI
local SortAIOrderType = {Type1 = 1}
_enum("SortAIOrderType", SortAIOrderType)

function BuffLogicSortAI:Constructor(buffInstance, logicParam)
  self._orderWeight = logicParam.orderWeight
  self._sortType = logicParam.sortType
  self._sortAIConfigID = logicParam.sortAIConfigID
  self._aiLogicType = logicParam.aiLogicType or AILogicPeriodType.Main
  self._sortParam = logicParam.sortParam or {5, 9}
end

function BuffLogicSortAI:DoLogic()
  local aiEntityList = self._world:GetGroupEntities(self._world.BW_WEMatchers.AI)
  local needSortEntitiesList = {}
  for i = 1, #aiEntityList do
    local e = aiEntityList[i]
    local aiComponent = e:AI()
    local aiLogicList = aiComponent:GetAILogic(self._aiLogicType)
    for _, aiLogic in pairs(aiLogicList) do
      if aiLogic:GetAIConfigID() == self._sortAIConfigID then
        table.insert(needSortEntitiesList, e)
        break
      end
    end
  end
  if self._sortType == SortAIOrderType.Type1 then
    self:SortType1(needSortEntitiesList)
  end
end

function BuffLogicSortAI:BuildSortType1List()
  local sortBoardList = {}
  local centerList = Vector2(self._sortParam[1], self._sortParam[2])
  local boardSvc = self._world:GetService("BoardLogic")
  local maxX = boardSvc:GetCurBoardMaxX()
  local maxY = boardSvc:GetCurBoardMaxY()
  local curX, curY = centerList.x, centerList.y
  for i = curX, 1, -1 do
    local pos = Vector2(i, curY)
    if boardSvc:IsValidPiecePos(pos) then
      table.insert(sortBoardList, pos)
    end
  end
  for i = maxY, 1, -1 do
    local pos = Vector2(1, i)
    if boardSvc:IsValidPiecePos(pos) then
      table.insert(sortBoardList, pos)
    end
  end
  for i = 1, maxX do
    local pos = Vector2(i, 1)
    if boardSvc:IsValidPiecePos(pos) then
      table.insert(sortBoardList, pos)
    end
  end
  for i = 1, maxY do
    local pos = Vector2(maxX, i)
    if boardSvc:IsValidPiecePos(pos) then
      table.insert(sortBoardList, pos)
    end
  end
  for i = 2, curX, -1 do
    local pos = Vector2(i, curY)
    if boardSvc:IsValidPiecePos(pos) then
      table.insert(sortBoardList, pos)
    end
  end
  return sortBoardList
end

function BuffLogicSortAI:SortType1(needSortEntityList)
  local canMoveAndAttackList = {}
  local otherList = {}
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  for _, entity in ipairs(needSortEntityList) do
    local pos = entity:GetGridPosition()
    if pos.x == teamPos.x or pos.y == teamPos.y then
      table.insert(canMoveAndAttackList, entity)
    else
      table.insert(otherList, entity)
    end
  end
  for _, entity in ipairs(canMoveAndAttackList) do
    local aiComponent = entity:AI()
    local aiLogicList = aiComponent:GetAILogic(self._aiLogicType)
    for order, aiLogic in pairs(aiLogicList) do
      if aiLogic:GetAIConfigID() == self._sortAIConfigID then
        aiLogic:SetOrderWeight(self._orderWeight)
        aiLogic:SetParallelID(1)
        break
      end
    end
  end
  local sortBoardList = self:BuildSortType1List()
  local count = 1
  for i, pos in ipairs(sortBoardList) do
    for _, entity in ipairs(otherList) do
      local entityPos = entity:GetGridPosition()
      local aiComponent = entity:AI()
      local aiLogicList = aiComponent:GetAILogic(self._aiLogicType)
      for order, aiLogic in pairs(aiLogicList) do
        if aiLogic:GetAIConfigID() == self._sortAIConfigID and entityPos == pos then
          aiLogic:SetOrderWeight(self._orderWeight - count)
          count = count + 1
          aiLogic:SetParallelID(2)
          break
        end
      end
    end
  end
end
