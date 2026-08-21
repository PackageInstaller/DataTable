

module('bulle.BulleItemDataVo', Class.impl())

function parseData(self, id, cusData)
    self.id = id
    self.icon = cusData.icon
    self.size = cusData.size
   
    self.score = cusData.score
end

return _M