module("cycle.CycleCellVo", Class.impl())

function parseCellVo(self,id,data)
    self.id = id 

    self.row = data.col_id
    self.col = data.row_id
    self.nextIds = data.next_ids
    self.lineList = data.line_list
    
    self.nextIds = data.next_ids
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
