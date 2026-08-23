local ShowFactory = require("app.view.module.show.ShowFactory")
local ShowPopService = class("ShowPopService")
local UpgradeSilent = require("upgrade.UpgradeSilent")

function ShowPopService:ctor()
	self._popFuncList = {}
	self._responseMsg = {}
	self._waitFlag = false
	self._waitShow = false
	self._feedbackWait = false
	self._lockState = false

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_REQUEST_START, self._onNetRequestStart, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_REQUEST_CANCEL, self._onNetRequestCancel, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_REQUEST_RESPONSE, self._onNetRequestResponse, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_DISCONNECTED, self._onNetDisconnected, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_TIMEOUT, self._onNetTimeout, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_ADD_POP_SHOW, self._onAddPop, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_ADD_CHECK_SHOW, self._onShowCheck, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_ADD_CHECK_SHOW_WAIT, self._onShowFeedBackWait, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_ADD_CHECK_SHOW_READY, self._onShowFeedBackReady, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_LOCK_FEEDBACK_POP, self._onLockFeedBackPop, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_UNLOCK_FEEDBACK_POP, self._onUnlockFeedBackPop, self)
end

function ShowPopService:_onShowFeedBackWait()
	self._feedbackWait = true
end

function ShowPopService:_onShowFeedBackReady()
	self._feedbackWait = false
end

function ShowPopService:_onAddPop(arg_4_1, arg_4_2)
	if arg_4_2.removeFlag then
		if #self._popFuncList > 0 then
			local var_4_0 = false
			local var_4_1 = {}

			for iter_4_0, iter_4_1 in ipairs(arg_4_2.removeFlag) do
				if iter_4_1 == "all" then
					var_4_0 = true

					break
				end

				var_4_1[iter_4_1] = true
			end

			if var_4_0 then
				self._popFuncList = {}
			else
				for iter_4_2 = #self._popFuncList, 1, -1 do
					if var_4_1[self._popFuncList[iter_4_2].flag] then
						table.remove(self._popFuncList, iter_4_2)
					end
				end
			end
		end
	end

	if arg_4_2.frontShow then
		for iter_4_3, iter_4_4 in ipairs(arg_4_2.frontShow) do
			table.insert(self._popFuncList, iter_4_4)
		end
	end

	if arg_4_2.award then
		for iter_4_5, iter_4_6 in ipairs((ShowFactory:pushShowQueue(arg_4_2.award))) do
			table.insert(self._popFuncList, {
				flag = "award",
				func = iter_4_6
			})
		end
	end

	if arg_4_2.afterShow then
		for iter_4_7, iter_4_8 in ipairs(arg_4_2.afterShow) do
			table.insert(self._popFuncList, iter_4_8)
		end
	end

	if arg_4_2.firstShow then
		for iter_4_9, iter_4_10 in ipairs(arg_4_2.firstShow) do
			table.insert(self._popFuncList, iter_4_9, iter_4_10)
		end
	end

	if arg_4_2.showNow and not self._waitFlag then
		if next(self._responseMsg) then
			self._waitShow = true
		else
			self:_onShowCheck()
		end
	end
end

function ShowPopService:_onShowCheck()
	if self._lockState then
		return
	end

	if not device.isWindowsDebug() and config.UPGRADE_SILENT_ENABLED and not UpgradeSilent.isFullDownload() then
		return
	end

	if next(self._responseMsg) then
		self._waitShow = true
	elseif #self._popFuncList > 0 then
		if not self._waitFlag then
			self._inWait = true

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_START)

			self._waitFlag = true
		end

		local var_5_0 = self._popFuncList[1].func()

		table.remove(self._popFuncList, 1)
		var_5_0:addEventListener(fgui.UIEventType.ExitFinish, handler(self, self._onShowQueueExit))
	else
		self._waitFlag = false

		if self._inWait then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_END)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

			self._inWait = false
		end

		if not self._feedbackWait then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHECK_FIGHT_VALUE_CHANGE)
		end
	end
end

function ShowPopService:_onShowQueueExit()
	self:_onShowCheck()
end

function ShowPopService:_onNetRequestStart(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_4 then
		self._responseMsg[arg_7_4] = self._responseMsg[arg_7_4] or 0
		self._responseMsg[arg_7_4] = self._responseMsg[arg_7_4] + 1
	end
end

function ShowPopService:_onNetRequestCancel(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_4 and self._responseMsg[arg_8_4] then
		self._responseMsg[arg_8_4] = self._responseMsg[arg_8_4] - 1

		if self._responseMsg[arg_8_4] == 0 then
			self._responseMsg[arg_8_4] = nil
		end
	end
end

function ShowPopService:_onNetRequestResponse(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_2 and self._responseMsg[arg_9_2] then
		self._responseMsg[arg_9_2] = self._responseMsg[arg_9_2] - 1

		if self._responseMsg[arg_9_2] == 0 then
			self._responseMsg[arg_9_2] = nil
		end
	end

	if next(self._responseMsg) then
		return
	end

	if not self._waitFlag then
		self:_onShowCheck()
	end
end

function ShowPopService:_onLockFeedBackPop()
	self._lockState = true
end

function ShowPopService:_onUnlockFeedBackPop()
	self._lockState = false

	self:_onShowCheck()
end

function ShowPopService:_onNetDisconnected()
	self._responseMsg = {}
end

function ShowPopService:_onNetTimeout()
	self._responseMsg = {}
end

return ShowPopService
