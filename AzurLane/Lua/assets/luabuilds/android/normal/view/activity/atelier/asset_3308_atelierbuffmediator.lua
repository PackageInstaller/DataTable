class = var_0_10000

local var_0_0 = "AtelierMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	GAME = var_1_10003

	var_1_1(var_1_0, var_1_10003.UPDATE_ATELIER_BUFF, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.UPDATE_ATELIER_BUFF, arg_2_1)

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	AtelierMaterialDetailMediator = var_3

	var_1_3(var_1_2, var_3.SHOW_DETAIL, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_1:GetVersion()
		local var_3_1

		if var_3_0 == 1 then
			AtelierMaterialDetailLayer = var_3_1
		else
			AtelierMaterialDetailYumiaLayer = var_3_1
		end

		local var_3_2 = arg_1_0
		local var_3_3 = var_4.addSubLayers

		Context = var_2_10006

		local var_3_4 = var_2_10006.New
		local var_3_5 = {}

		AtelierMaterialDetailMediator = var_2_10008
		var_3_5.mediator = var_2_10008
		var_3_5.viewComponent = var_3_1
		var_3_5.data = {
			material = arg_3_1
		}

		var_3_3(var_3_2, var_3_4(var_3_5))

		return
	end)

	getProxy = var_1_3
	ActivityProxy = var_1_2

	local var_1_4 = var_1_3(var_1_2)
	local var_1_5 = var_1.getActivityByType

	ActivityConst = var_3

	local var_1_6 = var_1_5(var_1_4, var_3.ACTIVITY_TYPE_ATELIER_LINK)

	assert = var_1_4

	var_1_4(var_1_6 and not var_1_6:isEnd())

	local var_1_7 = arg_1_0.viewComponent

	var_2.SetActivity(var_1_7, var_1_6)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	ActivityProxy = var_1_10002
	var_4_0[1] = var_1_10002.ACTIVITY_UPDATED
	GAME = var_2
	var_4_0[2] = var_2.UPDATE_ATELIER_BUFF_DONE

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1
	local var_5_2 = arg_5_1.getBody(var_5_1)

	if var_5_0 == nil then
		-- block empty
	else
		ActivityProxy = var_5_1

		local var_5_4

		if var_5_0 == var_5_1.ACTIVITY_UPDATED then
			local var_5_3 = var_5_2

			var_5_4 = var_5_2.getConfig(var_5_3, "type")
			ActivityConst = var_5_3

			if var_5_4 == var_5_3.ACTIVITY_TYPE_ATELIER_LINK then
				local var_5_5 = arg_5_0.viewComponent

				var_5_4.SetActivity(var_5_5, var_5_2)
			end
		else
			GAME = var_5_4

			if var_5_0 == var_5_4.UPDATE_ATELIER_BUFF_DONE then
				local var_5_6 = arg_5_0.viewComponent

				var_4.OnUpdateAtelierBuff(var_5_6)
			end
		end
	end

	return
end

function var_0_1.remove(arg_6_0)
	return
end

return var_0_1
