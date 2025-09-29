-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/agent/LoginAgent.lua

module("logic.extensions.login.agent.LoginAgent", package.seeall)

local LoginAgent = class("LoginAgent", BaseAgent)
local json = require("cjson")

function LoginAgent:ctor()
	LoginAgent.super.ctor(self)
end

local kGetServerList_RequestCount = 0
local kGetServerList_Url = false
local kGetServerList_Data = false
local isShowWaiting = false
local isRequestServerList = false

local function kHandleHttpGetServerListResponse(isSuccess, msg)
	isRequestServerList = false

	if isSuccess and not string.nilorempty(msg) then
		LoginAgent:_hideWaiting()

		if enableLog then
			print("handleHttpGetServerListRequest", msg)
		end

		kGetServerList_Data = false

		local msgList = json.decode(msg)
		local code = msgList.code

		if code ~= 0 then
			NewNoticeController.instance:closeNoticeView()
		end

		if code == 0 then
			local data = msgList.data

			LoginModel.instance:setNickName(data.servers[1].nickName)
			LoginModel.instance:setUserId(data.servers[1].userId)
			LoginModel.instance:setSocketPassword(data.socketPassword)
			LoginModel.instance:updateServerList(data.servers, data.lastZone)
			LoginModel.instance:setAccount(data.account)
			GlobalDispatcher:dispatchEvent(EventType.LOGIN_GET_SERVER_LIST_EVENT, true)
			LoginModel.instance:clearRetryTime()
			LoginModel.instance:syncServerTime(math.ceil(data.timestamp / 1000))
		elseif code == LoginEnum.StateCodeNeedRetryLogin then
			LoginModel.instance:addRetryTime()

			if LoginModel.instance:getRetryTime() <= LoginEnum.MaxRetryLoginTime and LoginModel.instance:getCacheParam() then
				LoginController.instance.webHandler:sendHttpGetServerListRequest(LoginModel.instance:getCacheParam())
			else
				MsgBoardController.instance:_handleResultCodeMsg(nil, nil, code)
			end
		elseif code == LoginEnum.StateCodeRegistMaxCount then
			local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang(LoginEnum.RegiterMaxCountTips))

			dialog:setConfirmButtonText(lang("tip_common_sure"))
			dialog:setConfirmListener(function()
				SystemUtil.Quit()
			end, LoginAgent)
		elseif tostring(msgList.msg) ~= "userdata: NULL" then
			if not Astral.OSDef.isEditor and Astral.GameConstParser.Instance.enableSDKLogin then
				local dialog = Dialog.showNotifyMessage(lang("tip_title"), msgList.msg)

				dialog:setConfirmButtonText(lang("tip_common_sure"))
				dialog:setConfirmListener(function()
					LoginController.instance:returnToLogin()
				end, LoginAgent)
				LoginFacade.instance:closeConfidentialityTip()

				return
			end
		else
			local itemInfo = LanguageMgr.instance:getLangRcInfo(tostring(code))

			if itemInfo then
				local dialog = Dialog.showNotifyMessage(lang("tip_title"), LanguageMgr.instance:getText(itemInfo))

				dialog:setConfirmButtonText(lang("tip_common_sure"))
				dialog:setConfirmListener(function()
					LoginController.instance:returnToLogin()
				end, LoginAgent)
			else
				MsgBoardController.instance:_handleResultCodeMsg(nil, nil, code)
			end
		end
	elseif kGetServerList_RequestCount < LoginEnum.GetServerListMaxRetryRequestCount then
		kGetServerList_RequestCount = kGetServerList_RequestCount + 1

		if not isShowWaiting then
			LoadingFacade.instance:showWaiting(nil, true)

			isShowWaiting = true
		end

		if kGetServerList_Url and kGetServerList_Data then
			LoginAgent.instance:_sendHttpGetServerListRequest(kGetServerList_Url, kGetServerList_Data)
		end
	else
		LoginAgent:_hideWaiting()

		kGetServerList_Data = false

		GlobalDispatcher:dispatchEvent(EventType.LOGIN_GET_SERVER_LIST_EVENT, false, msg)
		BootstrapGameConfigMgr._onGetServerListError()
	end
end

function LoginAgent:_hideWaiting()
	if isShowWaiting then
		LoadingFacade.instance:hideWaiting()

		isShowWaiting = false
	end
end

