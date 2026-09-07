local MainReceiveRemasterBossRushAwardsSequence = class("MainReceiveRemasterBossRushAwardsSequence")

function MainReceiveRemasterBossRushAwardsSequence:Execute(arg_1_1)
	seriesAsync({
		function(arg_2_0)
			local var_2_0 = getProxy(ActivityProxy):GetBossRushActivitity(true)

			if not var_2_0 or var_2_0:isEnd() or not var_2_0:HasAwards() then
				arg_2_0()

				return
			end

			seriesAsync({
				function(arg_3_0)
					pg.m02:sendNotification(GAME.BOSSRUSH_SETTLE, {
						actId = var_2_0.id,
						callback = arg_3_0
					})

					return
				end,
				function(arg_4_0, arg_4_1)
					if #arg_4_1.awards > 0 then
						LoadContextCommand.LoadLayerOnTopContext(Context.New({
							mediator = AwardInfoMediator,
							viewComponent = AwardInfoLayer,
							data = {
								items = arg_4_1.awards,
								removeFunc = arg_4_0
							}
						}))

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

return MainReceiveRemasterBossRushAwardsSequence
