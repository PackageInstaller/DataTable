class = var_0_10000

local var_0_0 = "NewShipMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.ON_LOCK = "NewShipMediator:ON_LOCK"
var_0_1.ON_EXIT = "NewShipMediator:ON_EXIT"
var_0_1.ON_SKILLINFO = "NewShipMediator:ON_SKILLINFO"
var_0_1.ON_EVALIATION = "NewShipMediator:ON_EVALIATION"
var_0_1.ON_SKIP_BATCH = "NewShipMediator:ON_SKIP_BATCH"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0.contextData.ship

	arg_1_0.fromRemould = arg_1_0.contextData.fromRemould
	assert = var_2

	var_2(var_1_0, "必须存在船")

	arg_1_0.showTrans = var_1_0:isRemoulded()

	local var_1_1 = arg_1_0.viewComponent

	var_2.setShip(var_1_1, var_1_0)
	arg_1_0:bind(var_0_1.ON_EXIT, function(arg_2_0, arg_2_1, arg_2_2)
		getProxy = var_2_10003
		ContextProxy = var_2_10004

		local var_2_0 = var_2_10003(var_2_10004)
		local var_2_1 = var_3.getCurrentContext(var_2_0)
		local var_2_2 = var_4.getContextByMediator(var_2_1, arg_1_0.class)
		local var_2_3 = arg_1_0
		local var_2_4 = var_6.sendNotification
		local var_2_5

		if not arg_1_0.contextData.onExit then
			GAME = var_2_5
			var_2_5 = var_2_5.REMOVE_LAYERS
		end

		var_2_4(var_2_3, var_2_5, {
			context = var_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SKIP_BATCH, function(arg_3_0, arg_3_1, arg_3_2)
		getProxy = var_2_10003
		BuildShipProxy = var_2_10004

		local var_3_0 = var_2_10003(var_2_10004)

		var_3.setSkipBatchBuildFlag(var_3_0, true)

		getProxy = var_3
		ContextProxy = var_3_0

		local var_3_1 = var_3(var_3_0)
		local var_3_2 = var_3.getCurrentContext(var_3_1)
		local var_3_3 = var_4.getContextByMediator(var_3_2, arg_1_0.class)
		local var_3_4 = arg_1_0
		local var_3_5 = var_6.sendNotification
		local var_3_6

		if not arg_1_0.contextData.onExit then
			GAME = var_3_6
			var_3_6 = var_3_6.REMOVE_LAYERS
		end

		var_3_5(var_3_4, var_3_6, {
			context = var_3_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_LOCK, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.UPDATE_LOCK, {
			ship_id_list = arg_4_1,
			is_locked = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SKILLINFO, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.addSubLayers

		Context = var_2_10005

		local var_5_2 = var_2_10005.New
		local var_5_3 = {}

		SkillInfoMediator = var_2_10007
		var_5_3.mediator = var_2_10007
		SkillInfoLayer = var_2_10007
		var_5_3.viewComponent = var_2_10007
		var_5_3.data = {
			fromNewShip = true,
			skillOnShip = arg_5_2,
			skillId = arg_5_1
		}

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)

	local var_1_2 = arg_1_0

	arg_1_0.bind(var_1_2, var_0_1.ON_EVALIATION, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		var_6_1(var_6_0, var_2_10004.FETCH_EVALUATION, arg_6_1)

		return
	end)

	getProxy = var_2
	PlayerProxy = var_1_2

	local var_1_3 = var_2(var_1_2)
	local var_1_4 = var_2.getData(var_1_3)

	if var_1_0:getRarity() >= 4 then
		local var_1_5 = var_1_4
		local var_1_6 = var_1_4.GetCommonFlag

		GAME_RESTOREVIEW_ALREADY = var_1_10006

		if not var_1_6(var_1_5, var_1_10006) then
			pg = var_4

			local var_1_7 = var_4.SdkMgr.GetInstance()

			var_4.StoreReview(var_1_7)

			local var_1_8 = arg_1_0
			local var_1_9 = arg_1_0.sendNotification

			GAME = var_1_10006

			local var_1_10 = var_1_10006.COMMON_FLAG
			local var_1_11 = {}

			GAME_RESTOREVIEW_ALREADY = var_1_10008
			var_1_11.flagID = var_1_10008

			var_1_9(var_1_8, var_1_10, var_1_11)
		end
	end

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	GAME = var_1_10002
	var_7_0[1] = var_1_10002.UPDATE_LOCK_DONE
	GAME = var_2
	var_7_0[2] = var_2.FETCH_EVALUATION_DONE

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1
	local var_8_2 = arg_8_1.getBody(var_8_1)

	GAME = var_8_1

	if var_8_0 == var_8_1.UPDATE_LOCK_DONE then
		local var_8_3 = arg_8_0.viewComponent

		var_4.UpdateLockButton(var_8_3, var_8_2:GetLockState())

		local var_8_4 = arg_8_0.viewComponent

		var_4.updateShip(var_8_4, var_8_2)
	else
		GAME = var_4

		if var_8_0 == var_4.FETCH_EVALUATION_DONE then
			if arg_8_0.fromRemould then
				return
			end

			local var_8_5 = arg_8_0
			local var_8_6 = arg_8_0.addSubLayers

			Context = var_1_10006

			local var_8_7 = var_1_10006.New
			local var_8_8 = {}

			ShipEvaluationMediator = var_1_10008
			var_8_8.mediator = var_1_10008
			ShipEvaluationLayer = var_1_10008
			var_8_8.viewComponent = var_1_10008
			var_8_8.data = {
				groupId = var_8_2,
				showTrans = arg_8_0.showTrans
			}

			var_8_6(var_8_5, var_8_7(var_8_8))
		end
	end

	return
end

return var_0_1
