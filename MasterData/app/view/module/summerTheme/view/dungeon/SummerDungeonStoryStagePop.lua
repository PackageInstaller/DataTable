local var_0_0 = g.core.model.User.themeData
local var_0_1 = g.core.const.ConstMgr.ThemeConst
local var_0_2 = g.core.config.activity_theme_dungeon_stage_info
local SummerDungeonStoryStagePop = class("SummerDungeonStoryStagePop", require("app.fairyGUI.summerTheme.UI_SummerDungeonStoryStagePop"), function()
	local var_1_1 = {
		pkgPath = "ui/summerTheme/summerTheme",
		pkgName = "summerTheme"
	}

	var_1_1.resName = var_0_1.THEME_ACTIVITY_DUNGEON_STORY_POP[({
		...
	})[1].themeValue or var_0_1.THEME_VALUE.GRYPH] or var_0_1.THEME_ACTIVITY_DUNGEON_STORY_POP[1]

	return fgui.GComponent:create(var_1_1, ...)
end)

function SummerDungeonStoryStagePop:ctor(arg_2_1)
	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.themeValue or var_0_1.THEME_VALUE.GRYPH
	end

	self._activeThemeType = var_0_1.THEME_TYPE
	self._activeThemeValue = var_2_0
	self._stageInfo = nil
	self._stageId = arg_2_1.id or 0
	self._dungeonData = var_0_0:getThemeData(self._activeThemeValue):getDungeonData()

	self:showAtCenter()
	self:_initUIListen()
	self.m_enterTransition:play()
end

function SummerDungeonStoryStagePop:_initUIListen()
	self.m_playStoryBtn:addClickListener(handler(self, self._onClickPlayStory))
	self.m_starStoryBg:addClickListener(handler(self, self._onClickPlayStory))
end

function SummerDungeonStoryStagePop:onLoad()
	self._stageInfo = var_0_2.get(self._stageId)

	self.m_stageIdTxt:setText(self._stageInfo.stage_id)
	self.m_storyNameTxt:setText(self._stageInfo.name)
	self.m_descComp:setTitle((string.gsub(self._stageInfo.des, "#main_role#", g.core.model.User:getName())))
	self.m_typeController:setSelectedIndex(math.max(0, self._activeThemeValue - 1 <= self.m_typeController:getPageCount() and self._activeThemeValue - 1 or 1))
end

function SummerDungeonStoryStagePop:_onClickPlayStory()
	self:dispatchCompEvent("SELECT_STORY_STAGE_POP", {
		stageId = self._stageId
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
		id = self._stageInfo.plot
	})
	self:removeSelf()
end

return SummerDungeonStoryStagePop
