--
-- Author:luqucheng
-- Date: 2019-11-08 16:01:58
--
local ActionRecord = Class("ActionRecord")

function  ActionRecord:__init(roles)
    self.data = {
        r = Constants.RecordType.Action,
    }
    for i,v in ipairs(roles) do
        self.data[v.id] = v.nowAction
    end
    
end

function ActionRecord:ToData(  )
    return self.data
end

return  ActionRecord