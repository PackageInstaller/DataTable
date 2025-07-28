module("recruit.RecruitActBraceletsTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("recruit/tab/RecruitActBraceletsTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.m_recruitType = recruit.RecruitType.RECRUIT_ACTIVITY_2
end

function configUI(self)
    super.configUI(self)
    self.m_btnLog = self:getChildGO("BtnLog")
    self.m_btnRule = self:getChildGO("BtnRule")
    self.mBtnOne = self:getChildGO("BtnOne")
    self.mBtnTen = self:getChildGO("BtnTen")

    self.m_propsIcon_one = self:getChildGO("PropsIcon_one"):GetComponent(ty.AutoRefImage)
    self.m_textCount_one = self:getChildGO("TextCount_one"):GetComponent(ty.Text)
    self.m_propsIcon_ten = self:getChildGO("PropsIcon_ten"):GetComponent(ty.AutoRefImage)
    self.m_textCount_ten = self:getChildGO("TextCount_ten"):GetComponent(ty.Text)

    self.mTextTime = self:getChildGO("mTextTime"):GetComponent(ty.Text)
    self.mBtnLook = self:getChildGO("mBtnLook")
    self.mBtnShop = self:getChildGO("BtnShop")
    self.mTxtData = self:getChildGO("mTxtData"):GetComponent(ty.Text)
    self.mDebugUpInfo = self:getChildGO("mDebugUpInfo")
end

function active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_RECRUIT_PANEL, self.__onUpdateViewHandler, self)
    self:__updateView(true)
end

function deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_RECRUIT_PANEL, self.__onUpdateViewHandler, self)
end

function initViewText(self)
    super.initViewText(self)

    self:setBtnLabel(self.mBtnOne, 28035, "招募一次")
    self:setBtnLabel(self.mBtnTen, 28036, "招募十次")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnLook, self.onClickLookTips)
    self:addUIEvent(self.mBtnShop, self.onClickShop)

    self:addUIEvent(self.m_btnLog, self.__onClickLogHandler)
    self:addUIEvent(self.m_btnRule, self.__onClickRuleHandler)
    self:addUIEvent(self.mBtnOne, self.__onClickOneHandler)
    self:addUIEvent(self.mBtnTen, self.__onClickTenHandler)
end

function onClickLookTips(self)
    local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_recruitType)

    local equipVo = LuaPoolMgr:poolGet(props.EquipVo)
    equipVo:setTid(configVo.show_item)
    TipsFactory:equipTips(equipVo)
end

function onClickShop(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.CovenantShop })
end

function __onClickLogHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_LOG_PANEL, { type = self.m_recruitType })
end

function __onClickRuleHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_RULE_PANEL, { type = self.m_recruitType })
end

function __onClickOneHandler(self)
    if (recruit.RecruitManager.recruitTopTimes + 1 > sysParam.SysParamManager:getValue(SysParamType.RECRUIT_TOP_DAILY_MAX)) then
        gs.Message.Show(_TT(28009))--"不可超过招募次数上限"
    else
        self:checkSend(self.m_recruitType, 1)
    end
end

function __onClickTenHandler(self)
    if (recruit.RecruitManager.recruitTopTimes + 10 > sysParam.SysParamManager:getValue(SysParamType.RECRUIT_TOP_DAILY_MAX)) then
        gs.Message.Show(_TT(28009))--"不可超过招募次数上限"
    else
        self:checkSend(self.m_recruitType, 10)
    end
end

function checkSend(self, recruitType, times)
    GameDispatcher:dispatchEvent(EventName.SEND_RECRUIT, { type = recruitType, times = times })
end

function __onUpdateViewHandler(self, args)
    -- local type = args.type
    -- if (type == self.m_recruitType) then
    self:__updateView(false)
    -- end
end

function __updateView(self, cusIsInit)
    local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_recruitType)
    local costMoneyTid_one = configVo:getCostOneId()
    local costMoneyCount_one = configVo:getCostOneNum()
    local costMoneyTid_ten = configVo:getCostTenId()
    local costMoneyCount_ten = configVo:getCostTenNum()

    self.m_propsIcon_one:SetImg(UrlManager:getPropsIconUrl(costMoneyTid_one), false)
    self.m_textCount_one.text = "x" .. costMoneyCount_one
    self.m_propsIcon_ten:SetImg(UrlManager:getPropsIconUrl(costMoneyTid_ten), false)
    self.m_textCount_ten.text = "x" .. costMoneyCount_ten

    self:upateActTime()

    if GameManager.IS_DEBUG and not GameManager.HIDE_DEBUG_INFO and recruit.RecruitManager.debugUpInfo then
        local upInfo = recruit.RecruitManager.debugUpInfo
        local upItemVo = props.PropsManager:getPropsConfigVo(upInfo.up_bracelet_tid)
        local msg = ""
        for i, v in ipairs(upInfo.other_bracelet_wight) do
            msg = msg .. v.key .. ": " .. v.value .. "\n"
        end
        self.mDebugUpInfo:SetActive(true)
        self.mTxtData.text = "当前UP烙痕：" .. upItemVo:getName() .. " tid: " .. upInfo.up_bracelet_tid .. "\n当前UP烙痕权重：" .. upInfo.up_bracelet_weight .. "\n其他烙痕权重：\n" .. msg
    else
        self.mDebugUpInfo:SetActive(false)
        self.mTxtData.text = ""
    end
end

function upateActTime(self)
    local menuVo = recruit.RecruitManager:getRecruitMenuVo(self.m_recruitType)

    local beginTime = TimeUtil.getMDHByTime2(TimeUtil.transTime(menuVo.beginTime))
    local endTime, endHour = TimeUtil.getMDHByTime2(TimeUtil.transTime(menuVo.endTime))
    self.mTextTime.text = string.format("%s%s    %s", _TT(28046), endTime, endHour)
end


-- 已招募次数
function getRecruitTimes(self)
    return recruit.RecruitManager:getRecruitInfo(self.m_recruitType).guaranteed_times
end
-- 需要招募次数
function getNeedTimes(self)
    return recruit.RecruitManager:getRecruitInfo(self.m_recruitType).guaranteed_limit
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(572):	"未可领取"
	语言包: _TT(7):	"已领取"
]]