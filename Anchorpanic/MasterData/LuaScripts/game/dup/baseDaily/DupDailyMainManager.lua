--[[ 
    日常副本总数据
    @author Jacob
]]
module('dup.DupDailyMainManager', Class.impl(Manager))

-- 副本信息初始化
EVENT_DUP_INFO_INIT = "EVENT_DUP_INFO_INIT"
-- 副本更新
EVENT_DUP_INFO_UPDATE = "EVENT_DUP_INFO_UPDATE"

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

function __init(self)

end

-- 日常副本总表
function parseDailyDupConfig(self)
    self.mDupEntryList = {}
    local baseData = RefMgr:getData("daily_dup_data")
    for key, data in pairs(baseData) do
        local vo = dup.DupDailyConfigVo.new()
        vo:parseData(key, data)
        table.insert(self.mDupEntryList, vo)
    end

    table.sort(self.mDupEntryList, function(vo1, vo2)
        return vo1.id < vo2.id
    end)
end

function getDailyDupName(self, type)
    if self.mDupEntryList == nil then
        self:parseDailyDupConfig()
    end

    for key, data in pairs(self.mDupEntryList) do
        if (data.type == type) then
            return data.name
        end

        for i = 1, #data.subType do
            if data.subType[i] == type then
                return data.subName[i]
            end
        end

    end
    return ""
end


function getDailyDupDes(self, type)
    if self.mDupEntryList == nil then
        self:parseDailyDupConfig()
    end

    for key, data in pairs(self.mDupEntryList) do
        if (data.type == type) then
            return data.des
        end

        for i = 1, #data.subType do
            if data.subType[i] == type then
                return data.des
            end
        end

    end
    return ""
end

function getDailyDupFuncId(self, type)
    if self.mDupEntryList == nil then
        self:parseDailyDupConfig()
    end

    for key, data in pairs(self.mDupEntryList) do
        if (data.type == type) then
            return data.funcId
        end
    end
end


-- 初始化副本数据配置表
function parseConfigData(self)
    self.mConfigDic = {}
    local baseData = RefMgr:getData("dup_data")
    for key, data in pairs(baseData) do
        local vo = dup.DupDailyDataVo.new()
        vo:parseData(key, data)
        if not self.mConfigDic[vo.type] then
            self.mConfigDic[vo.type] = {}
        end
        table.insert(self.mConfigDic[vo.type], vo)
    end

    for k, v in pairs(self.mConfigDic) do
        table.sort(v, function(vo1, vo2)
            return vo1.sort < vo2.sort
        end)
    end
end

-- 类型副本列表
function getDupDataList(self, cusType)
    if not self.mConfigDic then
        self:parseConfigData()
    end
    return self.mConfigDic[cusType]
end

function getDupData(self, refID)
    if not self.mConfigDic then
        self:parseConfigData()
    end

    for dataType, li in pairs(self.mConfigDic) do
        for i, v in ipairs(li) do
            if v.dupId == refID then
                return v
            end
        end
    end
end

-- 日常副本总览列表
function getDupEntryList(self)
    if not self.mDupEntryList then
        self:parseDailyDupConfig()
    end
    return self.mDupEntryList
end

-- 日常副本总览列表
function getDupEntryListByType(self, type)
    if not self.mDupEntryList then
        self:parseDailyDupConfig()
    end
    local list = {}
    for _, dupVo in ipairs(self.mDupEntryList) do
        if dupVo.tapType == type then
            table.insert(list, dupVo)
        end
    end
    return list
end

-- 获取副本章节名和副本名
function getDupNameByType(self, dupType)
    for i, v in ipairs(self:getDupEntryList()) do
        if v.type == dupType then
            return v:getTitleName()
        end
    end
end

-- 获取副本章节名和副本名
function getDupName(self, cusId)
    local dupVo = self:getDupData(cusId)
    local chapterVo
    for i, v in ipairs(self:getDupEntryList()) do
        if v.type == dupVo.type or table.indexof(v.subType, dupVo.type) ~= false then
            chapterVo = v
        end
    end
    return chapterVo:getName(), dupVo:getName()
end

function getRecommandFight(self, cusId)
    local dupVo = self:getDupData(cusId)
    return dupVo.power
end

-- 获取缓存的日常本当前挑战副本id
function getLastDupId(self, cusDupType)
    local dupId = StorageUtil:getNumber1('dailyDupLastId_' .. cusDupType)
    return dupId
end
-- 缓存日常本当前挑战的关卡id
function setLastDupId(self, cusDupType, cusDupId)
    StorageUtil:saveNumber1('dailyDupLastId_' .. cusDupType, cusDupId)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]