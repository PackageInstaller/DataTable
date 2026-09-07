local AnniversaryIslandSpringShipSelectMediator = class("AnniversaryIslandSpringShipSelectMediator", import("view.activity.BackHills.NewYearFestival.NewYearHotSpringShipSelectMediator"))

function AnniversaryIslandSpringShipSelectMediator:register()
	self:bind(AnniversaryIslandSpringShipSelectMediator.LOOG_PRESS_SHIP, function(arg_2_0, arg_2_1, arg_2_2)
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_2_2.id
		})

		return
	end)
	self:bind(AnniversaryIslandSpringShipSelectMediator.OPEN_CHUANWU, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(AnniversaryIslandHotSpringMediator.OPEN_CHUANWU, {
			arg_3_1,
			arg_3_2
		})

		return
	end)
	self.viewComponent:SetActivity((getProxy(ActivityProxy):getActivityById(self.contextData.actId)))

	return
end

function AnniversaryIslandSpringShipSelectMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == GAME.EXTEND_BACKYARD_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardShipInfoMediator_ok_unlock"))
		self.viewComponent:UpdateSlots()
	elseif var_4_0 == ActivityProxy.ACTIVITY_UPDATED and var_4_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_HOTSPRING_2 then
		self.viewComponent:SetActivity(var_4_1)
		self.viewComponent:UpdateSlots()
	end

	return
end

return AnniversaryIslandSpringShipSelectMediator
