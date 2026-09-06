-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/antiaddiction/controller/AntiAddictionController.lua

module("logic.extensions.antiaddiction.controller.AntiAddictionController", package.seeall)

local AntiAddictionController = class("AntiAddictionController", BaseController)

AntiAddictionController.PassErrorForOutside = false
AntiAddictionController.PassErrorForInside = false
AntiAddictionController.UseInsideTip = false

local RealNameResultState = {
	InAuthentication = 1,
	Fail = 2,
	Success = 0
}

function AntiAddictionController:ctor()
	return
end

function AntiAddictionController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GlobalNotify.SceneLoaded, self._onSceneLoadedFinish, self, NotifyPriority.Low)
end

function AntiAddictionController:_onSceneLoadedFinish(sceneType, sceneId)
	self.curRcdSceneType = sceneType

	self:tryShowAnti()
end

function AntiAddictionController:tryShowAnti()
	if self.curRcdSceneType == SceneType.City and self.linkUrl then
		UnityWebBridge.openWebView(self.linkUrl, false)

		self.linkUrl = nil
	end
end

function AntiAddictionController:onReset()
	self.checkTimeList = nil
	self.todayOnlineTimeSec = 0
	self.totalOnlineTimeSec = 0
	self.platformId = 0
	self.userType = 0
	self.realNameStatus = 0
	self.speakLimit = 0
	self.onlineLimit = 0
	self.onlineLimitTime = nil
	self.onlineLimitMinute = 0
	self._useNppaRealName = 0
	self._realNameResult = 0
	self.isPopupUpgrade = false
	self.isRealNameing = false
	self.linkUrl = nil
	self.rcdTime = 0

	removetimer(self.onMinCheck, self)
	removetimer(self.sendGetRoleInfo, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDay, self.onNewDay, self)
	ClockMgr.instance:addListener(ClockMgr.TickDay, self.onNewDay, self)
	GameUtil.resetTimeMap()
end

function AntiAddictionController:onNewDay()
	self:sendGetRoleInfo(self._callBack, self._callBackTarget)
	GameUtil.resetTimeMap()
end

function AntiAddictionController:gotoGuestUpgradeAccount(cancelCallback)
	self.isPopupUpgrade = true

	SDKManager.unregisterGuestUpgradeListener()
	SDKManager.registerGuestUpgradeListener(function(statusCode, statusDesc)
		SDKManager.unregisterGuestUpgradeListener()

		self.isPopupUpgrade = false

		if statusCode == SDKManager.STATUS_GUEST_UPGRADE_SUCCESS then
			RoleAgent.instance:sendExitGameReq()
		elseif statusCode == SDKManager.STATUS_GUEST_UPGRADE_CANCEL then
			GameUtil.callBack(cancelCallback)
		else
			GameUtil.callBack(cancelCallback)
			TipsFacade.instance:openTipWindowNoX("错误", "网络不稳定，请稍后再试。")
		end
	end)
	print(">>>>>>>>>>>> 风控  gotoGuestUpgradeAccount 升级账号 ")
	SDKManager.gotoGuestUpgradeAccount()
end

function AntiAddictionController:gotoRealNameAuth()
	self.isRealNameing = true

	SDKManager.unregisterRealNameAuthListener()
	SDKManager.registerRealNameAuthListener(function(statusCode, statusDesc)
		SDKManager.unregisterRealNameAuthListener()

		self.isRealNameing = false

		if statusCode == SDKManager.STATUS_REAL_NAME_AUTH_SUCCESS then
			RoleAgent.instance:sendExitGameReq()
		elseif statusCode == SDKManager.STATUS_REAL_NAME_AUTH_CANCEL then
			-- block empty
		else
			TipsFacade.instance:openTipWindowNoX("错误", "网络不稳定，请稍后再试。")
		end
	end)
	print(">>>>>>>>>>>> 风控  gotoRealNameAuth 去实名 ")
	SDKManager.gotoRealNameAuth()
end

function AntiAddictionController:checkCanSpeak()
	return self.speakLimit == 0
end

function AntiAddictionController:sendGetRoleInfo(callBack, callBackTarget)
	print("防沉迷 sendGetRoleInfo platformId:", checknumber(LoginModel.instance.platformId))

	if not Framework.OSDef.isEditor and checknumber(LoginModel.instance.platformId) >= 0 then
		print("防沉迷Agent sendGetRoleInfo")
		removetimer(self.onMinCheck, self)
		removetimer(self.sendGetRoleInfo, self)

		self._callBack = callBack
		self._callBackTarget = callBackTarget

		AntiAddictionAgent.instance:sendLoadReadNameInfoReq(self.onLoadInfoEnd, self, self.onLoadInfoErr)
	elseif callBack ~= nil then
		callBack(callBackTarget)
	end
