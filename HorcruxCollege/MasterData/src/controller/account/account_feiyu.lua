local var_0_0 = {}
local network = require("network.network")
local crypt = require("crypt")
local package_loader = require("controller.package_loader")

var_0_0.accountInfo = {
	channel = "fyuser"
}
var_0_0.playerInfo = {}
var_0_0.serverInfo = {}
var_0_0.loginRequestingHandler = nil
var_0_0.feiyuLoginReady = false
var_0_0.playerFirstLogin = false
var_0_0.playerNeedRealName = false
var_0_0.realNameInfo = {}
var_0_0.antiAddictionInfo = {
	needquit = false,
	needantiaddiction = false
}

local var_0_4 = "1"
local var_0_5 = "2"

local function var_0_7(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8, arg_1_9)
	print("Global Login Callback: ", arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8, arg_1_9)

	var_0_0.realNameInfo.identityBirthday = arg_1_6
	var_0_0.realNameInfo.identityAge = arg_1_7

	if arg_1_0 == 0 then
		if var_0_0.loginRequestingHandler then
			var_0_0.loginRequestingHandler = nil
			var_0_0.accountInfo.uid = arg_1_1
			var_0_0.accountInfo.unionid = arg_1_4

			FeiyuManager.realName(arg_1_4, arg_1_1, arg_1_6, arg_1_7, var_0_4)
			var_0_0.loginRequestingHandler(1, arg_1_1, arg_1_2)
		else
			if arg_1_1 == var_0_0.accountInfo.uid then
				return
			end

			FeiyuManager.realName(arg_1_4, arg_1_1, arg_1_6, arg_1_7, var_0_4)

			var_0_0.accountInfo.uid = arg_1_1
			var_0_0.accountInfo.token = arg_1_2
			var_0_0.accountInfo.unionid = arg_1_4

			global_logout("feiyuswitchaccount")
		end
	elseif var_0_0.loginRequestingHandler then
		var_0_0.loginRequestingHandler(2)
	end
end

function var_0_0:init()
	self.accountInfo.platform = FeiyuManager.getplatform()
	self.antiAddictionInfo = {
		needantiaddiction = false
	}

	FeiyuManager.registerLoginHandler(var_0_7)
	FeiyuManager.registerLogoutHandler(function(arg_3_0)
		print("Feiyu Logout Callback: ", arg_3_0)

		if self:getChannel() == "32" then
			global_restart_game()
		else
			require("controller.l2utils"):performWithDelay(function()
				global_logout("feiyulogoutaccount")
			end, 1)
		end
	end)
	FeiyuManager.registerRealNameHandler(function(arg_5_0, arg_5_1, arg_5_2)
		print("RealName Callback: ", arg_5_0, arg_5_1, arg_5_2)

		if arg_5_0 ~= 0 then
			var_0_0.playerNeedRealName = true
		else
			var_0_0.playerNeedRealName = false
			var_0_0.realNameInfo.identityAge = arg_5_1
			var_0_0.realNameInfo.identityBirthday = arg_5_2

			FeiyuManager.realName(var_0_0.accountInfo.unionid, var_0_0.accountInfo.uid, arg_5_2, arg_5_1, var_0_5)
		end
	end)
	FeiyuManager.registerAntiAddictHandler(function(arg_6_0)
		print("AntiAddict Callback: ", arg_6_0)

		if arg_6_0 == 0 then
			return
		end

		global_logout("feiyulogoutaccount")
	end)
	FeiyuManager.registerAntiTimeOutHandler(function(arg_7_0, arg_7_1, arg_7_2)
		print("AntiTimeOut Callback: ", arg_7_0, arg_7_1, arg_7_2)

		if arg_7_0 == 0 then
			self:antiAddiction("2")
		end
	end)
end

function var_0_0:getPlatform()
	return self.accountInfo.platform
end

function var_0_0:getToken()
	return self.accountInfo.token
end

