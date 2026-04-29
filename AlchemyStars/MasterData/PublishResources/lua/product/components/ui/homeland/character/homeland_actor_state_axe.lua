require("homeland_actor_state")
_class("HomelandActorStateAxe", HomelandActorState)
HomelandActorStateAxe = HomelandActorStateAxe

function HomelandActorStateAxe:Constructor()
end

function HomelandActorStateAxe:GetType()
  return HomelandActorStateType.Axe
end

function HomelandActorStateAxe:Enter()
  self._mcc:SetAnimatorBool("HoldAxe", true)
  local cfg = GameGlobal.GetUIModule(HomelandModule):GetCurrentToolCfg(ToolType.TT_AXE)
  self._mcc:AttachModel(cfg.Res, cfg.AttachPath)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.HomelandAudioTakeAxe)
end

function HomelandActorStateAxe:Exit()
  self._mcc:SetAnimatorBool("HoldAxe", false)
  self._mcc:ReleaseAttachedModel()
end
