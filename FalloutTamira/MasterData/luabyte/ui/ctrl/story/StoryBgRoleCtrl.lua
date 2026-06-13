local M = BaseClass("StoryBgRoleCtrl", require("UI.Ctrl.Story.BaseStoryCtrl"))
local CheckStr = string.isNullOrEmpty
local CheckTbl = table.isNullOrEmpty
local AudioHelper = CS.AudioHelper

function M:Init()
    self.m_roleSpines = { self._view.roleSpine1, self._view.roleSpine2, self._view.roleSpine3 }
    self.m_rectHearts = { self._view.rectHeart1, self._view.rectHeart2, self._view.rectHeart3 }
    self.m_rimgRoles = { self._view.rimgRole1, self._view.rimgRole2, self._view.rimgRole3 }
    self.m_imgEmojis = { self._view.imgEmoji1, self._view.imgEmoji2, self._view.imgEmoji3 }
    self.m_txtHearts = { self._view.txtHeart1, self._view.txtHeart2, self._view.txtHeart3 }
    self.m_shakeRT = self._view.transform:rectTransform() -- ShakeRect
    self.m_videoEndHandler = Bind(self, self.OnVideoEnd)
    self.m_rolePanelRT = self._view.rolePanel
    self.m_bgRoleRT = self._view.transform
    self.m_screenShakeTween = nil
    self.m_roleShakeTween = nil
    self.m_spineTimers = {}
    self.m_animPath = nil
    self.m_spineMat = {}

    local handler = Bind(self, self.OnStoryEndEvent)
    self._view.rectSkip:onClick(Bind(self, self.OnVideoSkipClick))
    self._view.rimgBg1:onClick(Bind(self, self.OnBackgroundClick))
    self.m_storyEndEvent = EventMgr:AddListener(UIMessageNames.STORY_END, handler)
end

function M:OnDispose()
    self:_StopShake()
    self:_StopSpineTimers()
    self.m_bgRoleRT:DoTweenKill()
    self._view.rimgBg1:DoTweenKill()
    for _, comp in ipairs(self.m_rimgRoles) do comp:DoTweenKill() end
    for _, comp in ipairs(self.m_roleSpines) do comp:DoTweenKill() end
    EventMgr:RemoveListener(UIMessageNames.STORY_END, self.m_storyEndEvent)

    self.m_shakeRT = nil
    self.m_spineMat = nil
    self.m_animPath = nil
    self.m_bgRoleRT = nil
    self.m_rimgRoles = nil
    self.m_imgEmojis = nil
    self.m_txtHearts = nil
    self.m_roleSpines = nil
    self.m_rectHearts = nil
    self.m_spineTimers = nil
    self.m_rolePanelRT = nil
    self.m_storyEndEvent = nil
    self.m_roleShakeTween = nil
    self.m_videoEndHandler = nil
    self.m_screenShakeTween = nil
    M.super.OnDispose(self)
end

function M:RefreshBgVisible(storyCfg)
    local cmderType = storyCfg.commanderType
    local isTalk = storyCfg.roleTalk > 0
    local hasSpine = not CheckStr(storyCfg.spinePath)
    local isNone = cmderType == StoryConst.ResponseType.None
    local isCmdVideo = cmderType == StoryConst.ResponseType.Video
    local isVideo = storyCfg.storyType == StoryConst.StoryType.Video
    local isLoopOn = storyCfg.isVideoLoop == StoryConst.IsVideoLoop.On
    self:SetBgRaycastEnable(isNone and (isTalk or (isVideo and not isLoopOn)))
    StoryHelper.SetActive(self._view.media, isVideo or isCmdVideo)
    self:_SetVideoSkipActive(isVideo and isLoopOn or hasSpine)
    StoryHelper.SetActive(self._view.spine, hasSpine)
end

function M:RefreshBgInfo(storyCfg)
    self:_StopSpineTimers()
    self:_SetBackgrounds(storyCfg)
    self:_SetSpine(self._view.spine, storyCfg.spinePath, "Loop")
    self:_SetRolesInfo(storyCfg)
    self:_SetEmojis(storyCfg.emoji)
    self:_SetFocus(storyCfg.focusParam)
    self:_SetHeartDes(storyCfg)
    self:_SetShake(storyCfg)
end

