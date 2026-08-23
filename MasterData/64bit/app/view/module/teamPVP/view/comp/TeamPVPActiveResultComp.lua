local var_0_0 = g.core.model.User.teamPvpData
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.knightsData
local TeamPVPActiveResultComp = class("TeamPVPActiveResultComp", require("app.fairyGUI.teamPVP.UI_TeamPVPActiveResultComp"))

function TeamPVPActiveResultComp:updateShowComp(arg_1_1)
	self.m_userIcon:updateAsUser(arg_1_1.user)
	self.m_userName:setText(arg_1_1.user.name)
	self.m_serverName:setText(arg_1_1.user.server_name)

	local var_1_0 = arg_1_1.user.show_knight_id or 0

	if var_1_0 < 1 then
		var_1_0 = arg_1_1.user.base_id
	end

	self.m_knightMask:setIcon(var_0_1:getMiddleKnightPicById(var_0_2:getKnightResInfo({
		knightId = var_1_0,
		skinId = arg_1_1.user.show_knight_dress
	}).painted_id))

	local var_1_1 = self.m_knightMask:getChild("icon"):getContentSprite()

	if var_1_1 then
		var_1_1:showChangingRect({
			x = -70,
			y = -200,
			width = 140,
			height = 550
		}, 80)
	end

	local var_1_2 = var_0_0:getTitleInfoByBaseId((var_0_0:getTitleIdByHonor(arg_1_1.score)))

	if var_1_2 then
		self.m_titleLoader:setURL(var_0_1:getTeamPVPBadge128(var_1_2.title_res))
	end
end

return TeamPVPActiveResultComp
