local AIStateBase = require("Game.Dorm.Character.AI.Base.AIStateBase")
local LittleManAIMoveState = class("LittleManAIMoveState", AIStateBase)

function LittleManAIMoveState:ctor(littleManCtrl, actionCfg, exitAction)
  self.time = 0
  self.littleManCtrl = littleManCtrl
  self.littleMan = littleManCtrl.littleMan
  self.actionCfg = actionCfg
  self.__onCompleteOneMove = BindCallback(self, self.CompleteOneMove)
end

function LittleManAIMoveState:GetStateName()
  return "littleman_move"
end

function LittleManAIMoveState:StartState()
  self.exeState = AIStateBase.AIExecuteState.Runnig
  self.__moveCount = 0
  self:StartNewMove()
end

function LittleManAIMoveState:StartNewMove()
  if self.time >= self.duration then
    self:OnExit()
    return
  end
  local emojiIdList = self.actionCfg.emoji
  local emojiId = emojiIdList[math.random(#emojiIdList)]
  self.littleMan:ShowEmoji(emojiId)
  self.littleMan:Move(self.__onCompleteOneMove)
end

function LittleManAIMoveState:CompleteOneMove()
  if self.time >= self.duration then
    self:OnExit()
    return
  end
  self:StartNewMove()
end

function LittleManAIMoveState:OnUpdate()
  if self.exeState == AIStateBase.AIExecuteState.End then
    return
  end
  self.time = self.time + Time.deltaTime
  if self.exeState == AIStateBase.AIExecuteState.Fail then
    self:OnExit()
  end
end

function LittleManAIMoveState:StartExitWait(action)
  self:OnExit(action)
end

function LittleManAIMoveState:OnExit(action)
  TimerManager:StopTimer(self.__nextTimer)
  AIStateBase.OnExit(self)
  self:ExitByWaitAction(action)
end

return LittleManAIMoveState
