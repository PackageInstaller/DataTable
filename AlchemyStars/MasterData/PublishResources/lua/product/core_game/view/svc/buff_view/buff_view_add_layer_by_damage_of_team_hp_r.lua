_class("BuffViewAddLayerByDamageOfTeamHp", BuffViewBase)
BuffViewAddLayerByDamageOfTeamHp = BuffViewAddLayerByDamageOfTeamHp

function BuffViewAddLayerByDamageOfTeamHp:PlayView(TT)
  local res = self._buffResult
  local curLayer = res:GetLayer()
  local buffseq = res:GetBuffSeq()
  local buffView = self._entity:BuffView()
  local viewInstance = buffView:GetBuffViewInstance(buffseq)
  if not viewInstance then
    Log.error("BuffViewAddLayerByDamageOfTeamHp not find viewInstance! entity=", self._entity:GetID(), " layer=", curLayer)
    return
  end
  viewInstance:SetLayerCount(TT, curLayer)
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
end
