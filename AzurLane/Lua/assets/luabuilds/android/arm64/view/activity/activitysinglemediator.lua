class = var_0_10000

local var_0_0 = "ActivityMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0.contextData.id

	arg_1_0.contextData.singleActivity = true

	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_0.bind

	ActivityMediator = var_1_10005

	var_1_2(var_1_1, var_1_10005.EVENT_OPERATION, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.ACTIVITY_OPERATION, arg_2_1)

		return
	end)

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.bind

	ActivityMediator = var_5

	var_1_4(var_1_3, var_5.EVENT_GO_SCENE, function(arg_3_0, arg_3_1, arg_3_2)
		SCENE = var_2_10003

		if arg_3_1 == var_2_10003.SUMMER_FEAST then
			pg = var_3

			local var_3_0 = var_3.NewStoryMgr.GetInstance()

			var_3.Play(var_3_0, "TIANHOUYUYI1", function()
				local var_4_0 = arg_1_0
				local var_4_1 = var_0.sendNotification

				GAME = var_3_10003

				local var_4_2 = var_3_10003.GO_SCENE

				SCENE = var_3_10004

				var_4_1(var_4_0, var_4_2, var_3_10004.SUMMER_FEAST)

				return
			end)
		else
			local var_3_1 = arg_1_0
			local var_3_2 = var_3.sendNotification

			GAME = var_2_10006

			var_3_2(var_3_1, var_2_10006.GO_SCENE, arg_3_1, arg_3_2)
		end

		return
	end)

	getProxy = var_1_4
	PlayerProxy = var_1_3

	local var_1_5 = var_1_4(var_1_3)
	local var_1_6 = var_2.getRawData(var_1_5)
	local var_1_7 = arg_1_0.viewComponent

	var_4.setPlayer(var_1_7, var_1_6)

	getProxy = var_4
	BayProxy = var_1_7

	local var_1_8 = var_4(var_1_7)
	local var_1_9 = var_4.getShipById(var_1_8, var_1_6.character)
	local var_1_10 = arg_1_0.viewComponent

	var_6.setFlagShip(var_1_10, var_1_9)

	getProxy = var_6
	ActivityProxy = var_1_10

	local var_1_11 = var_6(var_1_10)
	local var_1_12 = var_6.getActivityById(var_1_11, var_1_0)
	local var_1_13 = arg_1_0.viewComponent

	var_8.selectActivity(var_1_13, var_1_12)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	ActivityProxy = var_1_10002
	var_5_0[1] = var_1_10002.ACTIVITY_ADDED
	ActivityProxy = var_2
	var_5_0[2] = var_2.ACTIVITY_UPDATED
	ActivityProxy = var_2
	var_5_0[3] = var_2.ACTIVITY_OPERATION_DONE
	ActivityProxy = var_2
	var_5_0[4] = var_2.ACTIVITY_SHOW_AWARDS
	GAME = var_2
	var_5_0[5] = var_2.ACT_NEW_PT_DONE
	GAME = var_2
	var_5_0[6] = var_2.RETURN_AWARD_OP_DONE
	GAME = var_2
	var_5_0[7] = var_2.MONOPOLY_AWARD_DONE
	GAME = var_2
	var_5_0[8] = var_2.SUBMIT_TASK_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1:getBody()

	ActivityProxy = var_6_0

	if var_6_1 ~= var_6_0.ACTIVITY_ADDED then
		ActivityProxy = var_4

		if var_6_1 == var_4.ACTIVITY_UPDATED then
			local var_6_3 = arg_6_0.viewComponent

			var_4.updateActivity(var_6_3, var_6_2)

			goto label_6_0
		end

		ActivityProxy = var_4

		if var_6_1 == var_4.ACTIVITY_OPERATION_DONE then
			goto label_6_0
		end

		ActivityProxy = var_4

		if var_6_1 ~= var_4.ACTIVITY_SHOW_AWARDS then
			GAME = var_6_5

			if var_6_1 ~= var_6_5.ACT_NEW_PT_DONE then
				GAME = var_6_5

				if var_6_1 ~= var_6_5.RETURN_AWARD_OP_DONE then
					GAME = var_6_5

					do
						local var_6_5

						if var_6_1 == var_6_5.MONOPOLY_AWARD_DONE then
							local var_6_4 = arg_6_0.viewComponent

							var_6_5 = var_6_5.emit
							BaseUI = var_1_10007

							var_6_5(var_6_4, var_1_10007.ON_ACHIEVE, var_6_2.awards, var_6_2.callback)
						else
							GAME = var_6_5

							local var_6_7

							if var_6_1 == var_6_5.SUBMIT_TASK_DONE then
								local var_6_6 = arg_6_0.viewComponent

								var_6_7 = var_6_7.emit
								BaseUI = var_1_10007

								var_6_7(var_6_6, var_1_10007.ON_ACHIEVE, var_6_2, function()
									local var_7_0 = arg_6_0.viewComponent

									var_0.updateTaskLayers(var_7_0)

									return
								end)
							else
								GAME = var_6_7

								if var_6_1 == var_6_7.SEND_MINI_GAME_OP_DONE then
									local var_6_8 = {
										function(arg_8_0)
											if #var_6_2.awards > 0 then
												if arg_6_0.viewComponent then
													local var_8_0 = arg_6_0.viewComponent
													local var_8_1 = var_2.emit

													BaseUI = var_2_10005

													var_8_1(var_8_0, var_2_10005.ON_ACHIEVE, var_1, arg_8_0)
												else
													local var_8_2 = arg_6_0
													local var_8_3 = var_2.emit

													BaseUI = var_2_10005

													var_8_3(var_8_2, var_2_10005.ON_ACHIEVE, var_1, arg_8_0)
												end
											else
												arg_8_0()
											end

											return
										end
									}

									seriesAsync = var_5

									var_5(var_6_8)
								end
							end
						end
					end

					::label_6_0::

					return
				end
			end
		end
	end
end

return var_0_1
