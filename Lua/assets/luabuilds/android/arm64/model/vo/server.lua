local var_0_0 = class("Server", import(".BaseVO"))

var_0_0.STATUS = {
	REGISTER_FULL = 3,
	VINDICATE = 1,
	NORMAL = 0,
	FULL = 2
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.status = arg_1_1.status or var_0_0.STATUS.NORMAL
	arg_1_0.name = arg_1_1.name

	local var_1_0 = arg_1_1.tag_state or 0

	arg_1_0.isHot = var_1_0 == 1
	arg_1_0.isNew = var_1_0 == 2
	arg_1_0.isLogined = false
	arg_1_0.sortIndex = arg_1_1.sort or arg_1_0.id
	arg_1_0.host = arg_1_1.host
	arg_1_0.port = arg_1_1.port
	arg_1_0.proxyHost = arg_1_1.proxy_host
	arg_1_0.proxyPort = arg_1_1.proxy_port
	arg_1_0.ids = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.ids) do
		table.insert(arg_1_0.ids, iter_1_1)
	end

	return
end

function var_0_0.getHost(arg_2_0)
	if VersionMgr.Inst:OnProxyUsing() and arg_2_0.proxyHost ~= nil and arg_2_0.proxyHost ~= "" then
		return arg_2_0.proxyHost
	end

	return arg_2_0.host
end

function var_0_0.getPort(arg_3_0)
	if VersionMgr.Inst:OnProxyUsing() and arg_3_0.proxyPort ~= nil and arg_3_0.proxyPort ~= 0 then
		return arg_3_0.proxyPort
	end

	return arg_3_0.port
end

return var_0_0
