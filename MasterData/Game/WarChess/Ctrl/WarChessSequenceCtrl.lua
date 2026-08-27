local base = require("Game.WarChess.Ctrl.Base.WarChessCtrlBase")
local WarChessSequenceCtrl = class("WarChessSequenceCtrl", base)

function WarChessSequenceCtrl:ctor(wcCtrl)
  self.__playSequence = {}
  self.__tryPlayWCSLevelBuff = BindCallback(self, self.__TryPlayWCSLevelBuff)
  self.__tryPlayWCSLevelPressAdd = BindCallback(self, self.__TryPlayWCSLevelPressAdd)
  self.__playStartPlay = BindCallback(self, self.PlayStartPlay)
  self.__tryPlayWCSGetRewardWhenSettle = BindCallback(self, self.__TryPlayWCSGetRewardWhenSettle)
  self.__tryPlayWCSSelectLevelStage1 = BindCallback(self, self.__TryPlayWCSSelectLevelStage1)
  self.__tryPlayWCSSelectLevelStage2 = BindCallback(self, self.__TryPlayWCSSelectLevelStage2)
  self.__tryPalyCompleteFloorTip = BindCallback(self, self.__TryPalyCompleteFloorTip)
  self.__tryPalyGetRewradBagReward = BindCallback(self, self.__TryPalyGetRewradBagReward)
end

function WarChessSequenceCtrl:AterEnterPlayState()
  local sequence = {
    self.__tryPlayWCSLevelBuff,
    self.__tryPlayWCSLevelPressAdd,
    self.__playStartPlay
  }
  for _, callback in ipairs(sequence) do
    table.insert(self.__playSequence, callback)
  end
  self:__PlayNext()
end

function WarChessSequenceCtrl:WhenWCSLevelSettle()
  local sequence = {
    self.__tryPlayWCSSelectLevelStage1,
    self.__tryPlayWCSGetRewardWhenSettle,
    self.__tryPalyCompleteFloorTip,
    self.__tryPlayWCSSelectLevelStage2
  }
  for _, callback in ipairs(sequence) do
    table.insert(self.__playSequence, callback)
  end
  self:__PlayNext()
end

function WarChessSequenceCtrl:WhenBackPackUpdate()
  local sequence = {
    self.__tryPalyGetRewradBagReward
  }
  for _, callback in ipairs(sequence) do
    table.insert(self.__playSequence, callback)
  end
  self:__PlayNext()
end

function WarChessSequenceCtrl:__PlayNext()
  if #self.__playSequence > 0 then
    local callback = table.remove(self.__playSequence, 1)
    callback()
  end
end

function WarChessSequenceCtrl:SetWCStartPlayFunc(startPlayFunc)
  self.__startPlayFunc = startPlayFunc
end

function WarChessSequenceCtrl:PlayStartPlay()
  UIManager:ShowWindowAsync(UIWindowTypeID.WarChessNotice, function(win)
    win:OnWCStart(function()
      if self.__startPlayFunc ~= nil then
        self.__startPlayFunc()
        self.__startPlayFunc = nil
      end
      self:__PlayNext()
    end, 1.2)
  end)
end

function WarChessSequenceCtrl:SetWCSLevelBuff(envBuffData)
  self.__wcsBuffData = envBuffData
end

function WarChessSequenceCtrl:__TryPlayWCSLevelBuff()
  if self.__wcsBuffData == nil then
    self:__PlayNext()
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.EpBuffDesc, function(win)
    win:InitWCBuffDesc({
      self.__wcsBuffData
    }, function()
      self.__wcsBuffData = nil
      self:__PlayNext()
    end, 1.25)
    win:OpenBuffCloseFlyAni(1.25)
  end)
end

function WarChessSequenceCtrl:SetWCSLevelPressAdd(expAddNum)
  self.__wcsExpAddNum = expAddNum
end

function WarChessSequenceCtrl:__TryPlayWCSLevelPressAdd()
  if self.__wcsExpAddNum == nil then
    self:__PlayNext()
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.WarChessNotice, function(window)
    if window ~= nil then
      window:OnWCStressUpgrade(nil, self.__wcsExpAddNum, function()
        self.__wcsExpAddNum = nil
        self:__PlayNext()
      end)
    end
  end)
end

function WarChessSequenceCtrl:SetWCSGetRewardWhenSettle(seasonSettleData)
  self.__seasonSettleData = seasonSettleData
end

