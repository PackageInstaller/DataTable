module("AnimatorUtil", Class.impl())

function getAnimatorClipTime(animator, aniName)
    local clips = animator.runtimeAnimatorController.animationClips
    for i = 0, clips.Length - 1 do
        if clips[i].name == aniName then
            return clips[i].length
        end
    end

    Debug:log_error("不存在名为" .. tostring(aniName) .. "的动画片段:")
end

--（获取当前播放状态hash值）
function getCurStateHash(animator, layer_index)
    local animatorStateInfo = AnimatorUtil.getCurStateInfo(animator, layer_index)
    if not animatorStateInfo then
        return
    end

    return animatorStateInfo.shortNameHash
end

--获取当前播放的状态进度（0-1）
function getCurStateNormalizedTime(animator, layer_index)
    local animatorStateInfo = AnimatorUtil.getCurStateInfo(animator, layer_index)
    if not animatorStateInfo then
        return
    end
    return animatorStateInfo.normalizedTime
end

--获取当前层的播放信息
function getCurStateInfo(animator, layer_index)
    if not animator then return end

    layer_index = layer_index or 0
    return animator:GetCurrentAnimatorStateInfo(layer_index)
end

--通过hash值判断是否正在播放这个动作
function isPlayHash(animator, anim_hash, layer_index)
    return AnimatorUtil.getCurStateHash(animator, layer_index) == anim_hash
end

--通过动作名判断是否正在播放这个动作
function isPlayAni(animator, anim_name, layer_index)
    return AnimatorUtil.isPlayHash(animator, gs.Animator.StringToHash(anim_name), layer_index)
end

--判断Animator是否有这个参数
function haseParameter(animator, parameterName, parameterType)
    if gs.GoUtil.IsCompNull(animator) or string.NullOrEmpty(parameterName) then
        return false
    end

    local parameterHash = gs.Animator.StringToHash(parameterName)
    for i = 0, animator.parameters.Length - 1 do
        local parameter = animator.parameters[i]
        if (parameter.nameHash == parameterHash and parameter.type == parameterType) then
            return true
        end
    end
    return false
end

return _M
