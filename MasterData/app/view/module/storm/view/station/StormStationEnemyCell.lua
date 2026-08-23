local StormStationEnemyCell = class("StormStationEnemyCell", require("app.fairyGUI.storm.UI_StormStationEnemyCell"))

function StormStationEnemyCell:ctor()
	self.getSharedTrans(self, "enter_down", "CommonLongCellList", self)
	self:addClickListener(handler(self, self.onChallengeClick))
end

function StormStationEnemyCell:updateData(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	self._currentCity = arg_2_2

	local var_2_0

	if not arg_2_1.user then
		var_2_0 = arg_2_1.robotId and arg_2_1.robotId > 0
	end

	local var_2_1 = ""
	local var_2_2 = 0
	local var_2_4 = 0
	local var_2_5
	local var_2_6 = ""
	local var_2_7 = g.core.model.User.stormCityData:getOfficialInfoByRank(arg_2_1.rank)

	if var_2_7 then
		var_2_6 = var_2_7.name

		self.m_rankIcon:setURL((g.core.common.Path:getOfficialIcon(var_2_7.res)))
	end

	if not var_2_0 then
		if not arg_2_1.user or arg_2_1.user.base_id <= 0 then
			return
		end

		self._roleId = arg_2_1.user.id
		self._user = arg_2_1.user
		var_2_1 = arg_2_1.user.name or ""
		var_2_2 = arg_2_1.user.fight_value

		local var_2_8 = g.core.config.knight_info.get(arg_2_1.user.base_id).quality
		local var_2_9 = g.core.config.storm_city_lord_info.fetch(arg_2_1.user.storm_city_lord)

		if var_2_9 then
			var_2_6 = var_2_9.name

			self.m_rankIcon:setURL((g.core.common.Path:getOfficialIcon(var_2_9.res)))
		end

		var_2_2 = arg_2_1.user.fight_value
		var_2_1 = arg_2_1.user.name
		var_2_4 = arg_2_1.user.level
		var_2_5 = arg_2_1.user.show_knight_id
	else
		self._roleId = arg_2_1.robotId

		local var_2_10 = g.core.config.robot_info.get(arg_2_1.robotId)

		var_2_2 = var_2_10.fight_power
		var_2_1 = var_2_10.name
		var_2_4 = var_2_10.level
		var_2_5 = var_2_10.res_id

		self:_packRobotUser(var_2_10)
	end

	self._rank = arg_2_1.rank

	self.m_rankTxt:setText(self._rank)

	self._canChallenge = arg_2_1.canChallenge

	self.m_lvNameTxt:setText(g.core.lang:get(304602, {
		lv = var_2_4,
		name = var_2_1
	}))
	self.m_fightValueTxt:setText(var_2_2)
	self.m_titleTxt:setText(var_2_6)

	if var_2_5 then
		self.m_roleIcon:setURL((g.core.common.Path:getKnightIconById(g.core.config.knight_base_info.get(g.core.config.knight_info.get(var_2_5).advance_id).icon_id)))
	end
end

function StormStationEnemyCell:_packRobotUser(arg_3_1)
	self._user = {
		robot_type = 1,
		base_id = arg_3_1.id
	}
end

function StormStationEnemyCell:checkIsSelf()
	return math.uint64_equal(self._roleId, g.core.model.User:getId())
end

function StormStationEnemyCell:onChallengeClick()
	if g.core.model.User.stormCityData:isClose() then
		g.core.module.ModuleManager:tip(g.core.model.User.stormCityData:getCoolTimeTxt())
	elseif g.core.model.User.stormCityData:isNotOpen() then
		g.core.module.ModuleManager:tip(g.core.model.User.stormCityData:getCoolTimeTxt())
	elseif self:checkIsSelf() then
		g.core.module.ModuleManager:tip(g.core.lang:get(304603))
	elseif not self._canChallenge then
		g.core.module.ModuleManager:tip(g.core.lang:get(304605))
	elseif g.core.model.User.shopData:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.STORM_CITY) > 0 then
		local var_5_1 = g.core.model.User.stormCityData:getOwnCityId()

		if var_5_1 > 0 and var_5_1 ~= self._currentCity then
			g.core.module.ModuleManager:pushModule(g.view.entrance.CONFIRM_POP, {
				title = g.core.lang:get(107050),
				desc = g.core.lang:get(304604, {
					rank = g.core.model.User.stormCityData:getOwnRank(),
					city = g.core.config.storm_info.get(var_5_1).name
				}),
				onConfirm = handler(self, function()
					g.core.network.GameNetProxy:send_C2S_StormCity_ChallengeBegin({
						city = self._currentCity,
						rank = self._rank
					})
				end)
			})
		else
			self.m_effClick:addEffectSpine({
				anim = "play",
				name = "eff_ui_storm_click",
				isLoop = false,
				remove = true,
				eventHandler = handler(self, self._onEventHandler)
			})
		end
	else
		require("app.view.base.component.BaseBuyPop").createBuy(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.STORM_CITY)
	end
end

function StormStationEnemyCell:_onEventHandler(arg_7_1)
	if arg_7_1.type == "complete" then
		g.core.network.GameNetProxy:send_C2S_StormCity_ChallengeBegin({
			city = self._currentCity,
			rank = self._rank
		})
	end
end

return StormStationEnemyCell
