local LevelCellData = class("LevelCellData", import("model.vo.BaseVO"))

function LevelCellData:GetLine()
	return {
		row = self.row,
		column = self.column
	}
end

function LevelCellData:SetLine(arg_2_1)
	self.row = arg_2_1.row
	self.column = arg_2_1.column

	return
end

return LevelCellData
