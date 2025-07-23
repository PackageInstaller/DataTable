--[[ 
-----------------------------------------------------
@filename       : MazeAbnormalConfigVo
@Description    : 迷宫异常环境配置数据
@date           : 2021-08-07 14:16:01
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('maze.MazeAbnormalConfigVo', Class.impl())

function parseData(self, cusId, cusData)
    self.id = cusId
    self.skillId = cusData.skill_id
    self.color = cusData.color
end

-- 技能描述
function getSkillVo(self)
    local skillVo = fight.SkillManager:getSkillRo(self.skillId)
    return skillVo
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
