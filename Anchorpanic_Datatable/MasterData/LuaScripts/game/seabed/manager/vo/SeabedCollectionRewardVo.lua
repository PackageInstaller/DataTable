module("seabed.SeabedCollectionRewardVo", Class.impl())

function parseData(self,id,data)
    self.id = id 
    self.type = data.type
    self.num = data.num
    self.reward = data.reward
end

return _M