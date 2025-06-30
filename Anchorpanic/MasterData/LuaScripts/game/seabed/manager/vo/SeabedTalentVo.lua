module("seabed.SeabedTalentVo", Class.impl())

function parseData(self,id,data)
    self.id = id
    self.preId = data.pre_id
    self.type = data.type
    self.needTalent = data.need_talent  
    self.title = data.title
    self.des = data.des 
    self.icon = data.icon

    self.nextId = data.next_id
    self.row = data.row
    self.col = data.col
    
end

return _M