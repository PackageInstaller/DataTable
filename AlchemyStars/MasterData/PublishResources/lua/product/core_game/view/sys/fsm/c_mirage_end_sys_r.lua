require("mirage_end_system")
_class("ClientMirageEndSystem_Render", MirageEndSystem)
ClientMirageEndSystem_Render = ClientMirageEndSystem_Render

function ClientMirageEndSystem_Render:_DoRenderMirageClearWarningArea(TT)
  local mirageRenderSvc = self._world:GetService("MirageRender")
  mirageRenderSvc:DoMirageClearWarningArea()
end

function ClientMirageEndSystem_Render:_DoRenderForceCastTrapSkill(TT, eTraps)
  local mirageRenderSvc = self._world:GetService("MirageRender")
  mirageRenderSvc:DoMiragePlayTrapSkill(TT, eTraps)
end

function ClientMirageEndSystem_Render:_DoRenderMiragePlayTrapDieSkill(TT, eTraps)
  local mirageRenderSvc = self._world:GetService("MirageRender")
  mirageRenderSvc:DoMiragePlayTrapDieSkill(TT, eTraps)
end

function ClientMirageEndSystem_Render:_DoRenderMirageBossReturn(TT, bossEntity)
  local mirageRenderSvc = self._world:GetService("MirageRender")
  mirageRenderSvc:DoMiragePlayBossReturn(TT, bossEntity)
end

function ClientMirageEndSystem_Render:_DoRenderMirageEndUI(TT)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowMirageEnterUI, false)
  local mirageRenderSvc = self._world:GetService("MirageRender")
  mirageRenderSvc:SetMirageStepVisible(false)
  local pickUpCmpt = self._world:MiragePickUp()
  pickUpCmpt:GetCurPickUpGridPos(Vector2.zero)
end
