

module('mole.MoleItemDataVo', Class.impl())

function parseData(self, id, cusData)
    self.id = id
    self.type = cusData.type
    self.score = cusData.score
   
    self.icon = cusData.icon
    self.time = cusData.time
end

return _M