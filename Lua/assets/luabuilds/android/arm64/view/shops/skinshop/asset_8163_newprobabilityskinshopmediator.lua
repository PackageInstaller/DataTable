local NewProbabilitySkinShopMediator = class("NewProbabilitySkinShopMediator", import(".NewSkinShopMediator"))

NewProbabilitySkinShopMediator.OPEN_CHARGE_BIRTHDAY = "NewProbabilitySkinShopMediator:OPEN_CHARGE_BIRTHDAY"
NewProbabilitySkinShopMediator.CHARGE = "NewProbabilitySkinShopMediator:CHARGE"
NewProbabilitySkinShopMediator.OPEN_CHARGE_ITEM_PANEL = "NewProbabilitySkinShopMediator:OPEN_CHARGE_ITEM_PANEL"

function NewProbabilitySkinShopMediator:register()
	NewProbabilitySkinShopMediator.super.register(self)
	self:bind(NewProbabilitySkinShopMediator.OPEN_CHARGE_BIRTHDAY, function(arg_2_0, arg_2_1)
		self:addSubLayers(Context.New({
			mediator = ChargeBirthdayMediator,
			viewComponent = ChargeBirthdayLayer,
			data = {}
		}))

		return
	end)
	self:bind(NewProbabilitySkinShopMediator.CHARGE, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.CHARGE_OPERATION, {
			shopId = arg_3_1
		})

		return
	end)
	self:bind(NewProbabilitySkinShopMediator.OPEN_CHARGE_ITEM_PANEL, function(arg_4_0, arg_4_1)
		self:addSubLayers(Context.New({
			mediator = ChargeItemPanelMediator,
			viewComponent = ChargeItemPanelLayer,
			data = {
				panelConfig = arg_4_1
			}
		}))

		return
	end)

	return
end

function NewProbabilitySkinShopMediator:listNotificationInterests()
	local var_5_0 = NewProbabilitySkinShopMediator.super.listNotificationInterests(self)

	table.insert(var_5_0, GAME.CHARGE_SUCCESS)

	return var_5_0
end

function NewProbabilitySkinShopMediator:handleNotification(arg_6_1)
	NewProbabilitySkinShopMediator.super.handleNotification(self, arg_6_1)

	if arg_6_1:getName() == GAME.CHARGE_SUCCESS then
		self.viewComponent:OnChargeSuccess(arg_6_1:getBody().shopId)
	end

	return
end

return NewProbabilitySkinShopMediator
