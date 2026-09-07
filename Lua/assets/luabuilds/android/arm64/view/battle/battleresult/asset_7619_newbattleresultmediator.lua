local NewBattleResultMediator = class("NewBattleResultMediator", import("view.base.ContextMediator"))

NewBattleResultMediator.GET_NEW_SHIP = "NewBattleResultMediator:GET_NEW_SHIP"
NewBattleResultMediator.OPEN_FIALED_HELP = "NewBattleResultMediator:OPEN_FIALED_HELP"
NewBattleResultMediator.ON_ENTER_BATTLE_RESULT = "NewBattleResultMediator:ON_ENTER_BATTLE_RESULT"
NewBattleResultMediator.ON_COMPLETE_BATTLE_RESULT = "NewBattleResultMediator:ON_COMPLETE_BATTLE_RESULT"
NewBattleResultMediator.SET_SKIP_FLAG = "NewBattleResultMediator:SET_SKIP_FLAG"
NewBattleResultMediator.REENTER_STAGE = "NewBattleResultMediator:REENTER_STAGE"
NewBattleResultMediator.CHALLENGE_SHARE = "NewBattleResultMediator:ON_CHALLENGE_SHARE"
NewBattleResultMediator.CHALLENGE_DEFEAT_SCENE = "NewBattleResultMediator:CHALLENGE_DEFEAT_SCENE"

function NewBattleResultMediator:register()
	self:bind(NewBattleResultMediator.GET_NEW_SHIP, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self:addSubLayers(Context.New({
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
	self:bind(NewBattleResultMediator.OPEN_FIALED_HELP, function(arg_3_0, arg_3_1)
		self:addSubLayers(Context.New({
			mediator = BattleFailTipMediator,
			viewComponent = BattleFailTipLayer,
			data = {
				mainShips = self.contextData.newMainShips,
				battleSystem = self.contextData.system
			},
			onRemoved = arg_3_1
		}))

		return
	end)
	self:bind(NewBattleResultMediator.REENTER_STAGE, function(arg_4_0)
		self:sendNotification(GAME.BEGIN_STAGE, {
			stageId = self.contextData.stageId,
			mainFleetId = self.contextData.mainFleetId,
			system = self.contextData.system,
			actId = self.contextData.actId,
			rivalId = self.contextData.rivalId,
			continuousBattleTimes = self.contextData.continuousBattleTimes,
			totalBattleTimes = self.contextData.totalBattleTimes
		})

		return
	end)
	self:bind(NewBattleResultMediator.CHALLENGE_SHARE, function(arg_5_0)
		self:addSubLayers(Context.New({
			mediator = ChallengeShareMediator,
			viewComponent = ChallengeShareLayer,
			data = {
				mode = self.contextData.mode
			}
		}))

		return
	end)
	self:bind(NewBattleResultMediator.CHALLENGE_DEFEAT_SCENE, function(arg_6_0, arg_6_1)
		self:addSubLayers(Context.New({
			mediator = ChallengePassedMediator,
			viewComponent = ChallengePassedLayer,
			data = {
				mode = self.contextData.mode
			},
			onRemoved = arg_6_1.callback
		}))

		return
	end)
	self:sendNotification(NewBattleResultMediator.ON_ENTER_BATTLE_RESULT)

	return
end

function NewBattleResultMediator:listNotificationInterests()
	return {
		GAME.BEGIN_STAGE_DONE,
		GAME.CONTINUE_STAGE_DONE,
		NewBattleResultMediator.SET_SKIP_FLAG,
		ContinuousOperationMediator.CONTINUE_OPERATION,
		GAME.ACT_BOSS_EXCHANGE_TICKET_DONE,
		BossSingleContinuousOperationMediator.CONTINUE_OPERATION
	}
end

function NewBattleResultMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.CHANGE_SCENE, SCENE.COMBATLOAD, var_8_1)
	elseif var_8_0 == GAME.CONTINUE_STAGE_DONE then
		self:sendNotification(GAME.CHANGE_SCENE, SCENE.BOSSRUSH_PASSED_COMBATLOAD, var_8_1)
	elseif var_8_0 == ContinuousOperationMediator.CONTINUE_OPERATION then
		self.contextData.continuousBattleTimes = self.contextData.continuousBattleTimes - 1
	elseif var_8_0 == NewBattleResultMediator.SET_SKIP_FLAG then
		self.contextData.autoSkipFlag = var_8_1
	elseif var_8_0 == GAME.ACT_BOSS_EXCHANGE_TICKET_DONE then
		self.viewComponent:emit(NewBattleResultMediator.REENTER_STAGE)
	elseif var_8_0 == BossSingleContinuousOperationMediator.CONTINUE_OPERATION then
		self.contextData.continuousBattleTimes = self.contextData.continuousBattleTimes - 1
	end

	return
end

return NewBattleResultMediator
