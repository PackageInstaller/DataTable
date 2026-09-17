local var_0_0 = {}
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = 2
local var_0_7 = 30
local var_0_8 = 0

var_0_0.ip = nil
var_0_0.port = nil
var_0_0.status = 0
var_0_0.login_timeout = 2
var_0_0.connecting_timeout = 0
var_0_0.authkey = ""
var_0_0.socket_client = nil
var_0_0.scheduleid = nil
var_0_0.heartbeatcheck = nil
var_0_0.session_hash_tbl = {}
var_0_0.session_id_can_use = 1
var_0_0.playerinfo = {
	nil,
	nil,
	nil,
	nil,
	false,
	nil
}

local var_0_9 = false
local print_r = require("network.sproto.print_r")
local proto = require("network.sproto.proto")
local var_0_12 = proto.s2c:host("package")
local var_0_13 = var_0_12:attach(proto.c2s)

NET_EVENT_DATA = 0
NET_EVENT_CLOSED = 1
NET_EVENT_REQUEST = 2
NET_EVENT_RESPONSE = 3

local net_socket = require("network.net_socket")
local net_protobuffer = require("network.net_protobuffer")
local crypt = require("crypt")
local net_dispatcher = require("network.net_dispatcher")
local net_requesting = require("network.net_requesting")
local net_waitinglayer = require("network.net_waitinglayer")
local net_connect_handler = require("network.net_connect_handler")

