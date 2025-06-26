--[[ 
    芯片副本
    @author Jacob
]]
module('dup.DupEquipLowManager', Class.impl(dup.DupEquipBaseManager))


--打开芯片副本
OPEN_EQUIP_DUP = "OPEN_EQUIP_DUP"

function ctor(self)
    super.ctor(self)
    self:setDupType(DupType.DUP_EQUIP_LOW, PreFightBattleType.DupEquip_Low)
end

function getViewName(self)
    return dup.DupEquipLowPanel
end

function getBattleType(self, cusDupType)
    return PreFightBattleType.DupEquip_LOW
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
