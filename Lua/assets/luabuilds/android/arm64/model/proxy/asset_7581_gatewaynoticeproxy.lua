local GatewayNoticeProxy = class("GatewayNoticeProxy", import(".NetProxy"))

function GatewayNoticeProxy:register()
	self.data = {}

	return
end

function GatewayNoticeProxy:getGatewayNotices(arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(self.data) do
		if not arg_2_1 or not iter_2_1.isRead then
			table.insert(var_2_0, iter_2_1)
		end
	end

	return var_2_0
end

function GatewayNoticeProxy:setGatewayNotices(arg_3_1)
	self.data = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		table.insert(self.data, GatewayNotice.New(iter_3_1))
	end

	return
end

return GatewayNoticeProxy
