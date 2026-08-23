local var_0_0 = g.core.config.activity_theme_dungeon_chapter_info
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.const.ConstMgr.ThemeConst
local var_0_3 = g.core.model.User.themeData
local SummerThemeChapterTab = class("SummerThemeChapterTab", require("app.fairyGUI.summerTheme.UI_SummerThemeChapterTab"))

function SummerThemeChapterTab:ctor()
	self._activeThemeType = var_0_2.THEME_TYPE
	self._activeThemeValue = 0
	self._chapterId = 0
	self._selectIdx = 1
	self._isOpen = false
	self._isPrePass = false

	self:addClickListener(handler(self, self._onClick))
end

function SummerThemeChapterTab:updateTabInfo(arg_2_1, arg_2_2, arg_2_3)
	self._activeThemeValue = arg_2_3
	self._chapterId = arg_2_1.chapterId
	self._selectIdx = arg_2_2
	self._dungeonData = var_0_3:getThemeData(self._activeThemeValue):getDungeonData()

	local var_2_0 = var_0_0.get(self._chapterId)

	self:setTitle(var_2_0.name)
	self:setIcon(g.core.common.Path:getThemeDungeonChapterIcon(var_2_0.res))

	if self._activeThemeValue ~= var_0_2.THEME_VALUE.NEWYEAR then
		self.m_iconfg:setURL(g.core.common.Path:getThemeDungeonChapterTab(var_2_0.icon))
	end

	if not self._dungeonData:isPreChapterPass(self._chapterId) then
		self._isOpen = false
		self._isPrePass = true

		self.m_stateController:setSelectedIndex(2)
	elseif var_0_1:getTime() < arg_2_1.chapterOpenTime then
		self._isOpen = false

		local var_2_1, var_2_2, var_2_3, var_2_4 = var_0_1:getLeftTimeParts(arg_2_1.chapterOpenTime)

		if var_2_2 > 0 or var_2_3 > 0 or var_2_4 > 0 then
			if var_2_1 == 0 then
				self.m_openTime:setText(g.core.lang:get(405709))
			else
				self.m_openTime:setText(g.core.lang:get(100 + var_2_1 + 1) .. g.core.lang:get(405719))
			end
		else
			self.m_openTime:setText(g.core.lang:get(100 + var_2_1) .. g.core.lang:get(405719))
		end

		self.m_stateController:setSelectedIndex(0)
	else
		self._isOpen = true

		self.m_stateController:setSelectedIndex(1)
	end

	self.m_isSelectController:setSelectedIndex(0)
end

function SummerThemeChapterTab:_onClick()
	if self._isOpen then
		self:dispatchCompEvent("ON_SELECT_CHAPTER_ID", {
			id = self._chapterId,
			selectIndex = self._selectIdx
		})
	elseif self._isPrePass then
		g.core.module.ModuleManager:tip(g.core.lang:get(405728))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(405713))
	end
end

function SummerThemeChapterTab:refreshRedPoint()
	if self._activeThemeValue == 0 then
		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			themeValue = self._activeThemeValue,
			id = self._chapterId
		}
	})
end

return SummerThemeChapterTab
