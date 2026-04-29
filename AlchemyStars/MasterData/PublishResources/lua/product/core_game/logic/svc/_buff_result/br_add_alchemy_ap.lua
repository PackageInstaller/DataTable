_class("BuffResultAddAlchemyAP", BuffResultBase)
BuffResultAddAlchemyAP = BuffResultAddAlchemyAP

function BuffResultAddAlchemyAP:Constructor()
  self._buffArray = {}
end

function BuffResultAddAlchemyAP:AddAlchemyAP(finalAP, finalLevel, ap)
  self._ap = ap
  self._finalLevel = finalLevel
  self._finalAP = finalAP
end

function BuffResultAddAlchemyAP:GetBuffArray()
  return self._buffArray
end

function BuffResultAddAlchemyAP:AddBuffData(eid, buffseq)
  table.insert(self._buffArray, {eid, buffseq})
end
