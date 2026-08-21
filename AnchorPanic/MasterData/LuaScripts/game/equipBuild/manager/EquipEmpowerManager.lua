module("equipBuild.EquipEmpowerManager", Class.impl(Manager))

-- 构造函数
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
end

function updateEquipEmpowerLockInfo(self, msg)
    self.selectEquipVo = equipBuild.EquipStrengthenManager:getOpenEquipVo()
    if self.selectEquipVo.id == msg.equip_id then
        self.selectEquipVo:updateEmpowerLockInfo(msg.pos, msg.is_lock)
        if msg.is_lock == 1 then
            gs.Message.Show(_TT(71474))
        else
            gs.Message.Show(_TT(71475))
        end
        GameDispatcher:dispatchEvent(EventName.UPDATE_EQUIP_EMPOWER_LOCK)
        GameDispatcher:dispatchEvent(EventName.CLOSE_EQUIP_EMPOWER_LOCK_SURE_PANEL)
    end
end

function equipEmpowerPrepareInfo(self, msg)
    self.selectEquipVo = equipBuild.EquipStrengthenManager:getOpenEquipVo()
    if self.selectEquipVo.id == msg.equip_id then

        table.sort(msg.new_attr, function(a, b)
            return a.pos < b.pos
        end)
        self.tempAttr = msg.new_attr
        GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_EMPOWER_PREPARE_PANEL, {
            equipId = msg.equip_id,
            newAttr = msg.new_attr
        })
    end

end

function equipEmpowerResultInfo(self, msg)
    if msg.is_save == 1 then

    else

    end
    GameDispatcher:dispatchEvent(EventName.CLOSE_EQUIP_EMPOWER_PREPARE_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_EQUIP_EMPOWER_INFO)
end

function oldEmpowerUnconfirm(self, msg)
    self.selectEquipVo = equipBuild.EquipStrengthenManager:getOpenEquipVo()
    if self.selectEquipVo.id == msg.equip_id and #msg.new_attr > 0 then
        table.sort(msg.new_attr, function(a, b)
            return a.pos < b.pos
        end)
        self.tempAttr = msg.new_attr
        GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_EMPOWER_PREPARE_PANEL, {
            equipId = msg.equip_id,
            newAttr = msg.new_attr
        })
    end
end

function parseEmpowerTipsInfo(self)
    self.mTipsInfo = {}
    local baseData = RefMgr:getData('chip_refactor_show_data')
    for key, table in pairs(baseData) do
        self.mTipsInfo[key] = table.value
    end
end

function getEmpowerTipsInfo(self)
    if self.mTipsInfo == nil then
        self:parseEmpowerTipsInfo()
    end
    return self.mTipsInfo
end

function parseEmpowerCostInfo(self)
    self.mCostInfo = {}
    local baseData = RefMgr:getData('chip_refactor_cost_data')
    for key, value in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(equipBuild.EquipEmpowerCostVo)
        vo:parseData(key, value)
        self.mCostInfo[key] = vo
    end
end

function getEmpowerCostInfo(self, type)
    if self.mCostInfo == nil then
        self:parseEmpowerCostInfo()
    end
    return self.mCostInfo[type]
end

return _M
