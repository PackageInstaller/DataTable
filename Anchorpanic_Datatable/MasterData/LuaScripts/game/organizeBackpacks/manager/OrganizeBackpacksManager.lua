--[[
-----------------------------------------------------
@filename       : OrganizeBackpacksManager
@Description    : 整理背包管理器
@date           : 2024-9-24 10:05:14
@Author         : Shuai
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.organizeBackpacks.manager.OrganizeBackpacksManager', Class.impl(Manager))

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
    self.mPackBagTypeDic = {}
    self.mPackBagDupDic = {}
    self.mPackBagItemDic = {}
    self.mPackBagLevelInfoDic = {}
    self.mPassLevelList = {}
end

-- 解析整理背包关卡配置
function parseOrganizeBackpacksConfigData(self)
    self.mPackBagDupDic = {}
    local baseData = RefMgr:getData("pack_bag_dup_data")
    for key, data in pairs(baseData) do
        local vo = organizeBackpacks.OrganizeBackpacksVo.new()
        vo:parseConfigData(key, data)
        self.mPackBagDupDic[vo.id] = vo
    end
end

-- 解析整理背包道具配置
function parseOrganizeBackpacksItemConfigData(self)
    self.mPackBagItemDic = {}
    local baseData = RefMgr:getData("backpack_game_item_data")
    for key, data in pairs(baseData) do
        local vo = organizeBackpacks.OrganizeBackpacksItemVo.new()
        vo:parseConfigData(key, data)
        self.mPackBagItemDic[vo.id] = vo
    end
end

-- 解析整理背包具体关卡配置
function parseOrganizeBackpacksLevelInfoConData(self)
    self.mPackBagLevelInfoDic = {}
    local baseData = RefMgr:getData("backpack_game_level_data")
    for key, data in pairs(baseData) do
        local vo = organizeBackpacks.OrganizeBackpacksLevelVo.new()
        vo:parseConfigData(key, data)
        self.mPackBagLevelInfoDic[vo.id] = vo
    end
end

-- 解析整理背包关卡类型配置
function parseOrganizeBackpacksTypeConfigData(self)
    self.mPackBagTypeDic = {}
    local baseData = RefMgr:getData("backpack_game_data")
    for key, data in pairs(baseData) do
        local vo = organizeBackpacks.OrganizeBackpacksTypeVo.new()
        vo:parseConfigData(key, data)
        self.mPackBagTypeDic[vo.id] = vo
    end
end

--通过名字获取背包道具详情数据
function getLevelItemInfoByID(self, id)
    if table.nums(self.mPackBagItemDic) <= 0 then
        self:parseOrganizeBackpacksItemConfigData()
    end
    return self.mPackBagItemDic[id]
end
--获取背包详情列表数据
function getLevelInfoByID(self, id)
    if table.nums(self.mPackBagLevelInfoDic) <= 0 then
        self:parseOrganizeBackpacksLevelInfoConData()
    end
    return self.mPackBagLevelInfoDic[id]
end

function getTypeList(self)
    local list = {}
    if table.nums(self.mPackBagTypeDic) <= 0 then
        self:parseOrganizeBackpacksTypeConfigData()
    end
    for i, v in pairs(self.mPackBagTypeDic) do
        table.insert(list, v)
    end
    return list
end

function getTypeStageList(self, dupType)
    if table.nums(self.mPackBagTypeDic) <= 0 then
        self:parseOrganizeBackpacksTypeConfigData()
    end
    return self.mPackBagTypeDic[dupType]:getStageList()
end

function getStageVoById(self, stageId)
    if table.nums(self.mPackBagDupDic) <= 0 then
        self:parseOrganizeBackpacksConfigData()
    end
    return self.mPackBagDupDic[stageId]
end

function getStageTypeById(self, stageId)
    if table.nums(self.mPackBagTypeDic) <= 0 then
        self:parseOrganizeBackpacksTypeConfigData()
    end
    for type, typeVo in pairs(self.mPackBagTypeDic) do
        if table.indexof(typeVo:getStageList(), stageId) then
            return type
        end
    end
    return 1
end

function onUpdateLevelList(self, msg)
    for k, v in pairs(msg.dup_list) do
        if not table.indexof(self.mPassLevelList, v) then
            table.insert(self.mPassLevelList, v)
        end
    end
end

function getPassLevelList(self)
    return self.mPassLevelList or {}
end

function getRedState(self)
    if table.empty(self.mPackBagTypeDic) then
        self:parseOrganizeBackpacksTypeConfigData()
    end

    for _, typeVo in pairs(self.mPackBagTypeDic) do
        if self:getTypeRedState(typeVo:getId()) then
            return true
        end
    end
end

function getTypeRedState(self, type_id)
    local typeStageList = self:getTypeStageList(type_id)
    for _, stageId in pairs(typeStageList) do
        local stageVo = organizeBackpacks.OrganizeBackpacksManager:getStageVoById(stageId)
        if stageVo:getIsTimeOpen() and stageVo:getIsOpen() and not StorageUtil:getBool1(gstor.ORGANIZEBACKPACKS_DUPNEWOPENSTR .. stageId) then
            return true
        end
    end

    return false
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
