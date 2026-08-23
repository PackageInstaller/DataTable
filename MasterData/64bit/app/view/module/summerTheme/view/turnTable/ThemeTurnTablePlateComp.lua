local var_0_0 = g.core.const.ConstMgr.ThemeConst
local var_0_1 = g.core.model.User.themeData
local ThemeTurnTablePlateComp = class("ThemeTurnTablePlateComp", require("app.fairyGUI.summerThemeGame.UI_ThemeTurnTablePlateComp"))

function ThemeTurnTablePlateComp:ctor()
	self._activeThemeValue = var_0_0.THEME_VALUE.MOLLY
	self._turnTableData = nil
	self._rewardList = {}
	self._plateSpine = nil
	self._plateIconList = {}
	self._plateIconBgList = {}
	self._animIndexList = {}
	self._turnIndex = nil
	self._speedCount = 0
	self._speedSchedule = nil
	self._isOnce = true

	self:_initView()
end

function ThemeTurnTablePlateComp:onUnload()
	self:_cancelSpeedSchedule()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.TURN_TABLE_STOP)
end

function ThemeTurnTablePlateComp:_initView()
	self._plateSpine = self.m_plateHolderComp:addEffectSpine({
		name = "game_turntable_times",
		anim = "play",
		isLoop = true,
		eventHandler = handler(self, self._onEffectEventBack)
	})

	self._plateSpine:setTimeScale(var_0_0.TURN_INIT_SPEED)
end

function ThemeTurnTablePlateComp:_initAwardIcons()
	if not self._turnTableData or self._isInitIcon then
		return
	end

	self._isInitIcon = true

	for iter_4_0 = 1, var_0_0.TURN_AWARD_NUM do
		local var_4_0 = self._rewardList[iter_4_0]

		if self._rewardList[iter_4_0] then
			local var_4_1 = g.core.common.Goods:convert({
				type = var_4_0.cfg.reward_type,
				value = var_4_0.cfg.reward_value
			})
			local var_4_2 = var_4_1.quality + 1
			local var_4_3 = "ui://summerTheme/pic_lunpan_bg_pinzhi_" .. var_4_1.quality + 1
			local var_4_4 = self._plateSpine:getNodeForSlot("cx00" .. iter_4_0)
			local var_4_5 = self._plateSpine:getNodeForSlot("cx10" .. iter_4_0)
			local var_4_6 = require("app.view.module.summerTheme.view.turnTable.ThemeTurnTablePlateIconBg").new()

			self:addAutoRetain(var_4_6)

			if device.isWindowsDebug() or g.core.platform.PlatformProxy:checkNewFunctionByVersion1_1_0() then
				var_4_6:setRotation(90)
			end

			var_4_6:updateBgUrl(var_4_3, var_4_2)
			var_4_4:addChild(var_4_6:displayObject())

			self._plateIconBgList[iter_4_0] = var_4_6

			local var_4_7 = require("app.view.module.summerTheme.view.turnTable.ThemeTurnTablePlateIcon").new()

			self:addAutoRetain(var_4_7)

			if device.isWindowsDebug() or g.core.platform.PlatformProxy:checkNewFunctionByVersion1_1_0() then
				var_4_7:setRotation(90)
			end

			var_4_7:updateIcon(var_4_0, var_4_1.icon, var_4_2)
			var_4_5:addChild(var_4_7:displayObject())

			self._plateIconList[iter_4_0] = var_4_7
		end
	end
end

function ThemeTurnTablePlateComp:updateAwardIcons()
	for iter_5_0 = 1, var_0_0.TURN_AWARD_NUM do
		if self._plateIconList[iter_5_0] then
			self._plateIconList[iter_5_0]:updateIcon(self._rewardList[iter_5_0])
		end
	end
end

function ThemeTurnTablePlateComp:hideAwardIconsGetSpine()
	for iter_6_0 = 1, var_0_0.TURN_AWARD_NUM do
		if self._plateIconBgList[iter_6_0] then
			self._plateIconBgList[iter_6_0]:showGetSpine(false)
		end
	end
end

