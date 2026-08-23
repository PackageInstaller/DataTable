local AncientsAgainstComp = class("AncientsAgainstComp", require("app.fairyGUI.ancients.UI_AncientsAgainstComp"))
local var_0_2 = g.core.const.ConstMgr.AncientsConst

function var_0_0:ctor()
	self.m_Btn_myTeam:addClickListener(handler(self, self._onClickBtnMyTeam))
	self.m_Btn_guess:addClickListener(handler(self, self._onClickBtnGuess))
	self.m_Btn_shop:addClickListener(handler(self, self._onClickBtnShop))
	self.m_Btn_reward:addClickListener(handler(self, self._onClickBtnReward))
	self.m_Btn_chain:addClickListener(handler(self, self._onClickBtnChain))
	self.m_Btn_rank:addClickListener(handler(self, self._onClickBtnRank))

	self.m_effStage1 = self.m_eff_stage1
	self.m_effStage2 = self.m_eff_stage2
	self.m_effStage3 = self.m_eff_stage3
	self._roundVideoName = {
		{
			"v_1",
			"v_2",
			"v_3",
			"v_4",
			"v_5",
			"v_6",
			"v_7",
			"v_8"
		},
		{
			"v_9",
			"v_10",
			"v_11",
			"v_12"
		},
		{
			"v_13",
			"v_14"
		},
		{
			"v_15"
		}
	}
	self._roundEffectName = {
		{
			"eff_1",
			"eff_2",
			"eff_3",
			"eff_4"
		},
		{
			"eff_5",
			"eff_6"
		},
		{
			"eff_7"
		}
	}
	self._videoNodes = {
		self.m_v_1,
		self.m_v_2,
		self.m_v_3,
		self.m_v_4,
		self.m_v_5,
		self.m_v_6,
		self.m_v_7,
		self.m_v_8,
		self.m_v_9,
		self.m_v_10,
		self.m_v_11,
		self.m_v_12,
		self.m_v_13,
		self.m_v_14,
		self.m_v_15
	}

	for iter_1_0, iter_1_1 in ipairs(self._videoNodes) do
		iter_1_1:setVisible(false)
		iter_1_1:addClickListener(handler(self, self._onVideoClick))
	end

	self.m_Txt_title:setText(g.core.lang:get(433407, {
		time = g.core.common.ServerTime:getDateMDFormat(g.core.model.User.ancientsData:getActivityData().final_start_time)
	}))
	self.m_total_stateController:setSelectedIndex(0)
	self.m_eff_baqiang:removeAllEffect()
	self.m_eff_baqiang:addEffectSpine({
		isLoop = true,
		name = "eff_ui_ancients_badgelight"
	})
	self.m_enterTransition:play()
end

function var_0_0:onLoad()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_Btn_guess
	})
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._updateAgainstIcon), self)
end

