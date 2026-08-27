local AIStateBase = require("Game.Dorm.Character.AI.Base.AIStateBase")
local HallFairyAIDialogueState = class("HallFairyAIDialogueState", AIStateBase)

function HallFairyAIDialogueState:ctor(aiCtrl, actionCfg, exitAction)
  self.time = 0
  self.emojiTime = 0
  self.maxEmojiTime = 3
  self.isShowEmoji = false
  self.fairyEntity = self.aiCtrl.hallFairyEntity
  self.__onCompleteOneMove = BindCallback(self, self.CompleteOneMove)
end

function HallFairyAIDialogueState:GetStateName()
  return "dialogue"
end

function HallFairyAIDialogueState:StartState()
  self.exeState = AIStateBase.AIExecuteState.Runnig
  self.__moveCount = 0
  self.emojiTime = 0
  self.isShowEmoji = false
  self:StartDialogue()
end

function HallFairyAIDialogueState:StartDialogue()
  if self.time >= self.duration then
    self:OnExit()
    return
  end
  local ok, pos = self.fairyEntity:GetRandomOtherFairyPos()
  if not ok then
    self.fairyEntity:AnimatorStand()
    self.exeState = AIStateBase.AIExecuteState.Fail
    return
  end
  local success = self.fairyEntity:DoMoveAStar(pos, self.__onCompleteOneMove, ConfigData.buildinConfig.DormMoveFailTimeout, true, true)
  if success then
    if self.__moveCount <= 0 then
      self.fairyEntity:AnimatorCrossFade(self.actionCfg.action_name, self.actionCfg.trans_time)
    end
    self.__moveCount = self.__moveCount + 1
  elseif 1 > Vector3.Distance(self.fairyEntity.transform.position, pos) then
    self.fairyEntity:ShowRandomEmoji(self.actionCfg.emoji)
    self.isShowEmoji = true
  end
end

function HallFairyAIDialogueState:CompleteOneMove(success)
  self.fairyEntity:DormForceStopMove()
  if self.time < self.duration then
    self.fairyEntity:ShowRandomEmoji(self.actionCfg.emoji)
    self.isShowEmoji = true
  else
    self:OnExit()
    return
  end
end

function HallFairyAIDialogueState:OnUpdate()
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
end

function HallFairyAIDialogueState:InterruptState(gotoNext)
  TimerManager:StopTimer(self.__nextTimer)
  self.fairyEntity:DormForceStopMove()
  self.fairyEntity:ClearGreettingFairy()
  if gotoNext then
    self:OnExit()
    return
  end
end

function HallFairyAIDialogueState:StartExitWait(action)
  self.fairyEntity:DormForceStopMove()
  self.fairyEntity:HideEmoji()
  self.fairyEntity:ClearGreettingFairy()
  self:OnExit(action)
end

function HallFairyAIDialogueState:OnExit(action)
  TimerManager:StopTimer(self.__nextTimer)
  self.fairyEntity:ClearGreettingFairy()
  self.fairyEntity:AnimatorStand()
  AIStateBase.OnExit(self)
  self:ExitByWaitAction(action)
end

return HallFairyAIDialogueState
