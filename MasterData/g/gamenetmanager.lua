---@class GameNetManager: NetManager2
local GameNetManager = class("GameNetManager",  require "NetManager2")
local crypt = require "crypt"

-- 一次重试的网络连接重连次数
local retryTimes = 1
-- 最大弹窗次数（可配置），达到此次数后直接跳转到登录界面
local maxReconnectPopupTimes = 3

function GameNetManager:ctor(name)
	--self.super:ctor(name)

    self.index = 0
    self.tryReconTimes = 0
    self.conData = nil
    self.canTry = true
    self.retrying = false
    -- 重连弹窗次数计数器
    self.reconnectPopupTimes = 0
end

---登录失败
function GameNetManager:FailInLoginGateFlow()
	self:ClearLoader()
	self.canTry = false
	UICommonUtils.PopOkBox(LocalStrEnum.PromptTitle, LocalStrEnum.UI_NeedLoginAgain, function () -- 这里在UICommonUtils里已经弹出过提示了
		CoveManager.instance():SetHomelandShowOrHide(false)
		UIMgr.ClearGameRTToBlack()
		StateMgr:ChangeToState(GameFlowState.LoginState)
	end)
end


function GameNetManager:ConnectGateFlow(data, callBack)
	self.conData = data
	self.index = self.index + 1

	local aid = data.aid
	local subid = data.subid
	local ip = data.ip
	local port = data.port
	local secret = data.secret
	local zoneId = data.zoneId
	local index = self.index

    self.canTry = true
	local function checkLoginGate()
		local handshake = string.format("%d@%d#%d:%d", aid, zoneId, subid, index)
		LuaLogger.ds("handshake", handshake)
		local hmac = ""
		if UnityEngine.Application.platform ~= UnityEngine.RuntimePlatform.WebGLPlayer then
			hmac = crypt.hmac64(crypt.hashkey(handshake), secret)
		else
			hmac = handshake
		end
		local req = { aid = aid, subid = subid, zone_id = zoneId, index = index, hmac = hmac, recon = self.retrying}
		self:SendWaitMessage("user.LoginGateReq", req, function (data)
			LuaLogger.ds("checkLoginGate ret", tablex.dump(data))
			if data then
				if data.ret ~= 0 then
					--self.canTry = false
					--UICommonUtils.PopOkBox("提示", "需要重新登录", function () -- 这里在UICommonUtils里已经弹出过提示了
					--	StateMgr:ChangeToState(GameFlowState.LoginState)
					--end)
				end
				callBack(data.ret == 0)
			else
				callBack(false)
			end
	    end)
	end

	local function connectGamerServer()
		print("ip", ip, "port", port)

		--if TestSendTimeReq then
		--	TestSendTimeReq = false
		--	local sec = EngineUtil.ServerTime_Seconds()
		--	local msec = EngineUtil.ServerTime()
		--	self:SendMessage("user.TimeReq",{sec = sec, msec = msec},function(data)
		--		if data.msec then
		--			EngineGlobal.SetServerTime(data.msec)
		--			Me.servertime = EngineUtil.ServerTime_Seconds()
		--		else
		--			LuaLogger.ws("data.msec is nil, maybe waiting to reconnect")
		--		end
		--	end)
		--end
		
		self:LuaConnect(ip, port, function(success)
			if success == true then
				checkLoginGate()
			else
				callBack(false)
			end
		end)
	end
	
	connectGamerServer()
end

