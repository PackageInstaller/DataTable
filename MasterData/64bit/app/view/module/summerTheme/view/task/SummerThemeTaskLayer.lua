local var_0_0 = g.core.const.ConstMgr.ThemeConst
local var_0_1 = g.core.config.activity_theme_display_info
local var_0_2 = g.core.const.ConstMgr.SoundConst
local SummerThemeTaskLayer = class("SummerThemeTaskLayer", require("app.fairyGUI.summerTheme.UI_SummerThemeTaskLayer"), function()
	local var_1_0 = ({
		...
	})[1].themeValue or var_0_0.THEME_VALUE.GRYPH

	return fgui.GComponent:create({
		pkgName = "summerTheme",
		pkgPath = "ui/summerTheme/summerTheme",
		isFullScreen = true,
		resName = var_0_0.THEME_ACTIVITY_TASK_LAYER[var_1_0]
	})
end)

function SummerThemeTaskLayer:ctor(arg_2_1)
	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.themeValue or var_0_0.THEME_VALUE.GRYPH
	end

	self._activeThemeType = var_0_0.THEME_TYPE
	self._activeThemeValue = var_2_0

	if arg_2_1 then
		self._activityValues = arg_2_1.activityValues or {
			var_2_0
		}
	end

	self._taskTypeArr = nil
	self._curTaskType = nil
	self._curTaskArr = nil

	self:initThemeTask()
end

function SummerThemeTaskLayer:onLoad()
	self:_initRegisterMSG()

	for iter_3_0, iter_3_1 in ipairs(self._activityValues) do
		local var_3_0 = g.core.model.User.themeData:getThemeData(iter_3_1)

		if var_3_0 then
			local var_3_1 = var_3_0:getTaskData()

			var_3_1:refreshTaskCrossDay()
			var_3_1:requestTaskInfo()
			var_3_1:requestTaskDropInfo()
		end
	end

	if self._curTaskType == nil then
		self.m_tabList:setSelectedIndex(0)
		self:_refreshTaskType()
	end

	self:_refreshTaskCooldown()

	if self._activeThemeValue == var_0_0.THEME_VALUE.SUMMER then
		g.core.sound.SoundManager:playMusic(var_0_2.BGM.MUSIC_SUMMERTHEME_MAIN)
	elseif self._activeThemeValue == var_0_0.THEME_VALUE.GRYPH then
		g.core.sound.SoundManager:playMusic(var_0_2.BGM.MUSIC_SHENGQIANG_MAIN)
	end

	self.m_enterTransition:play()
	g.core.model.User.themeData:changeThemeBGM(self._activeThemeValue)
end

function SummerThemeTaskLayer:onUnload()
	return
end

function SummerThemeTaskLayer:initThemeTask()
	self:_initThemeTaskData()
	self:_initThemeTaskUI()
end

function SummerThemeTaskLayer:_initThemeTaskData()
	local var_6_0 = {}

	self._taskTypeArr = {}

	for iter_6_0, iter_6_1 in ipairs(self._activityValues) do
		local var_6_1 = g.core.model.User.themeData:getActivityData(iter_6_1)
		local var_6_2 = var_6_1 and var_6_1:getActivityState()

		if var_6_2 == g.core.const.ConstMgr.ActivityConst.ACTIVITY_STATE.START or var_6_2 == g.core.const.ConstMgr.ActivityConst.ACTIVITY_STATE.END then
			local var_6_3 = g.core.model.User.themeData:getThemeData(iter_6_1)

			if var_6_3 then
				for iter_6_2, iter_6_3 in ipairs(var_6_3:getTaskData():getTaskTypeArr()) do
					if not var_6_0[iter_6_3] then
						var_6_0[iter_6_3] = true

						table.insert(self._taskTypeArr, iter_6_3)
					end
				end
			end
		end
	end

	table.sort(self._taskTypeArr, function(arg_7_0, arg_7_1)
		if arg_7_0 == var_0_0.THEME_TASK_TYPE.COMMON then
			arg_7_0 = 10
		end

		if arg_7_1 == var_0_0.THEME_TASK_TYPE.COMMON then
			arg_7_1 = 10
		end

		return arg_7_0 < arg_7_1
	end)
end

function SummerThemeTaskLayer:_initThemeTaskUI()
	self.m_tabList:setIniter()
	self.m_tabList:setItemRenderer(handler(self, self._onRenderTabTaskList))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onGroupTaskTypeChange))
	self.m_taskList:setVirtual()
	self.m_taskList:doFairyBatching(false)
	self.m_taskList:setItemProvider(handler(self, self._onTaskItemTempl))
	self.m_taskList:setItemRenderer(handler(self, self._onRenderTaskList))

	self._displayInfo = var_0_1.get(self._activeThemeValue)

	self.m_topBarComp:setResInfoById(self._displayInfo.task_top_bar)
	self.m_topBarComp:setTitle(self._displayInfo.task_name)
	self:addBg(var_0_0.THEME_TASK_BG[self._activeThemeValue], nil, nil, 1)
	self.m_tabList:setNumItems(#self._taskTypeArr)
end

function SummerThemeTaskLayer:_initRegisterMSG()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_ACTION_GETINFO, self._refreshTaskList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH, self._onRcvThemeActionStatus, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_ACTION_GETAWARDS, self._onRcvThemeActionAwards, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_HOLIDAY_DROP_INFO, self._onRcvThemeTaskDrop, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)

	self._stateCheckScheduler = self:newSchedule(handler(self, self._onStateCheck), 60)
