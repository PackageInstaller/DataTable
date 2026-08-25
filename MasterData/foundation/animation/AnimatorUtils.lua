local AnimatorUtils = {}
local CSAnimator = CS.UnityEngine.Animator
local _triggerParamHashMap = {}
local _stateNameHashMap = {}

function AnimatorUtils.PlayState(animator, stateName, layer, normalizedTime)
  if not animator then
    return
  end
  local stateNameHash = AnimatorUtils.GetStateNameHash(stateName)
  animator:Play(stateNameHash, layer or -1, normalizedTime or 0)
end

function AnimatorUtils.PlayBlendParams(animator, name, argType, arg)
  if not (animator and name) or not argType then
    return false
  end
  local hash = AnimatorUtils.GetTriggerNameHash(name)
  if "Trigger" == argType then
    animator:ResetTrigger(hash)
    animator:SetTrigger(hash)
  end
  if "Int" == argType then
    animator:SetInteger(hash, arg)
  end
  if "Bool" == argType then
    animator:SetBool(hash, arg)
  end
  if "Float" == argType then
    animator:SetFloat(hash, arg)
  end
  return true
end

function AnimatorUtils.SetTrigger(animator, triggerName)
  if not animator then
    return
  end
  animator:ResetTrigger(AnimatorUtils.GetTriggerNameHash(triggerName))
  animator:SetTrigger(AnimatorUtils.GetTriggerNameHash(triggerName))
end

function AnimatorUtils.ResetAnimtor(animator, stateName)
  if not animator then
    return
  end
  local stateNameHash = AnimatorUtils.GetStateNameHash(stateName)
  animator:Play(stateNameHash)
  animator:Update(0)
end

function AnimatorUtils.GetCurrentAnimatorClipInfo(animator, layerIndex)
  do return animator.GetCurrentAnimatorClipInfo, animator end
  return animator.GetCurrentAnimatorClipInfo, animator, layerIndex
end

function AnimatorUtils.GetClipTime(animator, clipName)
  if not animator or not animator.runtimeAnimatorController then
    return
  end
  local clips = animator.runtimeAnimatorController.animationClips
  for i = 0, clips.Length - 1 do
    local clip = clips[i]
    if clip.name == clipName then
      return clip.length
    end
  end
  return
end

function AnimatorUtils.SetStateEndInBehavior(animator, name, callback)
  if not animator or not callback then
    return false
  end
  local ret = false
  local behaviors = animator:GetAnimatorStateBehaviors()
  local size = behaviors.Length
  for i = 0, size - 1 do
    if not name or behaviors[i].name == name then
      ret = true
      behaviors[i]:onStateEnd("-", callback)
      behaviors[i]:onStateEnd("+", callback)
    end
  end
  if not ret and callback then
    callback()
  end
  return ret
end

function AnimatorUtils.DelStateEndInBehavior(animator, name, callback)
  if not animator or not callback then
    return false
  end
  local behaviors = animator:GetAnimatorStateBehaviors()
  local size = behaviors.Length
  for i = 0, size - 1 do
    if not name or behaviors[i].name == name then
      behaviors[i]:onStateEnd("-", callback)
    end
  end
end

function AnimatorUtils.SetStateCompleteInBehavior(animator, name, callback)
  if not animator or not callback then
    return false
  end
  local ret = false
  local behaviors = animator:GetAnimatorStateBehaviors()
  local size = behaviors.Length
  for i = 0, size - 1 do
    if not name or behaviors[i].name == name then
      ret = true
      behaviors[i]:onStateComplete("-", callback)
      behaviors[i]:onStateComplete("+", callback)
    end
  end
  if not ret and callback then
    callback()
  end
  return ret
end

function AnimatorUtils.DelStateCompleteInBehavior(animator, name, callback)
  if not animator or not callback then
    return false
  end
  local behaviors = animator:GetAnimatorStateBehaviors()
  local size = behaviors.Length
  for i = 0, size - 1 do
    if not name or behaviors[i].name == name then
      behaviors[i]:onStateComplete("-", callback)
    end
  end
end

function AnimatorUtils.SetBehaviorOnStateEnd(behavior, callback)
  behavior:onStateEnd("+", function(hash)
    if callback then
      callback(hash)
    end
  end)
end

function AnimatorUtils.GetTriggerNameHash(triggerName)
  _triggerParamHashMap[triggerName] = _triggerParamHashMap[triggerName] or CSAnimator.StringToHash(triggerName)
  return _triggerParamHashMap[triggerName]
end

function AnimatorUtils.GetStateNameHash(stateName)
  _stateNameHashMap[stateName] = _stateNameHashMap[stateName] or CSAnimator.StringToHash(stateName)
  return _stateNameHashMap[stateName]
end

function AnimatorUtils.AddClipToPlay(finalStr, clipName)
  finalStr = finalStr or ""
  clipName = clipName or ""
  local symbol = ","
  if "" == finalStr or "" == clipName then
    symbol = ""
  end
  return finalStr .. symbol .. clipName
end

return AnimatorUtils
