require("homelandpet_behavior_base")
_class("HomelandPetBehaviorFishingMatch", HomelandPetBehaviorBase)
HomelandPetBehaviorFishingMatch = HomelandPetBehaviorFishingMatch
local HomelandPetFishingMatchStage = {
  Ready = 1,
  Play = 2,
  PlayEnd = 3,
  Finish = 4,
  Exiting = 5
}
_enum("HomelandPetFishingMatchStage", HomelandPetFishingMatchStage)
local HomelandPetFishingAnimType = {
  StartThrow = 1,
  Waiting = 2,
  Bite = 3,
  Collect = 4,
  MAX = 5
}
_enum("HomelandPetFishingAnimType", HomelandPetFishingAnimType)
local HomelandPetFishingAnimID = {
  Stand = 1,
  StartThrow = 2,
  Waiting = 3,
  Bite = 4,
  Collect = 5,
  Boost = 6,
  Win = 7,
  Lose = 8
}
_enum("HomelandPetFishingAnimType", HomelandPetFishingAnimType)

function HomelandPetBehaviorFishingMatch:Constructor(behaviorType, pet)
  HomelandPetBehaviorFishingMatch.super.Constructor(self, behaviorType, pet)
  self._animationComponent = self:GetComponent(HomelandPetComponentType.ExtraAnimation)
  self._abilityCfg = nil
  self._stage = HomelandPetFishingMatchStage.Ready
end

function HomelandPetBehaviorFishingMatch:Dispose()
end

function HomelandPetBehaviorFishingMatch:Enter()
  HomelandPetBehaviorFishingMatch.super.Enter(self)
  if self._cbFishMatchStart == nil then
    self._cbFishMatchStart = GameHelper:GetInstance():CreateCallback(self.FishMatchStart, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.FishMatchStart, self._cbFishMatchStart)
  end
  if self._cbFishMatchEnd == nil then
    self._cbFishMatchEnd = GameHelper:GetInstance():CreateCallback(self.FishMatchEnd, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.FishMatchEnd, self._cbFishMatchEnd)
  end
  self._animationComponent:PlayAnimation(HomelandPetFishingAnimID.Stand)
  if not self._params then
    return
  end
end

function HomelandPetBehaviorFishingMatch:Update(dms)
  HomelandPetBehaviorFishingMatch.super.Update(self, dms)
  if self._stage == HomelandPetFishingMatchStage.Play then
    local curTime = GameGlobal:GetInstance():GetCurrentTime()
    self._startTime = self._startTime or curTime
    local tick = curTime - self._startTime
    if not self:_CheckSectionEnd(tick) then
      self:_PlaySection(tick)
    else
      self:SwitchStage(HomelandPetFishingMatchStage.PlayEnd)
      self:_DebugBubble(5)
    end
  end
end

function HomelandPetBehaviorFishingMatch:Exit()
  HomelandPetBehaviorFishingMatch.super.Exit(self)
  if self._cbFishMatchStart then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.FishMatchStart, self._cbFishMatchStart)
    self._cbFishMatchStart = nil
  end
  if self._cbFishMatchEnd then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.FishMatchEnd, self._cbFishMatchEnd)
    self._cbFishMatchEnd = nil
  end
  self._animationComponent:PlayAnimation(HomelandPetFishingAnimID.Stand)
end

function HomelandPetBehaviorFishingMatch:Finish()
  return false
end

function HomelandPetBehaviorFishingMatch:CanInterrupt()
  if self._stage == HomelandPetFishingMatchStage.Exiting then
    return true
  end
  return false
end

function HomelandPetBehaviorFishingMatch:SwitchStage(stage)
  self._stage = stage
end

function HomelandPetBehaviorFishingMatch:FishMatchStart(match_end_time, pet_ability_id)
  self._startTime = nil
  self:_SetCfg(pet_ability_id)
  self._data = self:_CalcSectionData(self._abilityCfg.Config)
  self:SwitchStage(HomelandPetFishingMatchStage.Play)
end

function HomelandPetBehaviorFishingMatch:FishMatchEnd(result, playerGoal, petGoal)
  self:SwitchStage(HomelandPetFishingMatchStage.Exiting)
  local cfgId = HomelandPetFishingAnimID.Win
  if result ~= FishMatchEndType.MATCHEND_CLOSE then
    cfgId = petGoal < playerGoal and HomelandPetFishingAnimID.Lose or HomelandPetFishingAnimID.Win
  end
  self._animationComponent:StopAllEffect()
  self._animationComponent:PlayAnimation(cfgId, HomelandPetFishingAnimID.Stand)
  self._animationComponent:StopFishTools()
end

function HomelandPetBehaviorFishingMatch:Goal()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FishMatchPetScore)
end

