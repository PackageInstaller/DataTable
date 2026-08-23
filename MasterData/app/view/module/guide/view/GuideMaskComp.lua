local GuideMaskComp = class("GuideMaskComp", require("app.fairyGUI.guide.UI_GuideMaskComp"))

function GuideMaskComp:ctor()
	self:setSize(display.width, display.height)
end

function GuideMaskComp:updateView(arg_2_1, arg_2_2)
	local var_2_0

	if arg_2_1.tipsShape then
		self.m_typeController:setSelectedIndex(arg_2_1.tipsShape - 1)

		if arg_2_2 then
			var_2_0 = arg_2_2.globalCenterPos or cc.p(0, 0)
		end
	end

	local var_2_1 = self:globalToLocal(var_2_0)
	local var_2_2 = self["m_child" .. (arg_2_1.tipsShape or 1)]:getChild("empty")

	var_2_2:setPosition(var_2_1)

	if not arg_2_1.tipsShape or not arg_2_2 or arg_2_1.opeType == 4 and arg_2_2.size.width > 500 then
		var_2_2:setVisible(false)
	elseif arg_2_1.tipsShape == 1 then
		local var_2_3 = arg_2_2.scale or {
			x = 1,
			y = 1
		}

		var_2_2:setSize((arg_2_2.size.width + 30) * ((arg_2_1.tipScaleX or 100) / 100) * var_2_3.x, (arg_2_2.size.height + 30) * ((arg_2_1.tipScaleY or 100) / 100) * var_2_3.y)
	end
end

return GuideMaskComp
