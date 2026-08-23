local var_0_0 = g.core.const.ConstMgr.ThemeConst
local ThemeBioChapterBeginPop = class("ThemeBioChapterBeginPop", require("app.fairyGUI.themeBio.UI_ThemeBioChapterBeginPop"), function()
	local var_1_0 = ({
		...
	})[1].themeValue or var_0_0.THEME_VALUE.AKIRA

	return fgui.GComponent:create({
		pkgPath = "ui/themeBio/themeBio",
		pkgName = "themeBio",
		resName = var_0_0.THEME_BIO_CHAPTER_BEGIN_POP[var_1_0]
	}, ...)
end)

function ThemeBioChapterBeginPop:ctor(arg_2_1)
	if arg_2_1 then
		self._activeThemeValue = arg_2_1.themeValue or var_0_0.THEME_VALUE.AKIRA
	end

	self:showAtCenter()

	if arg_2_1 then
		self._chapterInfo = arg_2_1.chapterInfo or {}
	end

	self._callFunc = arg_2_1 and arg_2_1.callFunc

	if arg_2_1 then
		self._closeTime = arg_2_1.showTime or 2
	end

	self:_initView()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._waitState = true
end

function ThemeBioChapterBeginPop:onLoad()
	self.m_enterTransition:play(handler(self, self._onEnterAnimEnd))
end

function ThemeBioChapterBeginPop:_onEnterAnimEnd()
	if self._waitState then
		self._waitState = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end
end

function ThemeBioChapterBeginPop:_initView()
	self.m_picLoader:setURL((g.core.common.Path:getThemeBioIllustration(self._chapterInfo.base_id)))
	self.m_nameTxt:setText(self._chapterInfo.name)
	self.m_descTxt:setText(self._chapterInfo.chapter_clear)
	self.m_bgIcon:setURL(var_0_0.THEME_BIO_CHAPTER_CUT_SCENES_BG[self._activeThemeValue])

	self._scheduleHandler = g.core.common.Scheduler:newScheduleOnce(handler(self, self.onCloseBioChapterBegin), self._closeTime)
end

function ThemeBioChapterBeginPop:onCloseBioChapterBegin()
	if self.m_backTransition then
		self.m_backTransition:play(handler(self, function()
			self:dispatchCompEvent("UI_EVENT_CLOSE_MAIN_INFO_START")
			g.core.module.ModuleManager:popComponent()
		end))
	end
end

function ThemeBioChapterBeginPop:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

	if self._waitState then
		self._waitState = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end
end

return ThemeBioChapterBeginPop
