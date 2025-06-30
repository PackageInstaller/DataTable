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

return _M
