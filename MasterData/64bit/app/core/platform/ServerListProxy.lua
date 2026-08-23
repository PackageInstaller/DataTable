local var_0_0 = json.decode
local ServerListProxy = class("ServerListProxy")
local ErrorMessage = require("app.core.model.ErrorMessage")

function ServerListProxy:ctor()
	self._loginServer = nil
	self._platformRecommend = {}
	self._selectedServer = nil
	self._lastServerId = nil
	self._lastPId = nil
	self._lastSid = nil
	self._myServerList = {}
	self._mergeMyServerList = nil
	self._mergeServerList = nil
	self._lockedServers = {}
	self._allowedServers = {}
	self._allowSeverCnt = nil
	self._testServerListVersion = 0

	require("app.core.platform.ServerListProxyExLogic").setExtLogic(self)

	if config.SHOW_DEBUG_BTN or device.isWindows() then
		self._debugServerList = g.core.common.Storage:load("debug_server.json") or {}
	end

	if config.SERVER_JSON_ENABLED then
		self._serverList = json.decodeFileIfExists("server_list.json") or {}

		if config.PUBLISH_REGION and config.PUBLISH_REGION ~= 0 then
			self._serverList = json.decodeFileIfExists("server_list_" .. (g.core.const.ConstMgr.PlatformConst.REGION_SHORT[config.PUBLISH_REGION] or "") .. "_qa.json") or {}
		end

		if not device.isWindows() then
			local var_1_1 = {}

			for iter_1_0, iter_1_1 in ipairs(self._serverList) do
				if iter_1_1.isExternal then
					table.insert(var_1_1, iter_1_1)
				end
			end

			self._serverList = var_1_1
		end

		self._recommendList = self._serverList

		local var_1_2, var_1_3, var_1_4 = self:getLastLocalId()

		if var_1_2 and var_1_2 ~= "" then
			local var_1_5 = self:getServerByLocalId(var_1_2, var_1_4)

			if var_1_5 then
				self:setMyServerList("default", {
					{
						level = 0,
						base_id = 210000,
						vip_level = 0,
						name = var_1_3,
						server = var_1_5.sid
					}
				})
			end
		end
	else
		local var_1_6 = g.core.common.Storage:load("open_server.json", false) or {}

		self._recommendList = var_1_6.recommend or {}
		self._serverList = var_1_6.server or {}
	end
end

function ServerListProxy:updateServerInfo(arg_2_1)
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

	if self._testServerListVersion > 0 then
		if config.PCSDK_ENABLED then
			self:setServerList(self._serverList)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SDK_GET_MY_SERVER_LIST)
		elseif g.core.platform.PlatformProxy:isChannelOfChina() and self:isTesting() then
			g.core.utils.Rule.doRulePatchLogic()
		end
	end
end

function ServerListProxy:getLastLocalId()
	if not self._lastServerId then
		local var_3_0 = g.core.common.Storage:load("last_server.json", false)

		self._lastServerId = var_3_0 and var_3_0.localId
		self._lastPId = var_3_0 and var_3_0.pId

		local var_3_1

		if var_3_0 then
			::label_3_0::

			var_3_1 = var_3_0.content and var_3_0.content.sid
		end

		self._lastSid = var_3_1
	end

	return self._lastServerId, self._lastPId, self._lastSid
end

function ServerListProxy:saveLastServer(arg_4_1)
	if not arg_4_1 or self._lastServerId == arg_4_1.localId and self._lastSid == arg_4_1.sid and self._lastPId == g.core.platform.PlatformProxy:getSdkAccount() then
		return
	end

	self._lastServerId = arg_4_1.localId
	self._lastSid = arg_4_1.sid

	g.core.common.Storage:save("last_server.json", {
		localId = arg_4_1.localId,
		content = arg_4_1,
		pId = g.core.platform.PlatformProxy:getSdkAccount()
	}, false)
end

function ServerListProxy:reset()
	return
end

