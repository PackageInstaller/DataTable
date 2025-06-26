
module("formation.FormationAssistConfigVo", Class.impl())

function parseData(self, pos, cusData)
    -- 助战位置
    self.pos = pos
    -- 需要的玩家等级
    self.needPlayerLvl = cusData.need_level
end

-- 是否解锁了
function isUnLock(self)
    local playerLvl = role.RoleManager:getRoleVo():getPlayerLvl()
    return playerLvl >= self.needPlayerLvl
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
