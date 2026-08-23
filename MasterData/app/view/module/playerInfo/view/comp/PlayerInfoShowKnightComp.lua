local var_0_0 = g.core.model.User.knightsData
local PlayerInfoShowKnightComp = class("PlayerInfoShowKnightComp", require("app.fairyGUI.playerInfo.UI_PlayerInfoShowKnightComp"))

function PlayerInfoShowKnightComp:updateKnightComp(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_4) do
		var_1_0[iter_1_1] = true
	end

	for iter_1_2 = 1, g.core.const.ConstMgr.KNIGHT_CONST.LINEUP_MAX do
		local var_1_1 = arg_1_1[iter_1_2]

		if arg_1_3 then
			var_1_1 = var_0_0:getKnight({
				id = var_0_0:getFormation()[iter_1_2]
			})
		end

		if self["m_knight" .. iter_1_2] then
			self["m_knight" .. iter_1_2]:updateKnightIcon(var_1_1, arg_1_2, iter_1_2, arg_1_3, var_1_1 and var_1_0[var_1_1:getAdvanceId()])
		end
	end
end

return PlayerInfoShowKnightComp
