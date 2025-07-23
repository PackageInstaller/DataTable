--[[ 
    芯片突破副本
    @author Jacob
]]
module('dup.DupEquipTupoManager', Class.impl(dup.DupDailyBaseManager))

function ctor(self)
    super.ctor(self)

    self:setDupType(DupType.DUP_EQUIP_TUPO, PreFightBattleType.DupEquipTupo)
end

function getViewName(self)
    return dup.DupEquipTupoPanel
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