end

function AntiAddictionController:onLoadInfoErr(msg, status)
	print(">>>> 防沉迷Agent 获取错误码：", status)

	local _outsideErrorTip = "本次登录,你的实名制信息获取失败。如对你的游戏体验产生影响，请联系客服修复。"

	if status and status == -32001 then
		if not ("3_" .. msg.thirdPartyServiceResultCode) then
			if not status then
				::label_13_0::

				local _errorTipCode = ""
				local _errorTip = AntiAddictionController.UseInsideTip and (status and status == -32001 and _outsideErrorTip or MsgFlowMgr.instance:getResultCodeStr(status) or "error") or _outsideErrorTip

				local function _passErrorFunc()
					if self._callBack ~= nil then
						print(">>>> 错误 还是放行  后端记录 错误过")
						self._callBack(self._callBackTarget)

						self._callBack = nil
						self._callBackTarget = nil
					end
				end

				local function _errorTipWindow()
					FloatWordMgr.instance:show(_errorTip .. "(" .. _errorTipCode .. ")")
					_passErrorFunc()
				end

				if AntiAddictionController.PassErrorForInside then
					if AntiAddictionController.PassErrorForOutside then
						_passErrorFunc()
					elseif status and status == -32001 then
						_errorTipWindow()
					else
						_passErrorFunc()
					end
				elseif AntiAddictionController.PassErrorForOutside then
					_passErrorFunc()
				else
					_errorTipWindow()
				end
			end
		end
	end
end

function AntiAddictionController:onLoadInfoEnd(msg)
	print("防沉迷Agent onLoadInfoEnd")
	removetimer(self.onMinCheck, self)
	removetimer(self.sendGetRoleInfo, self)

	self.rcdTime = ServerTime.now()

	local var_16_0

	if msg then
		::label_16_0::

		var_16_0 = msg.summaryInfo and msg.summaryInfo.todayOnlineTimeSec
	end

	self.todayOnlineTimeSec = var_16_0

	local var_16_1

	if msg then
		::label_16_1::

		var_16_1 = msg.summaryInfo and msg.summaryInfo.totalOnlineTimeSec
	end

	self.totalOnlineTimeSec = var_16_1

	if msg.summaryInfo.realNameInfo then
		local var_16_2

		if msg then
			::label_16_2::

			var_16_2 = msg.summaryInfo and msg.summaryInfo.realNameInfo
		end

		local tb = GameUtil.jsonToTable(var_16_2)

		if tb then
			if msg and msg.summaryInfo then
				forcePrint(">>>realNameInfo:\n" .. msg.summaryInfo.realNameInfo)
			end

			if tb.data then
				local data = tb.data

				self.platformId = data.platformId
				self.userType = data.userType
				self._useNppaRealName = checknumber(data.useNppaRealName)
				self._realNameResult = checknumber(data.realNameResult)
				self.realNameStatus = self._useNppaRealName == 0 and 1 or (self._realNameResult == RealNameResultState.Success or self._realNameResult == RealNameResultState.InAuthentication) and 1 or 0
				self.speakLimit = data.speakLimit
				self.onlineLimit = data.onlineLimit
				self.onlineLimitTime = data.onlineLimitTime
				self.onlineLimitMinute = data.onlineLimitMinute
				self.todayOnlineTimeSec = math.max(checknumber(data.playerDuration) * 60, self.todayOnlineTimeSec)
				self.totalOnlineTimeSec = math.max(self.totalOnlineTimeSec, self.todayOnlineTimeSec)
			elseif self._callBack ~= nil then
				print(">>>> 错误 还是放行  后端记录 错误过 tb.data 是个空的   结构不正确没有")
				self._callBack(self._callBackTarget)

				self._callBack = nil
				self._callBackTarget = nil
			end
		end

		if self:checkNeedQuit() then
			printInfo("====您已被纳入防沉迷，去做作业吧========")
		else
			printInfo("======您未被纳入防沉迷，可以畅快玩游戏====")

			if self._callBack ~= nil then
				self._callBack(self._callBackTarget)

				self._callBack = nil
				self._callBackTarget = nil
			end

			settimer(10, self.onMinCheck, self)
		end

		GlobalDispatcher:dispatch(GlobalNotify.FENGKONG_GET_INFO, self)
	elseif self._callBack ~= nil then
		print(">>>> 错误 还是放行  后端记录 错误过  msg.summaryInfo.realNameInfo 没有")
		self._callBack(self._callBackTarget)

		self._callBack = nil
		self._callBackTarget = nil
	end
end

function AntiAddictionController:onMinCheck()
	if self:checkNeedQuit() then
		-- block empty
	elseif self.userType == 0 then
		-- block empty
	elseif self.realNameStatus == 0 then
		-- block empty
	end
