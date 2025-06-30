--[[ 
    芯片副本
    @author Jacob
]]
module('dup.DupEquipHighManager', Class.impl(dup.DupEquipBaseManager))


--打开芯片副本
OPEN_EQUIP_DUP = "OPEN_EQUIP_DUP"

function ctor(self)
    super.ctor(self)
    self:setDupType(DupType.DUP_EQUIP_HIGH, PreFightBattleType.DupEquip_High)
end

function getViewName(self)
    return dup.DupEquipHighPanel
end

function getBattleType(self, cusDupType)
    return PreFightBattleType.DupEquip_High
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
