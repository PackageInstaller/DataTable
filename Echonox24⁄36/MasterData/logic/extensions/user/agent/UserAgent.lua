-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/user/agent/UserAgent.lua

module("logic.extensions.user.agent.UserAgent", package.seeall)

local M = class("UserAgent", BaseAgent)

function M:sendLogoutRequest()
	local req = UserExtension_pb.LogoutRequest()

	self:sendMsg(req)
end

function M:handleLogoutReply(status, msg)
	if status == 0 then
		if enableLog then
			print("logout success!")
		end

		ChatHistoryModel.instance:saveCurrent()
	elseif enableErrorLog then
		printError("logout fail!", status)
	end
end

function M:sendGetServerTimeRequest()
	local req = UserExtension_pb.GetServerTimeRequest()

	self:sendMsg(req)
end

function M:handleGetServerTimeReply(status, msg)
	if status == 0 then
		ServerTime.init(msg.offset)
		ServerTime.sync(msg.timestamp)
	end
end

function M:_delayExecute()
	self:handleRealNameInfoPush(self._status, self._msg)
end

function M:handleRealNameInfoPush(status, msg)
	if status == 0 then
		if BattleMgr.instance:isInBattle() then
			self._status = status
			self._msg = msg

			removetimer(self._delayExecute, self)
			settimer(5, self._delayExecute, self, false)
		else
			PlayerModel.instance:updateRealNameInfo(msg)

			local result = msg.result

			if self._curShowDialog then
				return
			end

			if not msg.adult and (Astral.OSDef.RunOS == Astral.OSDef.Android or Astral.OSDef.RunOS == Astral.OSDef.IOS) and Astral.GameConstParser.Instance.enableSDKLogin then
				local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang("tip_test_not_adult"))

				dialog:setConfirmButtonText(lang("tip_common_sure"))
				dialog:setConfirmListener(self.confirmExit, self)

				self._curShowDialog = dialog

				StartGameRequestor.instance:stop()

				return
			end

			if result ~= 0 then
				if result == 135 then
					local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang("tip_game_overtime_up_account"))

					dialog:setConfirmButtonText(lang("tip_common_sure"))
					dialog:setConfirmListener(self.confirmUpgrade, self)

					self._curShowDialog = dialog

					return
				elseif result == 137 then
					if msg.userType == GameEnum.RealNameUserTypeEnum.Visitor and msg.totalOnlineMinute > msg.onlineLimitMinute then
						local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang("tip_game_overtime_up_account"))

						dialog:setConfirmButtonText(lang("tip_common_sure"))
						dialog:setConfirmListener(self.confirmUpgrade, self)

						self._curShowDialog = dialog

						return
					end

					local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang("tip_game_overtime_to_rest"))

					dialog:setConfirmButtonText(lang("tip_common_sure"))
					dialog:setConfirmListener(self.confirmExit, self)

					self._curShowDialog = dialog

					return
				elseif result == 138 then
					FloatWordMgr.instance:show(lang("tip_game_overtime"))
				end
			end

			local realNameInfo = msg

			if realNameInfo.onlineLimitTime ~= "" then
				local timeArr = string.split(realNameInfo.onlineLimitTime, "-")
				local beginArr = string.split(timeArr[1], ":")
				local beginHour = tonumber(beginArr[1])
				local beginMinute = tonumber(beginArr[2])
				local endArr = string.split(timeArr[2], ":")
				local endHour = tonumber(endArr[1])
				local endMinute = tonumber(endArr[2])
				local serverDate = ServerTime.nowDateServerLook()

				if beginHour < serverDate.hour or serverDate.hour == beginHour and beginMinute <= serverDate.min or endHour > serverDate.hour or serverDate.hour == endHour and endMinute >= serverDate.min then
					local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang("tip_time_not_game"))

					dialog:setConfirmButtonText(lang("tip_common_sure"))
					dialog:setConfirmListener(self.confirmExit, self)

					return
				end
			end

			if realNameInfo.onlineLimitMinute > 0 then
				if realNameInfo.userType == GameEnum.RealNameUserTypeEnum.Visitor then
					if msg.totalOnlineMinute > realNameInfo.onlineLimitMinute then
						local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang("tip_game_overtime_up_account"))

						dialog:setConfirmButtonText(lang("tip_common_sure"))
						dialog:setConfirmListener(self.confirmUpgrade, self)

						self._curShowDialog = true
					end
				elseif msg.dailyOnlineMinute >= realNameInfo.onlineLimitMinute then
					local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang("tip_game_overtime_to_rest"))

					dialog:setConfirmButtonText(lang("tip_common_sure"))
					dialog:setConfirmListener(self.confirmExit, self)
				elseif realNameInfo.onlineLimitMinute - msg.dailyOnlineMinute <= 30 then
					FloatWordMgr.instance:show(lang("tip_game_overtime"))
				end
			end
		end
	end
