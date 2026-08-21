local var_0_0 = class("AtelierCompositeMediator", import("view.base.ContextMediator"))

var_0_0.OPEN_FORMULA = "OPEN_FORMULA"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(GAME.COMPOSITE_ATELIER_RECIPE, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.COMPOSITE_ATELIER_RECIPE, {
			formulaId = arg_1_0.contextData.formulaId,
			items = arg_2_1,
			repeats = arg_2_2
		})

		return
	end)
	arg_1_0:bind(AtelierMaterialDetailMediator.SHOW_DETAIL, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_1:GetVersion() == 1 and AtelierMaterialDetailLayer or AtelierMaterialDetailYumiaLayer

		arg_1_0:addSubLayers(Context.New({
			mediator = AtelierMaterialDetailMediator,
			viewComponent = var_3_0,
			data = {
				material = arg_3_1
			}
		}))

		return
	end)
	arg_1_0.viewComponent:InitView()

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK)
	local var_1_1 = arg_1_0.contextData.versionIndex or 1

	arg_1_0.viewComponent:SetEnabled((AtelierTools.IsUnlockAtelier(var_1_0, var_1_1)))
	arg_1_0.viewComponent:SetActivity(var_1_0)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		GAME.COMPOSITE_ATELIER_RECIPE_DONE,
		ActivityProxy.ACTIVITY_UPDATED,
		var_0_0.OPEN_FORMULA
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.COMPOSITE_ATELIER_RECIPE_DONE then
		arg_5_0.viewComponent:OnCompositeResult(var_5_1)
	elseif var_5_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_5_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_ATELIER_LINK then
			arg_5_0.viewComponent:SetActivity(var_5_1)
		end
	elseif var_5_0 == var_0_0.OPEN_FORMULA then
		arg_5_0.viewComponent:OnReceiveFormualRequest(var_5_1)
	end

	return
end

function var_0_0.remove(arg_6_0)
	return
end

return var_0_0
