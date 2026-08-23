local KnightStruct = require("app.view.module.knight.model.KnightStruct")
local var_0_1 = g.core.config.knight_info
local RichmanMonsterKnightIcon = class("RichmanMonsterKnightIcon", require("app.fairyGUI.richman.UI_RichmanMonsterKnightIcon"))

function RichmanMonsterKnightIcon:updateRichmanMonster(arg_1_1)
	local var_1_0 = var_0_1.get(arg_1_1.res_id)
	local var_1_1 = KnightStruct.new(var_1_0.advance_id)

	var_1_1:addCfgInfo(var_1_0)
	self.m_knightIcon:updateIcon({
		isOthers = true,
		isFogNightPop = true,
		type = g.core.common.Goods.TYPE_KNIGHT,
		struct = var_1_1,
		star = var_1_0.star
	})
end

return RichmanMonsterKnightIcon
