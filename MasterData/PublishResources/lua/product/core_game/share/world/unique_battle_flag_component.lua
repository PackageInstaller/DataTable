_class("BattleFlagsComponent", Object)
BattleFlagsComponent = BattleFlagsComponent

function BattleFlagsComponent:Constructor(world)
  self.flags = {}
  self._frontAndObliqueOffsetDataList = {}
  self._chessTransformationIndex = 0
  self._curseTowerIndex = 1
  self._curseRound = 1
  self._summonMeantimeLimitEntityID = {}
  self._summonOnFixPosLimitEntityIDList = {}
  self._summonOnFixPosLimitIndex = 0
  self._sceneChangeTimes = 0
end

function BattleFlagsComponent:HasFlag(flag)
  return self.flags[flag]
end

function BattleFlagsComponent:AddFlag(flag)
  self.flags[flag] = true
end

function BattleFlagsComponent:RemoveFlag(flag)
  self.flags[flag] = false
end

function BattleFlagsComponent:GetFrontAndObliqueOffsetData(entityID)
  return self._frontAndObliqueOffsetDataList[entityID]
end

function BattleFlagsComponent:SetFrontAndObliqueOffsetData(entityID, dir)
  self._frontAndObliqueOffsetDataList[entityID] = dir
end

function BattleFlagsComponent:GetChessTransformationIndex()
  self._chessTransformationIndex = self._chessTransformationIndex + 1
  return self._chessTransformationIndex
end

function BattleFlagsComponent:GetCurrentCurseTowerIndex()
  return self._curseTowerIndex
end

function BattleFlagsComponent:SetCurrentCurseTowerIndex(index)
  self._curseTowerIndex = index
end

function BattleFlagsComponent:GetCurrentCurseTowerRound()
  return self._curseRound
end

function BattleFlagsComponent:SetCurrentCurseTowerRound(round)
  self._curseRound = round
end

function BattleFlagsComponent:GetSummonMeantimeLimitEntityID(trapID)
  return self._summonMeantimeLimitEntityID[trapID] or {}
end

function BattleFlagsComponent:SetSummonMeantimeLimitEntityID(trapID, entityIDList)
  self._summonMeantimeLimitEntityID[trapID] = entityIDList
end

function BattleFlagsComponent:GetSummonOnFixPosLimitIndex()
  return self._summonOnFixPosLimitIndex
end

function BattleFlagsComponent:SetSummonOnFixPosLimitIndex(index)
  self._summonOnFixPosLimitIndex = index
end

function BattleFlagsComponent:GetSummonOnFixPosLimitEntityID(trapID)
  return self._summonOnFixPosLimitEntityIDList[trapID] or {}
end

function BattleFlagsComponent:SetSummonOnFixPosLimitEntityID(trapID, entityIDList)
  self._summonOnFixPosLimitEntityIDList[trapID] = entityIDList
end

function BattleFlagsComponent:GetSceneChangeTimes()
  return self._sceneChangeTimes
end

function BattleFlagsComponent:AddSceneChangeTimes(num)
  self._sceneChangeTimes = self._sceneChangeTimes + num
end

function MainWorld:BattleFlags()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.BattleFlags)
end

function MainWorld:AddBattleFlags()
  local index = self.BW_UniqueComponentsEnum.BattleFlags
  local com = BattleFlagsComponent:New(self)
  self:SetUniqueComponent(index, com)
end

function MainWorld:HasBattleFlag(flag)
  local com = self:BattleFlags()
  if not com then
    return false
  end
  return com:HasFlag(flag)
end

function MainWorld:AddBattleFlag(flag)
  local index = self.BW_UniqueComponentsEnum.BattleFlags
  local com = self:BattleFlags()
  com = com or BattleFlagsComponent:New(self)
  com:AddFlag(flag)
  self:SetUniqueComponent(index, com)
end

function MainWorld:RemoveBattleFlag(flag)
  local index = self.BW_UniqueComponentsEnum.BattleFlags
  local com = self:BattleFlags()
  if not com then
    return
  end
  com:RemoveFlag(flag)
  self:SetUniqueComponent(index, com)
end
