--[[
    author:luqucheng
    time:2021-01-20 17:57:33
]]
local ChangeMergeSkillRecord = Class("ChangeMergeSkillRecord")

--@buff: [Game.Battle.Core.Buff#Buff]
function ChangeMergeSkillRecord:__init(mergeSkillId)
    self.id = mergeSkillId
    -- print('record add', table.toString(self:ToData()))
end

function ChangeMergeSkillRecord:ToData()
    return {
        r = Constants.RecordType.ChangeMergeSkillId,
        id = self.id,
    }
end


return  ChangeMergeSkillRecord