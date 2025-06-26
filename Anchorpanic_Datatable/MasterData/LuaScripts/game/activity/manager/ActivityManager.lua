--[[ 
-----------------------------------------------------
@filename       : ActivityManager
@Description    : 运营活动数据管理
@date           : 2020-12-09 19:29:14
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.activity.manager.ActivityManager', Class.impl(Manager))

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
    self.activityOpenMap = {}
    self.activityCloseMap = {}
    self.mBillboardList = nil
    --限时活动列表
    self.mActivityLimitList = {}
    --非限时活动列表
    self.mActivityHideEntrance = {}
    -- 新手活动结束时间戳
    self.noviceActivityEndTime = 0

    -- 推介是否已显示,nil 为初始化
    self.promoIsShow = nil

    --活动每日奖励领取数据
    self.mDailyRewadGotDic = {}
end

-- 解析轮播配置
function parseBillboardConfigData(self)
    self.mBillboardList = {}
    local baseData = nil
    local channelId, channelName = sdk.SdkManager:getChannelData()
    if (GameManager:getIsInCommiting() and (channelId == sdk.AndroidChannelId.QIANYOU or channelId == sdk.AndroidChannelId.QUICK or channelId == sdk.AndroidChannelId.QUICK2 or channelId == sdk.AndroidChannelId.QUICK3)) then
        baseData = RefMgr:getData("billboard_data_channel")
    else
        baseData = RefMgr:getData("billboard_data")
    end
    for key, data in pairs(baseData) do
        local vo = activity.BillboardConfigVo.new()
        vo:parseConfigData(key, data)
        table.insert(self.mBillboardList, vo)
    end
    table.sort(self.mBillboardList, function(v1, v2)
        return v1.id < v2.id
    end)
end

-- 解析时装通行证轮播配置
function parsePermitBillboardConfigData(self)
    self.mPermitBillboardList = {}
    local baseData = nil
    local channelId, channelName = sdk.SdkManager:getChannelData()
    if (GameManager:getIsInCommiting() and (channelId == sdk.AndroidChannelId.QIANYOU or channelId == sdk.AndroidChannelId.QUICK or channelId == sdk.AndroidChannelId.QUICK2 or channelId == sdk.AndroidChannelId.QUICK3)) then
        baseData = RefMgr:getData("permit_billboard_data")
    else
        baseData = RefMgr:getData("permit_billboard_data")
    end
    for key, data in pairs(baseData) do
        local vo = activity.PermitBillboardVo.new()
        vo:parseConfigData(key, data)
        table.insert(self.mPermitBillboardList, vo)
    end
    table.sort(self.mPermitBillboardList, function(v1, v2)
        return v1.id < v2.id
    end)
end

-- 获取轮播配置数据
function getBillboardList(self)
    if not self.mBillboardList then
        self:parseBillboardConfigData()
    end
    return self.mBillboardList
end

-- 获取时装通行证轮播配置数据
function getPermitBillboardList(self)
    if not self.mPermitBillboardList then
        self:parsePermitBillboardConfigData()
    end
    return self.mPermitBillboardList
end

--------------------------限时活动管理-----------------------------
-- 活动开启列表
function parseActivityOpenMsg(self, msg)
    local list = {}
    for i, v in ipairs(msg.open_list) do

        local vo = self.activityOpenMap[v.id]
        if not vo then
            vo = activity.ActivityVo.new()
        end
        vo:parseMsg(v)
        self.activityOpenMap[vo.id] = vo
        table.insert(list, vo)
    end
    GameDispatcher:dispatchEvent(EventName.ACTIVITY_OPEN_UPDATE, { openList = list })
end

-- 活动关闭推送
function parseActivityOverMsg(self, msg)
    for i, v in ipairs(msg.over_id_list) do
        local vo = self.activityOpenMap[v]
        self.activityOpenMap[v] = nil

        self.activityCloseMap[v] = vo
    end
    GameDispatcher:dispatchEvent(EventName.ACTIVITY_CLOSE_UPDATE, { closeList = msg.over_id_list })
    self:updateMainUIRedState(msg.over_id_list)
end

-- 新手活动开启
function parseActivityNoviceUpdateMsg(self, endTime)
    self.noviceActivityEndTime = endTime
    GameDispatcher:dispatchEvent(EventName.ACTIVITY_NOVICE_UPDATE)
end

-- 新手活动是否开启中
function getNoviceActivityIsOpen(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_NOVICE_ACTIVITY, false) then
        if self.noviceActivityEndTime > 0 and self.noviceActivityEndTime > GameManager:getClientTime() then
            return true
        end
        
    end
    return false
end

function getNoviceActivitySsrIsOpen(self)
    --if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_NOVICE_ACTIVITY, false) then
        local clientTime = GameManager:getClientTime()
        local ssrEndTime  = noviceActivity.NoviceActivityManager:getSSrEndTime()
        if (ssrEndTime > 0 and ssrEndTime > clientTime) then
            return true
        end
    --end
    return false
end

function getNoviceActivityRechargeIsOpen(self)
    --if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_NOVICE_ACTIVITY, false) then
        local clientTime = GameManager:getClientTime()
        local rechargeEndTime  = noviceActivity.NoviceActivityManager:getNoviceActivityRechargeEndTime()
        if (rechargeEndTime > 0 and rechargeEndTime > clientTime) then
            return true
        end
    --end
    return false
