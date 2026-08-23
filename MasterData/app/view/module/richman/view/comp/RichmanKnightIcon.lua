local var_0_0 = g.core.model.User.richmanData
local KnightStruct = require("app.view.module.knight.model.KnightStruct")
local var_0_2 = g.core.config.knight_info
local RichmanKnightIcon = class("RichmanKnightIcon", require("app.fairyGUI.richman.UI_RichmanKnightIcon"))

function RichmanKnightIcon:updateKnight(arg_1_1, arg_1_2, arg_1_3)
	if not var_0_0:getCurRobData() then
		local var_1_0 = g.core.model.User.knightsData:getKnightByPos(arg_1_1)

		if var_1_0 then
			self.m_knightIcon:updateIcon({
				struct = var_1_0
			})
			self.m_emptyController:setSelectedIndex(1)
		else
			self.m_emptyController:setSelectedIndex(0)
		end
	elseif arg_1_2 and arg_1_2 ~= 0 then
		local var_1_1 = var_0_2.get(arg_1_2)
		local var_1_2 = KnightStruct.new(var_1_1.advance_id)

		var_1_2:addCfgInfo(var_1_1)
		var_1_2:setIsOtherUser(true, arg_1_3)
		self.m_knightIcon:updateIcon({
			isOthers = true,
			isFogNightPop = true,
			type = g.core.common.Goods.TYPE_KNIGHT,
			struct = var_1_2,
			star = var_1_1.star
		})
		self.m_emptyController:setSelectedIndex(1)
	else
		self.m_emptyController:setSelectedIndex(0)
	end
end

return RichmanKnightIcon
