local SummerDungeonStoryStagePop = class("SummerDungeonStoryStagePop", require("app.fairyGUI.summerTheme.UI_SummerThemeDungeonFinishPop"), function()
	return fgui.GComponent:create({
		pkgName = "summerTheme",
		resName = "SummerThemeDungeonFinishPop",
		pkgPath = "ui/summerTheme/summerTheme"
	}, ...)
end)

function SummerDungeonStoryStagePop:ctor(arg_2_1)
	if arg_2_1 then
		self._chapterId = arg_2_1.id or 1
	end

	if arg_2_1 then
		self._activeThemeValue = arg_2_1.themeValue or 1
	end

	self:getView():setSize(display.width, display.height)
	self:showAtCenter()
	self.m_typeController:setSelectedIndex(math.max(0, self._activeThemeValue - 1 <= self.m_typeController:getPageCount() and self._activeThemeValue - 1 or 1))
	self.m_chapterIdTxt:setText("0" .. self._chapterId)
end

function SummerDungeonStoryStagePop:onLoad()
	self.m_enterTransition:play(handler(self, self._enterActionPlayEnd))
end

function SummerDungeonStoryStagePop:_enterActionPlayEnd()
	self:newScheduleOnce(handler(self, self._playBackAction), 1)
end

function SummerDungeonStoryStagePop:_playBackAction()
	self.m_backTransition:play(handler(self, self._backActionPlayEnd))
end

function SummerDungeonStoryStagePop:_backActionPlayEnd()
	g.core.module.ModuleManager:popModule()
end

return SummerDungeonStoryStagePop
