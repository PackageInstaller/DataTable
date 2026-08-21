require("base_ins_r")
_class("PlayCasterAttachmentVisibleInstruction", BaseInstruction)
PlayCasterAttachmentVisibleInstruction = PlayCasterAttachmentVisibleInstruction

function PlayCasterAttachmentVisibleInstruction:Constructor(paramList)
  self._visible = tonumber(paramList.visible)
end

function PlayCasterAttachmentVisibleInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local isShow = self._visible == 1
  casterEntity:SetAttachmentVisible(isShow)
end
