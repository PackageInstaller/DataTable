local AncientsTeamUserComp = class("AncientsTeamUserComp", require("app.fairyGUI.ancients.UI_AncientsTeamUserComp"))
local var_0_3 = g.core.const.ConstMgr.AncientsConst

function var_0_0:ctor()
	self.m_Btn_invite:addClickListener(handler(self, self._onClickBtnInvite))
	self.m_ban_fightController:setSelectedIndex(1)
	self:addClickListener(handler(self, self._onClickSelf))

	self._knightPicUserId = 0
end

function var_0_0:updateView(arg_2_1)
	local var_2_0 = g.core.model.User.ancientsData
	local var_2_1 = g.core.model.User.ancientsData:getTeamUserByPos(arg_2_1.pos, var_0_3.GET_TEAM_TYPE.CURRENT_TEAM)

	self._teamUser = var_2_1

	if not var_2_1 then
		self.m_has_userController:setSelectedIndex(0)
		self.m_ban_fightController:setSelectedIndex(1)
	else
		self.m_has_userController:setSelectedIndex(1)
		self.m_ban_fightController:setSelectedIndex(var_2_0:isUserBanFight(self:getUserId(), var_0_3.GET_TEAM_TYPE.CURRENT_TEAM) and 1 or 0)
		self.m_Txt_score:setText(var_2_1.score)
		self.m_Txt_contribute:setText(var_2_1.team_contribution)
		self.m_is_leaderController:setSelectedIndex(var_2_0:isTeamUserLeader(var_2_1.user_id, var_0_3.GET_TEAM_TYPE.CURRENT_TEAM) and 1 or 0)
		self.m_Txt_fightValue:setText(self._teamUser.fight_value)
	end
end

function var_0_0:updateUserBaseInfo()
	local var_3_0 = g.core.utils.Tools.ancientsFunc.getSnapshot(self:getUserId())

	if not var_3_0 then
		return
	end

	self.m_Comp_name:setText(var_3_0.name)

	if var_3_0.id == self._knightPicUserId then
		return
	end

	local var_3_1 = var_3_0.show_knight_id

	if not var_3_0.show_knight_id or var_3_1 == 0 then
		var_3_1 = var_3_0.base_id
	end

	if not var_3_1 or var_3_1 == 0 then
		return
	end

	self.m_Comp_spine:removeChildren()

	self._knightPic = require("app.view.common.CommonKnight").new((g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot(var_3_0)))

	self.m_Comp_spine:addChild(self._knightPic)

	self._knightPicUserId = var_3_0.id
end

function var_0_0:getUserId()
	if not self._teamUser then
		return 0
	end

	return self._teamUser.user_id
end

function var_0_0._onClickBtnInvite(arg_5_0)
	if not g.core.model.User.ancientsData:isTeamUserLeader(g.core.model.User:getId(), var_0_3.GET_TEAM_TYPE.CURRENT_TEAM) then
		g.core.module.ModuleManager:tip(g.core.lang:get(433314))

		return
	end

	if g.core.model.User.ancientsData:getAncientsState() >= var_0_3.ANCIENT_STATUS.FINAL then
		g.core.module.ModuleManager:tip(g.core.lang:get(433315))

		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_TEAM_INVITE_POP)
end

function var_0_0:_onClickSelf()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Small_01)

	local var_6_0 = g.core.model.User.ancientsData:getAncientsState()
	local var_6_1 = g.core.model.User:getId()

	if var_6_0 >= g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL and self:getUserId() == var_6_1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(302026))

		return
	end

	if var_6_0 >= g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL_COOP and g.core.model.User.ancientsData:isTeamUserLeader(var_6_1, var_0_3.GET_TEAM_TYPE.CURRENT_TEAM) and self:getUserId() == var_6_1 then
		return
	end

	if not self._teamUser then
		return
	end

	g.core.common.GlobalFunc.showFloatCustomPanel(self.m_Comp_click, "AncientsTeamMenuComp", (require("app.view.module.ancients.view.AncientsTeamMenuComp").new({
		teamUser = self._teamUser
	})))
end

return var_0_0
