local WarChessHelper = {}
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local eGridToward = eWarChessEnum.eGridToward
local WarChessBattleRoom = require("Game.WarChess.Data.Battle.WarChessBattleRoom")
WarChessHelper.rotateValue = {
  [eGridToward.up] = Vector3.zero,
  [eGridToward.right] = Vector3.New(0, 90, 0),
  [eGridToward.down] = Vector3.New(0, 180, 0),
  [eGridToward.left] = Vector3.New(0, -90, 0)
}
WarChessHelper.rotate2Move = {
  [eGridToward.up] = Vector2.up,
  [eGridToward.right] = Vector2.right,
  [eGridToward.down] = -Vector2.up,
  [eGridToward.left] = -Vector2.right
}
WarChessHelper.rotateMatrix = {
  [eGridToward.up] = {
    {
      1,
      0,
      0
    },
    {
      0,
      1,
      0
    },
    {
      0,
      0,
      1
    }
  },
  [eGridToward.right] = {
    {
      0,
      1,
      0
    },
    {
      -1,
      0,
      0
    },
    {
      0,
      0,
      1
    }
  },
  [eGridToward.down] = {
    {
      -1,
      0,
      0
    },
    {
      0,
      -1,
      0
    },
    {
      0,
      0,
      1
    }
  },
  [eGridToward.left] = {
    {
      0,
      -1,
      0
    },
    {
      1,
      0,
      0
    },
    {
      0,
      0,
      1
    }
  }
}
WarChessHelper.AStarSearchOrder = {
  [1] = Vector2.up,
  [2] = Vector2.right,
  [3] = -Vector2.up,
  [4] = -Vector2.right
}

function WarChessHelper.GridToward2RotateValue(eGridToward)
  return WarChessHelper.rotateValue[eGridToward]
end

function WarChessHelper.GridToward2RotateMatrix(eGridToward)
  return WarChessHelper.rotateMatrix[eGridToward]
end

function WarChessHelper.GridAreaRotateMatrix(areaData)
  local eGridToward = areaData:GetWCAreaLogicToward()
  local rotateMatrix = table.deepCopy(WarChessHelper.rotateMatrix[eGridToward])
  local width, height = areaData:GetWCAreaSizeXY()
  local x, y = areaData:GetWCAreaLogicPosXY()
  rotateMatrix[1][3] = x
  rotateMatrix[2][3] = y
  if eGridToward == eWarChessEnum.eGridToward.right then
    rotateMatrix[2][3] = rotateMatrix[2][3] + width - 1
  elseif eGridToward == eWarChessEnum.eGridToward.left then
    rotateMatrix[1][3] = rotateMatrix[1][3] + height - 1
  elseif eGridToward == eWarChessEnum.eGridToward.down then
    rotateMatrix[1][3] = rotateMatrix[1][3] + width - 1
    rotateMatrix[2][3] = rotateMatrix[2][3] + height - 1
  end
  return rotateMatrix
end

local sinTab = {
  [eGridToward.up] = 0,
  [eGridToward.right] = 1,
  [eGridToward.down] = 0,
  [eGridToward.left] = -1
}
local cosTab = {
  [eGridToward.up] = 1,
  [eGridToward.right] = 0,
  [eGridToward.down] = -1,
  [eGridToward.left] = 0
}

function WarChessHelper.GenGridInAreaPos(gridPosX, gridPosY, areaData)
  local areaX, areaY = areaData:GetWCAreaLogicPosXY()
  local eGridToward = areaData:GetWCAreaLogicToward()
  local areaSizeX, areaSizeY = areaData:GetWCAreaSizeXY()
  gridPosX, gridPosY = gridPosX - areaX, gridPosY - areaY
  local x, y
  if eGridToward == eWarChessEnum.eGridToward.up then
    x, y = gridPosX, gridPosY
  elseif eGridToward == eWarChessEnum.eGridToward.right then
    x = -gridPosY + (areaSizeX - 1)
    y = gridPosX
  elseif eGridToward == eWarChessEnum.eGridToward.down then
    x = -(gridPosX - (areaSizeX - 1))
    y = -(gridPosY - (areaSizeY - 1))
  elseif eGridToward == eWarChessEnum.eGridToward.left then
    x = gridPosY
    y = -gridPosX + (areaSizeY - 1)
  end
  return x, y