function ServerListProxy:setMergeServerList(arg_6_1, arg_6_2)
	self._mergeServerList = {
		count = arg_6_2,
		params = arg_6_1
	}
end

function ServerListProxy:_getMergeServerList()
	return self._mergeServerList
end

function ServerListProxy:setServerList(arg_8_1)
	local var_8_0, var_8_1 = g.core.platform.PlatformProxy:getVersion()
	local var_8_2 = ""

	if config.PUBLISH_REGION and config.PUBLISH_REGION ~= 0 then
		var_8_2 = g.core.const.ConstMgr.PlatformConst.REGION_SHORT[config.PUBLISH_REGION] or ""
	end

	local var_8_3 = device.isIOS() and "_ios_tishen" or "_android_tishen"

	if config.FORCE_SET_SERVER_JSON == 1 then
		self._serverList = json.decodeFileIfExists("server_list_" .. var_8_2 .. var_8_3 .. ".json") or {}
		self._recommendList = self._serverList
	elseif config.FORCE_SET_SERVER_JSON == 2 then
		self._serverList = json.decodeFileIfExists("server_list_" .. var_8_2 .. "_qa.json") or {}
		self._recommendList = self._serverList
	elseif self._testServerListVersion > 0 and self._testServerListVersion == var_8_1 then
		if config.PUBLISH_REGION and config.PUBLISH_REGION ~= 0 then
			self._serverList = json.decodeFileIfExists("server_list_" .. var_8_2 .. var_8_3 .. ".json") or {}
			self._recommendList = self._serverList

			if g.core.platform.PlatformProxy:isChannelOfChina() then
				for iter_8_0, iter_8_1 in ipairs(self._serverList) do
					iter_8_1.name = "平民之心S2"
				end
			end
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
		local var_8_4 = {}

		local function var_8_5(arg_9_0)
			for iter_9_0, iter_9_1 in ipairs(arg_9_0) do
				local var_9_0 = {}

				var_9_0.name = iter_9_1.server_name or iter_9_1.name
				var_9_0.sid = iter_9_1.server_id
				var_9_0.id = tonumber(iter_9_1.server_id)
				var_9_0.address = iter_9_1.gateway_domain

				local var_9_1 = var_9_0.address:find(":")

				if var_9_1 then
					var_9_0.address = var_9_0.address:sub(1, var_9_1 - 1)
				end

				var_9_0.port = iter_9_1.gateway_port
				var_9_0.localId = string.format("%s_%s_%s", iter_9_1.server_id, iter_9_1.gateway_domain, iter_9_1.gateway_port)
				var_9_0.openTime = tonumber(iter_9_1.first_opentime or 0)
				var_9_0.isRecommend = tonumber(iter_9_1.is_recommend or "0")
				var_9_0.newStyle = tonumber(iter_9_1.new_style or 0)
				var_9_0.opSid = iter_9_1.op_sid
				var_9_0.isActivated = iter_9_1.is_active
				var_9_0.type = iter_9_1.type
				var_9_0.serverURL = iter_9_1.server_url
				var_9_0.isMerge = 0

				if iter_9_1.is_merge and iter_9_1.is_merge ~= "" then
					var_9_0.isMerge = tonumber(iter_9_1.is_merge)
				end

				var_9_0.mainServerSid = {}

				if iter_9_1.child_merge_sid then
					var_9_0.mainServerSid = var_0_0(iter_9_1.child_merge_sid) or {}

					if #var_9_0.mainServerSid > 0 then
						var_9_0.isMerge = 1
					end
				end

				var_9_0.subServerSid = {}

				if iter_9_1.parent_merge_sid then
					var_9_0.subServerSid = var_0_0(iter_9_1.parent_merge_sid) or {}

					if #var_9_0.subServerSid > 0 then
						var_9_0.isMerge = 1
					end
				end

				table.insert(var_8_4, var_9_0)
			end
		end

		local var_8_6 = self:_getMergeServerList()

		if var_8_6 ~= nil and var_8_6.params ~= nil then
			var_8_5(var_8_6.params)

			local var_8_7 = tonumber(var_8_6.count) or 0

			if var_8_7 > 0 then
				local var_8_8 = {}

				for iter_8_2 = 1, #arg_8_1 - var_8_7 do
					var_8_8[iter_8_2] = arg_8_1[iter_8_2]
				end

				var_8_5(var_8_8)
			else
				var_8_5(arg_8_1)
			end
		else
			var_8_5(arg_8_1)
		end

		self._serverList, self._recommendList = self:_prepareServerList(var_8_4)

		g.core.common.Storage:save("open_server.json", {
			server = self._serverList,
			recommend = self._recommendList
		}, false)
	end
