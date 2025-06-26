module("equip.EquipManager", Class.impl(Manager))

-- 更新装备详细信息
UPDATE_EQUIP_DETAIL_DATA = "UPDATE_EQUIP_DETAIL_DATA"

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
    self.m_equipTidDic = nil
    self.m_equipSuitIdDic = nil
end

-- 解析装备配置表
function parseConfig(self)
    self.m_equipTidDic = {}
    self.m_equipSuitIdDic = {}
    local baseData = RefMgr:getData("equip_data")
    for tid, data in pairs(baseData) do
        local vo = equip.EquipConfigVo.new()
        vo:parseConfigData(tid, data)
        if (not self.m_equipTidDic[tid]) then
            self.m_equipTidDic[tid] = {}
        end
        self.m_equipTidDic[tid] = vo

        -- 按照套装id->装备tid->装备配置vo结构存储
        if (not self.m_equipSuitIdDic[vo.suitId]) then
            self.m_equipSuitIdDic[vo.suitId] = {}
        end
        self.m_equipSuitIdDic[vo.suitId][vo.tid] = vo
    end
end

function getAllEquipConfigVo(self)
    if(not self.m_equipTidDic)then
        self:parseConfig()
    end
    return self.m_equipTidDic
end

-- 根据装备tid获取装备配置
function getEquipConfigVo(self, cusTid)
    return self:getAllEquipConfigVo()[cusTid]
end

-- 根据装备tid获取所属的套装id
function getSuitIdByEquipTid(self, cusTid)
    local vo = self:getEquipConfigVo(cusTid)
    return vo and vo.suitId or -1
end

-- 获取套装字典
function getEquipSuitIdDic(self)
    if(not self.m_equipSuitIdDic)then
        self:parseConfig()
    end
    return self.m_equipSuitIdDic
end

-- 根据装备套装id获取可以组成套装的装备字典
function getSuitEquipDic(self, cusSuitId)
    return self:getEquipSuitIdDic()[cusSuitId]
end

--析构函数
function dtor(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
