module('watermelon.WatermelonTaskDataVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key 
    self.type = cusData.type
    self.subType = cusData.sub_type
    self.reward = cusData.reward
    self.des = cusData.des
end

return _M