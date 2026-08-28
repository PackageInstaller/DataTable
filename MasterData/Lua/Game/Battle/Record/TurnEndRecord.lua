--
-- Author:luqucheng
-- Date: 2019-11-09 14:13:01
--
local TurnEndRecord = Class("TurnEndRecord")

function  TurnEndRecord:__init(camp)
    self.camp = camp
    
end

function TurnEndRecord:ToData(  )
    return {
        r = Constants.RecordType.TurnEnd,
        c = self.camp
    }
end

return  TurnEndRecord