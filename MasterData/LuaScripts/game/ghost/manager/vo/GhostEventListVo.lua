



module('ghost.GhostEventListVo', Class.impl())

function parseData(self, id, cusData)
    self.id = id

    self.iconId = cusData.icon_id 
end

return _M