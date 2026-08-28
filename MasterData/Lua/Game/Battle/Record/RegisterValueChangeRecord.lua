--
-- Author:luqucheng
-- Date: 2019-11-08 16:01:58
--
local RegisterValueChangeRecord = Class("RegisterValueChangeRecord")

--@roles: [Game.Battle.Entity.Role#Role<>]
function  RegisterValueChangeRecord:__init(roleId, value)
    self.roleId = roleId
    self.value = value
end

function RegisterValueChangeRecord:ToData(  )
    return {
        r = Constants.RecordType.RegisterValueChange,
        rId = self.roleId,
        v = self.value
    }
end

return  RegisterValueChangeRecord