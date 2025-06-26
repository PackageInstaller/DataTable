module("equip.EquipSuitManager", Class.impl(Manager))

-- 默认所有套装的id
All_SUIT_EQUIP_ID = -1

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
    self.m_equipSuitDic = nil
    self.m_equipSuitList = nil
end

-- 解析装备套装配置表
function parseEquipSuitConfig(self)
    self.m_equipSuitDic = {}
    self.m_equipSuitList = {}
    local baseData = RefMgr:getData("equip_suit_data")
    for suitId, data in pairs(baseData) do
        local vo = equip.EquipSuitConfigVo.new()
        vo:parseConfigData(suitId, data)
        if (not self.m_equipSuitDic[suitId]) then
            self.m_equipSuitDic[suitId] = {}
        end
        self.m_equipSuitDic[suitId] = vo
        table.insert(self.m_equipSuitList, vo)
    end
end

-- 获取套装配置
function getEquipSuitConfigVo(self, suitId)
    if (not self.m_equipSuitDic) then
        self:parseEquipSuitConfig()
    end
    return self.m_equipSuitDic[suitId]
end

-- 获取套装配置列表
function getSuitConfigList(self)
    if (not self.m_equipSuitList) then
        self:parseEquipSuitConfig()
    end
    return self.m_equipSuitList
end

-- 根据指定格式获取所有的套装列表
function getFormatSuitConfigList(self, slotPos, heroWear)
    local suitConfigList = {}
    local equipList = bag.BagManager:getPropsListByType(PropsType.EQUIP)
    for i = 1, #equipList do
        if slotPos == nil or slotPos == equipList[i].subType then
            local equipConfigVo = equip.EquipManager:getEquipConfigVo(equipList[i].tid)
            local isHad = false
            for j = 1, #suitConfigList do
                if (equipConfigVo) then
                    if (suitConfigList[j].suitId == equipConfigVo.suitId) then
                        isHad = true
                        break
                    end
                else
                    Debug:log_error('HeroEquipSuitPanel', '战员芯片配置表找不到tid：' .. equipList[i].tid)
                end
            end
            if (not isHad) then
                if (equipConfigVo) then
                    local suitConfigVo = self:getEquipSuitConfigVo(equipConfigVo.suitId)
                    table.insert(suitConfigList, suitConfigVo)
                end
            end
        end
    end

    if heroWear then
        local heroDic = hero.HeroManager:getHeroDic()
        for heroId, heroVo in pairs(heroDic) do
            if (heroVo.equipList) then
                for i, equipVo in pairs(heroVo.equipList) do
                    local equipConfigVo = equip.EquipManager:getEquipConfigVo(equipVo.tid)
                    if not slotPos or equipVo.subType == slotPos then
                        local isHad = false
                        for j = 1, #suitConfigList do
                            if (suitConfigList[j].suitId == equipConfigVo.suitId) then
                                isHad = true
                                break
                            end
                        end
                        if (not isHad) then
                            if (equipConfigVo) then
                                local suitConfigVo = self:getEquipSuitConfigVo(equipConfigVo.suitId)
                                table.insert(suitConfigList, suitConfigVo)
                            end
                        else
                        end
                    end
                end
            end
        end
    end

    if #suitConfigList > 1 then
        local suitSort = function(a, b)
            if (a.suitId ~= b.suitId) then
                return a.suitId < b.suitId
            end
            return false
        end
        table.sort(suitConfigList, suitSort)
    end

    local allSuitConfigList = self:getSuitConfigList()
    for i = 1, #allSuitConfigList do
        local isHas = false
        for j = 1, #suitConfigList do
            if (suitConfigList[j].suitId == allSuitConfigList[i].suitId) then
                isHas = true
                break
            end
        end
        if (not isHas) then
            table.insert(suitConfigList, allSuitConfigList[i])
        end
    end

    return suitConfigList
end

-- 根据是有包含已有装备获取所有的套装列表
function getHasSuitConfigList(self, isAddAllId, slotPos)
    local suitConfigList = {}
    local equipList = bag.BagManager:getPropsListByType(PropsType.EQUIP)
    for i = 1, #equipList do
        if slotPos == nil or slotPos == equipList[i].subType then
            local equipConfigVo = equip.EquipManager:getEquipConfigVo(equipList[i].tid)
            local isHad = false
            for j = 1, #suitConfigList do
                if (equipConfigVo) then
                    if (suitConfigList[j].suitId == equipConfigVo.suitId) then
                        isHad = true
                        break
                    end
                else
                    Debug:log_error('HeroEquipSuitPanel', '战员芯片配置表找不到tid：' .. equipList[i].tid)
                end
            end
            if (not isHad) then
                if (equipConfigVo) then
                    local suitConfigVo = self:getEquipSuitConfigVo(equipConfigVo.suitId)
                    table.insert(suitConfigList, suitConfigVo)
                end
            end
        end
    end

    if #suitConfigList > 1 then
        local suitSort = function(a, b)
            return a.suitId < b.suitId
        end
        table.sort(suitConfigList, suitSort)
    end

    if ((isAddAllId == nil or isAddAllId == true) and #suitConfigList > 0) then
        -- 手动设置一个全部的选项
        local suitConfigVo = equip.EquipSuitConfigVo.new()
        suitConfigVo.suitId = equip.EquipSuitManager.All_SUIT_EQUIP_ID
        suitConfigVo.name = nil
        suitConfigVo.effectDes = nil
        suitConfigVo.suitSkillId_2 = nil
        suitConfigVo.suitSkillId_4 = nil

        table.insert(suitConfigList, 1, suitConfigVo)
    end
    return suitConfigList
end

--析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]