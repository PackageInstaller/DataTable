local HttpRequest = require("app.core.network.HttpRequest")
local var_0_1 = json.decode
local var_0_2 = json.encode
local AIData = class("AIData")

function AIData:ctor()
	self._curTopic = nil
	self._curUser = nil
	self._historyList = {}
	self._authToken = nil
	self._accountPrefix = nil
	self._initTime = -1
	self._expireTime = 0
	self._AIInfo = nil
	self._supplierInfo = nil
	self._roleMap = {}
	self._talkMap = {}
	self._initJsonStr = ""
	self._domain = config.DEBUG_VERSION and "https://qa-yooni-api.youzu.com" or "https://yooni-api.youzu.com"

	self:getAIGameId()
end

function AIData:getAIGameId()
	self._gameId = tonumber((g.core.platform.PlatformProxy:getGameId())) * 10 + 2
end

function AIData:checkInitAI()
	if g.core.common.ServerTime:getTime() >= self._expireTime then
		self:_initAI()

		return true
	end

	return false
end

function AIData:getAIMemberData(arg_4_1)
	return self[table.concat({
		"_",
		arg_4_1
	})]
end

function AIData:_initAI()
	local var_5_0 = table.concat({
		self._domain,
		"/v2/init",
		"?game_id=",
		self._gameId,
		"&op_id=",
		g.core.platform.PlatformProxy:getOpId(),
		"&op_game_id=",
		g.core.platform.PlatformProxy:getOpGameId(),
		"&server_id=",
		g.core.platform.ServerListProxy:getLoginServer().sid,
		"&account=",
		g.core.platform.PlatformProxy:getSdkAccount(),
		"&role_id=",
		g.core.platform.PlatformProxy:_getGameUserInfo().role_id
	})

	HttpRequest.new(var_5_0, nil, {
		success = handler(self, function(arg_6_0, arg_6_1)
			arg_6_0:_onHandlerInitAIMessage(arg_6_1, true)
		end),
		fail = handler(self, function(arg_7_0, arg_7_1, arg_7_2)
			if type(arg_7_2) == "table" then
				arg_7_2 = g.core.lang:get(431026)
			end

			arg_7_0:_onHandlerInitAIMessage(arg_7_2, false)
		end)
	}):send()
	release_print("initAI : " .. var_5_0)
end

function AIData:_onHandlerInitAIMessage(arg_8_1, arg_8_2)
	self._initTime = 0
	self._expireTime = -1

	if arg_8_2 then
		local var_8_0 = var_0_1(arg_8_1)

		release_print("_onHandlerInitAIMessage: " .. arg_8_1)

		self._initJsonStr = arg_8_1

		if var_8_0.status ~= 0 then
			g.core.module.ModuleManager:tip(var_8_0.msg)

			arg_8_2 = false
		else
			local var_8_1 = var_8_0.data

			self._authToken = var_8_0.data.token
			self._accountPrefix = var_8_1.account_prefix
			self._initTime = g.core.common.ServerTime:getTime()
			self._expireTime = var_8_1.expire_time
			self._AIInfo = var_8_1
			self._roleMap = var_8_1.model_list
			self._roleKeyWorldMap = {}

			for iter_8_0, iter_8_1 in pairs(self._roleMap) do
				self._roleKeyWorldMap[iter_8_0] = iter_8_1.keyword
			end

			self._curUser = {
				type = var_8_1.type
			}
		end
	else
		g.core.module.ModuleManager:tip(arg_8_1)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.AI_INIT_FINISH, false, nil, {
		isSuc = arg_8_2
	})
end

function AIData:getSupplierInfo()
	local var_9_0 = table.concat({
		self._domain,
		"/beta/product-list"
	})
	local var_9_1 = {
		game_id = self._gameId,
		account = self._accountPrefix .. g.core.platform.PlatformProxy:getSdkAccount()
	}
	local var_9_2 = {
		headers = {
			["Content-Type"] = "application/json",
			Authorization = self._authToken
		}
	}

	HttpRequest.new(var_9_0, "POST", {
		success = handler(self, function(arg_10_0, arg_10_1)
			arg_10_0:_onHandlerGetSupplierInfoMessage(arg_10_1, true)
		end),
		fail = handler(self, function(arg_11_0, arg_11_1, arg_11_2)
			if type(arg_11_2) == "table" then
				arg_11_2 = g.core.lang:get(431026)
			end

			arg_11_0:_onHandlerGetSupplierInfoMessage(arg_11_2, false)
		end)
	}, var_9_2):send(var_0_2(var_9_1))
	release_print("getSupplierInfo : " .. var_0_2({
		url = var_9_0,
		headers = var_9_2.headers,
		body = var_0_2(var_9_1)
	}))
