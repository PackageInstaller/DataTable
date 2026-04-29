require("homeland_actor_state")
_class("HomelandActorStatePick", HomelandActorState)
HomelandActorStatePick = HomelandActorStatePick

function HomelandActorStatePick:Constructor()
end

function HomelandActorStatePick:GetType()
  return HomelandActorStateType.Pick
end

function HomelandActorStatePick:Enter()
  self._mcc:SetAnimatorBool("HoldPick", true)
  local cfg = GameGlobal.GetUIModule(HomelandModule):GetCurrentToolCfg(ToolType.TT_PICK)
  self._mcc:AttachModel(cfg.Res, cfg.AttachPath)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.HomelandAudioPullOutPickaxe)
end

function HomelandActorStatePick:Exit()
  self._mcc:SetAnimatorBool("HoldPick", false)
  self._mcc:ReleaseAttachedModel()
end
