class = var_0_10000

local var_0_0 = "AtelierCompositeMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.OPEN_FORMULA = "OPEN_FORMULA"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	GAME = var_1_10003

	var_1_1(var_1_0, var_1_10003.COMPOSITE_ATELIER_RECIPE, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.COMPOSITE_ATELIER_RECIPE, {
			formulaId = arg_1_0.contextData.formulaId,
			items = arg_2_1,
			repeats = arg_2_2
		})

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

	local var_1_4 = arg_1_0.viewComponent

	var_1.InitView(var_1_4)

	getProxy = var_1
	ActivityProxy = var_1_4

	local var_1_5 = var_1(var_1_4)
	local var_1_6 = var_1.getActivityByType

	ActivityConst = var_3

	local var_1_7 = var_1_6(var_1_5, var_3.ACTIVITY_TYPE_ATELIER_LINK)
	local var_1_8

	if not arg_1_0.contextData.versionIndex then
		var_1_8 = 1
	end

	AtelierTools = var_3

	local var_1_9 = var_3.IsUnlockAtelier(var_1_7, var_1_8)
	local var_1_10 = arg_1_0.viewComponent

	var_4.SetEnabled(var_1_10, var_1_9)

	local var_1_11 = arg_1_0.viewComponent

	var_4.SetActivity(var_1_11, var_1_7)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[1] = var_1_10002.COMPOSITE_ATELIER_RECIPE_DONE
	ActivityProxy = var_2
	var_4_0[2] = var_2.ACTIVITY_UPDATED
	var_4_0[3] = var_0_1.OPEN_FORMULA

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1
	local var_5_2 = arg_5_1.getBody(var_5_1)

	GAME = var_5_1

	if var_5_0 == var_5_1.COMPOSITE_ATELIER_RECIPE_DONE then
		local var_5_3 = arg_5_0.viewComponent

		var_4.OnCompositeResult(var_5_3, var_5_2)
	else
		ActivityProxy = var_4

		if var_5_0 == var_4.ACTIVITY_UPDATED then
			local var_5_4 = var_5_2
			local var_5_5 = var_5_2.getConfig(var_5_4, "type")

			ActivityConst = var_5_4

			if var_5_5 == var_5_4.ACTIVITY_TYPE_ATELIER_LINK then
				local var_5_6 = arg_5_0.viewComponent

				var_4.SetActivity(var_5_6, var_5_2)
			end
		elseif var_5_0 == var_0_1.OPEN_FORMULA then
			local var_5_7 = arg_5_0.viewComponent

			var_4.OnReceiveFormualRequest(var_5_7, var_5_2)
		end
	end

	return
end

function var_0_1.remove(arg_6_0)
	return
end

return var_0_1