end

function getNoviceActivityEndTime(self)
    return self.noviceActivityEndTime
end


-- 获取活动开放列表
function getActivityOpenList(self)
    local list = {}
    for k, v in pairs(self.activityOpenMap) do
        table.insert(list, v)
    end
    table.insert(list, function(a, b)
        return a.endTime < b.endTime
    end)
end

-- 获取活动开放数据根据活动id
function getActivityVoById(self, cusId)
    return self.activityOpenMap[cusId]
end

-- 通过id检测活动是否开启
function checkIsOpenById(self, cusId)
    local vo = self.activityOpenMap[cusId]
    if vo and vo:isOpen() then
        return true
    end
    return false
end

-- 通过功能开放id检测活动是否开启
function checkIsOpenByFuncId(self, cusFuncId)
    for k, v in pairs(self.activityOpenMap) do
        if v.funcId == cusFuncId and v:isOpen() and v:isFuncOpen() then
            return true
        end
    end
    return false
end

-- 获取一个在线状态被关闭的活动
function getCloseActivity(self, cusId)
    return self.activityCloseMap[cusId]
end

-- 获取轮播广告开放状态
function getBillboardIsOpenByFunId(self, funcId)
    if funcId == funcopen.FuncOpenConst.FUNC_ID_WELFAREOPT_SEVENDAY_TARGET then
        return (not activityTarget.ActivityTargetManager:getIsFinish())
    end
    return true
end
--草创活动处理逻辑暂不引用
function registerActivityVo(self, activityVo, islimit)
    if islimit then
        if table.indexof(self.mActivityLimitList, activityVo) == false then
            table.insert(self.mActivityLimitList, activityVo)
        end
    else
        if table.indexof(self.mActivityHideEntrance, activityVo) == false then
            table.insert(self.mActivityHideEntrance, activityVo)
        end
    end
end

function getActivityVoByFuncId(self, funcId)

end

function updateMainUIRedState(self, closeList)
    for _, id in ipairs(closeList) do
        local closeVo = self:getCloseActivity(id)
        if closeVo then
            mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_ACTIVITY, false, closeVo.funcId)
        end
    end
end
--策划说跨天签到后也应弹出弹窗
function setPromoIsShow(self, isShow)
    if self.promoIsShow ~= isShow then
        self.promoIsShow = isShow
    end
end

function getPromoIsShow(self)
    return self.promoIsShow
end



function parseInvestPanelMsg(self,msg)
    --档位
    self.grade = msg.grade 
    --活动天数
    self.activityDay = msg.activity_day
    --充值金额
    self.totalCount = msg.total_count
    --天数奖励
    self.assetRewardList = msg.asset_reward_list
    --累计天数奖励
    self.itemRewardList = msg.item_reward_list

    self:updateRed()

    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_INVEST_VIEW)
end

function getActivityDay(self)
    return self.activityDay == nil and 0 or self.activityDay
end

function getInvestGrade(self)
    return self.grade == nil and 0 or self.grade
end

function getInvestTotalCount(self)
    return self.totalCount == nil and 0 or self.totalCount / 100
end

function getInvestItemRewardGeted(self,id)
    if self.itemRewardList == nil then
        return false
    end
    return table.indexof01(self.itemRewardList, id) > 0
end

function getInvestAssetRewardGeted(self,id)
    if self.assetRewardList == nil then
        return false
    end
    return table.indexof01(self.assetRewardList, id) > 0
end

--更新购买的档位
function updateInvestBuy(self,msg)
    self.grade = msg.grade_id 

    gs.Message.Show(_TT(81008))
    self:updateRed()
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_INVEST_VIEW)
end

