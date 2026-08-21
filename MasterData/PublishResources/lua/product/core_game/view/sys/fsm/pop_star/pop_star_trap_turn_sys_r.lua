require("pop_star_trap_turn_system")
_class("PopStarTrapTurnSystem_Render", PopStarTrapTurnSystem)
PopStarTrapTurnSystem_Render = PopStarTrapTurnSystem_Render

function PopStarTrapTurnSystem_Render:_DoRenderTrapState(TT, calcStateTraps)
  local trapServiceRender = self._world:GetService("TrapRender")
  trapServiceRender:RenderTrapState(TT, TrapDestroyType.DestroyByRound, calcStateTraps)
end

function PopStarTrapTurnSystem_Render:_DoRenderTrapBeforeMonster(TT)
  local playAISvc = self._world:GetService("PlayAI")
  if playAISvc == nil then
    return
  end
  playAISvc:DoCommonRountine(TT)
end

function PopStarTrapTurnSystem_Render:_DoRenderTrapAfterMonster(TT)
  local playAISvc = self._world:GetService("PlayAI")
  if playAISvc == nil then
    return
  end
  playAISvc:DoCommonRountine(TT)
end

function PopStarTrapTurnSystem_Render:_UpdateTrapGridRound(TT)
  local svc = self._world:GetService("TrapRender")
  svc:UpdateTrapGridRound()
end
