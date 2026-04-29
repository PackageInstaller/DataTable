_class("BuffViewChangePetExtraActiveSkill", BuffViewBase)
BuffViewChangePetExtraActiveSkill = BuffViewChangePetExtraActiveSkill

function BuffViewChangePetExtraActiveSkill:PlayView(TT)
  local pstId = self._entity:PetPstID():GetPstID()
  local skillID = self._buffResult:GetNewSkillID()
  local oriSkillID = self._buffResult:GetOriSkillID()
  GameGlobal:EventDispatcher():Dispatch(GameEventType.ChangePetExtraActiveSkill, pstId, oriSkillID, skillID)
end