end

function AIData:_onHandlerGetSupplierInfoMessage(arg_12_1, arg_12_2)
	self._supplierInfo = nil

	if arg_12_2 then
		release_print("_onHandlerGetSupplierInfoMessage,the init str : " .. self._initJsonStr)

		local var_12_0 = var_0_1(arg_12_1)

		if var_12_0.status ~= 0 then
			g.core.module.ModuleManager:tip(var_12_0.msg)

			arg_12_2 = false
		else
			self._supplierInfo = var_12_0.data
		end
	else
		g.core.module.ModuleManager:tip(arg_12_1)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.AI_GET_SUPPLIER_FINISH, false, nil, {
		isSuc = arg_12_2,
		data = self._supplierInfo
	})
end

function AIData:getModelList()
	local var_13_0 = table.concat({
		self._domain,
		"/beta/model-list"
	})
	local var_13_1 = {
		game_id = self._gameId,
		account = self._accountPrefix .. g.core.platform.PlatformProxy:getSdkAccount()
	}
	local var_13_2 = {
		headers = {
			["Content-Type"] = "application/json",
			Authorization = self._authToken
		}
	}

	HttpRequest.new(var_13_0, "POST", {
		success = handler(self, function(arg_14_0, arg_14_1)
			arg_14_0:_onHandlerGetModelListMessage(arg_14_1, true)
		end),
		fail = handler(self, function(arg_15_0, arg_15_1, arg_15_2)
			if type(arg_15_2) == "table" then
				arg_15_2 = g.core.lang:get(431026)
			end

			arg_15_0:_onHandlerGetModelListMessage(arg_15_2, false)
		end)
	}, var_13_2):send(var_0_2(var_13_1))
	release_print("getSupplierInfo : " .. var_0_2({
		url = var_13_0,
		headers = var_13_2.headers,
		body = var_0_2(var_13_1)
	}))
end

function AIData:_onHandlerGetModelListMessage(arg_16_1, arg_16_2)
	self._roleMap = {}

	if arg_16_2 then
		release_print("_onHandlerGetModelListMessage,the init str : " .. self._initJsonStr)

		local var_16_0 = var_0_1(arg_16_1)

		if var_16_0.status ~= 0 then
			g.core.module.ModuleManager:tip(var_16_0.msg)

			arg_16_2 = false
		else
			self._roleMap = var_16_0.data
		end
	else
		g.core.module.ModuleManager:tip(arg_16_1)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.AI_GET_MODEL_LIST_FINISH, false, nil, {
		isSuc = arg_16_2,
		data = self._roleMap
	})
end

function AIData:getCurUser()
	local var_17_0 = table.concat({
		self._domain,
		"/beta/user-setting"
	})
	local var_17_1 = {
		game_id = self._gameId,
		account = self._accountPrefix .. g.core.platform.PlatformProxy:getSdkAccount()
	}
	local var_17_2 = {
		headers = {
			["Content-Type"] = "application/json",
			Authorization = self._authToken
		}
	}

	HttpRequest.new(var_17_0, "POST", {
		success = handler(self, function(arg_18_0, arg_18_1)
			arg_18_0:_onHandlerGetCurUserMessage(arg_18_1, true)
		end),
		fail = handler(self, function(arg_19_0, arg_19_1, arg_19_2)
			if type(arg_19_2) == "table" then
				arg_19_2 = g.core.lang:get(431026)
			end

			arg_19_0:_onHandlerGetCurUserMessage(arg_19_2, false)
		end)
	}, var_17_2):send(var_0_2(var_17_1))
	release_print("getCurUser : " .. var_0_2({
		url = var_17_0,
		headers = var_17_2.headers,
		body = var_0_2(var_17_1)
	}))
end

function AIData:_onHandlerGetCurUserMessage(arg_20_1, arg_20_2)
	self._curUser = nil

	if arg_20_2 then
		local var_20_0 = var_0_1(arg_20_1)

		release_print("_onHandlerGetCurUserMessage,the init str : " .. self._initJsonStr)
		dump(var_20_0)

		if var_20_0.status ~= 0 then
			g.core.module.ModuleManager:tip(var_20_0.msg)

			arg_20_2 = false
		else
			self._curUser = var_20_0.data
		end
	else
		g.core.module.ModuleManager:tip(arg_20_1)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.AI_GET_CURRENT_USER_FINISH, false, nil, {
		isSuc = arg_20_2,
		data = self._curUser
	})
