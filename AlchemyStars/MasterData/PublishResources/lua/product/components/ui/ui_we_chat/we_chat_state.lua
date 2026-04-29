require("fsm_state")
_class("WeChatEmptyState", FSMState)
WeChatEmptyState = WeChatEmptyState
_class("WeChatNormalState", FSMState)
WeChatNormalState = WeChatNormalState

function WeChatNormalState:Enter(speakerId)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.WeChatNormalState, speakerId)
end

_class("WeChatReplyState", FSMState)
WeChatReplyState = WeChatReplyState

function WeChatReplyState:Enter(speakerId)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.WeChatReplyState, speakerId)
end

_class("WeChatVoiceState", FSMState)
WeChatVoiceState = WeChatVoiceState

function WeChatVoiceState:Constructor()
end

_class("WeChatAddAnswerState", FSMState)
WeChatAddAnswerState = WeChatAddAnswerState

function WeChatAddAnswerState:Enter(data)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.WeChatAddAnswerState, data)
end

_class("WeChatWaitState", FSMState)
WeChatWaitState = WeChatWaitState

function WeChatWaitState:Enter(data, time)
  time = time or 500
  self.time = time
  self.data = data
  self.startTime = GameGlobal:GetInstance():GetCurrentTime()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.WeChatWaitState, self.data)
end

function WeChatWaitState:Excute()
  local nowTime = GameGlobal:GetInstance():GetCurrentTime()
  if nowTime - self.startTime > self.time then
    self:ChangeState(WeChatState.WaitEnd, self.data)
  end
end

_class("WeChatWaitEndState", FSMState)
WeChatWaitEndState = WeChatWaitEndState

function WeChatWaitEndState:Enter(data)
  AudioHelperController.PlayRequestedUISound(CriAudioIDConst.WeChatRecvMessage)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.WeChatWaitEndState, data)
end
