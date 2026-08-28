--[[
    author:luqucheng
    time:2021-02-01 17:41:17
]]
local RoleDeadRecord = {}
RoleDeadRecord = Class("RoleDeadRecord")

function RoleDeadRecord:__init(roleId)
    self.roleId = roleId
end


function RoleDeadRecord:ToData()
    return 
    {
        r = Constants.RecordType.RoleDead,
        id = self.roleId,
    }
end

return  RoleDeadRecord