function M:ShowInteractVideoStory(storyCfg)
    self._view.media:UnregisterVideoEnd(self.m_videoEndHandler)
    local animPath = storyCfg.animPath
    if self.m_animPath ~= animPath then
        self.m_animPath = animPath
        local isVideoLoop = storyCfg.isVideoLoop
        local LoopType = StoryConst.IsVideoLoop
        local loop = isVideoLoop == LoopType.On
        if not loop then
            self:_SetVideoSkipActive(false)
            if GameHelper.CheckPostPvState(storyCfg.animPath) then
                AudioHelper.PlayPVStart()
            end
            self._view.media:RegisterVideoEnd(self.m_videoEndHandler)
        end
        self._view.media:SetRaycastEnable(false)
        if (isVideoLoop ~= LoopType.On) and (isVideoLoop ~= LoopType.Off) then
            --loop = true
            self._view.media:Play(animPath, loop)
            self._view.media:SetLoop(isVideoLoop * 0.001)
        else
            self._view.media:Play(animPath, loop)
        end
    end
end

function M:ShowVideoStory(animPath)
    if self.m_animPath ~= animPath then
        self.m_animPath = animPath
        AudioHelper.PlayPVStart()
        self._view.media:SetRaycastEnable(true)
        self._view.media:RegisterVideoEnd(self.m_videoEndHandler)
        self._view.media:Play(animPath, false)
    end
end

function M:SetBgRaycastEnable(enable)
    self._view.rimgBg1:SetRaycastTarget(enable)
end

function M:OnVideoEnd(videoPlayer)
    self._view.media:UnregisterVideoEnd(self.m_videoEndHandler)
    --循环中，则不自动跳过
    if self._view.media.isPlayingLoopClips then return end
    if GameHelper.CheckPostPvState(self.m_animPath) then
        AudioHelper.PlayPVEnd()
    end
    StoryDataMgr:GetInstance():NextStory()
end

function M:OnStoryEndEvent()
    self:SetBgRaycastEnable(false)
    self:_FadeOutRoles()
    self:_FadeOutBg()
end

function M:OnVideoSkipClick()
    local storyCfg = StoryDataMgr:GetInstance():GetStory()
    if storyCfg.storyType == StoryConst.StoryType.Video then
        if storyCfg.isVideoLoop == StoryConst.IsVideoLoop.Off then
            AudioHelper.PlayPVEnd()
            self._view.media:UnregisterVideoEnd(self.m_videoEndHandler)
        end
        self._view.media:Stop()
    end
    self:_SetVideoSkipActive(false)
    StoryDataMgr:GetInstance():SkipStory()
end

function M:OnBackgroundClick()
    EventMgr:Broadcast(UIMessageNames.STORY_CALL_MAIN, "OnClickBackground")
end

function M:OnScreenShakeComplete()
    self.m_shakeRT:Reset()
    self.m_shakeRT:SetStretchAll(0, 0, 0, 0)
    self.m_screenShakeTween = nil
end

function M:OnRoleShakeComplete(index)
    local storyCfg = StoryDataMgr:GetInstance():GetStory()
    local isSpine = not CheckTbl(storyCfg.roleSpine)
    local showlist = isSpine and self.m_roleSpines or self.m_rimgRoles
    self:_SetRolePosition(showlist[index], storyCfg.roleShow, index)
end

function M:_FadeOutRoles()
    local storyCfg = StoryDataMgr:GetInstance():GetStory()
    if storyCfg then
        local isSpine = not CheckTbl(storyCfg.roleSpine)
        for _, rawImg in ipairs(isSpine and self.m_roleSpines or self.m_rimgRoles) do
            if rawImg:IsActiveInHierarchy() then self:_FadeOut(rawImg, self:GetRoleFadeTime()) end
        end
    end
end

function M:_FadeOutBg()
    local rawImgBg1 = self._view.rimgBg1
    if rawImgBg1:IsActiveInHierarchy() then
        local duration = self:GetBackFadeTime() / 1000
        -- rawImgBg1:SetColorByColor(Color.white)
        rawImgBg1:SetDoFade(0, duration):SetTweenUpdate(true):OnTweenComplete(function()
            StoryDataMgr:GetInstance():FinishStory()
        end)
    end
end

