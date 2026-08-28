--
-- Author:luqucheng
-- Date: 2019-11-09 14:12:51
--
local TurnStartRecord = Class("TurnStartRecord")

function  TurnStartRecord:__init(camp)
    self.camp = camp
end

function TurnStartRecord:ToData(  )
    return {
        r = Constants.RecordType.TurnStart,
        c = self.camp,
    }
end

return  TurnStartRecord