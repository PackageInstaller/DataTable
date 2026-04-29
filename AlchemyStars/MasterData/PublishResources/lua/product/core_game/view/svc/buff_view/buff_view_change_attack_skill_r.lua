_class("BuffViewChangeAttackSkill", BuffViewBase)
BuffViewChangeAttackSkill = BuffViewChangeAttackSkill

function BuffViewChangeAttackSkill:PlayView(TT, notify)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivatePassive, self._entity:PetPstID():GetPstID(), true)
end

function BuffViewChangeAttackSkill:IsNotifyMatch(notify)
  local trapCasterID = self._buffResult:GetTrapCasterID()
  if notify and notify:GetNotifyType() == NotifyType.TrapSkillStart then
    if trapCasterID and trapCasterID == notify:GetNotifyEntity():GetID() then
      return true
    end
  else
    return true
  end
  return false
end
