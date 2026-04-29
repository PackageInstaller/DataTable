require("base_ins_r")
_class("PlayCasterAttachmentAnimationInstruction", BaseInstruction)
PlayCasterAttachmentAnimationInstruction = PlayCasterAttachmentAnimationInstruction

function PlayCasterAttachmentAnimationInstruction:Constructor(paramList)
  self._animName = paramList.animName
end

function PlayCasterAttachmentAnimationInstruction:DoInstruction(TT, casterEntity, phaseContext)
  casterEntity:SetAttachmentAnimationTrigger(self._animName)
end
