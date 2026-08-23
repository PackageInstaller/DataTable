local var_0_0 = g.core.model.User.mysteryData
local MysteryLineCell = class("MysteryLineCell", require("app.fairyGUI.mystery.UI_MysteryLineCell"))

function MysteryLineCell:updateCell(arg_1_1)
	self.m_lineTxt:setText(g.core.lang:get(423003, {
		num = arg_1_1.id
	}) .. g.core.lang:get(423002, {
		cur = arg_1_1.num,
		max = var_0_0:getRoomMaxUserCount()
	}))
end

return MysteryLineCell
