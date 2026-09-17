local var_0_0 = DeviceManager.getPackageChannel()

if var_0_0 == "FY" then
	if config.packagechannel == "palmpi" then
		account_manager = require("controller.account.account_palmpi")
	elseif config.packagechannel == "feiyu" then
		account_manager = require("controller.account.account_feiyu")
	end

	return account_manager
end

local var_0_1 = {}
local network = require("network.network")
local crypt = require("crypt")
local package_loader = require("controller.package_loader")

var_0_1.accountInfo = {
	channel = "fyuser"
}
var_0_1.playerInfo = {}
var_0_1.serverInfo = {}
var_0_1.loginRequestingHandler = nil
var_0_1.playerFirstLogin = false
var_0_1.playerNeedRealName = false
var_0_1.realNameInfo = {}
var_0_1.antiAddictionInfo = {
	needquit = false,
	needantiaddiction = false
}

local var_0_8 = require((string.format("controller.account.login_%s", var_0_0)))

function var_0_1:init()
	self.accountInfo.platform = SDKManager.getplatform()
	self.antiAddictionInfo = {
		needantiaddiction = false
	}

	var_0_8:init()
end

function var_0_1.onLoginSuccess(arg_2_0)
	if var_0_8.onLoginSuccess then
		var_0_8:onLoginSuccess()
	end
end

function var_0_1:getPlatform()
	return self.accountInfo.platform
end

function var_0_1:getToken()
	return self.accountInfo.token
end

local function var_0_9(arg_5_0)
	return cc.Crypto:MD5(string.format("channel=%s&clientbranch=%s&clientbranch=%s&platform=%s&time=%s", arg_5_0.channel or "", arg_5_0.clientbranch or "", arg_5_0.clientversion, arg_5_0.platform, arg_5_0.time or ""), false, true)
end

local function var_0_10()
	local var_6_0 = {
		platform = DeviceManager.platform,
		channel = var_0_1:getChannel(),
		clientversion = config.version,
		clientbranch = config.clientbranch,
		time = tostring(os.time())
	}

	if cc.Native.getVersionCode then
		var_6_0.versioncode = cc.Native:getVersionCode()
	end

	var_6_0.sign = var_0_9(var_6_0)

	return json.encode(var_6_0)
end

local function var_0_11(arg_7_0, arg_7_1)
	local var_7_0 = DeviceManager.createHTTPRequest(function(arg_8_0)
		local var_8_0 = arg_8_0.request

		if arg_8_0.name ~= "completed" then
			return
		end

		if var_8_0:getResponseStatusCode() ~= 200 then
			if arg_7_1 then
				arg_7_1(0)
			end

			return
		end

		if arg_7_1 then
			arg_7_1(1, json.decode((var_8_0:getResponseString())))
		end
	end, arg_7_0, "POST")

	var_7_0:setTimeout(35)
	var_7_0:setPOSTData((var_0_10()))
	var_7_0:start()
end

function PUSH_ALIAS_CALLBACK(...)
	print("###################################")
	print("test set push alias callback...")
	print(dump({
		...
	}))
	print("####################################")
end

