local AncientsGuessUserComp = class("AncientsGuessUserComp", require("app.fairyGUI.ancients.UI_AncientsGuessUserLeftComp"))
local var_0_2 = g.core.const.ConstMgr.AncientsConst

function var_0_0:ctor()
	self.m_Btn_guess:addClickListener(handler(self, self._onClickBtnGuess))
	self.m_Btn_fixGuess:addClickListener(handler(self, self._onClickBtnFixGuess))
	self.m_Loader_box:addClickListener(handler(self, self._onBoxClick))
end

function var_0_0:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onRevSnapShot), self)
end

function var_0_0:_onRevSnapShot(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._curCaptainId)

	if var_3_0 then
		self.m_Comp_userIcon:updateAsUser(var_3_0)
		self.m_Comp_userIcon:setTouchCallFunc(handler(self, function(arg_4_0)
			g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_COOP_TEAM_INFO_POP, {
				teamId = arg_4_0._curTeamId
			})
		end))
	end
end

function var_0_0:updateView(arg_5_1)
	self._isLeft = arg_5_1.isLeft
	self._data = arg_5_1.data

	if self._isLeft then
		self._curTeamId = self._data.left_team_id
		self._curRate = self._data.left_support_rate
		self._curCaptainId = self._data.left_captain_id
	else
		self._curTeamId = self._data.right_team_id
		self._curRate = self._data.right_support_rate
		self._curCaptainId = self._data.right_captain_id
	end

	self._team = g.core.model.User.ancientsData:getFinalTeamMap()[self._curTeamId]

	self.m_Txt_name:setText(g.core.lang:get(433332, {
		name = self._team.name
	}))
	self.m_Txt_fightValue:setText(self._team.pet_fight_value)
	self.m_Txt_betNum:setText(self._curRate .. "%")
	self.m_Txt_teamNum:setText(self._team.member_num)

	local var_5_0 = g.core.config.ancients_pet_info.get(self._team.ancient_pet_id)
	local var_5_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._curCaptainId)

	if var_5_1 then
		self.m_Comp_userIcon:updateAsUser(var_5_1)
		self.m_Comp_userIcon:setTouchCallFunc(handler(self, function(arg_6_0)
			g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_COOP_TEAM_INFO_POP, {
				teamId = arg_6_0._curTeamId
			})
		end))
	end

	local var_5_2 = 2
	local var_5_3 = 0

	if g.core.model.User.ancientsData:getRoundTeamsMap()[self._data.round] and not g.core.model.User.ancientsData:isInStageShowTime(self._data.round) then
		var_5_2 = 0

		for iter_5_0, iter_5_1 in ipairs(g.core.model.User.ancientsData:getRoundTeamsMap()[self._data.round]) do
			if iter_5_1 == self._curTeamId then
				var_5_2 = 1
			end
		end

		if self._data.support_team_id ~= 0 then
			var_5_3 = 1

			if self._data.support_team_id ~= self._curTeamId then
				var_5_3 = 2
			end
		end
	elseif self._data.support_team_id ~= 0 then
		var_5_3 = 1

		if self._data.support_team_id ~= self._curTeamId then
			var_5_3 = 2
		end
	end

	local var_5_6 = g.core.model.User.ancientsData:getTeam(var_0_2.GET_TEAM_TYPE.FINAL_TEAM) and g.core.model.User.ancientsData:getTeam(var_0_2.GET_TEAM_TYPE.FINAL_TEAM).team_id

	self.m_is_winController:setSelectedIndex(var_5_2)
	self.m_is_guessController:setSelectedIndex(var_5_3)
	self.m_is_selfController:setSelectedIndex(var_5_6 == self._curTeamId and 1 or 0)
	self.m_Group_box:setVisible(not self._data.is_awarded and var_5_3 ~= 0 and self._data.support_team_id == self._curTeamId)

	if self.m_Group_box:isVisible() then
		self.m_Loader_box:getTransition("loop"):play(-1, 0)
	elseif self.m_Loader_box:getTransition("loop"):isPlaying() then
		self.m_Loader_box:getTransition("loop"):stop()
	end
end

function var_0_0:_onClickBtnGuess()
	self:_sendGuessMessage()
end

function var_0_0:_onClickBtnFixGuess()
	self:_sendGuessMessage()
end

function var_0_0:_sendGuessMessage()
	local var_9_0 = g.core.model.User.ancientsData:getFinalStageTimeList()

	if g.core.model.User.ancientsData:getAncientsState() == g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL then
		local var_9_1 = g.core.common.ServerTime:getLeftSeconds(({
			var_9_0[1],
			var_9_0[2],
			var_9_0[3],
			var_9_0[4]
		})[self._data.round])

		if var_9_1 > 0 and var_9_1 < g.core.config.ancients_parameter_info.get(47).parameter * 60 then
			g.core.module.ModuleManager:tip(g.core.lang:get(433383))

			return
		end
	end

	g.core.network.GameNetProxy:send_C2S_Ancient_Guess({
		round = self._data.round,
		num = self._data.num,
		team_id = self._curTeamId
	})
end

function var_0_0:_onBoxClick()
	g.core.network.GameNetProxy:send_C2S_Ancient_GuessAward({
		round = self._data.round,
		num = self._data.num
	})
end

function var_0_0:onUnload()
	if self.m_Loader_box:getTransition("loop"):isPlaying() then
		self.m_Loader_box:getTransition("loop"):stop()
	end
end

return var_0_0