local function var_0_8(arg_10_0)
	return cc.Crypto:MD5(string.format("channel=%s&clientbranch=%s&clientbranch=%s&platform=%s&time=%s", arg_10_0.channel or "", arg_10_0.clientbranch or "", arg_10_0.clientversion, arg_10_0.platform, arg_10_0.time or ""), false, true)
end

local function var_0_9()
	local var_11_0 = {
		platform = DeviceManager.platform,
		channel = var_0_0:getChannel(),
		clientversion = config.version,
		clientbranch = config.clientbranch,
		time = tostring(os.time())
	}

	if cc.Native.getVersionCode then
		var_11_0.versioncode = cc.Native:getVersionCode()
	end

	var_11_0.sign = var_0_8(var_11_0)

	return json.encode(var_11_0)
end

local function var_0_10(arg_12_0, arg_12_1)
	local var_12_0 = DeviceManager.createHTTPRequest(function(arg_13_0)
		local var_13_0 = arg_13_0.request

		if arg_13_0.name ~= "completed" then
			return
		end

		if var_13_0:getResponseStatusCode() ~= 200 then
			if arg_12_1 then
				arg_12_1(0)
			end

			return
		end

		if arg_12_1 then
			arg_12_1(1, json.decode((var_13_0:getResponseString())))
		end
	end, arg_12_0, "POST")

	var_12_0:setTimeout(35)
	var_12_0:setPOSTData((var_0_9()))
	var_12_0:start()
end

function PUSH_ALIAS_CALLBACK(...)
	print("###################################")
	print("test set push alias callback...")
	print(dump({
		...
	}))
	print("####################################")
end

function var_0_0:verifyChannelPlayerid(arg_15_1, arg_15_2, arg_15_3)
	var_0_10(string.format("%s?method=verify_v3&uid=%s&platform=%s&channel=fyuser&token=%s", config.loginurl, arg_15_1, self.accountInfo.platform, arg_15_2), function(arg_16_0, arg_16_1)
		if arg_16_0 == 0 then
			if arg_15_3 then
				arg_15_3(0)
			end
		else
			local var_16_0 = arg_16_1.errcode

			if arg_16_1.errcode == -1 then
				if arg_15_3 then
					arg_15_3(0)
				end
			elseif var_16_0 == -2 then
				if not network:isConnected() then
					if arg_16_1.serverid ~= self:getServerID() then
						package_loader.switch_server_data_package(arg_16_1.serverid)
					end

					self:setServerInfo({
						id = arg_16_1.serverid,
						name = arg_16_1.servername,
						tag = arg_16_1.servertag
					})
				end

				if arg_15_3 then
					arg_15_3(2, string.urldecode(arg_16_1.msg))
				end
			elseif var_16_0 == -3 then
				local var_16_1 = cc.EventCustom:new("NEED_CLIENT_V3")

				var_16_1.downloadurl = string.urldecode(arg_16_1.downloadurl)

				cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_16_1)

				if arg_15_3 then
					arg_15_3(0)
				end
			else
				if arg_16_1.needharmony == 1 then
					global_open_harmony_world()
				end

				if network:isConnected() then
					if arg_16_1.serverid == self:getServerID() then
						if arg_15_3 then
							arg_15_3(1)
						end
					else
						package_loader.switch_server_data_package(arg_16_1.serverid)
						self:setServerInfo({
							id = arg_16_1.serverid,
							name = arg_16_1.servername,
							tag = arg_16_1.servertag
						})
						network:closeOnLogout()

						if not network:connect(arg_16_1.ip, arg_16_1.port, arg_15_3) and arg_15_3 then
							arg_15_3(0)
						end
					end
				else
					if arg_16_1.serverid ~= self:getServerID() then
						package_loader.switch_server_data_package(arg_16_1.serverid)
					end

					self:setServerInfo({
						id = arg_16_1.serverid,
						name = arg_16_1.servername,
						tag = arg_16_1.servertag
					})

					if not network:connect(arg_16_1.ip, arg_16_1.port, arg_15_3) and arg_15_3 then
						arg_15_3(0)
					end
				end

				if umeng_setAlias then
					print("############################")
					print("SetAlias: ", arg_15_1)
					print("############################")
					umeng_setAlias(arg_15_1, "feiyu", "PUSH_ALIAS_CALLBACK")
				end
			end
		end
	end)
