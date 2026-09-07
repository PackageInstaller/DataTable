local EducateMapMediator = class("EducateMapMediator", import("..base.EducateContextMediator"))

EducateMapMediator.ON_SPECIAL_EVENT_TRIGGER = "EducateMapMediator.ON_SPECIAL_EVENT_TRIGGER"
EducateMapMediator.ON_MAP_SITE_OPERATE = "EducateMapMediator.ON_MAP_SITE_OPERATE"
EducateMapMediator.ON_OPEN_SHOP = "EducateMapMediator.ON_OPEN_SHOP"
EducateMapMediator.ON_ADD_TASK_PROGRESS = "EducateMapMediator.ON_ADD_TASK_PROGRESS"

function EducateMapMediator:register()
	self:bind(EducateMapMediator.ON_SPECIAL_EVENT_TRIGGER, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.EDUCATE_TRIGGER_SPEC_EVENT, {
			siteId = arg_2_1.siteId,
			eventId = arg_2_1.id,
			callback = arg_2_1.callback
		})

		return
	end)
	self:bind(EducateMapMediator.ON_MAP_SITE_OPERATE, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.EDUCATE_MAP_SITE, {
			siteId = arg_3_1.siteId,
			optionVO = arg_3_1.optionVO
		})

		return
	end)
	self:bind(EducateMapMediator.ON_OPEN_SHOP, function(arg_4_0, arg_4_1)
		self:addSubLayers(Context.New({
			mediator = EducateShopMediator,
			viewComponent = EducateShopLayer,
			data = {
				shopId = arg_4_1
			}
		}))

		return
	end)
	self:bind(EducateMapMediator.ON_ADD_TASK_PROGRESS, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.EDUCATE_ADD_TASK_PROGRESS, {
			system = arg_5_1.system,
			progresses = arg_5_1.progresses
		})

		return
	end)

	return
end

function EducateMapMediator:listNotificationInterests()
	return {
		EducateProxy.RESOURCE_UPDATED,
		EducateProxy.ATTR_UPDATED,
		EducateProxy.BUFF_ADDED,
		EducateProxy.TIME_UPDATED,
		EducateProxy.TIME_WEEKDAY_UPDATED,
		EducateTaskProxy.TASK_UPDATED,
		EducateTaskProxy.TASK_ADDED,
		EducateTaskProxy.TASK_REMOVED,
		EducateProxy.CLEAR_NEW_TIP,
		GAME.EDUCATE_REFRESH_DONE,
		GAME.EDUCATE_SUBMIT_TASK_DONE,
		GAME.EDUCATE_TRIGGER_SPEC_EVENT_DONE,
		GAME.EDUCATE_MAP_SITE_DONE
	}
end

function EducateMapMediator:handleNotification(arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1:getBody()

	if var_7_0 == EducateProxy.RESOURCE_UPDATED then
		self.viewComponent:updateRes()
	elseif var_7_0 == EducateProxy.ATTR_UPDATED then
		self.viewComponent:updateAttrs()
	elseif var_7_0 == EducateProxy.BUFF_ADDED then
		self.viewComponent:updateAttrs()
	elseif var_7_0 == EducateProxy.TIME_UPDATED then
		self.viewComponent:updateTime()
		self.viewComponent:updateRes()
		self.viewComponent:updateTarget()
	elseif var_7_0 == EducateProxy.TIME_WEEKDAY_UPDATED then
		self.viewComponent:updateTimeWeekDay(var_7_1.weekDay)
	elseif var_7_0 == EducateTaskProxy.TASK_UPDATED or var_7_0 == EducateTaskProxy.TASK_ADDED or var_7_0 == EducateTaskProxy.TASK_REMOVED or var_7_0 == GAME.EDUCATE_SUBMIT_TASK_DONE then
		self.viewComponent:updateTarget()
	elseif var_7_0 == EducateProxy.CLEAR_NEW_TIP then
		if var_7_1.index == EducateTipHelper.NEW_SITE then
			self.viewComponent:clearNewTip(var_7_1.id)
		end
	elseif var_7_0 == GAME.EDUCATE_REFRESH_DONE then
		self.viewComponent:emit(EducateBaseUI.EDUCATE_CHANGE_SCENE, SCENE.EDUCATE)
	elseif var_7_0 == GAME.EDUCATE_TRIGGER_SPEC_EVENT_DONE then
		if var_7_1.type == EducateSpecialEvent.TYPE_SITE then
			self.viewComponent:ShowSpecEvent(var_7_1.siteId, var_7_1.id, var_7_1.drops, var_7_1.cb)
		end
	elseif var_7_0 == GAME.EDUCATE_MAP_SITE_DONE then
		assert(var_7_1.branchId ~= 0, "请检查配置, 无返回结果分支, optionId: " .. var_7_1.optionId)
		self.viewComponent:ShowSitePerform(var_7_1.optionId, var_7_1.branchId, var_7_1.events, var_7_1.drops, var_7_1.eventDrops)
	end

	return
end

return EducateMapMediator