function ThemeTurnTablePlateComp:_onEffectEventBack(arg_7_1, arg_7_2)
	if arg_7_1 and arg_7_1.type == "event" then
		if self._turnIndex and not self._speedSchedule then
			for iter_7_0 = 0, 3 do
				if arg_7_1.eventData and arg_7_1.eventData.name == "hit" .. (self._turnIndex + iter_7_0 - 1) % 8 + 1 then
					self._plateSpine:setTimeScale(0.2 * iter_7_0 + 0.1)
				end
			end
		end

		if self._turnIndex and not self._speedSchedule and arg_7_1.eventData and arg_7_1.eventData.name == "hit" .. self._turnIndex then
			local var_7_0 = self._plateIconBgList[self._turnIndex] and self._plateIconBgList[self._turnIndex]:getShowQuality() or 1

			self.m_onceEffectHolderComp:addEffectSpine({
				name = "eff_ui_turntable_get",
				remove = true,
				isLoop = false,
				anim = "play_" .. var_7_0
			})
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.TURN_TABLE_RESULT)

			if not self._isOnce then
				self:showAnimIconList(0)
			end

			self._plateSpine:pause()
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.TURN_TABLE_STOP)
			self:newScheduleOnce(handler(self, self._scheduleSpineResume), 1.5)
		end
	end
end

function ThemeTurnTablePlateComp:_scheduleSpineResume()
	self._plateSpine:resume()

	self._turnIndex = nil

	self._plateSpine:setTimeScale(var_0_0.TURN_INIT_SPEED)
	self:hideAwardIconsGetSpine()
	self:dispatchCompEvent("TurnTable_result")
end

function ThemeTurnTablePlateComp:showAnimIconList(arg_9_1)
	local var_9_0 = table.remove(self._animIndexList, 1)

	if not var_9_0 then
		return
	end

	if self._plateIconList[var_9_0] and arg_9_1 ~= 0 then
		self._plateIconList[var_9_0]:showGetSpine()
	end

	if self._plateIconBgList[var_9_0] then
		self._plateIconBgList[var_9_0]:showGetSpine(true)
	end

	self:newScheduleOnce(handler(self, self.showAnimIconList), 0.3)
end

function ThemeTurnTablePlateComp:updatePlateInfo(arg_10_1)
	self._activeThemeValue = arg_10_1

	local var_10_0 = var_0_1:getThemeData(arg_10_1)

	if not var_10_0 then
		return
	end

	self._turnTableData = var_10_0:getTurnTableData()
	self._rewardList = self._turnTableData:getRewardList()

	self:_initAwardIcons()
	self:updateAwardIcons()
end

function ThemeTurnTablePlateComp:playTurnPlateAnimation(arg_11_1, arg_11_2)
	self._isOnce = arg_11_2
	self._turnIndex = nil
	self._animIndexList = {}

	local var_11_0 = {}

	for iter_11_0 = 1, #arg_11_1 do
		for iter_11_1 = 1, var_0_0.TURN_AWARD_NUM do
			if self._rewardList[iter_11_1] and self._rewardList[iter_11_1].cfg.id == arg_11_1[iter_11_0] then
				var_11_0[iter_11_1] = true

				if self._rewardList[iter_11_1].cfg.big_reward == 1 then
					self._turnIndex = iter_11_1
				end
			end
		end
	end

	for iter_11_2, iter_11_3 in pairs(var_11_0) do
		table.insert(self._animIndexList, iter_11_2)
	end

	if self._turnIndex then
		for iter_11_4 = 1, #self._animIndexList do
			if self._animIndexList[iter_11_4] == self._turnIndex then
				table.remove(self._animIndexList, iter_11_4)

				break
			end
		end

		table.insert(self._animIndexList, 1, self._turnIndex)
	else
		self._turnIndex = self._animIndexList[1]
	end

	self:playAnimByIndex()
end

function ThemeTurnTablePlateComp:playAnimByIndex()
	if not self._turnIndex then
		return
	end

	self:_cancelSpeedSchedule()
	self:dispatchCompEvent("TurnTable_animStart")
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.TURN_TABLE_START)

	self._speedCount = 0

	self:_updateSpineSpeed()

	self._speedSchedule = g.core.common.Scheduler:newSchedule(handler(self, self._updateSpineSpeed), 0.25)
end

function ThemeTurnTablePlateComp:_cancelSpeedSchedule()
	if self._speedSchedule then
		g.core.common.Scheduler:cancelSchedule(self._speedSchedule)

		self._speedSchedule = nil
	end
end

function ThemeTurnTablePlateComp:_updateSpineSpeed()
	self._speedCount = self._speedCount + 1

	if var_0_0.TURN_SPEED_TABLE[self._speedCount] then
		self._plateSpine:setTimeScale(var_0_0.TURN_SPEED_TABLE[self._speedCount])
	else
		self:_cancelSpeedSchedule()
	end
end

return ThemeTurnTablePlateComp