end

function var_0_0:getPlayerData(arg_17_1, arg_17_2)
	print("getPlayerData: ", arg_17_1)
	network:rpc("get_user_account_data", {
		userchannel = "fyuser",
		token = "",
		uid = arg_17_1,
		platform = DeviceManager.platform,
		channelid = self:getChannel(),
		tapadid = self:getTapadid(),
		device = DeviceManager.getDeviceID(),
		sdkver = config.version,
		ntguard = self:isIntegrateNT() and 1 or 0
	}, function(arg_18_0)
		print("getPlayerDataResult: ", dump(arg_18_0))

		if arg_18_0.result == 1 or arg_18_0.result == 3 then
			self.accountInfo.uid = arg_17_1
			self.accountInfo.userinfo = arg_18_0.userinfo

			if arg_18_0.new then
				self:createrole()

				self.playerFirstLogin = true

				self:onPlayerCreate(self.accountInfo.userinfo["playerid" .. self.accountInfo.userinfo.defaultid])
			end

			self:onFeiyuAccountLogin()

			if arg_17_2 then
				arg_17_2(arg_18_0.result)
			end
		elseif arg_17_2 then
			arg_17_2(2)
		end
	end)
end

function var_0_0:setServerInfo(arg_19_1)
	self.serverInfo.id = arg_19_1.id
	self.serverInfo.name = arg_19_1.name
	self.serverInfo.tag = arg_19_1.tag

	local var_19_0 = {
		[1] = "3",
		[2] = "5"
	}

	if FeiyuManager.setServerID then
		FeiyuManager.setServerID(var_19_0[arg_19_1.id])
	else
		function FeiyuManager.getServerID()
			return var_19_0[arg_19_1.id]
		end
	end
end

function var_0_0:getServerInfo()
	return self.serverInfo
end

function var_0_0:getServerID()
	return self.serverInfo.id
end

function var_0_0:getServerList(arg_23_1)
	var_0_10(string.format("%s?method=getlist&uid=%s", config.loginurl, self.accountInfo.uid), function(arg_24_0, arg_24_1)
		if arg_24_0 == 0 then
			if arg_23_1 then
				arg_23_1(0)
			end
		elseif arg_23_1 then
			arg_23_1(1, arg_24_1.all, arg_24_1.close)
		end
	end)
end

function var_0_0:selectServer(arg_25_1, arg_25_2)
	var_0_10(string.format("%s?method=select_server&uid=%s&serverid=%d", config.loginurl, self.accountInfo.uid, arg_25_1), function(arg_26_0, arg_26_1)
		if arg_26_0 == 0 then
			if arg_25_2 then
				arg_25_2(-1)
			end
		elseif arg_26_1.errorcode == -2 then
			if arg_25_2 then
				arg_25_2(2, string.urldecode(arg_26_1.msg))
			end
		else
			self:setServerInfo({
				id = arg_26_1.serverid,
				name = arg_26_1.servername,
				tag = arg_26_1.servertag
			})
			package_loader.switch_server_data_package(arg_26_1.serverid)
			network:closeOnLogout()

			if not network:connect(arg_26_1.ip, arg_26_1.port, arg_25_2) and arg_25_2 then
				arg_25_2(0)
			end
		end
	end)
end

function var_0_0:playerLogin(arg_27_1)
	if self.feiyuLoginReady then
		if arg_27_1 then
			arg_27_1(4)
		end

		self.feiyuLoginReady = false
	else
		self.loginRequestingHandler = arg_27_1

		FeiyuManager.login()
	end
end

function var_0_0.switchaccount(arg_28_0, arg_28_1)
	arg_28_0.loginRequestingHandler = arg_28_1

	FeiyuManager.switchAccount()
end

