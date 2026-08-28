--
-- Author:luqucheng
-- Date: 2019-11-08 16:01:58
--
local WeakExposeRecord = Class("WeakExposeRecord")

function  WeakExposeRecord:__init(roleId, stars)
    self.recordType = Constants.RecordType.WeakExpose
    self.roleId = roleId
    self.weakCount = Core:FindRole(roleId).weakCount
    self.elements = stars
end

function WeakExposeRecord:ToData(  )
    return {
        r = Constants.RecordType.WeakExpose,
        id = self.roleId,
        el = self.stars,
        wc = self.weakCount,
    }
end

return  WeakExposeRecord