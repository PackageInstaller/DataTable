require("_buff_result_base")
_class("BuffResultRefreshFeatureTrapDefenceHPPercent", BuffResultBase)
BuffResultRefreshFeatureTrapDefenceHPPercent = BuffResultRefreshFeatureTrapDefenceHPPercent

function BuffResultRefreshFeatureTrapDefenceHPPercent:Constructor(curHPPercent)
  self._curHPPercent = curHPPercent
end

function BuffResultRefreshFeatureTrapDefenceHPPercent:GetHPPercent()
  return self._curHPPercent
end
