local Server = class("Server", import(".BaseVO"))

Server.STATUS = {
	REGISTER_FULL = 3,
	VINDICATE = 1,
	NORMAL = 0,
	FULL = 2
}

function Server:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.status = arg_1_1.status or Server.STATUS.NORMAL
	self.name = arg_1_1.name

	local var_1_0 = arg_1_1.tag_state or 0

	self.isHot = var_1_0 == 1
	self.isNew = var_1_0 == 2
	self.isLogined = false
	self.sortIndex = arg_1_1.sort or self.id
	self.host = arg_1_1.host
	self.port = arg_1_1.port
	self.proxyHost = arg_1_1.proxy_host
	self.proxyPort = arg_1_1.proxy_port
	self.ids = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.ids) do
		table.insert(self.ids, iter_1_1)
	end

	return
end

function Server:getHost()
	if VersionMgr.Inst:OnProxyUsing() and self.proxyHost ~= nil and self.proxyHost ~= "" then
		return self.proxyHost
	end

	return self.host
end

function Server:getPort()
	if VersionMgr.Inst:OnProxyUsing() and self.proxyPort ~= nil and self.proxyPort ~= 0 then
		return self.proxyPort
	end

	return self.port
end

return Server
