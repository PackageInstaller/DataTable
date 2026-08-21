
module('doundless.DoundlessCityTargetVo', Class.impl())

function parseData(self,id,cusData)
    self.id = id
    --分数
    self.point = cusData.point
    --描述
    self.des = cusData.des 
end

return _M