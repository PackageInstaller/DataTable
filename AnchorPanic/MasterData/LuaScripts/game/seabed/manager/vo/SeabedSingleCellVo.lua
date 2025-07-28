module("seabed.SeabedSingleCellVo", Class.impl())

function parseData(self,id,data)
    self.id = id    
    self.rowNum = data.row_num
    self.colNum = data.col_num 
    self.nextIds = data.next_ids 
    self.returnId = data.return_id
end


return _M