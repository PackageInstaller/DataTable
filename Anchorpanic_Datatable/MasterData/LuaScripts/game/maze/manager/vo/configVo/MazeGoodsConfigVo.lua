--[[ 
-----------------------------------------------------
@filename       : MazeGoodsConfigVo
@Description    : 迷宫物质配置数据
@date           : 2021-08-07 14:16:01
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('maze.MazeGoodsConfigVo', Class.impl())


function parseData(self, cusId, cusData)
    self.id = cusId
    self.skillId = cusData.skill_id
    self.color = cusData.colour
    -- 作战效率
    self.efficiency = cusData.combat_eff
end

-- 技能名
function getName(self)
    local skillVo = fight.SkillManager:getSkillRo(self.skillId)
    return skillVo:getName()
end

-- 技能描述
function getDes(self)
    local skillVo = fight.SkillManager:getSkillRo(self.skillId)
    return skillVo:getDesc()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
