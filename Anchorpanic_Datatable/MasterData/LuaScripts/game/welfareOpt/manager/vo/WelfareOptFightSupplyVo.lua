module("WelfareOptFightSupplyVo",Class.impl())

function pareseFightSupplyVo(self,cusData)
    --道具id
    self.costOneId = cusData.cost_one_id
    --道具数量
    self.costOneNum = cusData.cost_one_num

    self.costTenId = cusData.cost_ten_id
    self.costTenNum = cusData.cost_ten_num
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
