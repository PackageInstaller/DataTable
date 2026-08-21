---@class LoginNetManager
local LoginNetManager = class("LoginNetManager",  require "NetManager2")

local _loginRetryTimes = 1

function LoginNetManager:ctor(name)

	--self.super:ctor(name)

    self.secret = ""

    self.ip, self.port = SDKMgr.loginip, SDKMgr.loginport
    self.loginingZone = false
	
	self.tryReconTimes = 0
	self.doLoginCallback = nil
	self.canTry = true
	self.retrying = false
	-- Debugger.Log("LoginNetManager {0}", name)
end

function LoginNetManager:doLogin(callBack, try)
	local host = self.ip
	local port = self.port

	if try then
		self.retrying = true
	else
		self.tryReconTimes = 0
		self.retrying = false
	end
	
	self.doLoginCallback = callBack
	
	self:Disconnect()

	local crypt = require "crypt"
	local challenge
	self.secret = ""

	local function loginAuth()
		local req = {
			account = SDKMgr:GetUUID(),
		    token = SDKMgr:GetToken(),
			platform = UnityEngine.Application.platform:ToInt(),
			platformSubid = SDKMgr:getPlatformSubid(),
			device = NativeInfoLua.GetDeviceID(),
			deviceInfo = NativeInfoLua.GetDeviceDetail(),
			loginType = SDKMgr:getLoginType(),
			channel = UpdateManager.Instance.Code5,
			distinct_id = SDKMgr:getDistinctId(),
		}
		
		self:SendWaitMessage("login.LoginAuthReq", req, function (data)
			LuaLogger.ds("login.LoginAuthReq req", tablex.dump(req))
			LuaLogger.ds("login.LoginAuthReq back", tablex.dump(data))
			if data then
				if data.ret == 0 then
					callBack(true, data.phone)
				else
					callBack(data)
					self.loginFlow = false
				end
			else
				callBack(false)
				self.loginFlow = false
			end
		end)
	end

	local function verifySecret()
		local hmac = crypt.hmac64(challenge, self.secret)
		local req = {hmac = hmac}
		self:SendWaitMessage("login.VerifySecretReq", req, function (data)
			if data then
				LuaLogger.ds("login.VerifySecretReq back", tablex.dump(data))
				if data.ret == 0 then
					loginAuth()
				else
					self.loginFlow = false
					callBack(false)
				end
			else
				self.loginFlow = false
				callBack(false)
			end
		end)
	end

	local function requestKey()
		local clientkey = crypt.randomkey()
		local keyReq = {key = crypt.dhexchange(clientkey)}
		self:SendWaitMessage("login.KeyReq", keyReq, function (data)
			if data then
				self.secret = crypt.dhsecret((data.key), clientkey)
				--print("sceret is ", crypt.hexencode(self.secret))
				verifySecret()
			else
				self.loginFlow = false
				callBack(false)
			end
		end)
	end

	local function requestChallenge()
		local challengeReq = {}
		self:SendWaitMessage("login.ChallengeReq", challengeReq, function (data)
			if data then
				challenge = data.challenge
		        -- print("challenge", challenge)
		        requestKey()
			else
				self.loginFlow = false
				callBack(false)
			end
	    end)
	end

	local function connect()
		self:LuaConnect(host, port, function(success)
			self.retrying = false
			if success == true then
				self.loginFlow = true
				self.tryReconTimes = 0
				requestChallenge()
			else
				self:tryReconnect()
			end
		end)
	end

	connect()

end

function LoginNetManager:reqZoneList(callBack)
	local req = {}
	self:SendWaitMessage("login.ZoneListReq", req, function (data)
		if data then
			local zones = data.zones
	        print("zones", DLuaUtil.SerialiseProto(zones))
	        callBack(zones)
		else
			callBack(nil)
		end
    end)
end

function LoginNetManager:LoginZone(zoneId, callBack)

    self.loginingZone = true
	local oCallback = callBack
	callBack = function (success, ret)
	    self.loginingZone = false
		oCallback(success, ret)
	end

    local function reqLoginZone()
    	local req = { id = zoneId}
		self:SendWaitMessage("login.LoginZoneReq", req, function (data)
			if data then
				LuaLogger.ds("reqLoginZone ret", data.ret)
				--返回码处理
				if data.ret == 0 then
					data.secret = self.secret
					data.zoneId = zoneId
					LuaLogger.ds("ConnectGateFlow")
					LoginNetHandler = nil
					GameNetHandler:ConnectGateFlow(data, callBack)
				else
					callBack(false, data.ret)
				end
			else
				callBack(false)
			end
	    end)
    end

    reqLoginZone()
