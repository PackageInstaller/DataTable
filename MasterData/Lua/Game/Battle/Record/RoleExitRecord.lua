--[[
    author:luqucheng
    time:2021-02-01 17:41:17
]]
local RoleExitRecord = {}
RoleExitRecord = Class("RoleExitRecord")

function RoleExitRecord:__init(roleId)
    self.roleId = roleId
end


function RoleExitRecord:ToData()
    return 
    {
        r = Constants.RecordType.RoleExit,
        id = self.roleId,
    }
end

return  RoleExitRecord