function WarChessSequenceCtrl:__TryPlayWCSGetRewardWhenSettle()
  if self.__seasonSettleData == nil then
    self:__PlayNext()
    return
  end
  local rewardDic = {}
  local rewardCount = 0
  local addtionData = WarChessSeasonManager:GetSeasonAddtionData()
  local scoreTokenId
  if addtionData ~= nil then
    scoreTokenId = addtionData:GetSeasonScoreToken()
  end
  for itemId, addNum in pairs(self.__seasonSettleData.rewardItems) do
    if itemId ~= scoreTokenId then
      rewardDic[itemId] = addNum
      rewardCount = rewardCount + 1
    end
  end
  local itemId, totalNum, addNum
  if rewardCount < 1 then
    self:__PlayNext()
    return
  end
  if 1 < rewardCount then
    warn("not suppor mult rewards:" .. serpent.block(rewardDic))
  end
  for key, value in pairs(rewardDic) do
    itemId = key
    addNum = value
    break
  end
  if addNum == 0 then
    self:__PlayNext()
    return
  end
  local isLimitFull = false
  local addtionData = WarChessSeasonManager:GetSeasonAddtionData()
  if addtionData ~= nil and addtionData:GetSeasonScoreToken() == itemId then
    local count, fullCount = addtionData:GetSeasonScore()
    isLimitFull = 0 < fullCount and fullCount <= count
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.WarChessNotice, function(window)
    window:WCShowGetReward(itemId, totalNum, addNum, isLimitFull, function()
      self.__seasonSettleData = nil
      self:__PlayNext()
    end, 1.25)
  end)
end

function WarChessSequenceCtrl:SetWCSSelectLevel(nextWarChessLobby, nextRooms)
  self.__nextWarChessLobby = nextWarChessLobby
  self.__nextRooms = nextRooms
end

function WarChessSequenceCtrl:__TryPlayWCSSelectLevelStage1()
  UIManager:ShowWindowAsync(UIWindowTypeID.WarChessSeasonSelectLevel, function(win)
    if win == nil then
      self:__PlayNext()
      return
    end
    win:InitWCSLevelInfo()
    win:WCSPlayAniCompleteCurLevel(function()
      self:__PlayNext()
    end, 1.25)
  end)
end

function WarChessSequenceCtrl:__TryPlayWCSSelectLevelStage2()
  if self.__nextWarChessLobby then
    WarChessSeasonManager:WarChessSeasonEnterLobby()
  elseif self.__nextRooms ~= nil and #self.__nextRooms > 0 then
    UIManager:ShowWindowAsync(UIWindowTypeID.WarChessSeasonSelectLevel, function(win)
      if win == nil then
        self:__PlayNext()
        return
      end
      win:InitWCSSelectLevel(self.__nextRooms)
      win:WCSPlayAniSelectLevel(true, nil, 1.25)
    end)
  end
end

function WarChessSequenceCtrl:SetCompleteFloorTipCallCoroutine(callback, one_shoot)
  self.__tipCoroutine = coroutine.create(function(call)
    call()
    coroutine.yield()
    self:__PlayNext()
    if self.__floorTipCallbackOneShoot then
      self.__completeFloorTipCallback = nil
      self.__floorTipCallbackOneShoot = false
    end
  end)
  self.__completeFloorTipCallback = callback
  self.__floorTipCallbackOneShoot = one_shoot
end

function WarChessSequenceCtrl:ResumeFloorTipCallCoroutine()
  if self.__tipCoroutine then
    coroutine.resume(self.__tipCoroutine)
  end
end

function WarChessSequenceCtrl:__TryPalyCompleteFloorTip()
  if self.__completeFloorTipCallback and coroutine.status(self.__tipCoroutine) == "suspended" then
    coroutine.resume(self.__tipCoroutine, self.__completeFloorTipCallback)
  else
    self:__PlayNext()
  end
end

function WarChessSequenceCtrl:SetIsHaveNewRewradBagReward(bool)
  self.__isHaveNewRewradBagReward = bool
end

function WarChessSequenceCtrl:SetWhereNewRewradBagFrom(entityData)
  if entityData == nil then
    return
  end
  local logicPos = entityData:GetEntityLogicPos()
  self.__newRewradBagFromWorldPos = Vector3.New(logicPos.x, 0, logicPos.y)
end

function WarChessSequenceCtrl:__TryPalyGetRewradBagReward()
  if self.__isHaveNewRewradBagReward and self.__newRewradBagFromWorldPos ~= nil then
    local wcMain = UIManager:GetWindow(UIWindowTypeID.WarChessMain)
    local playNode
    if wcMain ~= nil then
      playNode = wcMain:GetWCPlayNode()
    end
    if playNode ~= nil then
      playNode:StartFlyWCRewardBag(self.__newRewradBagFromWorldPos, function()
        self:__PlayNext()
      end)
    end
    self.__isHaveNewRewradBagReward = nil
    self.__newRewradBagFromWorldPos = nil
  end
  self:__PlayNext()
end

function WarChessSequenceCtrl:SetReLoadSceneOverCallback(callback)
  table.insert(self.__playSequence, callback)
end

function WarChessSequenceCtrl:ApplayReLoadSceneOver()
  self:__PlayNext()
end

return WarChessSequenceCtrl
