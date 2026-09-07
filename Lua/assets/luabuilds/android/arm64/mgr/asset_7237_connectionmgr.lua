pg = pg or {}

local var_0_0 = pg

pg.ConnectionMgr = singletonClass("ConnectionMgr")

local var_0_1 = pg.ConnectionMgr
local var_0_2 = createLog("ConnectionMgr", LOG_CONNECTION)
local var_0_3
local var_0_4
local var_0_5
local var_0_6
local var_0_7 = false
local var_0_8 = {}
local var_0_9
local var_0_10
local var_0_11
local var_0_12

pg.ConnectionMgr.needStartSend = false

local var_0_13
local var_0_14
local var_0_15
local var_0_16

function pg.ConnectionMgr:Connect(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_1.erroCode = arg_1_4
	var_0_16 = arg_1_3
	var_0_3 = Connection.New(arg_1_1, arg_1_2)

	var_0_0.UIMgr.GetInstance():LoadingOn()
	var_0_3.onConnected:AddListener(function()
		var_0_0.UIMgr.GetInstance():LoadingOff()
		originalPrint("Network Connected.")

		var_0_5 = arg_1_1
		var_0_6 = arg_1_2
		var_0_4 = var_0_4 or var_0_0.SendWindow.New(self, 0)

		var_0_3.onData:AddListener(var_0_4.onData)

		if PLATFORM_CODE == PLATFORM_CHT then
			var_0_13 = var_0_0.IPAddress.New()
		end

		var_0_15 = -1
		var_0_7 = true
		var_0_10 = false

		arg_1_3()
		self:resetHBTimer()

		return
	end)
	var_0_3.onData:AddListener(self.onData)
	var_0_3.onError:AddListener(self.onError)
	var_0_3.onDisconnected:AddListener(self.onDisconnected)

	var_0_10 = true

	var_0_3:Connect()
	originalPrint("connect to - " .. arg_1_1 .. ":" .. arg_1_2)

	return
end

function pg.ConnectionMgr:ConnectByProxy()
	VersionMgr.Inst:SetUseProxy(true)

	if self:GetLastHost() ~= nil and self:GetLastPort() ~= "" then
		originalPrint("switch proxy! reason: first connect error")
		self:Connect(self:GetLastHost(), self:GetLastPort(), var_0_16)
	else
		originalPrint("not proxy -> logout")

		local var_3_0 = {}

		var_3_0.code = var_0_1.erroCode or 3

		var_0_0.m02:sendNotification(GAME.LOGOUT, var_3_0)
	end

	return
end

function pg.ConnectionMgr:ConnectByDomain(arg_4_1, arg_4_2)
	self:Connect(LuaHelper.getHostByDomain(arg_4_1), DEFAULT_PORT, arg_4_2)

	return
end

function pg.ConnectionMgr:Reconnect(arg_5_1)
	if not var_0_5 or not var_0_6 then
		warning("Network is not connected.")

		return
	end

	if var_0_10 then
		warning("connecting, please wait...")

		return
	end

	if var_0_7 and var_0_3 ~= nil then
		warning("Network is connected.")

		return
	end

	var_0_11 = arg_5_1

	self:stopHBTimer()
	var_0_4:stopTimer()
	originalPrint("reconnect --> " .. self:GetLastHost() .. ":" .. self:GetLastPort())
	self:Connect(self:GetLastHost(), self:GetLastPort(), function()
		local var_6_0 = getProxy(UserProxy)
		local var_6_1 = var_6_0:getData()
		local var_6_2 = var_0_0.SdkMgr.GetInstance():GetChannelUID()

		if var_6_2 == "" then
			var_6_2 = PLATFORM_LOCAL
		end

		if not var_6_1 or not var_6_1:isLogin() then
			if var_0_4.currentCS == 10020 and var_0_12 ~= DISCONNECT_TIME_OUT then
				self.needStartSend = false

				var_0_4:StartSend()
			else
				var_0_0.m02:sendNotification(GAME.LOGOUT, {
					code = 3
				})
			end

			return
		end

		local var_6_3 = {
			platform = var_6_2,
			account_id = var_6_1.uid,
			server_ticket = var_6_1.token,
			serverid = var_6_1.server,
			check_key = HashUtil.CalcMD5(var_6_1.token .. AABBUDUD)
		}

		var_6_3.device_id = var_0_0.SdkMgr.GetInstance():GetDeviceId()

		var_0_4:Send(10022, var_6_3, 10023, function(arg_7_0)
			if arg_7_0.result == 0 then
				originalPrint("reconnect success: " .. arg_7_0.user_id, " - ", arg_7_0.server_ticket)

				var_6_1.token = arg_7_0.server_ticket

				var_6_0:setLastLogin(var_6_1)
				arg_5_1()
				var_0_4:RemoveLoginPacket()

				if var_0_12 ~= DISCONNECT_TIME_OUT and var_0_4:getPacketIdx() > 0 then
					self.needStartSend = false

					var_0_4:Send(11001, {
						timestamp = 1
					}, 11002, function(arg_8_0)
						var_0_0.TimeMgr.GetInstance():SetServerTime(arg_8_0.timestamp, arg_8_0.monday_0oclock_timestamp)
						var_0_0.m02:sendNotification(GAME.CHANGE_CHAT_ROOM, 0)

						return
					end)

					local var_7_0 = nowWorld()

					if var_7_0 and var_7_0.type ~= World.TypeBase then
						WorldConst.ReqWorldForServer()
					end

					NewEducateHelper.ReqDataForServer()
				elseif self.needStartSend then
					self.needStartSend = false

					var_0_4:StartSend()
				end

				var_0_12 = nil

				local var_7_1 = getProxy(PlayerProxy)

				if var_7_1 and var_7_1:getInited() then
					var_0_0.SecondaryPWDMgr.GetInstance():FetchData()
				end

				var_0_0.NewGuideMgr.GetInstance():Resume()
				var_0_0.m02:sendNotification(GAME.ON_RECONNECTION)
				var_0_0.m02:sendNotification(GAME.ON_APPLICATION_PAUSE, false)
			else
				originalPrint("reconnect failed: " .. arg_7_0.result)
				var_0_0.m02:sendNotification(GAME.LOGOUT, {
					code = 199,
					tip = arg_7_0.result
				})
			end

			return
		end, false, false)

		return
	end)

	return
end

function pg.ConnectionMgr.onDisconnected(arg_9_0, arg_9_1)
	originalPrint("Network onDisconnected: " .. tostring(arg_9_0))

	var_0_12 = arg_9_1

	if var_0_3 then
		if not arg_9_0 then
			var_0_3.onDisconnected:RemoveAllListeners()
		end

		var_0_3:Dispose()

		var_0_3 = nil
	end

	if arg_9_0 then
		var_0_7 = false
	end

	if var_0_10 then
		var_0_0.UIMgr.GetInstance():LoadingOff()
	end

	var_0_10 = false

	return
end

function pg.ConnectionMgr:onData()
	if var_0_8[self.cmd] then
		local var_10_0 = var_0_0.Packer.GetInstance():Unpack(self.cmd, self:getLuaStringBuffer())

		for iter_10_0, iter_10_1 in ipairs(var_0_8[self.cmd]) do
			iter_10_1(var_10_0)
		end
	end

	return
end

function pg.ConnectionMgr.onError(arg_11_0)
	arg_11_0 = tostring(arg_11_0)

	originalPrint("Network Error: " .. arg_11_0)

	if var_0_3 then
		var_0_3:Dispose()

		var_0_3 = nil
	end

	local function var_11_0()
		local var_12_0 = {}

		var_12_0.code = var_0_1.erroCode or 3

		var_0_0.m02:sendNotification(GAME.LOGOUT, var_12_0)

		return
	end

	local function var_11_1()
		return
	end

	if var_0_10 then
		var_0_10 = false
		var_11_1 = var_0_11
	end

	var_0_0.ConnectionMgr.GetInstance():CheckProxyCounter()

	if var_0_5 and var_0_6 then
		var_0_0.ConnectionMgr.GetInstance():stopHBTimer()

		if table.contains({
			"NotSocket"
		}, arg_11_0) then
			var_0_0.ConnectionMgr.GetInstance():Reconnect(var_11_1)
		else
			var_0_0.MsgboxMgr.GetInstance():ShowMsgBox({
				modal = true,
				content = i18n("reconnect_tip", arg_11_0),
				onYes = function()
					var_0_0.ConnectionMgr.GetInstance():Reconnect(var_11_1)

					return
				end,
				onNo = var_11_0
			})
			var_0_0.NewStoryMgr.GetInstance():Stop()
			var_0_0.NewGuideMgr.GetInstance():Pause()
		end
	else
		var_0_0.ConnectionMgr.GetInstance():ConnectByProxy()
	end

	return
end

function pg.ConnectionMgr.Send(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6)
	if not var_0_4 then
		warning("sendWindow is nil. msgid " .. arg_15_1)

		return
	end

	var_0_4:Queue(arg_15_1, arg_15_2, arg_15_3, function(arg_16_0)
		if arg_16_0.result == 14 then
			var_0_0.m02:sendNotification(GAME.EXTRA_PROTO_RESULT, {
				result = arg_16_0.result
			})
		else
			arg_15_4(arg_16_0)
		end

		return
	end, arg_15_5, nil, arg_15_6)

	return
end

function pg.ConnectionMgr.setPacketIdx(arg_17_0, arg_17_1)
	var_0_4:setPacketIdx(arg_17_1)

	return
end

function pg.ConnectionMgr.On(arg_18_0, arg_18_1, arg_18_2)
	if var_0_8[arg_18_1] == nil then
		var_0_8[arg_18_1] = {}
	end

	table.insert(var_0_8[arg_18_1], arg_18_2)

	return
end

function pg.ConnectionMgr.Off(arg_19_0, arg_19_1, arg_19_2)
	if var_0_8[arg_19_1] == nil then
		return
	end

	if arg_19_2 == nil then
		var_0_8[arg_19_1] = nil
	else
		for iter_19_0, iter_19_1 in ipairs(var_0_8[arg_19_1]) do
			if iter_19_1 == arg_19_2 then
				table.remove(var_0_8[arg_19_1], iter_19_0)

				break
			end
		end
	end

	return
end

function pg.ConnectionMgr:Disconnect()
	self:stopHBTimer()

	var_0_8 = {}

	originalPrint("Manually Disconnect !!!")

	if var_0_3 then
		var_0_3:Dispose()

		var_0_3 = nil
	end

	var_0_5 = nil
	var_0_6 = nil
	lastProxyHost = nil
	lastProxyPort = nil
	var_0_4 = nil
	var_0_7 = false

	return
end

function pg.ConnectionMgr.getConnection(arg_21_0)
	return var_0_3
end

function pg.ConnectionMgr.isConnecting(arg_22_0)
	return var_0_10
end

function pg.ConnectionMgr.isConnected(arg_23_0)
	return var_0_7
end

function pg.ConnectionMgr.stopHBTimer(arg_24_0)
	if var_0_9 then
		var_0_9:Stop()

		var_0_9 = nil
	end

	return
end

function pg.ConnectionMgr:resetHBTimer()
	self:stopHBTimer()

	var_0_9 = Timer.New(function()
		var_0_14 = TimeUtil.GetSystemTime()

		self:Send(10100, {
			need_request = 1
		}, 10101, function(arg_27_0)
			local var_27_0 = TimeUtil.GetSystemTime() - var_0_14

			var_0_15 = var_0_15 == -1 and var_27_0 or (var_27_0 + var_0_15) / 2

			return
		end, false)

		return
	end, HEART_BEAT_TIMEOUT, -1, true)

	var_0_9:Start()

	return
end

function pg.ConnectionMgr.GetPingDelay(arg_28_0)
	return var_0_15
end

local var_0_17 = 0
local var_0_18 = 2
local var_0_19
local var_0_20

function pg.ConnectionMgr.SetProxyHost(arg_29_0, arg_29_1, arg_29_2)
	var_0_19 = arg_29_1
	var_0_20 = arg_29_2

	originalPrint("Proxy host --> " .. var_0_19 .. ":" .. var_0_20)

	return
end

function pg.ConnectionMgr.GetLastHost(arg_30_0)
	if VersionMgr.Inst:OnProxyUsing() and var_0_19 ~= nil and var_0_19 ~= "" then
		return var_0_19
	end

	return var_0_5
end

function pg.ConnectionMgr.GetLastPort(arg_31_0)
	if VersionMgr.Inst:OnProxyUsing() and var_0_20 ~= nil and var_0_20 ~= 0 then
		return var_0_20
	end

	return var_0_6
end

function pg.ConnectionMgr.CheckProxyCounter(arg_32_0)
	var_0_17 = var_0_17 + 1

	originalPrint("proxyCounter: " .. var_0_17)

	if not VersionMgr.Inst:OnProxyUsing() then
		if var_0_17 == var_0_18 then
			originalPrint("switch proxy! reason: " .. var_0_18 .. " error limit")
			VersionMgr.Inst:SetUseProxy(true)
		end
	else
		VersionMgr.Inst:SetUseProxy(false)

		var_0_17 = 0
	end

	return
end

function pg.ConnectionMgr.SwitchProxy(arg_33_0)
	if var_0_13 and var_0_13:IsSpecialIP() then
		if not VersionMgr.Inst:OnProxyUsing() then
			originalPrint("switch proxy! reason: tw specialIP send timeout")
			VersionMgr.Inst:SetUseProxy(true)
		else
			VersionMgr.Inst:SetUseProxy(false)
		end

		var_0_1.onDisconnected(false, DISCONNECT_TIME_OUT)
	end

	return
end

return