function M:_SetBackgrounds(storyCfg)
    local rawImg1, bgRes = self._view.rimgBg1, storyCfg.res
    if CheckStr(bgRes) then
        rawImg1:SetActive(false)
        return
    end

    rawImg1:DoTweenKill()
    rawImg1:SetPic(bgRes, false)
    if StoryHelper.IsFirstStory(storyCfg) then
        self:_FadeIn(rawImg1, self:GetBackFadeTime())
    else
        if StoryDataMgr:GetInstance():IsCrossBgStory(storyCfg) then
            local rawImg2 = self._view.rimgBg2
            rawImg2:DoTweenKill()
            local lastStory = StoryDataMgr:GetInstance():GetLastStory(storyCfg)
            self:_FadeIn(rawImg1, self:GetBackFadeTime())
            rawImg2:SetPic(lastStory.res, false)
            self:_FadeOut(rawImg2, self:GetBackFadeTime())
        else
            if IsNull(rawImg1.texture) or not rawImg1:IsActiveInHierarchy() or
                (storyCfg.skipWay == StoryConst.SkipWay.On) then
                self:_FadeIn(rawImg1, self:GetBackFadeTime())
            end
        end
    end
end

function M:_SetSpine(spine, spinePath, spineAnim, idleAnim, spineDurTime)
    if not CheckStr(spinePath) and spine.SetSpine then
        spine:SetSpine(spinePath, spineAnim)
        if not CheckStr(idleAnim) then
            self.m_spineTimers[spine] = TimerManager:GetInstance():GetTimer(spineDurTime, function()
                self.m_spineTimers[spine] = nil
                spine:SetSpine(spinePath, idleAnim)
            end, nil, true, nil, true)
            self.m_spineTimers[spine]:Start()
        end
    end
end

function M:_SetRolesInfo(storyCfg)
    local roleShow = storyCfg.roleShow
    local EffectOn = StoryConst.Effect.On
    local len = roleShow and #roleShow or 0
    local effect = storyCfg.effect or {}
    local flips = storyCfg.roleFlip or {}
    local scales = storyCfg.roleScale or {}
    local blacks = storyCfg.roleBlack or {}
    local rotates = storyCfg.roleRotate or {}
    local drawimgs = storyCfg.roleDrawing or {}
    local idleAnims = storyCfg.spineAnimEnd or {}
    local highlights = storyCfg.highlightRole or {}
    local flipDur = storyCfg.roleFlipDuration or {}
    local mat = self._view.rimgRemoteEffect.material
    local blackDur = storyCfg.roleBlackDuration or {}
    local scaleDur = storyCfg.roleScaleDuration or {}
    local rotateDur = storyCfg.roleRotateDuration or {}
    local fadeInDur = storyCfg.roleFadeInDuration or {}
    local fadeOutDur = storyCfg.roleFadeOutDuration or {}
    local roleSpines, spineAnims = storyCfg.roleSpine, storyCfg.spineAnime
    local roleMoves = { storyCfg.roleMove1, storyCfg.roleMove2, storyCfg.roleMove3 }
    local isSpine, spineDurTime = not CheckTbl(roleSpines), self:GetSpineTime(storyCfg.roleTalk)

    for i, comp in ipairs(isSpine and self.m_roleSpines or self.m_rimgRoles) do
        comp:DoTweenKill()
        comp:SetActive(i <= len)
        local showEff = (effect[i] or 0) == EffectOn
        if not isSpine then
            comp:SetMaterial(showEff and mat or nil)
            self:_SetRoleDrawing(comp, drawimgs[i])
            self.m_roleSpines[i]:SetActive(false)
        else
            self:_SetSpine(comp, roleSpines[i], spineAnims[i], idleAnims[i], spineDurTime)
            self:_SetSpineMaterial(comp, showEff, mat, i)
            self.m_rimgRoles[i]:SetActive(false)
        end
        self:_FadeIn(comp, fadeInDur[i] or -1)   -- 角色淡入时间
        self:_FadeOut(comp, fadeOutDur[i] or -1) -- 角色淡出时间
        self:_SetRoleHighlight(comp, highlights[i], fadeInDur[i], i)
        self:_SetBlackRole(comp, blacks[i] or 0, blackDur[i])
        self:_SetRoleRotation(comp, rotateDur[i] or -1, rotates[i])
        self:_SetRoleScale(comp, scaleDur[i] or -1, scales[i])
        self:_SetRoleMove(comp, roleShow, roleMoves[i], i)
        self:_SetRoleFlip(comp, flipDur[i] or -1, flips[i])
    end
end

