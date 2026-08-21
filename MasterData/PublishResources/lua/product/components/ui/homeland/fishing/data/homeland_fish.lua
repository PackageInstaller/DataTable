_class("HomelandFish", Object)
HomelandFish = HomelandFish

function HomelandFish:Constructor(fishId)
  self._fishItemId = fishId
  local cfg = Cfg.cfg_item_homeland_fish[fishId]
  cfg = cfg or Cfg.cfg_item_wishing_coin[fishId]
  if not cfg then
    Log.fatal("随机的鱼的ID错误：", fishId)
  end
  local fishingOperator = cfg.FishingOperator
  self._fishPowerLargeRange = fishingOperator[1]
  self._rightPowerRange = fishingOperator[2]
  self._playerPowerLargeRange = fishingOperator[3]
  self._decouplingTime = cfg.DecouplingTime / 1000
  self._lineBreakTime = cfg.LineBreakTime / 1000
  if cfg.MoveRang then
    self._moveRange = cfg.MoveRange / 1000
  else
    self._moveRange = 1
  end
  if self._moveSpeed then
    self._moveSpeed = cfg.MoveSpeed / 1000
  else
    self._moveSpeed = 1
  end
  self._fishPowerSpeed = cfg.FishPowerSpeed
  self._fishRacePowerSpeed = cfg.FishRacePowerSpeed
  self._fishInvitePowerSpeed = cfg.FishInvitePowerSpeed
  self._model = cfg.FishEffect
  self._fishingOldOperator = cfg.FishingOldOperator
  Log.fatal("鱼id", fishId)
  if cfg == Cfg.cfg_item_homeland_fish[fishId] then
    self._fishingRaceOperator = cfg.FishingRaceOperator
    self._fishingInvitOperator = cfg.FishingInvitOperator
    local fishingOperatorRace = cfg.RaceType
    if fishingOperatorRace ~= nil then
      self._fishPowerLargeRangeRace = fishingOperatorRace[1]
      self._rightPowerRangeRace = fishingOperatorRace[2]
      self._playerPowerLargeRangeRace = fishingOperatorRace[3]
    end
    local fishingOperatorInvite = cfg.InviteType
    if fishingOperatorInvite ~= nil then
      self._fishPowerLargeRangeInvite = fishingOperatorInvite[1]
      self._rightPowerRangeInvite = fishingOperatorInvite[2]
      self._playerPowerLargeRangeInvite = fishingOperatorInvite[3]
    end
  elseif cfg == Cfg.cfg_item_wishing_coin[fishId] then
    local fishingOperator = cfg.FishingOperator
    self._fishPowerLargeRangeRace = fishingOperator[1]
    self._rightPowerRangeRace = fishingOperator[2]
    self._playerPowerLargeRangeRace = fishingOperator[3]
    self._fishPowerLargeRangeInvite = fishingOperator[1]
    self._rightPowerRangeInvite = fishingOperator[2]
    self._playerPowerLargeRangeInvite = fishingOperator[3]
  end
end

function HomelandFish:GetModel()
  return self._model
end

