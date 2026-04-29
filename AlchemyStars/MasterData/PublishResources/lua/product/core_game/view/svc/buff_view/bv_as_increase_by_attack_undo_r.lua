_class("BuffViewAddSkillIncreaseByAttackUndo", BuffViewBase)
BuffViewAddSkillIncreaseByAttackUndo = BuffViewAddSkillIncreaseByAttackUndo

function BuffViewAddSkillIncreaseByAttackUndo:PlayView(TT)
  self._buffComp = self:Entity():BuffView()
  self._buffComp:SetBuffValue("SkillIncreaseByAttackLayer", 1)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAccumulateNum, self:Entity():PetPstID():GetPstID(), 0)
end
