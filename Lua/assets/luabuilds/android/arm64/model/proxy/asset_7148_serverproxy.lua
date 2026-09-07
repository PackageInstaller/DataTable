local ServerProxy = class("ServerProxy", import(".NetProxy"))

ServerProxy.SERVERS_UPDATED = "ServerProxy:SERVERS_UPDATED"

function ServerProxy:setServers(arg_1_1, arg_1_2)
	self.data = {}
	self.lastServer = nil
	self.firstServer = nil

	local var_1_0 = {}
	local var_1_1 = self:getLoginedServer(arg_1_2)

	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		assert(isa(iter_1_1, Server), "should be an instance of Server")

		if table.contains(var_1_1, tostring(iter_1_1.id)) then
			iter_1_1.isLogined = true
		end

		self.data[iter_1_1.id] = iter_1_1

		if iter_1_0 == #arg_1_1 then
			self.lastServer = iter_1_1
		end

		if iter_1_1.sortIndex == 0 then
			table.insert(var_1_0, iter_1_1)
		end
	end

	if #var_1_0 > 0 then
		self.firstServer = var_1_0[math.random(1, #var_1_0)]
	end

	self.facade:sendNotification(ServerProxy.SERVERS_UPDATED, self:getData())

	return
end

function ServerProxy:setLastServer(arg_2_1, arg_2_2)
	PlayerPrefs.SetInt("server.id" .. arg_2_2, arg_2_1)

	return
end

function ServerProxy:getLastServer(arg_3_1)
	return self.data[PlayerPrefs.GetInt("server.id" .. arg_3_1)] or self.firstServer or self.lastServer
end

function ServerProxy:recordLoginedServer(arg_4_1, arg_4_2)
	local var_4_0 = self:getLoginedServer(arg_4_1)

	if not table.contains(var_4_0, tostring(arg_4_2)) then
		self.data[arg_4_2].isLogined = true

		table.insert(var_4_0, tostring(arg_4_2))
		PlayerPrefs.SetString("loginedServer_" .. arg_4_1, (table.concat(var_4_0, ":")))
		PlayerPrefs.Save()
	end

	return
end

function ServerProxy:getLoginedServer(arg_5_1)
	if not self.loginedServerIds or self.recordUid and self.recordUid ~= arg_5_1 then
		self.recordUid = arg_5_1
		self.loginedServerIds = string.split(PlayerPrefs.GetString("loginedServer_" .. arg_5_1), ":")
	end

	return self.loginedServerIds
end

return ServerProxy