function var_0_1:verifyChannelPlayerid(arg_10_1, arg_10_2, arg_10_3)
	local assets_manager = require("controller.updatemodule.assets_manager")

	if assets_manager.pushThinkingDataCilent then
		assets_manager:pushThinkingDataCilent("sdk_login_success", {
			uid = arg_10_1,
			token = arg_10_2
		})
	end

	var_0_11(string.format("%s?method=verify_v3&uid=%s&platform=%s&channel=%s&token=%s&qq_or_weixin=%s", LOGIN_DEBUG_URL or config.loginurl, arg_10_1, self.accountInfo.platform, DeviceManager.getPackageChannel(), arg_10_2, self.loginType), function(arg_11_0, arg_11_1)
		if arg_11_1.uid then
			self.accountInfo.uid = arg_11_1.uid
		end

		if arg_11_1.channel_uid then
			self.accountInfo.channel_uid = string.sub(arg_11_1.channel_uid, 8)
		end

		if assets_manager.pushThinkingDataCilent then
			assets_manager:pushThinkingDataCilent("game_login_result", {
				uid = arg_11_1.uid,
				channel_uid = arg_11_1.channel_uid,
				result = arg_11_0,
				errorcode = arg_11_1.errorcode
			})
		end

		if arg_11_0 == 0 then
			if arg_10_3 then
				arg_10_3(0)
			end
		else
			local var_11_0 = arg_11_1.errcode

			if arg_11_1.errcode == -1 then
				if arg_10_3 then
					arg_10_3(0)
				end
			elseif var_11_0 == -2 then
				if not network:isConnected() then
					if arg_11_1.serverid ~= self:getServerID() then
						package_loader.switch_server_data_package(arg_11_1.serverid)
					end

					self:setServerInfo({
						id = arg_11_1.serverid,
						name = arg_11_1.servername,
						tag = arg_11_1.servertag
					})
				end

				if arg_10_3 then
					arg_10_3(2, string.urldecode(arg_11_1.msg))
				end
			elseif var_11_0 == -3 then
				local var_11_1 = cc.EventCustom:new("NEED_CLIENT_V3")

				var_11_1.downloadurl = string.urldecode(arg_11_1.downloadurl)

				cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_11_1)

				if arg_10_3 then
					arg_10_3(0)
				end
			else
				if arg_11_1.needharmony == 1 then
					global_open_harmony_world()
				end

				if network:isConnected() then
					if arg_11_1.serverid == self:getServerID() then
						if arg_10_3 then
							arg_10_3(1)
						end
					else
						package_loader.switch_server_data_package(arg_11_1.serverid)
						self:setServerInfo({
							id = arg_11_1.serverid,
							name = arg_11_1.servername,
							tag = arg_11_1.servertag
						})
						network:closeOnLogout()

						if not network:connect(arg_11_1.ip, arg_11_1.port, arg_10_3) and arg_10_3 then
							arg_10_3(0)
						end
					end
				else
					if arg_11_1.serverid ~= self:getServerID() then
						package_loader.switch_server_data_package(arg_11_1.serverid)
					end

					self:setServerInfo({
						id = arg_11_1.serverid,
						name = arg_11_1.servername,
						tag = arg_11_1.servertag
					})

					if not network:connect(arg_11_1.ip, arg_11_1.port, arg_10_3) and arg_10_3 then
						arg_10_3(0)
					end
				end

				if umeng_setAlias then
					print("############################")
					print("SetAlias: ", arg_10_1)
					print("############################")
					umeng_setAlias(arg_10_1, DeviceManager.getPackageChannel(), "PUSH_ALIAS_CALLBACK")
				end
			end
		end
	end)
end

function var_0_1:getPlayerData(arg_12_1, arg_12_2)
	print("getPlayerData: ", arg_12_1)
	network:rpc("get_user_account_data", {
		userchannel = "fyuser",
		token = "",
		uid = arg_12_1,
		platform = DeviceManager.platform,
		channelid = self:getChannel(),
		device = DeviceManager.getDeviceID(),
		sdkver = config.version,
		ntguard = self:isIntegrateNT() and 1 or 0,
		tapadid = self:getTapadid()
	}, function(arg_13_0)
		print("getPlayerDataResult: ", dump(arg_13_0))

		if arg_13_0.result == 1 or arg_13_0.result == 3 then
			self.accountInfo.uid = arg_12_1
			self.accountInfo.userinfo = arg_13_0.userinfo

			if arg_13_0.new then
				self:createrole()

				self.playerFirstLogin = true

				self:onPlayerCreate(self.accountInfo.userinfo["playerid" .. self.accountInfo.userinfo.defaultid])
			end

			if arg_12_2 then
				arg_12_2(arg_13_0.result)
			end
		elseif arg_12_2 then
			arg_12_2(2)
		end
	end)
end

function var_0_1:setServerInfo(arg_14_1)
	self.serverInfo.id = arg_14_1.id
	self.serverInfo.name = arg_14_1.name
	self.serverInfo.tag = arg_14_1.tag
end

function var_0_1:getServerInfo()
	return self.serverInfo
end

function var_0_1:getServerID()
	return self.serverInfo.id
end

function var_0_1:getServerList(arg_17_1)
	var_0_11(string.format("%s?method=getlist&uid=%s", LOGIN_DEBUG_URL or config.loginurl, self.accountInfo.uid), function(arg_18_0, arg_18_1)
		if arg_18_0 == 0 then
			if arg_17_1 then
				arg_17_1(0)
			end
		elseif arg_17_1 then
			arg_17_1(1, arg_18_1.all, arg_18_1.close)
		end
	end)
