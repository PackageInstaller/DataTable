require("_buff_result_base")
_class("BuffResultPlayEffectAnim", BuffResultBase)
BuffResultPlayEffectAnim = BuffResultPlayEffectAnim

function BuffResultPlayEffectAnim:Constructor(objName, animName, waitTime)
  self._objName = objName
  self._animName = animName
  self._waitTime = waitTime
end

function BuffResultPlayEffectAnim:GetObjName()
  return self._objName
end

function BuffResultPlayEffectAnim:GetAnimName()
  return self._animName
end

function BuffResultPlayEffectAnim:GetWaitTime()
  return self._waitTime
end
