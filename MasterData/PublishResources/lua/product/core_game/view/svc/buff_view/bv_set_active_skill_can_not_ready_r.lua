_class("BuffViewSetActiveSkillCanNotReady", BuffViewBase)
BuffViewSetActiveSkillCanNotReady = BuffViewSetActiveSkillCanNotReady

function BuffViewSetActiveSkillCanNotReady:PlayView(TT)
  local res = self._buffResult
  local buffseq = res:GetBuffSeq()
  local buffView = self._entity:BuffView()
  local viewInstance = buffView:GetBuffViewInstance(buffseq)
  if not viewInstance then
    Log.error(self._className, "no viewInstance! entity=", self._entity:GetID())
    return
  end
  if self._entity:HasPetPstID() then
    local extraSkillID = res:GetExtraSkillID()
    local petPstID = self._entity:PetPstID():GetPstID()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetActiveSkillCanNotReady, petPstID, res:IsCanNotReady(), buffseq, extraSkillID)
    local ready = res:IsReady()
    if ready then
      if extraSkillID then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.PetExtraActiveSkillGetReady, petPstID, extraSkillID, ready)
      else
        GameGlobal.EventDispatcher():Dispatch(GameEventType.PetActiveSkillGetReady, petPstID, ready)
      end
    elseif extraSkillID then
      GameGlobal:EventDispatcher():Dispatch(GameEventType.PetExtraActiveSkillCancelReady, petPstID, extraSkillID, 0)
    else
      GameGlobal:EventDispatcher():Dispatch(GameEventType.PetActiveSkillCancelReady, petPstID, 0)
    end
  end
end

_class("BuffViewResetActiveSkillCanNotReady", BuffViewSetActiveSkillCanNotReady)
BuffViewResetActiveSkillCanNotReady = BuffViewResetActiveSkillCanNotReady
