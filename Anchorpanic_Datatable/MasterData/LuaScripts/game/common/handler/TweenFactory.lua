local TweenFactory = Class.class('TweenFactory')

-- function TweenFactory:ctor()
-- end
--[[_s
@todo:把transform移动到lpos
@param: transform 移动的物体
@param: lpos 移动的目标点
@param: duration 移动所用的时间
@param: easeType 移动的类型 (默认可为nil)
@param: finishCall 完成移动的回调 (回调不带参数, 默认可为nil)
@return: tweener
]]
function TweenFactory:move2Lpos(transform, lpos, duration, easeType, finishCall, isLoop, loopType, loopTimes)
    local tweener = transform:DOLocalMove(lpos, duration)
    if easeType then tweener:SetEase(easeType) end
    if finishCall then
        tweener:OnComplete(finishCall)
    end
    if (isLoop) then
        tweener:SetLoops(loopTimes or -1, loopType or gs.DT.LoopType.Yoyo)
    end
    return tweener
end

function TweenFactory:move2pos(transform, pos, duration, easeType, finishCall, isLoop, loopType, loopTimes)
    local tweener = transform:DOMove(pos, duration)
    if easeType then tweener:SetEase(easeType) end
    if finishCall then
        tweener:OnComplete(finishCall)
    end
    if (isLoop) then
        tweener:SetLoops(loopTimes or -1, loopType or gs.DT.LoopType.Yoyo)
    end
    return tweener
end

function TweenFactory:moveLocalBezier(transform, startPos, controllPos, endPos, duration, easeType, finishCall, isLoop, loopType, loopTimes)
    local tweener = transform:DOLocalBezier(startPos, controllPos, endPos, duration)
    if easeType then tweener:SetEase(easeType) end
    if finishCall then
        tweener:OnComplete(finishCall)
    end
    if (isLoop) then
        tweener:SetLoops(loopTimes or -1, loopType or gs.DT.LoopType.Yoyo)
    end
    return tweener
end

--[[_s
@todo:把transform移动到x方向的lposX（只在x上移动）
@param: transform 移动的物体
@param: lposX 移动的目标点
@param: duration 移动所用的时间
@param: easeType 移动的类型 (默认可为nil)
@param: finishCall 完成移动的回调 (回调不带参数, 默认可为nil)
@return: tweener
]]
function TweenFactory:move2LPosX(transform, lposX, duration, easeType, finishCall, delayTween, isLoop, loopType, loopTimes)
    local sequence = gs.DT.DOTween.Sequence()

    local tweener = transform:DOLocalMoveX(lposX, duration)
    if easeType then tweener:SetEase(easeType) end
    -- if finishCall then
    --     tweener:OnComplete(finishCall)
    -- end
    if (delayTween) then
        sequence:AppendInterval(delayTween)
    end
    sequence:Append(tweener)
    sequence:Play()

    if finishCall then
        sequence:OnComplete(finishCall)
    end
    if (isLoop) then
        sequence:SetLoops(loopTimes or -1, loopType or gs.DT.LoopType.Yoyo)
    end
    return sequence
end

--[[_s
@todo:把transform移动到y方向的点lposY（只在Y上移动）
@param: transform 移动的物体
@param: lposY 	移动的目标点
@param: duration 移动所用的时间
@param: easeType 移动的类型 (默认可为nil)
@param: finishCall 完成移动的回调 (回调不带参数, 默认可为nil)
@return: tweener
]]
function TweenFactory:move2LPosY(transform, lposY, duration, easeType, finishCall, isLoop, loopType, loopTimes)
    local tweener = transform:DOLocalMoveY(lposY, duration)
    if easeType then tweener:SetEase(easeType) end	--动画类型gs.DT.Ease.Flash
    if finishCall then
        tweener:OnComplete(finishCall)
    end
    if (isLoop) then
        tweener:SetLoops(loopTimes or -1, loopType or gs.DT.LoopType.Yoyo)
    end
    return tweener
end

function TweenFactory:move2LPosZ(transform, lposZ, duration, easeType, finishCall, isLoop, loopType, loopTimes)
    local tweener = transform:DOLocalMoveZ(lposZ, duration)
    if easeType then tweener:SetEase(easeType) end	--动画类型gs.DT.Ease.Flash
    if finishCall then
        tweener:OnComplete(finishCall)
    end
    if (isLoop) then
        tweener:SetLoops(loopTimes or -1, loopType or gs.DT.LoopType.Yoyo)
    end
    return tweener
end

--[[_s
@todo:把transform移动到x方向的posX（只在x上移动）
@param: transform 移动的物体
@param: posX 移动的目标点
@param: duration 移动所用的时间
@param: easeType 移动的类型 (默认可为nil)
@param: finishCall 完成移动的回调 (回调不带参数, 默认可为nil)
@return: tweener
]]
function TweenFactory:move2PosXEx(transform, lposX, duration, easeType, finishCall)
    local tweener = transform:DOMoveUIX(lposX, duration)
    if easeType then tweener:SetEase(easeType) end
    if finishCall then
        tweener:OnComplete(finishCall)
    end
    return tweener
end

function TweenFactory:lRotate(transform, rotateV3, duration, finishCall)
    local tweener = transform:DOLocalRotate(rotateV3, duration)
    if finishCall then
        tweener:OnComplete(finishCall)
    end
    return tweener
end
function TweenFactory:lRotate2(transform, rotate, duration, finishCall)
    local tweener = transform:DOLocalRotateXYZ(rotate.x, rotate.y, rotate.z, duration)
    if finishCall then
        tweener:OnComplete(finishCall)
    end
    return tweener
end

