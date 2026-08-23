local var_0_0 = g.core.config.activity_theme_display_info
local var_0_1 = g.core.const.ConstMgr.ThemeConst
local var_0_2 = {
	[g.core.const.ConstMgr.ThemeConst.THEME_VALUE.SUMMER] = "bg/theme/bg_tswf_summer.jpg",
	[g.core.const.ConstMgr.ThemeConst.THEME_VALUE.GRYPH] = "bg/theme/bg_tswf_summer.jpg",
	[g.core.const.ConstMgr.ThemeConst.THEME_VALUE.HORUS] = "bg/theme/bg_activity03_horus_tansuo.jpg",
	[g.core.const.ConstMgr.ThemeConst.THEME_VALUE.NEWYEAR] = "bg/theme/bg_newyear_shopbg.jpg",
	[g.core.const.ConstMgr.ThemeConst.THEME_VALUE.LEVIA] = "bg/theme/bg_activity07_levia_tansuo.jpg",
	[g.core.const.ConstMgr.ThemeConst.THEME_VALUE.IFURITO] = "bg/theme/bg_activity03_horus_tansuo.jpg"
}
local ThemeExploreMainLayer = class("ThemeExploreMainLayer", require("app.fairyGUI.summerTheme.UI_ThemeExploreMainLayer"), function()
	local var_1_1 = {
		pkgName = "summerTheme",
		isFullScreen = true,
		pkgPath = "ui/summerTheme/summerTheme"
	}

	var_1_1.resName = var_0_1.THEME_ACTIVITY_EXPLORE_LAYER[({
		...
	})[1].themeValue or var_0_1.THEME_VALUE.GRYPH] or var_0_1.THEME_ACTIVITY_EXPLORE_LAYER[1]

	return fgui.GComponent:create(var_1_1, ...)
end)

function ThemeExploreMainLayer:ctor(arg_2_1)
	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.themeValue or var_0_1.THEME_VALUE.GRYPH
	end

	self._activeThemeType = var_0_1.THEME_TYPE
	self._activeThemeValue = var_2_0

	self:addBg(var_0_2[var_2_0])

	self._displayInfo = var_0_0.get(self._activeThemeValue)

	self.m_topBarComp:setResInfoById(self._displayInfo.explore_top_bar)
	self.m_topBarComp:setTitle(self._displayInfo.explore_name)

	self._expandIndex = nil
	self._waitExpandIndex = nil
	self._chapterIdMap = {}

	self.m_activityList:setIniter()
	self.m_activityList:setItemRenderer(handler(self, self._onActivityListRenderer))
	self.m_activityList:setItemProvider(handler(self, self._onActivityItemProvider))
	self.m_activityList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickItem))
end

function ThemeExploreMainLayer:onLoad()
	if self._activeThemeValue == var_0_1.THEME_VALUE.SUMMER then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.SWIM_MENUOPEN)
	elseif self._activeThemeValue == var_0_1.THEME_VALUE.GRYPH then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.SHENGQIANG_MENUOPEN)
	end

	self:setTouchable(true)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_RESETINFO, self._onResetMap, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_GETINFO, self.updateData, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_GETMAPINFO, self._onEnterMapStage, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	g.core.network.GameNetProxy:send_C2S_ThemeExplore_GetInfo({
		act_id = self._activeThemeValue
	})

	if self._expandIndex then
		self.m_activityList:scrollToView(self._expandIndex, true, true)
	end
end

function ThemeExploreMainLayer:_onResetMap(arg_4_1, arg_4_2, arg_4_3)
	g.core.network.GameNetProxy:send_C2S_ThemeExplore_GetMapInfo({
		act_id = self._activeThemeValue,
		chapter_id = arg_4_3.chapter_id
	})
end

function ThemeExploreMainLayer:_onCrossDayUpdate()
	local var_5_1 = g.core.model.User.activityDataManager:getShowActivityDataByCfg(self._activeThemeType, self._activeThemeValue)

	if not ((var_5_1 and var_5_1:isOpen() or nil) and true) then
		g.core.module.ModuleManager:popModule()

		return
	end

	self:updateData()
end

