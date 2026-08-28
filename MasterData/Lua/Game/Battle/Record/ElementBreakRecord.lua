--
-- Author:luqucheng
-- Date: 2019-11-08 16:01:58
--
local ElementBreakRecord = Class("ElementBreakRecord")

function  ElementBreakRecord:__init(roleId, remainStars)
    self.recordType = Constants.RecordType.ElementBreak
    self.roleId = roleId
    self.remainStars = remainStars
end

function ElementBreakRecord:ToData(  )
    return {
        r = Constants.RecordType.ElementBreak,
        id = self.roleId,
        re = self.remainStars,
    }
end

return  ElementBreakRecord