function TweenFactory:rotate(transform, rotate, duration, finishCall)
    local tweener = transform:DORotateXYZ(rotate.x, rotate.y, rotate.z, duration)
    if finishCall then
        tweener:OnComplete(finishCall)
    end
    return tweener
end

function TweenFactory:lRotateY(transform, y, duration, finishCall)
    local tweener = transform:DOLocalRotateY(y, duration)
    if finishCall then
        tweener:OnComplete(finishCall)
    end
    return tweener
end

function TweenFactory:jumpTo(trans, lposY, targetPos, duration, easeType, finishCall)
    local sequence = gs.DT.DOTween.Sequence()
    local move_Tweener = self:move2LPosY(trans, lposY, duration, easeType)
    local move1_Tweener = self:move2Lpos(trans, targetPos, duration, easeType)

    if easeType then
        move_Tweener:SetEase(easeType)
        move1_Tweener:SetEase(easeType)
    end

    sequence:Join(move_Tweener)
    sequence:Join(move1_Tweener)
    sequence:Play()

    if finishCall then
        sequence:OnComplete(finishCall)
    end
    return sequence
end

function TweenFactory:canvasGroupAlphaTo(canvasGroup, startAlpha, endAlpha, duration, easeType, finishCall, delayTween, isLoop, loopType, loopTimes)
    if(startAlpha)then
        canvasGroup.alpha = startAlpha
    end
    local sequence = gs.DT.DOTween.Sequence()
    local fade_Tweener = canvasGroup:DOFade(endAlpha, duration)

    if easeType then
        fade_Tweener:SetEase(easeType)
    end
    if (delayTween) then
        sequence:AppendInterval(delayTween)
    end
    sequence:Append(fade_Tweener)
    sequence:Play()

    if finishCall then
        sequence:OnComplete(finishCall)
    end
    if (isLoop) then
        sequence:SetLoops(loopTimes or -1, loopType or gs.DT.LoopType.Yoyo)
    end
    return sequence
end

function TweenFactory:propsMoveTo(rect, startScale, endScale, startSize, endSize, startPos, endPos, duration, easeType, finishCall)
    gs.TransQuick:Pos(rect, startPos.x, startPos.y, startPos.z)
    gs.TransQuick:Scale(rect, startScale.x, startScale.y, startScale.z)
    gs.TransQuick:SizeDelta(rect, startSize.x, startSize.y)

    local sequence = gs.DT.DOTween.Sequence()
    local scale_Tweener = rect:DOScale(endScale, duration)
    local size_Tweener = rect:DOSizeDelta(endSize, duration)
    local move_Tweener = self:move2pos(rect, endPos, duration, easeType)

    if easeType then
        scale_Tweener:SetEase(easeType)
        size_Tweener:SetEase(easeType)
        move_Tweener:SetEase(easeType)
    end

    sequence:Join(scale_Tweener)
    sequence:Join(size_Tweener)
    sequence:Join(move_Tweener)
    sequence:Play()

    if finishCall then
        gs.TransQuick:Pos(rect, startPos.x, startPos.y, startPos.z)
        gs.TransQuick:Scale(rect, startScale.x, startScale.y, startScale.z)
        gs.TransQuick:SizeDelta(rect, startSize.x, startSize.y)
        sequence:OnComplete(finishCall)
    end
    return sequence
end

function TweenFactory:scaleTo(rect, startV3, endV3, duration, easeType, finishCall)
    if startV3 then
        gs.TransQuick:Scale(rect, startV3.x, startV3.y, startV3.z)
    end

    local sequence = gs.DT.DOTween.Sequence()
    local scale_Tweener = rect:DOScale(endV3, duration)

    if easeType then
        scale_Tweener:SetEase(easeType)
    end

    sequence:Join(scale_Tweener)
    sequence:Play()

    if finishCall then
        gs.TransQuick:Scale(rect, startV3.x, startV3.y, startV3.z)
        sequence:OnComplete(finishCall)
    end
    return sequence
end

function TweenFactory:scaleTo01(rect, startVal, endVal, duration, easeType, finishCall)
    gs.TransQuick:Scale0(rect, startVal)

    local scale_Tweener = rect:DOScale(endVal, duration)
    if easeType then
        scale_Tweener:SetEase(easeType)
    end

    if finishCall then
        scale_Tweener:OnComplete(finishCall)
    end
    return scale_Tweener
end

function TweenFactory:scaleTo02(rect, startVal, endVal, duration1, duration2, easeType, finishCall)
    if startVal then
        gs.TransQuick:Scale0(rect, startVal)
    end

    local sequence = gs.DT.DOTween.Sequence()
    local scale_Tweener = rect:DOScale(endVal, duration1)

    if easeType then
        scale_Tweener:SetEase(easeType)
    end
    sequence:Append(scale_Tweener)
    scale_Tweener = rect:DOScale(startVal, duration2)
    sequence:Append(scale_Tweener)

    sequence:Play()

    if finishCall then
        sequence:OnComplete(finishCall)
    end
    return sequence
end

function TweenFactory:widthTo(rect, startWidth, endWidth, duration, easeType, finishCall)
    if startWidth then
        gs.TransQuick:SizeDelta01(rect, startWidth)
    end

    local sequence = gs.DT.DOTween.Sequence()
    local width_Tweener = rect:DOWidth(endWidth, duration)

    if easeType then
        width_Tweener:SetEase(easeType)
    end

    sequence:Join(width_Tweener)
    sequence:Play()

    if finishCall then
        sequence:OnComplete(finishCall)
    end
    return sequence
end

return TweenFactory

--[[ 替换语言包自动生成，请勿修改！
]]