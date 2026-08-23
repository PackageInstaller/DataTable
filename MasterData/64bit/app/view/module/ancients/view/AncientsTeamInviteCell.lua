local AncientsTeamInviteCell = class("AncientsTeamInviteCell", require("app.fairyGUI.ancients.UI_AncientsTeamInviteCell"))
local var_0_2 = g.core.const.ConstMgr.AncientsConst

function var_0_0:ctor()
	self.m_Btn_invite:addClickListener(handler(self, self._onClickBtnInvite))
end

function var_0_0:updateCell(arg_2_1)
	if not arg_2_1.snapshot then
		return
	end

	self._snapshot = arg_2_1.snapshot
	self._simpleUser = arg_2_1.simpleUser

	self.m_Comp_icon:updateAsUser(self._snapshot)
	self.m_Txt_name:setText(self._snapshot.name)
	self.m_Txt_fight_value:setText(self._simpleUser.fight_value)
	self.m_Txt_score:setText(self._simpleUser.score or 0)

	if self._simpleUser.team_id > 0 then
		self.m_invate_stateController:setSelectedIndex(2)
	else
		self.m_invate_stateController:setSelectedIndex(self._simpleUser.is_invited and 1 or 0)
	end

	if self._simpleUser.promote_rank and self._simpleUser.promote_rank > 0 then
		self.m_has_rankController:setSelectedIndex(1)
		self.m_Txt_rank:setText(g.core.lang:get(303033, {
			rank = self._simpleUser.promote_rank
		}))
	else
		self.m_has_rankController:setSelectedIndex(0)
	end
end

function var_0_0:_onClickBtnInvite()
	local var_3_0 = g.core.model.User.ancientsData:getTeamJoinCdTime(var_0_2.GET_TEAM_TYPE.CURRENT_TEAM)

	if var_3_0 <= g.core.common.ServerTime:getTime() then
		g.core.network.GameNetProxy:send_C2S_Ancient_Invite({
			user_id = self._snapshot.id
		})
	else
		local var_3_1 = {}

		var_3_1.time = g.core.common.ServerTime:getLeftHMSFormat(var_3_0)

		g.core.module.ModuleManager:tip(g.core.lang:get(433313, var_3_1))
	end
end

return var_0_0
