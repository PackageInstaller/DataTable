module('guide.GuidePanel', Class.impl(guide.GuideBasePanel))

--初始化UI
function configUI(self)
    super.configUI(self)
    -- 引导数据
    self.m_curGuideData = nil
    self.m_waitForNext = false
    self.m_isFullMark = false

    self.m_contentGo = self:getChildGO('ContentGroup')
    self.m_contentRtrans = self.m_contentGo:GetComponent(ty.RectTransform)
    self.m_contentBGRTrans = self:getChildGO('ContentBG'):GetComponent(ty.RectTransform)
    self.m_contentTxt = self:getChildGO('ContentTxt'):GetComponent(ty.Text)

    self.Content_1 = self:getChildGO("Content_1")
    self.Content_2 = self:getChildGO("Content_2")
    self.Content_3 = self:getChildGO("Content_3")
    self.mUpArrow = self:getChildGO("mUpArrow")
    self.mDownArrow = self:getChildGO("mDownArrow")

    local function _clickTargetCall()
        if self.m_waitForNext == true then return end
        if self.m_curGuideData and self.m_curGuideData.move_next == 1 then
            self.m_waitForNext = true
            guide.GuideManager:runNextGuide()
        end
    end
    local function _clickBGCall()
        if self.m_waitForNext == true then return end
        if self.m_curGuideData and self.m_curGuideData.is_click ~= 1 then
            -- 防止锁死
            if self.m_isFullMark == true or self.m_maskTrans.gameObject.activeSelf == false then
                if self.m_curGuideData and self.m_curGuideData.move_next == 1 then
                    self.m_waitForNext = true
                    guide.GuideManager:runNextGuide()
                end
            end
            return
        end
        -- 可以点背景触发下一个引导 (不用等外界的情况下)
        if self.m_curGuideData and self.m_curGuideData.move_next == 1 then
            self.m_waitForNext = true
            guide.GuideManager:runNextGuide()
        end
    end
    self:setClickCall(_clickTargetCall, _clickBGCall)

    local function _skipCall()
        GameDispatcher:dispatchEvent(EventName.CLOSE_GUIDE_PANEL)
        guide.GuideManager:switchFinishCall(true)
    end
    if not self.m_skipBtnGo then
        self.m_skipBtnGo = self:getChildGO('SkipBtn')
    end
    self:addOnClick(self.m_skipBtnGo, _skipCall)

    self.m_skipBtnGo:SetActive(false)
end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.START_GUIDE_STEP, self._startStep, self)
    GameDispatcher:addEventListener(EventName.NEXT_GUIDE_STEP, self._nextStep, self)
end

function deActive(self)
    LoopManager:clearTimeout(self.m_timeScaleSn)
    self.m_timeScaleSn = nil

    LoopManager:removeFrameByIndex(self.m_markTimeSn)
    self.m_markTimeSn = nil

    self:clearAutoPassSn()

    LoopManager:removeFrameByIndex(self.waitPosSn)
    self.waitPosSn = nil

    GameDispatcher:removeEventListener(EventName.START_GUIDE_STEP, self._startStep, self)
    GameDispatcher:removeEventListener(EventName.NEXT_GUIDE_STEP, self._nextStep, self)
    super.deActive(self)
end

-- 开始步骤
function _startStep(self, gStepData)
    self.m_rootEventClick:SetPierce(false)
    local targetTrans = nil
    if gStepData then
        self.m_curGuideData = gStepData.step
        targetTrans = gStepData.trans
    else
        self.m_curGuideData = guide.GuideManager:getCurStepData()
    end
    self.m_isFullMark = false
    local displayTargetTrans = nil
    if not targetTrans then
        if self.m_curGuideData then
            if self.m_curGuideData.control and self.m_curGuideData.control ~= "" then
                targetTrans = guide.GuideUITransHandler:getTrans(self.m_curGuideData.control)
                displayTargetTrans = guide.GuideUITransHandler:getTrans(self.m_curGuideData.display_control)
            elseif self.m_curGuideData.is_click ~= 1 then
                self.m_isFullMark = true
                -- self.m_rootEventClick:SetPierce(true)
            end
        end
    end

    -- 暂停处理
    local curRo = guide.GuideManager:getCurGuideRo()
    self.autoShowSkip = curRo:getCanPass() == 1

    self:_setupWithGuideStepData()

    if curRo:getCanPass() == 2 then
        self.m_skipBtnGo:SetActive(true)
    else
        self.m_skipBtnGo:SetActive(false)
    end

    if curRo then
        if curRo:getIsPause() == 1 then
            local function _toutCall()
                self.m_timeScaleSn = nil
                fight.FightManager:setupTimeScale(0)
            end
            LoopManager:clearTimeout(self.m_timeScaleSn)
            self.m_timeScaleSn = LoopManager:setTimeout(0.05, nil, _toutCall)
        end
    end
    self:hideMask()

    if self.m_curGuideData.control == "funcTips_formation_item_1205" or self.m_curGuideData.control == "funcTips_formation_item_1110" then
        GameDispatcher:dispatchEvent(EventName.OPEN_FORMATION_HEROLIST, true)
    end

    local function _markTimeCall()
        -- 第一个指向的目标
        if targetTrans then
            self:setStartMask(targetTrans, displayTargetTrans, self.m_curGuideData.is_click ~= 1, self.m_curGuideData)
        elseif self.m_isFullMark == true then
            self:setFullMask()
        end
        self.m_waitForNext = false
    end
    self.m_waitForNext = true

    self:addRealityTimeOut(self.m_curGuideData.delay / 1000, _markTimeCall, curRo:getIsPause() == 1)
