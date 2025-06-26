module("recruit.RecruitActTopTabView", Class.impl(TabSubView))
UIRes = UrlManager:getUIPrefabPath("recruit/tab/RecruitActTopTab.prefab")

-- 构造函数
function ctor(self, recruitId)
    self.m_recruitId = recruitId

    super.ctor(self)
end

function onLoadAssetComplete(self)
    -- 实例化是一个克隆对象，并不是加载的那个prefab，需要重新取
    self.UIObject = AssetLoader.GetGO(self.UIRes, self)
    self.UITrans = self.UIObject.transform

    local res_list = { 101, 111, 112 }

    local go_dic = {}
    for i = 1, #res_list do
        local go = self.UITrans:Find("RecruitActTopTab_" .. res_list[i]).gameObject
        go:SetActive(res_list[i] == self.m_recruitId)
        go_dic[res_list[i]] = go
    end

    self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(go_dic[self.m_recruitId])

    self:configUI()
    self:dispatchEvent(EVENT_LOAD_FINISH)
    self:addOnParent()
end

-- 初始化数据
function initData(self)

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

    self.mGroupBg = self:getChildGO("mGroupBg")

    self.mTextHeroName = self:getChildGO("mTextHeroName"):GetComponent(ty.Text)

    self.mTrialRedPoint = self:getChildTrans("mTrialRedPoint")

    self.mImgHeroHar = self:getChildGO("mImgHeroHar"):GetComponent(ty.AutoRefImage)
end

function active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_RECRUIT_PANEL, self.onUpdateViewHandler, self)
    GameDispatcher:addEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.updateTrial_RedState, self)

    self.mGroupBg:SetActive(true)

    self:updateView()
    self:updateShowActivetyTimer()
    self:updateTrial_RedState()
end

function deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_RECRUIT_PANEL, self.onUpdateViewHandler, self)
    GameDispatcher:removeEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.updateTrial_RedState, self)

    self.mGroupBg:SetActive(false)
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

function updateShowActivetyTimer(self)
    self:showActivetyTime()
end

function showActivetyTime(self)

    local menuVo = recruit.RecruitManager:getRecruitMenuVo(self.m_recruitId)

    local endTime, endHour = TimeUtil.getMDHByTime2(TimeUtil.transTime(menuVo.endTime))
    self.mTxtActivetyTime.text = string.format("%s%s  %s", _TT(28046), endTime, endHour)
end

function onClickDetails(self)
    local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_recruitId)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_RECRUITINFOPANEL, {
        heroTid = configVo:getTrailHero_id()
    })
end

function onClickTrial(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_MAINACTIVITY_TRIAL_PANEL, { recruit_id = self.m_recruitId })
end

function onClickLogHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_LOG_PANEL, { recruitId = self.m_recruitId })
end

function onClickRuleHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_RULE_PANEL, { recruitId = self.m_recruitId })
end

function onClickOneHandler(self)
    if self:getToDayRecruitTimes() + 1 > sysParam.SysParamManager:getValue(SysParamType.RECRUIT_TOP_DAILY_MAX) then
        gs.Message.Show(_TT(28009)) -- "不可超过招募次数上限"
    else
        self:checkSend(self.m_recruitId, 1)
    end
end

function onClickTenHandler(self)
    if self:getToDayRecruitTimes() + 1 > sysParam.SysParamManager:getValue(SysParamType.RECRUIT_TOP_DAILY_MAX) then
        gs.Message.Show(_TT(28009)) -- "不可超过招募次数上限"
    else
        self:checkSend(self.m_recruitId, 10)
    end
end

-- 今日已招募次数
function getToDayRecruitTimes(self)
    return recruit.RecruitManager:getRecruitInfo(self.m_recruitId).recruit_daily_times
end

function checkSend(self, recruitId, times)
    GameDispatcher:dispatchEvent(EventName.SEND_RECRUIT, { recruitId = recruitId, times = times })
end

function onUpdateViewHandler(self, args)
    self:updateView()
end

function updateView(self)
    self.mTextRemainTimes_1.text = "/" .. self:getNeedTimes()
    self.mTextRemainTimes_2.text = self:getRecruitTimes()
    self.mTextRemainTimes_3.text = _TT(583, self:getNeedTimes())
    -- self.mText_MaxTimes.text = self:getNeedTimes()

    local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_recruitId)
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
    self.mTextHeroName.text = configHeroVo.name

    local hero_id = configVo:getTrailHero_id()
    local upHeroVo = hero.HeroManager:getHeroConfigVo(hero_id)
    if GameManager.IS_DEBUG and not GameManager.HIDE_DEBUG_INFO then
        self.mDebugUpInfo:SetActive(true)

        local debugUpInfo = recruit.RecruitManager:getDebugShowRecruitUpInfoMsg(self.m_recruitId)
        if debugUpInfo then

            local msg = ""
            for i, v in ipairs(debugUpInfo.other_ratio) do
                msg = msg .. v.key .. ": " .. v.value .. "\n"
            end
            self.mTxtData.text = "当前大保底UP战员：" .. upHeroVo.name .. " tid: " .. hero_id .. "\n当前UP战员权重：" .. debugUpInfo.up_ratio .. "\n其他战员权重：\n" .. msg
        else
            self.mTxtData.text = "获取UP Debug数据出错了，请排查是否是配置出错。卡池ID:" .. self.m_recruitId
        end
    else
        self.mDebugUpInfo:SetActive(false)
        self.mTxtData.text = ""
    end


    -- 部分渠道需要特殊处理
    local isHar = (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious())
    self.mImgHeroHar.gameObject:SetActive(isHar)
    self:getChildGO("Spine"):SetActive(not isHar)
    self.mImgHeroHar:SetImg(UrlManager:getPainImg(upHeroVo.painting))
end

-- 已招募次数
function getRecruitTimes(self)
    return recruit.RecruitManager:getRecruitInfo(self.m_recruitId).guaranteed_times
end
-- 需要招募次数
function getNeedTimes(self)
    return recruit.RecruitManager:getRecruitInfo(self.m_recruitId).guaranteed_limit
end

function updateTrial_RedState(self)
    local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_recruitId)

    local trial_RedState = recruit.RecruitManager:getIsShowTrial(configVo:getTry_hero())
    if trial_RedState then
        RedPointManager:add(self.mTrialRedPoint, nil, 0, 0)
    else
        RedPointManager:remove(self.mTrialRedPoint)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]