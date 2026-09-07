local NewYearHotSpringShipSelectMediator = class("NewYearHotSpringShipSelectMediator", import("view.base.ContextMediator"))

NewYearHotSpringShipSelectMediator.EXTEND = "NewYearHotSpringShipSelectMediator:EXTEND"
NewYearHotSpringShipSelectMediator.OPEN_CHUANWU = "NewYearHotSpringShipSelectMediator:OPEN_CHUANWU"
NewYearHotSpringShipSelectMediator.LOOG_PRESS_SHIP = "NewYearHotSpringShipSelectMediator:LOOG_PRESS_SHIP"

function NewYearHotSpringShipSelectMediator:register()
	self:bind(NewYearHotSpringShipSelectMediator.EXTEND, function(arg_2_0)
		self:sendNotification(NewYearHotSpringMediator.UNLOCK_SLOT, self.contextData.actId)

		return
	end)
	self:bind(NewYearHotSpringShipSelectMediator.LOOG_PRESS_SHIP, function(arg_3_0, arg_3_1, arg_3_2)
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_3_2.id
		})

		return
	end)
	self:bind(NewYearHotSpringShipSelectMediator.OPEN_CHUANWU, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(NewYearHotSpringMediator.OPEN_CHUANWU, {
			arg_4_1,
			arg_4_2
		})

		return
	end)
	self.viewComponent:SetActivity((getProxy(ActivityProxy):getActivityById(self.contextData.actId)))

	return
end

function NewYearHotSpringShipSelectMediator:listNotificationInterests()
	return {
		GAME.EXTEND_BACKYARD_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function NewYearHotSpringShipSelectMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == GAME.EXTEND_BACKYARD_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardShipInfoMediator_ok_unlock"))
		self.viewComponent:UpdateSlots()
	elseif var_6_0 == ActivityProxy.ACTIVITY_UPDATED and var_6_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_HOTSPRING then
		self.viewComponent:SetActivity(var_6_1)
		self.viewComponent:UpdateSlots()
	end

	return
end

function NewYearHotSpringShipSelectMediator:remove()
	return
end

return NewYearHotSpringShipSelectMediator
