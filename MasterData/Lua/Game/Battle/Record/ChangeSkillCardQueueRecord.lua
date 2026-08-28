--
-- Author:luqucheng
-- Date: 2019-11-27 19:45:42
--
local ChangeSkillCardQueueRecord = Class("ChangeSkillCardQueueRecord")

function  ChangeSkillCardQueueRecord:__init(index, data, camp)
    self.index = index
    self.data = DeepCopy(data)
    self.camp = camp
end

function ChangeSkillCardQueueRecord:ToData(  )
    return {
        r = Constants.RecordType.ChangeQueueCard,
        index = self.index,
        skillIndex = self.data.skillIndex,
        targetId = self.data.targetId,
        star = self.data.star,
        roleId = self.data.roleId,
        params = self.data.params,
        c = self.camp
    }
end

return  ChangeSkillCardQueueRecord