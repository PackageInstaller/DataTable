local var_0_0 = {}

function var_0_0.setExtLogic(arg_1_0)
	if not var_0_0._isEnable() then
		return
	end

	arg_1_0._serverGroup = {}
	arg_1_0._serverOpGameId = nil

	local var_1_0 = {
		_isEnable = true,
		setExtLogic = true
	}

	for iter_1_0, iter_1_1 in pairs(var_0_0) do
		if type(iter_1_1) == "function" and not var_1_0[iter_1_0] then
			arg_1_0[iter_1_0] = iter_1_1
		end
	end
end

function var_0_0:updateServerInfo(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	self._platformRecommend = string.split(arg_2_1.default_server or "", ",")

	if arg_2_1.auto_default_server then
		if type(arg_2_1.auto_default_server) == "table" then
			if arg_2_1.auto_default_server and #arg_2_1.auto_default_server > 0 then
				self._platformRecommend = arg_2_1.auto_default_server
			end
		else
			local var_2_0 = tonumber(arg_2_1.auto_default_server)

			if var_2_0 and var_2_0 > 0 then
				self._platformRecommend = {
					var_2_0
				}
			end
		end
	end

	local var_2_1 = string.split(arg_2_1.recommend_server or "", ",")

	if type(var_2_1) == "table" then
		for iter_2_0, iter_2_1 in ipairs(var_2_1) do
			table.insert(self._platformRecommend, iter_2_1)
		end
	end

	self._lockedServers = {}

	for iter_2_2, iter_2_3 in ipairs((string.split(arg_2_1.locked_server_list or "", ";"))) do
		self._lockedServers[iter_2_2] = string.split(iter_2_3, ",")
	end

	self._allowedServers = {}

	for iter_2_4, iter_2_5 in ipairs((string.split(arg_2_1.allow_server_list or "", ";"))) do
		self._allowedServers[iter_2_4] = string.split(iter_2_5, ",")
	end

	if arg_2_1.allow_server_count then
		self._allowSeverCnt = tonumber(arg_2_1.allow_server_count)
	end

	if arg_2_1.serverList then
		self._testServerListVersion = tonumber(arg_2_1.serverList) or 0
	end

	arg_2_2 = arg_2_2 or g.core.platform.PlatformProxy:getOpGameId()
	self._serverGroup[arg_2_2] = self._serverGroup[arg_2_2] or {}
	self._serverGroup[arg_2_2].gmServerConfig = arg_2_1

	if config.PCSDK_ENABLED or self._testServerListVersion > 0 then
		if self._serverList and next(self._serverList) then
			local var_2_2, var_2_3 = self:_prepareServerList(self._serverList)

			self._recommendList = var_2_3
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SDK_GET_MY_SERVER_LIST)
	end
end

