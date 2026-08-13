class = var_0_10000

local var_0_0 = "CityRebuildCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	CityRebuildProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)
	local var_1_2 = var_1_0.operation

	CityRebuildProxy = var_1_10005

	if var_1_2 == var_1_10005.GET_DATA then
		pg = var_1_2

		local var_1_3 = var_1_2.ConnectionMgr.GetInstance()

		var_4.Send(var_1_3, 26060, {
			act_id = var_1_0.activityId
		}, 26061, function(arg_2_0)
			local var_2_2

			if arg_2_0.result == 0 then
				local var_2_0 = var_1_1

				var_2_2.SetData(var_2_0, var_1_0.activityId, arg_2_0.info)

				local var_2_1 = arg_1_0

				var_2_2 = var_2_2.sendNotification
				GAME = var_2_10004

				var_2_2(var_2_1, var_2_10004.CITY_REBUILD_DONE, {
					operation = var_1_0.operation
				})

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg = var_2_2

				local var_2_3 = var_2_2.TipsMgr.GetInstance()
				local var_2_4 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10004

				var_2_4(var_2_3, var_2_10004[arg_2_0.result] .. arg_2_0.result)
			end

			return
		end)
	else
		local var_1_4 = var_1_0.operation

		CityRebuildProxy = var_5

		if var_1_4 == var_5.REBUILD_OR_START_RECRUIT then
			pg = var_1_4

			local var_1_5 = var_1_4.ConnectionMgr.GetInstance()

			var_4.Send(var_1_5, 26064, {
				act_id = var_1_0.activityId,
				building_id = var_1_0.buildingId
			}, 26065, function(arg_3_0)
				local var_3_4

				if arg_3_0.result == 0 then
					local var_3_0 = var_1_1

					var_3_4.RebuildOrStartRecruit(var_3_0, var_1_0.activityId, var_1_0.buildingId)

					local var_3_1 = var_1_1

					var_3_4.Adjust(var_3_1, var_1_0.activityId, arg_3_0.adjust)

					local var_3_2 = var_1_1

					var_3_4.ComsumePt(var_3_2, var_1_0.activityId, var_1_0.ptCost[3])

					getProxy = var_3_4
					ActivityProxy = var_3_2

					local var_3_3 = var_3_4(var_3_2)

					var_3_4 = var_3_4.getActivityByType
					ActivityConst = var_2_10004
					var_2_10004 = var_3_4(var_3_3, var_2_10004.ACTIVITY_TYPE_CITY_REBUILD)

					var_3_4.subVitemNumber(var_2_10004, var_1_0.cost[2], var_1_0.cost[3])

					var_2_10004 = arg_1_0

					local var_3_5 = var_2.sendNotification

					GAME = var_5

					var_3_5(var_2_10004, var_5.CITY_REBUILD_DONE, {
						operation = var_1_0.operation
					})

					if var_1_0.callback then
						var_1_0.callback()
					end
				else
					pg = var_3_4

					local var_3_6 = var_3_4.TipsMgr.GetInstance()
					local var_3_7 = var_1.ShowTips

					ERROR_MESSAGE = var_2_10004

					var_3_7(var_3_6, var_2_10004[arg_3_0.result] .. arg_3_0.result)
				end

				return
			end)
		else
			local var_1_6 = var_1_0.operation

			CityRebuildProxy = var_5

			if var_1_6 == var_5.END_RECRUIT then
				pg = var_1_6

				local var_1_7 = var_1_6.ConnectionMgr.GetInstance()

				var_4.Send(var_1_7, 26062, {
					act_id = var_1_0.activityId,
					roles = var_1_0.roles
				}, 26063, function(arg_4_0)
					local var_4_3

					if arg_4_0.result == 0 then
						local var_4_0 = var_1_1

						var_4_3.RecruitDone(var_4_0, var_1_0.activityId, var_1_0.roles)

						local var_4_1 = var_1_1

						var_4_3.Adjust(var_4_1, var_1_0.activityId, arg_4_0.adjust)

						local var_4_2 = arg_1_0

						var_4_3 = var_4_3.sendNotification
						GAME = var_2_10004

						var_4_3(var_4_2, var_2_10004.CITY_REBUILD_DONE, {
							operation = var_1_0.operation
						})

						if var_1_0.callback then
							var_1_0.callback()
						end
					else
						pg = var_4_3

						local var_4_4 = var_4_3.TipsMgr.GetInstance()
						local var_4_5 = var_1.ShowTips

						ERROR_MESSAGE = var_2_10004

						var_4_5(var_4_4, var_2_10004[arg_4_0.result] .. arg_4_0.result)
					end

					return
				end)
			else
				local var_1_8 = var_1_0.operation

				CityRebuildProxy = var_5

				if var_1_8 == var_5.UPGRADE_BUFF then
					pg = var_1_8

					local var_1_9 = var_1_8.ConnectionMgr.GetInstance()

					var_4.Send(var_1_9, 26066, {
						act_id = var_1_0.activityId,
						group = var_1_0.group,
						count = var_1_0.count
					}, 26067, function(arg_5_0)
						local var_5_4

						if arg_5_0.result == 0 then
							local var_5_0 = var_1_1

							var_5_4.UpgradeBuff(var_5_0, var_1_0.activityId, var_1_0.group, var_1_0.count)

							local var_5_1 = var_1_1

							var_5_4.Adjust(var_5_1, var_1_0.activityId, arg_5_0.adjust)

							local var_5_2 = var_1_1

							var_5_4.ComsumePt(var_5_2, var_1_0.activityId, var_1_0.ptCost)

							local var_5_3 = arg_1_0

							var_5_4 = var_5_4.sendNotification
							GAME = var_2_10004

							var_5_4(var_5_3, var_2_10004.CITY_REBUILD_DONE, {
								operation = var_1_0.operation
							})

							if var_1_0.callback then
								var_1_0.callback()
							end
						else
							pg = var_5_4

							local var_5_5 = var_5_4.TipsMgr.GetInstance()
							local var_5_6 = var_1.ShowTips

							ERROR_MESSAGE = var_2_10004

							var_5_6(var_5_5, var_2_10004[arg_5_0.result] .. arg_5_0.result)
						end

						return
					end)
				else
					local var_1_10 = var_1_0.operation

					CityRebuildProxy = var_5

					if var_1_10 == var_5.RESULT then
						pg = var_1_10

						local var_1_11 = var_1_10.ConnectionMgr.GetInstance()

						var_4.Send(var_1_11, 26068, {
							act_id = var_1_0.activityId
						}, 26069, function(arg_6_0)
							local var_6_1

							if arg_6_0.result == 0 then
								local var_6_0 = var_1_1

								var_6_1.Result(var_6_0, var_1_0.activityId, arg_6_0.summary)

								PlayerConst = var_6_1
								var_6_1 = var_6_1.addTranDrop(arg_6_0.summary.award_list)
								var_2_10004 = arg_1_0

								local var_6_2 = var_2.sendNotification

								GAME = var_5

								var_6_2(var_2_10004, var_5.CITY_REBUILD_DONE, {
									operation = var_1_0.operation,
									awards = var_6_1,
									pt = arg_6_0.summary.summary_pt
								})

								if var_1_0.callback then
									var_1_0.callback()
								end
							else
								pg = var_6_1

								local var_6_3 = var_6_1.TipsMgr.GetInstance()
								local var_6_4 = var_1.ShowTips

								ERROR_MESSAGE = var_2_10004

								var_6_4(var_6_3, var_2_10004[arg_6_0.result] .. arg_6_0.result)
							end

							return
						end)
					else
						local var_1_12 = var_1_0.operation

						CityRebuildProxy = var_5

						if var_1_12 == var_5.CHOOSE_LEVEL then
							pg = var_1_12

							local var_1_13 = var_1_12.ConnectionMgr.GetInstance()

							var_4.Send(var_1_13, 26070, {
								act_id = var_1_0.activityId,
								level = var_1_0.level
							}, 26071, function(arg_7_0)
								local var_7_3

								if arg_7_0.result == 0 then
									local var_7_0 = var_1_1

									var_7_3.UpdateChooseLevel(var_7_0, var_1_0.activityId, var_1_0.level)

									local var_7_1 = var_1_1

									var_7_3.Adjust(var_7_1, var_1_0.activityId, arg_7_0.adjust)

									local var_7_2 = arg_1_0

									var_7_3 = var_7_3.sendNotification
									GAME = var_2_10004

									var_7_3(var_7_2, var_2_10004.CITY_REBUILD_DONE, {
										operation = var_1_0.operation
									})

									if var_1_0.callback then
										var_1_0.callback()
									end
								else
									pg = var_7_3

									local var_7_4 = var_7_3.TipsMgr.GetInstance()
									local var_7_5 = var_1.ShowTips

									ERROR_MESSAGE = var_2_10004

									var_7_5(var_7_4, var_2_10004[arg_7_0.result] .. arg_7_0.result)
								end

								return
							end)
						else
							local var_1_14 = var_1_0.operation

							CityRebuildProxy = var_5

							if var_1_14 == var_5.INIT_TIME then
								pg = var_1_14

								local var_1_15 = var_1_14.ConnectionMgr.GetInstance()

								var_4.Send(var_1_15, 26072, {
									act_id = var_1_0.activityId
								}, 26073, function(arg_8_0)
									local var_8_2

									if arg_8_0.result == 0 then
										local var_8_0 = var_1_1

										var_8_2.Adjust(var_8_0, var_1_0.activityId, arg_8_0.adjust)

										local var_8_1 = arg_1_0

										var_8_2 = var_8_2.sendNotification
										GAME = var_2_10004

										var_8_2(var_8_1, var_2_10004.CITY_REBUILD_DONE, {
											operation = var_1_0.operation
										})

										if var_1_0.callback then
											var_1_0.callback()
										end
									else
										pg = var_8_2

										local var_8_3 = var_8_2.TipsMgr.GetInstance()
										local var_8_4 = var_1.ShowTips

										ERROR_MESSAGE = var_2_10004

										var_8_4(var_8_3, var_2_10004[arg_8_0.result] .. arg_8_0.result)
									end

									return
								end)
							end
						end
					end
				end
			end
		end
	end

	return
end

return var_0_1
