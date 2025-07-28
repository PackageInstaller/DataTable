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

    -- 推介是否已显示
    self.promoIsShow = false
end

-- 解析轮播配置
function parseBillboardConfigData(self)
    self.mBillboardList = {}
    local baseData = nil
    local channelId, channelName = sdk.SdkManager:getChannelData()
    if(GameManager:getIsInCommiting() and (channelId == sdk.AndroidChannelId.QIANYOU or channelId == sdk.AndroidChannelId.QUICK or channelId == sdk.AndroidChannelId.QUICK2 or channelId == sdk.AndroidChannelId.QUICK3))then
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

-- 获取轮播配置数据
function getBillboardList(self)
    if not self.mBillboardList then
        self:parseBillboardConfigData()
    end
    return self.mBillboardList
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


return _M

--[[ 替换语言包自动生成，请勿修改！
]]