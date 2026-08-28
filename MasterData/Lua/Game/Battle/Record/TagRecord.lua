--
-- Author:luqucheng
-- Date: 2019-11-08 16:01:58
--
local TagRecord = Class("TagRecord")

function  TagRecord:__init(tag, p1, p2)
    self.recordType = tag
    self.p1 = p1
    self.p2 = p2
end

function TagRecord:ToData(  )
    return {
        r = self.recordType,
        p1 = self.p1,
        p2 = self.p2,
    }
end

return  TagRecord