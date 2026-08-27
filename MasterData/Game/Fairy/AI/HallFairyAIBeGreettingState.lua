local AIStateBase = require("Game.Dorm.Character.AI.Base.AIStateBase")
local HallFairyAIBeGreettingState = class("HallFairyAIBeGreettingState", AIStateBase)

function HallFairyAIBeGreettingState:ctor(aiCtrl, actionCfg, exitAction)
  self.time = 0
  self.emojiTime = 0
  self.maxEmojiTime = 3
  self.isShowEmoji = false
  self.fairyEntity = self.aiCtrl.hallFairyEntity
end

function HallFairyAIBeGreettingState:GetStateName()
  return "beGreeting"
end

function HallFairyAIBeGreettingState:StartState()
  self.exeState = AIStateBase.AIExecuteState.Runnig
  self.emojiTime = 0
  self.isShowEmoji = false
  self:StartGreeting()
end

function HallFairyAIBeGreettingState:StartGreeting()
  if self.time >= self.duration then
    self:OnExit()
    return
  end
  local greettingFairyEntity = self.fairyEntity:GetGreettingFairyEntity()
  if greettingFairyEntity == nil then
    self:OnExit()
    return
  end
  local greettingPos = greettingFairyEntity.transform.position
  self.fairyEntity.transform:DOLookAt(greettingPos, 0.1):SetLink(self.fairyEntity.gameObject)
end

function HallFairyAIBeGreettingState:OnUpdate()
  if self.exeState == AIStateBase.AIExecuteState.End then
    return
  end
  if self.time >= self.duration then
    self:OnExit()
    return
  end
  self.time = self.time + Time.deltaTime
  if self.isShowEmoji then
    self.emojiTime = self.emojiTime + Time.deltaTime
  end
  if self.emojiTime > self.maxEmojiTime then
    self:OnExit()
  end
  if self.exeState == AIStateBase.AIExecuteState.Fail then
    self:OnExit()
  end
  if self.fairyEntity:GetDistanceWithGreettingFairy() < 1 and not self.isShowEmoji then
    self.fairyEntity:ShowRandomEmoji(self.actionCfg.emoji)
    self.isShowEmoji = true
  end
end

function HallFairyAIBeGreettingState:InterruptState(gotoNext)
  TimerManager:StopTimer(self.__nextTimer)
  self.fairyEntity:DormForceStopMove()
  self.fairyEntity:ClearGreettingFairy()
  if gotoNext then
    self:OnExit()
    return
  end
end

function HallFairyAIBeGreettingState:StartExitWait(action)
  self.fairyEntity:DormForceStopMove()
  self.fairyEntity:HideEmoji()
  self.fairyEntity:ClearGreettingFairy()
  self:OnExit(action)
end

function HallFairyAIBeGreettingState:OnExit(action)
  TimerManager:StopTimer(self.__nextTimer)
  self.fairyEntity:ClearGreettingFairy()
  self.fairyEntity:AnimatorStand()
  AIStateBase.OnExit(self)
  self:ExitByWaitAction(action)
end

return HallFairyAIBeGreettingState
