local NewSlgBrComDropDownCell2 = class("NewSlgBrComDropDownCell2")

function NewSlgBrComDropDownCell2:onRenderComDropCell(arg_1_1, arg_1_2)
	self:setCtrlState("selIndex", {
		index = arg_1_2 and 1 or 0
	})
	self:getChild("title"):updateQualityTxtForce({
		isDark = false,
		quality = arg_1_1.quality,
		text = arg_1_1.text
	})
end

return NewSlgBrComDropDownCell2