function var_0_0.usercenterwithinfo(arg_29_0)
	local playermodel = require("model.playermodel")

	FeiyuManager.openUserCenter({
		playerId = tostring(playermodel.playerid),
		playerName = playermodel.nickname,
		serverId = FeiyuManager.getServerID(),
		serverName = FeiyuManager.getServerID(),
		playerLevel = tostring(playermodel.grade)
	})
end

local var_0_11

function var_0_0.getChannel(arg_30_0)
	var_0_11 = var_0_11 or DeviceManager.getChannelID()

	return var_0_11
end

function var_0_0:getPlayerShowInfo()
	return "ID", self.accountInfo.playerid
end

function var_0_0:login(arg_32_1, arg_32_2)
	local var_32_0 = self.accountInfo.uid
	local var_32_1 = self.accountInfo.channel

	assert(self.accountInfo.uid and var_32_1)
	network:rpc("player_login", {
		token = string.format("%s@%s", crypt.base64encode(var_32_0), crypt.base64encode(var_32_1)),
		pos = arg_32_1,
		device = DeviceManager.getDeviceID(),
		platform = DeviceManager.platform,
		sdkver = config.version,
		ntguard = self:isIntegrateNT() and 1 or 0,
		channelid = self:getChannel(),
		packageversion = DeviceManager.getPackageAssetsVersion(),
		tapadid = self:getTapadid()
	}, function(arg_33_0)
		if arg_33_0.result == 1 then
			network:set_login_info(2, arg_33_0.playerid)
			network:connect_check_schedule()
			TrackingManager.login(arg_33_0.playerid)
			buglySetUserId(tostring(arg_33_0.playerid))
			self:onPlayerLogin(arg_33_0.playerid)

			self.accountInfo.userinfo.defaultid = arg_32_1

			if arg_32_2 then
				arg_32_2(1, arg_33_0.playerid)
			end
		elseif arg_33_0.result == 2 then
			if arg_32_2 then
				arg_32_2(2)
			end
		elseif arg_32_2 then
			arg_32_2(arg_33_0.result, arg_33_0.errmsg)
		end
	end)
end

