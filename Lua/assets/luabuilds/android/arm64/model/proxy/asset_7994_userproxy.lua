local UserProxy = class("UserProxy", import(".NetProxy"))

function UserProxy:register()
	self.userIsLogined = false
	self.gateways = {}
	self.canSwitchGateway = false

	return
end

function UserProxy:setLastLogin(arg_2_1)
	assert(isa(arg_2_1, User), "should be an instance of User")

	if arg_2_1.type == 1 then
		PlayerPrefs.SetString("user.type", "1")
		PlayerPrefs.SetString("user.arg1", arg_2_1.arg1)
		PlayerPrefs.SetString("user.arg2", arg_2_1.arg2)
		PlayerPrefs.SetString("user.arg3", arg_2_1.arg3)
	elseif arg_2_1.type == 2 then
		PlayerPrefs.SetString("user.type", "1")
		PlayerPrefs.SetString("user.arg1", "yongshi")
		PlayerPrefs.SetString("user.arg2", arg_2_1.arg1)
		PlayerPrefs.SetString("user.arg3", arg_2_1.token)
	elseif arg_2_1.type == 3 then
		PlayerPrefs.SetString("user.type", "3")
		PlayerPrefs.SetString("user.arg1", arg_2_1.arg1)
		PlayerPrefs.SetString("user.arg2", "")
		PlayerPrefs.SetString("user.arg3", "")
		PlayerPrefs.SetString("guest_uuid", arg_2_1.arg1)
	end

	PlayerPrefs.Save()

	self.data = arg_2_1:clone()

	self.data:display("logged in")

	if PLATFORM_CODE == PLATFORM_JP then
		self:clearTranscode()
	end

	return
end

function UserProxy.getLastLoginUser()
	local var_3_0 = tonumber(PlayerPrefs.GetString("user.type"))
	local var_3_1 = PlayerPrefs.GetString("user.arg1")
	local var_3_2 = PlayerPrefs.GetString("user.arg2")

	print("last login:", var_3_0, " arg1:", var_3_1)

	if var_3_0 ~= "" and var_3_1 ~= "" and var_3_2 ~= "" then
		return User.New({
			type = var_3_0,
			arg1 = var_3_1,
			arg2 = var_3_2,
			arg3 = PlayerPrefs.GetString("user.arg3")
		})
	end

	return nil
end

function UserProxy:saveTranscode(arg_4_1)
	PlayerPrefs.SetString("transcode", arg_4_1)
	PlayerPrefs.Save()

	return
end

function UserProxy:getTranscode()
	local var_5_0 = PlayerPrefs.GetString("transcode")

	if var_5_0 then
		return var_5_0
	end

	return ""
end

function UserProxy:clearTranscode()
	PlayerPrefs.DeleteKey("transcode")

	return
end

function UserProxy:SetLoginedFlag(arg_7_1)
	self.userIsLogined = arg_7_1

	return
end

function UserProxy:GetLoginedFlag()
	return self.userIsLogined
end

local var_0_1 = "#cacheGatewayFlag#"

function UserProxy:SetDefaultGateway()
	self.gateways[PLATFORM] = self.gateways[PLATFORM] or GatewayInfo.New(NetConst.GATEWAY_HOST, NetConst.GATEWAY_PORT, NetConst.PROXY_GATEWAY_HOST, NetConst.PROXY_GATEWAY_PORT)

	return
end

function UserProxy:ShouldSwitchGateway(arg_10_1, arg_10_2)
	return self:GetCacheGatewayFlag(arg_10_2) ~= arg_10_1
end

function UserProxy:GetGateWayByPlatform(arg_11_1)
	return self.gateways[arg_11_1]
end

function UserProxy:SetGatewayForPlatform(arg_12_1, arg_12_2)
	self.gateways[arg_12_1] = arg_12_2

	return
end

function UserProxy:GetCacheGatewayFlag(arg_13_1)
	self.cachePlatform = self.cachePlatform or PlayerPrefs.GetInt(var_0_1 .. arg_13_1, PLATFORM)

	return self.cachePlatform
end

function UserProxy:GetCacheGatewayInServerLogined()
	return self.cachePlatform or PLATFORM
end

function UserProxy:SetCacheGatewayFlag(arg_15_1)
	if self.cachePlatform ~= arg_15_1 then
		self.cachePlatform = arg_15_1
	end

	return
end

function UserProxy:SaveCacheGatewayFlag(arg_16_1)
	if not self.canSwitchGateway then
		return
	end

	if PlayerPrefs.GetInt(var_0_1 .. arg_16_1, PLATFORM) ~= self.cachePlatform then
		PlayerPrefs.SetInt(var_0_1 .. arg_16_1, self.cachePlatform)
		PlayerPrefs.Save()
	end

	return
end

function UserProxy:GetReversePlatform()
	return (self.cachePlatform == PLATFORM_IPHONEPLAYER or nil) and (PLATFORM_ANDROID or PLATFORM_IPHONEPLAYER)
end

function UserProxy:ActiveGatewaySwitcher()
	self.canSwitchGateway = true

	return
end

function UserProxy:ShowGatewaySwitcher()
	return self.canSwitchGateway
end

return UserProxy
