local DynamicCellView = class("DynamicCellView", import(".LevelCellView"))

function DynamicCellView:Ctor(arg_1_1)
	DynamicCellView.super.Ctor(self)

	self.go = arg_1_1
	self.tf = self.go.transform

	self:OverrideCanvas()

	self.buffer = FuncBuffer.New()

	return
end

return DynamicCellView
