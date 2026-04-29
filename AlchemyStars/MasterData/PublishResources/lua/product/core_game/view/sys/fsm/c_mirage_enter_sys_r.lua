require("mirage_enter_system")
_class("ClientMirageEnterSystem_Render", MirageEnterSystem)
ClientMirageEnterSystem_Render = ClientMirageEnterSystem_Render

function ClientMirageEnterSystem_Render:_DoRenderMirageEnterUI(TT, initStepNum)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowMirageEnterUI, true)
  local mirageRenderSvc = self._world:GetService("MirageRender")
  mirageRenderSvc:SetMirageStepVisible(true)
  mirageRenderSvc:RefreshMirageStepNum(initStepNum)
end

function ClientMirageEnterSystem_Render:_DoRenderMirageShowTraps(TT, traps)
  local mirageRenderSvc = self._world:GetService("MirageRender")
  mirageRenderSvc:DoMirageShowTraps(TT, traps)
end

function ClientMirageEnterSystem_Render:_DoRenderMiragePlayTrapWarningSkill(TT, traps)
  local mirageSvcRender = self._world:GetService("MirageRender")
  mirageSvcRender:DoMiragePlayTrapWarningSkill(TT, traps)
end
