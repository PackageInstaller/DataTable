class = var_0_10000

local var_0_0 = "ServerProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

var_0_1.SERVERS_UPDATED = "ServerProxy:SERVERS_UPDATED"

function var_0_1.setServers(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.data = {}
	arg_1_0.lastServer = nil
	arg_1_0.firstServer = nil

	local var_1_0 = {}
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_0.getLoginedServer(var_1_1, arg_1_2)

	ipairs = var_1_1

	for iter_1_0, iter_1_1 in var_1_1(arg_1_1) do
		assert = var_1_10010
		isa = var_1_10011

		local var_1_3 = iter_1_1

		Server = var_1_10013

		var_1_10010(var_1_10011(var_1_3, var_1_10013), "should be an instance of Server")

		table = var_1_10010
		var_1_10010 = var_1_10010.contains
		var_1_10011 = var_1_2
		tostring = var_12

		if var_1_10010(var_1_10011, var_12(iter_1_1.id)) then
			iter_1_1.isLogined = true
		end

		var_1_10010 = arg_1_0.data
		var_1_10010[iter_1_1.id] = iter_1_1

		if iter_1_0 == #arg_1_1 then
			arg_1_0.lastServer = iter_1_1
		end

		if iter_1_1.sortIndex == 0 then
			table = var_1_10010

			var_1_10010.insert(var_1_0, iter_1_1)
		end
	end

	if #var_1_0 > 0 then
		math = var_5
		arg_1_0.firstServer = var_1_0[var_5.random(1, #var_1_0)]
	end

	local var_1_4 = arg_1_0.facade

	var_5.sendNotification(var_1_4, var_0_1.SERVERS_UPDATED, arg_1_0:getData())

	return
end

function var_0_1.setLastServer(arg_2_0, arg_2_1, arg_2_2)
	PlayerPrefs = var_1_10003

	var_1_10003.SetInt("server.id" .. arg_2_2, arg_2_1)

	return
end

function var_0_1.getLastServer(arg_3_0, arg_3_1)
	PlayerPrefs = var_1_10002

	local var_3_0 = var_1_10002.GetInt("server.id" .. arg_3_1)
	local var_3_1

	if not arg_3_0.data[var_3_0] and not arg_3_0.firstServer then
		var_3_1 = arg_3_0.lastServer
	end

	return var_3_1
end

function var_0_1.recordLoginedServer(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.getLoginedServer(var_4_0, arg_4_1)

	table = var_4_0

	local var_4_2 = var_4_0.contains
	local var_4_3 = var_4_1

	tostring = var_1_10006

	if not var_4_2(var_4_3, var_1_10006(arg_4_2)) then
		local var_4_4 = arg_4_0.data[arg_4_2]

		var_4_4.isLogined = true
		table = var_4_4

		local var_4_5 = var_4_4.insert
		local var_4_6 = var_4_1

		tostring = var_6

		var_4_5(var_4_6, var_6(arg_4_2))

		table = var_4_5

		local var_4_7 = var_4_5.concat(var_4_1, ":")

		PlayerPrefs = var_5

		var_5.SetString("loginedServer_" .. arg_4_1, var_4_7)

		PlayerPrefs = var_5

		var_5.Save()
	end

	return
end

function var_0_1.getLoginedServer(arg_5_0, arg_5_1)
	if not arg_5_0.loginedServerIds or arg_5_0.recordUid and arg_5_0.recordUid ~= arg_5_1 then
		arg_5_0.recordUid = arg_5_1
		PlayerPrefs = var_2

		local var_5_0 = var_2.GetString("loginedServer_" .. arg_5_1)

		string = var_3
		arg_5_0.loginedServerIds = var_3.split(var_5_0, ":")
	end

	return arg_5_0.loginedServerIds
end

return var_0_1
