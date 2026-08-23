local NewSlgPvcComDropDownCell = class("NewSlgPvcComDropDownCell")

function NewSlgPvcComDropDownCell:onRenderComDropCell(arg_1_1, arg_1_2, arg_1_3)
	self:setCtrlState("selIndex", {
		index = arg_1_2 and 1 or 0
	})
	self:setTitle(arg_1_1.text)

	if self:getController("showBg") then
		self:setCtrlState("showBg", {
			index = arg_1_3 % 2 == 1 and 0 or 1
		})
	end
end

return NewSlgPvcComDropDownCell
