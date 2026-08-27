local BaseBattleRoom = require("Game.Common.Data.BaseBattleRoom")
local DynEpRoomData = class("DynEpRoomData", BaseBattleRoom)
local CS_BattleUtility = CS.BattleUtility
local ChipData = require("Game.PlayerData.Item.ChipData")
local ItemData = require("Game.PlayerData.Item.ItemData")
local DynBuff = require("Game.Exploration.Data.DynBuff")
local ChoiceData = require("Game.Exploration.Data.DynEpEntChoiceData")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function DynEpRoomData:ctor(x, y, type, position, hidden, cross, mode)
  self.x = x
  self.y = y
  self.type = type
  self.mode = mode
  self.position = position or y << 16 | x
  self.hidden = hidden
  self.visible = not hidden
  self.isCrossRoom = cross or false
  self.monsterList = {}
  self.neutralList = {}
end

function DynEpRoomData:SetMapData(map, epOp)
  self.mapData = map
  if epOp and self.position == epOp.curPostion then
    self.jumpCat = epOp.jumpCat
  end
  if (self:IsBattleRoom() or self.type == ExplorationEnum.eRoomType.deploy) and self.battleMap == nil then
    self:GenerateBattleMap()
  end
end

function DynEpRoomData:SetEpRoomTagData(tagData)
  self.tagData = {}
  self.tagData.param1 = tagData.param1
  self.tagData.tagId = tagData.tagCatId
  local tagCfg = ConfigData.room_label[tagData.tagCatId]
  if tagCfg == nil then
    return
  end
  self.tagData.tagCat = tagCfg.tag
end

function DynEpRoomData:GetEpRoomTagCat()
  if self.tagData == nil then
    return 0
  end
  return self.tagData.tagCat
end

function DynEpRoomData:GetEpWormholeRoomTargetPos()
  if not self:IsWormholeRoom() then
    return 0
  end
  return self.tagData.param1[1]
end

function DynEpRoomData:SetEpRoomEpOpStateChanged(EpOp)
  if not EpOp or EpOp.curPostion ~= self.position then
    return
  end
  if EpOp.jumpCat and EpOp.jumpCat > 0 then
    self.jumpCat = EpOp.jumpCat
    if (self:IsBattleRoom() or self.type == ExplorationEnum.eRoomType.deploy) and self.battleMap == nil then
      self:GenerateBattleMap()
    end
  end
end

function DynEpRoomData:GenerateBattleMap()
  local size_row, size_col, deploy_rows, grid_scale_factor = self.mapData:GetBattleFieldSize()
  local benchCount = ConfigData.game_config.battleMap_bench_count
  if self:IsInTDBattle() then
    benchCount = 0
  end
  self.battleMap = CS_BattleUtility.GenBattleMap(size_row, size_col, deploy_rows, benchCount, grid_scale_factor)
  self.battleMap.IsDeployRoom = self.type == ExplorationEnum.eRoomType.deploy
end

function DynEpRoomData:GetSceneId()
  return self.mapData.sceneCfg.id
end

function DynEpRoomData:GetTagData()
  return self.tagData
end

function DynEpRoomData:IsMaxWidthCol()
  return self.mapData:GetMapColType(self.x).isMaxWidthCol
end

function DynEpRoomData:IsEndColRoom()
  return self.x == self.mapData.maxMapColNumber
end

function DynEpRoomData:InitBattleData(monsterGroup)
  self.battleId = monsterGroup.battleId
  self.dungeonType = monsterGroup.dungeonType
  self.crazyTime = monsterGroup.crazyTime
  if self.battleMap == nil then
    self:GenerateBattleMap()
  end
  self:TryInitSpecailDeployGrid(monsterGroup.specialDeployId, monsterGroup.redeploy)
  self:__InitMonsterOrNeutralData(monsterGroup.roleGroup)
  self:__InitBattleGrid(monsterGroup.grids)
  self.chipPreview = monsterGroup.algShow
  self.rewardChipList = {}
  if monsterGroup.alg ~= nil then
    for k, v in ipairs(monsterGroup.alg) do
      local chipData = ChipData.NewChipForServer(v)
      self.rewardChipList[k] = chipData
    end
  end
  self.monsterChipList = {}
  if monsterGroup.monsterAlg ~= nil then
    for k, v in ipairs(monsterGroup.monsterAlg) do
      local chipData = ChipData.NewChipForServer(v)
      self.monsterChipList[k] = chipData
    end
  end
  self.refreshAlgCntAfterBattle = monsterGroup.refreshAlgCnt
  self._spbattleReward = monsterGroup.spbattleReward
  self._spbattleRewardId = monsterGroup.spbattleRewardId
