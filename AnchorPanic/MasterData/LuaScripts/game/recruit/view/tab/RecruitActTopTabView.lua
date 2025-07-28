module("recruit.RecruitActTopTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("recruit/tab/RecruitActTopTab.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.m_recruitType = recruit.RecruitType.RECRUIT_ACTIVITY_1
end

function configUI(self)
    self.mBtnLog = self:getChildGO("BtnLog")
    self.mBtnRule = self:getChildGO("BtnRule")
    self.mBtnOne = self:getChildGO("BtnOne")
    self.mBtnTen = self:getChildGO("BtnTen")
    self.mBtnTrial = self:getChildGO("BtnTrial")
    self.mBtnDetails = self:getChildGO("mBtnDetails")

    self.mPropsIcon_one = self:getChildGO("PropsIcon_one"):GetComponent(ty.AutoRefImage)
    self.mTxtCount_one = self:getChildGO("TextCount_one"):GetComponent(ty.Text)
    self.mPropsIcon_ten = self:getChildGO("PropsIcon_ten"):GetComponent(ty.AutoRefImage)
    self.mTextCount_ten = self:getChildGO("TextCount_ten"):GetComponent(ty.Text)

    self.mImgPro = self:getChildGO("mImgPro"):GetComponent(ty.AutoRefImage)
    self.mImgEleType = self:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)

    self.mTextRemainTimes_1 = self:getChildGO("TextRemainTimes_1"):GetComponent(ty.Text)
    self.mTextRemainTimes_2 = self:getChildGO("TextRemainTimes_2"):GetComponent(ty.Text)
    self.mTextRemainTimes_3 = self:getChildGO("TextRemainTimes_3"):GetComponent(ty.Text)
    self.mTxtActivetyTime = self:getChildGO("mTxtActivetyTime"):GetComponent(ty.Text)
    self.mText_1 = self:getChildGO("mText_1"):GetComponent(ty.Text)
    self.mTxtData = self:getChildGO("mTxtData"):GetComponent(ty.Text)
    self.mDebugUpInfo = self:getChildGO("mDebugUpInfo")

    -- self.mGlow = self:getChildGO("mGlow")

    self.mAvproPlayer = self:getChildGO("MediaPlayer"):GetComponent(ty.MediaPlayer)
    AvproUtil:init(self.mAvproPlayer)

    self.mGroupBg = self:getChildGO("mGroupBg")
    -- self.mGroupBg:SetActive(false)

    self.mTrialRedPoint = self:getChildTrans("mTrialRedPoint")
end

function active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_RECRUIT_PANEL, self.onUpdateViewHandler, self)
    GameDispatcher:addEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.updateTrial_RedState, self)

    -- self.mGlow:SetActive(false)

    self.mGroupBg:SetActive(true)
    self.mAvproPlayer.gameObject:SetActive(false)

    -- self:outTimePlayMedia()

    self:updateView()
    self:updateShowActivetyTimer()
    self:updateTrial_RedState()
end

function deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_RECRUIT_PANEL, self.onUpdateViewHandler, self)
    GameDispatcher:removeEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.updateTrial_RedState, self)

    -- self:clearAcitivety()

    self.mGroupBg:SetActive(false)

    if self.mAvproPlayer then
        self.mAvproPlayer:CloseVideo()
        self.mAvproPlayer.Events:RemoveAllListeners()
    end

    if self.tween1 then
        self.tween1:Kill()
    end
    if self.tween2 then
        self.tween2:Kill()
    end
end

function initViewText(self)
    self:setBtnLabel(self.mBtnOne, 28007, "招募一次")
    self:setBtnLabel(self.mBtnTen, 28008, "招募十次")

    self.mText_1.text = _TT(551)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnLog, self.onClickLogHandler)
    self:addUIEvent(self.mBtnRule, self.onClickRuleHandler)
    self:addUIEvent(self.mBtnOne, self.onClickOneHandler)
    self:addUIEvent(self.mBtnTen, self.onClickTenHandler)
    self:addUIEvent(self.mBtnTrial, self.onClickTrial)
    self:addUIEvent(self.mBtnDetails, self.onClickDetails)
