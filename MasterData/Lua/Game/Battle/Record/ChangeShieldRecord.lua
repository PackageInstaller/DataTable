--
-- Author:luqucheng
-- Date: 2019-11-07 17:36:20
--
local ChangeShieldRecord = Class("ChangeShieldRecord")

--@buff: [Game.Battle.Core.Buff#Buff]
function ChangeShieldRecord:__init(roleId, shieldValue, shieldValueMax)
    self.id = roleId
    self.shieldValue = shieldValue
    self.shieldValueMax = shieldValueMax
    -- print('record add', table.toString(self:ToData()))
end

function ChangeShieldRecord:ToData()
    return {
        r = Constants.RecordType.ShieldChange,
        id = self.id,
        sv = self.shieldValue,
        svm = self.shieldValueMax,
    }
end


return  ChangeShieldRecord