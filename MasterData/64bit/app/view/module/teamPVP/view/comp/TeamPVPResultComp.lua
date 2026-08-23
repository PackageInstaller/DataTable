local var_0_0 = g.core.platform.ServerListProxy
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.teamPvpData
local TeamPVPResultComp = class("TeamPVPResultComp", require("app.fairyGUI.teamPVP.UI_TeamPVPResultRedComp"))

function TeamPVPResultComp:ctor()
	self._snapshot = nil
	self._battleUser = nil
	self._killNums = nil
end

function TeamPVPResultComp:updateResultComp(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	local var_2_0 = arg_2_1.snapshot
	local var_2_1 = arg_2_1.battleUser
	local var_2_2 = arg_2_1.battleUser.guid
	local var_2_3 = arg_2_1.battleUser.guid == arg_2_1.mvpId

	self.m_isMvpController:setSelectedIndex(arg_2_1.battleUser.guid == arg_2_1.mvpId and 1 or 0)

	if var_2_3 then
		self:_playMvpEffect()
	end

	self.m_featTxt:setText(arg_2_2[var_2_2] or 0)

	if var_2_1.is_robot then
		self.m_nameTxt:setText(var_0_2:getRobotName(var_2_2) or "")
	else
		self.m_nameTxt:setText(var_2_0.name)
	end

	local var_2_4 = var_0_0:getServerBySid(var_2_0.sid)

	self.m_serverName:setText((var_2_4 or nil) and (var_2_4.name or g.core.lang:get(420431)))
	self.m_powerTxt:setText(var_2_0.fight_value)
	self.m_levelTxt:setText(g.core.lang:get(2052, {
		level = var_2_0.level
	}))
	self.m_isMyselfController:setSelectedIndex(var_0_2:getMyGuid() == var_2_2 and 1 or 0)
	self.m_headComp:getChild("knightIcon"):setURL(var_0_1:getMiddleKnightPicById((var_2_0.show_knight_dress and var_2_0.show_knight_dress > 0 or nil) and var_2_0.show_knight_dress))
	self.m_rankLoader:setURL(var_0_1:getTeamPVPBadge128(var_2_1.title))
end

function TeamPVPResultComp:_playMvpEffect()
	self.m_mvpEff:addEffectSpine({
		anim = "mvp",
		name = "eff_ui_teamPvp_VSBtn",
		isLoop = true
	})
end

return TeamPVPResultComp
