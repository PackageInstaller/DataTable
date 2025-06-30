--[[ 
-----------------------------------------------------
@filename       : DupImpliedMatrixVo
@Description    : 默示之境矩阵配置数据
@date           : 2021-07-07 14:16:01
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_implied.manager.vo.DupImpliedMatrixVo', Class.impl())


function parseData(self, cusId, cusData)
    self.id = cusId
    self.skillId = cusData.skill_id
    self.color = cusData.colour
    self.icon = cusData.icon

    self.improveEfficiency = cusData.combat_eff
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

--图标
function getIcon(self)
    local skillVo = fight.SkillManager:getSkillRo(self.skillId)
    return skillVo:getIcon()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
