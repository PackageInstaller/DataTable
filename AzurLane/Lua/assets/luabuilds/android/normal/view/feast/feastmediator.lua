class = var_0_10000

local var_0_0 = "FeastMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.backYard.CourtYardMediator"))

var_0_1.SET_UP = "FeastMediator:SET_UP"
var_0_1.MAKE_TICKET = "FeastMediator:MAKE_TICKET"
var_0_1.GIVE_TICKET = "FeastMediator:GIVE_TICKET"
var_0_1.GIVE_GIFT = "FeastMediator:GIVE_GIFT"
var_0_1.EVENT_PT_OPERATION = "FeastMediator:EVENT_PT_OPERATION"
var_0_1.ON_SUBMIT = "FeastMediator:ON_SUBMIT"
var_0_1.ON_GO = "FeastMediator:ON_GO"
var_0_1.ON_SUBMIT_ONE_KEY = "FeastMediator:ON_SUBMIT_ONE_KEY"
var_0_1.ON_SHIP_ENTER_FEAST = "FeastMediator:ON_SHIP_ENTER_FEAST"

function var_0_1.register(arg_1_0)
	arg_1_0.caches = {}
	getProxy = var_1
	ActivityProxy = var_1_10002

	local var_1_0 = var_1(var_1_10002)
	local var_1_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	local var_1_2 = var_1_1(var_1_0, var_1_10003.ACTIVITY_TYPE_FEAST)

	arg_1_0:bind(var_0_1.SET_UP, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.GenCourtYardData(var_2_0, arg_2_1)

		CourtYardBridge = var_2_0

		local var_2_2 = var_2_0.New(var_2_1)
		local var_2_3 = _courtyard

		return
	end)
	arg_1_0:bind(var_0_1.MAKE_TICKET, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_3_2 = var_2_10004.FEAST_OP
		local var_3_3 = {
			activityId = var_1_2.id
		}

		FeastDorm = var_6
		var_3_3.cmd = var_6.OP_MAKE_TICKET
		var_3_3.arg1 = arg_3_1

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)
	arg_1_0:bind(var_0_1.GIVE_TICKET, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_4_2 = var_2_10004.FEAST_OP
		local var_4_3 = {
			activityId = var_1_2.id
		}

		FeastDorm = var_6
		var_4_3.cmd = var_6.OP_GIVE_TICKET
		var_4_3.arg1 = arg_4_1

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)
	arg_1_0:bind(var_0_1.GIVE_GIFT, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_5_2 = var_2_10004.FEAST_OP
		local var_5_3 = {
			activityId = var_1_2.id
		}

		FeastDorm = var_6
		var_5_3.cmd = var_6.OP_GIVE_GIFT
		var_5_3.arg1 = arg_5_1

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end)
	arg_1_0:bind(var_0_1.EVENT_PT_OPERATION, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		var_6_1(var_6_0, var_2_10004.ACT_NEW_PT, arg_6_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SUBMIT, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10004

		var_7_1(var_7_0, var_2_10004.SUBMIT_TASK, arg_7_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_GO, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0

		var_2.HandleTaskGo(var_8_0, arg_8_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SUBMIT_ONE_KEY, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0
		local var_9_1 = var_2.sendNotification

		GAME = var_2_10004

		var_9_1(var_9_0, var_2_10004.SUBMIT_TASK_ONESTEP, {
			resultList = arg_9_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SHIP_ENTER_FEAST, function(arg_10_0, arg_10_1)
		_courtyard = var_2_10002

		if var_2_10002 then
			_courtyard = var_2_10002

			local var_10_0 = var_2_10002:GetController()

			var_2.ShipEnterFeast(var_10_0, arg_10_1)
		end

		return
	end)

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.sendNotification

	GAME = var_4

	local var_1_5 = var_4.FEAST_OP
	local var_1_6 = {
		activityId = var_1_2.id
	}

	FeastDorm = var_6
	var_1_6.cmd = var_6.OP_ENTER

	var_1_4(var_1_3, var_1_5, var_1_6)

	return
end

function var_0_1.HandleTaskGo(arg_11_0, arg_11_1)
	if arg_11_1:IsActRoutineType() and arg_11_1:getConfig("sub_type") == 430 then
		-- block empty
	elseif arg_11_1:IsActRoutineType() and arg_11_1:getConfig("sub_type") == 431 then
		local var_11_0 = arg_11_0.viewComponent
		local var_11_1 = var_2.emit

		FeastScene = var_1_10004

		var_11_1(var_11_0, var_1_10004.GO_INTERACTION)
	elseif arg_11_1:IsActType() and (arg_11_1:getConfig("sub_type") == 432 or arg_11_1:getConfig("sub_type") == 433) then
		local var_11_2 = arg_11_0.viewComponent
		local var_11_3 = var_2.emit

		FeastScene = var_1_10004

		var_11_3(var_11_2, var_1_10004.GO_INVITATION)
	elseif arg_11_1:IsActType() and arg_11_1:getConfig("sub_type") == 417 then
		pg = var_2

		local var_11_4 = var_2.m02
		local var_11_5 = var_2.sendNotification

		GAME = var_1_10004

		var_11_5(var_11_4, var_1_10004.GO_MINI_GAME, 56)
	else
		local var_11_6 = arg_11_0
		local var_11_7 = arg_11_0.sendNotification

		GAME = var_1_10004

		var_11_7(var_11_6, var_1_10004.TASK_GO, {
			taskVO = arg_11_1
		})
	end

	return
end

function var_0_1.listNotificationInterests(arg_12_0)
	local var_12_0 = {}

	CourtYardEvent = var_1_10002
	var_12_0[1] = var_1_10002._QUIT
	CourtYardEvent = var_2
	var_12_0[2] = var_2._INITED
	CourtYardEvent = var_2
	var_12_0[3] = var_2._FEAST_INTERACTION
	GAME = var_2
	var_12_0[4] = var_2.ACT_NEW_PT_DONE
	GAME = var_2
	var_12_0[5] = var_2.SUBMIT_TASK_DONE
	GAME = var_2
	var_12_0[6] = var_2.FEAST_OP_DONE
	TaskProxy = var_2
	var_12_0[7] = var_2.TASK_ADDED
	TaskProxy = var_2
	var_12_0[8] = var_2.TASK_UPDATED
	TaskProxy = var_2
	var_12_0[9] = var_2.TASK_REMOVED
	TaskProxy = var_2
	var_12_0[10] = var_2.TASK_DELETE
	ActivityProxy = var_2
	var_12_0[11] = var_2.ACTIVITY_UPDATED

	return var_12_0
end

function var_0_1.handleNotification(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1:getName()
	local var_13_1 = arg_13_1:getBody()
	local var_13_2 = arg_13_1
	local var_13_3 = arg_13_1.getType(var_13_2)

	CourtYardEvent = var_13_2

	local var_13_4

	if var_13_0 == var_13_2._QUIT then
		var_1_10006 = arg_13_0.viewComponent
		var_13_4 = var_13_4.emit
		BaseUI = var_1_10007

		var_13_4(var_1_10006, var_1_10007.ON_BACK)

		goto label_13_0
	end

	CourtYardEvent = var_13_4

	if var_13_0 == var_13_4._INITED then
		var_1_10006 = arg_13_0.viewComponent

		var_5.OnCourtYardLoaded(var_1_10006)

		goto label_13_0
	end

	CourtYardEvent = var_5

	if var_13_0 == var_5._FEAST_INTERACTION then
		getProxy = var_13_5
		ActivityProxy = var_1_10006
		var_1_10006 = var_13_5(var_1_10006)

		local var_13_5 = var_13_5.getActivityByType

		ActivityConst = var_1_10007

		if var_13_5(var_1_10006, var_1_10007.ACTIVITY_TYPE_FEAST) then
			var_1_10007 = var_13_5

			if var_13_5.isEnd(var_1_10007) then
				return
			end

			var_1_10006 = var_13_1.groupId
			var_1_10007 = var_13_1.special
			var_1_10009 = arg_13_0
			var_1_10008 = arg_13_0.sendNotification
			GAME = var_1_10010

			local var_13_6 = var_1_10010.FEAST_OP
			local var_13_7 = {
				activityId = var_13_5.id
			}

			FeastDorm = var_12
			var_13_7.cmd = var_12.OP_INTERACTION
			var_13_7.arg1 = var_1_10006
			var_13_7.arg2 = var_1_10007

			var_1_10008(var_1_10009, var_13_6, var_13_7)

			goto label_13_0

			GAME = var_13_5

			local var_13_8

			if var_13_0 == var_13_5.FEAST_OP_DONE then
				var_13_8 = 0
				var_1_10006 = true
				var_1_10007 = var_13_1.cmd
				FeastDorm = var_1_10008

				local var_13_9

				if var_1_10007 == var_1_10008.OP_INTERACTION then
					_courtyard = var_1_10007
					var_13_9 = var_1_10007
					var_13_9 = var_1_10007.GetController(var_13_9)

					var_1_10007.UpdateBubble(var_13_9, var_13_1.groupId, var_13_1.value)

					if var_13_1.chat and var_13_1.chat ~= "" then
						_courtyard = var_1_10007
						var_13_9 = var_1_10007
						var_13_9 = var_1_10007.GetController(var_13_9)

						var_1_10007.UpdateChatBubble(var_13_9, var_13_1.groupId, var_13_1.chat)
					end

					CourtYardConst = var_1_10007
					var_13_8 = var_1_10007.FEAST_EFFECT_TIME
				else
					var_1_10007 = var_13_1.cmd
					FeastDorm = var_13_9

					local var_13_10

					if var_1_10007 == var_13_9.OP_GIVE_TICKET then
						getProxy = var_1_10007
						FeastProxy = var_13_10
						var_13_10 = var_1_10007(var_13_10)
						var_1_10009 = var_1_10007.getRawData(var_13_10)
						var_13_10 = var_1_10007.GetFeastShip(var_1_10009, var_13_1.groupId)
						_courtyard = var_1_10009

						local var_13_11 = var_1_10009:GetController()

						var_1_10009.AddShipWithSpecialPosition(var_13_11, var_13_10)

						local var_13_12 = arg_13_0.viewComponent

						var_1_10009 = var_1_10009.emit
						FeastScene = var_11

						var_1_10009(var_13_12, var_11.ON_GOT_TICKET, var_13_1.awards)

						getProxy = var_1_10009
						FeastProxy = var_13_12

						local var_13_13 = var_1_10009(var_13_12)
						local var_13_14 = var_1_10009.getRawData(var_13_13)

						var_1_10009 = var_1_10009.GetInvitedFeastShip(var_13_14, var_13_1.groupId)
						var_1_10006 = false
					else
						var_1_10007 = var_13_1.cmd
						FeastDorm = var_13_10

						local var_13_15

						if var_1_10007 == var_13_10.OP_RANDOM_SHIPS then
							_courtyard = var_1_10007
							var_13_15 = var_1_10007
							var_13_15 = var_1_10007.GetController(var_13_15)

							var_1_10007.ExitAllShip(var_13_15)

							var_1_10007 = {}
							ipairs = var_13_15

							if not var_13_1.ships then
								var_1_10009 = {}
							end

							for iter_13_0, iter_13_1 in var_13_15(var_1_10009) do
								table = var_1_10013

								var_1_10013.insert(var_1_10007, function(arg_14_0)
									_courtyard = var_2_10001

									local var_14_0 = var_2_10001:GetController()

									var_1.AddShip(var_14_0, iter_13_1, 0, 0)

									onNextTick = var_1

									var_1(arg_14_0)

									return
								end)
							end

							seriesAsync = var_13_15

							var_13_15(var_1_10007)
						else
							var_1_10007 = var_13_1.cmd
							FeastDorm = var_13_15

							local var_13_16

							if var_1_10007 == var_13_15.OP_GIVE_GIFT then
								var_13_16 = arg_13_0.viewComponent
								var_1_10007 = var_1_10007.emit
								FeastScene = var_1_10009

								var_1_10007(var_13_16, var_1_10009.ON_GOT_GIFT, var_13_1.awards)

								getProxy = var_1_10007
								FeastProxy = var_13_16
								var_13_16 = var_1_10007(var_13_16)
								var_13_16 = var_1_10007.getRawData(var_13_16)
								var_1_10007 = var_1_10007.GetInvitedFeastShip(var_13_16, var_13_1.groupId)
								var_1_10006 = false
							else
								var_1_10007 = var_13_1.cmd
								FeastDorm = var_13_16

								if var_1_10007 == var_13_16.OP_MAKE_TICKET then
									local var_13_17 = arg_13_0.viewComponent

									var_1_10007 = var_1_10007.emit
									FeastScene = var_1_10009

									var_1_10007(var_13_17, var_1_10009.ON_MAKE_TICKET, var_13_1.groupId)
								end
							end
						end
					end
				end

				var_1_10007 = #var_13_1.awards

				if 0 < var_1_10007 and var_1_10006 then
					var_1_10007 = var_13_1.cmd
					FeastDorm = var_8
					var_1_10007 = var_1_10007 == var_8.OP_INTERACTION and #arg_13_0.caches == 0

					local var_13_18 = var_1_10007 and var_13_8 or 0

					table = var_1_10009

					var_1_10009.insert(arg_13_0.caches, {
						var_13_1.awards,
						var_13_18
					})

					if #arg_13_0.caches == 1 then
						arg_13_0:DisplayAwards()
					end
				end

				goto label_13_0
			end

			TaskProxy = var_13_8

			if var_13_0 ~= var_13_8.TASK_ADDED then
				TaskProxy = var_13_19

				if var_13_0 ~= var_13_19.TASK_UPDATED then
					TaskProxy = var_13_19

					if var_13_0 ~= var_13_19.TASK_REMOVED then
						TaskProxy = var_13_19

						do
							local var_13_19

							if var_13_0 == var_13_19.TASK_DELETE then
								var_1_10006 = arg_13_0.viewComponent
								var_13_19 = var_13_19.emit
								FeastScene = var_1_10007

								var_13_19(var_1_10006, var_1_10007.ON_TASK_UPDATE)
							else
								ActivityProxy = var_13_19

								local var_13_20

								if var_13_0 == var_13_19.ACTIVITY_UPDATED then
									var_13_20 = var_13_1.id
									ActivityConst = var_1_10006

									if var_13_20 == var_1_10006.FEAST_PT_ACT then
										local var_13_21 = arg_13_0.viewComponent

										var_13_20 = var_13_20.emit
										FeastScene = var_1_10007

										var_13_20(var_13_21, var_1_10007.ON_ACT_UPDATE)
									end
								else
									GAME = var_13_20

									local var_13_23

									if var_13_0 == var_13_20.SUBMIT_TASK_DONE then
										local var_13_22 = arg_13_0.viewComponent

										var_13_23 = var_13_23.emit
										BaseUI = var_1_10007

										var_13_23(var_13_22, var_1_10007.ON_ACHIEVE, var_13_1, function()
											local var_15_0 = var_13_3

											getProxy = var_2_10001
											FeastProxy = var_2_10002

											local var_15_1 = var_2_10001(var_2_10002)

											var_1.HandleTaskStories(var_15_1, var_15_0)

											return
										end)
									else
										GAME = var_13_23

										if var_13_0 == var_13_23.ACT_NEW_PT_DONE then
											local var_13_24 = arg_13_0.viewComponent
											local var_13_25 = var_5.emit

											BaseUI = var_1_10007

											var_13_25(var_13_24, var_1_10007.ON_ACHIEVE, var_13_1.awards, function()
												return
											end)
										end
									end
								end
							end
						end

						::label_13_0::

						return
					end
				end
			end
		end
	end
end

function var_0_1.DisplayAwards(arg_17_0)
	local var_17_0 = arg_17_0.caches[1][1]
	local var_17_1 = var_1[2]
	local var_17_2 = {}

	if 0 < var_17_1 then
		table = var_5

		var_5.insert(var_17_2, function(arg_18_0)
			if not arg_17_0.viewComponent then
				return
			end

			onDelayTick = var_1

			var_1(arg_18_0, var_17_1, 1)

			return
		end)
	end

	table = var_5

	var_5.insert(var_17_2, function(arg_19_0)
		if not arg_17_0.viewComponent then
			return
		end

		local var_19_0 = arg_17_0.viewComponent
		local var_19_1 = var_1.emit

		BaseUI = var_2_10003

		var_19_1(var_19_0, var_2_10003.ON_ACHIEVE, var_17_0, arg_19_0)

		return
	end)

	seriesAsync = var_5

	var_5(var_17_2, function()
		table = var_2_10000

		var_2_10000.remove(arg_17_0.caches, 1)

		if #arg_17_0.caches > 0 then
			local var_20_0 = arg_17_0

			var_0.DisplayAwards(var_20_0)
		end

		return
	end)

	return
end

return var_0_1
