require("command_base_handler")
_class("SwitchPetEquipRefineUICommandHandler", CommandBaseHandler)
SwitchPetEquipRefineUICommandHandler = SwitchPetEquipRefineUICommandHandler

function SwitchPetEquipRefineUICommandHandler:DoHandleCommand(cmd)
  local uiState = cmd:GetCmdRefineUIState()
  local petPstID = cmd:GetCmdCasterPstID()
  local entityID = self:GetEntityIDByPstID(petPstID)
  local petEntity = self._world:GetEntityByID(entityID)
  if not petEntity then
    return
  end
  if not self:CheckCanSwitchState(petEntity, uiState) then
    return
  end
  local buffCmpt = petEntity:BuffComponent()
  buffCmpt:SetBuffValue("EquipRefineUIState", uiState)
  local triggerSvc = self._world:GetService("Trigger")
  local nt = NTEquipRefineUIStateChange:New(petEntity, uiState)
  triggerSvc:Notify(nt)
  if self._world:RunAtClient() then
    self._world:EventDispatcher():Dispatch(GameEventType.DataBuffValue, entityID, "EquipRefineUIState", uiState)
    self._world:EventDispatcher():Dispatch(GameEventType.BattleUIRefreshRefineSwitchBtnState, uiState)
  end
end

function SwitchPetEquipRefineUICommandHandler:CheckCanSwitchState(petEntity, uiState)
  local buffCmpt = petEntity:BuffComponent()
  if not buffCmpt then
    return false
  end
  if not buffCmpt:HasBuffEffect(BuffEffectType.ShowEquipRefineUI) then
    return false
  end
  if buffCmpt:GetBuffValue("EquipRefineUIState") == uiState then
    return false
  end
  return true
end