function ThemeExploreMainLayer:updateData()
	self._activityData = {}

	for iter_6_0, iter_6_1 in ipairs((g.core.model.User.themeData:getThemeData(self._activeThemeValue):getExploreData():getExploreChapterData())) do
		local var_6_0 = {
			data = iter_6_1
		}

		var_6_0.isOpen = iter_6_1.isOpen and iter_6_1.isTimeOpen
		var_6_0.info = g.core.config.activity_theme_explore_info.get(iter_6_1.id).toObject()
		var_6_0.isTimeOpen = iter_6_1.isTimeOpen
		var_6_0.themeValue = self._activeThemeValue

		table.insert(self._activityData, var_6_0)

		self._chapterIdMap[iter_6_1.id] = var_6_0
	end

	self.m_activityList:setNumItems(#self._activityData + 2)
	self.m_activityList:setColumnGap((math.ceil((display.width - (#self._activityData * 336 + 220)) / #self._activityData)))
end

function ThemeExploreMainLayer:_onEnterMapStage(arg_7_1, arg_7_2, arg_7_3)
	self:setTouchable(false)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_ENTER_PLAY_TRANSITION, false, {
		forceCallFunc = true,
		isSpine = true,
		callback = function()
			g.core.module.ModuleManager:pushModule(g.view.entrance.SUMMER_THEME_EXPLORE_STAGE, self._chapterIdMap[arg_7_3.chapter_id])
		end
	})
end

function ThemeExploreMainLayer:_onActivityItemProvider(arg_9_1)
	if arg_9_1 == 0 or arg_9_1 > #self._activityData then
		return "ui://summerTheme/ThemeExploreMainPlaceCell"
	else
		return "ui://summerTheme/ThemeExploreMainCell"
	end
end

function ThemeExploreMainLayer:_onActivityListRenderer(arg_10_1, arg_10_2)
	if arg_10_2.setCellView then
		arg_10_2:setCellView(self._activityData[arg_10_1], self._activeThemeValue)

		if not arg_10_2.cloneTrans then
			arg_10_2.getSharedTrans(arg_10_2, "enter_scaleOut", "CommonCardCellList", arg_10_2):play()
		end
	end
end

function ThemeExploreMainLayer:_onClickItem(arg_11_1)
	local var_11_0 = arg_11_1:getDataValue()

	if var_11_0 > 0 and var_11_0 <= #self._activityData then
		if not self._activityData[var_11_0].isOpen then
			if self._activityData[var_11_0].isTimeOpen then
				g.core.module.ModuleManager:tip(g.core.lang:get(405731, {
					name = g.core.config.activity_theme_explore_info.get(self._activityData[var_11_0].data.perChapterId).name,
					num = g.core.config.activity_theme_explore_info.get(self._activityData[var_11_0].data.id).pre_reward
				}))
			else
				local var_11_1, var_11_2, var_11_3, var_11_4 = g.core.common.ServerTime:getLeftTimeParts(self._activityData[var_11_0].data.openTime)

				if var_11_1 >= 1 then
					g.core.module.ModuleManager:tip(g.core.lang:get(405732, {
						num = var_11_1 + 1
					}))
				else
					g.core.module.ModuleManager:tip(g.core.lang:get(405733))
				end
			end

			return
		end

		local var_11_5 = self.m_activityList:getChildAt(var_11_0)

		if self._expandIndex then
			if var_11_0 == self._expandIndex then
				if var_11_5 and var_11_5.onUnExpand then
					var_11_5:onUnExpand()
				end

				self._expandIndex = nil
			else
				self._waitExpandIndex = var_11_0

				local var_11_6 = self.m_activityList:getChildAt(self._expandIndex)

				if var_11_6 and var_11_6.onUnExpand then
					var_11_6:onUnExpand(handler(self, self._onPreCloseFinish))
				end

				self._expandIndex = var_11_0
			end
		else
			if var_11_5 and var_11_5.onExpand then
				var_11_5:onExpand(handler(self, self.scrollToCurSel))
			end

			self._expandIndex = var_11_0

			self.m_activityList:scrollToView(var_11_0, true)
		end
	end
end

function ThemeExploreMainLayer:_onPreCloseFinish()
	if self._waitExpandIndex then
		local var_12_0 = self.m_activityList:getChildAt(self._waitExpandIndex)

		if var_12_0 and var_12_0.onUnExpand then
			var_12_0:onExpand(handler(self, self.scrollToCurSel))
		end

		self._waitExpandIndex = nil
	end
end

function ThemeExploreMainLayer:scrollToCurSel()
	if self._expandIndex then
		self.m_activityList:scrollToView(self._expandIndex, true)
	end
end

return ThemeExploreMainLayer