function var_0_0:updateView(arg_3_1)
	self._roundTeams = arg_3_1.roundData
	self._teamMap = g.core.model.User.ancientsData:getFinalTeamMap()
	self._roundMap = {}

	for iter_3_0, iter_3_1 in ipairs(self._roundTeams) do
		if not g.core.model.User.ancientsData:isInStageShowTime(iter_3_1.round) then
			self._roundMap[iter_3_1.round + 1] = iter_3_1.team_ids
		end
	end

	self.m_has_teamController:setSelectedIndex(g.core.model.User.ancientsData:getTeam(var_0_2.GET_TEAM_TYPE.FINAL_TEAM) == nil and g.core.model.User.ancientsData:hasFinalFightQualification() and g.core.model.User.ancientsData:getAncientsState() == g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL_COOP and 0 or 1)
	self.m_not_fullController:setSelectedIndex(g.core.model.User.ancientsData:isTeamUserLeader(g.core.model.User:getId(), var_0_2.GET_TEAM_TYPE.FINAL_TEAM) and g.core.model.User.ancientsData:getTeam(var_0_2.GET_TEAM_TYPE.FINAL_TEAM) ~= nil and #g.core.model.User.ancientsData:getTeam(var_0_2.GET_TEAM_TYPE.FINAL_TEAM).users < 4 and g.core.model.User.ancientsData:getAncientsState() == g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL_COOP and 1 or 0)
	self.m_has_promoteController:setSelectedIndex(g.core.model.User.ancientsData:hasFinalFightQualification() and 1 or 0)
	self.m_is_rankController:setSelectedIndex(g.core.model.User.ancientsData:isRankLevelAward() and 1 or 0)
	self.m_Txt_time1:setText(g.core.lang:get(433406, {
		time = g.core.config.ancients_final_time_info.get(1).hour
	}))
	self.m_Txt_time2:setText(g.core.lang:get(433406, {
		time = g.core.config.ancients_final_time_info.get(2).hour
	}))
	self.m_Txt_time3:setText(g.core.lang:get(433406, {
		time = g.core.config.ancients_final_time_info.get(3).hour
	}))
	self.m_Txt_time4:setText(g.core.lang:get(433406, {
		time = g.core.config.ancients_final_time_info.get(4).hour
	}))
	self:_updateState()
	self:_updateAgainstIcon()
	self:_updateAgainstLine()
	self:_updateVideoList()
end

function var_0_0:_updateVideoList()
	for iter_4_0, iter_4_1 in ipairs(self._roundVideoName) do
		for iter_4_2, iter_4_3 in ipairs(iter_4_1) do
			local var_4_1 = self:getChild(iter_4_3)

			if var_4_1 then
				var_4_1:setVisible((#(g.core.model.User.ancientsData:getRoundTeamsMap()[iter_4_0] or {}) > 0 and g.core.model.User.ancientsData:isShowBattleVideo(iter_4_0) or nil) and true)
			end
		end
	end

	for iter_4_4, iter_4_5 in ipairs(self._roundEffectName) do
		local var_4_2 = not not (#(g.core.model.User.ancientsData:getRoundTeamsMap()[iter_4_4] or {}) > 0 and g.core.model.User.ancientsData:isInStageEffShowTime(iter_4_4))

		for iter_4_6, iter_4_7 in ipairs(iter_4_5) do
			local var_4_3 = self:getChild(iter_4_7)

			if var_4_3 then
				var_4_3:removeAllEffect()

				if var_4_2 then
					-- block empty
				end

				var_4_3:setVisible(var_4_2)
			end
		end
	end
end

function var_0_0:_updateState()
	local var_5_0 = g.core.model.User.ancientsData:getAncientsState()
	local var_5_2

	if var_5_0 < g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL then
		var_5_2 = 0
	elseif var_5_0 == g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL then
		local var_5_3 = g.core.model.User.ancientsData:getFinalStageTimeList()
		local var_5_4 = {
			var_5_3[1],
			var_5_3[2],
			var_5_3[3],
			var_5_3[4]
		}

		var_5_2 = g.core.common.ServerTime:getLeftSeconds(var_5_4[1]) > 0 and 0 or g.core.common.ServerTime:getLeftSeconds(var_5_4[2]) > 0 and 1 or g.core.common.ServerTime:getLeftSeconds(var_5_4[3]) > 0 and 2 or g.core.common.ServerTime:getLeftSeconds(var_5_4[4]) > 0 and 3 or 4
	else
		var_5_2 = 5
	end

	self.m_stateController:setSelectedIndex(var_5_2)
end

function var_0_0:_onVideoClick(arg_6_1)
	local var_6_0 = string.split(arg_6_1:getSender():getCustomData(), ",")
	local var_6_1 = tonumber(var_6_0[1])
	local var_6_2 = tonumber(var_6_0[2])

	if self._roundMap[var_6_1][var_6_2 * 2] == 0 or self._roundMap[var_6_1][var_6_2 * 2 - 1] == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(433388))

		return
	end

	g.core.network.GameNetProxy:send_C2S_Ancient_FinalBattleReport({
		round = var_6_1,
		num = var_6_2
	})
end

function var_0_0:_updateAgainstIcon()
	local var_7_0 = self._roundMap[1] or {}
	local var_7_1 = self._roundMap[2] or {}
	local var_7_2 = self._roundMap[3] or {}
	local var_7_3 = self._roundMap[4] or {}
	local var_7_4 = self._roundMap[5] or {}

	for iter_7_0 = 1, var_0_2.ROUND_NUM.ROUND_ZERO do
		self:getChild("Comp_0_" .. iter_7_0):updateIcon({
			round = 1,
			data = self._teamMap[var_7_0[iter_7_0]]
		})
	end

	for iter_7_1 = 1, var_0_2.ROUND_NUM.ROUND_ONE do
		self:getChild("Comp_1_" .. iter_7_1):updateIcon({
			round = 2,
			data = self._teamMap[var_7_1[iter_7_1]]
		})
	end

	for iter_7_2 = 1, var_0_2.ROUND_NUM.ROUND_TWO do
		self:getChild("Comp_2_" .. iter_7_2):updateIcon({
			round = 3,
			data = self._teamMap[var_7_2[iter_7_2]]
		})
	end

	for iter_7_3 = 1, var_0_2.ROUND_NUM.ROUND_THREE do
		self:getChild("Comp_3_" .. iter_7_3):updateIcon({
			round = 4,
			data = self._teamMap[var_7_3[iter_7_3]]
		})
	end

	for iter_7_4 = 1, var_0_2.ROUND_NUM.ROUND_FOUR do
		self:getChild("Comp_4_" .. iter_7_4):updateIcon({
			round = 5,
			data = self._teamMap[var_7_4[iter_7_4]]
		})
	end
end

function var_0_0:_updateAgainstLine()
	local var_8_0 = self._roundMap[1] or {}
	local var_8_1 = self._roundMap[2] or {}
	local var_8_2 = self._roundMap[3] or {}
	local var_8_3 = self._roundMap[4] or {}

	if not self._roundMap[5] then
		-- block empty
	end

	local var_8_5 = self.m_stateController:getSelectedIndex()

	for iter_8_0 = 1, 5 do
		self:getChild("Comp_line_left_" .. iter_8_0):updateLine(var_8_5 < 1 and 2 or 1, false)
		self:getChild("Comp_line_right_" .. iter_8_0):updateLine(var_8_5 < 1 and 2 or 1, false)
	end

	for iter_8_1 = 1, var_0_2.ROUND_NUM.ROUND_ZERO do
		local var_8_7, var_8_8 = g.core.model.User.ancientsData:getPromoteLineStateByTeamId(1, (self._teamMap[var_8_0[iter_8_1]] or nil) and (self._teamMap[var_8_0[iter_8_1]].team_id or 0))

		self:getChild("Comp_line_0_" .. iter_8_1):updateLine(var_8_7, false)
	end

	for iter_8_2 = 1, var_0_2.ROUND_NUM.ROUND_ONE do
		local var_8_10, var_8_11 = g.core.model.User.ancientsData:getPromoteLineStateByTeamId(2, (self._teamMap[var_8_1[iter_8_2]] or nil) and (self._teamMap[var_8_1[iter_8_2]].team_id or 0))

		self:getChild("Comp_line_1_" .. iter_8_2):updateLine(var_8_10, var_8_11)

		if iter_8_2 % 2 == 0 and var_8_10 ~= 2 then
			self:getChild("Comp_line_merge_1_" .. iter_8_2 / 2):updateLine(1)
		elseif iter_8_2 % 2 == 0 and var_8_10 == 2 then
			self:getChild("Comp_line_merge_1_" .. iter_8_2 / 2):updateLine(2)
		end
	end

	for iter_8_3 = 1, var_0_2.ROUND_NUM.ROUND_TWO do
		local var_8_13, var_8_14 = g.core.model.User.ancientsData:getPromoteLineStateByTeamId(3, (self._teamMap[var_8_2[iter_8_3]] or nil) and (self._teamMap[var_8_2[iter_8_3]].team_id or 0))

		self:getChild("Comp_line_2_" .. iter_8_3):updateLine(var_8_13, var_8_14)

		if iter_8_3 % 2 == 0 and var_8_13 ~= 2 then
			self:getChild("Comp_line_merge_2_" .. iter_8_3 / 2):updateLine(1)
		elseif iter_8_3 % 2 == 0 and var_8_13 == 2 then
			self:getChild("Comp_line_merge_2_" .. iter_8_3 / 2):updateLine(2)
		end
	end

	for iter_8_4 = 1, var_0_2.ROUND_NUM.ROUND_THREE do
		local var_8_16, var_8_17 = g.core.model.User.ancientsData:getPromoteLineStateByTeamId(4, (self._teamMap[var_8_3[iter_8_4]] or nil) and (self._teamMap[var_8_3[iter_8_4]].team_id or 0))

		self:getChild("Comp_line_3_" .. iter_8_4):updateLine(var_8_16, var_8_17)
	end
end

function var_0_0._onClickBtnMyTeam(arg_9_0)
	if g.core.model.User.ancientsData:hasFinalFightQualification() then
		if g.core.model.User.ancientsData:getTeam(var_0_2.GET_TEAM_TYPE.FINAL_TEAM) == nil then
			g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_COOP_MAIN_LAYER)
		else
			g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_MAIN_LAYER)
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(433378))
	end
end

function var_0_0._onClickBtnGuess(arg_10_0)
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_GUESS_POP)
end

function var_0_0._onClickBtnShop(arg_11_0)
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.ANCIENTS
	})
end

function var_0_0._onClickBtnReward(arg_12_0)
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_FINAL_RANK_LAYER)
end

function var_0_0:_onClickBtnChain()
	g.core.model.User.giftData:refreshInTime()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.shop.view.ShopActivityGiftPop").new({
		activityValue = g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.ANCIENTS_ACTIVITY,
		shopValue = g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.ANCIENTS_ACTIVITY,
		openCheckFunc = handler(self, function(arg_14_0)
			return g.core.model.User.ancientsData:isTimeToOpen()
		end),
		title = self.m_Btn_chain:getTitle()
	})))
end

function var_0_0._onClickBtnRank(arg_15_0)
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_POINTS_RANK_LAYER)
end

return var_0_0
