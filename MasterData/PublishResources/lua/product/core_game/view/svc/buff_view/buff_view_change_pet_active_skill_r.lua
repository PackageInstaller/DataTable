_class("BuffViewChangePetActiveSkill", BuffViewBase)
BuffViewChangePetActiveSkill = BuffViewChangePetActiveSkill

function BuffViewChangePetActiveSkill:PlayView(TT)
  local pstId = self._entity:PetPstID():GetPstID()
  local skillID = self._buffResult:GetSkillID()
  local layer = self._buffResult:GetLayer()
  GameGlobal:EventDispatcher():Dispatch(GameEventType.ChangePetActiveSkill, pstId, skillID)
end