function var_0_0:setServerList(arg_3_1, arg_3_2)
	local var_3_0, var_3_1 = g.core.platform.PlatformProxy:getVersion()
	local var_3_2 = ""

	if config.PUBLISH_REGION and config.PUBLISH_REGION ~= 0 then
		var_3_2 = g.core.const.ConstMgr.PlatformConst.REGION_SHORT[config.PUBLISH_REGION] or ""
	end

	local var_3_3 = device.isIOS() and "_ios_tishen" or "_android_tishen"

	if config.FORCE_SET_SERVER_JSON == 1 then
		self._serverList = json.decodeFileIfExists("server_list_" .. var_3_2 .. var_3_3 .. ".json") or {}
		self._recommendList = self._serverList
	elseif config.FORCE_SET_SERVER_JSON == 2 then
		self._serverList = json.decodeFileIfExists("server_list_" .. var_3_2 .. "_qa.json") or {}
		self._recommendList = self._serverList
	elseif self._testServerListVersion > 0 and self._testServerListVersion == var_3_1 then
		if config.PUBLISH_REGION and config.PUBLISH_REGION ~= 0 then
			self._serverList = json.decodeFileIfExists("server_list_" .. var_3_2 .. var_3_3 .. ".json") or {}
			self._recommendList = self._serverList
		elseif device.isIOS() then
			if config.MAJIA_PACKAGE then
				self._serverList = json.decodeFileIfExists("server_list_ios2.json") or {}
				self._recommendList = self._serverList
			else
				self._serverList = json.decodeFileIfExists("server_list_ios.json") or {}
				self._recommendList = self._serverList
			end
		else
			self._serverList = json.decodeFileIfExists("server_list_android.json") or {}
			self._recommendList = self._serverList
		end

		cc.exports.GUIDE_CLOSE = not config.UPGRADE_SILENT_ENABLED
	else
		local var_3_4 = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
			local var_3_5 = {}

			var_3_5.name = iter_3_1.server_name or iter_3_1.name
			var_3_5.sid = iter_3_1.server_id

			if arg_3_2 == nil then
				arg_3_2 = string.sub(var_3_5.sid, 1, 4)
			end

			var_3_5.id = tonumber(iter_3_1.server_id)
			var_3_5.address = iter_3_1.gateway_domain

			local var_3_6 = var_3_5.address:find(":")

			if var_3_6 then
				var_3_5.address = var_3_5.address:sub(1, var_3_6 - 1)
			end

			var_3_5.port = iter_3_1.gateway_port
			var_3_5.localId = string.format("%s_%s_%s", iter_3_1.server_id, iter_3_1.gateway_domain, iter_3_1.gateway_port)
			var_3_5.openTime = tonumber(iter_3_1.first_opentime or 0)
			var_3_5.isRecommend = tonumber(iter_3_1.is_recommend or "0")
			var_3_5.newStyle = tonumber(iter_3_1.new_style or 0)
			var_3_5.opSid = iter_3_1.op_sid
			var_3_5.isActivated = iter_3_1.is_active
			var_3_5.type = iter_3_1.type
			var_3_5.serverURL = iter_3_1.server_url

			table.insert(var_3_4, var_3_5)
		end

		local var_3_7, var_3_8 = self:_prepareServerList(var_3_4)

		self._serverGroup[arg_3_2] = self._serverGroup[arg_3_2] or {}

		local var_3_9 = self._serverGroup[arg_3_2]

		var_3_9.serverList = var_3_7
		var_3_9.recommendList = var_3_8
		self._serverList = var_3_7
		self._recommendList = var_3_8

		if arg_3_2 == g.core.platform.PlatformProxy:getOpGameId() then
			g.core.common.Storage:save("open_server.json", {
				server = self._serverList,
				recommend = self._recommendList
			}, false)
		end

		if not var_3_9.myServerList then
			g.core.platform.PlatformProxy:reqAccountServer(false, arg_3_2)
		end
	end
end

function var_0_0:switchServerList(arg_4_1, arg_4_2)
	arg_4_1 = tostring(arg_4_1)
	self._serverOpGameId = arg_4_1

	if arg_4_2 or not self._serverGroup[arg_4_1] or not self._serverGroup[arg_4_1].serverList then
		self:requestServerByOpGameId(arg_4_1)

		return false
	else
		self:setCurServerList(arg_4_1, true)

		return true
	end
end

function var_0_0:setCurServerList(arg_5_1, arg_5_2)
	if not self._serverGroup[arg_5_1] then
		return
	end

	self._serverOpGameId = arg_5_1

	self:updateServerInfo(self._serverGroup[arg_5_1].gmServerConfig, arg_5_1)

	self._serverList = self._serverGroup[arg_5_1].serverList
	self._recommendList = self._serverGroup[arg_5_1].recommendList

	if arg_5_2 and not self._serverGroup[arg_5_1].myServerList then
		g.core.platform.PlatformProxy:reqAccountServer(false, arg_5_1)
	else
		self._myServerList = self._serverGroup[arg_5_1].myServerList or {}
	end
end

function var_0_0:requestServerByOpGameId(arg_6_1)
	arg_6_1 = tostring(arg_6_1)

	local function var_6_0()
		g.core.platform.PlatformProxy:reqServerList(arg_6_1)
		g.core.platform.PlatformProxy:reqAccountServer(arg_6_1)
	end

	if self._serverGroup[arg_6_1] and self._serverGroup[arg_6_1].gmServerConfig then
		self:updateServerInfo(self._serverGroup[arg_6_1].gmServerConfig, arg_6_1)
		var_6_0()
	else
		g.core.platform.PlatformProxy:requestPlatformConfig({
			opGameId = arg_6_1
		}, var_6_0)
	end
end

function var_0_0.removeAllServerGroupInfo(arg_8_0)
	arg_8_0._serverOpGameId = nil
end

