local CrusingMediator = class("CrusingMediator", import("view.base.ContextMediator"))

CrusingMediator.UNFROZEN_MAP_UPDATE = "CrusingMediator.UN_FROZEN_MAP_UPDATE"
CrusingMediator.EVENT_OPEN_TASK = "CrusingMediator.EVENT_OPEN_TASK"
CrusingMediator.EVENT_GET_AWARD = "CrusingMediator.EVENT_GET_AWARD"
CrusingMediator.EVENT_GET_AWARD_PAY = "CrusingMediator.EVENT_GET_AWARD_PAY"
CrusingMediator.EVENT_GET_AWARD_ALL = "CrusingMediator.EVENT_GET_AWARD_ALL"
CrusingMediator.EVENT_GO_CHARGE = "CrusingMediator.EVENT_GO_CHARGE"
CrusingMediator.EVENT_OPEN_BIRTHDAY = "CrusingMediator.EVENT_OPEN_BIRTHDAY"

function CrusingMediator:register()
	self:bind(CrusingMediator.EVENT_OPEN_TASK, function(arg_2_0)
		self.contextData.frozenMapUpdate = true

		self:addSubLayers(Context.New({
			mediator = CrusingTaskMediator,
			viewComponent = CrusingTaskLayer
		}))

		return
	end)
	self:bind(CrusingMediator.EVENT_GET_AWARD, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.CRUSING_CMD, {
			cmd = 2,
			activity_id = self.viewComponent.activity.id,
			arg1 = arg_3_1
		})

		return
	end)
	self:bind(CrusingMediator.EVENT_GET_AWARD_PAY, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.CRUSING_CMD, {
			cmd = 3,
			activity_id = self.viewComponent.activity.id,
			arg1 = arg_4_1
		})

		return
	end)
	self:bind(CrusingMediator.EVENT_GET_AWARD_ALL, function(arg_5_0)
		self:sendNotification(GAME.CRUSING_CMD, {
			cmd = 4,
			activity_id = self.viewComponent.activity.id
		})

		return
	end)
	self:bind(CrusingMediator.EVENT_GO_CHARGE, function(arg_6_0, arg_6_1)
		self:addSubLayers(Context.New({
			mediator = ChargeItemPanelMediator,
			viewComponent = ChargeItemPanelLayer,
			data = {
				panelConfig = arg_6_1
			}
		}))

		return
	end)
	self:bind(CrusingMediator.EVENT_OPEN_BIRTHDAY, function(arg_7_0, arg_7_1)
		self:addSubLayers(Context.New({
			mediator = ChargeBirthdayMediator,
			viewComponent = ChargeBirthdayLayer,
			data = {}
		}))

		return
	end)
	self.viewComponent:setActivity((getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING)))
	self.viewComponent:setPlayer(getProxy(PlayerProxy):getData())

	return
end

function CrusingMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.CRUSING_CMD_DONE,
		CrusingMediator.UNFROZEN_MAP_UPDATE,
		PlayerProxy.UPDATED,
		GAME.CHARGE_SUCCESS
	}
end

function CrusingMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_9_1.id == self.viewComponent.activity.id then
			self.viewComponent:setActivity(var_9_1)
			self.viewComponent:updateAwardPanel()
			self.viewComponent:updateMapStatus()
			self.viewComponent:updateMapWay()
		end
	elseif var_9_0 == GAME.CRUSING_CMD_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_9_1.awards)
	elseif var_9_0 == CrusingMediator.UNFROZEN_MAP_UPDATE then
		self.contextData.frozenMapUpdate = false

		self.viewComponent:updateMapWay()
	elseif var_9_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayer(var_9_1)
	elseif var_9_0 == GAME.CHARGE_SUCCESS then
		self.viewComponent:OnChargeSuccess((Goods.Create({
			shop_id = var_9_1.shopId
		}, Goods.TYPE_CHARGE)))
	end

	return
end

return CrusingMediator