function HomelandFish:GetFishPowerSpeed(time)
  if self._fishPowerSpeed == nil or #self._fishPowerSpeed <= 0 then
    return -1
  end
  for i = 1, #self._fishPowerSpeed do
    local tmp = self._fishPowerSpeed[i]
    if time >= tmp.range[1] and time <= tmp.range[2] then
      return tmp.value / 1000
    end
  end
  return self._fishPowerSpeed[#self._fishPowerSpeed].value / 1000
end

function HomelandFish:GetRaceFishPowerSpeed(time)
  if self._fishRacePowerSpeed == nil or #self._fishRacePowerSpeed <= 0 then
    return -1
  end
  for i = 1, #self._fishRacePowerSpeed do
    local tmp = self._fishRacePowerSpeed[i]
    if time >= tmp.range[1] and time <= tmp.range[2] then
      return tmp.value / 1000
    end
  end
  return self._fishRacePowerSpeed[#self._fishRacePowerSpeed].value / 1000
end

function HomelandFish:GetInviteFishPowerSpeed(time)
  if self._fishInvitePowerSpeed == nil or #self._fishInvitePowerSpeed <= 0 then
    return -1
  end
  for i = 1, #self._fishInvitePowerSpeed do
    local tmp = self._fishInvitePowerSpeed[i]
    if time >= tmp.range[1] and time <= tmp.range[2] then
      return tmp.value / 1000
    end
  end
  return self._fishInvitePowerSpeed[#self._fishInvitePowerSpeed].value / 1000
end

function HomelandFish:GetItemId()
  return self._fishItemId
end

function HomelandFish:GetDecouplingTime()
  return self._decouplingTime
end

function HomelandFish:GetLineBreakTime()
  return self._lineBreakTime
end

function HomelandFish:GetPowerRange()
  return 0, self._fishPowerLargeRange + self._rightPowerRange + self._playerPowerLargeRange
end

function HomelandFish:GetRacePowerRange()
  return 0, self._fishPowerLargeRangeRace + self._rightPowerRangeRace + self._playerPowerLargeRangeRace
end

function HomelandFish:GetInvitePowerRange()
  return 0, self._fishPowerLargeRangeInvite + self._rightPowerRangeInvite + self._playerPowerLargeRangeInvite
end

function HomelandFish:GetRightPowerRange()
  return self._fishPowerLargeRange, self._fishPowerLargeRange + self._rightPowerRange
end

function HomelandFish:GetRaceRightPowerRange()
  return self._fishPowerLargeRangeRace, self._fishPowerLargeRangeRace + self._rightPowerRangeRace
end

function HomelandFish:GetInviteRightPowerRange()
  return self._fishPowerLargeRangeInvite, self._fishPowerLargeRangeInvite + self._rightPowerRangeInvite
end

function HomelandFish:GetMoveRange()
  return self._moveRange
end

function HomelandFish:GetMoveSpeed()
  return self._moveSpeed
end

function HomelandFish:GetGameMoveSpeed(type, n)
  if type == 3 then
    if self._fishingRaceOperator == nil then
      return nil
    else
      if n <= #self._fishingRaceOperator then
        self._moveSpeed = self._fishingRaceOperator[n][1]
      else
        self._moveSpeed = 0
      end
      return self._moveSpeed / 100
    end
  elseif type == 5 then
    if self._fishingInvitOperator == nil then
      return nil
    else
      if n <= #self._fishingInvitOperator then
        self._moveSpeed = self._fishingInvitOperator[n][1]
      else
        self._moveSpeed = 0
      end
      return self._moveSpeed / 100
    end
  elseif type == 6 or type == 1 then
    if self._fishingOldOperator == nil then
      return nil
    else
      if n <= #self._fishingOldOperator then
        self._moveSpeed = self._fishingOldOperator[n][1]
      else
        self._moveSpeed = 0
      end
      return self._moveSpeed / 100
    end
  end
end

function HomelandFish:GetMoveTime(type, n)
  if type == 3 then
    if self._fishingRaceOperator == nil then
      return nil
    else
      if n <= #self._fishingRaceOperator then
        self._moveTime = self._fishingRaceOperator[n][2]
      else
        self._moveTime = 0
      end
      return self._moveTime
    end
  elseif type == 5 then
    if self._fishingInvitOperator == nil then
      return nil
    else
      if n <= #self._fishingInvitOperator then
        self._moveTime = self._fishingInvitOperator[n][2]
      else
        self._moveTime = 0
      end
      return self._moveTime
    end
  elseif type == 6 or type == 1 then
    if self._fishingOldOperator == nil then
      return nil
    else
      if n <= #self._fishingOldOperator then
        self._moveTime = self._fishingOldOperator[n][2]
      else
        self._moveTime = 0
      end
      return self._moveTime
    end
  end
  return self._moveTime
end

function HomelandFish:GetChangeLength(type, n)
  if type == 3 then
    if self._fishingRaceOperator == nil then
      return nil
    else
      if n <= #self._fishingRaceOperator then
        self._changeLength = self._fishingRaceOperator[n][3]
      else
        self._changeLength = 0
      end
      return self._changeLength
    end
  elseif type == 5 then
    if self._fishingInvitOperator == nil then
      return nil
    else
      if n <= #self._fishingInvitOperator then
        self._changeLength = self._fishingInvitOperator[n][3]
      else
        self._changeLength = 0
      end
      return self._changeLength
    end
  elseif type == 6 or type == 1 then
    if self._fishingOldOperator == nil then
      return nil
    else
      if n <= #self._fishingOldOperator then
        self._changeLength = self._fishingOldOperator[n][3]
      else
        self._changeLength = 0
      end
      return self._changeLength
    end
  end
end

function HomelandFish:GetChangeTime(type, n)
  if type == 3 then
    if self._fishingRaceOperator == nil then
      return nil
    else
      if n <= #self._fishingRaceOperator then
        self._changeTime = self._fishingRaceOperator[n][4]
      else
        self._changeTime = 0
      end
      return self._changeTime
    end
  elseif type == 5 then
    if self._fishingInvitOperator == nil then
      return nil
    else
      if n <= #self._fishingInvitOperator then
        self._changeTime = self._fishingInvitOperator[n][4]
      else
        self._changeTime = 0
      end
      return self._changeTime
    end
  elseif type == 6 or type == 1 then
    if self._fishingOldOperator == nil then
      return nil
    else
      if n <= #self._fishingOldOperator then
        self._changeTime = self._fishingOldOperator[n][4]
      else
        self._changeTime = 0
      end
      return self._changeTime
    end
  end
end
