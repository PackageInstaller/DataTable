local AncientsTeamApplyCell = class("AncientsTeamApplyCell", require("app.fairyGUI.ancients.UI_AncientsTeamApplyCell"))
local var_0_2 = g.core.const.ConstMgr.AncientsConst

function var_0_0:ctor()
	self.m_Btn_refuse:addClickListener(handler(self, self._onClickBtnRefuse))
	self.m_Btn_join:addClickListener(handler(self, self._onClickBtnJoin))
end

function var_0_0:updateCell(arg_2_1)
	self._simpleUser = arg_2_1.simpleUser

	local var_2_0 = g.core.utils.Tools.ancientsFunc.getSnapshot(self._simpleUser.user_id)

	if var_2_0 then
		self.m_Comp_icon:updateAsUser(var_2_0)
		self.m_Comp_name:setText(var_2_0.name)
		self.m_Txt_fight_value:setText(self._simpleUser.fight_value)
	end

	self.m_Txt_level:setText(g.core.lang:get(200017, {
		level = var_2_0.level
	}))
	self.m_Txt_score:setText(self._simpleUser.score or 0)

	if self._simpleUser.promote_rank and self._simpleUser.promote_rank > 0 then
		self.m_has_rankController:setSelectedIndex(1)
		self.m_Txt_rank:setText(g.core.lang:get(303033, {
			rank = self._simpleUser.promote_rank
		}))
	else
		self.m_has_rankController:setSelectedIndex(0)
	end
end

function var_0_0:_onClickBtnRefuse()
	if not g.core.model.User.ancientsData:isTeamUserLeader(g.core.model.User:getId(), var_0_2.GET_TEAM_TYPE.CURRENT_TEAM) then
		g.core.module.ModuleManager:tip(g.core.lang:get(433314))

		return
	end

	local var_3_0 = g.core.model.User.ancientsData:getTeamJoinCdTime(var_0_2.GET_TEAM_TYPE.CURRENT_TEAM)

	if var_3_0 > g.core.common.ServerTime:getTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(433313, {
			time = g.core.common.ServerTime:getLeftHMSFormat(var_3_0)
		}))

		return
	end

	g.core.network.GameNetProxy:send_C2S_Ancient_ConfirmApply({
		accept = false,
		user_id = self._simpleUser.user_id
	})
end

function var_0_0:_onClickBtnJoin()
	if not g.core.model.User.ancientsData:isTeamUserLeader(g.core.model.User:getId(), var_0_2.GET_TEAM_TYPE.CURRENT_TEAM) then
		g.core.module.ModuleManager:tip(g.core.lang:get(433314))

		return
	end

	local var_4_0 = g.core.model.User.ancientsData:getTeamJoinCdTime(var_0_2.GET_TEAM_TYPE.CURRENT_TEAM)

	if var_4_0 > g.core.common.ServerTime:getTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(433313, {
			time = g.core.common.ServerTime:getLeftHMSFormat(var_4_0)
		}))

		return
	end

	g.core.network.GameNetProxy:send_C2S_Ancient_ConfirmApply({
		accept = true,
		user_id = self._simpleUser.user_id
	})
end

return var_0_0
