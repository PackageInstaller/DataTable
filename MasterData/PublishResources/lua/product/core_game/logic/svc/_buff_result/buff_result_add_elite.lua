_class("BuffResultAddElite", BuffResultBase)
BuffResultAddElite = BuffResultAddElite

function BuffResultAddElite:Constructor(eliteIDArray)
  self._eliteIDArray = eliteIDArray
  self._newBuffSeqArray = {}
end

function BuffResultAddElite:GetEliteIDArray()
  return self._eliteIDArray
end

function BuffResultAddElite:AddBuffSeq(buffSeq)
  self._newBuffSeqArray[#self._newBuffSeqArray + 1] = buffSeq
end

function BuffResultAddElite:GetAddBuffSeqArray()
  return self._newBuffSeqArray
end