function M:_SetSpineMaterial(comp, isEff, mat, idx)
    if isEff then
        if not self.m_spineMat[idx] then
            self.m_spineMat[idx] = comp.material
        end
        comp:SetMaterial(mat)
    else
        local defMat = self.m_spineMat[idx]
        if defMat then
            comp:SetMaterial(defMat)
            self.m_spineMat[idx] = nil
        end
    end
end

function M:_SetRoleDrawing(rawImg, drawPath)
    if not CheckStr(drawPath) then rawImg:SetPic(drawPath, false) end
end

function M:_SetEmojis(emoji)
    if not emoji then emoji = {} end
    for i, emojiUI in ipairs(self.m_imgEmojis) do
        local value = emoji[i] or 0
        if value ~= 0 then
            emojiUI.transform.parent:SetActive(true)
            emojiUI:SetPic(StoryConst.EmojiPath .. value, false)
        else
            emojiUI.transform.parent:SetActive(false)
        end
    end
end

function M:_SetRoleHighlight(comp, highlight, duration, i)
    if highlight then
        if not duration or (duration <= 0) then
            self:_SetRoleHightlightActive(comp, i, highlight == StoryConst.Highlight.On)
        end
    else
        self:_SetRoleHightlightActive(comp, i, false)
    end
end

function M:_SetRoleHightlightActive(comp, index, active)
    if active then
        comp.transform:SetAsLastSibling()
        comp:SetColorByColor(Color.white)
    else
        comp:SetColorByColor(Color.gray)
    end
end

function M:_FadeIn(rimg, duration)
    if duration == -1 then return end

    rimg:SetActive(true)
    if duration > 0 then
        rimg:SetColorByColor(StoryConst.Color.WhiteZero)
        rimg:SetDoFade(1, duration / 1000):SetTweenUpdate(true)
    end
end

function M:_FadeOut(rimg, duration)
    if duration == -1 then return end

    local state = duration > 0
    rimg:SetActive(state)
    if state then
        -- rimg:SetColorByColor(Color.white)    -- 剧情结束时如有黑色立绘会导致错误的先变白再消失
        rimg:SetDoFade(0, duration / 1000):SetTweenUpdate(true)
    end
end

function M:_SetHeartDes(storyCfg)
    local heartTalk = storyCfg.heartTalk
    if heartTalk > 0 then
        local heartTalkIdx, isSpine = storyCfg.heartTalkIndex, not CheckTbl(storyCfg.roleSpine)
        local showlist = isSpine and self.m_roleSpines or self.m_rimgRoles
        for i, _ in ipairs(storyCfg.roleShow or {}) do
            local active = i == (heartTalkIdx + 1)
            StoryHelper.SetActive(self.m_rectHearts[i], active)
            self:_SetHeartDesPosition(showlist[i], active, i, heartTalk)
        end
    else
        for _, rTrans in ipairs(self.m_rectHearts) do StoryHelper.SetActive(rTrans, false) end
    end
end

function M:_SetHeartDesPosition(comp, active, index, heartTalk)
    if active then
        local x = comp.transform.position.x
        local rectHeart = self.m_rectHearts[index]
        local pos = rectHeart.transform.position
        rectHeart:SetPos(x, pos.y, pos.z)
        self.m_txtHearts[index]:SetText(ConfigHelper.GetLocalStringByPlayerName(heartTalk))
    end
end

function M:_SetBlackRole(rawImg, blackTime, blackDurTime)
    -- 0不变黑；1变黑
    if blackTime ~= 1 then return end

    if not blackDurTime then
        blackDurTime = 0
        Logger.LogError("立绘变黑时间未配置，请 <color=yellow>@杜老师</color>")
    end
    if blackDurTime <= 0 then
        rawImg:SetColor(7, 7, 7, 255)
    else
        rawImg:SetDoColor(7, 7, 7, blackDurTime / 1000):SetTweenUpdate(true)
    end
end

function M:_SetRoleMove(rawImg, roleShow, roleMove, index)
    if CheckTbl(roleMove) then
        self:_SetRolePosition(rawImg, roleShow, index)
    else
        local x, y, duration = roleMove[1] / 1000, roleMove[2] / 1000, roleMove[3] / 1000
        if duration == 0 then
            rawImg:SetRectLocalPoint(self.m_rolePanelRT, x, y)
        else
            rawImg:SetRectDoMove(self.m_rolePanelRT, x, y, duration):SetTweenUpdate(true)
        end
    end