end

function ServerListProxy:setMergeMyServerList(arg_10_1, arg_10_2)
	self._mergeMyServerList = {
		account = arg_10_1,
		params = arg_10_2
	}
end

function ServerListProxy:_getMergeMyServerList()
	return self._mergeMyServerList
end

function ServerListProxy:setMyServerList(arg_12_1, arg_12_2)
	self._myServerList = {}

	local var_12_0 = self:_getMergeMyServerList()

	if not var_12_0 and not arg_12_2 then
		return
	end

	local var_12_1 = 0

	local function var_12_2(arg_13_0)
		for iter_13_0, iter_13_1 in ipairs(arg_13_0) do
			local var_13_1 = self:getServerBySid(tostring(iter_13_1.server or iter_13_1.server_id))

			if var_13_1 then
				iter_13_1.playerName = iter_13_1.name or iter_13_1.role_name
				iter_13_1.name = var_13_1.name
				iter_13_1.address = var_13_1.address
				iter_13_1.sid = var_13_1.sid
				iter_13_1.id = tonumber(var_13_1.sid)
				iter_13_1.port = var_13_1.port
				iter_13_1.localId = string.format("%s_%s_%s", var_13_1.sid, var_13_1.address, var_13_1.port)
				iter_13_1.newStyle = var_13_1.newStyle
				iter_13_1.isMerge = var_13_1.isMerge
				iter_13_1.mainServerSid = var_13_1.mainServerSid
				iter_13_1.subServerSid = var_13_1.subServerSid
				var_12_1 = math.max(var_12_1, var_13_1.id)

				table.insert(self._myServerList, iter_13_1)
			end
		end
	end

	if var_12_0 ~= nil and var_12_0.params ~= nil then
		var_12_2(var_12_0.params)
	end

	if arg_12_2 ~= nil then
		var_12_2(arg_12_2)
	end

	local var_12_3 = self:getLastLocalId()

	table.sort(self._myServerList, function(arg_14_0, arg_14_1)
		local var_14_0, var_14_1

		if arg_14_0.localId == var_12_3 then
			var_14_0 = var_12_1 + 1 or arg_14_0.id

			if arg_14_1.localId == var_12_3 then
				var_14_1 = var_12_1 + 1 or arg_14_1.id
			end
		end

		return var_14_1 < var_14_0
	end)
end

function ServerListProxy:getMyServerList()
	return self._myServerList
end

function ServerListProxy:getServerList()
	if config.SHOW_DEBUG_BTN or device.isWindows() then
		local var_16_0 = clone(self._serverList)

		for iter_16_0, iter_16_1 in ipairs(self._debugServerList) do
			table.insert(var_16_0, iter_16_1)
		end

		return var_16_0
	else
		return self._serverList
	end
end

function ServerListProxy:getBaseMainServer(arg_17_1)
	local var_17_0 = self:getServerBySid(arg_17_1)

	if not var_17_0 then
		return nil
	end

	if var_17_0.isMerge == 1 and next(var_17_0.mainServerSid) then
		while var_17_0.mainServerSid[1] do
			local var_17_1 = self:getServerBySid(var_17_0.mainServerSid[1])
			local var_17_2

			if var_17_1.isMerge == 1 and next(var_17_1.mainServerSid) then
				var_17_2 = var_17_1.mainServerSid[1]
			else
				return var_17_1
			end
		end
	else
		return nil
	end
