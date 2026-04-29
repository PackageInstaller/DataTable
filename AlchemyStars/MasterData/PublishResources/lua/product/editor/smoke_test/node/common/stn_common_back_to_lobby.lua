require("base_state_node")
_class("Common_BackToLobby", Common_AsyncBase)
Common_BackToLobby = Common_BackToLobby

function Common_BackToLobby:TaskFunc(TT, outResult)
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
  if GameGlobal.UIStateManager():CurUIStateType() ~= UIStateType.UIMain then
    return false
  end
  self._beginUnscaledTimeMS = UnityEngine.Time.unscaledTime * 1000
  while UnityEngine.Time.unscaledTime * 1000 - self._beginUnscaledTimeMS < 5000 do
    YIELD(TT)
  end
end
