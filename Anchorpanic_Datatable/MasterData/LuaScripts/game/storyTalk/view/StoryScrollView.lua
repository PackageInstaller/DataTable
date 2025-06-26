module('storyTalk.StoryScrollView', Class.impl('lib.component.BaseNode'))

function initData(self, rootGo)
    super.initData(self, rootGo)
    self.mStoryScrollBG = self:getChildGO("mStoryScrollBG"):GetComponent(ty.AutoRefImage)
    self.mStoryScrollBGCanvasGroup = self:getChildGO("mStoryScrollBGCanvasGroup"):GetComponent(ty.CanvasGroup)
    self.mStoryScrollRect = self:getChildGO("mStoryScrollRect"):GetComponent(ty.ScrollRect)
    self.mStoryScrollCanvasGroup = self.mStoryScrollRect:GetComponent(ty.CanvasGroup)
    self.mStoryScrollTxt = self:getChildGO("mStoryScrollTxt"):GetComponent(ty.Text)
    self.mJumpStoryScrollBtn = self:getChildGO("mJumpStoryScrollBtn")
    self.mJumpStoryScrollTxt = self:getChildGO("mJumpStoryScrollTxt"):GetComponent(ty.Text)
    self:addOnClick(self.mJumpStoryScrollBtn, self.onJumpStoryScrollClick)

    self.addPosY = 0.4 -- Y轴增量/帧

    self.txtStartAlpha = 0
    self.txtEndAlpha = 1
    self.txtAlphaTime = 1

    self.bgStartAlpha = 0
    self.bgEndAlpha = 0.7
    self.bgAlphaTime = 1
end

-- 跳过剧本演出点击
function onJumpStoryScrollClick(self)
    self:close()
end

function open(self, curData, finishCall)
    self.finishCall = finishCall
    self.mStoryScrollBG:SetImg(UrlManager:getBgPath(curData.roll_bg), false)
    self.mStoryScrollTxt.text = curData.roll_str

    gs.Canvas.ForceUpdateCanvases()
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mStoryScrollTxt.gameObject.transform)

    TweenFactory:canvasGroupAlphaTo(self.mStoryScrollCanvasGroup, self.txtStartAlpha, self.txtEndAlpha,
        self.txtAlphaTime)
    TweenFactory:canvasGroupAlphaTo(self.mStoryScrollBGCanvasGroup, self.bgStartAlpha, self.bgEndAlpha,
        self.bgAlphaTime, nil, nil)

    self.mStoryScrollRect.content.anchoredPosition = gs.VEC2_ZERO
    self.storySrollTween = LoopManager:addFrame(1, 0, self, self.onUpdateStoryTxt)
    self:setActive(true)
end

function onUpdateStoryTxt(self)
    local currentPos = self.mStoryScrollRect.content.anchoredPosition
    local newPos = currentPos
    local maxH = self.mStoryScrollTxt:GetComponent(ty.RectTransform).rect.height

    if currentPos.y > maxH then
        LoopManager:removeFrameByIndex(self.storySrollTween)
        self:close()
    else
        newPos.y = currentPos.y + (gs.Input.GetMouseButton(0) and self.addPosY * 3 or self.addPosY)
        self.mStoryScrollRect.content.anchoredPosition = newPos
    end
end

function close(self)
    local function tweenEnd()
        self.storySrollTween = nil
        self:setActive(false)
        self.finishCall()
    end

    LoopManager:removeFrameByIndex(self.storySrollTween)
    TweenFactory:canvasGroupAlphaTo(self.mStoryScrollCanvasGroup, self.txtEndAlpha, self.txtStartAlpha,
        self.txtAlphaTime)
    TweenFactory:canvasGroupAlphaTo(self.mStoryScrollBGCanvasGroup, self.bgEndAlpha, self.bgStartAlpha,
        self.bgAlphaTime, nil, tweenEnd)
end

return _M