end

function playMedia(self)
    if self.mAvproPlayer then
        self.mAvproPlayer:Stop()
        self.mAvproPlayer:CloseVideo()

        self.mAvproPlayer:OpenVideoFromFile(gs.MediaPlayer.FileLocation.AbsolutePathOrURL,
            gs.PathUtil.GetExistFullPath("extra/video/ui/aoyi_cg.mp4"), false)
        self.mAvproPlayer:Play()
        AvproUtil:setVolume(self.mAvproPlayer, 100)

        local onMediaPlayerEvent = function(mediaPlayer, eventType, errorCode)
            if eventType == gs.MediaPlayerEventType.FinishedPlaying then
                self.mAvproPlayer.Events:RemoveAllListeners()
                -- 视频播放完成
                self.mAvproPlayer:Stop()

                -- self.mGlow:SetActive(true)
                self:outTimePlayMedia()
            end
        end

        self.mAvproPlayer.Events:AddListener(onMediaPlayerEvent)
    end
end

function outTimePlayMedia(self)
    self.mGroupBg:SetActive(true)
    self:setTimeout(6, function()
        self.mGroupBg:SetActive(false)
        self:playMedia()
    end)
end

function updateShowActivetyTimer(self)
    -- self:clearAcitivety()

    self:showActivetyTime()
    -- self.activetyTimeShowTimer = self:addTimer(1,0,self.showActivetyTime)
end

function showActivetyTime(self)
    -- local clientTime = GameManager:getClientTime()

    -- local configVo = recruit.RecruitManager:getRecruitMenuVo(self.m_recruitType)
    -- local configEndTime = configVo.endTime
    -- local endTime = TimeUtil.transTime(configEndTime)
    -- local surplusTime = endTime - clientTime
    -- if surplusTime <= 0 then
    --     GameDispatcher:dispatchEvent(EventName.UPDATE_RECRUIT_PANEL)
    --     -- self:clearAcitivety()
    --     return
    -- end
    -- local str = TimeUtil.getFormatTimeBySeconds_9(surplusTime)

    local menuVo = recruit.RecruitManager:getRecruitMenuVo(self.m_recruitType)
    -- local beginTime = TimeUtil.getMDHByTime2(TimeUtil.transTime(menuVo.beginTime))
    local endTime, endHour = TimeUtil.getMDHByTime2(TimeUtil.transTime(menuVo.endTime))
    self.mTxtActivetyTime.text = string.format("%s%s  %s", _TT(28046), endTime, endHour)
    -- self.mTxtActivetyTime.text = string.format("%s - %s",TimeUtil.getFormatTimeBySeconds_8(TimeUtil.transTime(configVo.beginTime)),TimeUtil.getFormatTimeBySeconds_8(TimeUtil.transTime(configVo.endTime)))
end

-- function clearAcitivety(self)
-- if self.activetyTimeShowTimer then
--     self:removeTimerByIndex(self.activetyTimeShowTimer)
--     self.activetyTimeShowTimer = nil
-- end
-- end

function onClickDetails(self)
    local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_recruitType)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_RECRUITINFOPANEL, {
        heroTid = configVo:getTrailHero_id()
    })
end

function onClickTrial(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_MAINACTIVITY_TRIAL_PANEL)
end

function onClickLogHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_LOG_PANEL, {
        type = self.m_recruitType
    })
end

function onClickRuleHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_RULE_PANEL, {
        type = self.m_recruitType
    })
end

function onClickOneHandler(self)
    if self:getToDayRecruitTimes() + 1 > sysParam.SysParamManager:getValue(SysParamType.RECRUIT_TOP_DAILY_MAX) then
        gs.Message.Show(_TT(28009)) -- "不可超过招募次数上限"
    else
        self:checkSend(self.m_recruitType, 1)
    end
