class = var_0_10000

local var_0_0 = "AnniversaryIslandSpringShipSelectMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.BackHills.NewYearFestival.NewYearHotSpringShipSelectMediator"))

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.LOOG_PRESS_SHIP, function(arg_2_0, arg_2_1, arg_2_2)
		pg = var_2_10003

		local var_2_0 = var_2_10003.m02
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_2_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_2_1(var_2_0, var_2_2, var_2_10006.SHIPINFO, {
			shipId = arg_2_2.id
		})

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.OPEN_CHUANWU, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		AnniversaryIslandHotSpringMediator = var_2_10005

		var_3_1(var_3_0, var_2_10005.OPEN_CHUANWU, {
			arg_3_1,
			arg_3_2
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

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	GAME = var_4_1

	local var_4_4

	if var_4_0 == var_4_1.EXTEND_BACKYARD_DONE then
		pg = var_4_4

		local var_4_3 = var_4_4.TipsMgr.GetInstance()

		var_4_4 = var_4_4.ShowTips
		i18n = var_1_10006

		var_4_4(var_4_3, var_1_10006("backyard_backyardShipInfoMediator_ok_unlock"))

		local var_4_5 = arg_4_0.viewComponent

		var_4_4.UpdateSlots(var_4_5)
	else
		ActivityProxy = var_4_4

		if var_4_0 == var_4_4.ACTIVITY_UPDATED then
			local var_4_6 = var_4_2
			local var_4_7 = var_4_2.getConfig(var_4_6, "type")

			ActivityConst = var_4_6

			if var_4_7 == var_4_6.ACTIVITY_TYPE_HOTSPRING_2 then
				local var_4_8 = arg_4_0.viewComponent

				var_4.SetActivity(var_4_8, var_4_2)

				local var_4_9 = arg_4_0.viewComponent

				var_4.UpdateSlots(var_4_9)
			end
		end
	end

	return
end

return var_0_1
