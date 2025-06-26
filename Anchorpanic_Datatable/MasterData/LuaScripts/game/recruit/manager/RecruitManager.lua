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

function setRecruitActionId(self, recruitId)
    self.m_recruitActionId = recruitId
end
function getRecruitActionId(self)
    return self.m_recruitActionId
end

function getRecruitActionType(self)
    if not self.m_recruitActionId then
        return
    end

    return self:getRecruitTypeById(self.m_recruitActionId)
end

-- 限定up池招募大保底信息
function onDebugShowRecruitUpInfoMsg(self, msg)
    self.debugUpInfo = {}
    for k, v in pairs(msg.info_list) do
        self.debugUpInfo[v.id] = v
    end
end

function getDebugShowRecruitUpInfoMsg(self, recruit_id)
    if self.debugUpInfo then
        return self.debugUpInfo[recruit_id]
    end
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
    for recruitId, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(recruit.ItemRecruitDataRo)
        ro:parseData(recruitId, data)
        self.m_recruitConfigDic[recruitId] = ro
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
        self.m_recruitRuleConfigDic[_id] = ro
    end
end

-- -- 初始化菜单数据
function parseRecruitMenuConfigData(self)
    self.m_recruitMenuConfigDic = {}
    local baseData = nil
    local channelId, channelName = sdk.SdkManager:getChannelData()
    if(GameManager:getIsInCommiting() and (channelId == sdk.AndroidChannelId.QIANYOU or channelId == sdk.AndroidChannelId.QUICK or channelId == sdk.AndroidChannelId.QUICK2 or channelId == sdk.AndroidChannelId.QUICK3))then
        baseData = RefMgr:getData("research_recruit_data_channel")
    else
        baseData = RefMgr:getData("research_recruit_data")
    end
    for id, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(recruit.RecruitMenuVo)
        ro:parseData(id, data)
        self.m_recruitMenuConfigDic[id] = ro
    end
end

-- 获取卡池id(根据类型拿配置，只会拿到第一个)
function getRecruitIdByType(self, recruitType)
    if (not self.m_recruitConfigDic) then
        self:parseConfigData()
    end
    for recruit_id, recruitConfigVo in pairs(self.m_recruitConfigDic) do
        if recruitConfigVo.type == recruitType then
            return recruit_id
        end
    end
end

function getRecruitConfigListByType(self, recruitType)
    if (not self.m_recruitConfigDic) then
        self:parseConfigData()
    end
    local recruit_ConfigList = {}
    for recruit_id, recruitConfigVo in pairs(self.m_recruitConfigDic) do
        if recruitConfigVo.type == recruitType then
            table.insert(recruit_ConfigList, recruitConfigVo)
        end
    end

    return recruit_ConfigList
end

function getRecruitTypeById(self, recruitId)
    local configVo = self:getRecruitConfigVo(recruitId)
    if configVo then
        return configVo.type
    end
end

-- 获取招募配置
function getRecruitConfigVo(self, recruitId)
    if (not self.m_recruitConfigDic) then
        self:parseConfigData()
    end
    return self.m_recruitConfigDic[recruitId]
end

-- 获取招募规则配置
function getRecruitRuleConfigVo(self, recruitId)
    if (not self.m_recruitRuleConfigDic) then
        self:parseRuleConfigData()
    end
    return self.m_recruitRuleConfigDic[recruitId]
end

-- 获取招募菜单配置
function getRecruitMenuDic(self)
    if not self.m_recruitMenuConfigDic then
        self:parseRecruitMenuConfigData()
    end
    return self.m_recruitMenuConfigDic
end
-- 菜单配置
function getRecruitMenuVo(self, id)
    if not self.m_recruitMenuConfigDic then
        self:parseRecruitMenuConfigData()
    end
    return self.m_recruitMenuConfigDic[id]
end

-- 解析招募数据
function parseRecruitInfo(self, msg)
    self.mRecruitInfoDic = {}
    for i, v in ipairs(msg.recruit_list) do
        local vo = recruit.RecruitInfoVo.new()
        vo:parseMsg(v)
        self.mRecruitInfoDic[vo.recruit_id] = vo
    end

    GameDispatcher:dispatchEvent(EventName.UPDATE_RECRUIT_PANEL)
end

-- 获取招募数据
function getRecruitInfo(self, recruitId)
    if not self.mRecruitInfoDic then
        return nil
    end
    return self.mRecruitInfoDic[recruitId]
end