end

function AntiAddictionController:checkHasRealNameByTips()
	if not Framework.OSDef.isEditor then
		local str = ""

		if self.speakLimit == 1 then
			if self.userType == 0 then
				str = "根据《关于进一步严格管理切实防止未成年人沉迷网络游戏的通知》，您需要完成账号绑定，并进行实名认证，才可以进行聊天发言"

				TipsFacade.instance:openPopupWindow("需要实名认证", "根据《关于进一步严格管理切实防止未成年人沉迷网络游戏的通知》，您需要完成账号绑定，并进行实名认证，才可以进行聊天发言", function()
					self:gotoGuestUpgradeAccount()
				end, function()
					print(">>>>>>>>> 取消 gotoGuestUpgradeAccount")
				end, "绑定账号", "返回")
			elseif self.realNameStatus == 0 then
				TipsFacade.instance:openPopupWindow("需要实名认证", "根据《关于进一步严格管理切实防止未成年人沉迷网络游戏的通知》，您需要完成实名认证，才可以进行聊天发言", function()
					self:gotoRealNameAuth()
				end, function()
					print(">>>>>>>>> 取消 gotoRealNameAuth")
				end, "绑定账号", "返回")
			elseif self:_getGovAuthStatus() == RealNameResultState.Success then
				return true
			elseif self:_getGovAuthStatus() == RealNameResultState.InAuthentication then
				FloatWordMgr.instance:show("正在实名认证中")

				return false
			else
				return false
			end

			return false
		else
			return true
		end
	else
		return true
	end
end

function AntiAddictionController:popupTimeSlotLimit()
	local timeFunc
	local str = ""

	str = "根据您的账号信息，您已被识别为未成年人。\n根据《关于进一步严格管理切实防止未成年人沉迷网络游戏的通知》，18岁以下未成年人只可以在周五、周六、周日和法定节假日的20时至21时体验游戏。请您在指定的时间回来体验游戏吧。"

	if self.userType == 0 then
		-- block empty
	elseif self.realNameStatus == 0 then
		-- block empty
	else
		str = "根据您的账号信息，您已被识别为未成年人。\n根据《关于进一步严格管理切实防止未成年人沉迷网络游戏的通知》，18岁以下未成年人只可以在周五、周六、周日和法定节假日的20时至21时体验游戏。请您在指定的时间回来体验游戏吧。"
	end

	SurveyController.instance:sendBehaviorRightNow(200472)

	local p = TipsFacade.instance:openTipWindowNoXExt("提示", str, function()
		RoleAgent.instance:sendExitGameReq()
	end, "明天再来")
end

function AntiAddictionController:popupTimeOver()
	local timeCount = 10
	local p
	local str = ""

	if self.userType == 0 then
		timeCount = 30
		str = "根据《关于进一步严格管理切实防止未成年人沉迷网络游戏的通知》，18岁以下未成年人只可以在周五、周六、周日和法定节假日的20时至21时体验游戏"

		SurveyController.instance:sendBehaviorRightNow(200472)

		p = TipsFacade.instance:openPopupWindow("需要绑定账号", str, function()
			self:gotoGuestUpgradeAccount(function()
				TipsFacade.instance:openTipWindowNoXExt("提示", "尊敬的用户，由于您账号没有进行升级将暂时退出游戏。", function()
					BootstrapLauncher.instance:applicationQuit()
				end)
			end)
		end, function()
			RoleAgent.instance:sendExitGameReq()
		end, "绑定账号")
	elseif self.realNameStatus == 0 then
		str = "根据您的账号信息，您已被识别为未成年人。\n根据《关于进一步严格管理切实防止未成年人沉迷网络游戏的通知》，18岁以下未成年人只可以在周五、周六、周日和法定节假日的20时至21时体验游戏。请您在指定的时间回来体验游戏吧。"

		SurveyController.instance:sendBehaviorRightNow(200472)

		p = TipsFacade.instance:openTipWindowNoXExt("提示", str, function()
			RoleAgent.instance:sendExitGameReq()
		end, "明天再来")
	else
		str = "根据您的账号信息，您已被识别为未成年人。\n根据《关于进一步严格管理切实防止未成年人沉迷网络游戏的通知》，18岁以下未成年人只可以在周五、周六、周日和法定节假日的20时至21时体验游戏。请您在指定的时间回来体验游戏吧。"

		SurveyController.instance:sendBehaviorRightNow(200472)

		p = TipsFacade.instance:openTipWindowNoXExt("提示", str, function()
			RoleAgent.instance:sendExitGameReq()
		end, "明天再来")
	end
end

