local AncientsSoulEchoUserComp = class("AncientsSoulEchoUserComp", require("app.fairyGUI.ancients.UI_AncientsSoulEchoUserComp"))

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onRcvCommonSimpleUserSnap), self)
end

function var_0_0:_onRcvCommonSimpleUserSnap(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self:_updateUsersBaseInfo()
end

function var_0_0:updateView(arg_4_1, arg_4_2)
	if not arg_4_1 then
		return
	end

	self._pos = arg_4_2
	self._isLeader = g.core.model.User.ancientsData:isTeamUserLeader(g.core.model.User:getId())

	local var_4_0 = arg_4_1.main_user_id or 0

	self._echoUserId = var_4_0

	if self._isLeader then
		if var_4_0 == 0 then
			self.m_statusController:setSelectedIndex(2)
		else
			self.m_statusController:setSelectedIndex(0)

			if g.core.utils.Tools.ancientsFunc.sendSimpleUserSnapshot({
				var_4_0
			}) then
				self:_updateUsersBaseInfo()
			end
		end
	elseif var_4_0 == 0 then
		self.m_statusController:setSelectedIndex(1)
	else
		self.m_statusController:setSelectedIndex(3)

		if g.core.utils.Tools.ancientsFunc.sendSimpleUserSnapshot({
			var_4_0
		}) then
			self:_updateUsersBaseInfo()
		end
	end
end

function var_0_0:_updateUsersBaseInfo()
	local var_5_0 = g.core.utils.Tools.ancientsFunc.getSnapshot(self._echoUserId)

	self.m_Comp_name:setText(var_5_0.name)
	self.m_Txt_fightValue:setText(var_5_0.fight_value)
	self.m_knightIcon:setIcon(g.core.common.Path:getMiddleKnightPicById((var_5_0.show_knight_dress > 0 or nil) and var_5_0.show_knight_dress))
end

return var_0_0
