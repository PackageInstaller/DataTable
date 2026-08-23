local AncientsCoopTeamInviteCell = class("AncientsCoopTeamInviteCell", require("app.fairyGUI.ancients.UI_AncientsCoopTeamInviteCell"))

function var_0_0:ctor()
	self.m_Btn_cancel:addClickListener(handler(self, self._onClickBtnCancel))
	self.m_Btn_reject:addClickListener(handler(self, self._onClickBtnReject))
	self.m_Btn_confirm:addClickListener(handler(self, self._onClickBtnConfirm))
	self.m_Btn_apply:addClickListener(handler(self, self._onClickBtnApply))

	self._teamData = {}
end

function var_0_0:updateCell(arg_2_1)
	self.m_tabTypeController:setSelectedIndex(arg_2_1.type)

	self._teamData = arg_2_1.team

	local var_2_0 = g.core.utils.Tools.ancientsFunc.getSnapshot(self._teamData.captain)

	if var_2_0 == nil then
		return
	end

	self.m_Comp_pet:updateAsUser(var_2_0)
	self.m_Txt_name:setText(g.core.lang:get(433334, {
		level = self._teamData.level,
		name = self._teamData.name
	}))
	self.m_Txt_num:setText(self._teamData.member_num .. "/4")
	self.m_Txt_fight:setText(self._teamData.pet_fight_value)

	local var_2_1 = g.core.model.User.ancientsData:isApplyedByTeamId(self._teamData.team_id)

	self.m_Btn_cancel:setVisible(var_2_1)
	self.m_Btn_apply:setVisible(not var_2_1)
end

function var_0_0:_onClickBtnCancel()
	g.core.network.GameNetProxy:send_C2S_Ancient_DeleteApply({
		team_id = self._teamData.team_id
	})
end

function var_0_0:_onClickBtnReject()
	g.core.network.GameNetProxy:send_C2S_Ancient_ConfirmInvite({
		accept = false,
		team_id = self._teamData.team_id
	})
end

function var_0_0:_onClickBtnConfirm()
	if g.core.model.User.ancientsData:isForbiddenJoinTeam() then
		g.core.module.ModuleManager:tip(g.core.lang:get(433355, {
			time = g.core.model.User.ancientsData:getForbiddenJoinTeamCDStr()
		}))

		return
	end

	if self._teamData.member_num >= 4 then
		g.core.module.ModuleManager:tip(g.core.lang:get(433404))

		return
	end

	if g.core.model.User.ancientsData:teamForbiddenJoin(self._teamData.join_user_cd_time) and not self._teamData.confirm then
		g.core.module.ModuleManager:tip(g.core.lang:get(433356, {
			time = g.core.model.User.ancientsData:getCDStr(self._teamData.join_user_cd_time)
		}))

		return
	end

	g.core.network.GameNetProxy:send_C2S_Ancient_ConfirmInvite({
		accept = true,
		team_id = self._teamData.team_id
	})
end

function var_0_0:_onClickBtnApply()
	if self._teamData.member_num >= 4 then
		g.core.module.ModuleManager:tip(g.core.lang:get(433363))

		return
	end

	if g.core.model.User.ancientsData:isForbiddenJoinTeam() then
		g.core.module.ModuleManager:tip(g.core.lang:get(433355, {
			time = g.core.model.User.ancientsData:getForbiddenJoinTeamCDStr()
		}))

		return
	end

	if g.core.model.User.ancientsData:teamForbiddenJoin(self._teamData.join_user_cd_time) and not self._teamData.confirm then
		g.core.module.ModuleManager:tip(g.core.lang:get(433356, {
			time = g.core.model.User.ancientsData:getCDStr(self._teamData.join_user_cd_time)
		}))

		return
	end

	g.core.network.GameNetProxy:send_C2S_Ancient_ReqJoin({
		team_id = self._teamData.team_id
	})
end

return var_0_0