function AntiAddictionController:gotoUpgradeAccount()
	if self.userType == 0 then
		TipsFacade.instance:openPopupWindow("需要绑定账号", "需要先绑定账号，才可以继续进行实名认证", function()
			self:gotoGuestUpgradeAccount()
		end, function()
			return
		end, "绑定账号", "返回")
	elseif self.realNameStatus == 0 then
		self:gotoRealNameAuth()
	elseif self.realNameStatus == 1 then
		if self:_getGovAuthStatus() == RealNameResultState.Success then
			FloatWordMgr.instance:show(lang("您已在本游戏实名"))
		elseif self:_getGovAuthStatus() == RealNameResultState.InAuthentication then
			FloatWordMgr.instance:show("正在实名认证中")
		else
			FloatWordMgr.instance:show("实名认证失败")
		end
	end
end

function AntiAddictionController:checkNeedUpgrade()
	if self.userType == 0 then
		-- block empty
	elseif self.realNameStatus == 0 then
		-- block empty
	elseif self.realNameStatus == 1 then
		if self:_getGovAuthStatus() == RealNameResultState.Success then
			return false
		elseif self:_getGovAuthStatus() == RealNameResultState.InAuthentication then
			-- block empty
		end
	end

	return true
end

function AntiAddictionController:getMyAntiType()
	if self.userType == 0 then
		return 1
	elseif self.realNameStatus == 0 then
		return 2
	elseif self.realNameStatus == 1 then
		if self:_getGovAuthStatus() == RealNameResultState.Success then
			return 3
		elseif self:_getGovAuthStatus() == RealNameResultState.InAuthentication then
			return 4
		else
			return 2
		end
	else
		return 3
	end
end

function AntiAddictionController:checkNeedQuit()
	if self.isPopupUpgrade == true or self.isRealNameing == true then
		return true
	end

	if self:_getGovAuthStatus() == RealNameResultState.InAuthentication then
		local str = "根据您的账号信息，您已被识别为未成年人。\n根据《关于进一步严格管理切实防止未成年人沉迷网络游戏的通知》，18岁以下未成年人只可以在周五、周六、周日和法定节假日的20时至21时体验游戏。请您在指定的时间回来体验游戏吧。"

		SurveyController.instance:sendBehaviorRightNow(200472)
		TipsFacade.instance:openTipWindowNoXExt("提示", str, function()
			RoleAgent.instance:sendExitGameReq()
		end, "明天再来")

		return true
	end

	if self:checkTimeSlotLimit() then
		self:popupTimeSlotLimit()

		return true
	end

	if self:checkTimeOver() then
		self:popupTimeOver()

		return true
	end

	return false
end

function AntiAddictionController:checkTimeSlotLimit()
	if self.userType ~= 0 and self.realNameStatus == 1 and self.onlineLimit == 1 and self.onlineLimitMinute > 0 and self.onlineLimitTime ~= nil then
		local times = string.split(self.onlineLimitTime, "-")

		if #times == 2 then
			local nowTime = ServerTime.now()
			local timeStart = self:string2time(nowTime, times[1])
			local timeEnd = self:string2time(nowTime, times[2])

			if timeEnd < timeStart then
				local todayTime = self:string2time(nowTime)
				local tomorrowTime = todayTime + 86400

				if todayTime < nowTime and nowTime < timeEnd or timeStart < nowTime and nowTime < tomorrowTime then
					return true
				end
			elseif timeStart < nowTime and nowTime < timeEnd then
				return true
			end
		end
	end

	return false
end

function AntiAddictionController:string2time(nowTime, timeString)
	timeString = timeString or ""

	local timetable = os.date("*t", nowTime)
	local fun = string.gmatch(timeString, "%d+")
	local y = timetable.year
	local m = timetable.month
	local d = timetable.day
	local H = fun() or 0
	local M = fun() or 0
	local S = fun() or 0

	return os.time({
		year = y,
		month = m,
		day = d,
		hour = H,
		min = M,
		sec = S
	})
end

function AntiAddictionController:checkTimeOver()
	if self.userType == 0 then
		if self.onlineLimitMinute > 0 then
			local limit = self.onlineLimitMinute * 60
			local total = self.totalOnlineTimeSec + (ServerTime.now() - self.rcdTime)

			if limit <= total then
				return true
			end
		end
	elseif self.realNameStatus == 1 and self.onlineLimit == 1 and self.onlineLimit == 1 and self.onlineLimitMinute > 0 then
		local limit = self.onlineLimitMinute * 60
		local total = self.todayOnlineTimeSec + (ServerTime.now() - self.rcdTime)

		if limit <= total then
			return true
		end
	end

	return false
end

function AntiAddictionController:_getGovAuthStatus()
	return self._realNameResult
end

AntiAddictionController.instance = AntiAddictionController.New()

return AntiAddictionController
