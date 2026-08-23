local NewSlgBrComDropDownCell = class("NewSlgBrComDropDownCell")

function NewSlgBrComDropDownCell:onRenderComDropCell(arg_1_1, arg_1_2, arg_1_3)
	self:setCtrlState("selIndex", {
		index = arg_1_2 and 1 or 0
	})
	self:setTitle(arg_1_1.text)

	if arg_1_1.img then
		self:getChild("icon"):setIcon(arg_1_1.img)
		self:getChild("icon"):setVisible(true)
	else
		self:getChild("icon"):setVisible(false)
	end

	if self:getController("showBg") then
		self:setCtrlState("showBg", {
			index = arg_1_3 % 2 == 1 and 0 or 1
		})
	end
end

return NewSlgBrComDropDownCell
