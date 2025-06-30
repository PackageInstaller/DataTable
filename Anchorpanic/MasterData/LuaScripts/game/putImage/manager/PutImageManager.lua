-- @FileName:   PutImageManager.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-28 15:28:41
-- @Copyright:   (LY) 2023 雷焰网络

module('game.putImage.manager.PutImageManager', Class.impl(Manager))

--构造
function ctor(self)
    super.ctor(self)
    self:init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:init()
end

--初始化
function init(self)
    self.m_passStageDic = {}

end
-------------------------------------------------数据-------------------------
function setPassStage(self, dup_id)
    self.m_passStageDic[dup_id] = true
end

function isPassDup(self, dupId)
    if dupId == 0 then 
        return true
    end
    return self.m_passStageDic[dupId] or false
end

function isPassArea(self, area_id)
    local areaConfig = self:getAreaConfig(area_id)
    for _, dup_id in pairs(areaConfig.stage_list) do
        if not self:isPassDup(dup_id) then
            return false
        end
    end

    return true
end

-------------------------------------------------配置-------------------------
function parseAreaConfigVo(self)
    if not self.m_areaConfigVoDic then
        self.m_areaConfigVoDic = {}
        local baseData = RefMgr:getData("jigsaw_puzzle_area_data")
        for key, data in pairs(baseData) do
            local baseVo = putImage.PutImageAreaConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.m_areaConfigVoDic[key] = baseVo
        end
    end
end

function getAreaConfigDic(self)
    if not self.m_areaConfigVoDic then
        self:parseAreaConfigVo()
    end

    return self.m_areaConfigVoDic
end

function getAreaConfig(self, area_id)
    if not self.m_areaConfigVoDic then
        self:parseAreaConfigVo()
    end

    return self.m_areaConfigVoDic[area_id]
end

--获取区域id根据副本id
function getAreaIdByDupId(self, dupId)
    local allAreaCofig = self:getAreaConfigDic()
    for areaId, areaConfigVo in pairs(allAreaCofig) do
        for _, dup_id in pairs(areaConfigVo.stage_list) do
            if dupId == dup_id then
                return areaId
            end
        end
    end

    return 1
end

function parseDupConfigVo(self)
    self.m_dupConfigVoDic = {}
    local baseData = RefMgr:getData("jigsaw_puzzle_data")
    for key, data in pairs(baseData) do
        local baseVo = putImage.PutImageDupConfigVo.new()
        baseVo:parseCogfigData(key, data)
        self.m_dupConfigVoDic[key] = baseVo
    end
end

function getDupConfigVo(self, dupId)
    if not self.m_dupConfigVoDic then
        self:parseDupConfigVo()
    end

    return self.m_dupConfigVoDic[dupId]
end

--获取下一个关卡
function getNextDupConfig(self, dupId)
    local isBreak = false
    local dupConfigList = self:getDupConfigVoList()
    for index, dupConfigVo in pairs(dupConfigList) do
        if dupConfigVo.id == dupId then
            if dupConfigList[index + 1] then
                return dupConfigList[index + 1]
            end
        end
    end
end


function getDupConfigVoList(self)
    if not self.m_dupConfigVoDic then
        self:parseDupConfigVo()
    end

    local dupList = {}
    for dup_id, dupConfig in pairs(self.m_dupConfigVoDic) do
        table.insert(dupList, dupConfig)
    end

    table.sort(dupList, function (a, b)
        return a.id < b.id
    end)

    return dupList
end

---------------------------
function getIsShowRed(self)
    if self:isShowAreaRed() ~= 0 then
        return true
    end

    return false
end


function isShowAreaRed(self)
    local areaConfig = self:getAreaConfigDic()
    for areaId, areaConfigVo in pairs(areaConfig) do
        for _,dup_id in pairs(areaConfigVo.stage_list) do
            local dupConfigVo = self:getDupConfigVo(dup_id)
            if self:getDupShowRed(dupConfigVo) then 
                return areaId
            end
        end
    end
    return 0
end

function getDupShowRed(self, dupConfigVo)
    local lastDup_id = dupConfigVo.pre_id
    if self:isPassDup(lastDup_id) and not self:isPassDup(dupConfigVo.id) and dupConfigVo:isOpen() and not StorageUtil:getBool1(gstor.PUTIMAGE_DUPNEWOPENSTR .. dupConfigVo.id) then
        return true
    end

    return false
end

return _M