function var_0_0:setMyServerList(arg_9_1, arg_9_2)
	self._myServerList = {}

	if not arg_9_2 then
		return
	end

	local var_9_0 = 0
	local var_9_1

	if g.core.platform.PlatformProxy then
		var_9_1 = g.core.platform.PlatformProxy:getRegionGroupInfo()
	end

	local var_9_2

	for iter_9_0, iter_9_1 in ipairs(arg_9_2) do
		local var_9_3 = var_9_1 and #var_9_1 > 0 and self:getServerFromServerGroup(tostring(iter_9_1.server)) or self:getServerBySid(tostring(iter_9_1.server))

		if var_9_3 then
			iter_9_1.playerName = iter_9_1.name or iter_9_1.role_name
			iter_9_1.name = var_9_3.name
			iter_9_1.address = var_9_3.address
			iter_9_1.sid = var_9_3.sid
			iter_9_1.id = tonumber(var_9_3.sid)
			iter_9_1.port = var_9_3.port
			iter_9_1.localId = string.format("%s_%s_%s", var_9_3.sid, var_9_3.address, var_9_3.port)
			iter_9_1.newStyle = var_9_3.newStyle
			var_9_0 = math.max(var_9_0, var_9_3.id)

			table.insert(self._myServerList, iter_9_1)

			var_9_2 = string.sub(iter_9_1.sid, 1, 4)
		end
	end

	local var_9_5 = self:getLastLocalId()

	table.sort(self._myServerList, function(arg_10_0, arg_10_1)
		local var_10_0, var_10_1

		if arg_10_0.localId == var_9_5 then
			var_10_0 = var_9_0 + 1 or arg_10_0.id

			if arg_10_1.localId == var_9_5 then
				var_10_1 = var_9_0 + 1 or arg_10_1.id
			end
		end

		return var_10_1 < var_10_0
	end)

	if not g.core.platform.PlatformProxy then
		return
	end

	var_9_2 = var_9_2 or g.core.platform.PlatformProxy:getOpGameId()
	self._serverGroup[var_9_2] = self._serverGroup[var_9_2] or {}
	self._serverGroup[var_9_2].myServerList = self._myServerList
end

function var_0_0:clearMyServerList()
	self._myServerList = {}

	for iter_11_0, iter_11_1 in pairs(self._serverGroup) do
		iter_11_1.myServerList = nil
	end
end

function var_0_0:getServerFromServerGroup(arg_12_1)
	arg_12_1 = checkstring(arg_12_1)

	local var_12_0 = self._serverGroup[string.sub(arg_12_1, 1, 4)]

	if var_12_0 and var_12_0.serverList then
		for iter_12_0, iter_12_1 in ipairs(var_12_0.serverList) do
			if checkstring(iter_12_1.sid) == arg_12_1 then
				return iter_12_1, iter_12_0
			end
		end
	end

	return nil
end

function var_0_0:getLastLoginServerByMuiltGroup()
	local var_13_0 = g.core.platform.PlatformProxy:getRegionGroupInfo()
	local var_13_1
	local var_13_2, var_13_3, var_13_4 = self:getLastLocalId()
	local var_13_5 = g.core.platform.PlatformProxy:getSdkAccount() == var_13_3 and var_13_2 and var_13_2 ~= ""
	local var_13_7 = g.core.platform.PlatformProxy:isLogined()
	local var_13_8 = g.core.platform.PlatformProxy:getClientPhoneIpInfo()
	local var_13_9

	if var_13_8 then
		local var_13_10 = g.core.platform.PlatformProxy:getOpGameId()

		if var_13_8.data then
			var_13_8 = var_13_8.data
		end

		for iter_13_0, iter_13_1 in ipairs(var_13_0) do
			if iter_13_1.continent == var_13_8.continent then
				var_13_10 = iter_13_1.opGameId

				break
			end
		end

		local var_13_11 = self._serverGroup[var_13_10]

		if self._serverGroup[var_13_10] and var_13_11.recommendList then
			var_13_9 = var_13_11.recommendList[math.random(#var_13_11.recommendList)]
		end
	end

	if not var_13_7 then
		var_13_1 = var_13_9
	elseif not var_13_5 then
		local var_13_12 = 0

		for iter_13_2, iter_13_3 in pairs(self._serverGroup) do
			for iter_13_4, iter_13_5 in ipairs(iter_13_3.myServerList or {}) do
				if iter_13_5.level and var_13_12 < iter_13_5.level then
					var_13_1 = iter_13_5
					var_13_12 = iter_13_5.level
				end
			end
		end

		if var_13_12 == 0 then
			var_13_1 = var_13_9
		end
	elseif var_13_5 then
		var_13_1 = self:getServerFromServerGroup(var_13_4)
	end

	var_13_1 = var_13_1 or self:getLastLoginServer()

	return var_13_1
end

function var_0_0:getServerOpGameId()
	return self._serverOpGameId
end

function var_0_0:onlySetCurServerList(arg_15_1)
	self._serverGroup = self._serverGroup or {}

	if not self._serverGroup[arg_15_1] then
		return
	end

	self._serverOpGameId = arg_15_1
	self._serverList = self._serverGroup[arg_15_1].serverList
	self._recommendList = self._serverGroup[arg_15_1].recommendList
end

function var_0_0:setLoginServerGroup(arg_16_1)
	self:onlySetCurServerList((string.sub(arg_16_1.sid, 1, 4)))
end

function var_0_0._isEnable()
	return config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.EN
end

return var_0_0