end

function var_0_1:selectServer(arg_19_1, arg_19_2)
	var_0_11(string.format("%s?method=select_server&uid=%s&serverid=%d", LOGIN_DEBUG_URL or config.loginurl, self.accountInfo.uid, arg_19_1), function(arg_20_0, arg_20_1)
		if arg_20_0 == 0 then
			if arg_19_2 then
				arg_19_2(-1)
			end
		elseif arg_20_1.errorcode == -2 then
			if arg_19_2 then
				arg_19_2(2, string.urldecode(arg_20_1.msg))
			end
		else
			self:setServerInfo({
				id = arg_20_1.serverid,
				name = arg_20_1.servername,
				tag = arg_20_1.servertag
			})
			package_loader.switch_server_data_package(arg_20_1.serverid)
			network:closeOnLogout()

			if not network:connect(arg_20_1.ip, arg_20_1.port, arg_19_2) and arg_19_2 then
				arg_19_2(0)
			end
		end
	end)
end

function var_0_1.playerLogin(arg_21_0, arg_21_1)
	arg_21_0.loginRequestingHandler = arg_21_1

	var_0_8.login()

	local assets_manager = require("controller.updatemodule.assets_manager")

	if assets_manager.pushThinkingDataCilent then
		assets_manager:pushThinkingDataCilent("sdk_login")
	end
end

function var_0_1.switchaccount(arg_22_0, arg_22_1)
	arg_22_0.loginRequestingHandler = arg_22_1

	if SDKManager.switchAccount then
		SDKManager.switchAccount()
	elseif SDKManager.logout then
		SDKManager.logout()
	else
		var_0_8.login()
	end

	local assets_manager = require("controller.updatemodule.assets_manager")

	if assets_manager.pushThinkingDataCilent then
		assets_manager:pushThinkingDataCilent("sdk_switch_account")
	end
end

function var_0_1.usercenterwithinfo(arg_23_0)
	if SDKManager.showUserCenter then
		SDKManager:showUserCenter()
	end
end

local var_0_12

function var_0_1.getChannel(arg_24_0)
	var_0_12 = var_0_12 or DeviceManager.getChannelID()

	return var_0_12
end

function var_0_1:getPlayerShowInfo()
	return "ID", self.accountInfo.playerid
end

function var_0_1:login(arg_26_1, arg_26_2)
	local var_26_0 = self.accountInfo.uid
	local var_26_1 = self.accountInfo.channel

	assert(self.accountInfo.uid and var_26_1)
	network:rpc("player_login", {
		token = string.format("%s@%s", crypt.base64encode(var_26_0), crypt.base64encode(var_26_1)),
		pos = arg_26_1,
		device = DeviceManager.getDeviceID(),
		platform = DeviceManager.platform,
		sdkver = config.version,
		ntguard = self:isIntegrateNT() and 1 or 0,
		channelid = self:getChannel(),
		packageversion = DeviceManager.getPackageAssetsVersion(),
		packagechannel = DeviceManager.getPackageChannel(),
		tapadid = self:getTapadid(),
		hexiechannelid = self:getHexiechannelid(),
		ismoegirlchannel = self:getIsMoegirlChannel()
	}, function(arg_27_0)
		if arg_27_0.result == 1 then
			network:set_login_info(2, arg_27_0.playerid)
			network:connect_check_schedule()
			buglySetUserId(tostring(arg_27_0.playerid))

			self.accountInfo.userinfo.defaultid = arg_26_1

			if arg_26_2 then
				arg_26_2(1, arg_27_0.playerid)
			end
		elseif arg_27_0.result == 2 then
			if arg_26_2 then
				arg_26_2(2)
			end
		elseif arg_26_2 then
			arg_26_2(arg_27_0.result, arg_27_0.errmsg)
		end
	end)
end