end

function onClickTenHandler(self)
    if self:getToDayRecruitTimes() + 1 > sysParam.SysParamManager:getValue(SysParamType.RECRUIT_TOP_DAILY_MAX) then
        gs.Message.Show(_TT(28009)) -- "不可超过招募次数上限"
    else
        self:checkSend(self.m_recruitType, 10)
    end
end

-- 今日已招募次数
function getToDayRecruitTimes(self)
    return recruit.RecruitManager:getRecruitInfo(self.m_recruitType).recruit_daily_times
end

function checkSend(self, recruitType, times)
    GameDispatcher:dispatchEvent(EventName.SEND_RECRUIT, {
        type = recruitType,
        times = times
    })
end

function onUpdateViewHandler(self, args)
    self:updateView()
end

function updateView(self)
    self.mTextRemainTimes_1.text = "/" .. self:getNeedTimes()
    self.mTextRemainTimes_2.text = self:getRecruitTimes()
    self.mTextRemainTimes_3.text = _TT(583, self:getNeedTimes())
    -- self.mText_MaxTimes.text = self:getNeedTimes()

    local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_recruitType)
    local costMoneyTid_one = configVo:getCostOneId()
    local costMoneyCount_one = configVo:getCostOneNum()
    local costMoneyTid_ten = configVo:getCostTenId()
    local costMoneyCount_ten = configVo:getCostTenNum()

    self.mPropsIcon_one:SetImg(UrlManager:getPropsIconUrl(costMoneyTid_one), false)
    self.mTxtCount_one.text = "x" .. costMoneyCount_one
    self.mPropsIcon_ten:SetImg(UrlManager:getPropsIconUrl(costMoneyTid_ten), false)
    self.mTextCount_ten.text = "x" .. costMoneyCount_ten

    local configHeroVo = hero.HeroManager:getHeroConfigVo(configVo:getTrailHero_id())
    self.mImgEleType:SetImg(UrlManager:getHeroEleTypeIconUrl(configHeroVo.eleType), false)
    self.mImgPro:SetImg(UrlManager:getHeroJobSmallIconUrl(configHeroVo.professionType), false)

    if GameManager.IS_DEBUG and not GameManager.HIDE_DEBUG_INFO and recruit.RecruitManager.debugUpInfo then
        local upInfo = recruit.RecruitManager.debugUpInfo
        local upHeroVo = hero.HeroManager:getHeroConfigVo(upInfo.up_hero_tid)
        local msg = ""
        for i, v in ipairs(upInfo.other_hero_wight) do
            msg = msg .. v.key .. ": " .. v.value .. "\n"
        end
        self.mDebugUpInfo:SetActive(true)
        self.mTxtData.text = "当前大保底UP战员：" .. upHeroVo.name .. " tid: " .. upInfo.up_hero_tid ..
                                 "\n当前UP战员权重：" .. upInfo.up_hero_weight .. "\n其他战员权重：\n" ..
                                 msg
    else
        self.mDebugUpInfo:SetActive(false)
        self.mTxtData.text = ""
    end

    -- self.mTxtName.text = configHeroVo.name
end

-- 已招募次数
function getRecruitTimes(self)
    return recruit.RecruitManager:getRecruitInfo(self.m_recruitType).guaranteed_times
end
-- 需要招募次数
function getNeedTimes(self)
    return recruit.RecruitManager:getRecruitInfo(self.m_recruitType).guaranteed_limit
end

function updateTrial_RedState(self)
    local trial_RedState = mainActivity.MainActivityManager:getIsShowTrial()
    if trial_RedState then
        RedPointManager:add(self.mTrialRedPoint, nil, 0, 0)
    else
        RedPointManager:remove(self.mTrialRedPoint)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
