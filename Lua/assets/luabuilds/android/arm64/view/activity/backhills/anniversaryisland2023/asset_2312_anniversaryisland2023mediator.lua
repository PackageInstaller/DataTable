local AnniversaryIsland2023Mediator = class("AnniversaryIsland2023Mediator", import("..TemplateMV.BackHillMediatorTemplate"))

function AnniversaryIsland2023Mediator:register()
	AnniversaryIsland2023Mediator.super.register(self)
	self:sendNotification(GAME.ACTIVITY_OPERATION, {
		cmd = 2,
		activity_id = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2).id
	})

	return
end

function AnniversaryIsland2023Mediator:listNotificationInterests()
	local var_2_0 = AnniversaryIsland2023Mediator.super.listNotificationInterests(self)

	table.insertto(var_2_0, {
		ActivityProxy.ACTIVITY_SHOW_AWARDS
	})

	return var_2_0
end

function AnniversaryIsland2023Mediator:handleNotification(arg_3_1)
	AnniversaryIsland2023Mediator.super.handleNotification(self, arg_3_1)

	local var_3_0 = arg_3_1:getBody()

	if arg_3_1:getName() == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		self:addSubLayers(Context.New({
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

function AnniversaryIsland2023Mediator:CheckPreloadData(arg_4_1)
	if getProxy(ContextProxy):getContextByMediator(AnniversaryIsland2023Mediator) then
		self.prevContext = self.prevContext or getProxy(ContextProxy):getCurrentContext()

		getProxy(ContextProxy):CleanUntilMediator(AnniversaryIsland2023Mediator)
	else
		local var_4_0 = Context.New()

		SCENE.SetSceneInfo(var_4_0, SCENE.ANNIVERSARY_ISLAND_BACKHILL_2023)

		local var_4_1 = getProxy(ContextProxy):getCurrentContext()

		var_4_0:extendData({
			fromMediatorName = var_4_1.mediator.__cname
		})
		getProxy(ContextProxy):pushContext(var_4_0)

		self.prevContext = self.prevContext or var_4_1
	end

	existCall(arg_4_1)

	return
end

return AnniversaryIsland2023Mediator