end

local function GetManhattanDis(AGrid, BGrid)
  local logicPosA = AGrid:GetGridLogicPos()
  local logicPosB = BGrid:GetGridLogicPos()
  return math.abs(logicPosA.x - logicPosB.x) + math.abs(logicPosA.y - logicPosB.y)
end

local function SortByGridValue(giridA, giridB)
  return giridA.searchValue < giridB.searchValue
end

function WarChessHelper.AStrarPathFind(mapCtrl, startGrid, endGrid, isMonster, selfEntityData)
  if startGrid == endGrid then
    return true, {endGrid}
  end
  startGrid.searchValue = 0
  local open_set = {startGrid}
  local close_set = {}
  local curGrid
  while 0 < table.count(open_set) do
    table.sort(open_set, SortByGridValue)
    curGrid = table.remove(open_set, 1)
    close_set[curGrid] = true
    if curGrid == endGrid then
      local passGridList = {}
      while curGrid ~= startGrid do
        table.insert(passGridList, curGrid)
        curGrid = curGrid.parentGrid
      end
      if not isMonster then
        local teamData = selfEntityData
        local maxPathLength = teamData:GetCouldWalkLength()
        if maxPathLength ~= nil and maxPathLength < #passGridList then
          return false
        end
      end
      return true, passGridList
    else
      local logicPos = curGrid:GetGridLogicPos()
      for _, dirValue in ipairs(WarChessHelper.AStarSearchOrder) do
        local nearLogicPos = logicPos + dirValue
        local gridData = mapCtrl:GetGridDataByLogicPos(nil, nearLogicPos)
        local entityData = mapCtrl:GetEntityDataByLogicPos(nil, nearLogicPos)
        if not (gridData ~= nil and (entityData == nil or entityData:GetWCEntityCouldPass(isMonster) or entityData == selfEntityData) and gridData:GetCouldPass(isMonster)) or close_set[gridData] ~= nil then
        elseif table.contain(open_set, gridData) then
          local newWaySearchValue = curGrid.searchValue + GetManhattanDis(curGrid, gridData)
          if newWaySearchValue < gridData.searchValue then
            gridData.parentGrid = curGrid
            gridData.searchValue = newWaySearchValue
          end
        else
          gridData.parentGrid = curGrid
          gridData.searchValue = GetManhattanDis(gridData, startGrid) + GetManhattanDis(gridData, endGrid)
          table.insert(open_set, gridData)
        end
      end
    end
  end
  return false
end