end

function LoginNetManager:LoginZoneFlow(zone)
	LuaLogger.ds("LoginNetManager.Netstate", self.Netstate)
	self:LoginZone(zone.id, function(success, ret)
		LuaLogger.ds("LoginNetManager.LoginZone", success)
        if success then
            SDKMgr:setLastLoginZone(zone)
			GameNetHandler:SendWaitMessage("user.CanEnterGameReq", {versionCode = GlobalInfo.VersionStr}, function (data)
				LuaLogger.ds("user.CanEnterGameResp ret", tablex.dump(data))
				if data.enterCode == GE.EnterGameCode.CanEnter then
					--TODO: 这里进入状态但不创建UI
					StateMgr:ChangeToState(GameFlowState.SelectUserState)
				elseif data.enterCode == GE.EnterGameCode.GameVersionNeedUpdate then
					UICommonUtils.GameVersionNeedUpdate()
				else
					GlobalInfo.None18EnterGameFailed = true
					-- if data.enterCode == GE.EnterGameCode.CantEnterOvertime18 then -- 超过当日游戏时长上限
					-- 	local AddictionPrevention = require "AddictionPrevention"
					-- 	UICommonUtils.PopOkBox(LocalStrEnum.FangChenMiPromptTitle, string.format(LocalStrEnum.None18OnlineOvertimeHour, tostring(AddictionPrevention.MaxHoursToday())))
					-- elseif data.enterCode == GE.EnterGameCode.CantEnterBetween228 then -- 未成年人在22:00-8:00之间无法登录
					-- 	UICommonUtils.PopOkBox(LocalStrEnum.FangChenMiPromptTitle, LocalStrEnum.None18Forbidden228)
					-- elseif data.enterCode == GE.EnterGameCode.CanOnlyEnterByNewPolicy1 then -- 未满18只能在周五、周六、周日和法定节假日每日的20时至21时游戏
					-- 	UICommonUtils.PopOkBox(LocalStrEnum.FangChenMiPromptTitle, LocalStrEnum.None18NewPolicy1)
					-- end
					
					-- local temp = {
					-- 	title = LocalStrEnum.FangChenMiTongZhiTitle,
					-- 	content = LocalStrEnum.None18Tip,
					-- }
					-- UIMgr:popUI("NoticeMsgPanel", temp)
					UIMgr:popUICover("Adult")
				end
			end)
		else
			if ret then
				UICommonUtils.PopOkBox(LocalStrEnum.PromptTitle, Config.LoginFailedStr[ret])
			else
				UICommonUtils.PopOkBox(LocalStrEnum.PromptTitle, LocalStrEnum.LoginFailedText)
			end
        end
    end)
end

-- 连接登录服务器失败后的尝试
function LoginNetManager:tryReconnect()
	if self.retrying then
		return
	end
	
	if self.tryReconTimes >= _loginRetryTimes then
		self.doLoginCallback(false)
		return
	end

	self:Reset()
	LuaLogger.ds("LoginNetManger continue trying reconnect")
	self.tryReconTimes = self.tryReconTimes + 1
	self:doLogin(self.doLoginCallback, true)
end

function LoginNetManager:DisconnectHandle()
	self.super.DisconnectHandle(self)
	
	LuaLogger.ds("LoginNetHandler on disconnect in lua", GameFlowFSM:getCurrentStateId())
	--LuaLogger.ds(self.Netstate, self.Netstate == NetHandler2.NetState2.Disconnected)
	-- 在选服之前的流程过长会被服务端断开链接
	--if GameFlowFSM:getCurrentStateId() == GameFlowState.LoginState and self.loginingZone == false then
	--	if self.loginFlow then -- 已经连接成功，但中途并非因为验证失败而断开
	--		-- 上次断开的回调可能是在连接成功之后调过来的，所以要判断目前是不是连接状态
	--		if self.Netstate ~= NetHandler2.NetState2.Connected then
	--			StateMgr:ChangeToState(GameFlowState.LoginState)
	--			self.loginFlow = false
	--		end
	--	end
	--end
end

return LoginNetManager