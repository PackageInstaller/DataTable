_class("BuffViewSetSealedCurse", BuffViewBase)
BuffViewSetSealedCurse = BuffViewSetSealedCurse

function BuffViewSetSealedCurse:PlayView(TT)
  local res = self._buffResult
  local buffseq = res:GetBuffSeq()
  local buffView = self._entity:BuffView()
  local viewInstance = buffView:GetBuffViewInstance(buffseq)
  if not viewInstance then
    Log.error(self._className, "no viewInstance! entity=", self._entity:GetID())
    return
  end
  if self._entity:HasPetPstID() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.BattlePetIconSealedCurse, self._entity:PetPstID():GetPstID(), res:IsCursed(), buffseq, viewInstance:RemainRoundCount(), viewInstance:GetMaxRoundCount() == 0)
  end
end

_class("BuffViewResetSealedCurse", BuffViewSetSealedCurse)
