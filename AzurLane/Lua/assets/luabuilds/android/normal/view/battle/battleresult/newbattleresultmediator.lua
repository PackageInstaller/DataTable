class = var_0_10000

local var_0_0 = "NewBattleResultMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.GET_NEW_SHIP = "NewBattleResultMediator:GET_NEW_SHIP"
var_0_1.OPEN_FIALED_HELP = "NewBattleResultMediator:OPEN_FIALED_HELP"
var_0_1.ON_ENTER_BATTLE_RESULT = "NewBattleResultMediator:ON_ENTER_BATTLE_RESULT"
var_0_1.ON_COMPLETE_BATTLE_RESULT = "NewBattleResultMediator:ON_COMPLETE_BATTLE_RESULT"
var_0_1.SET_SKIP_FLAG = "NewBattleResultMediator:SET_SKIP_FLAG"
var_0_1.REENTER_STAGE = "NewBattleResultMediator:REENTER_STAGE"
var_0_1.CHALLENGE_SHARE = "NewBattleResultMediator:ON_CHALLENGE_SHARE"
var_0_1.CHALLENGE_DEFEAT_SCENE = "NewBattleResultMediator:CHALLENGE_DEFEAT_SCENE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GET_NEW_SHIP, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0
		local var_2_1 = var_4.addSubLayers

		Context = var_2_10006

		local var_2_2 = var_2_10006.New
		local var_2_3 = {}

		NewShipMediator = var_2_10008
		var_2_3.mediator = var_2_10008
		NewShipLayer = var_2_10008
		var_2_3.viewComponent = var_2_10008
		var_2_3.data = {
			ship = arg_2_1,
			autoExitTime = arg_2_3
		}
		var_2_3.onRemoved = arg_2_2

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_FIALED_HELP, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_3_2 = var_2_10004.New
		local var_3_3 = {}

		BattleFailTipMediator = var_2_10006
		var_3_3.mediator = var_2_10006
		BattleFailTipLayer = var_2_10006
		var_3_3.viewComponent = var_2_10006
		var_3_3.data = {
			mainShips = arg_1_0.contextData.newMainShips,
			battleSystem = arg_1_0.contextData.system
		}
		var_3_3.onRemoved = arg_3_1

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)
	arg_1_0:bind(var_0_1.REENTER_STAGE, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.sendNotification

		GAME = var_2_10003

		var_4_1(var_4_0, var_2_10003.BEGIN_STAGE, {
			stageId = arg_1_0.contextData.stageId,
			mainFleetId = arg_1_0.contextData.mainFleetId,
			system = arg_1_0.contextData.system,
			actId = arg_1_0.contextData.actId,
			rivalId = arg_1_0.contextData.rivalId,
			continuousBattleTimes = arg_1_0.contextData.continuousBattleTimes,
			totalBattleTimes = arg_1_0.contextData.totalBattleTimes
		})

		return
	end)
	arg_1_0:bind(var_0_1.CHALLENGE_SHARE, function(arg_5_0)
		local var_5_0 = arg_1_0
		local var_5_1 = var_1.addSubLayers

		Context = var_2_10003

		local var_5_2 = var_2_10003.New
		local var_5_3 = {}

		ChallengeShareMediator = var_2_10005
		var_5_3.mediator = var_2_10005
		ChallengeShareLayer = var_2_10005
		var_5_3.viewComponent = var_2_10005
		var_5_3.data = {
			mode = arg_1_0.contextData.mode
		}

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)
	arg_1_0:bind(var_0_1.CHALLENGE_DEFEAT_SCENE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_6_2 = var_2_10004.New
		local var_6_3 = {}

		ChallengePassedMediator = var_2_10006
		var_6_3.mediator = var_2_10006
		ChallengePassedLayer = var_2_10006
		var_6_3.viewComponent = var_2_10006
		var_6_3.data = {
			mode = arg_1_0.contextData.mode
		}
		var_6_3.onRemoved = arg_6_1.callback

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)
	arg_1_0:sendNotification(var_0_1.ON_ENTER_BATTLE_RESULT)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	GAME = var_1_10002
	var_7_0[1] = var_1_10002.BEGIN_STAGE_DONE
	GAME = var_2
	var_7_0[2] = var_2.CONTINUE_STAGE_DONE
	NewBattleResultMediator = var_2
	var_7_0[3] = var_2.SET_SKIP_FLAG
	ContinuousOperationMediator = var_2
	var_7_0[4] = var_2.CONTINUE_OPERATION
	GAME = var_2
	var_7_0[5] = var_2.ACT_BOSS_EXCHANGE_TICKET_DONE
	BossSingleContinuousOperationMediator = var_2
	var_7_0[6] = var_2.CONTINUE_OPERATION

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1
	local var_8_2 = arg_8_1.getBody(var_8_1)

	GAME = var_8_1

	local var_8_4

	if var_8_0 == var_8_1.BEGIN_STAGE_DONE then
		local var_8_3 = arg_8_0

		var_8_4 = arg_8_0.sendNotification
		GAME = var_1_10006
		var_1_10006 = var_1_10006.CHANGE_SCENE
		SCENE = var_1_10007

		var_8_4(var_8_3, var_1_10006, var_1_10007.COMBATLOAD, var_8_2)
	else
		GAME = var_8_4

		local var_8_6

		if var_8_0 == var_8_4.CONTINUE_STAGE_DONE then
			local var_8_5 = arg_8_0

			var_8_6 = arg_8_0.sendNotification
			GAME = var_1_10006

			local var_8_7 = var_1_10006.CHANGE_SCENE

			SCENE = var_1_10007

			var_8_6(var_8_5, var_8_7, var_1_10007.BOSSRUSH_PASSED_COMBATLOAD, var_8_2)
		else
			ContinuousOperationMediator = var_8_6

			local var_8_8

			if var_8_0 == var_8_6.CONTINUE_OPERATION then
				var_8_8 = arg_8_0.contextData
				var_8_8.continuousBattleTimes = arg_8_0.contextData.continuousBattleTimes - 1
			else
				NewBattleResultMediator = var_8_8

				local var_8_9

				if var_8_0 == var_8_8.SET_SKIP_FLAG then
					var_8_9 = arg_8_0.contextData
					var_8_9.autoSkipFlag = var_8_2
				else
					GAME = var_8_9

					if var_8_0 == var_8_9.ACT_BOSS_EXCHANGE_TICKET_DONE then
						local var_8_10 = arg_8_0.viewComponent

						var_4.emit(var_8_10, var_0_1.REENTER_STAGE)
					else
						BossSingleContinuousOperationMediator = var_4

						if var_8_0 == var_4.CONTINUE_OPERATION then
							arg_8_0.contextData.continuousBattleTimes = arg_8_0.contextData.continuousBattleTimes - 1
						end
					end
				end
			end
		end
	end

	return
end

return var_0_1
