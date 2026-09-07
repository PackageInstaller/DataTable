local MilitaryExerciseMediator = class("MilitaryExerciseMediator", import("..base.ContextMediator"))

MilitaryExerciseMediator.OPEN_RANK = "MilitaryExerciseMediator:OPEN_RANK"
MilitaryExerciseMediator.OPEN_SHOP = "MilitaryExerciseMediator:OPEN_SHOP"
MilitaryExerciseMediator.OPEN_DOCKYARD = "MilitaryExerciseMediator:OPEN_DOCKYARD"
MilitaryExerciseMediator.REPLACE_RIVALS = "MilitaryExerciseMediator:REPLACE_RIVALS"
MilitaryExerciseMediator.RECOVER_UP = "MilitaryExerciseMediator:RECOVER_UP"
MilitaryExerciseMediator.START_BATTLE = "MilitaryExerciseMediator:START_BATTLE"
MilitaryExerciseMediator.OPEN_RIVAL_INFO = "MilitaryExerciseMediator:OPEN_RIVAL_INFO"

function MilitaryExerciseMediator:register()
	self.viewComponent:updatePlayer((getProxy(PlayerProxy):getData()))
	self.viewComponent:setShips((getProxy(BayProxy):getRawData()))
	self:bind(MilitaryExerciseMediator.OPEN_RANK, function(arg_2_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.BILLBOARD, {
			page = PowerRank.TYPE_MILITARY_RANK
		})

		return
	end)
	self:bind(MilitaryExerciseMediator.OPEN_RIVAL_INFO, function(arg_3_0, arg_3_1)
		self:addSubLayers(Context.New({
			viewComponent = RivalInfoLayer,
			mediator = RivalInfoMediator,
			data = {
				rival = arg_3_1,
				type = RivalInfoLayer.TYPE_BATTLE
			}
		}))

		return
	end)
	self:bind(MilitaryExerciseMediator.OPEN_DOCKYARD, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.GO_SCENE, SCENE.EXERCISEFORMATION)

		return
	end)
	self:bind(MilitaryExerciseMediator.OPEN_SHOP, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHOP, arg_5_1 or {
			warp = NewShopsScene.TYPE_MILITARY_SHOP
		})

		return
	end)
	self:bind(MilitaryExerciseMediator.REPLACE_RIVALS, function(arg_6_0)
		self:sendNotification(GAME.REPLACE_RIVALS)

		return
	end)

	local var_1_0 = getProxy(ActivityProxy):getMilitaryExerciseActivity()

	assert(var_1_0, "不存在该活动")
	self.viewComponent:setActivity(var_1_0)

	local var_1_1 = getProxy(MilitaryExerciseProxy):getSeasonInfo()

	if var_1_1 then
		self.viewComponent:setSeasonInfo(var_1_1)
	else
		self:sendNotification(GAME.GET_SEASON_INFO)
	end

	return
end

function MilitaryExerciseMediator:listNotificationInterests()
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

function MilitaryExerciseMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GAME.REPLACE_RIVALS_DONE then
		self.viewComponent:setRivals(var_8_1)
		self.viewComponent:updateRivals()
		pg.TipsMgr.GetInstance():ShowTips(i18n("exercise_replace_rivals_ok_tip"))
	elseif var_8_0 == GAME.GET_SEASON_INFO_DONE then
		self.viewComponent:setSeasonInfo(var_8_1)
	elseif var_8_0 == MilitaryExerciseProxy.EXERCISE_FLEET_UPDATED then
		self.viewComponent:setFleet(var_8_1)
		self.viewComponent:initPlayerFleet()
	elseif var_8_0 == PlayerProxy.UPDATED then
		self.viewComponent:updatePlayer(var_8_1)
	elseif var_8_0 == MilitaryExerciseProxy.SEASON_INFO_UPDATED then
		self.viewComponent:updateSeaInfoVO(var_8_1)
		self.viewComponent:updateSeasonTime()
	elseif var_8_0 == GAME.MILITARY_STARTED then
		self:addSubLayers(Context.New({
			mediator = ExercisePreCombatMediator,
			viewComponent = ExercisePreCombatLayer,
			data = {
				stageId = 80000,
				system = var_8_1.system,
				rivalId = var_8_1.rivalId
			}
		}))
	elseif var_8_0 == ActivityProxy.ACTIVITY_UPDATED and var_8_1.id == ActivityConst.MILITARY_EXERCISE_ACTIVITY_ID then
		self.viewComponent:setActivity(var_8_1)
		self.viewComponent:updateSeasonLeftTime(var_8_1.stopTime)
	end

	return
end

return MilitaryExerciseMediator