end

function AIData:switchAITypeAndModelType(arg_21_1, arg_21_2)
	arg_21_1 = arg_21_1 or self._curUser.type
	arg_21_2 = arg_21_2 or self._curUser.model_type

	local var_21_0 = {
		type = arg_21_1,
		model_type = arg_21_2
	}
	local var_21_1 = table.concat({
		self._domain,
		"/beta/setting"
	})
	local var_21_2 = {
		game_id = self._gameId,
		account = self._accountPrefix .. g.core.platform.PlatformProxy:getSdkAccount(),
		type = arg_21_1,
		model_type = arg_21_2
	}
	local var_21_3 = {
		headers = {
			["Content-Type"] = "application/json",
			Authorization = self._authToken
		}
	}

	HttpRequest.new(var_21_1, "POST", {
		success = handler(self, function(arg_22_0, arg_22_1)
			arg_22_0:_onHandlerSwitchAITypeAndModelTypeMessage(arg_22_1, true, var_21_0)
		end),
		fail = handler(self, function(arg_23_0, arg_23_1, arg_23_2)
			if type(arg_23_2) == "table" then
				arg_23_2 = g.core.lang:get(431026)
			end

			arg_23_0:_onHandlerSwitchAITypeAndModelTypeMessage(arg_23_2, false)
		end)
	}, var_21_3):send(var_0_2(var_21_2))
	release_print("switchAITypeAndModelType : " .. var_0_2({
		url = var_21_1,
		headers = var_21_3.headers,
		body = var_0_2(var_21_2)
	}))
end

function AIData:_onHandlerSwitchAITypeAndModelTypeMessage(arg_24_1, arg_24_2, arg_24_3)
	if arg_24_2 then
		local var_24_0 = var_0_1(arg_24_1)

		release_print("_onHandlerSwitchAITypeAndModelTypeMessage,the init str : " .. self._initJsonStr)
		dump(var_24_0)

		if var_24_0.status ~= 0 then
			g.core.module.ModuleManager:tip(var_24_0.msg)

			arg_24_2 = false
		else
			self._curUser.type = arg_24_3.type
			self._curUser.model_type = arg_24_3.model_type
			self._curUser.keyWorld = self._roleKeyWorldMap[self._curUser.model_type]
		end
	else
		dump(arg_24_1)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.AI_SWITCH_TYPE_AND_MODEL_FINISH, false, nil, {
		isSuc = arg_24_2,
		data = self._curUser
	})
end

function AIData:getHistory(arg_25_1, arg_25_2, arg_25_3)
	arg_25_2 = arg_25_2 or 10

	local var_25_0, var_25_1

	if not arg_25_3 then
		arg_25_3 = 10
		var_25_0 = {
			game_id = self._gameId,
			account = self._accountPrefix .. g.core.platform.PlatformProxy:getSdkAccount(),
			type = self._curUser.type,
			model_type = self._curUser.model_type
		}
		var_25_1 = {
			headers = {
				["Content-Type"] = "application/json",
				Authorization = self._authToken
			}
		}
	end

	HttpRequest:new("POST", {
		success = handler(self, function(arg_26_0, arg_26_1)
			arg_26_0:_onHandlerGetHistoryMessage(arg_26_1, true)
		end),
		fail = handler(self, function(arg_27_0, arg_27_1, arg_27_2)
			if type(arg_27_2) == "table" then
				arg_27_2 = g.core.lang:get(431026)
			end

			arg_27_0:_onHandlerGetHistoryMessage(arg_27_2, false)
		end)
	}, var_25_1):send(var_0_2(var_25_0))
	release_print("getHistory : " .. var_0_2({
		url = table.concat({
			self._domain,
			"/beta/history"
		}),
		headers = var_25_1.headers,
		body = var_0_2(var_25_0)
	}))
end

function AIData:_onHandlerGetHistoryMessage(arg_28_1, arg_28_2)
	self._historyList = {}

	if arg_28_2 then
		local var_28_0 = var_0_1(arg_28_1)

		release_print("_onHandlerGetHistoryMessage,the init str : " .. self._initJsonStr)
		dump(var_28_0)

		if var_28_0.status ~= 0 then
			g.core.module.ModuleManager:tip(var_28_0.msg)

			arg_28_2 = false
		else
			self._historyList = var_28_0.data

			for iter_28_0, iter_28_1 in ipairs(self._historyList) do
				iter_28_1.content = self:_checkContentTxt(iter_28_1.content)
			end
		end
	else
		g.core.module.ModuleManager:tip(arg_28_1)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.AI_GET_HISTORY_FINISH, false, nil, {
		isSuc = arg_28_2,
		data = self._historyList,
		keyWorld = self._curUser.keyWorld
	})