function WarChessHelper.BSFAllCouldReachGrid(mapCtrl, startGrid, data, isMonster, isPatrol)
  local curGrid
  local couldReachGridDic = {}
  local waitSearchQueue = {}
  local waitNextSearchQueue = {}
  local searchedDic = {}
  local maxPathLength = data:GetCouldWalkLength()
  local curPathLength = 0
  table.insert(waitSearchQueue, startGrid)
  local couldInetactDic = {}
  local levelNubDic = {}
  local startPos = startGrid:GetGridLogicPos()
  while 0 < #waitSearchQueue or 0 < #waitNextSearchQueue do
    if #waitSearchQueue == 0 then
      local emptyTable = waitSearchQueue
      waitSearchQueue = waitNextSearchQueue
      waitNextSearchQueue = emptyTable
      curPathLength = curPathLength + 1
      if maxPathLength ~= nil and maxPathLength <= curPathLength then
        return couldReachGridDic, couldInetactDic, levelNubDic
      end
    end
    curGrid = table.remove(waitSearchQueue, 1)
    local logicPos = curGrid:GetGridLogicPos()
    for _, dirValue in ipairs(WarChessHelper.AStarSearchOrder) do
      local nearLogicPos = logicPos + dirValue
      local gridData = mapCtrl:GetGridDataByLogicPos(nil, nearLogicPos)
      local coordination = WarChessHelper.Pos2Coordination(nearLogicPos)
      local entityData = mapCtrl:GetEntityDataByLogicPos(nil, nearLogicPos)
      if gridData ~= nil then
        if not isPatrol then
          if (entityData == nil or entityData:GetWCEntityCouldPass(isMonster)) and gridData:GetCouldPass(isMonster) and searchedDic[gridData] == nil then
            table.insert(waitNextSearchQueue, gridData)
          end
          if entityData == nil and gridData:GetCouldStand() then
            local distance = Mathf.Max(Mathf.Abs(startPos.x - nearLogicPos.x), Mathf.Abs(startPos.y - nearLogicPos.y))
            if levelNubDic[distance] == nil then
              levelNubDic[distance] = {}
            end
            levelNubDic[distance][gridData] = true
            couldReachGridDic[gridData] = true
          end
        else
          if gridData:GetCouldPatrol() and searchedDic[gridData] == nil then
            table.insert(waitNextSearchQueue, gridData)
          end
          if gridData:GetCouldPatrol() then
            local distance = Mathf.Max(Mathf.Abs(startPos.x - nearLogicPos.x), Mathf.Abs(startPos.y - nearLogicPos.y))
            if levelNubDic[distance] == nil then
              levelNubDic[distance] = {}
            end
            levelNubDic[distance][gridData] = true
            couldReachGridDic[gridData] = true
          end
        end
        searchedDic[gridData] = true
        couldInetactDic[coordination] = true
      end
    end
  end
  return couldReachGridDic, couldInetactDic, levelNubDic
end

function WarChessHelper.DFSCondUnit(condUnit, condId)
  if condUnit.e and condUnit.e.cat == condId then
    return condUnit.e.pms
  end
  local orResult = false
  if condUnit.o then
    for i, v in pairs(condUnit.o.data) do
      orResult = WarChessHelper.DFSCondUnit(v, condId)
      if orResult then
        break
      end
    end
  end
  local andResult = false
  if condUnit.a then
    for i, v in pairs(condUnit.a.data) do
      andResult = WarChessHelper.DFSCondUnit(v, condId)
      if andResult then
        break
      end
    end
  end
  return orResult or andResult
end

function WarChessHelper.Vector3MoveToward(current, target, maxDistanceDelta)
  local a = target - current
  local magnitude = a:Magnitude()
  if maxDistanceDelta >= magnitude then
    return target
  end
  return current + a * (maxDistanceDelta / magnitude)
end

function WarChessHelper.Coordination2Pos(coordination)
  local x = coordination & CommonUtil.UInt16Max
  local y = coordination >> 16
  return x, y
end

function WarChessHelper.Pos2Coordination(pos)
  return WarChessHelper.PosXy2Coordination(pos.x, pos.y)
end

function WarChessHelper.PosXy2Coordination(x, y)
  local coordination = y << 16 | x
  return coordination
end

function WarChessHelper.IsPointInRect(view, x, y)
  if view == nil then
    return false
  end
  if x < view.xMin or x > view.xMax or y < view.yMin or y > view.yMax then
    return false
  end
  return true
end

local function __WCCoinSort(itemCfg1, itemCfg2)
  local id1 = itemCfg1.id
  local id2 = itemCfg2.id
  local s1 = ConstWCShowCoin[id1]
  local s2 = ConstWCShowCoin[id2]
  return s1 < s2
end

function WarChessHelper.WCCoinSort(coinRewardList)
  if coinRewardList == nil then
    return
  end
  table.sort(coinRewardList, __WCCoinSort)
end

function WarChessHelper.OpenWCChipBag(teamData, closeCallback)
  local warchessMain = UIManager:GetWindow(UIWindowTypeID.WarChessMain)
  if warchessMain == nil then
    return false
  end
  local playNode = warchessMain:GetWCPlayNode()
  if playNode == nil then
    return false
  end
  return playNode:OpenWCTeamChipBag(teamData, closeCallback)
end

