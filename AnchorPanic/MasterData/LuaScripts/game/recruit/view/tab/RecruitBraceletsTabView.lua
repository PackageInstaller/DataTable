module("recruit.RecruitBraceletsTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("recruit/tab/RecruitBraceletsTab.prefab")

--构造函数
function ctor(self, recruitId)
    super.ctor(self)
    self.m_recruitId = recruitId
end

-- 初始化数据
function initData(self)
    self.m_recruitType = recruit.RecruitType.RECRUIT_BRACELETS
end

function configUI(self)
    self.m_btnLog = self:getChildGO("BtnLog")
    self.m_btnRule = self:getChildGO("BtnRule")
    self.mBtnOne = self:getChildGO("BtnOne")
    self.mBtnTen = self:getChildGO("BtnTen")

    self.mImgFree = self:getChildGO("mImgFree")
    self.mFreeTime = self:getChildGO("mFreeTime")
    self.CostOne = self:getChildGO("CostOne")

    self.m_propsIcon_one = self:getChildGO("PropsIcon_one"):GetComponent(ty.AutoRefImage)
    self.m_textCount_one = self:getChildGO("TextCount_one"):GetComponent(ty.Text)
    self.m_propsIcon_ten = self:getChildGO("PropsIcon_ten"):GetComponent(ty.AutoRefImage)
    self.m_textCount_ten = self:getChildGO("TextCount_ten"):GetComponent(ty.Text)
    self.mTextFreeTime = self:getChildGO("mTextFreeTime"):GetComponent(ty.Text)

    self.mBtnShop = self:getChildGO("BtnShop")
end

function active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_RECRUIT_PANEL, self.onUpdateViewHandler, self)
    self:updateView(true)
end

function deActive(self)
    self:clearTimer()

    GameDispatcher:removeEventListener(EventName.UPDATE_RECRUIT_PANEL, self.onUpdateViewHandler, self)
end

function initViewText(self)
    self:setBtnLabel(self.mBtnOne, 28023, "招募一次")
    self:setBtnLabel(self.mBtnTen, 28024, "招募十次")
end

function addAllUIEvent(self)
    self:addUIEvent(self.m_btnLog, self.onClickLogHandler)
    self:addUIEvent(self.m_btnRule, self.onClickRuleHandler)
    self:addUIEvent(self.mBtnOne, self.onClickOneHandler)
    self:addUIEvent(self.mBtnTen, self.onClickTenHandler)

    self:addUIEvent(self.mBtnShop, self.onClickShop)
end

function onClickShop(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.CovenantShop})
end

function onClickLogHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_LOG_PANEL, {recruitId = self.m_recruitId})
end

function onClickRuleHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_RULE_PANEL, {recruitId = self.m_recruitId})
end

function onClickOneHandler(self)
    if (recruit.RecruitManager.recruitTopTimes + 1 > sysParam.SysParamManager:getValue(SysParamType.RECRUIT_TOP_DAILY_MAX)) then
        gs.Message.Show(_TT(28009))--"不可超过招募次数上限"
    else
        self:checkSend(self.m_recruitId, 1)
    end
end

function onClickTenHandler(self)
    if (recruit.RecruitManager.recruitTopTimes + 10 > sysParam.SysParamManager:getValue(SysParamType.RECRUIT_TOP_DAILY_MAX)) then
        gs.Message.Show(_TT(28009))--"不可超过招募次数上限"
    else
        self:checkSend(self.m_recruitId, 10)
    end
end

function checkSend(self, recruitId, times)
    GameDispatcher:dispatchEvent(EventName.SEND_RECRUIT, {recruitId = recruitId, times = times})
end

function onUpdateViewHandler(self, args)
    -- local type = args.type
    -- if (type == self.m_recruitType) then
    self:updateView(false)
    -- end
end

function updateView(self, cusIsInit)
    local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_recruitId)
    local costMoneyTid_one = configVo:getCostOneId()
    local costMoneyCount_one = configVo:getCostOneNum()
    local costMoneyTid_ten = configVo:getCostTenId()
    local costMoneyCount_ten = configVo:getCostTenNum()

    self.m_propsIcon_one:SetImg(UrlManager:getPropsIconUrl(costMoneyTid_one), false)
    self.m_textCount_one.text = "x" .. costMoneyCount_one
    self.m_propsIcon_ten:SetImg(UrlManager:getPropsIconUrl(costMoneyTid_ten), false)
    self.m_textCount_ten.text = "x" .. costMoneyCount_ten

    local RecruitInfo = recruit.RecruitManager:getRecruitInfo(self.m_recruitId)

    local isFree = RecruitInfo.free_times < configVo.free_times
    self.mImgFree:SetActive(isFree)
    self.CostOne:SetActive(not isFree)

    self.mTextFreeTime.text = ""
    self:clearTimer()
    if not isFree then
        self:refreshShowTime()
        self.mFreeTimeSn = self:addTimer(1, -1, self.refreshShowTime)
    end
end

function refreshShowTime(self)
    local cusClientDt = GameManager:getClientTime()
    local timeTable = TimeUtil.getTimeTable(cusClientDt)

    local refreshTime = {}
    refreshTime.year = timeTable.year
    refreshTime.month = timeTable.month
    refreshTime.day = timeTable.day

    local refreshDt = 0
    if timeTable.hour >= 5 then
        refreshTime.hour = 23
        refreshTime.min = 59
        refreshTime.sec = 59

        refreshDt = os.time(refreshTime) + (5 * 3600) + 1
    else
        refreshTime.hour = 5
        refreshTime.min = 0
        refreshTime.sec = 0

        refreshDt = os.time(refreshTime)
    end

    local t = refreshDt - cusClientDt
    local h = math.floor(t / 3600)
    local m = math.floor(t / 60) - h * 60
    local s = t % 60

    if t > 0 then
        self.mTextFreeTime.text = _TT(581, h, m, s)
    else
        self.mTextFreeTime.text = ""
    end
end

function clearTimer(self)
    if self.mFreeTimeSn then
        self:removeTimerByIndex(self.mFreeTimeSn)
        self.mFreeTimeSn = nil
    end
end

-- 已招募次数
function getRecruitTimes(self)
    return recruit.RecruitManager:getRecruitInfo(self.m_recruitId).guaranteed_times
end
-- 需要招募次数
function getNeedTimes(self)
    return recruit.RecruitManager:getRecruitInfo(self.m_recruitId).guaranteed_limit
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