end

function ServerListProxy:isSameMergeGroup(arg_18_1, arg_18_2)
	if tostring(arg_18_1) == tostring(arg_18_2) then
		return true
	end

	local var_18_0 = self:getBaseMainServer(arg_18_1)
	local var_18_1 = self:getBaseMainServer(arg_18_2)
	local var_18_2, var_18_3

	if var_18_0 then
		var_18_2 = var_18_0.sid or arg_18_1

		if var_18_1 then
			var_18_3 = var_18_1.sid or arg_18_2
		end
	end

	return tostring(var_18_2) == tostring(var_18_3)
end

function ServerListProxy:updateServerList()
	if config.SHOW_DEBUG_BTN or device.isWindows() then
		for iter_19_0, iter_19_1 in ipairs(self._serverList) do
			if iter_19_1.name == "国服内网战斗测试服" then
				table.remove(self._serverList, iter_19_0)

				break
			end
		end
	end
end

function ServerListProxy:getRecommendServerList()
	return self._recommendList
end

function ServerListProxy:getSelectedServer()
	if self._summonServer then
		return self._summonServer
	end

	return self._selectedServer or self._recommendList[1]
end

function ServerListProxy:setSummonServer(arg_22_1)
	self._summonServer = arg_22_1
end

function ServerListProxy:clearSummonServer()
	self:setCurServer(self:getSelectedServer())

	self._summonServer = nil
end

function ServerListProxy:setCurServer(arg_24_1)
	self._selectedServer = arg_24_1

	ErrorMessage:setServer(self._selectedServer)
end

function ServerListProxy:getCurServer()
	return self._selectedServer
end

function ServerListProxy:setSelectedServer(arg_26_1)
	self._selectedServer = self:getServerBySid(arg_26_1)

	ErrorMessage:setServer(self._selectedServer)
end

function ServerListProxy:getServerBySid(arg_27_1)
	arg_27_1 = checkstring(arg_27_1)

	for iter_27_0, iter_27_1 in ipairs(self._serverList) do
		if checkstring(iter_27_1.sid) == arg_27_1 then
			return iter_27_1, iter_27_0
		end
	end

	return nil
end

function ServerListProxy:setSelectedServerWithAddress(arg_28_1, arg_28_2)
	self._selectedServer = self:getServerBySidWithAddress(arg_28_1, arg_28_2)

	ErrorMessage:setServer(self._selectedServer)
end

function ServerListProxy:getServerBySidWithAddress(arg_29_1, arg_29_2)
	for iter_29_0, iter_29_1 in ipairs((self:getServerList())) do
		if iter_29_1.sid == arg_29_1 and iter_29_1.address == arg_29_2 then
			return iter_29_1, iter_29_0
		end
	end

	return nil
end

function ServerListProxy:getRangeServer(arg_30_1)
	local var_30_0 = {}
	local var_30_1 = self:getServerList()

	for iter_30_0 = arg_30_1[1], arg_30_1[2], arg_30_1[1] > arg_30_1[2] and -1 or 1 do
		if var_30_1[iter_30_0] then
			table.insert(var_30_0, var_30_1[iter_30_0])
		end
	end

	return var_30_0
end

