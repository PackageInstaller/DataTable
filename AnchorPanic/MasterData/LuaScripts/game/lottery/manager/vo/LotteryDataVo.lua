module('lottery.LotteryDataVo', Class.impl())

function parseData(self, id, cusData)
    self.id = id 

    self.costOneId = cusData.cost_one_id
    self.costOneNum = cusData.cost_one_num
    self.numWeight = cusData.num_weight
    self.des = cusData.des
    self.rule = cusData.rule
end

function getDesPropsItemId(self,id)
    return self.des[id].item_id
end

function getDesPropsItemNum(self,id)
    return self.des[id].num
end



return _M