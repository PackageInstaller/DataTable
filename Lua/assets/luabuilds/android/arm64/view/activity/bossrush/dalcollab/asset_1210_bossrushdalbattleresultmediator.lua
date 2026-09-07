local BossRushDALBattleResultMediator = class("BossRushDALBattleResultMediator", import("view.base.ContextMediator"))

BossRushDALBattleResultMediator.ON_SETTLE = "BossRushDALBattleResultMediator:ON_SETTLE"
BossRushDALBattleResultMediator.BEGIN_STAGE = "BossRushDALBattleResultMediator:BEGIN_STAGE"

function BossRushDALBattleResultMediator:register()
	self:bind(BossRushDALBattleResultMediator.ON_SETTLE, function()
		if not self.contextData.win then
			self:sendNotification(GAME.GO_BACK)

			return
		end

		seriesAsync({
			function(arg_3_0)
				self:ShowTotalAward(self.contextData.awards)

				return
			end
		})

		return
	end)
	self:bind(BossRushDALBattleResultMediator.BEGIN_STAGE, function(arg_4_0)
		local var_4_0, var_4_1 = getProxy(ActivityProxy):GetContinuousTime()

		self:sendNotification(GAME.BEGIN_STAGE, {
			system = self.contextData.system,
			actId = self.contextData.actId,
			continuousBattleTimes = var_4_0,
			totalBattleTimes = var_4_1
		})

		return
	end)
	self:sendNotification(NewBattleResultMediator.ON_ENTER_BATTLE_RESULT)

	return
end

function BossRushDALBattleResultMediator:listNotificationInterests()
	return {
		NewBattleResultMediator.SET_SKIP_FLAG,
		GAME.BOSSRUSH_TRACE_DONE,
		GAME.BOSSRUSH_TRACE_ERROR,
		GAME.BEGIN_STAGE_DONE,
		GAME.BEGIN_STAGE_ERRO,
		ContinuousOperationMediator.ON_REENTER
	}
end

function BossRushDALBattleResultMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == nil then
		-- block empty
	elseif var_6_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.CHANGE_SCENE, SCENE.COMBATLOAD, var_6_1)
	elseif var_6_0 == GAME.BEGIN_STAGE_ERRO then
		if var_6_1 == 3 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("battle_preCombatMediator_timeout"),
				onYes = function()
					self.viewComponent:emit(BaseUI.ON_CLOSE)

					return
				end
			})
		end
	elseif var_6_0 == GAME.BOSSRUSH_TRACE_DONE then
		self.viewComponent:emit(BossRushDALBattleResultMediator.BEGIN_STAGE)
	elseif var_6_0 == GAME.BOSSRUSH_TRACE_ERROR then
		self:sendNotification(GAME.GO_BACK)
	elseif var_6_0 == NewBattleResultMediator.SET_SKIP_FLAG then
		if var_6_1 then
			getProxy(ActivityProxy):UseContinuousTime()
			existCall(self.viewComponent.HideConfirmPanel, self.viewComponent)

			if not (function()
				local var_8_0 = getProxy(ActivityProxy):GetContinuousTime()

				if not var_8_0 or var_8_0 <= 0 then
					return
				end

				if getProxy(BayProxy):getShipCount() >= getProxy(PlayerProxy):getRawData():getMaxShipBag() then
					return
				end

				local var_8_1 = self.contextData.seriesData
				local var_8_2 = self.contextData.system
				local var_8_3, var_8_4 = self.contextData.seriesData:GetModeFleetIDs(self.contextData.seriesData.mode)
				local var_8_5 = var_8_1:GetFleets(var_8_4)[1]
				local var_8_6 = var_8_1:GetFleets(var_8_3)

				if (function()
					local var_9_1 = var_8_1:GetOilLimit()
					local var_9_2 = pg.battle_cost_template[var_8_2].oil_cost > 0

					local function var_9_3(arg_10_0, arg_10_1)
						local var_10_0 = 0

						if var_9_2 then
							var_10_0 = arg_10_0:GetCostSum().oil

							if arg_10_1 > 0 then
								var_10_0 = math.min(arg_10_1, var_10_0)
							end
						end

						return var_10_0
					end

					local var_9_4 = #var_8_1:GetExpeditionIds()
					local var_9_5 = var_9_3(var_8_5, var_9_1[2]) * var_9_4

					for iter_9_0 = 1, var_9_4 do
						var_9_5 = var_9_5 + var_9_3(var_8_6[iter_9_0] or var_8_6[1], var_9_1[1])
					end

					return var_9_5
				end)() > getProxy(PlayerProxy):getRawData().oil then
					return
				end

				if self.contextData.seriesData.mode == BossRushSeriesData.MODE.SINGLE and underscore.any(table.mergeArray(var_8_6, {
					var_8_5
				}), function(arg_11_0)
					return _.any(arg_11_0:GetRawShipIds(), function(arg_12_0)
						return getProxy(BayProxy):RawGetShipById(arg_12_0):getEnergy() <= pg.gameset.series_enemy_mood_limit.key_value
					end)
				end) then
					return
				end

				return true
			end)() then
				getProxy(ActivityProxy):AddBossRushAwards(self.contextData.awards)
				self:ShowTotalAward((getProxy(ActivityProxy):PopBossRushAwards()))

				return
			end

			self:sendNotification(NewBattleResultMediator.ON_COMPLETE_BATTLE_RESULT)
		end
	elseif var_6_0 == ContinuousOperationMediator.ON_REENTER then
		getProxy(ActivityProxy):AddBossRushAwards(self.contextData.awards)

		if not var_6_1.autoFlag or not self.contextData.win then
			self:ShowTotalAward((getProxy(ActivityProxy):PopBossRushAwards()))

			return
		end

		local var_6_2 = getProxy(ActivityProxy):GetContinuousTime()

		if var_6_2 and var_6_2 > 0 then
			self:sendNotification(GAME.BOSSRUSH_TRACE, {
				actId = self.contextData.actId,
				seriesId = self.contextData.seriesData.id,
				mode = self.contextData.seriesData.mode
			})

			return
		end

		self:ShowTotalAward((getProxy(ActivityProxy):PopBossRushAwards()))
	end

	return
end

function BossRushDALBattleResultMediator:ShowTotalAward(arg_13_1)
	local var_13_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB)
	local var_13_1, var_13_2 = getProxy(ContextProxy):getContextByMediator(_G[var_13_0 and var_13_0:getConfig("config_client").mediator or "BossRushDALCollabMediator"])
	local var_13_3, var_13_4 = getProxy(ActivityProxy):GetContinuousTime()

	var_13_2:addChild(Context.New({
		mediator = BossRushTotalRewardPanelMediator,
		viewComponent = BossRushTotalRewardPanel,
		data = {
			isLayer = true,
			rewards = arg_13_1,
			isAutoFight = self.contextData.isAutoFight,
			totalBattleTimes = var_13_4,
			continuousBattleTimes = var_13_3
		}
	}))
	self:sendNotification(GAME.GO_BACK)

	return
end

function BossRushDALBattleResultMediator:remove()
	return
end

return BossRushDALBattleResultMediator
