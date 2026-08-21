



module('mole.MoleEventListVo', Class.impl())

function parseData(self, id, cusData)
    self.id = id

    self.pos = cusData.pos
    self.moleId = cusData.mole_id
    self.timePoint = cusData.time_point
end

return _M