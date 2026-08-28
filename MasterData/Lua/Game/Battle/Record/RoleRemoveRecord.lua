--[[
    author:pikaqiu
]]
local RoleRemoveRecord = {}
RoleRemoveRecord = Class("RoleRemoveRecord")

function RoleRemoveRecord:__init(roleId)
    self.roleId = roleId
end


function RoleRemoveRecord:ToData()
    return 
    {
        r = Constants.RecordType.RoleRemove,
        id = self.roleId,
    }
end

return  RoleRemoveRecord