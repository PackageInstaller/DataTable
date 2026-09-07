local DOAYearHotSpringShipSelectMediator = class("DOAYearHotSpringShipSelectMediator", import("view.base.ContextMediator"))

DOAYearHotSpringShipSelectMediator.EXTEND = "DOAYearHotSpringShipSelectMediator:EXTEND"
DOAYearHotSpringShipSelectMediator.OPEN_CHUANWU = "DOAYearHotSpringShipSelectMediator:OPEN_CHUANWU"
DOAYearHotSpringShipSelectMediator.LOOG_PRESS_SHIP = "DOAYearHotSpringShipSelectMediator:LOOG_PRESS_SHIP"

function DOAYearHotSpringShipSelectMediator:register()
	self:bind(DOAYearHotSpringShipSelectMediator.EXTEND, function(arg_2_0)
		self:sendNotification(DOAYearHotSpringMediator.UNLOCK_SLOT, self.contextData.actId)

		return
	end)
	self:bind(DOAYearHotSpringShipSelectMediator.LOOG_PRESS_SHIP, function(arg_3_0, arg_3_1, arg_3_2)
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_3_2.id
		})

		return
	end)
	self:bind(DOAYearHotSpringShipSelectMediator.OPEN_CHUANWU, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(DOAYearHotSpringMediator.OPEN_CHUANWU, {
			arg_4_1,
			arg_4_2
		})

		return
	end)
	self.viewComponent:SetActivity((getProxy(ActivityProxy):getActivityById(self.contextData.actId)))

	return
end

function DOAYearHotSpringShipSelectMediator:listNotificationInterests()
	return {
		GAME.EXTEND_BACKYARD_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function DOAYearHotSpringShipSelectMediator:handleNotification(arg_6_1)
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

function DOAYearHotSpringShipSelectMediator:remove()
	return
end

return DOAYearHotSpringShipSelectMediator
