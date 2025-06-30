--[[ 
-----------------------------------------------------
@filename       : ManualManager
@Description    : 图鉴
@date           : 2022-2-22 10:25:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualManager", Class.impl(Manager))

-- 图鉴数据更新
MANUAL_DATA_UPDATE = "MANUAL_DATA_UPDATE"
-- 怪物图鉴选择改变
OPEN_MONSTER_INFOVIEW = "OPEN_MONSTER_INFOVIEW"
-- 战员图鉴选择改变
MANUAL_HERO_SELECT = "MANUAL_HERO_SELECT"

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
    self.mManualMonConfigDic = nil
    self.mManualMonConfigList = nil
    self.mHasFightList = nil
    self.lastIndex = nil
    self.mEquipUnlockTidList = {}
end

-- 解析图鉴配置
function parseManualMonConfig(self)
    self.mManualMonConfigDic = {}
    self.mManualMonConfigList = {}
    local baseData = RefMgr:getData("manual_mon_data")
    for id, data in pairs(baseData) do
        local vo = manual.ManualMonsterConfigVo.new()
        vo:parseData(id, data)
        self.mManualMonConfigDic[vo.model] = vo
        table.insert(self.mManualMonConfigList, vo)
    end
    table.sort(self.mManualMonConfigList,
    function(configVo1, configVo2)
        return configVo1.id < configVo2.id
    end
    )
end

--解析怪物页签配置
function parseManualMonTypeConfig(self)
    self.mManualMonTypeConfigDic = {}
    self.mManualMonTypeConfigList = {}
    local baseData = RefMgr:getData("manual_mon_type_data")
    for _, data in ipairs(baseData) do
        local vo = manual.ManualMonsterConfigTypeVo.new()
        vo:parseData(data)
        self.mManualMonTypeConfigDic[vo.type] = vo
        table.insert(self.mManualMonTypeConfigList, vo)
    end
    table.sort(self.mManualMonTypeConfigList, function(vo1, vo2) return vo1.type < vo2.type end)
end

--获取怪兽页签数据
function getMonsterVoByType(self, type)
    if not self.mManualMonTypeConfigDic then
        self:parseManualMonTypeConfig()
    end
    return self.mManualMonTypeConfigDic[type]
end
--获取怪兽页签列表
function getMonsterTabList(self)
    if (not self.mManualMonTypeConfigList) then
        self:parseManualMonTypeConfig()
    end
    return self.mManualMonTypeConfigList
end
-- 获取图鉴怪物配置数据
function getMonsterConfigVo(self, model)
    if (not self.mManualMonConfigDic) then
        self:parseManualMonConfig()
    end
    return self.mManualMonConfigDic[model]
end

-- 获取图鉴怪物配置列表
function getMonsterConfigList(self)
    if (not self.mManualMonConfigList) then
        self:parseManualMonConfig()
    end
    return self.mManualMonConfigList
end
--是否还有未读
function getAllHaveNew(self)
    for _, monsterVo in ipairs(self:getMonsterConfigList()) do
        if monsterVo:getIsNew() then
            return true
        end
    end
    return false
end

--是否还有未读
function getNewStateByType(self, type)
    for _, monsterVo in ipairs(manual.ManualManager:getCurListDataByType(type)) do
        if monsterVo:getIsNew() then
            return true
        end
    end
    return false
end


function parseHasFightList(self, isInit, monIdList)
    if (isInit or not self.mHasFightList) then
        self.mHasFightList = monIdList
    else
        for i = 1, #monIdList do
            if (table.indexof(self.mHasFightList, monIdList[i]) == false) then
                table.insert(self.mHasFightList, monIdList[i])
            end
        end
    end
    self:dispatchEvent(self.MANUAL_DATA_UPDATE, { type = manual.ManualType.Monster })
end

function parseHasGotEquip(self, msg)
    if msg.is_init == 1 then
        self.mEquipUnlockTidList = {}
    end

    for k, v in pairs(msg.bracelet_list) do
        local configVo = props.PropsManager:getPropsConfigVo(v)
        local color = configVo.color
        if (self.mEquipUnlockTidList[color] == nil) then
            self.mEquipUnlockTidList[color] = {}
        end
        if not table.indexof(self.mEquipUnlockTidList[color], v) then
            table.insert(self.mEquipUnlockTidList[color], v)
        end
    end
    for k, v in pairs(self.mEquipUnlockTidList) do
        table.sort(v,
        function(v1, v2)
            return v1 < v2
        end)
    end
end

-- 根据图鉴怪物模型判断是否已经打过
function judgeIsHasFight(self, id)
    if (not self.mHasFightList) then
        return false
    end
    return table.indexof(self.mHasFightList, id)
end

function jugEquipHasUnlockByTid(self, equipTid)
    local configVo = props.PropsManager:getPropsConfigVo(equipTid)
    if not self.mEquipUnlockTidList[configVo.color] then
        return false
    end
    return table.indexof(self.mEquipUnlockTidList[configVo.color], equipTid)
end

function jugEquipHasUnlock(self, color, equipTid)
    if not self.mEquipUnlockTidList[color] then
        return false
    end
    return table.indexof(self.mEquipUnlockTidList[color], equipTid)
end

function getUnlockEquipList(self, color)
    if (color == 1) then
        local res = {}
        for k, v in pairs(self.mEquipUnlockTidList) do
            for m, n in pairs(v) do
                table.insert(res, n)
            end
        end
        return res
    end
    return self.mEquipUnlockTidList[color] ~= nil and self.mEquipUnlockTidList[color] or {}
end

--根据模型id判断当前数据列表中的位置
function getCurIndexByModel(self, model, type)
    for i, v in ipairs(self:getTypeHasFightMonsterList(type)) do
        if v.model == model then
            return i
        end
    end
end
--获取见过的怪物列表根据类型
function getTypeHasFightMonsterList(self, type)
    local list = {}
    for k, v in ipairs(self:getHasFightMonsterList()) do
        if v.type == type then
            table.insert(list, v)
        end
    end
    return list or {}
end

--获取见过的怪物列表
function getHasFightMonsterList(self)
    local hasFightList = {}
    for _, v in ipairs(self:getMonsterConfigList()) do
        if self:judgeIsHasFight(v.id) then
            table.insert(hasFightList, v)
        end
    end
    return hasFightList
end

--获取当前的怪物总进度
function getMonsterProgress(self)
    local hasFightList = self:getHasFightMonsterList()
    local progress = math.floor(#hasFightList / #self:getMonsterConfigList() * 100)
    return progress
end

--获取当前类型的列表数据
function getCurListDataByType(self, type)
    local curList = {}
    for _, v in ipairs(self:getMonsterConfigList()) do
        if v.type == type then
            table.insert(curList, v)
        end
    end
    return curList
end

function getBracelesConfigDic(self, type)
    if type == nil then
        type = 1
    end
    if self.mBracelesList then
        if type == 1 then
            local allList = {}
            for k, v in pairs(self.mBracelesList) do
                for m, n in pairs(v) do
                    table.insert(allList, n)
                end
            end
            return allList
        end
        return self.mBracelesList[type] == nil and {} or self.mBracelesList[type]
    end

    local equipDic = equip.EquipManager:getAllEquipConfigVo()
    self.mBracelesList = {}
    for k, v in pairs(equipDic) do
        if k >= 7100 then --大于7100都是手环
            local configVo = props.PropsManager:getPropsConfigVo(k)
            local color = configVo.color
            if (self.mBracelesList[color] == nil) then
                self.mBracelesList[color] = {}
            end
            table.insert(self.mBracelesList[color], v)
        end
    end
    for k, v in pairs(self.mBracelesList) do
        table.sort(v,
        function(v1, v2)
            return v1.tid < v2.tid
        end)
    end
    return self:getBracelesConfigDic(type)
end

function getBracelesAllHaveNew(self)
    for _, BracelesVo in pairs(self:getBracelesConfigDic()) do
        if BracelesVo:getIsNew() then
            return true
        end
    end
    return false
end

function getBracelesNewStateByType(self, type)
    for _, BracelesVo in ipairs(self:getBracelesConfigDic(type)) do
        if BracelesVo:getIsNew() then
            return true
        end
    end
    return false
end

function setLastIndex(self, index)
    self.lastIndex = index
end

function getLastIndex(self)
    if self.lastIndex == nil then
        return 1
    else
        return self.lastIndex
    end
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]