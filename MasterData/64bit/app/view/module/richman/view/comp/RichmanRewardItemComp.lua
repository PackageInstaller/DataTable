local var_0_0 = g.core.common.Goods
local RichmanRewardItemComp = class("RichmanRewardItemComp", require("app.fairyGUI.richman.UI_RichmanRewardItemComp"))

function RichmanRewardItemComp:updateRewardItem(arg_1_1)
	local var_1_0 = var_0_0:convert(arg_1_1)

	self.m_icon:setURL(var_1_0.icon)
	self.m_numTxt:setText("x" .. var_1_0.size)
end

return RichmanRewardItemComp