end

-- 下一步骤
function _nextStep(self, gStepData)
    if self.waitPosSn then
        LoopManager:removeFrameByIndex(self.waitPosSn)
        self.waitPosSn = nil
    end

    self.m_rootEventClick:SetPierce(false)
    local targetTrans = nil
    local stepData = guide.GuideManager:getCurStepData()
    if gStepData then
        stepData = gStepData.gData or stepData
        targetTrans = gStepData.trans
    end
    self.m_isFullMark = false
    self.m_curGuideData = stepData
    local displayTargetTrans = nil
    if not targetTrans then
        if self.m_curGuideData.control and self.m_curGuideData.control ~= "" then
            targetTrans = guide.GuideUITransHandler:getTrans(self.m_curGuideData.control)
            displayTargetTrans = guide.GuideUITransHandler:getTrans(self.m_curGuideData.display_control)
        elseif self.m_curGuideData.is_click ~= 1 then
            self.m_isFullMark = true
            -- self.m_rootEventClick:SetPierce(true)
        end
    end

    self.m_contentGo:SetActive(false)
    self:hideMask()

    if self.m_curGuideData.control == "funcTips_formation_item_1205" or self.m_curGuideData.control == "funcTips_formation_item_1110" then
        GameDispatcher:dispatchEvent(EventName.OPEN_FORMATION_HEROLIST, true)
    end

    local function _markTimeCall()
        local function callback()
            self:_setupWithGuideStepData()
        end

        if targetTrans then
            self:setObjMask(targetTrans, displayTargetTrans, self.m_curGuideData.is_click ~= 1, self.m_curGuideData, callback)
        elseif self.m_isFullMark == true then
            self:setFullMask()
        end
        self.m_waitForNext = false
    end
    self.m_waitForNext = true

    local curRo = guide.GuideManager:getCurGuideRo()
    self:addRealityTimeOut(self.m_curGuideData.delay / 1000, _markTimeCall, curRo:getIsPause() == 1)
end

function setContentShow(self, contentGo)
    contentGo:SetActive(true)

    local childGos, childTrans = GoUtil.GetChildHash(contentGo)
    local ShowContent = {}
    ShowContent.contentText = childGos["ContentTxt"]:GetComponent(ty.Text)
    ShowContent.setContentText = function (text)
        ShowContent.contentText.text = text
    end
    ShowContent.contentBg = childGos["ContentBG"]:GetComponent(ty.RectTransform)
    return ShowContent
end

function _setupWithGuideStepData(self)
    if self.m_curGuideData then
        self.Content_1:SetActive(false)
        self.Content_2:SetActive(false)
        self.Content_3:SetActive(false)

        if self.m_curGuideData.msg and #self.m_curGuideData.msg > 0 then
            if string.NullOrEmpty(self.m_curGuideData.painting_up) then
                if self.m_curGuideData.text_box == 1 then
                    self.mContentData = self:setContentShow(self.Content_2)
                elseif self.m_curGuideData.text_box == 2 then
                    if self.m_curGuideData.posy < 0 then
                        self.mUpArrow:SetActive(true)
                        self.mDownArrow:SetActive(false)
                    elseif self.m_curGuideData.posy > 0 then
                        self.mUpArrow:SetActive(false)
                        self.mDownArrow:SetActive(true)
                    end
                    self.mContentData = self:setContentShow(self.Content_3)
                end
            else
                self.mContentData = self:setContentShow(self.Content_1)
                if self.m_curGuideData.areaw ~= 0 then
                    gs.TransQuick:SizeDelta(self.mContentData.contentBg, self.m_curGuideData.areaw)
                end
            end

            self.mContentData.setContentText(self.m_curGuideData.msg)
            self.m_contentGo:SetActive(true)
        else
            self.m_contentGo:SetActive(false)
        end

        if self.autoShowSkip then
            local function __autoShowSkip()
                local skipBtn = self:getChildGO('SkipBtn')
                if skipBtn then
                    skipBtn:SetActive(true)
                end
            end

            self:clearAutoPassSn()
            self.autoSn = LoopManager:setTimeout(sysParam.SysParamManager:getValue(70), self, __autoShowSkip)
        end
    else
        self.m_contentGo:SetActive(false)
    end
end

function clearAutoPassSn(self)
    if self.autoSn then
        LoopManager:clearTimeout(self.autoSn)
        self.autoSn = nil
    end
end

function addRealityTimeOut(self, OutTime, callBack, isPause)
    local curTime = 0
    local deltaTime = (1 / gs.Application.targetFrameRate)
    local function _markTimeCall()
        if not isPause then
            deltaTime = (1 / gs.Application.targetFrameRate) * gs.Time.timeScale
        end
        curTime = curTime + deltaTime

        if curTime >= OutTime then
            if callBack then
                callBack()
            end

            LoopManager:removeFrameByIndex(self.m_markTimeSn)
        end
    end

    LoopManager:removeFrameByIndex(self.m_markTimeSn)
    self.m_markTimeSn = LoopManager:addFrame(1, 0, nil, _markTimeCall)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
