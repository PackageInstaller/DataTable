_class("BuffLogicCreateTrap", BuffLogicBase)
BuffLogicCreateTrap = BuffLogicCreateTrap

function BuffLogicCreateTrap:Constructor(buffInstance, logicParam)
  self.trapID = logicParam.trapID
  self.entity = buffInstance:Entity()
  self._buffInstance.trapIDs = {}
  self._newGridCount = logicParam.newGridCount or 0
  self._gridType = logicParam.gridType or nil
  self._priGridType = logicParam.priGridType or nil
  self._ignorePieceTypeCheck = logicParam.ignorePieceTypeCheck == 1
  self._perGridCreateCount = logicParam.perGridCreateCount or nil
  self._blockFlagID = logicParam.blockFlagID
end

function BuffLogicCreateTrap:DoLogic(notify)
  Log.debug("[BuffLogic] create trap: ", self.trapID)
  local world = self._buffInstance:World()
  local notifyType = notify:GetNotifyType()
  local trapEntity
  local eIds = {}
  local pos
  local trapServiceLogic = world:GetService("TrapLogic")
  local randomSvc = self._world:GetService("RandomLogic")
  if notifyType == NotifyType.MonsterMoveOneFinish or notifyType == NotifyType.PlayerFirstMoveEnd then
    local blockFlag = 0
    for _, grid in ipairs(notify:GetCreateTrapGrids()) do
      if trapServiceLogic:CanSummonTrapOnPos(grid, self.trapID, blockFlag) then
        trapEntity = trapServiceLogic:CreateTrap(self.trapID, grid, self.entity:GridLocation():GetGridDir(), false, nil, self.entity)
        if trapEntity then
          table.insert(eIds, trapEntity:GetID())
        end
      end
    end
    pos = notify:GetCreateTrapGrids()
  elseif notifyType == NotifyType.BuffLoad then
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    local pieces = utilScopeSvc:GetEmptyPieces()
    if self._blockFlagID then
      pieces = utilScopeSvc:GetPiecesExcludeBlockID(self._blockFlagID)
    end
    if #pieces < 1 then
      return
    end
    local r = randomSvc:LogicRand(1, #pieces)
    local dropPos = pieces[r]
    if trapServiceLogic:CanSummonTrapOnPos(dropPos, self.trapID) then
      trapEntity = trapServiceLogic:CreateTrap(self.trapID, dropPos, Vector2(0, 1), false, nil, self.entity)
      if trapEntity then
        table.insert(eIds, trapEntity:GetID())
      end
    end
  elseif notifyType == NotifyType.RefreshGridOnPetMoveDone then
    local oldGridList = notify:GetOldChainPathGrid()
    local newGridList = notify:GetNewChainPathGrid()
    local oldPieceCount = 0
    for pos, pieceType in pairs(oldGridList) do
      if pieceType == self._gridType then
        oldPieceCount = oldPieceCount + 1
      end
    end
    local trapCount = math.floor(oldPieceCount / self._newGridCount)
    local usePos = {}
    if 0 < trapCount then
      if self._priGridType then
        for index, v in ipairs(newGridList) do
          if 0 < trapCount then
            if v.pieceType == self._priGridType and trapServiceLogic:CanSummonTrapOnPos(v.pos, self.trapID) then
              trapEntity = trapServiceLogic:CreateTrap(self.trapID, v.pos, Vector2(0, 1), false, nil, self.entity)
              if trapEntity then
                table.insert(eIds, trapEntity:GetID())
                trapCount = trapCount - 1
                usePos[#usePos + 1] = v.pos
              end
            end
          else
            break
          end
        end
      end
      if 0 < trapCount then
        while 0 < trapCount and 0 < #newGridList do
          local index = randomSvc:LogicRand(1, #newGridList)
          local data = newGridList[index]
          if not table.icontains(usePos, data.pos) and trapServiceLogic:CanSummonTrapOnPos(data.pos, self.trapID) then
            trapEntity = trapServiceLogic:CreateTrap(self.trapID, data.pos, Vector2(0, 1), false, nil, self.entity)
            if trapEntity then
              table.insert(eIds, trapEntity:GetID())
              trapCount = trapCount - 1
              usePos[#usePos + 1] = data.pos
            end
          end
          table.remove(newGridList, index)
        end
      end
    else
      return
    end
  elseif notifyType == NotifyType.ResetGridElement then
    local resetGridList = notify:GetResetGridDataList()
    local newTrapCount = math.floor(#resetGridList / self._newGridCount)
    local posList = {}
    for _, data in ipairs(resetGridList) do
      table.insert(posList, Vector2(data.m_nX, data.m_nY))
    end
    if 0 < newTrapCount then
      while 0 < newTrapCount do
        local index = randomSvc:LogicRand(1, #posList)
        local pos = posList[index]
        if trapServiceLogic:CanSummonTrapOnPos(Vector2(pos.x, pos.y), self.trapID) then
          trapEntity = trapServiceLogic:CreateTrap(self.trapID, Vector2(pos.x, pos.y), Vector2(0, 1), false, nil, self.entity)
          if trapEntity then
            table.insert(eIds, trapEntity:GetID())
            table.remove(posList, index)
            newTrapCount = newTrapCount - 1
          end
        end
      end
    else
      return
    end
  elseif notifyType == NotifyType.MonsterDeadStart then
    local entity = notify:GetNotifyEntity()
    local area = entity:BodyArea():GetArea()
    local pos = entity:GetGridPosition()
    local posList = {}
    for _, value in ipairs(area) do
      local wordPos = pos + value
      table.insert(posList, wordPos)
    end
    local index = randomSvc:LogicRand(1, #posList)
    local randPos = posList[index]
    local blockFlag = 0
    if trapServiceLogic:CanSummonTrapOnPos(Vector2(randPos.x, randPos.y), self.trapID, blockFlag) then
      trapEntity = trapServiceLogic:CreateTrap(self.trapID, Vector2(randPos.x, randPos.y), Vector2(0, 1), false, nil, self.entity)
      if trapEntity then
        table.insert(eIds, trapEntity:GetID())
      end
    end
  elseif notifyType == NotifyType.GridConvert then
    local convertInfoArray = notify:GetConvertInfoArray()
    for _, info in ipairs(convertInfoArray) do
      if (self._ignorePieceTypeCheck or info:GetBeforePieceType() ~= info:GetAfterPieceType()) and trapServiceLogic:CanSummonTrapOnPos(info:GetPos(), self.trapID) then
        local e = trapServiceLogic:CreateTrap(self.trapID, info:GetPos(), Vector2.New(0, 1), false, nil, self.entity)
        if e then
          table.insert(eIds, e:GetID())
        end
      end
    end
  elseif notifyType == NotifyType.SuperGridTriggerEnd then
    pos = notify:GetTriggerPos()
    if trapServiceLogic:CanSummonTrapOnPos(pos, self.trapID) then
      trapEntity = trapServiceLogic:CreateTrap(self.trapID, pos, Vector2.up, false, nil, self.entity)
      if trapEntity then
        table.insert(eIds, trapEntity:GetID())
      end
    end
  elseif notifyType == NotifyType.TeamNormalAttackStart then
    local chanPathData = notify:GetChainPath()
    local count = 0
    for index, pos in ipairs(chanPathData) do
      local needSummon = index % self._perGridCreateCount == 0
      if needSummon and trapServiceLogic:CanSummonTrapOnPos(pos, self.trapID) then
        trapEntity = trapServiceLogic:CreateTrap(self.trapID, pos, Vector2(0, 1), false, nil, self.entity)
        if trapEntity then
          table.insert(eIds, trapEntity:GetID())
        end
      end
    end
  end
  local result = BuffResultCreateTrap:New(eIds, pos)
  return result
end
