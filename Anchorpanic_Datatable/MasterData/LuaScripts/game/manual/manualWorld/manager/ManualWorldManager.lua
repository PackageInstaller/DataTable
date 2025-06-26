--[[ 
-----------------------------------------------------
@filename       : ManualWorldManager
@Description    : 图鉴-世界观
@date           : 2023-3-14 15:19:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualWorldManager", Class.impl(Manager))

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
    self.mManualWorldMsgList = {}
    self.mManualWorldConfigList = {}
    self.mManualWorldConfigDic = nil
    self.mManualWorldUnlockDic = nil
    self.mManualWorldUnlockList = {}
end

-- 解析图鉴配置
function parseManualWorldConfig(self)
    self.mManualWorldConfigDic = {}
    self.mManualWorldConfigList = {}
    local baseData = RefMgr:getData("manual_world_data")
    for key, data in pairs(baseData) do
        local vo = manual.ManualWorldVo.new()
        vo:parseData(key, data)
        self.mManualWorldConfigDic[vo.index] = vo
        table.insert(self.mManualWorldConfigList, vo)
    end
    table.sort(self.mManualWorldConfigList, function(vo1, vo2) return vo1.index < vo2.index end)
end

-- 解析服务器返回
function parseManualWorldMsg(self, msg)
    if msg then
        for _, worldId in ipairs(msg.world_list) do
            if table.indexof(self.mManualWorldMsgList, worldId) == false then
                table.insert(self.mManualWorldMsgList, worldId)
            end
        end
    end
    --   table.sort(self.mManualWorldConfigList, function(vo1, vo2) return vo1.sort < vo2.sort end)
end

-- 解析图鉴配置
function parseManualWorldUnlockConfig(self)
    self.mManualWorldUnlockDic = {}
    self.mManualWorldUnlockList = {}
    local baseData = RefMgr:getData("manual_world_unlock_data")
    for key, data in pairs(baseData) do
        local vo = manual.ManualWorldUnlockVo.new()
        vo:parseData(key, data)
        if not self.mManualWorldUnlockDic[vo.tag] then
            self.mManualWorldUnlockDic[vo.tag] = {}
        end
        table.insert(self.mManualWorldUnlockDic[vo.tag], vo)
        table.insert(self.mManualWorldUnlockList, vo)
    end
    for _, list in pairs(self.mManualWorldUnlockDic) do
        table.sort(list, function(vo1, vo2) return vo1.worldId < vo2.worldId end)
    end
    table.sort(self.mManualWorldUnlockList, function(vo1, vo2) return vo1.worldId < vo2.worldId end)

end
--获取子列表数据
function getWorldLitleListByType(self, tag)
    if not self.mManualWorldUnlockDic then
        self:parseManualWorldUnlockConfig()
    end
    return self.mManualWorldUnlockDic[tag] or {}
end

--获取总列表
function getWorldLitleList(self)
    if #self.mManualWorldUnlockList <= 0 then
        self:parseManualWorldUnlockConfig()
    end
    return self.mManualWorldUnlockList
end

function getAllHaveNew(self)
    for _, worldVo in ipairs(self:getWorldLitleList()) do
        if worldVo:getIsNew() then
            return true
        end
    end
    return false
end

function getCurNewStateByType(self, type)
    local list = type > 1 and self:getWorldLitleListByType(type) or self:getWorldLitleList()
    for _, worldVo in ipairs(list) do
        if worldVo:getIsNew() then
            return true
        end
    end
    return false
end

function getTabList(self, tabType)
    local tabList = {}
    if not self.mManualWorldConfigDic then
        self:parseManualWorldConfig()
    end
    if tabType ~= 1 then
        tabList = self:getCurUnlockListByType(tabType)
    else
        for _, worldVo in pairs(self.mManualWorldConfigDic) do
            if worldVo.type >= 2 then
                for _, Vo in ipairs(self:getCurUnlockListByType(worldVo.type)) do
                    table.insert(tabList, Vo)
                end
            end
        end
    end
    return tabList or {}
end

function getCurProgresstByType(self, type)
    if type > 1 then
        return math.floor(#self:getTabList(type) / #self:getWorldLitleListByType(type) * 100)
    else
        return math.floor(#self:getTabList(type) / #self:getWorldLitleList() * 100)
    end
end

function getCurUnlockListByType(self, type)
    local list = {}
    for _, infoVo in ipairs(self:getWorldLitleListByType(type)) do
        if infoVo:getIsUnlock() then
            table.insert(list, infoVo)
        end
    end
    return list or {}
end

function getTabVo(self, type)
    if not self.mManualWorldConfigDic then
        self:parseManualWorldConfig()
    end
    return self.mManualWorldConfigDic[type]
end

function getManualWorldTabList(self)
    if #self.mManualWorldConfigList <= 0 then
        self:parseManualWorldConfig()
    end
    return self.mManualWorldConfigList
end

function getIsUnlockById(self, worldId)
    return (table.indexof(self.mManualWorldMsgList, worldId) ~= false)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]