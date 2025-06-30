--[[
-----------------------------------------------------
@filename       : MainActivityManager
@Description    : 运营活动数据管理
@date           : 2020-12-09 19:29:14
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.mainActivity.manager.MainActivityManager', Class.impl(Manager))

--构造
function ctor(self)
    super.ctor(self)
    self:__init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

--初始化
function __init(self)
    self.mLoginDay = 0
    self.mMainActivityList = {}
    self.mActivitySignList = {}
    self.mMainActivityDic = nil
    self.mActivitySignDic = nil
    self.mActivitySignedList = {}

    --商店配置表Dic
    self.mActivityShopConfig = {}
    --商店MSG
    self.mActivityShopMsg = {}

    --任务配置表
    self.mActivityTaskConfig = {}
    --任务MSG
    self.mActivityTaskMsg = {}
    --任务Scroll height
    self.scrollHeight = 0
    --试玩 试玩是否首通
    self.mIsFirstPassTrial = false
    --是否是第一次打开
    self.mIsFirstEnter = true

    --活动界面
    self.mActiveViewList = {}
end

-- 解析主题活动主界面配置
function parseMainActivityConfigData(self)
    self.mMainActivityList = {}
    self.mMainActivityDic = {}

    local baseData = nil
    local channelId, channelName = sdk.SdkManager:getChannelData()
    if (GameManager:getIsInCommiting() and (channelId == sdk.AndroidChannelId.QIANYOU or channelId == sdk.AndroidChannelId.QUICK or channelId == sdk.AndroidChannelId.QUICK2 or channelId == sdk.AndroidChannelId.QUICK3)) then
        baseData = RefMgr:getData("activity_data_channel")
    else
        baseData = RefMgr:getData("activity_data")
    end

    for key, data in pairs(baseData) do
        local vo = mainActivity.MainActivityVo.new()
        vo:parseConfigData(key, data)
        self.mMainActivityDic[vo.id] = vo
        table.insert(self.mMainActivityList, vo)
    end
    table.sort(self.mMainActivityList, function(v1, v2)
        return v1.id < v2.id
    end)
end

-- 解析活动任务配置
function parseActivitySignConfigData(self)
    self.mActivitySignList = {}
    self.mActivitySignDic = {}
    local baseData = RefMgr:getData("activity_sign_data")
    for key, data in pairs(baseData) do
        local vo = mainActivity.MainActivitySignVo.new()
        vo:parseConfigData(key, data)
        self.mActivitySignDic[vo.daily] = vo
        table.insert(self.mActivitySignList, vo)
    end
    table.sort(self.mActivitySignList, function(v1, v2)
        return v1.daily < v2.daily
    end)
end

-- 解析活动商店配置
function parseActivityShopConfigData(self)
    local baseData = RefMgr:getData("activity_shop_data")
    for key, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(mainActivity.MainActivityShopVo)
        vo:parseConfigData(key, data)
        self.mActivityShopConfig[vo.itemTid] = vo
    end
end

-- 解析活动任务奖励配置
function parseActivityTaskConfigData(self)
    local baseData = RefMgr:getData("activity_task_data")
    for key, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(mainActivity.MainActivityTaskVo)
        vo:parseConfigData(key, data)
        self.mActivityTaskConfig[vo.id] = vo
    end
end

-- 解析主题活动主界面配置
function getTrialConfigVo(self, dupId)
    if not self.m_TrialConfigDic then
        self.m_TrialConfigDic = {}
        local baseData = RefMgr:getData("try_hero_data")
        for key, config in pairs(baseData) do
            local vo = LuaPoolMgr:poolGet(mainActivity.MainActivityTrialConfigVo)
            vo:parseConfigData(key, config)
            self.m_TrialConfigDic[key] = vo
        end
    end

    return self.m_TrialConfigDic[dupId]
end

-- 解析活动签到服务端数据
function parseActivitySignMsg(self, msg)
    if msg then
        self.mActivitySignedList = {}
        self.mLoginDay = msg.login_day
        for _, signDay in pairs(msg.sign_day_reward_list) do
            if not table.indexof(self.mActivitySignedList, signDay) then
                table.insert(self.mActivitySignedList, signDay)
            end
        end

        GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)

        GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_SIGN_UPDATE)
    end
end

-- 解析服务器任务列表
function parseTaskMsg(self, msg)
    if next(msg.task_list) then
        for _, data in pairs(msg.task_list) do
            local vo = LuaPoolMgr:poolGet(mainActivity.MainActivityTaskMsgVo)
            vo:parseMsg(data)
            self.mActivityTaskMsg[vo.id] = vo
        end
    end

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_TASK_UPDATE)
end

--获取是否是第一次播放
function getIsFirstEnter(self)
    return self.mIsFirstEnter
end
--修改第一次播放状态
function setIsFirstEnter(self)
    self.mIsFirstEnter = false
end

-- 更新单个任务数据
function updateTaskMsg(self, msg)
    if next(msg.task_info) then
        if self.mActivityTaskMsg[msg.task_info.id] ~= nil then
            self.mActivityTaskMsg[msg.task_info.id]:parseMsg(msg.task_info)
        else
            local vo = LuaPoolMgr:poolGet(mainActivity.MainActivityTaskMsgVo)
            vo:parseMsg(msg.task_info)
            self.mActivityTaskMsg[vo.id] = vo
        end
    end

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_TASK_UPDATE)
end

