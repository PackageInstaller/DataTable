_class("BuffResultModifyRestRound", BuffResultBase)
BuffResultModifyRestRound = BuffResultModifyRestRound

function BuffResultModifyRestRound:Constructor(curWaveRound, curWaveRoundDiff)
  self._curWaveRound = curWaveRound
  self._curWaveRoundDiff = curWaveRoundDiff
end

function BuffResultModifyRestRound:GetCurWaveRound()
  return self._curWaveRound
end

function BuffResultModifyRestRound:GetCurWaveRoundDiff()
  return self._curWaveRoundDiff
end