end

function AIData:clearHistory()
	HttpRequest.new(table.concat({
		self._domain,
		"/beta/flush"
	}), "POST", {
		success = handler(self, function(arg_30_0, arg_30_1)
			arg_30_0:_onHandlerClearHistoryMessage(arg_30_1, true)
		end),
		fail = handler(self, function(arg_31_0, arg_31_1, arg_31_2)
			if type(arg_31_2) == "table" then
				arg_31_2 = g.core.lang:get(431026)
			end

			arg_31_0:_onHandlerClearHistoryMessage(arg_31_2, false)
		end)
	}, {
		headers = {
			["Content-Type"] = "application/json",
			Authorization = self._authToken
		}
	}):send(var_0_2({
		game_id = self._gameId,
		account = self._accountPrefix .. g.core.platform.PlatformProxy:getSdkAccount(),
		type = self._curUser.type,
		model_type = self._curUser.model_type
	}))
end

function AIData:_onHandlerClearHistoryMessage(arg_32_1, arg_32_2)
	if arg_32_2 then
		local var_32_0 = var_0_1(arg_32_1)

		release_print("_onHandlerClearHistoryMessage,the init str : " .. self._initJsonStr)

		if var_32_0.status ~= 0 then
			g.core.module.ModuleManager:tip(var_32_0.msg)

			arg_32_2 = false
		else
			self._historyList = {}
		end
	else
		g.core.module.ModuleManager:tip(arg_32_1)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.AI_CLEAR_HISTORY_FINISH, false, nil, {
		isSuc = arg_32_2
	})
end

function AIData:addTopic(arg_33_1)
	HttpRequest.new(table.concat({
		self._domain,
		"/beta/add-topic"
	}), "POST", {
		success = handler(self, function(arg_34_0, arg_34_1)
			arg_34_0:_onHandlerAddTopicMessage(arg_34_1, true)
		end),
		fail = handler(self, function(arg_35_0, arg_35_1, arg_35_2)
			if type(arg_35_2) == "table" then
				arg_35_2 = g.core.lang:get(431026)
			end

			arg_35_0:_onHandlerAddTopicMessage(arg_35_2, false)
		end)
	}, {
		headers = {
			["Content-Type"] = "application/json",
			Authorization = self._authToken
		}
	}):send(var_0_2({
		game_id = self._gameId,
		account = self._accountPrefix .. g.core.platform.PlatformProxy:getSdkAccount(),
		type = self._curUser.type,
		model_type = self._curUser.model_type,
		op_id = tonumber((g.core.platform.PlatformProxy:getOpId())),
		topic_type = arg_33_1.type,
		topic_name = arg_33_1.name,
		topic_answer = arg_33_1.answer
	}))
end

function AIData:_onHandlerAddTopicMessage(arg_36_1, arg_36_2)
	self._curTopic = nil

	if arg_36_2 then
		local var_36_0 = var_0_1(arg_36_1)

		release_print("_onHandlerClearHistoryMessage,the init str : " .. self._initJsonStr)

		if var_36_0.status ~= 0 then
			g.core.module.ModuleManager:tip(var_36_0.msg)

			arg_36_2 = false
		else
			self._curTopic = var_36_0.data
		end
	else
		g.core.module.ModuleManager:tip(arg_36_1)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.AI_ADD_TOPIC_FINISH, false, nil, {
		isSuc = arg_36_2,
		data = self._curTopic
	})
end