function LoginAgent:_sendHttpGetServerListRequest(url, data)
	if isRequestServerList then
		return
	end

	isRequestServerList = true

	if enableLog then
		print("sendHttpGetServerListRequest", url, kGetServerList_RequestCount, LoginEnum.GetServerListMaxRetryRequestCount)
	end

	Astral.NetworkManager.Instance:HttpRequestWithPost(url, data, nil, kHandleHttpGetServerListResponse, LoginEnum.ConnectLoginServerTimeout)
end

function LoginAgent:sendHttpGetServerListRequest(param)
	local url = BootstrapGameConfigMgr.getHttpLoginUrl()
	local data = TemplateCollectionUtils.CreateDictionary_StringString()

	if param then
		param.platformId = param.platformId or 0

		data:Add("platformId", param.platformId)
		data:Add("package", BootstrapUtil.getGamePackageName())
		data:Add("version", tostring(BootstrapUtil.getGameVersionCode()))

		if param.account then
			data:Add("account", param.account)
		end

		if param.sessionId then
			data:Add("sessionId", param.sessionId)
		end

		if param.debug then
			data:Add("debug", tostring(param.debug))
		end

		LoginModel.instance:setCacheParam(param)
	end

	kGetServerList_Url = url
	kGetServerList_Data = data
	kGetServerList_RequestCount = 0

	self:_sendHttpGetServerListRequest(url, data)
end

function LoginAgent:sendLoginRequest(isReconnecting)
	if enableLog then
		printInfo("send login,isReconnecting = ", tostring(isReconnecting))
	end

	local account, password = LoginModel.instance:getAccountAndSocketPassword()
	local req = {}

	req.account = account
	req.password = password
	req.connectWay = isReconnecting and 1 or 0

	NetConnMgr.instance:sendSysMsg(1, req, ConnectionType.Logic)
end

function LoginAgent:handleLoginResponse(status, msg)
	if status == 0 then
		self:sendUploadCidRequest()

		if enableLog then
			print("login success!")
		end

		LoginModel.instance:setUserId(msg.userId)
		LoginModel.instance:setReason(msg.reason)
		GlobalDispatcher:dispatchEvent(EventType.LOGIN_CONNECT_SERVER_DONE_EVENT, true)
	else
		if enableLog then
			print("login failed!", status, msg.reason)
		end

		LoginController.instance:hideLoginFailDialog()
		FloatWordMgr.instance:clear()
		LoadingFacade.instance:hideWaiting()

		local reason = json.decode(msg.reason)
		local hintCode = reason.code

		if self:_tryConnectNewHost(hintCode) then
			return
		end

		local hintMsg = reason.msg
		local dialogText = ""
		local itemInfo = LanguageMgr.instance:getLangRcInfo(tostring(hintCode))

		if hintMsg ~= nil and hintMsg ~= "" and tostring(hintMsg) ~= "userdata: NULL" then
			dialogText = hintMsg
		else
			dialogText = LanguageMgr.instance:getText(itemInfo)
		end

		LoginModel.instance:setReason(msg.reason)

		if hintCode == LoginEnum.StateCodeTimeOutLimit then
			local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang("tip_game_overtime_up_account"))

			dialog:setConfirmButtonText(lang("tip_common_sure"))
			dialog:setConfirmListener(self.confirmUpgrade, self)

			return
		end

		local dialog = Dialog.showNotifyMessage(lang("tip_login_fail"), dialogText)

		dialog:setConfirmButtonText(lang("tip_common_sure"))
		dialog:setConfirmListener(self._onLogout, self)
	end
end

function LoginAgent:_tryConnectNewHost(hintCode)
	if not LoginController.instance.reconnectHandler:hasNewHost() then
		return false
	end

	if hintCode == LoginEnum.StateCodeOutstripMaxConnect or hintCode == LoginEnum.StateCodeOutstripMaxConnect2 then
		LoginController.instance.reconnectHandler:connectNewHost()

		return true
	elseif hintCode == LoginEnum.StateCodeHasNoFinishFight then
		local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang("tip_cannot_back_to_battle"))

		dialog:setConfirmButtonText(lang("tip_common_sure"))
		dialog:setConfirmListener(self._connectNewHost, self)

		return true
	end

	return false
end

function LoginAgent:_connectNewHost()
	LoginController.instance.reconnectHandler:connectNewHost()
end

function LoginAgent:sendUploadCidRequest()
	if not SDKManager.isZhSdk() then
		return
	end

	if not string.nilorempty(NotificationMgr.getClientId()) then
		local msg = NotifyExtension_pb.UploadCidRequest()

		msg.cid = NotificationMgr.getClientId()

		self:sendMsg(msg)
	end
