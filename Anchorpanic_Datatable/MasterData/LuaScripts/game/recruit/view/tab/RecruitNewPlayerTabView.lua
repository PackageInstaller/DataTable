module("recruit.RecruitNewPlayerTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("recruit/tab/RecruitNewPlayerTab.prefab")

--构造函数
function ctor(self, recruitId)
    super.ctor(self)
    self.m_recruitId = recruitId
end

-- 初始化数据
function initData(self)
    self.m_recruitType = recruit.RecruitType.RECRUIT_NEW_PLAYER
end

function configUI(self)
    self.m_btnTen = self:getChildGO("BtnTen")
    self.m_btnRule = self:getChildGO("BtnRule")

    self.m_propsIcon_ten = self:getChildGO("PropsIcon_ten"):GetComponent(ty.AutoRefImage)
    self.mTextCount_ten = self:getChildGO("TextCount_ten"):GetComponent(ty.Text)

    self.m_textRemainTimes = self:getChildGO("TextRemainTimes"):GetComponent(ty.Text)
end

function active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_RECRUIT_PANEL, self.__onUpdateViewHandler, self)

    --请求上一次的招募结果
    GameDispatcher:dispatchEvent(EventName.REQ_NEWPLAY_RECRUIT_RESULT)
    self:__updateView()
end

function deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_RECRUIT_PANEL, self.__onUpdateViewHandler, self)
end

function initViewText(self)
    self:setBtnLabel(self.m_btnTen, 28008, "链接十次")
end

function addAllUIEvent(self)
    self:addUIEvent(self.m_btnTen, self.onClickTenHandler)
    self:addUIEvent(self.m_btnRule, self.onClickRuleHandler)

end

-- 已招募次数
function getRecruitTimes(self)
    return recruit.RecruitManager:getRecruitInfo(self.m_recruitId).recruit_daily_times
end

function onClickTenHandler(self)
    if (self:getRecruitTimes() >= sysParam.SysParamManager:getValue(SysParamType.RECRUIT_NEW_PLAYER_TIMES)) then
        gs.Message.Show(_TT(28009))--"不可超过招募次数上限"
    else
        self:checkSend(self.m_recruitId, 10)
    end
end

function onClickRuleHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_RULE_PANEL, {recruitId = self.m_recruitId})
end

function checkSend(self, recruitId, times)
    GameDispatcher:dispatchEvent(EventName.SEND_RECRUIT, {recruitId = recruitId, times = times})
end

function __onUpdateViewHandler(self, args)
    -- local type = args.type
    -- if (type == self.m_recruitType) then
    self:__updateView()
    -- end
end

function __updateView(self)
    local maxCount = sysParam.SysParamManager:getValue(SysParamType.RECRUIT_NEW_PLAYER_TIMES)
    self.m_textRemainTimes.text = maxCount - self:getRecruitTimes()

    local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_recruitId)
    local costMoneyTid_ten = configVo:getCostTenId()
    local costMoneyCount_ten = configVo:getCostTenNum()

    self.m_propsIcon_ten:SetImg(UrlManager:getPropsIconUrl(costMoneyTid_ten), false)
    self.mTextCount_ten.text = "x" .. costMoneyCount_ten
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
