module("seabed.SeabedPointVo", Class.impl())

function parseData(self,id,data)
    self.id = id
    self.score = data.score
    self.des = data.des
end

return _M