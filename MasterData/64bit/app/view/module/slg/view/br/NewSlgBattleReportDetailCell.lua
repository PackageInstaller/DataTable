local var_0_1 = g.core.const.ConstMgr.NewSlgConst.REPORT
local NewSlgBattleReportDetailCell = class("NewSlgBattleReportDetailCell", require("app.fairyGUI.newSlg.UI_NewSlgBattleReportDetailCell"))

function NewSlgBattleReportDetailCell:ctor()
	self._reportInfo = nil
	self._idx = nil
end

function NewSlgBattleReportDetailCell:_getAllTroopsDecByIdx(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = 0

	arg_2_3 = arg_2_3 or arg_2_1 - 1

	local var_2_1 = 0

	for iter_2_0 = 1, arg_2_1 do
		local var_2_2

		if #self._reportInfo.battles < iter_2_0 then
			var_2_2 = self._reportInfo.battles2[iter_2_0 - #self._reportInfo.battles] or self._reportInfo.battles[iter_2_0]
		end

		local var_2_3
		local var_2_4

		if var_2_2.is_win then
			var_2_3 = var_2_2.atk_team
			var_2_4 = self:_getTeamByTeamId(false, var_2_2.def_team)
		else
			var_2_3 = var_2_2.def_team
			var_2_4 = self:_getTeamByTeamId(true, var_2_2.atk_team)
		end

		if var_2_3 == arg_2_2 then
			var_2_0 = var_2_0 + var_2_2.troops_dec
		elseif iter_2_0 == arg_2_1 then
			var_2_0 = var_2_4.max_troops - var_2_0
		end

		if iter_2_0 == arg_2_3 then
			var_2_1 = var_2_0
		end
	end

	return var_2_0, var_2_1 - var_2_0, var_2_1
end

function NewSlgBattleReportDetailCell:updateReportDetailInfo(arg_3_1, arg_3_2)
	self._idx = arg_3_2
	self._reportInfo = arg_3_1

	if not self._idx then
		self:updateBattleSnapShot()
	else
		self:updateOneBattle()
	end
end

function NewSlgBattleReportDetailCell:updateBattleSnapShot()
	self.m_showAtkTipController:setSelectedIndex(1)
	self:_updateTitle()

	local var_4_0 = g.core.common.ServerTime:getDateObject(self._reportInfo.start_tm)

	self.m_timeTxt:setText((g.core.lang:get(429545, {
		month = var_4_0.month,
		day = var_4_0.day,
		hour = var_4_0.hour,
		min = var_4_0.min
	})))
	self.m_tipTxt:setText("")
	self.m_atkComp:updateComp(self._reportInfo.final_atk_team, {
		cur = math.floor(self._reportInfo.final_battle.atk_left_troops),
		max = self._reportInfo.final_atk_team.max_troops,
		dis = -(self._reportInfo.final_battle.atk_init_troops - self._reportInfo.final_battle.atk_left_troops),
		finalAuthority = self._reportInfo.final_battle.atk_final_authority,
		authority_rate_add = self._reportInfo.final_battle.atk_authority_rate_add,
		authority_rate_dec = self._reportInfo.final_battle.atk_authority_rate_dec
	}, self._reportInfo)
	self.m_defComp:updateComp(self._reportInfo.final_def_team, {
		cur = math.floor(self._reportInfo.final_battle.def_left_troops),
		max = self._reportInfo.final_def_team.max_troops,
		dis = -(self._reportInfo.final_battle.def_init_troops - self._reportInfo.final_battle.def_left_troops),
		finalAuthority = self._reportInfo.final_battle.def_final_authority,
		authority_rate_add = self._reportInfo.final_battle.def_authority_rate_add,
		authority_rate_dec = self._reportInfo.final_battle.def_authority_rate_dec
	}, self._reportInfo)

	if self._reportInfo.is_win then
		self.m_isWinController:setSelectedIndex(0)
	else
		self.m_isWinController:setSelectedIndex(1)
	end
end

function NewSlgBattleReportDetailCell:updateOneBattle()
	local var_5_0 = self._reportInfo.is_win
	local var_5_1

	if self._idx then
		local var_5_2 = self._reportInfo.detail.battles
		local var_5_3 = self._idx

		if self._idx > #self._reportInfo.detail.battles then
			var_5_3 = var_5_3 - #var_5_2
			var_5_2 = self._reportInfo.detail.battles2
		end

		var_5_1 = var_5_2[var_5_3]
		var_5_0 = var_5_2[var_5_3].is_win

		self.m_title:setText(g.core.lang:get(428959, {
			index = self._idx
		}))
		self.m_timeTxt:setText("")
		self.m_showAtkTipController:setSelectedIndex(0)
	end

	if not var_5_0 and self._idx then
		self.m_tipTxt:setText(g.core.lang:get(429583))
	end

	local var_5_4

	for iter_5_0, iter_5_1 in ipairs(self._reportInfo.detail.atk_teams) do
		if iter_5_1.team_id == var_5_1.atk_team then
			var_5_4 = iter_5_1

			break
		end
	end

	local var_5_5

	for iter_5_2, iter_5_3 in ipairs(self._reportInfo.detail.def_teams) do
		if iter_5_3.team_id == var_5_1.def_team then
			var_5_5 = iter_5_3

			break
		end
	end

	local var_5_6 = var_5_1.atk_left_troops

	self.m_tipTxt:setText("")
	self.m_atkComp:updateComp(var_5_4, {
		cur = math.floor(var_5_6),
		max = var_5_4.max_troops,
		dis = -(var_5_1.atk_init_troops - var_5_1.atk_left_troops),
		finalAuthority = var_5_1.atk_final_authority,
		authority_rate_add = var_5_1.def_authority_rate_add,
		authority_rate_dec = var_5_1.def_authority_rate_dec
	}, self._reportInfo)
	self.m_defComp:updateComp(var_5_5, {
		cur = math.floor(var_5_1.def_left_troops),
		max = var_5_5.max_troops,
		dis = -(var_5_1.def_init_troops - var_5_1.def_left_troops),
		finalAuthority = var_5_1.def_final_authority,
		authority_rate_add = var_5_1.def_authority_rate_add,
		authority_rate_dec = var_5_1.def_authority_rate_dec
	}, self._reportInfo)

	if var_5_0 then
		self.m_isWinController:setSelectedIndex(0)
	else
		self.m_isWinController:setSelectedIndex(1)
	end
end

function NewSlgBattleReportDetailCell:_getTeamByTeamId(arg_6_1, arg_6_2)
	local var_6_0

	if arg_6_1 then
		for iter_6_0, iter_6_1 in ipairs(self._reportInfo.atk_teams) do
			if iter_6_1.team_id == arg_6_2 then
				var_6_0 = iter_6_1

				break
			end
		end
	else
		for iter_6_2, iter_6_3 in ipairs(self._reportInfo.def_teams) do
			if iter_6_3.team_id == arg_6_2 then
				var_6_0 = iter_6_3

				break
			end
		end
	end

	return var_6_0
end

function NewSlgBattleReportDetailCell:_updateTitle()
	local var_7_0 = ""

	if self._reportInfo.report_type == var_0_1.SVR_TYPE.NEW_SLG_REPORT_TYPE_MONSTER then
		local var_7_1 = g.core.config.new_slg_monster_info.get(self._reportInfo.def_id, g.core.model.User.newSlgData:getSlgInfo().monster_group)

		var_7_0 = table.concat({
			table.concat({
				g.core.lang:get(302516, {
					level = var_7_1.level
				}),
				var_7_1.name
			}, ""),
			(table.concat({
				"(",
				table.concat({
					self._reportInfo.def_axis.x,
					self._reportInfo.def_axis.y
				}, ","),
				")"
			}, ""))
		}, " ")
	elseif self._reportInfo.report_type == var_0_1.SVR_TYPE.NEW_SLG_REPORT_TYPE_TEAM then
		local var_7_2 = g.core.config.new_slg_boss_info.get(self._reportInfo.def_id)

		var_7_0 = table.concat({
			g.core.lang:get(302516, {
				level = var_7_2.level
			}),
			var_7_2.name
		}, "")
	elseif self._reportInfo.report_type == var_0_1.SVR_TYPE.NEW_SLG_REPORT_TYPE_CITY then
		local var_7_3 = g.core.config.new_slg_city_info.get(self._reportInfo.def_id)

		var_7_0 = table.concat({
			g.core.lang:get(302516, {
				level = var_7_3.level
			}),
			var_7_3.name
		}, "")
	elseif self._reportInfo.report_type == var_0_1.SVR_TYPE.NEW_SLG_REPORT_TYPE_FARM then
		local var_7_4 = g.core.config.new_slg_farm_info.get(self._reportInfo.def_id)

		var_7_0 = table.concat({
			g.core.lang:get(302516, {
				level = var_7_4.level
			}),
			var_7_4.name
		}, "")
	end

	self.m_title:setText(var_7_0)
end

function NewSlgBattleReportDetailCell:_onClickMine()
	if self._userId > 0 then
		if g.core.model.User:getId() == self._userId then
			g.core.module.ModuleManager:tip(g.core.lang:get(429011))
		else
			self:addPopup(require("app.view.friend.FriendPalyerInfoPop").new(0, self._userId), {
				hideContinue = true,
				touchDisappear = true
			})
		end
	end
end

return NewSlgBattleReportDetailCell
