_class("BuffViewChangeSkillIncrease", BuffViewBase)
BuffViewChangeSkillIncrease = BuffViewChangeSkillIncrease

function BuffViewChangeSkillIncrease:PlayView(TT)
  if self._buffResult:GetLight() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivatePassive, self._entity:PetPstID():GetPstID(), true)
  end
end

_class("BuffViewRemoveSkillIncrease", BuffViewBase)
BuffViewRemoveSkillIncrease = BuffViewRemoveSkillIncrease

function BuffViewRemoveSkillIncrease:PlayView(TT)
  if self._buffResult:GetBlack() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivatePassive, self._entity:PetPstID():GetPstID(), false)
  end
end
