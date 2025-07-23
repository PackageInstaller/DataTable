--[[ 
-----------------------------------------------------
@filename       : InfiniteCityDisasterVo
@Description    : 无限城灾害配置数据
@date           : 2021-03-04 15:32:45
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.infiniteCity.manager.vo.InfiniteCityDisasterVo', Class.impl())


function parseData(self, cusId, cusData)
    self.id = cusId
    self.skillId = cusData.skill_id
    self.lvl = cusData.level
    self.type = cusData.type
    self.scoreList = cusData.score
    self.icon = cusData.icon
end

-- 获取对应难度评分
function getScore(self, cusDeff)
    return self.scoreList[cusDeff]
end


-- 技能名
function getName(self)
    local skillVo = fight.SkillManager:getSkillRo(self.skillId)
    return skillVo:getName()
end


-- 灾害描述
function getDes(self)
    local skillVo = fight.SkillManager:getSkillRo(self.skillId)
    return skillVo:getDesc()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
