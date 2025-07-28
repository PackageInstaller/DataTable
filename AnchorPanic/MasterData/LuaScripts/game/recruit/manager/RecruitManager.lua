module("recruit.RecruitManager", Class.impl(Manager))

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    -- 高级招募当天已招募的次数
    self.recruitTopTimes = 0
    -- 高级招募保底已抽次数
    self.recruitTopGuaranteedTimes = 0
    -- 高级招募保底所需次数
    self.recruitTopGuaranteedNeedTimes = 0
    -- 新手招募已招募次数
    self.recruitNewPlayerUseTimes = 0

    -- 手环研发当天已招募的次数
    self.recruitBraceletTimes = 0
    -- 手环研发保底已抽次数
    self.recruitBraceletGuaranteedTimes = 0
    -- 手环研发保底所需次数
    self.recruitBraceletGuaranteedNeedTimes = 0

    self.m_recruitLogDic = {}

    -- 记录当前展示相同tid的对应顺序英雄字典
    self.m_recruitResultList = {}

    self.mDismissData = nil

    self.mDisHeroList = {}
    for i = 1, sysParam.SysParamManager:getValue(49) do
        table.insert(self.mDisHeroList, -1)
    end
end
-- 设置英雄招募的结果字典，用于获取转化的碎片数据
function setRecruitHeroResultList(self, dic)
    self.m_recruitResultList = dic
end
--获取抽卡英雄结果
function getRecruitHeroResultList(self)
    return self.m_recruitResultList
end

--设置手环抽卡的结果数据
function setRecruitCardResultList(self, list)
    self.m_recruitCardResultList = list
end

function getRecruitCardResultList(self)
    return self.m_recruitCardResultList
end

function setRecruitActionType(self, type)
    self.m_recruitActionType = type
end
function getRecruitActionType(self)
    return self.m_recruitActionType
end

-- 限定up池招募大保底信息
function onDebugShowRecruitUpInfoMsg(self, msg)
    self.debugUpInfo = msg
end


-- -- 初始化配置表
function parseConfigData(self)
    self.m_recruitConfigDic = {}
    local baseData = nil
    if(web.WebManager.net_type == web.NET_TYPE.OUTER_TEST and GameManager:getIsInCommiting() and (channelId == sdk.AndroidChannelId.QIANYOU or channelId == sdk.AndroidChannelId.QUICK or channelId == sdk.AndroidChannelId.QUICK2 or channelId == sdk.AndroidChannelId.QUICK3))then
        baseData = RefMgr:getData("item_recruit_data_channel_test")
    else
        baseData = RefMgr:getData("item_recruit_data")
    end
    for recruitType, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(recruit.HeroRecruitConfigVo)
        ro:parseData(recruitType, data)
        self.m_recruitConfigDic[recruitType] = ro
    end
end

-- -- 初始化规则配置表
function parseRuleConfigData(self)
    self.m_recruitRuleConfigDic = {}
    local baseData = nil
    local channelId, channelName = sdk.SdkManager:getChannelData()
    if(GameManager:getIsInCommiting() and (channelId == sdk.AndroidChannelId.QIANYOU or channelId == sdk.AndroidChannelId.QUICK or channelId == sdk.AndroidChannelId.QUICK2 or channelId == sdk.AndroidChannelId.QUICK3))then
        baseData = RefMgr:getData("hero_recruit_rule_data_channel")
    else
        baseData = RefMgr:getData("hero_recruit_rule_data")
    end
    for _id, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(recruit.HeroRecruitRuleConfigVo)
        ro:parseData(_id, data)
        self.m_recruitRuleConfigDic[data.type] = ro
    end
end

