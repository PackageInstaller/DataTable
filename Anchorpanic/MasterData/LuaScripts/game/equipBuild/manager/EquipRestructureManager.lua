module("equipBuild.EquipRestructureManager", Class.impl(Manager))

-- 装备重构材料选择
EQUIP_RESTRUCTURE_MATERIAL_SELECT = "EQUIP_RESTRUCTURE_MATERIAL_SELECT"

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
    self.m_equipRestructureDic = nil
end

function __parseConfigData(self)
    self.m_equipRestructureDic = {}
    local baseData = RefMgr:getData('equip_reconstruct_data')
    for key, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(equipBuild.EquipReconstructVo)
        ro:parseData(key, data)
        self.m_equipRestructureDic[key] = ro
    end
end

-- 获取装备重构配置vo
function getRestructureVo(self, cusEquipTid)
    if(not self.m_equipRestructureDic)then
        self:__parseConfigData()
    end
    return self.m_equipRestructureDic[cusEquipTid]
end

-- 是否可重构
function isEquipCanRestructure(self, equipTid)
    return self:getRestructureVo(equipTid) ~= nil
end

--析构函数
function dtor(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
