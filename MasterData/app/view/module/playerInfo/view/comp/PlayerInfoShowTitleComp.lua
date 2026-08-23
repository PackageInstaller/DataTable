local UserConst = require("app.view.module.user.const.UserConst")
local var_0_1 = g.core.model.User
local var_0_2 = g.core.model.User.playerInfoData
local PlayerInfoShowTitleComp = class("PlayerInfoShowTitleComp", require("app.fairyGUI.playerInfo.UI_PlayerInfoShowTitleComp"))

function PlayerInfoShowTitleComp:updateTitleComp(arg_1_1)
	local var_1_0 = {}

	var_1_0 = arg_1_1 and var_0_1:getAllWearingTitleIds() or var_0_2:getTitleShowList()

	for iter_1_0 = 1, UserConst.MAX_TITLE_SLOT do
		if self["m_titleIcon" .. iter_1_0] then
			self["m_titleIcon" .. iter_1_0]:updateTitleIcon(var_1_0[iter_1_0], arg_1_1)
		end
	end
end

return PlayerInfoShowTitleComp