end

function M:_SetRolePosition(rawImg, roleShow, index)
    if not CheckTbl(roleShow) then
        local count = #roleShow
        local offset = 0
        if count == 1 then
            offset = 0.5
        elseif count == 2 then
            offset = 0.33
        elseif count == 3 then
            offset = 0.25
        end
        rawImg:SetRectLocalPoint(self.m_rolePanelRT, offset * index, 0)
    end
end

function M:_SetRoleRotation(rawImg, duration, rotate)
    if duration == -1 then return end

    if duration == 0 then
        rawImg:SetLocalRotation(0, 0, rotate)
    else
        rawImg:SetDoLocalRotateZ(rotate, duration / 1000):SetTweenUpdate(true)
    end
end

function M:_SetRoleScale(rawImg, duration, scale)
    if duration == -1 then return end

    local value = scale / 1000
    if duration == 0 then
        rawImg:SetLocalScale(value, value, value)
    else
        rawImg:SetDoScale(value, duration / 1000):SetTweenUpdate(true)
    end
end

function M:_SetRoleFlip(rawImg, duration, flip)
    if duration == -1 then return end

    local FlipType = StoryConst.FlipType
    if duration == 0 then
        if flip == FlipType.None then
            rawImg:SetLocalRotation(0, 0, 0)
        else
            rawImg:SetLocalRotation(0, 180, 0)
        end
    else
        duration = duration / 1000
        if flip == FlipType.None then
            rawImg:SetDoLocalRotateY(0, duration):SetTweenUpdate(true)
        elseif flip == FlipType.Clockwise then
            rawImg:SetDoLocalRotateY(-180, duration):SetTweenUpdate(true)
        elseif flip == FlipType.AntiClockwise then
            rawImg:SetDoLocalRotateY(180, duration):SetTweenUpdate(true)
        end
    end
end

--focusParam : focusParam[1] = viewport.x,focusParam[2] = viewport.y
--focusParam[3] = scale, focusParam[4] = duration
function M:_SetFocus(focusParam)
    if not CheckTbl(focusParam) then
        local x, y = focusParam[1] / 1000, focusParam[2] / 1000
        local scale, duration = focusParam[3] / 1000, focusParam[4] / 1000
        self.m_bgRoleRT:DoTweenKill()
        if duration == 0 then
            self.m_bgRoleRT:SetRectLocalPoint(self.m_shakeRT, x, y)
            self.m_bgRoleRT:SetLocalScale(scale, scale, scale)
        else
            self.m_bgRoleRT:SetRectDoMove(self.m_shakeRT, x, y, duration, 1):SetTweenUpdate(true)
            self.m_bgRoleRT:SetDoScale(scale, duration):SetTweenUpdate(true)
        end
    end
end

--shakeParam：数组，按顺序分别是力度,振幅,时间
function M:_SetShake(storyCfg)
    self:_StopShake()
    local shakeParam = storyCfg.shakeParam
    if not CheckTbl(shakeParam) then
        local dur = shakeParam[3]
        if not dur or (dur <= 0) then
            Logger.LogError("【严重错误】震屏时间未配置 或<= 0, id = " .. storyCfg.id)
            return
        end
        local shake = storyCfg.shake
        local isSpine = not CheckTbl(storyCfg.roleSpine)
        self:_SetScreenShake(shake, shakeParam)
        self:_SetRoleShake(storyCfg.roleShakeType, shake, shakeParam, isSpine)
    end
end