function AIData:_combineMsg(arg_37_1)
	if not arg_37_1 then
		return ""
	end

	local var_37_0 = {}
	local var_37_1 = {}

	for iter_37_0 in arg_37_1:gmatch("[^\r\n]+") do
		table.insert(var_37_1, iter_37_0)
	end

	for iter_37_1, iter_37_2 in ipairs(var_37_1) do
		local var_37_3, var_37_4 = pcall(var_0_1, (iter_37_2:sub(1, 6) == "data: " or nil) and iter_37_2:sub(7))

		if var_37_3 then
			table.insert(var_37_0, var_37_4)
		else
			table.insert(var_37_0, {
				_error = "JSON parse failed",
				_raw = iter_37_2
			})
		end
	end

	return (var_0_2(var_37_0[#var_37_0]))
end

function AIData:sendTopicContent(arg_38_1)
	local var_38_0 = table.concat({
		self._domain,
		"/beta/send"
	})
	local var_38_1 = {
		game_id = self._gameId,
		account = self._accountPrefix .. g.core.platform.PlatformProxy:getSdkAccount(),
		type = self._curUser.type,
		model_type = self._curUser.model_type,
		op_id = tonumber((g.core.platform.PlatformProxy:getOpId())),
		context = arg_38_1
	}
	local var_38_2 = {
		headers = {
			Accept = "text/event-stream",
			["Content-Type"] = "application/json",
			Authorization = self._authToken
		}
	}

	HttpRequest.new(var_38_0, "POST", {
		success = handler(self, function(arg_39_0, arg_39_1)
			arg_39_0:_onHandlerSendTopicContentMessage(arg_39_0:_combineMsg(arg_39_1), true)
		end),
		fail = handler(self, function(arg_40_0, arg_40_1, arg_40_2)
			if type(arg_40_2) == "table" then
				arg_40_2 = g.core.lang:get(431026)
			end

			arg_40_0:_onHandlerSendTopicContentMessage(arg_40_2, false)
		end)
	}, var_38_2):send(var_0_2(var_38_1))
	release_print("sendTopicContent : " .. var_0_2({
		url = var_38_0,
		headers = var_38_2.headers,
		body = var_0_2(var_38_1)
	}))
end

function AIData:_onHandlerSendTopicContentMessage(arg_41_1, arg_41_2)
	local var_41_0

	if arg_41_2 then
		local var_41_1 = var_0_1(arg_41_1)

		print("cur msg:")
		print(arg_41_1)
		release_print("_onHandlerSendTopicContentMessage,the init str : " .. self._initJsonStr)

		if var_41_1.status ~= 0 or var_41_1.data == nil then
			g.core.module.ModuleManager:tip(var_41_1.msg)

			arg_41_2 = false
		else
			var_41_0 = var_41_1.data
			var_41_0.message = self:_checkContentTxt(var_41_1.data.message)
		end
	else
		g.core.module.ModuleManager:tip(arg_41_1)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.AI_SEND_TOPIC_CONTENT_FINISH, false, nil, {
		isSuc = arg_41_2,
		data = var_41_0
	})
end

function AIData:syncTopicContent(arg_42_1)
	local var_42_0 = table.concat({
		self._domain,
		"/beta/sync-send"
	})
	local var_42_1 = {
		game_id = self._gameId,
		account = self._accountPrefix .. g.core.platform.PlatformProxy:getSdkAccount(),
		type = self._curUser.type,
		model_type = self._curUser.model_type,
		op_id = tonumber((g.core.platform.PlatformProxy:getOpId())),
		context = arg_42_1
	}
	local var_42_2 = {
		headers = {
			Accept = "text/event-stream",
			["Content-Type"] = "application/json",
			Authorization = self._authToken
		}
	}

	HttpRequest.new(var_42_0, "POST", {
		success = handler(self, function(arg_43_0, arg_43_1)
			arg_43_0:_onHandlerSendTopicContentMessage(arg_43_1, true)
		end),
		fail = handler(self, function(arg_44_0, arg_44_1, arg_44_2)
			if type(arg_44_2) == "table" then
				arg_44_2 = g.core.lang:get(431026)
			end

			arg_44_0:_onHandlerSendTopicContentMessage(arg_44_2, false)
		end)
	}, var_42_2):send(var_0_2(var_42_1))
	release_print("syncTopicContent : " .. var_0_2({
		url = var_42_0,
		headers = var_42_2.headers,
		body = var_0_2(var_42_1)
	}))
end

function AIData:_onHandlerSyncTopicContentMessage(arg_45_1, arg_45_2)
	local var_45_0

	if arg_45_2 then
		local var_45_1 = var_0_1(arg_45_1)

		release_print("_onHandlerSyncTopicContentMessage,the init str : " .. self._initJsonStr)

		if var_45_1.status ~= 0 then
			g.core.module.ModuleManager:tip(var_45_1.msg)

			arg_45_2 = false
		else
			var_45_0 = var_45_1.data
		end
	else
		g.core.module.ModuleManager:tip(arg_45_1)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.AI_SYNC_TOPIC_CONTENT_FINISH, false, nil, {
		isSuc = arg_45_2,
		data = var_45_0
	})
end

function AIData:_checkContentTxt(arg_46_1)
	return arg_46_1
end

return AIData