-- -- 初始化菜单数据
function parseRecruitMenuConfigData(self)
    self.m_recruitMenuConfigList = {}
    local baseData = nil
    local channelId, channelName = sdk.SdkManager:getChannelData()
    if(GameManager:getIsInCommiting() and (channelId == sdk.AndroidChannelId.QIANYOU or channelId == sdk.AndroidChannelId.QUICK or channelId == sdk.AndroidChannelId.QUICK2 or channelId == sdk.AndroidChannelId.QUICK3))then
        baseData = RefMgr:getData("research_recruit_data_channel")
    else
        baseData = RefMgr:getData("research_recruit_data")
    end
    for key, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(recruit.RecruitMenuVo)
        ro:parseData(key, data)
        table.insert(self.m_recruitMenuConfigList, ro)
    end
end

-- 获取招募配置
function getRecruitConfigVo(self, recruitType)
    if (not self.m_recruitConfigDic) then
        self:parseConfigData()
    end
    return self.m_recruitConfigDic[recruitType]
end

-- 获取招募规则配置
function getRecruitRuleConfigVo(self, recruitType)
    if (not self.m_recruitRuleConfigDic) then
        self:parseRuleConfigData()
    end
    return self.m_recruitRuleConfigDic[recruitType]
end

-- 获取招募菜单配置
function getRecruitMenuList(self)
    if not self.m_recruitMenuConfigList then
        self:parseRecruitMenuConfigData()
    end
    return self.m_recruitMenuConfigList
end
-- 菜单配置
function getRecruitMenuVo(self, type)
    local list = self:getRecruitMenuList()
    for i, vo in ipairs(list) do
        if vo.type == type then
            return vo
        end
    end
    return nil
end

-- 解析招募数据
function parseRecruitInfo(self, msg)
    self.mRecruitInfoDic = {}
    for i, v in ipairs(msg.recruit_list) do
        local vo = recruit.RecruitInfoVo.new()
        vo:parseMsg(v)
        self.mRecruitInfoDic[vo.type] = vo
    end

    GameDispatcher:dispatchEvent(EventName.UPDATE_RECRUIT_PANEL)
end

-- 获取招募数据
function getRecruitInfo(self, cusType)
    if not self.mRecruitInfoDic then
        return nil
    end
    return self.mRecruitInfoDic[cusType]
end

-- 更新招募日志
function updateRecruitLog(self, msg)
    if (not self.m_recruitLogDic[msg.type]) then
        self.m_recruitLogDic[msg.type] = {}
    end
    self.m_recruitLogDic[msg.type] = {}
    for i = 1, #msg.log_list do
        local vo = recruit.RecruitLogVo.new()
        vo:parseMsgData(msg.type, msg.log_list[i])
        table.insert(self.m_recruitLogDic[msg.type], vo)
    end

    GameDispatcher:dispatchEvent(EventName.UPDATE_RECRUIT_LOG, {type = msg.type})
end

-- 获取招募日志
function getRecruitLogList(self, recruitType)
    if (not self.m_recruitLogDic[recruitType]) then
        return {}
    end
    return self.m_recruitLogDic[recruitType]
end

--更新新手招募的红点状态
function updateNewPlayRedState(self)
    local recruitInfo = self:getRecruitInfo(recruit.RecruitType.RECRUIT_NEW_PLAYER)
    if not recruitInfo then
        return false
    end

    if recruitInfo.recruit_daily_times >= sysParam.SysParamManager:getValue(SysParamType.RECRUIT_NEW_PLAYER_TIMES) then
        return false
    end

    local configVo = recruit.RecruitManager:getRecruitConfigVo(recruit.RecruitType.RECRUIT_NEW_PLAYER)
    local costCount = configVo:getCostTenNum()
    local costTid = configVo:getCostTenId()
    local hasCount = MoneyUtil.getMoneyCountByTid(costTid)

    if (hasCount >= costCount) then
        return true
    end
    return false
end

