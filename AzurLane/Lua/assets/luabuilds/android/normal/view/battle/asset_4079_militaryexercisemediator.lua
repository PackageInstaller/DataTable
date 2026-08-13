class = var_0_10000

local var_0_0 = "MilitaryExerciseMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.OPEN_RANK = "MilitaryExerciseMediator:OPEN_RANK"
var_0_1.OPEN_SHOP = "MilitaryExerciseMediator:OPEN_SHOP"
var_0_1.OPEN_DOCKYARD = "MilitaryExerciseMediator:OPEN_DOCKYARD"
var_0_1.REPLACE_RIVALS = "MilitaryExerciseMediator:REPLACE_RIVALS"
var_0_1.RECOVER_UP = "MilitaryExerciseMediator:RECOVER_UP"
var_0_1.START_BATTLE = "MilitaryExerciseMediator:START_BATTLE"
var_0_1.OPEN_RIVAL_INFO = "MilitaryExerciseMediator:OPEN_RIVAL_INFO"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	MilitaryExerciseProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)

	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_1_1 = var_1_10002(var_1_10003)
	local var_1_2 = var_2.getData(var_1_1)
	local var_1_3 = arg_1_0.viewComponent

	var_4.updatePlayer(var_1_3, var_1_2)

	getProxy = var_4
	BayProxy = var_1_3

	local var_1_4 = var_4(var_1_3)
	local var_1_5 = var_4.getRawData(var_1_4)
	local var_1_6 = arg_1_0.viewComponent

	var_6.setShips(var_1_6, var_1_5)
	arg_1_0:bind(var_0_1.OPEN_RANK, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_2_10003

		local var_2_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_2_3 = var_2_10004.BILLBOARD
		local var_2_4 = {}

		PowerRank = var_2_10006
		var_2_4.page = var_2_10006.TYPE_MILITARY_RANK

		var_2_1(var_2_0, var_2_2, var_2_3, var_2_4)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_RIVAL_INFO, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_3_2 = var_2_10004.New
		local var_3_3 = {}

		RivalInfoLayer = var_2_10006
		var_3_3.viewComponent = var_2_10006
		RivalInfoMediator = var_2_10006
		var_3_3.mediator = var_2_10006

		local var_3_4 = {
			rival = arg_3_1
		}

		RivalInfoLayer = var_2_10007
		var_3_4.type = var_2_10007.TYPE_BATTLE
		var_3_3.data = var_3_4

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_DOCKYARD, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_4_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_4_1(var_4_0, var_4_2, var_2_10006.EXERCISEFORMATION)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_SHOP, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_5_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		local var_5_3 = var_2_10005.SHOP

		if not arg_5_1 then
			::label_5_0::

			var_2_10006 = {}
			NewShopsScene = var_2_10007
			var_2_10006.warp = var_2_10007.TYPE_MILITARY_SHOP
		end

		var_5_1(var_5_0, var_5_2, var_5_3, var_2_10006)

		return
	end)

	local var_1_7 = arg_1_0

	arg_1_0.bind(var_1_7, var_0_1.REPLACE_RIVALS, function(arg_6_0)
		local var_6_0 = arg_1_0
		local var_6_1 = var_1.sendNotification

		GAME = var_2_10003

		var_6_1(var_6_0, var_2_10003.REPLACE_RIVALS)

		return
	end)

	getProxy = var_6
	ActivityProxy = var_1_7

	local var_1_8 = var_6(var_1_7)
	local var_1_9 = var_6.getMilitaryExerciseActivity(var_1_8)

	assert = var_1_8

	var_1_8(var_1_9, "不存在该活动")

	local var_1_10 = arg_1_0.viewComponent

	var_8.setActivity(var_1_10, var_1_9)

	if var_1_0:getSeasonInfo() then
		local var_1_11 = arg_1_0.viewComponent

		var_9.setSeasonInfo(var_1_11, var_8)
	else
		local var_1_12 = arg_1_0
		local var_1_13 = arg_1_0.sendNotification

		GAME = var_1_10011

		var_1_13(var_1_12, var_1_10011.GET_SEASON_INFO)
	end

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	GAME = var_1_10002
	var_7_0[1] = var_1_10002.REPLACE_RIVALS_DONE
	GAME = var_2
	var_7_0[2] = var_2.GET_SEASON_INFO_DONE
	MilitaryExerciseProxy = var_2
	var_7_0[3] = var_2.EXERCISE_FLEET_UPDATED
	PlayerProxy = var_2
	var_7_0[4] = var_2.UPDATED
	MilitaryExerciseProxy = var_2
	var_7_0[5] = var_2.SEASON_INFO_UPDATED
	GAME = var_2
	var_7_0[6] = var_2.MILITARY_STARTED
	ActivityProxy = var_2
	var_7_0[7] = var_2.ACTIVITY_UPDATED

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1
	local var_8_2 = arg_8_1.getBody(var_8_1)

	GAME = var_8_1

	local var_8_3

	if var_8_0 == var_8_1.REPLACE_RIVALS_DONE then
		var_1_10005 = arg_8_0.viewComponent

		var_8_3.setRivals(var_1_10005, var_8_2)

		var_1_10005 = arg_8_0.viewComponent

		var_8_3.updateRivals(var_1_10005)

		pg = var_8_3
		var_1_10005 = var_8_3.TipsMgr.GetInstance()
		var_8_3 = var_8_3.ShowTips
		i18n = var_1_10006

		var_8_3(var_1_10005, var_1_10006("exercise_replace_rivals_ok_tip"))
	else
		GAME = var_8_3

		if var_8_0 == var_8_3.GET_SEASON_INFO_DONE then
			var_1_10005 = arg_8_0.viewComponent

			var_4.setSeasonInfo(var_1_10005, var_8_2)
		else
			MilitaryExerciseProxy = var_4

			if var_8_0 == var_4.EXERCISE_FLEET_UPDATED then
				var_1_10005 = arg_8_0.viewComponent

				var_4.setFleet(var_1_10005, var_8_2)

				var_1_10005 = arg_8_0.viewComponent

				var_4.initPlayerFleet(var_1_10005)
			else
				PlayerProxy = var_4

				if var_8_0 == var_4.UPDATED then
					var_1_10005 = arg_8_0.viewComponent

					var_4.updatePlayer(var_1_10005, var_8_2)
				else
					MilitaryExerciseProxy = var_4

					if var_8_0 == var_4.SEASON_INFO_UPDATED then
						var_1_10005 = arg_8_0.viewComponent

						var_4.updateSeaInfoVO(var_1_10005, var_8_2)

						var_1_10005 = arg_8_0.viewComponent

						var_4.updateSeasonTime(var_1_10005)
					else
						GAME = var_4

						local var_8_4

						if var_8_0 == var_4.MILITARY_STARTED then
							var_1_10005 = arg_8_0
							var_8_4 = arg_8_0.addSubLayers
							Context = var_1_10006

							local var_8_5 = var_1_10006.New
							local var_8_6 = {}

							ExercisePreCombatMediator = var_1_10008
							var_8_6.mediator = var_1_10008
							ExercisePreCombatLayer = var_1_10008
							var_8_6.viewComponent = var_1_10008
							var_8_6.data = {
								stageId = 80000,
								system = var_8_2.system,
								rivalId = var_8_2.rivalId
							}

							var_8_4(var_1_10005, var_8_5(var_8_6))
						else
							ActivityProxy = var_8_4

							if var_8_0 == var_8_4.ACTIVITY_UPDATED then
								local var_8_7 = var_8_2.id

								ActivityConst = var_1_10005

								if var_8_7 == var_1_10005.MILITARY_EXERCISE_ACTIVITY_ID then
									local var_8_8 = arg_8_0.viewComponent

									var_4.setActivity(var_8_8, var_8_2)

									local var_8_9 = arg_8_0.viewComponent

									var_4.updateSeasonLeftTime(var_8_9, var_8_2.stopTime)
								end
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