function var_0_0.pack(arg_2_0, arg_2_1)
	return string.char((math.floor(#arg_2_1 / 256))) .. string.char(#arg_2_1 % 256) .. arg_2_1
end

local function var_0_22(arg_3_0)
	return cc.Crypto:MD5(string.format("channel=%s&clientbranch=%s&clientbranch=%s&platform=%s&time=%s", arg_3_0.channel or "", arg_3_0.clientbranch or "", arg_3_0.clientversion, arg_3_0.platform, arg_3_0.time or ""), false, true)
end

function var_0_0.init(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = DeviceManager.createHTTPRequest(function(arg_5_0)
		local var_5_0 = arg_5_0.request

		if arg_5_0.name ~= "completed" then
			return
		end

		if var_5_0:getResponseStatusCode() ~= 200 then
			if arg_4_2 then
				arg_4_2(0)
			end

			return
		end

		local var_5_1 = json.decode((var_5_0:getResponseString()))

		if var_5_1.msg then
			if arg_4_2 then
				arg_4_2(2, string.urldecode(var_5_1.msg))
			end

			return
		end

		arg_4_0.ip = var_5_1.ip
		arg_4_0.port = var_5_1.port

		if var_5_1.needharmony == 1 then
			global_open_harmony_world()
		end

		if not arg_4_0:connect(nil, nil, arg_4_2) and arg_4_2 then
			arg_4_2(0)
		end
	end, config.loginurl, "POST")

	var_4_0:setTimeout(35)

	local var_4_1 = {
		platform = DeviceManager.platform,
		channel = arg_4_1,
		clientversion = config.version,
		clientbranch = config.clientbranch,
		time = tostring(os.time())
	}

	var_4_1.sign = var_0_22(var_4_1)

	var_4_0:setPOSTData(json.encode(var_4_1))
	var_4_0:start()
end

function var_0_0:isConnected()
	return self.status == var_0_3
end

function var_0_0:connect(arg_7_1, arg_7_2, arg_7_3)
	arg_7_1 = arg_7_1 or self.ip
	arg_7_2 = arg_7_2 or self.port
	self.ip = arg_7_1
	self.port = arg_7_2

	assert(arg_7_1 and arg_7_2, "host and port are neccessary")

	if self.status == var_0_3 then
		if arg_7_3 then
			arg_7_3(1)
		end

		return true
	end

	self.status = var_0_2
	self.socket_client = net_socket.new(arg_7_1, arg_7_2, var_0_0.nethandler)
	self.socket_buffer = net_protobuffer.new(var_0_12, var_0_0.nethandler)

	self.socket_client:settimeout(self.login_timeout)

	if self.socket_client:connect(arg_7_1, arg_7_2) == 1 then
		print("socket connect successd")

		self.status = var_0_3

		self.socket_client:settimeout(self.connecting_timeout)
		self:netschedule()
		net_requesting.schedule()
		net_connect_handler.connect(self, function(arg_8_0)
			if arg_8_0 == 1 then
				print("connect auth success!!!!!")

				if arg_7_3 then
					arg_7_3(1)
				end
			else
				print("connect auth failed....")
				self:disconnect()

				if arg_7_3 then
					arg_7_3(0)
				end
			end
		end)

		return true
	else
		print("socket connect failed")
		self:disconnect()

		return false
	end
end

function var_0_0:disconnect()
	print("disconnect the network")

	if self.socket_client ~= nil and self.status ~= var_0_1 then
		self.socket_client:close()

		self.socket_client = nil

		self.socket_buffer:close()

		self.socket_buffer = nil

		if self.status ~= var_0_4 then
			self.status = var_0_1
		end
	end
end

function var_0_0:reconnect(arg_10_1, arg_10_2)
	arg_10_1 = arg_10_1 or self.ip
	arg_10_2 = arg_10_2 or self.port

	assert(arg_10_1 and arg_10_2, "host and port are neccessary")

	self.status = var_0_4

	print("reconnecting...")

	self.socket_client = net_socket.new(arg_10_1, arg_10_2, var_0_0.nethandler)
	self.socket_buffer = net_protobuffer.new(var_0_12, var_0_0.nethandler)

	self.socket_client:settimeout(self.login_timeout)

	if self.socket_client:connect(arg_10_1, arg_10_2) == 1 then
		print("socket reconnect success")

		self.status = var_0_3

		self.socket_client:settimeout(self.connecting_timeout)

		return true
	else
		print("socket reconnect failed")

		return false
	end
end

function var_0_0.fixconnection(arg_11_0, arg_11_1)
	local var_11_0 = 1
	local var_11_1 = false
	local var_11_2

	var_11_2 = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		if var_11_1 then
			return
		end

		if var_11_0 > var_0_7 then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_11_2)

			if arg_11_1 then
				arg_11_1(var_11_1)
			end

			return
		end

		arg_11_0:disconnect()

		var_11_0 = var_11_0 + 1

		if arg_11_0:reconnect() then
			var_11_1 = true

			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_11_2)

			if arg_11_1 then
				arg_11_1(var_11_1)
			end
		end
	end, 3, false)
end

function var_0_0:rpc(arg_13_1, arg_13_2, arg_13_3)
	self:send_request(arg_13_1, arg_13_2, arg_13_3, var_0_0.session_id_can_use)

	var_0_0.session_id_can_use = var_0_0.session_id_can_use + 1
end

function var_0_0:send_request(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = self:pack((var_0_13(arg_14_1, arg_14_2, arg_14_4)))

	self:sendpackage(var_14_0)

	if arg_14_3 then
		net_requesting.registerRequesting(arg_14_4, var_14_0, arg_14_3)
	end
end

function var_0_0:sendpackage(arg_15_1)
	if self.status == var_0_3 and self.socket_client ~= nil then
		self.socket_client:send(arg_15_1)
	end
end

function var_0_0.addWaitingLayer(arg_16_0)
	if not var_0_9 then
		net_waitinglayer.addWaitingLayer()

		var_0_9 = true
	end
end

function var_0_0.removeWaitingLayer(arg_17_0)
	net_waitinglayer.removeWaitingLayer()

	var_0_9 = false
end

function var_0_0.cleanWaitingLayer(arg_18_0)
	net_waitinglayer.clearWaitingLayer()

	var_0_9 = false
end

function var_0_0:missconnection(arg_19_1)
	if self.status == var_0_4 then
		return
	end

	if cc.Director:getInstance():getRunningScene():getName() == "LoginScene" then
		global_logout(1)
		global_ShowBlockWords("魂器终端连接失败，请检查网络>_<")

		return
	end

	self.status = var_0_4
	var_0_8 = 0

	net_requesting.unschedule()
	self:addWaitingLayer()

	if self.playerinfo[var_0_6] == nil then
		global_logout(4)

		return
	end

	self:fixconnection(function(arg_20_0)
		if not arg_20_0 then
			self.status = var_0_5

			global_logout(4)
		end

		self:netschedule()
		net_connect_handler.reconnect(self, self.playerinfo[var_0_6], function(arg_21_0)
			if arg_21_0.result == 1 then
				print("reconnect success")
				self:connect_check_schedule()
				net_requesting.sendAllRequestAgain()
				net_requesting.schedule()
				self:removeWaitingLayer()
				require("model.playermodel"):getServerTime()
			else
				self.status = var_0_5

				global_logout(4)
			end
		end)
	end)
end

function var_0_0.tryReLogin(arg_22_0)
	print("Try To ReLogin...")
	net_requesting.clearAllRequest()
	net_requesting.schedule()
	net_connect_handler.connect(arg_22_0, function(arg_23_0)
		if arg_23_0 == 1 then
			print("Try Relogin Success!!!!")
			arg_22_0:connect_check_schedule()

			local var_23_0 = 0

			require("model.playermodel"):reloadPlayerData(function()
				var_23_0 = var_23_0 + 1

				if var_23_0 == 11 then
					FightManager.refreshAtOnce()
					arg_22_0:removeWaitingLayer()
					cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("RELOAD_PLAYER_DATA"))
				end
			end)
		else
			arg_22_0.status = var_0_5

			global_logout(4)
		end
	end)
end

function var_0_0:set_login_info(arg_25_1, arg_25_2)
	self.playerinfo[arg_25_1] = arg_25_2
end

function var_0_0:shutdown()
	if self.socket_client then
		self.socket_client:shutdown("both")
	end
end

function var_0_0:requestingError()
	if self.status ~= var_0_4 and self.status ~= var_0_5 then
		print("request error, try to reconnect")
		self:unnetschedule()
		self:disable_connect_check()
		self:missconnection()
	end
end

function var_0_0:requestingTimeout()
	if self.status ~= var_0_4 and self.status ~= var_0_5 then
		print("request timeout, try to reconnect")
		self:unnetschedule()
		self:disable_connect_check()
		self:missconnection(true)
	end
end

function var_0_0:update()
	if self.status ~= var_0_3 then
		return
	end

	self.socket_client:select()
	self.socket_buffer:update()
end

function var_0_0.nethandler(arg_30_0, ...)
	({
		[NET_EVENT_DATA] = function(arg_31_0)
			if not var_0_0.socket_buffer then
				return
			end

			var_0_0.socket_buffer:dispatchPacket(arg_31_0)
		end,
		[NET_EVENT_CLOSED] = function()
			print("socket is closed, try to fix it")
			var_0_0:unnetschedule()
			var_0_0:disable_connect_check()
			var_0_0:missconnection()
		end,
		[NET_EVENT_RESPONSE] = function(arg_33_0, arg_33_1)
			net_requesting.exeResponse(arg_33_0, arg_33_1)
		end,
		[NET_EVENT_REQUEST] = function(arg_34_0, arg_34_1, arg_34_2)
			local var_34_0 = require("network.net_dispatcher"):dispatch_request(arg_34_0, arg_34_1, arg_34_2)

			if var_34_0 then
				var_0_0.socket_client:send(var_0_0:pack(arg_34_2(var_34_0)))
			end
		end
	})[arg_30_0](...)
end

function var_0_0:connect_check_schedule()
	if self.heartbeatcheck then
		return
	end

	self.heartbeatcheck = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_36_0)
		if self.status ~= var_0_3 then
			var_0_8 = 0

			return
		end

		var_0_8 = var_0_8 + 1

		if var_0_8 >= 3 then
			print("heartbeat has miss 3, try to fix connect")
			self:unnetschedule()
			self:disable_connect_check()
			self:missconnection()
		end
	end, 3, false)