end

function SummerThemeTaskLayer:_onStateCheck()
	local var_10_0 = false

	for iter_10_0, iter_10_1 in ipairs(self._activityValues) do
		local var_10_1 = g.core.model.User.activityDataManager:getShowActivityDataByCfg(self._activeThemeType, iter_10_1)

		if var_10_1 and var_10_1:isOpen() then
			var_10_0 = true

			break
		end
	end

	if not var_10_0 then
		g.core.module.ModuleManager:popModule()

		return
	end

	local var_10_2 = #self._taskTypeArr

	self:_initThemeTaskData()

	if #self._taskTypeArr ~= var_10_2 then
		self.m_tabList:setNumItems(#self._taskTypeArr)

		self._curTaskType = nil

		self.m_tabList:setSelectedIndex(0)
		self:_refreshTaskType()
	end

	self:_refreshTaskList()
end

function SummerThemeTaskLayer:_onRenderTabTaskList(arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2:getChild("redPointComp")
	local var_11_1 = self._taskTypeArr[arg_11_1 + 1]
	local var_11_2

	if self._taskTypeArr[arg_11_1 + 1] == var_0_0.THEME_TASK_TYPE.DAILY then
		var_11_2 = self._displayInfo.daily_name

		var_11_0:setId(266)
	elseif var_11_1 == var_0_0.THEME_TASK_TYPE.HONOUR then
		var_11_2 = self._displayInfo.achievement_name

		var_11_0:setId(265)
	else
		var_11_2 = self._displayInfo.drop_name
	end

	arg_11_2:setTitle(var_11_2)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = var_11_0,
		customData = {
			themeValue = self:_getDisplayThemeValue(var_11_1),
			activityValues = self._activityValues
		}
	})
end

function SummerThemeTaskLayer:_onTaskItemTempl(arg_12_1)
	if self._curTaskType == var_0_0.THEME_TASK_TYPE.COMMON then
		return "ui://summerTheme/" .. (var_0_0.THEME_ACTIVITY_TASK_CELLEX[self._activeThemeValue] or "HolyGuideThemeTaskCellEx")
	elseif self._curTaskType == var_0_0.THEME_TASK_TYPE.DAILY then
		return "ui://summerTheme/" .. (var_0_0.THEME_ACTIVITY_TASK_CELL[self._activeThemeValue] or "HolyGuideThemeTaskCell")
	else
		return "ui://summerTheme/" .. (var_0_0.THEME_ACTIVITY_TASK_CELL[self._activeThemeValue] or "HolyGuideThemeTaskCell")
	end
end

function SummerThemeTaskLayer:_onRenderTaskList(arg_13_1, arg_13_2)
	if self._curTaskType == nil then
		return
	end

	local var_13_0 = self._curTaskArr and self._curTaskArr[arg_13_1 + 1]

	if not var_13_0 then
		return
	end

	arg_13_2:refreshTaskCell(var_13_0, (self._curTaskThemeValues or nil) and (self._curTaskThemeValues[arg_13_1 + 1] or self._activeThemeValue), self._activityValues)
end

function SummerThemeTaskLayer:_refreshTaskType()
	local var_14_0 = self._taskTypeArr[self.m_tabList:getSelectedIndex() + 1]

	if self._curTaskType == var_14_0 then
		return
	end

	self._curTaskType = var_14_0

	if self._curTaskType == var_0_0.THEME_TASK_TYPE.HONOUR then
		self.m_showCDController:setSelectedIndex(0)
	else
		self.m_showCDController:setSelectedIndex(1)
		self:_refreshTaskCooldown()
	end
end

function SummerThemeTaskLayer:_getDisplayThemeValue(arg_15_1)
	local var_15_0 = self._activeThemeValue

	for iter_15_0, iter_15_1 in ipairs(self._activityValues) do
		local var_15_1 = g.core.model.User.themeData:getActivityData(iter_15_1)

		if var_15_1 and var_15_1:getActivityState() == g.core.const.ConstMgr.ActivityConst.ACTIVITY_STATE.START then
			var_15_0 = iter_15_1
		end
	end

	return var_15_0
end

