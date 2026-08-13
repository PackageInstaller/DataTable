class = var_0_10000

local var_0_0 = "Server"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

var_0_1.STATUS = {
	REGISTER_FULL = 3,
	VINDICATE = 1,
	NORMAL = 0,
	FULL = 2
}

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id

	local var_1_0

	if not arg_1_1.status then
		var_1_0 = var_0_1.STATUS.NORMAL
	end

	arg_1_0.status = var_1_0
	arg_1_0.name = arg_1_1.name

	local var_1_1

	if not arg_1_1.tag_state then
		var_1_1 = 0
	end

	arg_1_0.isHot = var_1_1 == 1
	arg_1_0.isNew = var_1_1 == 2
	arg_1_0.isLogined = false

	local var_1_2

	if not arg_1_1.sort then
		var_1_2 = arg_1_0.id
	end

	arg_1_0.sortIndex = var_1_2
	arg_1_0.host = arg_1_1.host
	arg_1_0.port = arg_1_1.port
	arg_1_0.proxyHost = arg_1_1.proxy_host
	arg_1_0.proxyPort = arg_1_1.proxy_port
	arg_1_0.ids = {}
	ipairs = var_3

	for iter_1_0, iter_1_1 in var_3(arg_1_1.ids) do
		table = var_1_10008

		var_1_10008.insert(arg_1_0.ids, iter_1_1)
	end

	return
end

function var_0_1.getHost(arg_2_0)
	VersionMgr = var_1_10001

	local var_2_0 = var_1_10001.Inst

	if var_1.OnProxyUsing(var_2_0) and arg_2_0.proxyHost ~= nil and arg_2_0.proxyHost ~= "" then
		return arg_2_0.proxyHost
	end

	return arg_2_0.host
end

function var_0_1.getPort(arg_3_0)
	VersionMgr = var_1_10001

	local var_3_0 = var_1_10001.Inst

	if var_1.OnProxyUsing(var_3_0) and arg_3_0.proxyPort ~= nil and arg_3_0.proxyPort ~= 0 then
		return arg_3_0.proxyPort
	end

	return arg_3_0.port
end

return var_0_1