function var_0_1:addAndLogin(arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = self.accountInfo.uid
	local var_28_1 = self.accountInfo.channel

	assert(self.accountInfo.uid and var_28_1 and arg_28_1)
	network:rpc("user_add_player", {
		uid = var_28_0,
		channel = var_28_1,
		pos = arg_28_1,
		name = arg_28_2,
		device = DeviceManager.getDeviceID(),
		platform = DeviceManager.platform,
		sdkver = config.version,
		ntguard = self:isIntegrateNT() and 1 or 0,
		channelid = self:getChannel(),
		packageversion = DeviceManager.getPackageAssetsVersion(),
		packagechannel = DeviceManager.getPackageChannel(),
		tapadid = self:getTapadid(),
		hexiechannelid = self:getHexiechannelid(),
		ismoegirlchannel = self:getIsMoegirlChannel()
	}, function(arg_29_0)
		if arg_29_0.result == 1 then
			self:createrole()
			network:set_login_info(2, arg_29_0.playerid)
			network:connect_check_schedule()
			buglySetUserId(tostring(arg_29_0.playerid))

			self.playerFirstLogin = true
			self.accountInfo.userinfo.defaultid = arg_28_1
			self.accountInfo.userinfo["playerid" .. arg_28_1] = arg_29_0.playerid

			if arg_28_3 then
				arg_28_3(1, arg_29_0.playerid)
			end
		else
			if arg_29_0.playerid then
				self.accountInfo.userinfo["playerid" .. arg_28_1] = arg_29_0.playerid
				self.playerInfo[arg_29_0.playerid] = {
					head = 9202101,
					class = 1,
					showgirl = "2100",
					grade = 1,
					rolenum = 1,
					level = "1-1-1",
					name = arg_28_2
				}
			end

			if arg_28_3 then
				arg_28_3(arg_29_0.result, arg_29_0.errmsg)
			end
		end
	end)
end

function var_0_1:getUserPlayerInfo(arg_30_1, arg_30_2)
	local var_30_0 = self.accountInfo.userinfo

	assert(arg_30_1 > 0 and arg_30_1 < 13, arg_30_1)

	local var_30_1 = var_30_0["playerid" .. arg_30_1]

	assert(var_30_0["playerid" .. arg_30_1])

	if self.playerInfo[var_30_0["playerid" .. arg_30_1]] then
		if arg_30_2 then
			arg_30_2(1, self.playerInfo[var_30_0["playerid" .. arg_30_1]])
		end
	else
		network:rpc("get_user_player_info", {
			playerid = var_30_0["playerid" .. arg_30_1]
		}, function(arg_31_0)
			if arg_31_0.result == 1 then
				self.playerInfo[var_30_1] = arg_31_0.playerinfo

				if arg_30_2 then
					arg_30_2(arg_31_0.result, arg_31_0.playerinfo)
				end
			elseif arg_30_2 then
				arg_30_2(arg_31_0.result)
			end
		end)
	end
end

function var_0_1:getUserPlayerid()
	if not self.accountInfo.userinfo then
		return nil
	end

	return self.accountInfo.userinfo["playerid" .. self.accountInfo.userinfo.defaultid]
end

function var_0_1:getUserPlayerIndex()
	return self.accountInfo.userinfo.defaultid
end

function var_0_1:getUserPlayeridByPos(arg_34_1)
	if self.accountInfo.userinfo["playerid" .. arg_34_1] and self.accountInfo.userinfo["playerid" .. arg_34_1] ~= 0 then
		return self.accountInfo.userinfo["playerid" .. arg_34_1]
	else
		return nil
	end
end

function var_0_1:isUserPlayerInfoCached(arg_35_1)
	return self.playerInfo[arg_35_1] ~= nil
end

function var_0_1:getUserPlayerInfoByPlayerid(arg_36_1)
	return self.playerInfo[arg_36_1]
end

local var_0_13 = {
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

function var_0_1:canCreateNewPlayer(arg_37_1)
	if var_0_13[arg_37_1] <= 0 then
		return true
	end

	local var_37_0 = self.accountInfo.userinfo.playerid1

	if self.playerInfo[self.accountInfo.userinfo.playerid1] then
		return self.playerInfo[var_37_0].grade >= var_0_13[arg_37_1]
	else
		network:rpc("get_user_player_info", {
			playerid = var_37_0
		}, function(arg_38_0)
			if arg_38_0.result == 1 then
				self.playerInfo[var_37_0] = arg_38_0.playerinfo
			end
		end)

		return false
	end
end

function var_0_1:updatePlayerInfoOnLogOut()
	local playermodel = require("model.playermodel")

	self.playerInfo[playermodel.playerid] = {
		name = playermodel.nickname,
		class = playermodel.class,
		grade = playermodel.grade,
		level = playermodel.curMode .. "-" .. playermodel.curLevel,
		head = playermodel.head_sculpture,
		showgirl = playermodel.showgirl,
		rolenum = playermodel:getOwnedServantNum()
	}
end

function var_0_1:getUserID()
	return self.accountInfo.uid
end

function var_0_1:getUnionID()
	return self.accountInfo.unionid
end

function var_0_1:activate_user(arg_42_1, arg_42_2)
	if string.len(arg_42_1) == 0 then
		if arg_42_2 then
			arg_42_2(0)
		end

		return
	end

	network:rpc("activate_uid", {
		uid = self:getUserID(),
		key = arg_42_1
	}, function(arg_43_0)
		if arg_42_2 then
			arg_42_2(arg_43_0.result)
		end
	end)
end

function var_0_1:isPlayerFirstLogin()
	return self.playerFirstLogin
end

function var_0_1:collectPlayerInfoOnLogin(arg_45_1)
	local var_45_0 = self.playerInfo[arg_45_1] or {}
	local var_45_1 = (function(arg_46_0)
		local var_46_0, var_46_1, var_46_2 = arg_46_0:match("(%d+)-(%d+)-(%d+)")

		return var_46_0 .. "-" .. var_46_1
	end)(var_45_0.level or "1-1-1")
	local var_45_2 = 0

	for iter_45_0 = 1, 4 do
		if self.accountInfo.userinfo["playerid" .. iter_45_0] and self.accountInfo.userinfo["playerid" .. iter_45_0] > 0 then
			var_45_2 = var_45_2 + 1
		end
	end

	return {
		city = var_45_1,
		grade = var_45_0.grade,
		class = var_45_0.class,
		rolenum = var_45_0.rolenum,
		playernum = var_45_2
	}
end

function var_0_1.createrole(arg_47_0)
	if SDKManager.createRole then
		SDKManager.createRole()
	end
end

function var_0_1.isIntegrateNT(arg_48_0)
	return cc.Native.NTESCSGuardianGetToken ~= nil
end

function var_0_1:getAccountPlayerCount()
	local var_49_0 = 6

	for iter_49_0 = 7, 12 do
		if self.accountInfo.userinfo["playerid" .. iter_49_0] and self.accountInfo.userinfo["playerid" .. iter_49_0] > 0 then
			var_49_0 = var_49_0 + 1
		end
	end

	return var_49_0
end

function var_0_1:getAccountPlayerRealCount()
	local var_50_0 = 0

	for iter_50_0 = 1, 12 do
		if self.accountInfo.userinfo["playerid" .. iter_50_0] and self.accountInfo.userinfo["playerid" .. iter_50_0] > 0 then
			var_50_0 = var_50_0 + 1
		end
	end

	return var_50_0
end

function var_0_1.onEnterGame(arg_51_0)
	return
end

function var_0_1.onPlayerUpdate(arg_52_0)
	return
end

function var_0_1:getChannelUid()
	return self.accountInfo.channel_uid
end

function var_0_1.onPlayerCreate(arg_54_0)
	return
end

function var_0_1.getOaid(arg_55_0)
	local var_55_0 = DeviceManager.getChannelID()

	print("channelid", var_55_0)
	print("cc.Native.getOaid", cc.Native.getOaid)

	if var_55_0 == "270049" and cc.Native.getOaid then
		print("cc.Native:getOaid()", cc.Native:getOaid())

		return cc.Native:getOaid()
	else
		return
	end
end

function var_0_1:getTapadid()
	if DeviceManager.platform == "android" then
		return self:getOaid()
	elseif DeviceManager.platform == "ios" then
		return
	end
end

function var_0_1.getHexiechannelid(arg_57_0)
	if cc.Native.getHexieChannelId then
		local var_57_0 = cc.Native:getHexieChannelId()

		if var_57_0 and var_57_0 ~= "" then
			return var_57_0
		end
	end
end

function var_0_1.getIsMoegirlChannel(arg_58_0)
	if SDKManager and SDKManager.isMoegirlChannel then
		return SDKManager:isMoegirlChannel()
	end
end

return var_0_1
