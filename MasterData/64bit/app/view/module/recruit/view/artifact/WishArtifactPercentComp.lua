local WishArtifactPercentComp = class("WishArtifactPercentComp", require("app.fairyGUI.recruitArtifact.UI_WishArtifactPercentComp"))

function WishArtifactPercentComp:updatePercent(arg_1_1, arg_1_2)
	local var_1_0 = g.core.config.parameter_info.get(15003).parameter

	self.m_basePercentText:setText(var_1_0 .. "%")

	local var_1_1 = 0

	if arg_1_2 and arg_1_2:getUpValue() > 0 then
		local var_1_2 = math.floor(tonumber(g.core.config.parameter_info.get(15027).parameter) / 100)

		self.m_extPercentText:setText(g.core.lang:get(108409, {
			num = var_1_2
		}))
		self.m_totalText:setText(g.core.lang:get(108410, {
			num = var_1_0 + var_1_2
		}))

		var_1_1 = 1
	end

	self.m_hasExtPercentController:setSelectedIndex(var_1_1)
end

function WishArtifactPercentComp:updatePercentByPercent(arg_2_1)
	self.m_basePercentText:setText(arg_2_1 .. "%")
end

return WishArtifactPercentComp