function ServerListProxy:getLastLoginServer()
	local var_31_0, var_31_1, var_31_2 = self:getLastLocalId()
	local var_31_3 = g.core.platform.PlatformProxy:getSdkAccount()

	if not var_31_0 or var_31_0 == "" or var_31_1 and var_31_3 ~= "" and var_31_1 ~= var_31_3 then
		local var_31_4 = self._myServerList[1]

		var_31_0 = self._myServerList[1] and var_31_4.localId or ""
		var_31_2 = var_31_4 and var_31_4.sid or ""

		if var_31_0 == "" then
			if #self._recommendList > 0 then
				local var_31_6 = self._recommendList[math.random(#self._recommendList)]

				var_31_0 = var_31_6 and var_31_6.localId or ""
				var_31_2 = var_31_6 and var_31_6.sid or ""
			end
		end
	end

	if var_31_0 ~= "" then
		for iter_31_0, iter_31_1 in ipairs(self._serverList) do
			if iter_31_1.localId == var_31_0 and iter_31_1.sid == var_31_2 then
				return iter_31_1, iter_31_0
			end
		end
	end

	return self._serverList[1], 1
end

function ServerListProxy:getServerByLocalId(arg_32_1, arg_32_2)
	if not arg_32_1 then
		return nil
	end

	for iter_32_0, iter_32_1 in ipairs(self._serverList) do
		if iter_32_1.localId == arg_32_1 and iter_32_1.sid == arg_32_2 then
			return iter_32_1, iter_32_0
		end
	end

	return self._serverList[1], 1
end

function ServerListProxy:getServerById(arg_33_1)
	for iter_33_0, iter_33_1 in ipairs(self._serverList) do
		if iter_33_1.id == arg_33_1 then
			return iter_33_1, iter_33_0
		end
	end
end

function ServerListProxy:_prepareServerList(arg_34_1)
	if not arg_34_1 then
		return {}, {}
	end

	local function var_34_0(arg_35_0)
		return string.sub(tostring(arg_35_0 or ""), 1, 4) == "3111"
	end

	table.sort(arg_34_1, function(arg_36_0, arg_36_1)
		if arg_36_0.openTime ~= arg_36_1.openTime then
			return arg_36_0.openTime > arg_36_1.openTime
		end

		local var_36_0 = var_34_0(arg_36_0.sid)

		if var_36_0 ~= var_34_0(arg_36_1.sid) then
			return var_36_0
		end

		return arg_36_0.id > arg_36_1.id
	end)

	local var_34_1 = {}

	for iter_34_0, iter_34_1 in ipairs(arg_34_1) do
		if self:isPlatRecommed(iter_34_1.sid) then
			table.insert(var_34_1, iter_34_1)
		end
	end

	if device.isOHOS() and #var_34_1 == 0 then
		var_34_1[1] = arg_34_1[1]
	end

	return arg_34_1, var_34_1
end

function ServerListProxy:isPlatRecommed(arg_37_1)
	if g.core.platform.PlatformProxy:needMergeServer(g.core.platform.PlatformProxy:getOpGameId(), (g.core.platform.PlatformProxy:getOpId())) then
		if self._serverList[1] then
			return tostring(arg_37_1) == tostring(self._serverList[1].sid)
		end
	else
		for iter_37_0, iter_37_1 in ipairs(self._platformRecommend) do
			if tostring(arg_37_1) == tostring(iter_37_1) then
				return true
			end
		end
	end

	return false
end

function ServerListProxy:getIndexByServerId(arg_38_1)
	local var_38_0 = -1
	local var_38_1 = tonumber(arg_38_1)

	for iter_38_0, iter_38_1 in ipairs(self._serverList) do
		if iter_38_1.newStyle and iter_38_1.newStyle ~= 4 then
			var_38_0 = var_38_0 + 1
		end

		if iter_38_1.id == var_38_1 then
			return var_38_0
		end
	end

	return var_38_0
end

function ServerListProxy:isFrobidded(arg_39_1)
	if self._testServerListVersion > 0 and self._testServerListVersion == config.GAME_VERSION_NO then
		return false
	end

	if self._allowSeverCnt then
		if self:getIndexByServerId(arg_39_1) >= self._allowSeverCnt then
			return true
		else
			return false
		end
	end

	for iter_39_0, iter_39_1 in ipairs(self._allowedServers) do
		if iter_39_1[2] then
			if arg_39_1 >= iter_39_1[1] and arg_39_1 <= iter_39_1[2] then
				return false
			end
		elseif iter_39_1[1] == arg_39_1 then
			return false
		end
	end

	for iter_39_2, iter_39_3 in ipairs(self._lockedServers) do
		if iter_39_3[2] then
			if arg_39_1 >= iter_39_3[1] and arg_39_1 <= iter_39_3[2] then
				return true
			end
		elseif iter_39_3[1] == arg_39_1 then
			return true
		end
	end

	return false
end

function ServerListProxy:isForbiddedCreated(arg_40_1)
	local var_40_0 = self:getCurServer()

	if not var_40_0 then
		return true
	end

	if self:isFrobidded(var_40_0.sid) then
		if arg_40_1 then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new({
				type = 1,
				text = g.core.lang:get(100036),
				text_cancel = g.core.lang:get(1154)
			}), {
				system = true
			})
		end

		return true
	end

	return false
end

ServerListProxy.STATE_INDEX = {
	DOWN = 0,
	FULL = 3,
	BUSY = 2,
	NORMAL = 1
}

function ServerListProxy:getServerState(arg_41_1)
	local var_41_0 = 2

	if arg_41_1.newStyle == 4 then
		var_41_0 = 0
	elseif arg_41_1.newStyle == 5 then
		var_41_0 = 0
	end

	if self:isPlatRecommed(arg_41_1.sid) then
		var_41_0 = 1
	end

	return (self:isFrobidded(arg_41_1.sid) or nil) and 3
end

function ServerListProxy:getRecommedServers()
	local var_42_0 = {}

	for iter_42_0, iter_42_1 in ipairs(self._serverList) do
		if self:isPlatRecommed(iter_42_1.sid) then
			var_42_0[#var_42_0 + 1] = iter_42_1
		end
	end

	return var_42_0
end

function ServerListProxy:isMyServer(arg_43_1)
	for iter_43_0, iter_43_1 in ipairs(self._myServerList) do
		if iter_43_1.id == arg_43_1.id then
			return true
		end
	end

	return false
end

function ServerListProxy:isTesting()
	local var_44_0, var_44_1 = g.core.platform.PlatformProxy:getVersion()

	if self._testServerListVersion > 0 and self._testServerListVersion == var_44_1 then
		return true
	end

	return false
end

function ServerListProxy:setLoginServer(arg_45_1)
	self._loginServer = arg_45_1

	self:setLoginServerGroup(arg_45_1)
end

function ServerListProxy:setLoginServerGroup(arg_46_1)
	return
end

function ServerListProxy:getLoginServer()
	return self._loginServer
end

function ServerListProxy:isOtherServerUser(arg_48_1)
	return arg_48_1 ~= self:getSelectedServer().id
end

function ServerListProxy:addDebugList(arg_49_1)
	local var_49_0 = {}

	for iter_49_0, iter_49_1 in ipairs(arg_49_1) do
		local var_49_1 = true

		for iter_49_2, iter_49_3 in ipairs(self._debugServerList) do
			if iter_49_1.name == iter_49_3.name then
				self._debugServerList[iter_49_2] = iter_49_1
				var_49_1 = false

				break
			end
		end

		if var_49_1 then
			table.insert(var_49_0, iter_49_1)
		end
	end

	for iter_49_4, iter_49_5 in ipairs(var_49_0) do
		table.insert(self._debugServerList, iter_49_5)
	end

	if self._debugServerList and #self._debugServerList > 0 then
		g.core.common.Storage:save("debug_server.json", self._debugServerList)
	end
end

function ServerListProxy:checkAndFixServerInfo(arg_50_1)
	local var_50_0 = true

	for iter_50_0, iter_50_1 in pairs(self._serverList) do
		if iter_50_1.name == arg_50_1.name then
			self._serverList[iter_50_0] = arg_50_1
			var_50_0 = false

			break
		end
	end

	return var_50_0
end

return ServerListProxy
