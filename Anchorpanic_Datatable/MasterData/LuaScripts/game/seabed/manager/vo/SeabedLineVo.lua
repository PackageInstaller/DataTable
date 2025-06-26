module("seabed.SeabedLineVo", Class.impl())

function parseData(self,id,data)
    self.id = id    
    self.cellData = {}
    self.name = data.name 
    self.des = data.des 
    self.endCell = data.end_cell
    self.backGround = data.background
    self.long = data.long
    self.wide = data.wide
    self:parseCellData(data.cell_data)
end


function parseCellData(self,data)
    for cellId, data in pairs(data) do
        local vo = seabed.SeabedSingleCellVo.new()
        vo:parseData(cellId,data)
        self.cellData[cellId] = vo
    end
end

function getAllCell(self)
    return self.cellData
end

function getSingleCellData(self,cellId)
    return self.cellData[cellId]
end

return _M