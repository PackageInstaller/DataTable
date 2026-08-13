class = var_0_10000

local var_0_0 = "DOAYearHotSpringShipSelectMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.EXTEND = "DOAYearHotSpringShipSelectMediator:EXTEND"
var_0_1.OPEN_CHUANWU = "DOAYearHotSpringShipSelectMediator:OPEN_CHUANWU"
var_0_1.LOOG_PRESS_SHIP = "DOAYearHotSpringShipSelectMediator:LOOG_PRESS_SHIP"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.EXTEND, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		DOAYearHotSpringMediator = var_2_10003

		var_2_1(var_2_0, var_2_10003.UNLOCK_SLOT, arg_1_0.contextData.actId)

		return
	end)
	arg_1_0:bind(var_0_1.LOOG_PRESS_SHIP, function(arg_3_0, arg_3_1, arg_3_2)
		pg = var_2_10003

		local var_3_0 = var_2_10003.m02
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_3_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_3_1(var_3_0, var_3_2, var_2_10006.SHIPINFO, {
			shipId = arg_3_2.id
		})

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.OPEN_CHUANWU, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		DOAYearHotSpringMediator = var_2_10005

		var_4_1(var_4_0, var_2_10005.OPEN_CHUANWU, {
			arg_4_1,
			arg_4_2
		})

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityById(var_1_1, arg_1_0.contextData.actId)
	local var_1_3 = arg_1_0.viewComponent

	var_2.SetActivity(var_1_3, var_1_2)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.EXTEND_BACKYARD_DONE
	ActivityProxy = var_2
	var_5_0[2] = var_2.ACTIVITY_UPDATED

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1
	local var_6_2 = arg_6_1.getBody(var_6_1)

	GAME = var_6_1

	local var_6_4

	if var_6_0 == var_6_1.EXTEND_BACKYARD_DONE then
		pg = var_6_4

		local var_6_3 = var_6_4.TipsMgr.GetInstance()

		var_6_4 = var_6_4.ShowTips
		i18n = var_1_10006

		var_6_4(var_6_3, var_1_10006("backyard_backyardShipInfoMediator_ok_unlock"))

		local var_6_5 = arg_6_0.viewComponent

		var_6_4.UpdateSlots(var_6_5)
	else
		ActivityProxy = var_6_4

		if var_6_0 == var_6_4.ACTIVITY_UPDATED then
			local var_6_6 = var_6_2
			local var_6_7 = var_6_2.getConfig(var_6_6, "type")

			ActivityConst = var_6_6

			if var_6_7 == var_6_6.ACTIVITY_TYPE_HOTSPRING then
				local var_6_8 = arg_6_0.viewComponent

				var_4.SetActivity(var_6_8, var_6_2)

				local var_6_9 = arg_6_0.viewComponent

				var_4.UpdateSlots(var_6_9)
			end
		end
	end

	return
end

function var_0_1.remove(arg_7_0)
	return
end

return var_0_1