function SummerThemeTaskLayer:_refreshTaskList()
	if self._curTaskType == nil then
		return
	end

	local var_16_0 = g.core.model.User.themeData
	local var_16_1 = g.core.const.ConstMgr.ActivityConst

	self._curTaskArr = {}
	self._curTaskThemeValues = {}

	local var_16_2 = self:_getDisplayThemeValue(self._curTaskType)
	local var_16_3 = var_16_0:getThemeData(var_16_2)

	if var_16_3 then
		local var_16_4 = var_16_3:getTaskData():getTaskArrByType(self._curTaskType)

		if var_16_4 then
			for iter_16_0, iter_16_1 in ipairs(var_16_4) do
				local var_16_5 = self._curTaskType ~= var_0_0.THEME_TASK_TYPE.COMMON and iter_16_1:getBaseInfo().activity_id or nil
				local var_16_6 = var_16_5 == nil or var_16_5 == 0

				if var_16_5 and var_16_5 ~= 0 then
					local var_16_7 = var_16_0:getActivityData(var_16_5)

					var_16_6 = var_16_7 and var_16_7:getActivityState() == var_16_1.ACTIVITY_STATE.START or false
				end

				if var_16_6 then
					local var_16_8 = iter_16_1

					if var_16_5 and var_16_5 ~= 0 and var_16_5 ~= var_16_2 then
						local var_16_9 = var_16_0:getThemeData(var_16_5)

						if var_16_9 then
							local var_16_10 = var_16_9:getTaskData():getTaskArrByType(self._curTaskType)

							if var_16_10 then
								local var_16_11 = iter_16_1:getBaseInfo().id

								for iter_16_2, iter_16_3 in ipairs(var_16_10) do
									if iter_16_3:getBaseInfo().id == var_16_11 then
										var_16_8 = iter_16_3

										break
									end
								end
							end
						end
					end

					table.insert(self._curTaskArr, var_16_8)
					table.insert(self._curTaskThemeValues, var_16_2)
				end
			end
		end
	end

	table.sort(self._curTaskArr, function(arg_17_0, arg_17_1)
		return arg_17_0:sortCompare(arg_17_1)
	end)
	self.m_tabList:setNumItems(#self._taskTypeArr)
	self.m_taskList:setNumItems(#self._curTaskArr)
	self.m_taskList:transitionShowCells("enter_left", 0.03)
end

function SummerThemeTaskLayer:_refreshTaskCooldown()
	self.m_cooldown:resetCooldownTs((g.core.common.ServerTime:getOpenLeftTime(24, 0, 0)))
end

function SummerThemeTaskLayer:_onGroupTaskTypeChange()
	local var_19_0 = self._taskTypeArr[self.m_tabList:getSelectedIndex() + 1]

	if self._curTaskType == var_19_0 then
		return
	end

	g.core.sound.SoundManager:playSound(var_0_2.Sound.READY_OFF)

	self._curTaskType = var_19_0

	if self._curTaskType == var_0_0.THEME_TASK_TYPE.HONOUR then
		self.m_showCDController:setSelectedIndex(0)
	else
		self.m_showCDController:setSelectedIndex(1)
		self:_refreshTaskCooldown()
	end

	self:_refreshTaskList()
end

function SummerThemeTaskLayer:_onRcvThemeTaskDrop(arg_20_1, arg_20_2, arg_20_3)
	for iter_20_0, iter_20_1 in ipairs(self._activityValues) do
		if arg_20_3.sub_activity_id == iter_20_1 then
			self:_refreshTaskList()

			return
		end
	end
end

function SummerThemeTaskLayer:_onRcvThemeActionAwards(arg_21_1, arg_21_2, arg_21_3)
	if arg_21_3.awards then
		g.core.module.ModuleManager:awardSummary(arg_21_3.awards)
	end

	self:_refreshTaskList()
end

function SummerThemeTaskLayer:_onRcvThemeActionStatus(arg_22_1, arg_22_2, arg_22_3)
	if arg_22_3.tp == g.core.network.proto.STATUS_THEME then
		self:_refreshTaskList()
	end
end

function SummerThemeTaskLayer:_onCrossDayUpdate()
	local var_23_0 = false

	for iter_23_0, iter_23_1 in ipairs(self._activityValues) do
		local var_23_1 = g.core.model.User.themeData:getThemeData(iter_23_1)

		if var_23_1 then
			var_23_1:getTaskData():refreshTaskCrossDay()
		end

		local var_23_2 = g.core.model.User.activityDataManager:getShowActivityDataByCfg(self._activeThemeType, iter_23_1)

		if var_23_2 and var_23_2:isOpen() then
			var_23_0 = true
		end
	end

	if not var_23_0 then
		g.core.module.ModuleManager:popModule()

		return
	end

	local var_23_3 = #self._taskTypeArr

	self:_initThemeTaskData()

	if #self._taskTypeArr ~= var_23_3 then
		self.m_tabList:setNumItems(#self._taskTypeArr)

		self._curTaskType = nil

		self.m_tabList:setSelectedIndex(0)
		self:_refreshTaskType()
	end

	for iter_23_2, iter_23_3 in ipairs(self._activityValues) do
		local var_23_4 = g.core.model.User.themeData:getThemeData(iter_23_3)

		if var_23_4 then
			var_23_4:getTaskData():requestTaskInfo()
		end
	end

	self:_refreshTaskCooldown()
end

return SummerThemeTaskLayer
