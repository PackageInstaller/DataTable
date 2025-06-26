module("dup.DupEquipMainManager", Class.impl(Manager))

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

function __init(self)
end

function parseDailyEquipConfig(self)
    self.mDupEquipList = {}
    local baseData = RefMgr:getData("chip_dup_show_data")
    for key, data in pairs(baseData) do
        local vo = dup.DupEquipConfigVo.new()
        vo:parseData(key, data)
        table.insert(self.mDupEquipList, vo)
    end
    table.sort(self.mDupEquipList, function(vo1, vo2)
        return vo1.id < vo2.id
    end)
end

function getDupEquipData(self)
    if self.mDupEquipList == nil then
        self:parseDailyEquipConfig()
    end
    return self.mDupEquipList
end

function getDupEquipSuitList(self)
    if not self.mDupEquipList then
        self:parseDailyEquipConfig()
    end
    return self.mDupEquipList[1]:getSuitList()
end

function getDupEquipName(self, type)
    if self.mDupEquipList == nil then
        self:parseDailyEquipConfig()
    end
    for key, data in pairs(self.mDupEquipList) do
        if (data.type == type) then
            return data.name
        end
    end
    return ""
end

--入口是否开启
function getEntryIsPass(self, type)
    if type ~= self:getDupEquipData()[1].type then
        local curType = type - 1
        for _, dupVo in ipairs(dup.DupDailyMainManager:getDupDataList(curType)) do
            if dup.DupEquipBaseManager:getDupState(dupVo) ~= 2 then
                return false
            end
        end
    end
    return true
end

function getDupEquipDes(self, type)
    if self.mDupEquipList == nil then
        self:parseDailyEquipConfig()
    end

    for key, data in pairs(self.mDupEquipList) do
        if (data.type == type) then
            return data.des
        end
    end
    return ""

end

function getOpenIdByType(self, type)
    if self.mDupEquipList == nil then
        self:parseDailyEquipConfig()
    end

    for key, data in pairs(self.mDupEquipList) do
        if (data.type == type) then
            return data.funcId
        end
    end
    return ""
end

-- 类型副本列表
function getDupDataList(self, cusType)
    return dup.DupDailyMainManager:getDupDataList(cusType)
end

function getDupData(self, refID)
    return dup.DupDailyMainManager:getDupData(refID)
end

function getDupNameByType(self, type)
    for i, v in ipairs(self:getDupEquipData()) do
        if v.type == type then
            return v:getName()
        end
    end
end

-- 获取副本章节名和副本名
function getDupName(self, cusId)
    local dupVo = self:getDupData(cusId)
    local chapterVo
    for i, v in ipairs(self:getDupEquipData()) do
        if v.type == dupVo.type then
            chapterVo = v
        end
    end
    return chapterVo:getName(), dupVo:getName()
end

function getRecommandFight(self, cusId)
    local dupVo = self:getDupData(cusId)
    return dupVo.power
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]