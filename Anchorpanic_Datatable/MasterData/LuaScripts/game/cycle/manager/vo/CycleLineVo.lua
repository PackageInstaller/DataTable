module("cycle.CycleLineVo", Class.impl())

function parseLineVo(self, id, data)
    self.id = id

    self.row = data.row_num
    self.col = data.col_num
    self.cellData = data.cell_data

    self.name = data.name 
    self.des = data.des

    self:parseCellData()
end

function getRow(self)
    return self.row
end

function getCol(self)
    return self.col
end

function parseCellData(self)
    self.cellDic = {}
    for k, v in pairs(self.cellData) do
        local vo = cycle.CycleCellVo.new()
        vo:parseCellVo(k,v)
        self.cellDic[k] = vo
    end
end

function getCellData(self)
    return self.cellDic
end

function getCellDataById(self,id)
    return self.cellDic[id]
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
