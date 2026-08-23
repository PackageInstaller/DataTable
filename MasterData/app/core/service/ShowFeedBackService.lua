local var_0_0 = g.core.const.ConstMgr.ShowConst
local var_0_1 = g.core.event.enum
local UpgradeSilent = require("upgrade.UpgradeSilent")
local var_0_3 = g.core.event.EventManager
local ShowFeedBackService = class("ShowFeedBackService")

function ShowFeedBackService:ctor()
	self._showQueue = {}
	self._curShowingComp = nil
	self._inShowIng = false
	self._lockState = false

	var_0_3:addEventListener(var_0_1.EVENT_LOGIN_REPEAT, self._onResetShowQueue, self)
	var_0_3:addEventListener(var_0_1.EVENT_ENTER_BATTLE, self._onResetShowQueue, self)
	var_0_3:addEventListener(var_0_1.EVENT_GAME_LOGOUT_ACCOUNT, self._onResetShowQueue, self)
	var_0_3:addEventListener(var_0_1.EVENT_CUSTOM_LOGOUT, self._onResetShowQueue, self)
	var_0_3:addEventListener(var_0_1.EVENT_ADD_FEEDBACK_SHOW, self._onAddFeedbackShow, self)
	var_0_3:addEventListener(var_0_1.EVENT_CHECK_FIGHT_VALUE_CHANGE, self._onCheckFightValueChange, self)
	var_0_3:addEventListener(var_0_1.EVENT_LOCK_FEEDBACK_POP, self._onLockFeedBackPop, self)
	var_0_3:addEventListener(var_0_1.EVENT_UNLOCK_FEEDBACK_POP, self._onUnlockFeedBackPop, self)
end

function ShowFeedBackService:_onAddFeedbackShow(arg_2_1, arg_2_2)
	local ShowFactory = require("app.view.module.show.ShowFactory")

	if arg_2_2.baseShowPop then
		local var_2_1 = {
			arg_2_2.baseShowPop
		}

		table.insert(self._showQueue, {
			isFloat = true,
			func = function()
				return ShowFactory:popLayer(var_2_1, var_0_0.POPLAYER_TP.BASE_POP_UPGRADE)
			end
		})
	end

	if arg_2_2.baseShowReward then
		local var_2_2 = {}

		if #arg_2_2.baseShowReward > 0 then
			for iter_2_0 = 1, #arg_2_2.baseShowReward do
				table.insert(var_2_2, arg_2_2.baseShowReward[iter_2_0])
			end

			table.insert(self._showQueue, {
				isFloat = true,
				func = function()
					return ShowFactory:popLayer(var_2_2, var_0_0.POPLAYER_TP.BASE_POP_REWARD)
				end
			})
		end
	end

	if arg_2_2.achievement then
		table.insert(self._showQueue, {
			func = function()
				return ShowFactory:popLayer(arg_2_2.achievement, var_0_0.POPLAYER_TP.ACHIEVEMENT_REACH)
			end
		})
	end

	if arg_2_2.fightValueChange then
		local var_2_3 = arg_2_2.fightValueChange
		local var_2_4 = false

		for iter_2_1, iter_2_2 in ipairs(self._showQueue) do
			if iter_2_2.mergeType and iter_2_2.mergeType == var_0_0.POPLAYER_TP.FIGHT_VALUE_CHANGE then
				iter_2_2.mergeData.changeValue = iter_2_2.mergeData.changeValue + var_2_3
				var_2_3 = iter_2_2.mergeData.changeValue

				function iter_2_2.func()
					return ShowFactory:popLayer({
						changeValue = var_2_3
					}, var_0_0.POPLAYER_TP.FIGHT_VALUE_CHANGE)
				end

				var_2_4 = true

				break
			end
		end

		if not var_2_4 then
			table.insert(self._showQueue, {
				stillEndPos = true,
				isFloat = true,
				func = function()
					return ShowFactory:popLayer({
						changeValue = var_2_3
					}, var_0_0.POPLAYER_TP.FIGHT_VALUE_CHANGE)
				end,
				mergeData = {
					changeValue = var_2_3
				},
				mergeType = var_0_0.POPLAYER_TP.FIGHT_VALUE_CHANGE
			})
		end
	end

	if arg_2_2.outpostFightValueChange then
		local var_2_5 = arg_2_2.outpostFightValueChange
		local var_2_6 = false

		for iter_2_3, iter_2_4 in ipairs(self._showQueue) do
			if iter_2_4.mergeType and iter_2_4.mergeType == var_0_0.POPLAYER_TP.OUTPOST_FIGHT_VALUE_CHANGE then
				iter_2_4.mergeData.changeValue = iter_2_4.mergeData.changeValue + var_2_5
				var_2_5 = iter_2_4.mergeData.changeValue

				function iter_2_4.func()
					return ShowFactory:popLayer({
						changeValue = var_2_5
					}, var_0_0.POPLAYER_TP.OUTPOST_FIGHT_VALUE_CHANGE)
				end

				var_2_6 = true

				break
			end
		end

		if not var_2_6 then
			table.insert(self._showQueue, {
				stillEndPos = true,
				isFloat = true,
				func = function()
					return ShowFactory:popLayer({
						changeValue = var_2_5
					}, var_0_0.POPLAYER_TP.OUTPOST_FIGHT_VALUE_CHANGE)
				end,
				mergeData = {
					changeValue = var_2_5
				},
				mergeType = var_0_0.POPLAYER_TP.OUTPOST_FIGHT_VALUE_CHANGE
			})
		end
	end

	if arg_2_2.slgFightValueChange then
		local var_2_7 = arg_2_2.slgFightValueChange
		local var_2_8 = false

		for iter_2_5, iter_2_6 in ipairs(self._showQueue) do
			if iter_2_6.mergeType and iter_2_6.mergeType == var_0_0.POPLAYER_TP.SLG_FIGHT_VALUE_CHANGE then
				iter_2_6.mergeData.changeValue = iter_2_6.mergeData.changeValue + var_2_7
				var_2_7 = iter_2_6.mergeData.changeValue

				function iter_2_6.func()
					return ShowFactory:popLayer({
						type = 1,
						changeValue = var_2_7
					}, var_0_0.POPLAYER_TP.FIGHT_VALUE_CHANGE)
				end

				var_2_8 = true

				break
			end
		end

		if not var_2_8 then
			table.insert(self._showQueue, {
				stillEndPos = true,
				isFloat = true,
				func = function()
					return ShowFactory:popLayer({
						type = 1,
						changeValue = var_2_7
					}, var_0_0.POPLAYER_TP.FIGHT_VALUE_CHANGE)
				end,
				mergeData = {
					changeValue = var_2_7
				},
				mergeType = var_0_0.POPLAYER_TP.SLG_FIGHT_VALUE_CHANGE
			})
		end
	end

	if arg_2_2.otherFightValueChange then
		local var_2_9 = arg_2_2.otherFightValueChange
		local var_2_10 = false

		for iter_2_7, iter_2_8 in ipairs(self._showQueue) do
			if iter_2_8.mergeType and iter_2_8.mergeType == var_0_0.POPLAYER_TP.OTHER_FIGHT_VALUE_CHANGE then
				iter_2_8.mergeData.changeValue = iter_2_8.mergeData.changeValue + var_2_9
				var_2_9 = iter_2_8.mergeData.changeValue

				function iter_2_8.func()
					return ShowFactory:popLayer({
						changeValue = var_2_9,
						preValue = arg_2_2.preValue,
						title = arg_2_2.title
					}, var_0_0.POPLAYER_TP.OTHER_FIGHT_VALUE_CHANGE)
				end

				var_2_10 = true

				break
			end
		end

		if not var_2_10 then
			table.insert(self._showQueue, {
				stillEndPos = true,
				isFloat = true,
				func = function()
					return ShowFactory:popLayer({
						changeValue = var_2_9,
						preValue = arg_2_2.preValue,
						title = arg_2_2.title
					}, var_0_0.POPLAYER_TP.OTHER_FIGHT_VALUE_CHANGE)
				end,
				mergeData = {
					changeValue = var_2_9
				},
				mergeType = var_0_0.POPLAYER_TP.OTHER_FIGHT_VALUE_CHANGE
			})
		end
	end

	if arg_2_2.quickUseBox then
		local var_2_11 = arg_2_2.quickUseBox

		table.insert(self._showQueue, {
			isFloat = true,
			func = function()
				return ShowFactory:popLayer(var_2_11, var_0_0.POPLAYER_TP.BASE_QUICK_USE_BOX)
			end
		})
	end

	if arg_2_2.easterEggPop then
		local var_2_12 = {
			arg_2_2.easterEggPop
		}

		table.insert(self._showQueue, {
			isFloat = true,
			func = function()
				return ShowFactory:popLayer(var_2_12, var_0_0.POPLAYER_TP.EASTER_EGG)
			end
		})
	end

	self:_checkAndMergeQueue()

	if not self._inShowIng then
		self:_onCheckFeedbackShow(true)
	end