-- 更新招募日志
function updateRecruitLog(self, msg)
    if (not self.m_recruitLogDic[msg.recruit_id]) then
        self.m_recruitLogDic[msg.recruit_id] = {}
    end
    self.m_recruitLogDic[msg.recruit_id] = {}
    for i = 1, #msg.log_list do
        local vo = recruit.RecruitLogVo.new()
        vo:parseMsgData(msg.recruit_id, msg.log_list[i])
        table.insert(self.m_recruitLogDic[msg.recruit_id], vo)
    end

    GameDispatcher:dispatchEvent(EventName.UPDATE_RECRUIT_LOG, {recruit_id = msg.recruit_id})
end

-- 获取招募日志
function getRecruitLogList(self, recruit_id)
    if (not self.m_recruitLogDic[recruit_id]) then
        return {}
    end
    return self.m_recruitLogDic[recruit_id]
end

--更新新手招募的红点状态
function updateNewPlayRedState(self)
    local recruitId = self:getRecruitIdByType(recruit.RecruitType.RECRUIT_NEW_PLAYER)
    local recruitInfo = self:getRecruitInfo(recruitId)
    if not recruitInfo then
        return false
    end

    if recruitInfo.recruit_daily_times >= sysParam.SysParamManager:getValue(SysParamType.RECRUIT_NEW_PLAYER_TIMES) then
        return false
    end

    local recruit_id = self:getRecruitIdByType(recruit.RecruitType.RECRUIT_NEW_PLAYER)
    local configVo = self:getRecruitConfigVo(recruit_id)
    local costCount = configVo:getCostTenNum()
    local costTid = configVo:getCostTenId()
    local hasCount = MoneyUtil.getMoneyCountByTid(costTid)

    if (hasCount >= costCount) then
        return true
    end
    return false
end

--更新烙痕招募的红点状态
function updatRecruitFreeRedState(self)
    local recruitId = self:getRecruitIdByType(recruit.RecruitType.RECRUIT_BRACELETS)
    local menuConfig = self:getRecruitMenuVo(recruitId)
    if not menuConfig then
        return false
    end
    if not funcopen.FuncOpenManager:isOpen(menuConfig.funcId) then
        return false
    end

    local RecruitInfo = self:getRecruitInfo(recruitId)
    if not RecruitInfo then
        return false
    end

    local RecruitConfigVo = self:getRecruitConfigVo(recruitId)
    if not RecruitConfigVo then
        return false
    end

    return RecruitInfo.free_times < RecruitConfigVo.free_times
end

function updateActBraceletsShopRedState(self)
    return read.ReadManager:isModuleRead(219, 2060)
end

function updateAppBraceletsShopRedState(self)
    return read.ReadManager:isModuleRead(219, 2060)
end

function updateActBraceletsShopBuyRedState(self, recruit_id)
    local menuVo = self:getRecruitMenuVo(recruit_id)
    if not menuVo:isOpenTime() then
        return false
    end
    local configVo = self:getRecruitConfigVo(recruit_id)
    local shopId = configVo.show_item
    local shopVo = shop.ShopManager:getShopItemByTid(ShopType.COVENANT, shopId)
    if shopVo then
        if MoneyUtil.getMoneyCountByTid(shopVo:getRealPayType()) >= shopVo.price and self:updateActBraceletsShopRedState() then
            return true
        end
    end

    return false
end

function updateSeniorAppBraceletsRedState(self)
    return read.ReadManager:isModuleRead(219, 800)
end

function updateSeniorAppActRedState(self)
    return read.ReadManager:isModuleRead(221, 800)
end

function updateAppBraceletsShopBuyRedState(self, recruit_id)
    local recruitInfo = self:getRecruitInfo(recruit_id)
    if recruitInfo then
        local select_id = recruitInfo.select_tid
        local shopId = select_id
        local shopVo = shop.ShopManager:getShopItemByTid(ShopType.COVENANT, shopId)
        if shopVo then
            if MoneyUtil.getMoneyCountByTid(shopVo:getRealPayType()) >= shopVo.price and self:updateAppBraceletsShopRedState() then
                return true
            end
        end
    end

    return false
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

function updateTrialStateMsg(self, msg)
    self.mIsFirstPassTrial = {}
    for k, v in pairs(msg.pass_dup) do
        self.mIsFirstPassTrial[v] = 1
    end

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

--是否显示红点
function getIsShowTrial(self, dup_id)
    if not self.mIsFirstPassTrial then
        return false
    end

    return self.mIsFirstPassTrial[dup_id] == nil
end

--当前是否打开了规则弹窗
function SetOpenRulePanel(self, value)
    self.isOpenRule = value
end

function isOpenRulePanel(self, value)
    return self.isOpenRule or false
end

--当前是否打开了定向选择弹窗
function SetOpenAppSelectPanel(self,appType)
    self.openAppType = appType
end

function getOpenAppSelectPanel(self)
    return self.openAppType 
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
