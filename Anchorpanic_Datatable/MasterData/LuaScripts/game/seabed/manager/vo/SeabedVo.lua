module("seabed.SeabedVo", Class.impl())

function parseData(self,id,data)
    self.id = id    
    self.layerId = data.layer_id
    self.difficulty = data.difficulty
    self.lines = data.lines
end

return _M