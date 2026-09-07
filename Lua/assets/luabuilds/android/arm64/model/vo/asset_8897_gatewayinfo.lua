local GatewayInfo = class("GatewayInfo")

function GatewayInfo:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.host = arg_1_1
	self.port = arg_1_2
	self.proxyHost = arg_1_3
	self.proxyPort = arg_1_4

	return
end

return GatewayInfo
