local var_0_0 = class("AnniversaryIsland2023Mediator", import("..TemplateMV.BackHillMediatorTemplate"))

function var_0_0.register(arg_1_0)
	var_0_0.super.register(arg_1_0)
	arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, {
		cmd = 2,
		activity_id = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2).id
	})

	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	local var_2_0 = var_0_0.super.listNotificationInterests(arg_2_0)

	table.insertto(var_2_0, {
		ActivityProxy.ACTIVITY_SHOW_AWARDS
	})

	return var_2_0
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	var_0_0.super.handleNotification(arg_3_0, arg_3_1)

	local var_3_0 = arg_3_1:getBody()

	if arg_3_1:getName() == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		arg_3_0:addSubLayers(Context.New({
			mediator = AwardInfoMediator,
			viewComponent = AnniversaryIslandAwardLayer,
			data = {
				items = var_3_0.awards
			},
			onRemoved = var_3_0.callback
		}))
	end

	return
end

function var_0_0.CheckPreloadData(arg_4_0, arg_4_1)
	if getProxy(ContextProxy):getContextByMediator(AnniversaryIsland2023Mediator) then
		arg_4_0.prevContext = arg_4_0.prevContext or getProxy(ContextProxy):getCurrentContext()

		getProxy(ContextProxy):CleanUntilMediator(AnniversaryIsland2023Mediator)
	else
		local var_4_0 = Context.New()

		SCENE.SetSceneInfo(var_4_0, SCENE.ANNIVERSARY_ISLAND_BACKHILL_2023)

		local var_4_1 = getProxy(ContextProxy):getCurrentContext()

		var_4_0:extendData({
			fromMediatorName = var_4_1.mediator.__cname
		})
		getProxy(ContextProxy):pushContext(var_4_0)

		arg_4_0.prevContext = arg_4_0.prevContext or var_4_1
	end

	existCall(arg_4_1)

	return
end

return var_0_0
