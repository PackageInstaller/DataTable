



module('bird.BirdEventListVo', Class.impl())

function parseData(self, id, cusData)
    self.id = id

    self.icon_list = cusData.icon_list 
end

return _M