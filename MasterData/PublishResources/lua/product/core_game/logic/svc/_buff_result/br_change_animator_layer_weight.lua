_class("BuffResultChangeAnimatorLayerWeight", BuffResultBase)
BuffResultChangeAnimatorLayerWeight = BuffResultChangeAnimatorLayerWeight

function BuffResultChangeAnimatorLayerWeight:Constructor(changeInfo)
  self._changeInfo = changeInfo
end

function BuffResultChangeAnimatorLayerWeight:GetChangeInfo()
  return self._changeInfo
end
