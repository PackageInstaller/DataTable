_class("BuffViewAddBuffByAddBuff", BuffViewBase)
BuffViewAddBuffByAddBuff = BuffViewAddBuffByAddBuff

function BuffViewAddBuffByAddBuff:PlayView(TT, notify, trace)
  local playBuffSvc = self._world:GetService("PlayBuff")
  local arr = self._buffResult:GetBuffArray()
  for i, v in ipairs(arr) do
    local eid, seq = v[1], v[2]
    Log.debug("BuffViewAddBuffByAddBuff entityid=", eid, "buffseq=", seq, "trace: ", trace)
    local entity = self._world:GetEntityByID(eid)
    if entity then
      local inst = entity:BuffView():GetBuffViewInstance(seq)
      if inst then
        playBuffSvc:PlayAddBuff(TT, inst, self._entity:GetID(), true)
        if self._buffResult:GetLight() == 1 then
          GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivatePassive, entity:PetPstID():GetPstID(), true)
        end
      end
    end
  end
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
  local cfg = self._viewInstance:BuffConfigData()
  local effectID = cfg:GetExecEffectID()
  if effectID then
    self._world:GetService("Effect"):CreateEffect(effectID, self._entity)
  end
end

function BuffViewAddBuffByAddBuff:IsNotifyMatch(notify)
  if notify and notify:GetNotifyType() == NotifyType.AfterEntityAddBuff then
    return notify:GetBuffSeq() == self._buffResult:GetAddBuffSeq()
  end
  return false
end
