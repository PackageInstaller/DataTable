--
-- Author:luqucheng
-- Date: 2019-11-08 09:46:40
--
local AIChooseSkillRecord = Class("AIChooseSkillRecord")

--@buff: [Game.Battle.Core.Buff#Buff]
function  AIChooseSkillRecord:__init(skills)
    self.skills = skills
end

function AIChooseSkillRecord:ToData()
    return {
        r = Constants.RecordType.AIChooseSkill,--战报类型
        ss = table.link({}, self.skills)
    }
end

return  AIChooseSkillRecord