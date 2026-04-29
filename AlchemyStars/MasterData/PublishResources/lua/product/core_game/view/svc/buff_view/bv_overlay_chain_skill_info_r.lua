_class("BuffViewOverlayChainSkillInfo", BuffViewBase)
BuffViewOverlayChainSkillInfo = BuffViewOverlayChainSkillInfo

function BuffViewOverlayChainSkillInfo:PlayView(TT)
  if not self._entity:HasPetPstID() then
    return
  end
end

_class("BuffViewClearOverlayChainSkillInfo", BuffViewBase)
BuffViewClearOverlayChainSkillInfo = BuffViewClearOverlayChainSkillInfo

function BuffViewClearOverlayChainSkillInfo:PlayView(TT)
  if not self._entity:HasPetPstID() then
    return
  end
end
