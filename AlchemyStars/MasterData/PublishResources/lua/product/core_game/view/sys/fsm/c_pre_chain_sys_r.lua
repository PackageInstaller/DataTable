require("pre_chain_state_system")
_class("ClientPreChainSystem_Render", PreChainStateSystem)
ClientPreChainSystem_Render = ClientPreChainSystem_Render

function ClientPreChainSystem_Render:_PlayPreChainTrapSkill(TT, trapIds)
  local renderEntityService = self._world:GetService("RenderEntity")
  renderEntityService:DestroyGhost()
  local sTrapRender = self._world:GetService("TrapRender")
  local taskIds = sTrapRender:PlayTrapPreChainSkill(trapIds)
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIds) do
    YIELD(TT)
  end
end

function ClientPreChainSystem_Render:_DoRenderWaitTeleportFinish(TT, listTrapTrigger, teamEntity)
  local sPlaySkillInstruction = self._world:GetService("PlaySkillInstruction")
  local listTrapTask = sPlaySkillInstruction:PlayTrapTrigger(TT, teamEntity, listTrapTrigger)
  self:_WaitTasksEnd(TT, listTrapTask)
end

function ClientPreChainSystem_Render:_DoRenderResetPickUp()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  pickUpTargetCmpt:Reset()
  renderBoardEntity:ReplacePickUpTarget()
end
