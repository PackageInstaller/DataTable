--[[ 
-----------------------------------------------------
@filename       : DupCodeHopeHeroVo
@Description    : 代号·希望副本战员信息
@date           : 2021-05-17 14:13:15
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dupCodeHope.manager.vo.DupCodeHopeHeroVo', Class.impl())

function parseMsg(self, cusMsg)
    -- 唯一id
    self.heroId = cusMsg.hero_id
    -- 已消耗耐力
    self.costStamina = cusMsg.had_cost_stamina
end

-- 战员最大和剩余可用耐力
function getHeroStamina(self)
    local maxCount = sysParam.SysParamManager:getValue(SysParamType.CODE_HOPE_HERO_MAX_STAMINA)
    local remaidCount = math.max(0, maxCount - self.costStamina)
    return remaidCount, maxCount
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
