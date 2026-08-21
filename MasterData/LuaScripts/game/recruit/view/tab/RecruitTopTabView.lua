module("recruit.RecruitTopTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("recruit/tab/RecruitTopTab.prefab")

--构造函数
function ctor(self, recruitId)
    super.ctor(self)
    self.m_recruitId = recruitId
end

-- 初始化数据
function initData(self)
    self.m_recruitType = recruit.RecruitType.RECRUIT_TOP
end

function configUI(self)
    self.m_btnLog = self:getChildGO("BtnLog")
    self.m_btnRule = self:getChildGO("BtnRule")
    self.mBtnOne = self:getChildGO("BtnOne")
    self.mBtnTen = self:getChildGO("BtnTen")

    self.m_propsIcon_one = self:getChildGO("PropsIcon_one"):GetComponent(ty.AutoRefImage)
    self.m_textCount_one = self:getChildGO("TextCount_one"):GetComponent(ty.Text)
    self.m_propsIcon_ten = self:getChildGO("PropsIcon_ten"):GetComponent(ty.AutoRefImage)
    self.m_textCount_ten = self:getChildGO("TextCount_ten"):GetComponent(ty.Text)

    self.TextRemainTimes_1 = self:getChildGO("TextRemainTimes_1"):GetComponent(ty.Text)

    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
    self.mAnimator:Play("RecruitTopTab_Enter01")

    self:setGuideTrans("recruit_top_btn_one", self.mBtnOne.transform)
end

function active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_RECRUIT_PANEL, self.__onUpdateViewHandler, self)
    self:__updateView(true)

    if recruit.RecruitManager:getIsFirstOpenTopRecruit() then
        self.mAnimator:Play("RecruitTopTab_Enter02")
    end
    recruit.RecruitManager:setIsFirstOpenTopRecruit(true)
end

function deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_RECRUIT_PANEL, self.__onUpdateViewHandler, self)
end

function onClickClose(self)
    recruit.RecruitManager:setIsFirstOpenTopRecruit(false)
end

function initViewText(self)
    self:setBtnLabel(self.mBtnOne, 28007, "招募一次")
    self:setBtnLabel(self.mBtnTen, 28008, "招募十次")
end

function addAllUIEvent(self)
    self:addUIEvent(self.m_btnLog, self.onClickLogHandler)
    self:addUIEvent(self.m_btnRule, self.onClickRuleHandler)
    self:addUIEvent(self.mBtnOne, self.onClickOneHandler)
    self:addUIEvent(self.mBtnTen, self.onClickTenHandler)
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

function __onUpdateViewHandler(self, args)
    -- local type = args.type
    -- if (type == self.m_recruitType) then
    self:__updateView(false)
    -- end
end

function __updateView(self, cusIsInit)
    local already_times = self:getRecruitTimes()
    local need_times = self:getNeedTimes()
    self.TextRemainTimes_1.text = string.format("<size=50><color=#FFFFFF>%s</color></size>/%s", already_times, need_times)

    local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_recruitId)
    local costMoneyTid_one = configVo:getCostOneId()
    local costMoneyCount_one = configVo:getCostOneNum()
    local costMoneyTid_ten = configVo:getCostTenId()
    local costMoneyCount_ten = configVo:getCostTenNum()

    self.m_propsIcon_one:SetImg(UrlManager:getPropsIconUrl(costMoneyTid_one), false)
    self.m_textCount_one.text = "x" .. costMoneyCount_one
    self.m_propsIcon_ten:SetImg(UrlManager:getPropsIconUrl(costMoneyTid_ten), false)
    self.m_textCount_ten.text = "x" .. costMoneyCount_ten
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
