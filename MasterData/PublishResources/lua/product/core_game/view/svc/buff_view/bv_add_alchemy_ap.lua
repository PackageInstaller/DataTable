_class("BuffViewAddAlchemyAP", BuffViewBase)
BuffViewAddAlchemyAP = BuffViewAddAlchemyAP

function BuffViewAddAlchemyAP:PlayView(TT)
  local featureSvcRender = self._world:GetService("FeatureRender")
  if featureSvcRender then
    featureSvcRender:NotifyAlchemyAPChange(TT, self._buffResult._finalAP, self._buffResult._finalLevel, self._buffResult._ap)
  end
  local playBuffSvc = self._world:GetService("PlayBuff")
  local arr = self._buffResult:GetBuffArray()
  for i, v in ipairs(arr) do
    local eid, seq = v[1], v[2]
    Log.debug("BuffViewAddAlchemyAP entityid=", eid, "buffseq=", seq, "trace: ")
    local entity = self._world:GetEntityByID(eid)
    if entity then
      local inst = entity:BuffView():GetBuffViewInstance(seq)
      if inst then
        playBuffSvc:PlayAddBuff(TT, inst)
      end
    end
  end
end
