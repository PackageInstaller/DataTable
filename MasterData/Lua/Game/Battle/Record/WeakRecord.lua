--
-- Author:luqucheng
-- Date: 2019-11-08 16:01:58
--
local WeakRecord = Class("WeakRecord")

function  WeakRecord:__init(roleId, round)
    self.recordType = Constants.RecordType.Weak
    self.roleId = roleId
    self.weakCount = Core:FindRole(roleId).weakCount
    self.round = round
end

function WeakRecord:ToData(  )
    return {
        r = Constants.RecordType.Weak,
        id = self.roleId,
        ro = self.round,
        wc = self.weakCount,
    }
end

return  WeakRecord