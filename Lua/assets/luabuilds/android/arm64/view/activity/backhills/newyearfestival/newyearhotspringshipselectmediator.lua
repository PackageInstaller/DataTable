local var_0_0 = class("NewYearHotSpringShipSelectMediator", import("view.base.ContextMediator"))

var_0_0.EXTEND = "NewYearHotSpringShipSelectMediator:EXTEND"
var_0_0.OPEN_CHUANWU = "NewYearHotSpringShipSelectMediator:OPEN_CHUANWU"
var_0_0.LOOG_PRESS_SHIP = "NewYearHotSpringShipSelectMediator:LOOG_PRESS_SHIP"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.EXTEND, function(arg_2_0)
		arg_1_0:sendNotification(NewYearHotSpringMediator.UNLOCK_SLOT, arg_1_0.contextData.actId)

		return
	end)
	arg_1_0:bind(var_0_0.LOOG_PRESS_SHIP, function(arg_3_0, arg_3_1, arg_3_2)
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_3_2.id
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CHUANWU, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:sendNotification(NewYearHotSpringMediator.OPEN_CHUANWU, {
			arg_4_1,
			arg_4_2
		})

		return
	end)
	arg_1_0.viewComponent:SetActivity((getProxy(ActivityProxy):getActivityById(arg_1_0.contextData.actId)))

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		GAME.EXTEND_BACKYARD_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == GAME.EXTEND_BACKYARD_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardShipInfoMediator_ok_unlock"))
		arg_6_0.viewComponent:UpdateSlots()
	elseif var_6_0 == ActivityProxy.ACTIVITY_UPDATED and var_6_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_HOTSPRING then
		arg_6_0.viewComponent:SetActivity(var_6_1)
		arg_6_0.viewComponent:UpdateSlots()
	end

	return
end

function var_0_0.remove(arg_7_0)
	return
end

return var_0_0
