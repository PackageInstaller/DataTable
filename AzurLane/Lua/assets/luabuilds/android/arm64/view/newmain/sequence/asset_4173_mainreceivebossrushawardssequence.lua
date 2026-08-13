class = var_0_10000

local var_0_0 = var_0_10000("MainReceiveBossRushAwardsSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_2_0)
			getProxy = var_2_10001
			ActivityProxy = var_2_10003

			local var_2_0 = var_2_10001(var_2_10003)
			local var_2_2

			if not var_1.GetBossRushActivitity(var_2_0, false) then
				getProxy = var_2_10002
				ActivityProxy = var_4

				local var_2_1 = var_2_10002(var_4)

				var_2_10002 = var_2_10002.getActivityByType
				ActivityConst = var_2_10005
				var_2_2 = var_2_10002(var_2_1, var_2_10005.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB)
			end

			if not var_2_2 or var_2_2:isEnd() or not var_2_2:HasAwards() then
				arg_2_0()

				return
			end

			seriesAsync = var_2_10002

			var_2_10002({
				function(arg_3_0)
					pg = var_3_10001

					local var_3_0 = var_3_10001.m02
					local var_3_1 = var_1.sendNotification

					GAME = var_3_10004

					var_3_1(var_3_0, var_3_10004.BOSSRUSH_SETTLE, {
						actId = var_2_2.id,
						callback = arg_3_0
					})

					return
				end,
				function(arg_4_0, arg_4_1)
					if #arg_4_1.awards > 0 then
						LoadContextCommand = var_3

						local var_4_0 = var_3.LoadLayerOnTopContext

						Context = var_3_10005

						local var_4_1 = var_3_10005.New
						local var_4_2 = {}

						AwardInfoMediator = var_3_10008
						var_4_2.mediator = var_3_10008
						AwardInfoLayer = var_3_10008
						var_4_2.viewComponent = var_3_10008
						var_4_2.data = {
							items = var_2,
							removeFunc = arg_4_0
						}

						var_4_0(var_4_1(var_4_2))

						return
					end

					arg_4_0()

					return
				end,
				arg_2_0
			})

			return
		end,
		arg_1_1
	})

	return
end

return var_0_0
