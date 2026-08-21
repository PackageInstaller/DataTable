local var_0_0 = class("NewBattleResultMediator", import("view.base.ContextMediator"))

var_0_0.GET_NEW_SHIP = "NewBattleResultMediator:GET_NEW_SHIP"
var_0_0.OPEN_FIALED_HELP = "NewBattleResultMediator:OPEN_FIALED_HELP"
var_0_0.ON_ENTER_BATTLE_RESULT = "NewBattleResultMediator:ON_ENTER_BATTLE_RESULT"
var_0_0.ON_COMPLETE_BATTLE_RESULT = "NewBattleResultMediator:ON_COMPLETE_BATTLE_RESULT"
var_0_0.SET_SKIP_FLAG = "NewBattleResultMediator:SET_SKIP_FLAG"
var_0_0.REENTER_STAGE = "NewBattleResultMediator:REENTER_STAGE"
var_0_0.CHALLENGE_SHARE = "NewBattleResultMediator:ON_CHALLENGE_SHARE"
var_0_0.CHALLENGE_DEFEAT_SCENE = "NewBattleResultMediator:CHALLENGE_DEFEAT_SCENE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.GET_NEW_SHIP, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_1_0:addSubLayers(Context.New({
			mediator = NewShipMediator,
			viewComponent = NewShipLayer,
			data = {
				ship = arg_2_1,
				autoExitTime = arg_2_3
			},
			onRemoved = arg_2_2
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_FIALED_HELP, function(arg_3_0, arg_3_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = BattleFailTipMediator,
			viewComponent = BattleFailTipLayer,
			data = {
				mainShips = arg_1_0.contextData.newMainShips,
				battleSystem = arg_1_0.contextData.system
			},
			onRemoved = arg_3_1
		}))

		return
	end)
	arg_1_0:bind(var_0_0.REENTER_STAGE, function(arg_4_0)
		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
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
	arg_1_0:bind(var_0_0.CHALLENGE_SHARE, function(arg_5_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChallengeShareMediator,
			viewComponent = ChallengeShareLayer,
			data = {
				mode = arg_1_0.contextData.mode
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.CHALLENGE_DEFEAT_SCENE, function(arg_6_0, arg_6_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChallengePassedMediator,
			viewComponent = ChallengePassedLayer,
			data = {
				mode = arg_1_0.contextData.mode
			},
			onRemoved = arg_6_1.callback
		}))

		return
	end)
	arg_1_0:sendNotification(var_0_0.ON_ENTER_BATTLE_RESULT)

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		GAME.BEGIN_STAGE_DONE,
		GAME.CONTINUE_STAGE_DONE,
		NewBattleResultMediator.SET_SKIP_FLAG,
		ContinuousOperationMediator.CONTINUE_OPERATION,
		GAME.ACT_BOSS_EXCHANGE_TICKET_DONE,
		BossSingleContinuousOperationMediator.CONTINUE_OPERATION
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GAME.BEGIN_STAGE_DONE then
		arg_8_0:sendNotification(GAME.CHANGE_SCENE, SCENE.COMBATLOAD, var_8_1)
	elseif var_8_0 == GAME.CONTINUE_STAGE_DONE then
		arg_8_0:sendNotification(GAME.CHANGE_SCENE, SCENE.BOSSRUSH_PASSED_COMBATLOAD, var_8_1)
	elseif var_8_0 == ContinuousOperationMediator.CONTINUE_OPERATION then
		arg_8_0.contextData.continuousBattleTimes = arg_8_0.contextData.continuousBattleTimes - 1
	elseif var_8_0 == NewBattleResultMediator.SET_SKIP_FLAG then
		arg_8_0.contextData.autoSkipFlag = var_8_1
	elseif var_8_0 == GAME.ACT_BOSS_EXCHANGE_TICKET_DONE then
		arg_8_0.viewComponent:emit(var_0_0.REENTER_STAGE)
	elseif var_8_0 == BossSingleContinuousOperationMediator.CONTINUE_OPERATION then
		arg_8_0.contextData.continuousBattleTimes = arg_8_0.contextData.continuousBattleTimes - 1
	end

	return
end

return var_0_0