function var_0_0:addAndLogin(arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = self.accountInfo.uid
	local var_34_1 = self.accountInfo.channel

	assert(self.accountInfo.uid and var_34_1 and arg_34_1)
	network:rpc("user_add_player", {
		uid = var_34_0,
		channel = var_34_1,
		pos = arg_34_1,
		name = arg_34_2,
		device = DeviceManager.getDeviceID(),
		platform = DeviceManager.platform,
		sdkver = config.version,
		ntguard = self:isIntegrateNT() and 1 or 0,
		channelid = self:getChannel(),
		packageversion = DeviceManager.getPackageAssetsVersion(),
		tapadid = self:getTapadid()
	}, function(arg_35_0)
		if arg_35_0.result == 1 then
			network:set_login_info(2, arg_35_0.playerid)
			network:connect_check_schedule()
			TrackingManager.login(arg_35_0.playerid)
			buglySetUserId(tostring(arg_35_0.playerid))

			self.playerFirstLogin = true

			self:onPlayerCreate(arg_35_0.playerid, arg_34_2)
			self:onPlayerLogin(arg_35_0.playerid, arg_34_2)

			self.accountInfo.userinfo.defaultid = arg_34_1
			self.accountInfo.userinfo["playerid" .. arg_34_1] = arg_35_0.playerid

			if arg_34_3 then
				arg_34_3(1, arg_35_0.playerid)
			end
		else
			if arg_35_0.playerid then
				self.accountInfo.userinfo["playerid" .. arg_34_1] = arg_35_0.playerid
				self.playerInfo[arg_35_0.playerid] = {
					head = 9202101,
					class = 1,
					showgirl = "2100",
					grade = 1,
					rolenum = 1,
					level = "1-1-1",
					name = arg_34_2
				}

				FeiyuManager.onPlayerCreate(playerid, arg_34_2 or "", FeiyuManager.getServerID(), self:getUserID(), "1")
				FeiyuManager.collectInfo({
					method = "createRole",
					playerLevel = "1",
					playerId = tostring(arg_35_0.playerid),
					playerName = arg_34_2,
					serverId = FeiyuManager.getServerID(),
					serverName = FeiyuManager.getServerID(),
					playerTime = tostring(os.time())
				})
			end

			if arg_34_3 then
				arg_34_3(arg_35_0.result, arg_35_0.errmsg)
			end
		end
	end)
end

function var_0_0:getUserPlayerInfo(arg_36_1, arg_36_2)
	local var_36_0 = self.accountInfo.userinfo

	assert(arg_36_1 > 0 and arg_36_1 < 13, arg_36_1)

	local var_36_1 = var_36_0["playerid" .. arg_36_1]

	assert(var_36_0["playerid" .. arg_36_1])

	if self.playerInfo[var_36_0["playerid" .. arg_36_1]] then
		if arg_36_2 then
			arg_36_2(1, self.playerInfo[var_36_0["playerid" .. arg_36_1]])
		end
	else
		network:rpc("get_user_player_info", {
			playerid = var_36_0["playerid" .. arg_36_1]
		}, function(arg_37_0)
			if arg_37_0.result == 1 then
				self.playerInfo[var_36_1] = arg_37_0.playerinfo

				if arg_36_2 then
					arg_36_2(arg_37_0.result, arg_37_0.playerinfo)
				end
			end
		end)
	end
end

function var_0_0:getUserPlayerid()
	if not self.accountInfo.userinfo then
		return nil
	end

	return self.accountInfo.userinfo["playerid" .. self.accountInfo.userinfo.defaultid]
end

function var_0_0:getUserPlayerIndex()
	return self.accountInfo.userinfo.defaultid
end

function var_0_0:getUserPlayeridByPos(arg_40_1)
	if self.accountInfo.userinfo["playerid" .. arg_40_1] and self.accountInfo.userinfo["playerid" .. arg_40_1] ~= 0 then
		return self.accountInfo.userinfo["playerid" .. arg_40_1]
	else
		return nil
	end
end

function var_0_0:isUserPlayerInfoCached(arg_41_1)
	return self.playerInfo[arg_41_1] ~= nil
end

function var_0_0:getUserPlayerInfoByPlayerid(arg_42_1)
	return self.playerInfo[arg_42_1]
end

local var_0_12 = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
}

function var_0_0:canCreateNewPlayer(arg_43_1)
	if var_0_12[arg_43_1] <= 0 then
		return true
	end

	local var_43_0 = self.accountInfo.userinfo.playerid1

	if self.playerInfo[self.accountInfo.userinfo.playerid1] then
		return self.playerInfo[var_43_0].grade >= var_0_12[arg_43_1]
	else
		network:rpc("get_user_player_info", {
			playerid = var_43_0
		}, function(arg_44_0)
			if arg_44_0.result == 1 then
				self.playerInfo[var_43_0] = arg_44_0.playerinfo
			end
		end)

		return false
	end
end

function var_0_0:updatePlayerInfoOnLogOut()
	local playermodel = require("model.playermodel")
	local var_45_1 = {
		name = playermodel.nickname,
		class = playermodel.class,
		grade = playermodel.grade
	}

	var_45_1.level = playermodel.curMode .. "-" .. (playermodel.curLevel or "1")
	var_45_1.head = playermodel.head_sculpture
	var_45_1.showgirl = playermodel.showgirl
	var_45_1.rolenum = playermodel:getOwnedServantNum()
	self.playerInfo[playermodel.playerid] = var_45_1
end

function var_0_0:getUserID()
	return self.accountInfo.uid
end

function var_0_0:getUnionID()
	return self.accountInfo.unionid
end

function var_0_0:activate_user(arg_48_1, arg_48_2)
	if string.len(arg_48_1) == 0 then
		if arg_48_2 then
			arg_48_2(0)
		end

		return
	end

	network:rpc("activate_uid", {
		uid = self:getUserID(),
		key = arg_48_1
	}, function(arg_49_0)
		if arg_48_2 then
			arg_48_2(arg_49_0.result)
		end
	end)
end

