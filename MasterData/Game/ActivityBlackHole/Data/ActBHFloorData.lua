local ActBHFloorData = class("ActBHFloorData")
local DungeonLevelActBlackHole = require("Game.ActivityBlackHole.Data.DungeonLevelActBlackHole")

function ActBHFloorData:ctor()
end

function ActBHFloorData.CreatActBHFloorData(floorCfg, msg, actData)
  local actBHFloorData = ActBHFloorData.New()
  actBHFloorData:InitBHFloorData(floorCfg, msg, actData)
  return actBHFloorData
end

function ActBHFloorData:InitBHFloorData(floorCfg, msg, actData)
  self._floorCfg = floorCfg
  self._floorNetMsg = msg or {}
  self.actData = actData
  self.highScore = self._floorNetMsg.highScore or 0
  self.isReset = self._floorNetMsg.isReset or false
  self.niceTime = self._floorNetMsg.niceTime or 0
  self.dungeonLevelList = {}
  for i = 1, floorCfg.dungeon_num do
    local msgLevel = self._floorNetMsg.floorLevel and self._floorNetMsg.floorLevel[floorCfg.dungeon_id[i]] or nil
    local data = DungeonLevelActBlackHole.New(floorCfg.dungeon_id[i], msgLevel, self)
    table.insert(self.dungeonLevelList, data)
  end
  self:RecordUnlockState()
end

function ActBHFloorData:UpdateBHFloorData(msg)
  self._floorNetMsg = msg or self._floorNetMsg
  self.highScore = self._floorNetMsg.highScore or 0
  self.niceTime = self._floorNetMsg.niceTime or 0
  self.isReset = self._floorNetMsg.isReset or false
  for i, data in ipairs(self.dungeonLevelList) do
    local msgLevel = self._floorNetMsg.floorLevel and self._floorNetMsg.floorLevel[self._floorCfg.dungeon_id[i]] or nil
    data:UpdateMsgLevel(msgLevel)
  end
end

function ActBHFloorData:RecordUnlockState()
  self._isUnlockState = self:GetFloorDataUnlockState()
end

function ActBHFloorData:GetIsNewUnlock()
  local nowUnlockState = self:GetFloorDataUnlockState()
  local isNewUnlock = self._isUnlockState ~= nowUnlockState
  self._isUnlockState = nowUnlockState
  return isNewUnlock
end

function ActBHFloorData:GetDungeonLevelList()
  return self.dungeonLevelList
end

function ActBHFloorData:GetBHFloorName()
  return self._floorCfg.floor_name
end

function ActBHFloorData:GetBHFloorCfg()
  return self._floorCfg
end

function ActBHFloorData:GetNowScore()
  return self.highScore
end

function ActBHFloorData:GetNowTime()
  return self.niceTime
end

function ActBHFloorData:GetActData()
  return self.actData
end

function ActBHFloorData:GetFloorIsBoss()
  return self._floorCfg.is_boss
end

function ActBHFloorData:GetRejectHeroAndFairyDic(stageId)
  local heroDic = {}
  local fairyDic = {}
  for i, levelData in pairs(self.dungeonLevelList) do
    local tempStageId = levelData:GetDungeonLevelStageId()
    if tempStageId ~= stageId then
      local heroList, fairyData = levelData:GetBlackHolePassTeam()
      if heroList then
        for i, heroElem in pairs(heroList) do
          heroDic[heroElem.heroId] = true
        end
      end
      if fairyData then
        fairyDic[fairyData:GetFairyUID()] = true
      end
    end
  end
  return heroDic, fairyDic
end

function ActBHFloorData:GetFloorDataId()
  return self._floorCfg.floor_id
end

function ActBHFloorData:GetFloorDataUnlockState()
  if self._floorCfg.floor_id == 1 then
    return true
  end
  local lastFloorId = self._floorCfg.floor_id - 1
  local lastFloorData = self.actData:GetBlackHoleFloorData(lastFloorId)
  local num = lastFloorData:GetNowScore()
  if 0 < num then
    return true
  end
  return false, lastFloorData
end

return ActBHFloorData
