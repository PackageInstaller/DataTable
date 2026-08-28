--
-- Author:luqucheng
--
local ChangeElementRecord = Class("ChangeElementRecord")

function  ChangeElementRecord:__init(roleId, element)
    self.roleId = roleId
    self.element = element
end

function ChangeElementRecord:ToData(  )
    return {
        r = Constants.RecordType.ChangeElement,
        ri = self.roleId,
        el = self.element
    }
end

return  ChangeElementRecord