end

function var_0_0:netschedule()
	if self.scheduleid then
		return
	end

	self.scheduleid = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_38_0)
		self:update()
	end, 0, false)
end

function var_0_0:disable_connect_check()
	if not self.heartbeatcheck then
		return
	end

	var_0_8 = 0

	cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.heartbeatcheck)

	self.heartbeatcheck = nil
end

local var_0_23 = false

function var_0_0:unnetschedule()
	if not self.scheduleid then
		return
	end

	cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduleid)

	self.scheduleid = nil
	var_0_23 = false
end

function var_0_0:checkconnection(arg_41_1, arg_41_2)
	if self.status ~= var_0_3 then
		if arg_41_1 then
			arg_41_1(false)
		end

		return
	end

	arg_41_2 = arg_41_2 or 10

	local var_41_0
	local var_41_1 = false

	var_0_23 = true
	var_41_0 = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		if var_41_1 then
			return
		end

		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_41_0)

		if not var_0_23 then
			return
		end

		var_0_23 = false

		if self.status ~= var_0_3 then
			return
		end

		if arg_41_1 then
			arg_41_1(false)
		end
	end, arg_41_2, false)

	self:rpc("handshake", {
		msg = "l2_hcollege_handshake",
		type = crypt.base64encode("HEARTBEAT")
	}, function(arg_43_0)
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_41_0)

		var_41_1 = true
		var_0_23 = false
		var_0_8 = 0

		if arg_41_1 then
			arg_41_1(true)
		end
	end)
