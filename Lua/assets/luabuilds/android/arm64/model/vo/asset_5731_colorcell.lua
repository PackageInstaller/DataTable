local ColorCell = class("ColorCell")

function ColorCell:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.row = arg_1_1
	self.column = arg_1_2
	self.type = arg_1_3

	return
end

return ColorCell
