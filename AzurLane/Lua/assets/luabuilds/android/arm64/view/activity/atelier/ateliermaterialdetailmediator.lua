local var_0_0 = class("AtelierMaterialDetailMediator", import("view.base.ContextMediator"))

var_0_0.SHOW_DETAIL = "SHOW_DETAIL"
var_0_0.GO_RECIPE = "GO_RECIPE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(GAME.GO_SCENE, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0.viewComponent:closeView()
		arg_1_0:sendNotification(GAME.GO_SCENE, arg_2_1, arg_2_2)

		return
	end)
	arg_1_0:bind(var_0_0.GO_RECIPE, function(arg_3_0, arg_3_1)
		arg_1_0.viewComponent:closeView()
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.ATELIER_COMPOSITE, {
			formulaId = arg_3_1,
			activityID = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK).id
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getBody()

	if arg_5_1:getName() == nil then
		-- block empty
	end

	return
end

function var_0_0.remove(arg_6_0)
	return
end

return var_0_0
