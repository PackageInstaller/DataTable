local var_0_0 = class("AtelierMediator", import("view.base.ContextMediator"))

function var_0_0.register(arg_1_0)
	arg_1_0:bind(GAME.UPDATE_ATELIER_BUFF, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.UPDATE_ATELIER_BUFF, arg_2_1)

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

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK)

	assert(var_1_0 and not var_1_0:isEnd())
	arg_1_0.viewComponent:SetActivity(var_1_0)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.UPDATE_ATELIER_BUFF_DONE
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == nil then
		-- block empty
	elseif var_5_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_5_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_ATELIER_LINK then
			arg_5_0.viewComponent:SetActivity(var_5_1)
		end
	elseif var_5_0 == GAME.UPDATE_ATELIER_BUFF_DONE then
		arg_5_0.viewComponent:OnUpdateAtelierBuff()
	end

	return
end

function var_0_0.remove(arg_6_0)
	return
end

return var_0_0
