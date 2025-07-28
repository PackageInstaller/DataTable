module("seabed.SeabedTeaserVo", Class.impl())

function parseData(self,id,data)
    --难度
    self.id = id 
    --难题描述
    self.des = data.des
end

return _M