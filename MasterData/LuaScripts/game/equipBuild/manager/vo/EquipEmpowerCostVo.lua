module("equipBuild.EquipEmpowerCostVo", Class.impl())

function parseData(self,id,cusData)
    self.id = id
    self.cost = cusData.cost
    self.coinCost = cusData.coin_cost
end

function getCost(self)
    local cost = {}
    for i = 1, #self.cost do
        table.insert(cost, {tid = self.cost[i][1], num = self.cost[i][2]})
    end
    for i = 1, #self.coinCost do
        table.insert(cost, {tid = self.coinCost[i][1], num = self.coinCost[i][2]})
    end
    return cost
end

return _M