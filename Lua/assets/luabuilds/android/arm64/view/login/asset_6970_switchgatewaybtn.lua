local SwitchGatewayBtn = class("SwitchGatewayBtn")

function SwitchGatewayBtn:Ctor(arg_1_1)
	self._tr = arg_1_1
	self._go = arg_1_1.gameObject

	setActive(self._go, false)

	return
end

function SwitchGatewayBtn:Flush()
	local var_2_0 = getProxy(UserProxy):ShowGatewaySwitcher()

	setActive(self._go, var_2_0)

	if var_2_0 then
		self:RegistSwicher()
	end

	return
end

function SwitchGatewayBtn:RegistSwicher()
	local var_3_0 = getProxy(UserProxy)
	local var_3_1 = var_3_0:getLastLoginUser()

	onButton(nil, self._go, function()
		pg.m02:sendNotification(GAME.SERVER_INTERCOMMECTION, {
			user = var_3_1,
			platform = var_3_0:GetReversePlatform()
		})

		return
	end, SFX_PANEL)

	self.isRegist = true

	return
end

function SwitchGatewayBtn:Dispose()
	if self.isRegist then
		removeOnButton(self._go)

		self.isRegist = nil
	end

	return
end

return SwitchGatewayBtn
