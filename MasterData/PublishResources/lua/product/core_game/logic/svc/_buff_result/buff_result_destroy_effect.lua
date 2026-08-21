require("_buff_result_base")
_class("BuffResultDestroyEffect", BuffResultBase)
BuffResultDestroyEffect = BuffResultDestroyEffect

function BuffResultDestroyEffect:Constructor(objName, waitTime)
  self._objName = objName
  self._waitTime = waitTime
end

function BuffResultDestroyEffect:GetObjName()
  return self._objName
end

function BuffResultDestroyEffect:GetWaitTime()
  return self._waitTime
end