--shakeParam：数组，按顺序分别是力度,振幅,时间
function M:_SetScreenShake(shake, shakeParam)
    local ShakeType = StoryConst.Shake
    local strength, vibrato, duration = shakeParam[1], shakeParam[2], shakeParam[3] / 1000
    if shake == ShakeType.Screen then
        self.m_screenShakeTween = self.m_shakeRT:SetDoShakePosition(duration, strength, vibrato)
            :SetTweenUpdate(true)
            :OnTweenComplete(Bind(self, self.OnScreenShakeComplete))
    elseif shake == ShakeType.ScreenLR then
        self.m_screenShakeTween = self.m_shakeRT:SetDoShakePositionX(duration, strength, vibrato)
            :SetTweenUpdate(true)
            :OnTweenComplete(Bind(self, self.OnScreenShakeComplete))
    elseif shake == ShakeType.ScreenTB then
        self.m_screenShakeTween = self.m_shakeRT:SetDoShakePositionY(duration, strength, vibrato)
            :SetTweenUpdate(true)
            :OnTweenComplete(Bind(self, self.OnScreenShakeComplete))
    elseif shake == ShakeType.ScreenLoop then
        self.m_screenShakeTween = self.m_shakeRT:SetDoShakePosition(duration, strength, vibrato)
            :SetTweenUpdate(true)
            :SetTweenLoops(-1)
    elseif shake == ShakeType.ScreenLRLoop then
        self.m_screenShakeTween = self.m_shakeRT:SetDoShakePositionX(duration, strength, vibrato)
            :SetTweenUpdate(true)
            :SetTweenLoops(-1)
    elseif shake == ShakeType.ScreenTBLoop then
        self.m_screenShakeTween = self.m_shakeRT:SetDoShakePositionY(duration, strength, vibrato)
            :SetTweenUpdate(true)
            :SetTweenLoops(-1)
    end
end

--shakeParam：数组，按顺序分别是力度,振幅,时间
function M:_SetRoleShake(shakeTypes, shake, shakeParam, isSpine)
    if shake == StoryConst.Shake.RoleShake and not CheckTbl(shakeTypes) then
        local RoleShakeType = StoryConst.RoleShakeType
        local list = isSpine and self.m_roleSpines or self.m_rimgRoles
        for i, value in ipairs(shakeTypes) do
            local strength = shakeParam[i * 3 - 2]
            local vibrato = shakeParam[i * 3 - 1]
            if not strength or not vibrato then
                Logger.LogError("shakeParam 未配置，策划请检查剧情表，剧情工具可查看id。")
                return
            end
            local duration = shakeParam[i * 3] / 1000
            if value == RoleShakeType.Role then
                self.m_roleShakeTween = list[i]:SetDoShakePosition(duration, strength, vibrato)
                    :SetTweenUpdate(true)
                    :OnTweenComplete(Bind(self, self.OnRoleShakeComplete, i))
            elseif value == RoleShakeType.RoleLR then
                self.m_roleShakeTween = list[i]:SetDoShakePositionX(duration, strength, vibrato)
                    :SetTweenUpdate(true)
                    :OnTweenComplete(Bind(self, self.OnRoleShakeComplete, i))
            elseif value == RoleShakeType.RoleTB then
                self.m_roleShakeTween = list[i]:SetDoShakePositionY(duration, strength, vibrato)
                    :SetTweenUpdate(true)
                    :OnTweenComplete(Bind(self, self.OnRoleShakeComplete, i))
            elseif value == RoleShakeType.RoleLoop then
                self.m_roleShakeTween = list[i]:SetDoShakePosition(duration, strength, vibrato)
                    :SetTweenUpdate(true)
                    :SetTweenLoops(-1)
            elseif value == RoleShakeType.RoleLRLoop then
                self.m_roleShakeTween = list[i]:SetDoShakePositionX(duration, strength, vibrato)
                    :SetTweenUpdate(true)
                    :SetTweenLoops(-1)
            elseif value == RoleShakeType.RoleTBLoop then
                self.m_roleShakeTween = list[i]:SetDoShakePositionY(duration, strength, vibrato)
                    :SetTweenUpdate(true)
                    :SetTweenLoops(-1)
            end
        end
    end
end

function M:_StopShake()
    if self.m_screenShakeTween then
        self.m_screenShakeTween:TweenPause()
        self.m_screenShakeTween:TweenKill()
        self.m_screenShakeTween = nil
        self:OnScreenShakeComplete()
    end
    if self.m_roleShakeTween then
        self.m_roleShakeTween:TweenPause()
        self.m_roleShakeTween:TweenKill()
        self.m_roleShakeTween = nil
    end
end

function M:_StopSpineTimers()
    for _, timer in pairs(self.m_spineTimers) do
        if timer then timer:Stop() end
    end
    self.m_spineTimers = {}
end

function M:_SetVideoSkipActive(active)
    if not active then
        self._view.rectSkip:SetActive(active)
    elseif active then
        local story = StoryDataMgr:GetInstance():GetStory()
        self._view.rectSkip:SetActive(story and (story.canSkip == 1) or false)
    end
end

function M:SetSkipActive(active)
    self._view.rectSkip:SetActive(active)
end

function M:GetSkipActive()
    return self._view.rectSkip:IsActiveInHierarchy()
end

return M