function var_0_0:isPlayerFirstLogin()
	return self.playerFirstLogin
end

function var_0_0:collectPlayerInfoOnLogin(arg_51_1)
	local var_51_0 = self.playerInfo[arg_51_1] or {}
	local var_51_1 = (function(arg_52_0)
		local var_52_0, var_52_1, var_52_2 = arg_52_0:match("(%d+)-(%d+)-(%d+)")

		return var_52_0 .. "-" .. var_52_1
	end)(var_51_0.level or "1-1-1")
	local var_51_2 = 0

	for iter_51_0 = 1, 4 do
		if self.accountInfo.userinfo["playerid" .. iter_51_0] and self.accountInfo.userinfo["playerid" .. iter_51_0] > 0 then
			var_51_2 = var_51_2 + 1
		end
	end

	return {
		city = var_51_1,
		grade = var_51_0.grade,
		class = var_51_0.class,
		rolenum = var_51_0.rolenum,
		playernum = var_51_2
	}
end

function var_0_0:onFeiyuAccountLogin()
	local var_53_0 = self:getUserID()

	FeiyuManager.onAccountRegister(var_53_0)
	FeiyuManager.onAccountLogin(var_53_0, (self:getUnionID()))
end

function var_0_0.onPlayerCreate(arg_54_0, arg_54_1, arg_54_2)
	return
end

function var_0_0.onPlayerLogin(arg_55_0, arg_55_1)
	return
end

function var_0_0:onPlayerUpdate()
	self:collectInfo("levelUp")
end

function var_0_0:onEnterGame()
	if self.playerFirstLogin then
		self:collectInfo("createRole")

		self.playerFirstLogin = false
	end

	self:collectInfo("enterServer")
	FeiyuManager.enterGame(require("model.playermodel").playerid, FeiyuManager.getServerID())
end

function var_0_0:createrole(arg_58_1)
	TrackingManager.register(self.accountInfo.userid)
end

function var_0_0.collectInfo(arg_59_0, arg_59_1)
	if DeviceManager.platform == "android" then
		local playermodel = require("model.playermodel")

		FeiyuManager.collectInfo({
			method = arg_59_1,
			playerId = tostring(playermodel.playerid),
			playerName = playermodel.nickname,
			playerLevel = tostring(playermodel.grade),
			serverId = FeiyuManager.getServerID(),
			serverName = FeiyuManager.getServerID(),
			playerTime = playermodel.create_time
		})
	end
end

function var_0_0.isIntegrateNT(arg_60_0)
	return cc.Native.NTESCSGuardianGetToken ~= nil
end

function var_0_0:getAntiAddictionInfo()
	return self.antiAddictionInfo
end

function var_0_0.antiAddiction(arg_62_0, arg_62_1)
	arg_62_1 = arg_62_1 or "1"

	FeiyuManager.antiAddiction(arg_62_1)
end

function var_0_0.antiAddictTimeout(arg_63_0)
	FeiyuManager.isTimeOut()
end

function var_0_0:getAccountPlayerCount()
	local var_64_0 = 6

	for iter_64_0 = 7, 12 do
		if self.accountInfo.userinfo["playerid" .. iter_64_0] and self.accountInfo.userinfo["playerid" .. iter_64_0] > 0 then
			var_64_0 = var_64_0 + 1
		end
	end

	return var_64_0
end

function var_0_0:getAccountPlayerRealCount()
	local var_65_0 = 0

	for iter_65_0 = 1, 12 do
		if self.accountInfo.userinfo["playerid" .. iter_65_0] and self.accountInfo.userinfo["playerid" .. iter_65_0] > 0 then
			var_65_0 = var_65_0 + 1
		end
	end

	return var_65_0
end

function var_0_0.setOaid(arg_66_0, arg_66_1)
	arg_66_0.oaid = arg_66_1
end

function var_0_0:getTapadid()
	if DeviceManager.platform == "android" then
		return self.oaid
	elseif DeviceManager.platform == "ios" then
		return DeviceManager.getDeviceID()
	end
end

return var_0_0
