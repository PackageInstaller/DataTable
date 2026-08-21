local var_0_0 = class("CrusingMediator", import("view.base.ContextMediator"))

var_0_0.UNFROZEN_MAP_UPDATE = "CrusingMediator.UN_FROZEN_MAP_UPDATE"
var_0_0.EVENT_OPEN_TASK = "CrusingMediator.EVENT_OPEN_TASK"
var_0_0.EVENT_GET_AWARD = "CrusingMediator.EVENT_GET_AWARD"
var_0_0.EVENT_GET_AWARD_PAY = "CrusingMediator.EVENT_GET_AWARD_PAY"
var_0_0.EVENT_GET_AWARD_ALL = "CrusingMediator.EVENT_GET_AWARD_ALL"
var_0_0.EVENT_GO_CHARGE = "CrusingMediator.EVENT_GO_CHARGE"
var_0_0.EVENT_OPEN_BIRTHDAY = "CrusingMediator.EVENT_OPEN_BIRTHDAY"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.EVENT_OPEN_TASK, function(arg_2_0)
		arg_1_0.contextData.frozenMapUpdate = true

		arg_1_0:addSubLayers(Context.New({
			mediator = CrusingTaskMediator,
			viewComponent = CrusingTaskLayer
		}))

		return
	end)
	arg_1_0:bind(var_0_0.EVENT_GET_AWARD, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.CRUSING_CMD, {
			cmd = 2,
			activity_id = arg_1_0.viewComponent.activity.id,
			arg1 = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.EVENT_GET_AWARD_PAY, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.CRUSING_CMD, {
			cmd = 3,
			activity_id = arg_1_0.viewComponent.activity.id,
			arg1 = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.EVENT_GET_AWARD_ALL, function(arg_5_0)
		arg_1_0:sendNotification(GAME.CRUSING_CMD, {
			cmd = 4,
			activity_id = arg_1_0.viewComponent.activity.id
		})

		return
	end)
	arg_1_0:bind(var_0_0.EVENT_GO_CHARGE, function(arg_6_0, arg_6_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChargeItemPanelMediator,
			viewComponent = ChargeItemPanelLayer,
			data = {
				panelConfig = arg_6_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.EVENT_OPEN_BIRTHDAY, function(arg_7_0, arg_7_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChargeBirthdayMediator,
			viewComponent = ChargeBirthdayLayer,
			data = {}
		}))

		return
	end)
	arg_1_0.viewComponent:setActivity((getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING)))
	arg_1_0.viewComponent:setPlayer(getProxy(PlayerProxy):getData())

	return
end

function var_0_0.listNotificationInterests(arg_8_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.CRUSING_CMD_DONE,
		var_0_0.UNFROZEN_MAP_UPDATE,
		PlayerProxy.UPDATED,
		GAME.CHARGE_SUCCESS
	}
end

function var_0_0.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_9_1.id == arg_9_0.viewComponent.activity.id then
			arg_9_0.viewComponent:setActivity(var_9_1)
			arg_9_0.viewComponent:updateAwardPanel()
			arg_9_0.viewComponent:updateMapStatus()
			arg_9_0.viewComponent:updateMapWay()
		end
	elseif var_9_0 == GAME.CRUSING_CMD_DONE then
		arg_9_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_9_1.awards)
	elseif var_9_0 == var_0_0.UNFROZEN_MAP_UPDATE then
		arg_9_0.contextData.frozenMapUpdate = false

		arg_9_0.viewComponent:updateMapWay()
	elseif var_9_0 == PlayerProxy.UPDATED then
		arg_9_0.viewComponent:setPlayer(var_9_1)
	elseif var_9_0 == GAME.CHARGE_SUCCESS then
		arg_9_0.viewComponent:OnChargeSuccess((Goods.Create({
			shop_id = var_9_1.shopId
		}, Goods.TYPE_CHARGE)))
	end

	return
end

return var_0_0
