function fgui.GBasicTextField.setText(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	fgui.GObject.setText(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
end

function fgui.GBasicTextField:setAdditionalKerning(arg_2_1)
	local var_2_0 = self:displayObject()

	tolua.cast(var_2_0, "cc.Label")

	if var_2_0.setAdditionalKerning then
		var_2_0:setAdditionalKerning(arg_2_1)
	end
end

function fgui.GBasicTextField:setTextQuality(arg_3_1, arg_3_2)
	self:setText(arg_3_1)
	self:setColor(g.core.common.Color.quality[math.max(1, arg_3_2)])
end

function fgui.GBasicTextField:setTextDarkQuality(arg_4_1, arg_4_2)
	self:setText(arg_4_1)
	self:setColor(g.core.common.Color.darkQuality[math.max(1, arg_4_2)])
end

function fgui.GBasicTextField:setQuality(arg_5_1)
	self:setColor(g.core.common.Color.quality[math.max(1, arg_5_1)])
end

function fgui.GBasicTextField:setDarkQuality(arg_6_1)
	self:setColor(g.core.common.Color.darkQuality[math.max(1, arg_6_1)])
end

return fgui.GBasicTextField
