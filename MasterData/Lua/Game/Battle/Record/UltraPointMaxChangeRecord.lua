--
-- Author:luqucheng
-- Date: 2019-11-08 09:46:40
--
local UltraPointMaxChangeRecord = Class("UltraPointMaxChangeRecord")

--@role: [Game.Battle.Entity.Role#Role]
function  UltraPointMaxChangeRecord:__init( role , from, to)
    self.roleId = role.id
    self.from = from
    self.to = to
end

function UltraPointMaxChangeRecord:ToData()
    return {
        r = Constants.RecordType.UltraPointMaxChange,--战报类型
        ri = self.roleId,
        f = self.from,
        t = self.to,
    }
end

return  UltraPointMaxChangeRecord