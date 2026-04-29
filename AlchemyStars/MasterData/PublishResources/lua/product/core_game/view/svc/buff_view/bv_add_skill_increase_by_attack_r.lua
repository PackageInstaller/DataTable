_class("BuffViewAddSkillIncreaseByAttack", BuffViewBase)
BuffViewAddSkillIncreaseByAttack = BuffViewAddSkillIncreaseByAttack

function BuffViewAddSkillIncreaseByAttack:Constructor()
  self._buffView = self:Entity():BuffView()
end

function BuffViewAddSkillIncreaseByAttack:IsNotifyMatch(notify)
  local attackerID = notify._attacker:GetID()
  local myID = self:Entity():GetID()
  return attackerID == myID and self:GetBuffResult():GetLayer() == (self._buffView:GetBuffValue("SkillIncreaseByAttackLayer") or 1)
end

function BuffViewAddSkillIncreaseByAttack:PlayView(TT)
  local layer = self._buffResult:GetLayer()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAccumulateNum, self:Entity():PetPstID():GetPstID(), layer)
  layer = layer + 1
  self._buffView:SetBuffValue("SkillIncreaseByAttackLayer", layer)
end
