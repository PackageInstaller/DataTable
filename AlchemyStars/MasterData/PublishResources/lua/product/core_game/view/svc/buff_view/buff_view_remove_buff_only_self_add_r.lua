_class("BuffViewRemoveBuffOnlySelfAdd", BuffViewBase)
BuffViewRemoveBuffOnlySelfAdd = BuffViewRemoveBuffOnlySelfAdd

function BuffViewRemoveBuffOnlySelfAdd:IsNotifyMatch(notify)
  local result = self._buffResult
  return true
end

function BuffViewRemoveBuffOnlySelfAdd:PlayView(TT, notify)
  local playBuffSvc = self._world:GetService("PlayBuff")
  local result = self._buffResult
  local arr = result:GetBuffArray()
  for i, v in ipairs(arr) do
    local eid = v.eid
    local tSeqID = v.tSeqID
    local entity = self._world:GetEntityByID(eid)
    if entity then
      for _, seq in ipairs(tSeqID) do
        local inst = entity:BuffView():GetBuffViewInstance(seq)
        if inst then
          playBuffSvc:PlayRemoveBuff(TT, inst, NTBuffUnload:New())
        end
      end
    end
  end
end
