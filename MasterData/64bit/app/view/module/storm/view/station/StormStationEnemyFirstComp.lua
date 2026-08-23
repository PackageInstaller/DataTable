local StormStationEnemyFirstComp = class("StormStationEnemyFirstComp", require("app.fairyGUI.storm.UI_StormStationEnemyFirstComp"))

function StormStationEnemyFirstComp:ctor()
	self.m_touchBg:addClickListener(handler(self, self.onChallengeClick))
	self.m_touchKnight:addClickListener(handler(self, self._onClickIcon))

	self._idleTrans = nil
end

function StormStationEnemyFirstComp:onLoad()
	if self.m_rankController:getSelectedIndex() == 0 and not self._idleTrans then
		self._idleTrans = self.m_effFirst:addEffectSpine({
			anim = "play",
			isLoop = true,
			name = "eff_ui_storm_frist"
		})
	end
end

function StormStationEnemyFirstComp:_onClickIcon(arg_3_1)
	if not self._params then
		return
	end

	if not self._params.user then
		if self._params.robotId and self._params.robotId > 0 then
			return
		end

		if self:checkIsSelf() then
			g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
				isSelf = true
			})

			goto label_3_0
		end
	end

	do
		local var_3_1

		if arg_3_1 then
			var_3_1 = {}

			local var_3_2 = arg_3_1:getInput():getTouch()

			var_3_1.x = var_3_2:getLocationInView().x
			var_3_1.y = var_3_2:getLocationInView().y
		end

		local var_3_3 = self:_checkAndGetPopInfo(self._params.user)

		var_3_3.clickWorldPos = var_3_1

		self:addPopup(require("app.view.base.infoPop.InfoUserMenuPop").new(var_3_3), {
			isUpdateBlack = false,
			hideContinue = true
		})
	end

	::label_3_0::
end

function StormStationEnemyFirstComp:_checkAndGetPopInfo(arg_4_1)
	local var_4_0 = {}
	local var_4_1 = {
		user = clone(arg_4_1)
	}

	if var_4_1.user.guild_id and var_4_1.user.guild_id == 0 then
		var_4_1.user.guild_id = -1
	end

	var_4_0.playerInfo = var_4_1

	return var_4_0
end

function StormStationEnemyFirstComp:updateData(arg_5_1, arg_5_2)
	if not arg_5_1 then
		return
	end

	self._currentCity = arg_5_2
	self._params = arg_5_1

	local var_5_0

	if not arg_5_1.user then
		var_5_0 = arg_5_1.robotId and arg_5_1.robotId > 0
	end

	local var_5_1 = ""
	local var_5_2 = 0
	local var_5_4 = 0
	local var_5_6 = g.core.model.User.stormCityData:getOfficialInfoByRank(arg_5_1.rank)

	if var_5_6 then
		self.m_titleTxt:setText(var_5_6.name)
		self.m_rankIcon:setURL((g.core.common.Path:getOfficialIcon(var_5_6.res)))
	end

	if not var_5_0 then
		if not arg_5_1.user or arg_5_1.user.base_id <= 0 then
			return
		end

		self._roleId = arg_5_1.user.id
		self._user = arg_5_1.user
		var_5_1 = arg_5_1.user.name or ""
		var_5_2 = arg_5_1.user.fight_value

		local var_5_7 = g.core.config.knight_info.get(arg_5_1.user.base_id).quality
		local var_5_8 = g.core.config.storm_city_lord_info.fetch(arg_5_1.user.storm_city_lord)

		if var_5_8 then
			self.m_titleTxt:setText(var_5_8.name)
			self.m_rankIcon:setURL((g.core.common.Path:getOfficialIcon(var_5_8.res)))
		end

		var_5_2 = arg_5_1.user.fight_value
		var_5_1 = arg_5_1.user.name
		var_5_4 = arg_5_1.user.level

		self.m_knightIcon:updateAsUser(arg_5_1.user)
	else
		self._roleId = arg_5_1.robotId

		local var_5_9 = g.core.config.robot_info.get(arg_5_1.robotId)

		var_5_2 = var_5_9.fight_power
		var_5_1 = var_5_9.name
		var_5_4 = var_5_9.level

		self:_packRobotUser(var_5_9)

		if var_5_9.res_id then
			local var_5_10 = g.core.config.knight_info.fetch(var_5_9.res_id)

			if var_5_10 then
				self.m_knightIcon:justSetIcon((g.core.common.Path:getKnightIconById(g.core.config.knight_base_info.get(var_5_10.advance_id).icon_id)))
			end
		end
	end

	self._rank = arg_5_1.rank
	self._canChallenge = arg_5_1.canChallenge

	self.m_levelTxt:setText(g.core.lang:get(304601, {
		lv = var_5_4
	}))
	self.m_nameTxt:setText(var_5_1)
	self.m_fightValueTxt:setText(var_5_2)
end

function StormStationEnemyFirstComp:_packRobotUser(arg_6_1)
	self._user = {
		robot_type = 1,
		base_id = arg_6_1.id
	}
end

function StormStationEnemyFirstComp:checkIsSelf()
	if not self._roleId then
		return false
	end

	return math.uint64_equal(self._roleId, g.core.model.User:getId())
end

function StormStationEnemyFirstComp:onChallengeClick()
	if g.core.model.User.stormCityData:isClose() then
		g.core.module.ModuleManager:tip(g.core.model.User.stormCityData:getCoolTimeTxt())
	elseif g.core.model.User.stormCityData:isNotOpen() then
		g.core.module.ModuleManager:tip(g.core.model.User.stormCityData:getCoolTimeTxt())
	elseif self:checkIsSelf() then
		g.core.module.ModuleManager:tip(g.core.lang:get(304603))
	elseif not self._canChallenge then
		g.core.module.ModuleManager:tip(g.core.lang:get(304605))
	elseif g.core.model.User.shopData:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.STORM_CITY) > 0 then
		local var_8_1 = g.core.model.User.stormCityData:getOwnCityId()

		if var_8_1 > 0 and var_8_1 ~= self._currentCity then
			g.core.module.ModuleManager:pushModule(g.view.entrance.CONFIRM_POP, {
				title = g.core.lang:get(107050),
				desc = g.core.lang:get(304604, {
					rank = g.core.model.User.stormCityData:getOwnRank(),
					city = g.core.config.storm_info.get(var_8_1).name
				}),
				onConfirm = handler(self, function()
					g.core.network.GameNetProxy:send_C2S_StormCity_ChallengeBegin({
						city = self._currentCity,
						rank = self._rank
					})
				end)
			})
		else
			g.core.network.GameNetProxy:send_C2S_StormCity_ChallengeBegin({
				city = self._currentCity,
				rank = self._rank
			})
		end
	else
		require("app.view.base.component.BaseBuyPop").createBuy(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.STORM_CITY)
	end
end

return StormStationEnemyFirstComp
