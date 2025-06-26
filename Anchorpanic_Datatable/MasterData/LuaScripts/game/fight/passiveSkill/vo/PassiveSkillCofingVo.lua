--[[ 
-----------------------------------------------------
@filename       : PassiveSkillCofingVo
@Description    : 被动技能演出配置
@date           : 2022-11-05 19:39:53
@Author         : Jacob
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("fight.PassiveSkillCofingVo", Class.impl())

function parseData(self, cusSkillId, cusData)
    self.skillId = cusSkillId
    self.skillEff = cusData.skill_eff
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]