-- 领取任务奖励
function onReceiveTaskAward(self, msg)
    if next(msg.task_id_list) then
        for _, id in pairs(msg.task_id_list) do
            self.mActivityTaskMsg[id].state = 2
        end

        GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)

        GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_TASK_UPDATE)
    end
end

-- 解析 商店MSG
function parseShopMsg(self, msg)
    if next(msg.goods_list) then
        for _, vo in pairs(msg.goods_list) do
            self.mActivityShopMsg[vo.id] = {id = vo.id, purchasedTimes = vo.buy_times}
        end
    end
end

-- 更新 商店MSG
function updateShopMsg(self, msg)
    if next(msg) then
        local Vo = self.mActivityShopMsg[msg.id]
        if Vo then
            Vo.purchasedTimes = msg.buy_times
        else
            self.mActivityShopMsg[msg.id] = {id = msg.id, purchasedTimes = msg.buy_times}
        end
    end
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_BUY_UPDATE, {id = msg.id})
end

--------------------------------------------------------------------------------------------------------------------------------------
function checkIsSigned(self, daily)
    return table.indexof(self.mActivitySignedList, daily) ~= false
end

function getLoginDay(self)
    return self.mLoginDay
end

function getMainActivitySignList(self)
    if #self.mActivitySignList <= 0 then
        self:parseActivitySignConfigData()
    end
    return self.mActivitySignList
end

function getMainActivitySignVoById(self, id)
    if not self.mActivitySignDic then
        self:parseActivitySignConfigData()
    end
    return self.mActivitySignDic[id]
end

function getMainActivityConfigList(self)
    if #self.mMainActivityList <= 0 then
        self:parseMainActivityConfigData()
    end
    return self.mMainActivityList
end

function getMainActivityVoById(self, activityId)
    if not self.mMainActivityDic then
        self:parseMainActivityConfigData()
    end
    return self.mMainActivityDic[activityId]
end

function getSignBubble(self)
    local flag = false
    for _, signVo in ipairs(self:getMainActivitySignList()) do
        if signVo:getCanReceive() then
            flag = true
            break
        end
    end
    return flag
end

-- 商店配置list
function getShopConfigList(self)
    if next(self.mActivityShopConfig) == nil then
        self:parseActivityShopConfigData()
    end
    if not self.mActivityShopConfigList then
        self.mActivityShopConfigList = {}
        for _, vo in pairs(self.mActivityShopConfig) do
            table.insert(self.mActivityShopConfigList, vo)
        end

        table.sort(self.mActivityShopConfigList, function(m_shopVo1, m_shopVo2) return m_shopVo1.sort < m_shopVo2.sort end)
    end
    return self.mActivityShopConfigList
end

--获取活动那个商店Vo
function getShopItemVo(self, tid)
    local shopItemVo = self.mActivityShopConfigDic[tid]
    return shopItemVo
end

--获取活动商店商品Price
function getShopItemPriceVo(self, tid)
    local shopItemVo = self.mActivityShopConfigDic[tid]

    return shopItemVo and shopItemVo.price or 0
end

--获取活动商店商品Price
function getShopItemPriceVo(self, tid)
    local shopItemVo = self.mActivityShopConfigDic[tid]
    return shopItemVo and shopItemVo.price or 0
end

--获取活动商店商品Msg Vo 商品id
function getShopMsgVo(self, id)
    return self.mActivityShopMsg[id]
end

-- 获取任务配置表
function getTaskConfig(self)
    if next(self.mActivityTaskConfig) == nil then
        self:parseActivityTaskConfigData()
    end
    return self.mActivityTaskConfig
end

-- 根据任务id获取任务配置
function getTaskConfigVo(self, taskId)
    if next(self.mActivityTaskConfig) == nil then
        self:parseActivityTaskConfigData()
    end
    return self.mActivityTaskConfig[taskId]
end

--  根据任务id获取任务MsgVo
function getTaskMsgVo(self, taskId)
    return self.mActivityTaskMsg[taskId]
end

--  根据任务id 判断任务奖励是否领取
function checkTaskAwardReceived(self, taskId)
    local taskMsgVo = self:getTaskMsgVo(taskId)
    if taskMsgVo == nil then
        return false
    end
    return taskMsgVo.state == 2
end

--  是否有可领取的任务
function checkTaskAwardCanReceive(self)
    if next(self.mActivityTaskMsg) then
        for _, msgVo in pairs(self.mActivityTaskMsg) do
            if msgVo.state == 0 then
                return true
            end
        end
    end
    return false
end

--一键领取所有任务奖励
function receiveAllTaskAward(self)
    local receiveList = {}
    if next(self.mActivityTaskMsg) then
        for _, msgVo in pairs(self.mActivityTaskMsg) do
            if msgVo.state == 0 then
                table.insert(receiveList, msgVo.id)
            end
        end
        if next(receiveList) then
            GameDispatcher:dispatchEvent(EventName.REQ_MAINACTIVITY_TASK_AWARD_RECEIVE, receiveList)
        else
            gs.Message.Show("领取失败")
        end
    else
        gs.Message.Show("领取失败")
        return false
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
