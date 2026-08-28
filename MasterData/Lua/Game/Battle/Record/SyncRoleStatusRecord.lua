--
-- Author:luqucheng
-- Date: 2019-11-08 16:01:58
--
local SyncRoleStatusRecord = Class("SyncRoleStatusRecord")

--@roles: [Game.Battle.Entity.Role#Role<>]
function  SyncRoleStatusRecord:__init(roleId, statusAbility)
    self.roleId = roleId
    self.statusAbility = statusAbility
end

function SyncRoleStatusRecord:ToData(  )
    return {
        r = Constants.RecordType.SyncStatus,
        id = self.roleId,
        status = DeepCopy(self.statusAbility)
    }
end

return  SyncRoleStatusRecord