--
-- Author:luqucheng
-- Date: 2019-11-08 12:00:09
--
local SkillFailedRecord = Class("SkillFailedRecord")


function  SkillFailedRecord:__init(attacker, skillCardId, star, isInputSkill)
    self.attacker = attacker
    self.skillCardId = skillCardId
    self.star = star
    self.isInputSkill = isInputSkill
end

function SkillFailedRecord:ToData()
    return {
        r = Constants.RecordType.SkillFailed,--战报类型
        a = self.attacker.id,--触发器类型
        s = self.skillCardId,
        ss = self.star,
        ip = self.isInputSkill
    }
end

return  SkillFailedRecord