end

function M:handleRealNameNotifyPush(status, msg)
	if status == 0 then
		local type = msg.type

		if type == GameEnum.RealNameNotifyType.HINT then
			local dialog = Dialog.showNotifyMessage(msg.title, msg.msg)

			dialog:setConfirmButtonText(lang("tip_common_sure"))
		elseif type == GameEnum.RealNameNotifyType.LOGOUT then
			LoginController.instance:showReturnToLoginDialog(msg.msg, msg.title)
		elseif type == GameEnum.RealNameNotifyType.WEB then
			print("打开网页", msg.link)
			BootstrapUtil.showWebBrowser(msg.link)
		end
	end
end

function M:confirmUpgrade()
	if SDKManager.getSDKInstacne():isShowGuestUpgradeAccount() then
		SDKManager.getSDKInstacne():registerGuestUpgradeListener(function(statusCode, statusDesc)
			self._curShowDialog = nil

			if statusCode == SDKManager.STATUS_GUEST_UPGRADE_SUCCESS then
				FloatWordMgr.instance:show(lang("tip_up_account_success"))
				UserAgent.instance:sendNotifyRealNameInfoUpdateRequest()
			elseif statusCode == SDKManager.STATUS_GUEST_UPGRADE_CANCEL then
				printError(lang("guest upgrade tourist cancel..."))
				self:sendLogoutRequest()
			else
				printError(lang("guest upgrade tourist fail ...") .. statusDesc)
				FloatWordMgr.instance:show(string.format("%d:%s", statusCode, statusDesc))
			end

			SDKManager.getSDKInstacne():unregisterGuestUpgradeListener()
		end)
		SDKManager.getSDKInstacne():gotoGuestUpgradeAccount()
	else
		printError(lang("guest upgrade tourist not support..."))
	end
end

function M:confirmExit()
	self._curShowDialog = nil

	self:sendLogoutRequest()
	SystemUtil.Quit()
end

function M:sendSendDeviceInfoRequest()
	local msg = UserExtension_pb.SendDeviceInfoRequest()

	msg.infoJson = SDKManager.getSDKInstacne():getDeviceDetailJson()

	print("发送设备信息", msg.infoJson)
	self:sendMsg(msg)
end

function M:handleSendDeviceInfoReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function M:sendNotifyRealNameInfoUpdateRequest()
	local msg = UserExtension_pb.NotifyRealNameInfoUpdateRequest()

	self:sendMsg(msg)
end

function M:handleNotifyRealNameInfoUpdateReply(status, msg)
	return
end

function M:handleOnImportantInstantPush(status, msg)
	if status == 0 then
		ServerTime.init(msg.offset)
		ServerTime.sync(msg.timestamp)

		if msg.key == UserExtension_pb.ImportantInstantKey.CONFIG_UPDATE then
			GlobalDispatcher:dispatchEvent(EventType.CONFIG_UPDATE_EVENT, msg.key)
		else
			GlobalDispatcher:dispatchEvent(EventType.ON_IMPORTANT_INSTANT_PUSH, msg.key)
		end
	end
end

function M:sendUploadStatsRequest(eventId, params)
	local req = UserExtension_pb.UploadStatsRequest()

	req.eventId = tostring(eventId)
	req.params = params

	self:sendMsg(req)
end

function M:handleUploadStatsReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function M:handleServerGitVersionPush(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.GIT_COMMITID, msg.id, msg.time)
	end
end

function M:sendDevicePerformanceMetricRequest(performanceInfo)
	local req = UserExtension_pb.SendDevicePerformanceMetricRequest()

	req.logic = performanceInfo.logic
	req.deviceName = performanceInfo.deviceName
	req.cpuModel = performanceInfo.cpuModel
	req.gpuModel = performanceInfo.gpuModel
	req.memory = performanceInfo.memory
	req.realTimeFrameRate = performanceInfo.realTimeFrameRate
	req.resolution = performanceInfo.resolution
	req.effectLevel = performanceInfo.effectLevel
	req.gameFrameRate = performanceInfo.gameFrameRate
	req.hdr = performanceInfo.hdr
	req.antiAliasing = performanceInfo.antiAliasing
	req.realTimeFrameRateVar = performanceInfo.realTimeFrameVariance
	req.platform = performanceInfo.platform
	req.level = performanceInfo.level

	self:sendMsg(req)
end

function M:handleSendDevicePerformanceMetricReply(status, msg)
	return
end

M.instance = M.New()

return M
