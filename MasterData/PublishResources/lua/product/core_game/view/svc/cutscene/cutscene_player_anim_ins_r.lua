require("cutscene_base_ins_r")
_class("CutscenePlayerAnimationInstruction", CutsceneBaseInstruction)
CutscenePlayerAnimationInstruction = CutscenePlayerAnimationInstruction

function CutscenePlayerAnimationInstruction:Constructor(paramList)
  self._animName = paramList.anim
end

function CutscenePlayerAnimationInstruction:DoInstruction(TT, phaseContext)
  local playerEntity = phaseContext:GetCutsceneWorld():Player():GetLocalTeamEntity()
  playerEntity:SetAnimatorControllerTriggers({
    self._animName
  })
  Log.fatal("剧情指令，播放动作")
end
