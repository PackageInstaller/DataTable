require("_buff_result_base")
_class("BuffResultChangeFeatureDayData", BuffResultBase)
BuffResultChangeFeatureDayData = BuffResultChangeFeatureDayData

function BuffResultChangeFeatureDayData:Constructor(oldState, newState, restRound)
  self._oldState = oldState
  self._newState = newState
  self._restRound = restRound
end

function BuffResultChangeFeatureDayData:GetOldState()
  return self._oldState
end

function BuffResultChangeFeatureDayData:GetNewState()
  return self._newState
end

function BuffResultChangeFeatureDayData:GetRestRound()
  return self._restRound
end
