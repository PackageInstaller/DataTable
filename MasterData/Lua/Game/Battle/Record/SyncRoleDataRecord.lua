--
-- Author:luqucheng
-- Date: 2019-11-08 16:01:58
--
local SyncRoleDataRecord = Class("SyncRoleDataRecord")

--@roles: [Game.Battle.Entity.Role#Role<>]
function  SyncRoleDataRecord:__init(roles)
    self.roles = roles
end

function SyncRoleDataRecord:ToData(  )
    local ds = {}
    for i,role in ipairs(self.roles) do
        if not role:IsDead() then
            local vs = {}
            for k,v in pairs(role.attr.values) do
                if v and v ~= 0 then
                    vs[k] = v
                end
            end
            local data = {
                id = role.id,
                values = vs
            }
            table.insert(ds, data)
        end
    end
    return {
        r = Constants.RecordType.SyncRole,
        datas = ds
    }
end

return  SyncRoleDataRecord