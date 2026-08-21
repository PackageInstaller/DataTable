



module('dessert.DessertEventListVo', Class.impl())

function parseData(self, id, cusData)
    self.id = id

    self.iconList = cusData.icon_list 
end

return _M