end

function DynEpRoomData:InitRoomRewardGroup(rewards)
  self.rewardList = {}
  if rewards ~= nil then
    for k1, elem in ipairs(rewards.data) do
      for i = 1, elem.stacking do
        local itemData = ItemData.New(elem.id, elem.num)
        local pos = math.random(1, #self.rewardList + 1)
        table.insert(self.rewardList, pos, itemData)
      end
    end
    self.rewardExtraDic = rewards.extra
    self.rewardBuffDic = rewards.buff
  end
end

function DynEpRoomData:InitTreasureRoomData(treasureGroup)
  if treasureGroup == nil then
    error("DynEpRoomData:InitTreasureRoomData error:treasureGroup is nil")
    return
  end
  self.treasureData = {}
  local boxId
  self.treasureData.boxId = treasureGroup.boxId
  self.treasureData.logic = treasureGroup.logic
  self.treasureData.freshCnt = treasureGroup.freshCnt
  self.treasureData.chipDatas = {}
  if treasureGroup.data ~= nil then
    for k, v in pairs(treasureGroup.data) do
      local Data = {}
      Data.data = ChipData.NewChipForServer(v.id)
      local state
      if v.state == ChipEnum.eChipSelectState.StateNone then
        state = false
      elseif v.state == ChipEnum.eChipSelectState.StateSelected then
        state = true
      else
        error("DynEpRoomData:InitTreasureRoomData error:treasureGroup.data.state is nil")
        break
      end
      Data.state = state
      Data.idx = k - 1
      table.insert(self.treasureData.chipDatas, Data)
    end
    MsgCenter:Broadcast(eMsgEventId.OnTreasureRoomUpdate, self)
  end
end

function DynEpRoomData:InitStoreRoomData(storeGroup)
  if storeGroup == nil then
    error("DynEpRoomData:InitStoreRoomData error:storeGroup is nil")
    return
  end
  self.storeRoomData = {}
  self.storeRoomData.currencyId = storeGroup.currency
  self.storeRoomData.storeId = storeGroup.storeId
  self.storeRoomData.refreshTimes = storeGroup.refreshTimes
  self.storeRoomData.extraFetterFreeRefreshTimes = storeGroup.freeRefreshTimes
  self.storeRoomData.discCountLimitTimes = storeGroup.discCountLimitTimes
  self.storeRoomData.data = {}
  if storeGroup.data ~= nil then
    for idx, elem in ipairs(storeGroup.data) do
      local storeData = {}
      storeData.idx = idx
      storeData.id = elem.id
      storeData.discount = elem.discount
      storeData.saled = elem.saled
      local itemId, level = ExplorationManager.ChipServerIdConvert(elem.id)
      local chipCfg = ConfigData.chip[itemId]
      if chipCfg == nil then
        error("Can't find chip cfg, id = " .. tostring(itemId))
      else
        if chipCfg.type == ChipEnum.eChipType.Buff then
          local buffData = DynBuff.CreateByEpBuffId(chipCfg.buff_id)
          buffData:InitDynEpBuffItemId(itemId, level)
          storeData.epBuffData = buffData
        else
          local chipData = ChipData.NewChipForServer(elem.id)
          storeData.chipData = chipData
        end
        table.insert(self.storeRoomData.data, storeData)
      end
    end
    MsgCenter:Broadcast(eMsgEventId.OnStoreRoomUpdate, self)
  end
end

function DynEpRoomData:GetEpStoreRoomRefreshTimes()
  local refreshTimes = self.storeRoomData.refreshTimes
  refreshTimes = math.max(refreshTimes - ExplorationManager:GetDynPlayer():GetEpFreshStoreFreeNumExtra(), 0)
  return refreshTimes
end

function DynEpRoomData:InitEventAndRecoveryRoomData(eventGroup, jumpCat)
  if eventGroup == nil then
    error("DynEpRoomData:InitEventAndRecoveryRoomData error:eventGroup is nil")
    return
  end
  eventGroup.choiceDatalist = {}
  local isHaveRandom = false
  for index, value in ipairs(eventGroup.data) do
    local data = ChoiceData.CreateChoiceData(index - 1, value)
    if data.isRandom then
      isHaveRandom = true
    end
    table.insert(eventGroup.choiceDatalist, data)
  end
  eventGroup.data = nil
  eventGroup.isHaveRandom = isHaveRandom
  eventGroup.eRoomType = self.type
  self.eventData = eventGroup
  if jumpCat == nil or jumpCat == 0 then
    MsgCenter:Broadcast(eMsgEventId.OnEventAndRecoveryRoomUpdate, self)
  end
end

function DynEpRoomData:InitResetRoomData(resetRoomGroup)
  if resetRoomGroup == nil then
    error("DynEpRoomData:InitResetRoomData error:resetGroup is nil")
    return
  end
  self.roomRecordList = {}
  self.roomRecordList = resetRoomGroup.record
  MsgCenter:Broadcast(eMsgEventId.OnResetRoomUpdate, self)
end

function DynEpRoomData:InitEpExRoomData(epExRoom)
  self.epExRoomData = epExRoom
  MsgCenter:Broadcast(eMsgEventId.OnEpExRoomUpdate, self)
end

function DynEpRoomData:InitEpBuffEffective(data)
  self.epBuffEffective = data
end

function DynEpRoomData:GetEpBuffEffective(dynPlayer)
  local curRoomActiveBuff = {}
  if self:IsBattleRoom() then
    local epBuffList = dynPlayer:GetEpBuffList()
    for _, epBuff in pairs(epBuffList) do
      local buffCfg = epBuff:GetBuffCfg()
      if buffCfg.tigger_type == 2 then
        if buffCfg.is_battleShow then
          table.insert(curRoomActiveBuff, buffCfg)
        end
        if #curRoomActiveBuff >= ConfigData.game_config.epBuffShowMax then
          break
        end
      end
    end
  end
  if self.epBuffEffective ~= nil then
    for buffId, count in pairs(self.epBuffEffective) do
      if #curRoomActiveBuff >= ConfigData.game_config.epBuffShowMax then
        break
      end
      local buffCfg = ConfigData.exploration_buff[buffId]
      if buffCfg == nil then
        error("exploration buff cfg is null,id:" .. tostring(buffId))
      else
        local i = 1
        while count >= i and #curRoomActiveBuff < ConfigData.game_config.epBuffShowMax do
          if buffCfg.is_battleShow then
            table.insert(curRoomActiveBuff, buffCfg)
          end
          i = i + 1
        end
      end
    end
  end
  if #curRoomActiveBuff == 0 then
    return nil
  end
  table.sort(curRoomActiveBuff, function(b1, b2)
    return b1.id < b2.id
  end)
  return curRoomActiveBuff
end

function DynEpRoomData:IsCanMove()
  if self:GetEpRoomTagCat() == ExplorationEnum.eRoomTag.MoveStop then
    return false
  end
  return true
end

function DynEpRoomData:IsWormholeRoom()
  if self:GetEpRoomTagCat() == ExplorationEnum.eRoomTag.Wormhole then
    return true
  end
  return false
end

function DynEpRoomData:GetNextRoom()
  if self:IsEpSpecialRoom() then
    warn("EpSpecialRoom hasn't next room.")
    return
  end
  local couldSelectAnyNextRoom = ExplorationManager:GetDynPlayer():IsHaveSpecificTypeBuff(ExplorationEnum.eBuffLogicId.freeSelectRoom)
  if couldSelectAnyNextRoom then
    return self:GetNextAllRoom() or {}
  end
  if self.nextRooms ~= nil then
    return self.nextRooms
  end
  self.nextRooms = {}
  local colTrackType = self.mapData:GetMapColTrackType(self.x)
  if colTrackType == ExplorationEnum.eTrackLineType.EndTrack then
    return self.nextRooms
  end
  if colTrackType == ExplorationEnum.eTrackLineType.ReverseETrack or colTrackType == ExplorationEnum.eTrackLineType.SingleTrack then
    local nextRoomData = self.mapData:GetRoomByXY(self.x + 1, 0)
    table.insert(self.nextRooms, nextRoomData)
    return self.nextRooms
  end
  if colTrackType == ExplorationEnum.eTrackLineType.NormalETrack then
    for k, room in pairs(self.mapData.roomMap[self.x + 1]) do
      table.insert(self.nextRooms, room)
    end
    return self.nextRooms
  end
  local tx = self.x + 1
  local ty = self.y
  local tmpRoom = self.mapData:GetRoomByXY(tx, ty)
  if tmpRoom ~= nil then
    table.insert(self.nextRooms, tmpRoom)
  end
  if self:IsMaxWidthCol() then
    ty = self.y - 1
  else
    ty = self.y + 1
  end
  tmpRoom = self.mapData:GetRoomByXY(tx, ty)
  if tmpRoom ~= nil then
    table.insert(self.nextRooms, tmpRoom)
  end
  return self.nextRooms
end

function DynEpRoomData:GetLastRoom()
  if self.lastRooms ~= nil then
    return self.lastRooms
  end
  self.lastRooms = {}
  if self.x == 0 then
    return self.lastRooms
  end
  local lastColTrackType = self.mapData:GetMapColTrackType(self.x - 1)
  if lastColTrackType == ExplorationEnum.eTrackLineType.NormalETrack or lastColTrackType == ExplorationEnum.eTrackLineType.SingleTrack then
    table.insert(self.lastRooms, self.mapData:GetRoomByXY(self.x - 1, 0))
    return self.lastRooms
  end
  if lastColTrackType == ExplorationEnum.eTrackLineType.ReverseETrack then
    for k, room in pairs(self.mapData.roomMap[self.x - 1]) do
      table.insert(self.lastRooms, room)
    end
    return self.lastRooms
  end
  local tx = self.x - 1
  local ty = self.y
  local tmpRoom = self.mapData:GetRoomByXY(tx, ty)
  if tmpRoom ~= nil then
    table.insert(self.lastRooms, tmpRoom)
  end
  if self:IsMaxWidthCol() then
    ty = self.y - 1
  else
    ty = self.y + 1
  end
  tmpRoom = self.mapData:GetRoomByXY(tx, ty)
  if tmpRoom ~= nil then
    table.insert(self.lastRooms, tmpRoom)
  end
  return self.lastRooms
end

function DynEpRoomData:GetNextDownDirRoom()
  local colTrackType = self.mapData:GetMapColTrackType(self.x)
  if colTrackType ~= ExplorationEnum.eTrackLineType.NormalYTrack then
    return nil
  end
  local tx = self.x + 1
  local ty = self.y
  if self:IsMaxWidthCol() then
    ty = ty - 1
  end
  local tmpRoom = self.mapData:GetRoomByXY(tx, ty)
  return tmpRoom
end

function DynEpRoomData:GetNextUpDirRoom()
  local colTrackType = self.mapData:GetMapColTrackType(self.x)
  if colTrackType ~= ExplorationEnum.eTrackLineType.NormalYTrack then
    return nil
  end
  local tx = self.x + 1
  local ty = self.y
  if not self:IsMaxWidthCol() then
    ty = ty + 1
  end
  local tmpRoom = self.mapData:GetRoomByXY(tx, ty)
  return tmpRoom
end

function DynEpRoomData:GetNextParallelRoom()
  local colTrackType = self.mapData:GetMapColTrackType(self.x)
  if colTrackType ~= ExplorationEnum.eTrackLineType.SingleTrack then
    return nil
  end
  local tmpRoom = self.mapData:GetRoomByXY(self.x + 1, self.y)
  return tmpRoom
end

function DynEpRoomData:GetNextAllRoom()
  local tmpRooms = self.mapData:GetRoomsByX(self.x + 1)
  return tmpRooms
end

function DynEpRoomData:IsBattleRoom(epOp)
  if epOp ~= nil and self.position == epOp.curPostion and epOp.jumpCat ~= nil and epOp.jumpCat > 0 then
    self.jumpCat = epOp.jumpCat
  end
  local roomLogicType = self:GetRoomLogicType()
  return roomLogicType == ExplorationEnum.eRoomLogicType.battle
end

function DynEpRoomData:IsDeployRoom()
  return self.type == ExplorationEnum.eRoomType.deploy
end

function DynEpRoomData:IsStartRoom()
  return self.type == ExplorationEnum.eRoomType.start
end

function DynEpRoomData:IsHiddenRoom()
  return self.hidden
end

function DynEpRoomData:SetVisible(visible)
  self.visible = visible
end

function DynEpRoomData:GetVisible()
  return self.visible
end

function DynEpRoomData:IsCrossRoom()
  return self.isCrossRoom
end

function DynEpRoomData:GetTotalFightingPower()
  if not self:IsBattleRoom() then
    return 0
  end
  local fightingPower = 0
  for k, dynMonster in pairs(self.monsterList) do
    fightingPower = fightingPower + dynMonster:GetFightingPower()
  end
  return fightingPower
end

function DynEpRoomData:GetMonsterList()
  return self.monsterList
end

function DynEpRoomData:GetRewardChipList()
  return self.rewardChipList
end

function DynEpRoomData:GetRoomPosition()
  return self.position
end

function DynEpRoomData:IsBossRoom()
  return self.type == ExplorationEnum.eRoomType.boss
end

function DynEpRoomData:IsRealBossRoom()
  return self == self.mapData:GetRealBossRoom()
end

function DynEpRoomData:IsHideBossRoom()
  return self:IsBossRoom() and not self:IsRealBossRoom()
end

function DynEpRoomData:GetRoomChipPreview()
  return self.chipPreview or 0
end

function DynEpRoomData:GetMosterChipList()
  return self.monsterChipList
end

function DynEpRoomData:GetRoomType(isJustDefaultType)
  local roomType = self.type
  if not isJustDefaultType and self.jumpCat ~= nil and self.jumpCat > 0 then
    roomType = self.jumpCat
  end
  return roomType
end

function DynEpRoomData:GetRoomTypeCfg()
  local roomTypeCfg = ConfigData.exploration_roomtype[self:GetRoomType()]
  if roomTypeCfg == nil then
    return nil
  end
  return roomTypeCfg
end

function DynEpRoomData:GetRoomLogicType()
  local roomTypeCfg = self:GetRoomTypeCfg()
  if roomTypeCfg == nil then
    return nil
  end
  return roomTypeCfg.real_logic
end

function DynEpRoomData:ResetJumpCat()
  self.jumpCat = nil
end

function DynEpRoomData:SetAmbushAndSneakData(ambushData, stealthData)
  if (ambushData ~= 0 or stealthData ~= 0) and (self.ambushData ~= ambushData or self.stealthData ~= stealthData) then
    self.ambushData = ambushData
    self.stealthData = stealthData
    MsgCenter:Broadcast(eMsgEventId.OnBeforeBattleRandomDataChange, ambushData, stealthData, self:GetRoomPosition())
  end
end

function DynEpRoomData:GetAmbushAndSneakData()
  return self.ambushData, self.stealthData
end

function DynEpRoomData:GetIsInBigBossRoom()
  return self.mode == 5
end

function DynEpRoomData:IsEpSpecialRoom()
  return self.position == proto_object_EplSpecialPosition.EplSpecialPositionInit
end

function DynEpRoomData:SetEpRoomType(type)
  if 0 < type then
    self.type = type
  else
    self.type = nil
  end
end

function DynEpRoomData:IsInTDBattle()
  return self.mapData.epMapLogic == ExplorationEnum.eMapLogic.TowerDefence
end

function DynEpRoomData:IsGuardTDBattle()
  return self.mapData.epMapLogic == ExplorationEnum.eMapLogic.Guard
end

function DynEpRoomData:IsBrotatoBattle()
  return self.mapData.epMapLogic == ExplorationEnum.eMapLogic.Brotato
end

function DynEpRoomData:IsRoomHasSpbattleReward()
  return self._spbattleReward, self._spbattleRewardId
end

function DynEpRoomData:ClearEpRoomData()
  self.occupyCoords = nil
  self.battleMap = nil
  self.monsterList = nil
  self.rewardChipList = nil
  self.rewardList = nil
  self.monsterChipList = nil
  self.effectGridList = nil
  self.refreshAlgCntAfterBattle = nil
  self.treasureData = nil
  self.storeRoomData = nil
  self.eventData = nil
  self.roomRecordList = nil
  self.ambushData = nil
  self.stealthData = nil
  self.epBuffEffective = nil
  self.epExRoomData = nil
  self.tagData = nil
end

return DynEpRoomData