--更新烙痕招募的红点状态
function updatRecruitFreeRedState(self, recruitType)
    local menuConfig = self:getRecruitMenuVo(recruitType)
    if not menuConfig then
        return false
    end
    if not funcopen.FuncOpenManager:isOpen(menuConfig.funcId) then
        return false
    end

    local RecruitInfo = recruit.RecruitManager:getRecruitInfo(recruitType)
    if not RecruitInfo then
        return false
    end

    local RecruitConfigVo = recruit.RecruitManager:getRecruitConfigVo(recruitType)
    if not RecruitConfigVo then
        return false
    end

    return RecruitInfo.free_times < RecruitConfigVo.free_times
end

--析构函数
function dtor(self)
end

function parseDismissData(self)
    self.mDismissData = {}
    local baseData = RefMgr:getData("hero_retire_data")
    for id, data in pairs(baseData) do
        local vo = recruit.DismissVo.new()
        vo:parseData(data)
        self.mDismissData[id] = vo
    end
end

function getDismissData(self)
    if self.mDismissData == nil then
        self:parseDismissData()
    end

    return self.mDismissData
end

function getDismissDataByColor(self, color)
    if self.mDismissData == nil then
        self:parseDismissData()
    end
    return self.mDismissData[color].gitItem[1][2]
end

function getDisHeroData(self)
    return self.mDisHeroList
end

function initDisHeroData(self)
    self.mDisHeroList = {}
    for i = 1, sysParam.SysParamManager:getValue(49) do
        table.insert(self.mDisHeroList, -1)
    end
end

function setDismissResResult(self, msg)
    if (msg.result == 1) then
        self:initDisHeroData()
        GameDispatcher:dispatchEvent(EventName.UPDATE_HERO_DISMISS_PANEL)
    end
end

function setDisHeroData(self, data)
    local idx = table.indexof01(self.mDisHeroList, data)
    local reIdx = table.indexof01(self.mDisHeroList, -1)

    if idx > 0 then
        self.mDisHeroList[idx] = -1
    else
        if reIdx == 0 then
            gs.Message.Show(_TT(1136))
            return
        end
        self.mDisHeroList[reIdx] = data
    end
end

function cancelHeroNotSelect(self, data)
    local idx = table.indexof01(self.mDisHeroList, data)
    self.mDisHeroList[idx] = -1
end

function setDisHeroDataNotSelect(self, data)
    local idx = table.indexof01(self.mDisHeroList, data)
    local reIdx = table.indexof01(self.mDisHeroList, -1)

    if idx > 0 then
    else
        if reIdx == 0 then
            return
        end
        self.mDisHeroList[reIdx] = data
    end
end

function getDisHeroSelect(self, data)
    return table.indexof01(self.mDisHeroList, data) > 0
end

function setLongTimeHeroSelect(self, data)
    self:setDisHeroData(data)

    local list, idDic = showBoard.ShowBoardManager:getHeroScrollList(nil, showBoard.panelSortType.LEVEL, true, {}, false)
    local voList = {}
    for i = #list, 1, -1 do
        table.insert(voList, list[i]:getDataVo())
    end

    for i = 1, #voList do
        local reIndex = table.indexof01(self.mDisHeroList, -1)
        if reIndex > 0 then
            if
                (hero.HeroUseCodeManager:getIsCanUse(voList[i].id, false) and voList[i].id ~= data.id and
                    voList[i].tid == data.tid and
                    voList[i].lvl == 1 and
                    voList[i].evolutionLvl == 0 and
                    voList[i].isLock == 0 and
                voList[i].isLike == 0)
                then
                self:setDisHeroDataNotSelect(voList[i])
            end
        else
            break
        end
    end
end

--当前是否打开了规则弹窗
function SetOpenRulePanel(self, value)
    self.isOpenRule = value
end

function isOpenRulePanel(self, value)
    return self.isOpenRule or false
end

--是否玩家主动关闭的普通战员抽卡
function setIsFirstOpenTopRecruit(self, val)
    self.mIsFirstOpenTopRecruit = val
end

function getIsFirstOpenTopRecruit(self, val)
    return self.mIsFirstOpenTopRecruit or false
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
