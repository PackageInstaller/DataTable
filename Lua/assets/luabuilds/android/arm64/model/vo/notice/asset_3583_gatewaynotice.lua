local GatewayNotice = class("GatewayNotice", import(".Notice"))

function GatewayNotice:prefKey()
	return "GatewayNotice" .. self.id
end

return GatewayNotice