function WarChessHelper.GetChipReturnMoney(dynPlayer, chipId, count)
  local haveChipData = dynPlayer.chipDic[chipId]
  if haveChipData ~= nil and not haveChipData:IsConsumeSkillChip() then
    local maxLevel = haveChipData:GetChipMaxLevel()
    local overflowCount = haveChipData:GetCount() + count - maxLevel
    overflowCount = math.min(overflowCount, maxLevel)
    if 0 < overflowCount then
      local shopId = WarChessManager:GetWCLevelShopId()
      local shopCoinCfg = ConfigData.warchess_shop_coin[shopId]
      if shopCoinCfg == nil then
        return 0
      end
      local moneyReturn = shopCoinCfg.function_over_payback[overflowCount]
      return moneyReturn or 0
    end
  end
  return 0
end

function WarChessHelper.CheckEnemyCanMove(entityData)
  local hasCorrectEventType = false
  if #entityData.unitCfg.triggers > 0 then
    for index, v in pairs(entityData.unitCfg.triggers) do
      if v.trigger.cat == eWarChessEnum.eTriggerType.enemyPursueAtk then
        if v ~= nil and v.trigger ~= nil and v.eventType ~= nil then
          for _, vEventType in pairs(v.eventType) do
            if vEventType == eWarChessEnum.eTriggerConditionType.turnStart or vEventType == eWarChessEnum.eTriggerConditionType.turnEnd then
              hasCorrectEventType = true
              break
            end
          end
          for _, vCustomEvent in pairs(v.customTag) do
            if 22 <= vCustomEvent and vCustomEvent <= 31 then
              hasCorrectEventType = true
              break
            end
          end
        end
        if hasCorrectEventType then
          local moveAbility = v.trigger.pms[1]
          return true, moveAbility
        end
      end
    end
  end
  return false, 0
end

function WarChessHelper.AcquireOutSideBoxReward(triggers, WarChesGlobalData)
  local rewardDic
  for i, trigger in ipairs(triggers) do
    if trigger.cat == eWarChessEnum.eTriggerType.OutsideItem then
      local boxId = trigger.pms[1]
      if not WarChesGlobalData:IsReceivedOutsideItemBox(boxId) then
        local rewardIds, rewardNums = WarChesGlobalData:GetOutSideBoxReward(boxId)
        if rewardIds ~= nil then
          if rewardDic == nil then
            rewardDic = {}
          end
          for i, itemId in ipairs(rewardIds) do
            local num = rewardDic[itemId] or 0
            rewardDic[itemId] = num + rewardNums[i]
          end
        end
        WarChesGlobalData:SetOutsideItemBoxReceive(boxId)
      end
    end
  end
  if rewardDic ~= nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CommonRewardData = require("Game.CommonUI.CommonRewardData")
      local CRData = CommonRewardData.CreateCRDataUseDic(rewardDic):SetCRNotHandledGreat(true)
      window:AddAndTryShowReward(CRData)
    end)
  end
end

function WarChessHelper.WCJumpChessType2HeadIconId(numericValue)
  local WarChessJumpCtrl = require("Game.WarChess.Ctrl.SubSystemCtrl.WarChessJumpCtrl")
  local jumpTable = WarChessJumpCtrl.jumpDiffTable[WarChessJumpCtrl.eJumpType.chess]
  return jumpTable.headIconIds[numericValue]
end

function WarChessHelper.GetRandomRotate(min, max)
  if min == nil or max == nil then
    return nil
  end
  local angle = math.random(min, max)
  return Quaternion.Euler(0, angle + 180, 0)
end

function WarChessHelper.CalWCRoomBattlePower(monsters, teamData)
  local fakeBattleRoom = WarChessBattleRoom.New()
  fakeBattleRoom.battleMap = CS.BattleUtility.GenBattleMap(7, 5, 3, 5, 100)
  fakeBattleRoom:__InitMonsterOrNeutralData(monsters)
  local fightingPower = 0
  for k, dynMonster in pairs(fakeBattleRoom.monsterList) do
    fightingPower = fightingPower + dynMonster:GetFightingPower()
  end
  print("战斗力为:" .. tostring(fightingPower))
  return fightingPower
end

return WarChessHelper
