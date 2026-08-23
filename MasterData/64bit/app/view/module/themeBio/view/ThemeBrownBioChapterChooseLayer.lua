local var_0_0 = g.core.const.ConstMgr.ThemeConst
local var_0_1 = g.core.const.ConstMgr.ThemeBioConst
local var_0_2 = 5
local var_0_3 = g.core.config.activity_theme_info
local var_0_5 = g.core.config.activity_theme_display_info
local var_0_6 = g.core.model.User.themeData
local ThemeBrownBioChapterChooseLayer = class("ThemeBrownBioChapterChooseLayer", require("app.fairyGUI.themeBio.UI_ThemeBrownBioChapterChooseLayer"), function()
	local var_1_0 = {
		...
	}
	local var_1_1 = var_1_0[1] and var_1_0[1].themeValue

	return fgui.GComponent:create({
		pkgPath = "ui/themeBio/themeBio",
		pkgName = "themeBio",
		isFullScreen = true,
		resName = var_0_0.THEME_BIO_CHAPTER_CHOOSE_LAYER[var_1_1]
	}, ...)
end)

function ThemeBrownBioChapterChooseLayer:ctor(arg_2_1)
	self._themeValue = arg_2_1 and arg_2_1.themeValue
	self._themeInfo = nil

	if self._themeValue == 0 then
		return
	end

	self._themeInfo = var_0_3.get(self._themeValue)
	self.m_chapterArr = {}
	self._chapterInfos = {}

	for iter_2_0 = 1, var_0_2 do
		self.m_chapterArr[iter_2_0] = self["m_chapterComp" .. iter_2_0]
	end

	self._themeBioData = var_0_6:getThemeData(self._themeValue):getThemeBioData()
	self._chapterInfos = {}

	for iter_2_1 = 1, var_0_2 do
		if self._themeInfo["biography_id_" .. iter_2_1] > 0 then
			local var_2_0 = self._themeBioData:getChapter(self._themeInfo["biography_id_" .. iter_2_1])

			if var_2_0 then
				self._chapterInfos[#self._chapterInfos + 1] = var_2_0
			end
		end
	end

	self:_initActivityMainUI()
	self.m_enterTransition:setHook("pass", handler(self, self._onPlayEnterAtPass))
	self.m_topBar:setReturnCallBack(handler(self, self._onClickClose))
end

function ThemeBrownBioChapterChooseLayer:_initActivityMainUI()
	self:addBg(var_0_0.THEME_BIO_CHOOSE_LAYER_BG[self._themeValue])

	self._displayInfo = var_0_5.get(self._themeValue)

	self.m_topBar:setResInfoById(self._displayInfo.biography_top_bar)
	self.m_topBar:setTitle(self._displayInfo.biography_name)
end

function ThemeBrownBioChapterChooseLayer:_addBgMusic()
	local var_4_0

	for iter_4_0, iter_4_1 in ipairs(self._chapterInfos) do
		local var_4_1, var_4_2, var_4_3 = self._themeBioData:getChapterUnlockStateAndTip(iter_4_1)

		if var_4_1 == var_0_1.BIO_CHAPTER_UNLOCK then
			var_4_0 = iter_4_1.music
		else
			break
		end
	end

	if var_4_0 then
		g.core.sound.SoundManager:playMusic(var_4_0, true)
	end
end

function ThemeBrownBioChapterChooseLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_BIOGRAPHY_GETINFO, handler(self, self._onGetInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)

	if not self._themeBioData:isInited() then
		g.core.network.GameNetProxy:send_C2S_ThemeBiography_GetInfo({
			act_id = self._themeValue
		})
	elseif self._themeBioData:isExpired() then
		self._themeBioData:resetExpired()
		g.core.network.GameNetProxy:send_C2S_ThemeBiography_GetInfo({
			act_id = self._themeValue
		})
	else
		self:updatePageView()
	end

	self.m_enterTransition:play()
	self:_addBgMusic()
end

function ThemeBrownBioChapterChooseLayer:onUnload()
	g.core.sound.SoundManager:rewindMusic()
end

function ThemeBrownBioChapterChooseLayer:_onGetInfo(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self:updatePageView()
end

function ThemeBrownBioChapterChooseLayer:_onCrossDayUpdate()
	local var_8_1 = g.core.model.User.activityDataManager:getShowActivityDataByCfg(var_0_0.THEME_TYPE, self._themeValue)

	if not ((var_8_1 and var_8_1:isOpen() or nil) and true) then
		g.core.module.ModuleManager:popToRoot()

		return
	end

	self:updatePageView()
end

function ThemeBrownBioChapterChooseLayer:updatePageView()
	for iter_9_0, iter_9_1 in ipairs(self._chapterInfos) do
		if self.m_chapterArr[iter_9_0] then
			self.m_chapterArr[iter_9_0]:updateData(iter_9_1, self._themeValue)
		end
	end
end

function ThemeBrownBioChapterChooseLayer:_onPlayEnterAtPass()
	for iter_10_0, iter_10_1 in ipairs(self._chapterInfos) do
		if self.m_chapterArr[iter_10_0] then
			self.m_chapterArr[iter_10_0]:checkPlayedPassEffect()
		end
	end
end

function ThemeBrownBioChapterChooseLayer:_onClickClose()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_THEME_BIO_EXIT_CHAPTER_CHOOSE_LAYER, true, {})
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return ThemeBrownBioChapterChooseLayer
