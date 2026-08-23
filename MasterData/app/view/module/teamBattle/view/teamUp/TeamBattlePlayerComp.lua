local TeamBattlePlayerComp = class("TeamBattlePlayerComp", require("app.fairyGUI.teamBattle.UI_TeamBattlePlayerComp"))

function TeamBattlePlayerComp:ctor()
	self._data = nil

	self:_initComp()
end

function TeamBattlePlayerComp:_initComp()
	self.m_inviteBtn:addClickListener(handler(self, self._onClickInviteBtn))
	self.m_tickOutBtn:addClickListener(handler(self, self._onClickTickOutBtn))
end

function TeamBattlePlayerComp:updateComp(arg_3_1)
	self._data = arg_3_1

	if not arg_3_1 then
		self.m_isEmptyController:setSelectedIndex(0)

		return
	end

	self.m_userPicComp:getChild("knightPicComp"):updateKnight({
		snapshot = arg_3_1
	})
	self.m_playInfoComp:updateInfoComp(arg_3_1)
	self.m_isEmptyController:setSelectedIndex(1)

	if g.core.model.User.teamBattleData:getTeamUpData():isLeader() and self.m_posController:getSelectedIndex() > 0 then
		self.m_showTickOutController:setSelectedIndex(1)
	else
		self.m_showTickOutController:setSelectedIndex(0)
	end
end

function TeamBattlePlayerComp:_onClickInviteBtn()
	if self._data == nil then
		self:dispatchCompEvent("invitePlayer")
	end
end

function TeamBattlePlayerComp:_onClickTickOutBtn()
	self:dispatchCompEvent("tickOutPlayer", {
		uid = self._data.id
	})
end

function TeamBattlePlayerComp:setReady(arg_6_1)
	if arg_6_1 then
		self.m_tickOutBtn:setVisible(false)
		self.m_inviteGroup:setVisible(false)
	end
end

return TeamBattlePlayerComp
