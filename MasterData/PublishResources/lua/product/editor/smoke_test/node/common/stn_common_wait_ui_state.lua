require("common_async_base")
_class("Common_WaitUIState", Common_AsyncBase)
Common_WaitUIState = Common_WaitUIState

function Common_WaitUIState:Constructor(_, state)
  self._requiredUIState = state
end

function Common_WaitUIState:TaskFunc(TT, status)
  while self._requiredUIState ~= GameGlobal.UIStateManager():CurUIStateType() do
    YIELD(TT)
  end
end