end

function var_0_0:registerRequestListener()
	self:listenHeartBeat()
	self:listenOfflineAlert()
	self:listenLogoutOrder()
	self:listenCheckClientVersion()
	self:listenBarragegift()
end

function var_0_0.listenHeartBeat(arg_45_0)
	net_dispatcher:registerListener(function()
		var_0_8 = 0

		return {
			msg = os.time(),
			platform = DeviceManager.platform
		}
	end, "heartbeat")
end

function var_0_0.listenOfflineAlert(arg_47_0)
	net_dispatcher:registerListener(function(arg_48_0)
		global_offlineAlert(arg_48_0.msg)
	end, "offline_alert")
end

function var_0_0.listenLogoutOrder(arg_49_0)
	net_dispatcher:registerListener(function(arg_50_0)
		global_logout(arg_50_0.order)
	end, "logout_order")
end

function var_0_0.listenCheckClientVersion(arg_51_0)
	net_dispatcher:registerListener(function(arg_52_0)
		if arg_52_0.version then
			if arg_52_0.version ~= config.version then
				global_logout(5)
			end
		else
			require("controller.updatemodule.assets_manager"):onServerCheckOrder()
		end
	end, "check_version")
end

function var_0_0.listenBarragegift(arg_53_0)
	net_dispatcher:registerListener(function(arg_54_0)
		if cc.UserDefault:getInstance():getBoolForKey("unShowGift") then
			return
		end

		require("controller.barrage_manager"):pushBarrageGiftEvent(arg_54_0)
	end, "firework_broadcast")
	net_dispatcher:registerListener(function(arg_55_0)
		require("controller.barrage_manager"):pushSaluteAwardEvent(arg_55_0)
	end, "salute_award_broadcast")
end

var_0_0:registerRequestListener()

function var_0_0:closeOnLogout()
	self:unnetschedule()
	self:disable_connect_check()
	self:disconnect()
	net_requesting.unschedule()
	net_requesting.clearAllRequest()
	net_waitinglayer.clearWaitingLayer()
end

return var_0_0
