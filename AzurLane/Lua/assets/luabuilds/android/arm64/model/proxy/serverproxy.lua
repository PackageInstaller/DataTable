local var_0_0 = class("ServerProxy", import(".NetProxy"))

var_0_0.SERVERS_UPDATED = "ServerProxy:SERVERS_UPDATED"

function var_0_0.setServers(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.data = {}
	arg_1_0.lastServer = nil
	arg_1_0.firstServer = nil

	local var_1_0 = arg_1_0:getLoginedServer(arg_1_2)

	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		assert(isa(iter_1_1, Server), "should be an instance of Server")

		if table.contains(var_1_0, tostring(iter_1_1.id)) then
			iter_1_1.isLogined = true
		end

		arg_1_0.data[iter_1_1.id] = iter_1_1

		if iter_1_0 == #arg_1_1 then
			arg_1_0.lastServer = iter_1_1
		end

		if iter_1_1.sortIndex == 0 then
			table.insert({}, iter_1_1)
		end
	end

	if #{} > 0 then
		arg_1_0.firstServer = ({})[math.random(1, #{})]
	end

	arg_1_0.facade:sendNotification(var_0_0.SERVERS_UPDATED, arg_1_0:getData())

	return
end

function var_0_0.setLastServer(arg_2_0, arg_2_1, arg_2_2)
	PlayerPrefs.SetInt("server.id" .. arg_2_2, arg_2_1)

	return
end

function var_0_0.getLastServer(arg_3_0, arg_3_1)
	return arg_3_0.data[PlayerPrefs.GetInt("server.id" .. arg_3_1)] or arg_3_0.firstServer or arg_3_0.lastServer
end

function var_0_0.recordLoginedServer(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0:getLoginedServer(arg_4_1)

	if not table.contains(var_4_0, tostring(arg_4_2)) then
		arg_4_0.data[arg_4_2].isLogined = true

		table.insert(var_4_0, tostring(arg_4_2))
		PlayerPrefs.SetString("loginedServer_" .. arg_4_1, (table.concat(var_4_0, ":")))
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.getLoginedServer(arg_5_0, arg_5_1)
	if not arg_5_0.loginedServerIds or arg_5_0.recordUid and arg_5_0.recordUid ~= arg_5_1 then
		arg_5_0.recordUid = arg_5_1
		arg_5_0.loginedServerIds = string.split(PlayerPrefs.GetString("loginedServer_" .. arg_5_1), ":")
	end

	return arg_5_0.loginedServerIds
end

return var_0_0
