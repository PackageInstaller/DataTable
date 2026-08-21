local var_0_0 = class("MilitaryExerciseMediator", import("..base.ContextMediator"))

var_0_0.OPEN_RANK = "MilitaryExerciseMediator:OPEN_RANK"
var_0_0.OPEN_SHOP = "MilitaryExerciseMediator:OPEN_SHOP"
var_0_0.OPEN_DOCKYARD = "MilitaryExerciseMediator:OPEN_DOCKYARD"
var_0_0.REPLACE_RIVALS = "MilitaryExerciseMediator:REPLACE_RIVALS"
var_0_0.RECOVER_UP = "MilitaryExerciseMediator:RECOVER_UP"
var_0_0.START_BATTLE = "MilitaryExerciseMediator:START_BATTLE"
var_0_0.OPEN_RIVAL_INFO = "MilitaryExerciseMediator:OPEN_RIVAL_INFO"

function var_0_0.register(arg_1_0)
	arg_1_0.viewComponent:updatePlayer((getProxy(PlayerProxy):getData()))
	arg_1_0.viewComponent:setShips((getProxy(BayProxy):getRawData()))
	arg_1_0:bind(var_0_0.OPEN_RANK, function(arg_2_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.BILLBOARD, {
			page = PowerRank.TYPE_MILITARY_RANK
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_RIVAL_INFO, function(arg_3_0, arg_3_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = RivalInfoLayer,
			mediator = RivalInfoMediator,
			data = {
				rival = arg_3_1,
				type = RivalInfoLayer.TYPE_BATTLE
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_DOCKYARD, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.EXERCISEFORMATION)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_SHOP, function(arg_5_0, arg_5_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHOP, arg_5_1 or {
			warp = NewShopsScene.TYPE_MILITARY_SHOP
		})

		return
	end)
	arg_1_0:bind(var_0_0.REPLACE_RIVALS, function(arg_6_0)
		arg_1_0:sendNotification(GAME.REPLACE_RIVALS)

		return
	end)

	local var_1_0 = getProxy(ActivityProxy):getMilitaryExerciseActivity()

	assert(var_1_0, "不存在该活动")
	arg_1_0.viewComponent:setActivity(var_1_0)

	local var_1_1 = getProxy(MilitaryExerciseProxy):getSeasonInfo()

	if var_1_1 then
		arg_1_0.viewComponent:setSeasonInfo(var_1_1)
	else
		arg_1_0:sendNotification(GAME.GET_SEASON_INFO)
	end

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		GAME.REPLACE_RIVALS_DONE,
		GAME.GET_SEASON_INFO_DONE,
		MilitaryExerciseProxy.EXERCISE_FLEET_UPDATED,
		PlayerProxy.UPDATED,
		MilitaryExerciseProxy.SEASON_INFO_UPDATED,
		GAME.MILITARY_STARTED,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GAME.REPLACE_RIVALS_DONE then
		arg_8_0.viewComponent:setRivals(var_8_1)
		arg_8_0.viewComponent:updateRivals()
		pg.TipsMgr.GetInstance():ShowTips(i18n("exercise_replace_rivals_ok_tip"))
	elseif var_8_0 == GAME.GET_SEASON_INFO_DONE then
		arg_8_0.viewComponent:setSeasonInfo(var_8_1)
	elseif var_8_0 == MilitaryExerciseProxy.EXERCISE_FLEET_UPDATED then
		arg_8_0.viewComponent:setFleet(var_8_1)
		arg_8_0.viewComponent:initPlayerFleet()
	elseif var_8_0 == PlayerProxy.UPDATED then
		arg_8_0.viewComponent:updatePlayer(var_8_1)
	elseif var_8_0 == MilitaryExerciseProxy.SEASON_INFO_UPDATED then
		arg_8_0.viewComponent:updateSeaInfoVO(var_8_1)
		arg_8_0.viewComponent:updateSeasonTime()
	elseif var_8_0 == GAME.MILITARY_STARTED then
		arg_8_0:addSubLayers(Context.New({
			mediator = ExercisePreCombatMediator,
			viewComponent = ExercisePreCombatLayer,
			data = {
				stageId = 80000,
				system = var_8_1.system,
				rivalId = var_8_1.rivalId
			}
		}))
	elseif var_8_0 == ActivityProxy.ACTIVITY_UPDATED and var_8_1.id == ActivityConst.MILITARY_EXERCISE_ACTIVITY_ID then
		arg_8_0.viewComponent:setActivity(var_8_1)
		arg_8_0.viewComponent:updateSeasonLeftTime(var_8_1.stopTime)
	end

	return
end

return var_0_0
