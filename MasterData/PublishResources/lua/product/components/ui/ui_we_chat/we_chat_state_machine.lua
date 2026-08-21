require("fsm_state_machine")
require("we_chat_state")
_class("WeChatStateMachine", FSMStateMachine)
WeChatStateMachine = WeChatStateMachine
local WeChatState = {
  Empty = -1,
  Normal = 1,
  Reply = 2,
  AddAnswer = 3,
  Wait = 4,
  WaitEnd = 5,
  Voice = 6
}
_enum("WeChatState", WeChatState)
local WeChatStateName = {
  [WeChatState.Empty] = "Empty",
  [WeChatState.Normal] = "Normal",
  [WeChatState.Reply] = "Reply",
  [WeChatState.AddAnswer] = "AddAnswer",
  [WeChatState.Wait] = "Wait",
  [WeChatState.WaitEnd] = "WaitEnd",
  [WeChatState.Voice] = "Voice"
}
_enum("WeChatStateName", WeChatStateName)

function WeChatStateMachine:OnInit()
  self:Add(WeChatEmptyState:New(WeChatState.Empty, self))
  self:Add(WeChatNormalState:New(WeChatState.Normal, self))
  self:Add(WeChatReplyState:New(WeChatState.Reply, self))
  self:Add(WeChatAddAnswerState:New(WeChatState.AddAnswer), self)
  self:Add(WeChatWaitState:New(WeChatState.Wait), self)
  self:Add(WeChatWaitEndState:New(WeChatState.WaitEnd), self)
  self:Add(WeChatVoiceState:New(WeChatState.Voice, self))
end
