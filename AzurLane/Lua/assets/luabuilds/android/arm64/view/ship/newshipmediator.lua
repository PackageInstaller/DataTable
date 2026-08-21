local var_0_0 = class("NewShipMediator", import("..base.ContextMediator"))

var_0_0.ON_LOCK = "NewShipMediator:ON_LOCK"
var_0_0.ON_EXIT = "NewShipMediator:ON_EXIT"
var_0_0.ON_SKILLINFO = "NewShipMediator:ON_SKILLINFO"
var_0_0.ON_EVALIATION = "NewShipMediator:ON_EVALIATION"
var_0_0.ON_SKIP_BATCH = "NewShipMediator:ON_SKIP_BATCH"

function var_0_0.register(arg_1_0)
	arg_1_0.fromRemould = arg_1_0.contextData.fromRemould

	assert(arg_1_0.contextData.ship, "必须存在船")

	arg_1_0.showTrans = arg_1_0.contextData.ship:isRemoulded()

	arg_1_0.viewComponent:setShip(arg_1_0.contextData.ship)
	arg_1_0:bind(var_0_0.ON_EXIT, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0.contextData.onExit or GAME.REMOVE_LAYERS

		arg_1_0:sendNotification(var_2_0, {
			context = getProxy(ContextProxy):getCurrentContext():getContextByMediator(arg_1_0.class)
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SKIP_BATCH, function(arg_3_0, arg_3_1, arg_3_2)
		getProxy(BuildShipProxy):setSkipBatchBuildFlag(true)

		local var_3_0 = arg_1_0.contextData.onExit or GAME.REMOVE_LAYERS

		arg_1_0:sendNotification(var_3_0, {
			context = getProxy(ContextProxy):getCurrentContext():getContextByMediator(arg_1_0.class)
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_LOCK, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:sendNotification(GAME.UPDATE_LOCK, {
			ship_id_list = arg_4_1,
			is_locked = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SKILLINFO, function(arg_5_0, arg_5_1, arg_5_2)
		arg_1_0:addSubLayers(Context.New({
			mediator = SkillInfoMediator,
			viewComponent = SkillInfoLayer,
			data = {
				fromNewShip = true,
				skillOnShip = arg_5_2,
				skillId = arg_5_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ON_EVALIATION, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.FETCH_EVALUATION, arg_6_1)

		return
	end)

	if arg_1_0.contextData.ship:getRarity() >= 4 and not getProxy(PlayerProxy):getData():GetCommonFlag(GAME_RESTOREVIEW_ALREADY) then
		pg.SdkMgr.GetInstance():StoreReview()
		arg_1_0:sendNotification(GAME.COMMON_FLAG, {
			flagID = GAME_RESTOREVIEW_ALREADY
		})
	end

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		GAME.UPDATE_LOCK_DONE,
		GAME.FETCH_EVALUATION_DONE
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GAME.UPDATE_LOCK_DONE then
		arg_8_0.viewComponent:UpdateLockButton(var_8_1:GetLockState())
		arg_8_0.viewComponent:updateShip(var_8_1)
	elseif var_8_0 == GAME.FETCH_EVALUATION_DONE then
		if arg_8_0.fromRemould then
			return
		end

		arg_8_0:addSubLayers(Context.New({
			mediator = ShipEvaluationMediator,
			viewComponent = ShipEvaluationLayer,
			data = {
				groupId = var_8_1,
				showTrans = arg_8_0.showTrans
			}
		}))
	end

	return
end

return var_0_0
