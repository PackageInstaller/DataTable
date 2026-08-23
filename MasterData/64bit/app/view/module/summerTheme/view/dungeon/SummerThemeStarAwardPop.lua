local var_0_0 = g.core.model.User.themeData
local var_0_1 = g.core.const.ConstMgr.ThemeConst
local SummerThemeStarAwardPop = class("SummerThemeStarAwardPop", require("app.fairyGUI.summerTheme.UI_SummerThemeStarAwardPop"), function()
	local var_1_1 = {
		pkgPath = "ui/summerTheme/summerTheme",
		pkgName = "summerTheme"
	}

	var_1_1.resName = var_0_1.THEME_ACTIVITY_DUNGEON_AWARD_POP[({
		...
	})[1].themeValue or var_0_1.THEME_VALUE.GRYPH] or var_0_1.THEME_ACTIVITY_DUNGEON_AWARD_POP[1]

	return fgui.GComponent:create(var_1_1, ...)
end)

function SummerThemeStarAwardPop:ctor(arg_2_1)
	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.themeValue or var_0_1.THEME_VALUE.GRYPH
	end

	self._activeThemeType = var_0_1.THEME_TYPE
	self._activeThemeValue = var_2_0
	self._chapterId = arg_2_1.chapterId

	self:showAtCenter()

	self.rewardData = {}

	self.m_rewardList:setIniter()
	self.m_rewardList:setItemRendererAsync1(handler(self, self._onListRenderer), 0.02, false)
	self:_updateAwardView()
end

function SummerThemeStarAwardPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_DUNGEON_GETCHAPTERBOX, handler(self, self._onGetChapterChestAward), self)
end

function SummerThemeStarAwardPop:_updateAwardView()
	self._dungeonData = var_0_0:getThemeData(self._activeThemeValue):getDungeonData()
	self.rewardData = self._dungeonData:getChapterStarAwards(self._chapterId)

	local var_4_0 = self._dungeonData:getChapterStar(self._chapterId)

	self._ownStarNum = var_4_0 or 0

	self.m_starTxt:setText(var_4_0)
	self.m_rewardList:setNumItems(#self.rewardData)
end

function SummerThemeStarAwardPop:_onListRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateItem(self.rewardData[arg_5_1 + 1], arg_5_1, self._ownStarNum, self._chapterId, self._activeThemeValue)
end

function SummerThemeStarAwardPop:_onGetChapterChestAward(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_6_4.awards)
		self:_updateAwardView()
	end
end

return SummerThemeStarAwardPop