end

function ShowFeedBackService:_checkAndMergeQueue()
	table.sort(self._showQueue, function(arg_17_0, arg_17_1)
		if arg_17_0.stillEndPos and arg_17_1.stillEndPos then
			return false
		end

		return arg_17_1.stillEndPos
	end)
end

function ShowFeedBackService:_onCheckFightValueChange()
	local var_18_0 = g.core.model.User:getChangeFightValue()

	if var_18_0 ~= 0 then
		var_0_3:dispatchEvent(var_0_1.EVENT_ADD_FEEDBACK_SHOW, false, {
			fightValueChange = var_18_0
		})
	end
end

function ShowFeedBackService:_onCheckFeedbackShow(arg_19_1)
	if self._lockState then
		return
	end

	if not device.isWindowsDebug() and config.UPGRADE_SILENT_ENABLED and not UpgradeSilent.isFullDownload() then
		return
	end

	if #self._showQueue > 0 and not self._inShowIng then
		self._inShowIng = true

		local var_19_0 = self._showQueue[1].func()

		if var_19_0 then
			self._curShowingComp = var_19_0

			table.remove(self._showQueue, 1)
			var_19_0:addEventListener(fgui.UIEventType.ExitFinish, handler(self, self._onShowQueueExit))
		end
	else
		self._inShowIng = false
	end
end

function ShowFeedBackService:_onLockFeedBackPop()
	self._lockState = true
end

function ShowFeedBackService:_onUnlockFeedBackPop()
	self._lockState = false

	self:_onCheckFeedbackShow()
end

function ShowFeedBackService:_onShowQueueExit()
	self._inShowIng = false

	self:_onCheckFeedbackShow()
end

function ShowFeedBackService:_onResetShowQueue()
	g.core.model.User.bagData:resetAllQuickBoxItem()

	self._showQueue = {}
end

return ShowFeedBackService
