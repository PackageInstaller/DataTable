--
-- Author:luqucheng
-- Date: 2019-11-08 09:46:40
--
local UltraPointChangeRecord = Class("UltraPointChangeRecord")

--@role: [Game.Battle.Entity.Role#Role]
function  UltraPointChangeRecord:__init( role , type)
    self.roleId = role.id
    self.nowPoint = role:GetUltraPoint()
    self.type = type
end

function UltraPointChangeRecord:ToData()
    return {
        r = Constants.RecordType.UltraPointChange,--战报类型
        ri = self.roleId,
        p = self.nowPoint,
        t = self.type,  -- 加点的来源类型
    }
end

return  UltraPointChangeRecord