function HomelandPetBehaviorFishingMatch:_SetCfg(id)
  self._abilityCfg = Cfg.cfg_homeland_fishmatch_pet_ability[id]
  if not self._abilityCfg then
    Log.exception("HomelandPetBehaviorFishingMatch:_SetCfg() cfg_homeland_fishmatch_pet_ability[", id, "] == nil")
    return
  end
end

function HomelandPetBehaviorFishingMatch:_GetAnimationTime()
  return 1300, 1667
end

function HomelandPetBehaviorFishingMatch:_CalcSectionData(data)
  local tb_out = {}
  local animTime1, animTime2 = self:_GetAnimationTime()
  for i, v in ipairs(data) do
    local timeOnce = v[1]
    local biteTime = v[2]
    local effect = v[3] == 1
    local count = v[4]
    if biteTime < 0 then
      Log.exception("HomelandPetBehaviorFishingMatch:_CalcPlayData() cfg_homeland_fishmatch_pet_ability[", self._params, "] Error: biteTime < 0")
    end
    local playSpeed = 1
    if timeOnce < animTime1 + animTime2 then
      playSpeed = timeOnce / (animTime1 + animTime2)
    end
    local t1, t4 = animTime1 * playSpeed, animTime2 * playSpeed
    local t2t3 = timeOnce - t1 - t4
    local t2 = math.max(0, t2t3 - biteTime)
    local t3 = t2t3 - t2
    for ii = 1, count do
      table.insert(tb_out, self:_CreateData(tb_out, t1, effect))
      table.insert(tb_out, self:_CreateData(tb_out, t2, effect))
      table.insert(tb_out, self:_CreateData(tb_out, t3, effect))
      table.insert(tb_out, self:_CreateData(tb_out, t4, effect))
    end
  end
  table.insert(tb_out, self:_CreateData(tb_out, animTime1, false))
  table.insert(tb_out, self:_CreateData(tb_out, 0, false))
  return tb_out
end

function HomelandPetBehaviorFishingMatch:_CreateData(tb_out, duration, effect)
  local last = tb_out[#tb_out]
  local type = last and last.type + 1 or HomelandPetFishingAnimType.MAX
  type = type == HomelandPetFishingAnimType.MAX and HomelandPetFishingAnimType.StartThrow or type
  local start = last and last.start + last.duration or 0
  return {
    type = type,
    start = start,
    duration = duration,
    effect = effect,
    play = false
  }
end

function HomelandPetBehaviorFishingMatch:_PlaySection(tick)
  if not self._data then
    return
  end
  local id
  for i, v in ipairs(self._data) do
    if not v.play and tick > v.start then
      v.play = true
      local cfgId = HomelandPetFishingAnimType.Stand
      local effId = HomelandPetFishingAnimID.Boost
      local show = v.effect
      if v.type == HomelandPetFishingAnimType.StartThrow then
        id = 1
        cfgId = HomelandPetFishingAnimID.StartThrow
        GameGlobal.EventDispatcher():Dispatch(GameEventType.FishMatchPetChangeFishingStatus, FishgingStatus.Throw)
        self._animationComponent:StartFishTools(cfgId, 800)
      elseif v.type == HomelandPetFishingAnimType.Waiting then
        id = 2
        cfgId = HomelandPetFishingAnimID.Waiting
        GameGlobal.EventDispatcher():Dispatch(GameEventType.FishMatchPetChangeFishingStatus, FishgingStatus.Fishing)
      elseif v.type == HomelandPetFishingAnimType.Bite then
        id = 3
        cfgId = HomelandPetFishingAnimID.Bite
        GameGlobal.EventDispatcher():Dispatch(GameEventType.FishMatchPetChangeFishingStatus, FishgingStatus.Bite)
      elseif v.type == HomelandPetFishingAnimType.Collect then
        id = 4
        cfgId = HomelandPetFishingAnimID.Collect
        GameGlobal.EventDispatcher():Dispatch(GameEventType.FishMatchPetChangeFishingStatus, FishgingStatus.FishSuccess)
        self._animationComponent:StopFishTools(500)
        self:Goal()
      end
      self._animationComponent:PlayAnimation(cfgId)
      self._animationComponent:PlayEffect(cfgId, true)
      self._animationComponent:PlayEffect(effId, show)
      break
    end
  end
  self:_DebugBubble(id)
end

function HomelandPetBehaviorFishingMatch:_CheckSectionEnd(tick)
  local last = self._data[#self._data]
  return not last or last.play
end

function HomelandPetBehaviorFishingMatch:_DebugBubble(id)
  local show = UIActivityHelper.CheckDebugOpen()
  if not show then
    return
  end
  local tb = {
    [1] = 4030137,
    [2] = 4030133,
    [3] = 4030103,
    [4] = 4030025,
    [5] = 4030013,
    [6] = 4010082
  }
  local bubbleCmp = self:GetComponent(HomelandPetComponentType.Bubble)
  local bubbleId = tb[id]
  if bubbleCmp and bubbleId then
    bubbleCmp:ShowBubble(bubbleId)
  end
end
