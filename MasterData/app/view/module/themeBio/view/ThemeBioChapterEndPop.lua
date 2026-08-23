local var_0_0 = g.core.const.ConstMgr.ThemeConst
local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local ThemeBioChapterEndPop = class("ThemeBioChapterEndPop", require("app.fairyGUI.themeBio.UI_ThemeBioChapterEndPop"), function()
	local var_1_0 = ({
		...
	})[1].themeValue or var_0_0.THEME_VALUE.AKIRA

	return fgui.GComponent:create({
		pkgPath = "ui/themeBio/themeBio",
		pkgName = "themeBio",
		resName = var_0_0.THEME_BIO_CHAPTER_END_POP[var_1_0]
	}, ...)
end)

function ThemeBioChapterEndPop:ctor(arg_2_1)
	self:showAtCenter()

	if arg_2_1 then
		self._chapterInfo = arg_2_1.chapterInfo or {}
	end

	self._callFunc = arg_2_1 and arg_2_1.callFunc

	if arg_2_1 then
		self._closeTime = arg_2_1.showTime or 2
	end

	if arg_2_1 then
		self._activeThemeValue = arg_2_1.themeValue or 1
	end

	self:_initView()
	self:addClickListener(handler(self, self.onCloseBioChapterEnd))
end

function ThemeBioChapterEndPop:onLoad()
	self.m_enterTransition:play()
end

function ThemeBioChapterEndPop:onUnload()
	KnightVoiceCommon.stopVoice()
end

function ThemeBioChapterEndPop:_initView()
	self.m_picLoader:setURL((g.core.common.Path:getThemeBioIllustration(self._chapterInfo.base_id)))
	self.m_nameTxt:setText(self._chapterInfo.name)
	self.m_descTxt:setText(self._chapterInfo.chapter_clear)
	self.m_bgIcon:setURL(var_0_0.THEME_BIO_CHAPTER_CUT_SCENES_BG[self._activeThemeValue])
	KnightVoiceCommon.playVoice({
		voiceType = "biography_sound",
		resId = self._chapterInfo.base_id,
		func = handler(self, self.onCloseBioChapterEnd)
	})
end

function ThemeBioChapterEndPop:onCloseBioChapterEnd()
	if not self._onExit and self.m_backTransition then
		self._onExit = true

		self.m_backTransition:play(handler(self, function()
			self:dispatchCompEvent("UI_EVENT_CLOSE_MAIN_INFO_END")
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		end))
	end
end

return ThemeBioChapterEndPop
