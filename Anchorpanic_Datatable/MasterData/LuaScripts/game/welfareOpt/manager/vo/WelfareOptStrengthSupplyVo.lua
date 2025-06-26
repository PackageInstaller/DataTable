module("WelfareOptStrengthSupplyVo", Class.impl())


function parseWelfareOptStrengthSupplyData(self, cusData)
    self.beginHour = cusData.begin_hour
    self.endHour = cusData.end_hour
    self.dropId = cusData.drop_id
end

function getAwardList(self)
    return AwardPackManager:getAwardListById(self.dropId)
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]