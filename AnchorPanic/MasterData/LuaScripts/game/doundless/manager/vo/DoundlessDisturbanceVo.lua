
module('doundless.DoundlessDisturbanceVo', Class.impl())

function parseData(self,id,cusData)
    self.id = id 

    self.radio = cusData.radio
    self.des = cusData.des
end

return _M