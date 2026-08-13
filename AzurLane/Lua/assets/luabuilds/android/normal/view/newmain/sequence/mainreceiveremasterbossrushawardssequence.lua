class = var_0_10000

local var_0_0 = var_0_10000("MainReceiveRemasterBossRushAwardsSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_2_0)
			getProxy = var_2_10001
			ActivityProxy = var_2_10002

			local var_2_0 = var_2_10001(var_2_10002)

			if not var_1.GetBossRushActivitity(var_2_0, true) or var_1:isEnd() or not var_1:HasAwards() then
				arg_2_0()

				return
			end

			seriesAsync = var_2_0

			var_2_0({
				function(arg_3_0)
					pg = var_3_10001

					local var_3_0 = var_3_10001.m02
					local var_3_1 = var_1.sendNotification

					GAME = var_3_10003

					var_3_1(var_3_0, var_3_10003.BOSSRUSH_SETTLE, {
						actId = var_0.id,
						callback = arg_3_0
					})

					return
				end,
				function(arg_4_0, arg_4_1)
					local var_4_0 = #arg_4_1.awards

					if 0 < var_4_0 then
						LoadContextCommand = var_4_0

						local var_4_1 = var_4_0.LoadLayerOnTopContext

						Context = var_4

						local var_4_2 = var_4.New
						local var_4_3 = {}

						AwardInfoMediator = var_3_10006
						var_4_3.mediator = var_3_10006
						AwardInfoLayer = var_3_10006
						var_4_3.viewComponent = var_3_10006
						var_4_3.data = {
							items = var_2,
							removeFunc = arg_4_0
						}

						var_4_1(var_4_2(var_4_3))

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
