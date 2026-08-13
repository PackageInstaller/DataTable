class = var_0_10000

local var_0_0 = "BossRushDALBattleResultMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_SETTLE = "BossRushDALBattleResultMediator:ON_SETTLE"
var_0_1.BEGIN_STAGE = "BossRushDALBattleResultMediator:BEGIN_STAGE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_SETTLE, function()
		local var_2_1

		if not arg_1_0.contextData.win then
			local var_2_0 = arg_1_0

			var_2_1 = var_2_1.sendNotification
			GAME = var_2_10003

			var_2_1(var_2_0, var_2_10003.GO_BACK)

			return
		end

		seriesAsync = var_2_1

		var_2_1({
			function(arg_3_0)
				local var_3_0 = arg_1_0

				var_1.ShowTotalAward(var_3_0, arg_1_0.contextData.awards)

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_1.BEGIN_STAGE, function(arg_4_0)
		getProxy = var_2_10001
		ActivityProxy = var_2_10003

		local var_4_0 = var_2_10001(var_2_10003)
		local var_4_1, var_4_2 = var_1.GetContinuousTime(var_4_0)
		local var_4_3 = arg_1_0
		local var_4_4 = var_3.sendNotification

		GAME = var_2_10006

		var_4_4(var_4_3, var_2_10006.BEGIN_STAGE, {
			system = arg_1_0.contextData.system,
			actId = arg_1_0.contextData.actId,
			continuousBattleTimes = var_4_1,
			totalBattleTimes = var_4_2
		})

		return
	end)

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.sendNotification

	NewBattleResultMediator = var_4

	var_1_1(var_1_0, var_4.ON_ENTER_BATTLE_RESULT)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	NewBattleResultMediator = var_1_10002
	var_5_0[1] = var_1_10002.SET_SKIP_FLAG
	GAME = var_2
	var_5_0[2] = var_2.BOSSRUSH_TRACE_DONE
	GAME = var_2
	var_5_0[3] = var_2.BOSSRUSH_TRACE_ERROR
	GAME = var_2
	var_5_0[4] = var_2.BEGIN_STAGE_DONE
	GAME = var_2
	var_5_0[5] = var_2.BEGIN_STAGE_ERRO
	ContinuousOperationMediator = var_2
	var_5_0[6] = var_2.ON_REENTER

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1
	local var_6_3 = arg_6_1.getBody(var_6_2)

	if var_6_1 == nil then
		-- block empty
	else
		GAME = var_6_0

		local var_6_4

		if var_6_1 == var_6_0.BEGIN_STAGE_DONE then
			var_1_10006 = arg_6_0
			var_6_4 = arg_6_0.sendNotification
			GAME = var_1_10007
			var_1_10007 = var_1_10007.CHANGE_SCENE
			SCENE = var_1_10008

			var_6_4(var_1_10006, var_1_10007, var_1_10008.COMBATLOAD, var_6_3)
		else
			GAME = var_6_4

			local var_6_5

			if var_6_1 == var_6_4.BEGIN_STAGE_ERRO then
				if var_6_3 == 3 then
					pg = var_6_5
					var_1_10006 = var_6_5.MsgboxMgr.GetInstance()
					var_6_5 = var_6_5.ShowMsgBox
					var_1_10007 = {
						hideNo = true
					}
					i18n = var_1_10008
					var_1_10007.content = var_1_10008("battle_preCombatMediator_timeout")

					function var_1_10007.onYes()
						local var_7_0 = arg_6_0.viewComponent
						local var_7_1 = var_0.emit

						BaseUI = var_2_10003

						var_7_1(var_7_0, var_2_10003.ON_CLOSE)

						return
					end

					var_6_5(var_1_10006, var_1_10007)
				end
			else
				GAME = var_6_5

				if var_6_1 == var_6_5.BOSSRUSH_TRACE_DONE then
					var_1_10006 = arg_6_0.viewComponent

					var_4.emit(var_1_10006, var_0_1.BEGIN_STAGE)
				else
					GAME = var_4

					local var_6_6

					if var_6_1 == var_4.BOSSRUSH_TRACE_ERROR then
						var_1_10006 = arg_6_0
						var_6_6 = arg_6_0.sendNotification
						GAME = var_1_10007

						var_6_6(var_1_10006, var_1_10007.GO_BACK)
					else
						NewBattleResultMediator = var_6_6

						if var_6_1 == var_6_6.SET_SKIP_FLAG then
							if var_6_3 then
								getProxy = var_4
								ActivityProxy = var_1_10006
								var_1_10006 = var_4(var_1_10006)

								var_4.UseContinuousTime(var_1_10006)

								existCall = var_4

								var_4(arg_6_0.viewComponent.HideConfirmPanel, arg_6_0.viewComponent)

								if not (function()
									getProxy = var_2_10000
									ActivityProxy = var_2_10002

									local var_8_0 = var_2_10000(var_2_10002)

									if not var_0.GetContinuousTime(var_8_0) or var_0 <= 0 then
										return
									end

									getProxy = var_2_10001
									BayProxy = var_2_10003

									local var_8_1 = var_2_10001(var_2_10003)
									local var_8_2 = var_1.getShipCount(var_8_1)

									getProxy = var_8_0
									PlayerProxy = var_2_10004

									local var_8_3 = var_8_0(var_2_10004)
									local var_8_4 = var_2.getRawData(var_8_3)

									if var_8_2 >= var_2.getMaxShipBag(var_8_4) then
										return
									end

									local var_8_5 = arg_6_0.contextData.seriesData
									local var_8_6 = arg_6_0.contextData.system
									local var_8_7 = arg_6_0.contextData.seriesData.mode
									local var_8_8, var_8_9 = var_8_5:GetModeFleetIDs(var_8_7)
									local var_8_10 = var_8_5:GetFleets(var_8_9)[1]
									local var_8_11 = var_8_5:GetFleets(var_8_8)
									local var_8_12 = (function()
										local var_9_0 = 0

										pg = var_3_10001

										local var_9_1 = var_3_10001.battle_cost_template[var_8_6]
										local var_9_2 = var_8_5
										local var_9_3 = var_2.GetOilLimit(var_9_2)
										local var_9_4 = var_9_1.oil_cost > 0

										local function var_9_5(arg_10_0, arg_10_1)
											local var_10_0 = 0

											if var_9_4 then
												var_10_0 = arg_10_0:GetCostSum().oil

												if 0 < arg_10_1 then
													math = var_3
													var_10_0 = var_3.min(arg_10_1, var_10_0)
												end
											end

											return var_10_0
										end

										local var_9_6 = var_8_5
										local var_9_7 = #var_5.GetExpeditionIds(var_9_6)
										local var_9_8 = var_9_5(var_8_10, var_9_3[2]) * var_9_7

										for iter_9_0 = 1, var_9_7 do
											local var_9_9 = var_9_5
											local var_9_10

											if not var_8_11[iter_9_0] then
												var_9_10 = var_8_11[1]
											end

											var_9_8 = var_9_8 + var_9_9(var_9_10, var_9_3[1])
										end

										return var_9_8
									end)()

									getProxy = var_11
									PlayerProxy = var_2_10013

									local var_8_13 = var_11(var_2_10013)

									if var_11.getRawData(var_8_13).oil < var_8_12 then
										return
									end

									BossRushSeriesData = var_11

									if var_8_7 == var_11.MODE.SINGLE then
										underscore = var_11

										local var_8_14 = var_11.any

										table = var_8_13

										if var_8_14(var_8_13.mergeArray(var_8_11, {
											var_8_10
										}), function(arg_11_0)
											_ = var_3_10001

											return var_3_10001.any(arg_11_0:GetRawShipIds(), function(arg_12_0)
												getProxy = var_4_10001
												BayProxy = var_4_10003

												local var_12_0 = var_4_10001(var_4_10003)
												local var_12_1 = var_1.RawGetShipById(var_12_0, arg_12_0)
												local var_12_2 = var_1.getEnergy(var_12_1)

												pg = var_12_0

												return var_12_2 <= var_12_0.gameset.series_enemy_mood_limit.key_value
											end)
										end) then
											return
										end
									end

									return true
								end)() then
									getProxy = var_6_2
									ActivityProxy = var_7

									local var_6_7 = var_6_2(var_7)

									var_6_2.AddBossRushAwards(var_6_7, arg_6_0.contextData.awards)

									getProxy = var_6_2
									ActivityProxy = var_6_7

									local var_6_8 = var_6_2(var_6_7)

									var_6_2 = var_6_2.PopBossRushAwards(var_6_8)
									var_1_10008 = arg_6_0

									arg_6_0.ShowTotalAward(var_1_10008, var_6_2)

									return
								end

								local var_6_9 = arg_6_0

								var_6_2 = arg_6_0.sendNotification
								NewBattleResultMediator = var_1_10008

								var_6_2(var_6_9, var_1_10008.ON_COMPLETE_BATTLE_RESULT)
							end
						else
							ContinuousOperationMediator = var_4

							if var_6_1 == var_4.ON_REENTER then
								getProxy = var_4
								ActivityProxy = var_1_10006

								local var_6_10 = var_4(var_1_10006)

								var_4.AddBossRushAwards(var_6_10, arg_6_0.contextData.awards)

								local var_6_11, var_6_12

								if not var_6_3.autoFlag or not arg_6_0.contextData.win then
									getProxy = var_6_11
									ActivityProxy = var_6_10
									var_6_10 = var_6_11(var_6_10)
									var_6_11 = var_6_11.PopBossRushAwards(var_6_10)
									var_6_12 = arg_6_0

									arg_6_0.ShowTotalAward(var_6_12, var_6_11)

									return
								end

								getProxy = var_6_11
								ActivityProxy = var_6_10

								local var_6_13 = var_6_11(var_6_10)

								if var_4.GetContinuousTime(var_6_13) and 0 < var_4 then
									var_6_12 = arg_6_0
									var_6_2 = arg_6_0.sendNotification
									GAME = var_1_10008

									var_6_2(var_6_12, var_1_10008.BOSSRUSH_TRACE, {
										actId = arg_6_0.contextData.actId,
										seriesId = arg_6_0.contextData.seriesData.id,
										mode = arg_6_0.contextData.seriesData.mode
									})

									return
								end

								getProxy = var_6_2
								ActivityProxy = var_6_12

								local var_6_14 = var_6_2(var_6_12)
								local var_6_15 = var_5.PopBossRushAwards(var_6_14)

								arg_6_0:ShowTotalAward(var_6_15)
							end
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.ShowTotalAward(arg_13_0, arg_13_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_13_0 = var_1_10002(var_1_10004)
	local var_13_1 = var_2.getActivityByType

	ActivityConst = var_1_10005

	local var_13_2

	if not var_13_1(var_13_0, var_1_10005.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB) or not var_2:getConfig("config_client").mediator then
		var_13_2 = "BossRushDALCollabMediator"
	end

	getProxy = var_13_0
	ContextProxy = var_1_10006

	local var_13_3 = var_13_0(var_1_10006)
	local var_13_4 = var_4.getContextByMediator

	_G = var_1_10007

	local var_13_5, var_13_6 = var_13_4(var_13_3, var_1_10007[var_13_2])

	getProxy = var_13_3
	ActivityProxy = var_1_10008

	local var_13_7 = var_13_3(var_1_10008)
	local var_13_8, var_13_9 = var_6.GetContinuousTime(var_13_7)
	local var_13_10 = var_13_6
	local var_13_11 = var_13_6.addChild

	Context = var_1_10011

	local var_13_12 = var_1_10011.New
	local var_13_13 = {}

	BossRushTotalRewardPanelMediator = var_1_10014
	var_13_13.mediator = var_1_10014
	BossRushTotalRewardPanel = var_1_10014
	var_13_13.viewComponent = var_1_10014
	var_13_13.data = {
		isLayer = true,
		rewards = arg_13_1,
		isAutoFight = arg_13_0.contextData.isAutoFight,
		totalBattleTimes = var_13_9,
		continuousBattleTimes = var_13_8
	}

	var_13_11(var_13_10, var_13_12(var_13_13))

	local var_13_14 = arg_13_0
	local var_13_15 = arg_13_0.sendNotification

	GAME = var_11

	var_13_15(var_13_14, var_11.GO_BACK)

	return
end

function var_0_1.remove(arg_14_0)
	return
end

return var_0_1
