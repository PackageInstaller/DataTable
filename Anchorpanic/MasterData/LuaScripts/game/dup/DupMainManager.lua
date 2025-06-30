--[[
    副本总数据
    @author Jacob
]]
module('dup.DupMainManager', Class.impl(Manager))

-- 副本信息初始化
EVENT_DUP_INFO_INIT = "EVENT_DUP_INFO_INIT"
-- 副本更新
EVENT_DUP_INFO_UPDATE = "EVENT_DUP_INFO_UPDATE"
-- 副本双倍
EVENT_DUP_UP_UPDATE = "EVENT_DUP_INFO_UPDATE"
--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

function __init(self)
    self.mDupData = {}
    self.mDupUpDataList = {}
    self.mDupUpRemainNum = 0
    self.mDupMaxUpNum = 0
end

-- 解析副本信息
function parseDupDataMsg(self, msg)
    for k, v in pairs(msg.dup_info) do
        local vo = dup.DupInfoVo.new()
        vo:parseData(v)
        self.mDupData[vo.type] = vo
    end
    self:dispatchEvent(EVENT_DUP_INFO_INIT)
end

-- 解析副本Up信息
function parseDupUpInfoMsg(self, msg)
    if msg then
        self.mDupUpRemainNum = msg.remain_times
        self.mDupMaxUpNum = msg.max_times
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_DUP_UP)
end

function getIsShowUp(self)
    if self.mDupUpRemainNum > 0 and self.mDupMaxUpNum > 0 then
        return true
    end
    return false
end
--获取资源副本经验双倍up剩余次数与总次数
function getUpNumAndMaxNum(self)
    return self.mDupUpRemainNum, self.mDupMaxUpNum
end

function parseDupUpConfigData(self)
    self.mDupUpDataList = {}
    local baseData = RefMgr:getData("activity_dup_up_data")
    for key, data in pairs(baseData) do
        local vo = dup.DupUpVo.new()
        vo:parseData(key, data)
        table.insert(self.mDupUpDataList, vo)
    end

    table.sort(self.mDupUpDataList, function(vo1, vo2)
        return vo1.id < vo2.id
    end)
end

--获取当前副本是否可Up
function getIsDupUp(self, type)
    if #self.mDupUpDataList <= 0 then
        self:parseDupUpConfigData()
    end
    for _, dupUpVo in ipairs(self.mDupUpDataList) do
        if (table.indexof(dupUpVo:getTypeList(), type) ~= false) and self:getIsShowUp() then
            return true
        end
    end
    return false
end

--获取是否符合活动币添加
--dupType 副本类型
function getIsMatchActivityMoney(self, dupType)
    local isMatch = false
    local list = sysParam.SysParamManager:getValue(SysParamType.DUP_DROP_ACTIVITYMONEY_lIST)
    if table.indexof(list, dupType) and activity.ActivityManager:getActivityVoById(activity.ActivityId.MainActivity) then
        isMatch = true
    end
    return isMatch
end

-- 副本更新
function parseDupUpdateMsg(self, msg)
    local vo = self:getDupInfoData(msg.dup_info.type)
    if not vo then
        vo = dup.DupInfoVo.new()
    end
    vo:parseData(msg.dup_info)

    self:dispatchEvent(EVENT_DUP_INFO_UPDATE, vo.type)
end

-- 获取副本数据 cusType 副本类型
function getDupInfoData(self, cusType)
    return self.mDupData[cusType]
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
