-- @FileName:   RoundPrizeProbabilityConfigVo.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-12-23 14:20:54
-- @Copyright:   (LY) 2024 锚点降临

module('game.roundPrize.manager.vo.RoundPrizeProbabilityConfigVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key
    self.cost_one_id = cusData.cost_one_id
    self.cost_one_num = cusData.cost_one_num
    self.cost_ten_id = cusData.cost_ten_id
    self.cost_ten_num = cusData.cost_ten_num
    self.minimum_item = cusData.minimum_item
    -- self.des = cusData.des
    self.probabilityList = {}
    for index, desc in pairs(cusData.des) do
        self.probabilityList[index] = {tid = desc.item_id, count = desc.num, probability = desc.pr * 0.001}
    end

    self.rule = cusData.rule
end

function getProbabilityList(self)
    return self.probabilityList
end

return _M