---尝试重新连接
function GameNetManager:tryReconnect()
	LuaLogger.ds("GameNetManager:tryReconnect()")
	self:CacheMessageExcept({"user.LoginGateReq"})
	self:Reset()
	local needResendSessionIds = self:CollectNeedResendSessionIds()
	self:ConnectGateFlow(self.conData, function (success)
		LuaLogger.ds("ConnectGateFlow back", success)
		if not self.canTry then
			LuaLogger.ds("tryReconnect can't try")
			return
		end

		if success then
			self:StopCacheMessage()
			self.tryReconTimes = 0
			self.retrying = false
			-- 重连成功时重置弹窗计数器
			self.reconnectPopupTimes = 0
			LuaLogger.ds("self.retrying = false")

			if Me then
				Me:enterScene(true, function (data)
					GameMsgMgr:sendEvent(GameMsgType.GameReconnected)
					self:ReSendMessage(needResendSessionIds)
				end)
			end
		else
			-- GameMsgMgr:sendEvent(GameMsgType.TryReConnectFailed)
			self.tryReconTimes = self.tryReconTimes + 1
			LuaLogger.ds("self.tryReconTimes", self.tryReconTimes)
			if self.tryReconTimes >= retryTimes then
				self:ClearLoader()
				-- 检查是否已达到最大弹窗次数
				if self.reconnectPopupTimes >= maxReconnectPopupTimes then
					LuaLogger.ds("达到最大弹窗次数", maxReconnectPopupTimes, "，直接跳转到登录界面")
					self.reconnectPopupTimes = 0
					self.tryReconTimes = 0
					self.retrying = false
					self.canTry = false
					CoveManager.instance():SetHomelandShowOrHide(false)
					UIMgr.ClearGameRTToBlack()
					UIMgr:clearAllUI()
					StateMgr:ChangeToState(GameFlowState.LoginState)
				else
					-- 未达到最大次数，弹出弹窗
					self.reconnectPopupTimes = self.reconnectPopupTimes + 1
					LuaLogger.ds("重连失败，弹出弹窗", self.reconnectPopupTimes, "/", maxReconnectPopupTimes)
					UICommonUtils.PopOkBox(LocalStrEnum.PromptTitle, LocalStrEnum.UI_NetWorkError_TryAgainStr, function ()
						-- self.retrying = false
				        self.tryReconTimes = 0
				        self:tryReconnect()
				    end)
				end
			else
				self:tryReconnect()
			end
		end
	end)
end

---连接
---@param ip string 服务器IP
---@param port number 服务器端口
---@param action function 连接回调
function GameNetManager:LuaConnect(ip, port, action)
	self:startCheckTimer()
	self.super.LuaConnect(self, ip, port, action)

end

function GameNetManager:LuaDisconnect()
	self.actDisconnect = true	-- 主动断开
	-- 主动断开时重置弹窗计数器
	self.reconnectPopupTimes = 0
	self:Disconnect()
end

function GameNetManager:DisconnectHandle()
	self.super.DisconnectHandle(self)
	
	--LuaLogger.ds(self.Netstate, self.Netstate == NetHandler2.NetState2.Disconnected)
	LuaLogger.ds("GameNetManager:DisconnectHandle()", GlobalInfo.None18EnterGameFailed, self.IsKicked, self.actDisconnect,
			self.retrying, self.canTry, self.tryReconTimes)

	GameMsgMgr:sendEvent(GameMsgType.GameDisconnected)

	--if TestSendTimeReq then
	--	TestSendTimeReq = false
	--	local sec = EngineUtil.ServerTime_Seconds()
	--	local msec = EngineUtil.ServerTime()
	--	self:SendMessage("user.TimeReq",{sec = sec, msec = msec},function(data)
	--		if data.msec then
	--			EngineGlobal.SetServerTime(data.msec)
	--			Me.servertime = EngineUtil.ServerTime_Seconds()
	--		else
	--			LuaLogger.ws("data.msec is nil, maybe waiting to reconnect")
	--		end
	--	end)
	--end
	
	if GlobalInfo.None18EnterGameFailed then
		--GlobalInfo.None18EnterGameFailed = nil
		return
	end
	
	if self.IsKicked then -- 如果是被踢下线的，就不自动重连了
		self.IsKicked = false
		-- 被踢下线时重置弹窗计数器
		self.reconnectPopupTimes = 0
		return
	end

	if self.actDisconnect then
		self.actDisconnect = nil
		-- 主动断开时重置弹窗计数器（虽然LuaDisconnect中已经重置，这里再确保一下）
		self.reconnectPopupTimes = 0
		return
	end

	if self.retrying or not self.canTry or self.tryReconTimes >= retryTimes then --  or GV.MainDestroyed
		return
	end

	LuaLogger.ds("start try Reconnect")
	self.retrying = true
	self:tryReconnect()
end

function GameNetManager:ErrorHandle(errorCode, sessionId)
	LuaLogger.ws("GameNetManager:ErrorHandle", errorCode, sessionId)
	if sessionId then
		-- 目前是ServerException
		if tostring(errorCode) == "ServerException" then
			if UnityEngine.Application.platform == UnityEngine.RuntimePlatform.WindowsEditor then
				self:ClearSessionData(sessionId)
			else
				self:ClearLoader()
				self.canTry = false
				UICommonUtils.PopOkBox(LocalStrEnum.PromptTitle, "数据出错，需要重新登录。", function ()
					StateMgr:ChangeToState(GameFlowState.LoginState)
				end)
			end
		end
	end
end

return GameNetManager