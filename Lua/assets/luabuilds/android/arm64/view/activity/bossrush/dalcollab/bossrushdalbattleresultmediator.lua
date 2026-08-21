local var_0_0 = class("BossRushDALBattleResultMediator", import("view.base.ContextMediator"))

var_0_0.ON_SETTLE = "BossRushDALBattleResultMediator:ON_SETTLE"
var_0_0.BEGIN_STAGE = "BossRushDALBattleResultMediator:BEGIN_STAGE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_SETTLE, function()
		if not arg_1_0.contextData.win then
			arg_1_0:sendNotification(GAME.GO_BACK)

			return
		end

		seriesAsync({
			function(arg_3_0)
				arg_1_0:ShowTotalAward(arg_1_0.contextData.awards)

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_0.BEGIN_STAGE, function(arg_4_0)
		local var_4_0, var_4_1 = getProxy(ActivityProxy):GetContinuousTime()

		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			system = arg_1_0.contextData.system,
			actId = arg_1_0.contextData.actId,
			continuousBattleTimes = var_4_0,
			totalBattleTimes = var_4_1
		})

		return
	end)
	arg_1_0:sendNotification(NewBattleResultMediator.ON_ENTER_BATTLE_RESULT)

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		NewBattleResultMediator.SET_SKIP_FLAG,
		GAME.BOSSRUSH_TRACE_DONE,
		GAME.BOSSRUSH_TRACE_ERROR,
		GAME.BEGIN_STAGE_DONE,
		GAME.BEGIN_STAGE_ERRO,
		ContinuousOperationMediator.ON_REENTER
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == nil then
		-- block empty
	elseif var_6_0 == GAME.BEGIN_STAGE_DONE then
		arg_6_0:sendNotification(GAME.CHANGE_SCENE, SCENE.COMBATLOAD, var_6_1)
	elseif var_6_0 == GAME.BEGIN_STAGE_ERRO then
		if var_6_1 == 3 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("battle_preCombatMediator_timeout"),
				onYes = function()
					arg_6_0.viewComponent:emit(BaseUI.ON_CLOSE)

					return
				end
			})
		end
	elseif var_6_0 == GAME.BOSSRUSH_TRACE_DONE then
		arg_6_0.viewComponent:emit(var_0_0.BEGIN_STAGE)
	elseif var_6_0 == GAME.BOSSRUSH_TRACE_ERROR then
		arg_6_0:sendNotification(GAME.GO_BACK)
	elseif var_6_0 == NewBattleResultMediator.SET_SKIP_FLAG then
		if var_6_1 then
			getProxy(ActivityProxy):UseContinuousTime()
			existCall(arg_6_0.viewComponent.HideConfirmPanel, arg_6_0.viewComponent)

			if not (function()
				local var_8_0 = getProxy(ActivityProxy):GetContinuousTime()

				if not var_8_0 or var_8_0 <= 0 then
					return
				end

				local var_8_1 = getProxy(BayProxy)

				if var_8_1:getShipCount() >= getProxy(PlayerProxy):getRawData():getMaxShipBag() then
					return
				end

				local var_8_2 = arg_6_0.contextData.seriesData
				local var_8_3 = arg_6_0.contextData.system
				local var_8_4, var_8_5 = arg_6_0.contextData.seriesData:GetModeFleetIDs(arg_6_0.contextData.seriesData.mode)
				local var_8_6 = var_8_2:GetFleets(var_8_5)[1]
				local var_8_7 = var_8_2:GetFleets(var_8_4)

				if (function()
					local var_9_1 = var_8_2:GetOilLimit()
					local var_9_2 = pg.battle_cost_template[var_8_3].oil_cost > 0
					local var_9_4 = #var_8_2:GetExpeditionIds()
					local var_9_5 = (function(arg_10_0, arg_10_1)
						local var_10_0 = 0

						if var_9_2 then
							var_10_0 = arg_10_0:GetCostSum().oil

							if arg_10_1 > 0 then
								var_10_0 = math.min(arg_10_1, var_10_0)
							end
						end

						return var_10_0
					end)(var_8_6, var_9_1[2]) * var_9_4

					for iter_9_0 = 1, var_9_4 do
						local var_9_7 = var_8_7[iter_9_0] or var_8_7[1]

						var_9_5 = var_9_5 + var_9_3(var_9_7, var_9_1[1])
					end

					return var_9_5
				end)() > getProxy(PlayerProxy):getRawData().oil then
					return
				end

				if arg_6_0.contextData.seriesData.mode == BossRushSeriesData.MODE.SINGLE and underscore.any(table.mergeArray(var_8_2:GetFleets(var_8_4), {
					var_8_2:GetFleets(var_8_5)[1]
				}), function(arg_11_0)
					return _.any(arg_11_0:GetRawShipIds(), function(arg_12_0)
						local var_12_0 = getProxy(BayProxy):RawGetShipById(arg_12_0)

						return var_12_0:getEnergy() <= pg.gameset.series_enemy_mood_limit.key_value
					end)
				end) then
					return
				end

				return true
			end)() then
				getProxy(ActivityProxy):AddBossRushAwards(arg_6_0.contextData.awards)
				arg_6_0:ShowTotalAward((getProxy(ActivityProxy):PopBossRushAwards()))

				return
			end

			arg_6_0:sendNotification(NewBattleResultMediator.ON_COMPLETE_BATTLE_RESULT)
		end
	elseif var_6_0 == ContinuousOperationMediator.ON_REENTER then
		getProxy(ActivityProxy):AddBossRushAwards(arg_6_0.contextData.awards)

		if not var_6_1.autoFlag or not arg_6_0.contextData.win then
			local var_6_2 = getProxy(ActivityProxy)

			arg_6_0:ShowTotalAward((var_6_2:PopBossRushAwards()))

			return
		end

		local var_6_3 = getProxy(ActivityProxy):GetContinuousTime()

		if var_6_3 and var_6_3 > 0 then
			arg_6_0:sendNotification(GAME.BOSSRUSH_TRACE, {
				actId = arg_6_0.contextData.actId,
				seriesId = arg_6_0.contextData.seriesData.id,
				mode = arg_6_0.contextData.seriesData.mode
			})

			return
		end

		local var_6_4 = getProxy(ActivityProxy)

		arg_6_0:ShowTotalAward((var_6_4:PopBossRushAwards()))
	end

	return
end

function var_0_0.ShowTotalAward(arg_13_0, arg_13_1)
	local var_13_9000
	local var_13_0 = getProxy(ActivityProxy)
	local var_13_1 = var_13_0.getActivityByType(var_13_9000, ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB)
	local var_13_2 = var_13_1 and var_13_1:getConfig("config_client").mediator or "BossRushDALCollabMediator"
	local var_13_3, var_13_4 = getProxy(ContextProxy).getContextByMediator(var_13_0, _G[var_13_2])
	local var_13_5, var_13_6 = getProxy(ActivityProxy):GetContinuousTime()

	var_13_4:addChild(Context.New({
		mediator = BossRushTotalRewardPanelMediator,
		viewComponent = BossRushTotalRewardPanel,
		data = {
			isLayer = true,
			rewards = arg_13_1,
			isAutoFight = arg_13_0.contextData.isAutoFight,
			totalBattleTimes = var_13_6,
			continuousBattleTimes = var_13_5
		}
	}))
	arg_13_0:sendNotification(GAME.GO_BACK)

	return
end

function var_0_0.remove(arg_14_0)
	return
end

return var_0_0