function updateInvestGet(self,msg)
    if msg.type == 1 then
        table.insert(self.assetRewardList, msg.reward_id)
    elseif msg.type == 2 then
        table.insert(self.itemRewardList, msg.reward_id)
    end
    self:updateRed()
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_INVEST_VIEW)
end

function updateRed(self)
    local isRed = self:getInvestRed()
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_SPECIALSUPPLY, isRed, funcopen.FuncOpenConst.FUNC_ID_ACTIVITY_INVEST)
end

function getInvestRed(self)
    local isRed = false

    local list = self:getInvestAccrueData()
    for k, v in pairs(list) do
        isRed = isRed or self:canDefGetRed(k)
    end

    isRed = isRed or self:canBuyInvest()
    
    local awardList = self:getInvestList()
    local grade = self:getInvestGrade()
    if grade > 0 then
        local investVo = self:getInvestDataById(grade)
        for k, v in pairs(investVo.dayReward) do
            isRed = isRed or self:canGetGradeRed(k)
        end
    end

    return isRed
end

function canBuyInvest(self)
    local needMoney = sysParam.SysParamManager:getValue(SysParamType.ACTIVITY_INVEST_NEED_MONEY) / 100
    local curMoney = activity.ActivityManager:getInvestTotalCount()
    local grade = self:getInvestGrade()
    if needMoney > curMoney or grade > 0 then
        return false
    end

    local prefixVersion = download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.PrefixVersionKey)
    if StorageUtil:getBool1(prefixVersion .. "invest") == false then
        return true
    else 
        return false
    end
end

function canDefGetRed(self,id)
    local curMoney = self:getInvestTotalCount()
    local needMoney = sysParam.SysParamManager:getValue(SysParamType.ACTIVITY_INVEST_NEED_MONEY) / 100
    if curMoney < needMoney then
        return false
    end

    local curDay = self:getActivityDay()
    return curDay >= self:getInvestAccrueDataById(id).day and self:getInvestItemRewardGeted(self:getInvestAccrueDataById(id).id) == false
end

function canGetGradeRed(self,id)
    if self:getInvestGrade() <=0 then
        return false
    end

    local curMoney = self:getInvestTotalCount()
    local needMoney = sysParam.SysParamManager:getValue(SysParamType.ACTIVITY_INVEST_NEED_MONEY) / 100
    if curMoney < needMoney then
        return false
    end

    local curDay = self:getActivityDay()
    return curDay >= id and self:getInvestAssetRewardGeted(id) == false
end


function parseInvestData(self)
    self.mInvestData = {}
    self.mInvestList = {}
    local baseData = RefMgr:getData("invest_reward_data")
    for k, v in pairs(baseData) do
        local vo = activity.ActivityInvestRewardVo.new()
        vo:parseData(k, v)
        table.insert(self.mInvestList, vo)
        self.mInvestData[k] = vo
    end
    table.sort(self.mInvestList, function(a, b)
        return a.id < b.id
    end)
end

function getInvestList(self)
    if self.mInvestData == nil then
        self:parseInvestData()
    end
    return self.mInvestList
end

function getInvestDataById(self,id)
    if self.mInvestData == nil then
        self:parseInvestData()
    end
    return self.mInvestData[id]
end

function parseInvestAccrueData(self)
    self.mInvestAccrueData = {}
    local baseData = RefMgr:getData("invest_accrue_return_data")
    for k, v in pairs(baseData) do
        local vo = activity.ActivityInvestAccrueVo.new()
        vo:parseData(k, v)
        table.insert(self.mInvestAccrueData, vo)
    end
    table.sort(self.mInvestAccrueData, function(a, b)
        return a.day < b.day
    end)
end

function getInvestAccrueData(self)
    if self.mInvestAccrueData == nil then
        self:parseInvestAccrueData()
    end
    return self.mInvestAccrueData
end

function getInvestAccrueDataById(self,id)
    if self.mInvestAccrueData == nil then
        self:parseInvestAccrueData()
    end
    return self.mInvestAccrueData[id]
end

--更新活动每日奖励领取数据
function updateDayRewardMsg(self, msg)
    self.mDailyRewadGotDic = {}
    for _, activity_id in ipairs(msg.activity_id) do
        self.mDailyRewadGotDic[activity_id] = 1
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
end

function checkIsGotDailyReward(self, activity_id)
    return self.mDailyRewadGotDic[activity_id] == 1
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]