end

function LoginAgent:confirmUpgrade()
	if SDKManager.getSDKInstacne():isShowGuestUpgradeAccount() then
		SDKManager.getSDKInstacne():registerGuestUpgradeListener(function(statusCode, statusDesc)
			if statusCode == SDKManager.STATUS_GUEST_UPGRADE_SUCCESS then
				FloatWordMgr.instance:show(lang("tip_uplevel_login"))
			elseif statusCode == SDKManager.STATUS_GUEST_UPGRADE_CANCEL then
				printError(lang("guest upgrade tourist cancel..."))
			else
				printError(lang("guest upgrade tourist fail ...") .. statusDesc)
				FloatWordMgr.instance:show(string.format("%d:%s", statusCode, statusDesc))
			end

			self:_onLogout()
			SDKManager.getSDKInstacne():unregisterGuestUpgradeListener()
		end)
		SDKManager.getSDKInstacne():gotoGuestUpgradeAccount()
	else
		printError(lang("guest upgrade tourist not support..."))
		self:_onLogout()
	end
end

function LoginAgent:_onLogout()
	LoginController.instance:returnToLogin()
end

function LoginAgent:handleLeaveResponse(status, msg)
	if enableLog then
		print("handleLeaveResponse", status, msg.reason)
	end

	LoginModel.instance:setReason(msg.reason)
end

function LoginAgent:handleForceLogoutResponse(status, msg)
	if enableLog then
		print("handleForceLogoutResponse", status, msg.reason)
	end

	LoginController.instance.reconnectHandler:handleForceLogout()
	LoginModel.instance:setReason(msg.reason)
	GlobalDispatcher:dispatchEvent(EventType.DISCONNENT_SERVER_EVENT)

	if msg.reason == "user request" then
		LoginController.instance:hideLoginFailDialog()
		LoginController.instance:returnToLogin()
	else
		local content = status == LoginEnum.StateCodeAccountOtherLogin and lang("您的账号在其他地方登陆") or nil

		LoginController.instance:showReturnToLoginDialog(content)
	end
end

function LoginAgent:sendGetLostCmdRespRequest(downTag)
	local req = {}

	req.downTag = downTag

	NetConnMgr.instance:sendSysMsg(3, req, ConnectionType.Logic)
end

function LoginAgent:handleGetLostCmdRespResponse(status, msg)
	if enableLog then
		print("handleGetLostCmdRespResponse", msg.canGet)
	end
end

function LoginAgent:handleGetLostCmdRespResponseStartTag(status, msg)
	if enableLog then
		print("handleGetLostCmdRespResponseStartTag")
	end
end

local function kHandleHttpGetSurveyListResponse(isSuccess, msg)
	printWarn("=====kHandleHttpGetSurveyListResponse==msg=", msg)

	if isSuccess and not string.nilorempty(msg) then
		if enableLog then
			print("sendHttpGetSurveyListRequest", msg)
		end

		local msgList = json.decode(msg)
		local code = msgList.code

		if code == 0 then
			if msgList.data == json.null then
				msgList.data = nil
			end

			SurveyHtmlUtil.setSurveyData(msgList.data)
			GlobalDispatcher:dispatchEvent(EventType.GET_SURVEY_LIST_EVENT, msgList.data)
		elseif code == LoginEnum.StateCodeNetworkException then
			printWarn("=====kHandleHttpGetSurveyListResponse  userdata: NULL=检测到异常，请检查网络或重启客户端后填写==")
			SurveyHtmlUtil.setSurveyData(nil)
			GlobalDispatcher:dispatchEvent(EventType.GET_SURVEY_LIST_EVENT, nil)
		end
	else
		printWarn("=====kHandleHttpGetSurveyListResponse==failed======")
		SurveyHtmlUtil.setSurveyData(nil)
		GlobalDispatcher:dispatchEvent(EventType.GET_SURVEY_LIST_EVENT, nil)
	end
end

function LoginAgent:sendHttpGetSurveyListRequest(param)
	local url = ""
	local jsonStr = ""
	local data = TemplateCollectionUtils.CreateDictionary_StringString()

	if param then
		url = param.url
		jsonStr = param.dataWithSign

		data:Add("Content-Type", "application/json")
	end

	Astral.NetworkManager.Instance:HttpRequestWithPost(url, data, jsonStr, kHandleHttpGetSurveyListResponse, 10)
end

LoginAgent.instance = LoginAgent.New()

return LoginAgent
