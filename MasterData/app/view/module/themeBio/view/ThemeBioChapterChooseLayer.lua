local ThemeBioChapterChooseLayer = class("ThemeBioChapterChooseLayer", require("app.fairyGUI.themeBio.UI_ThemeBioChapterChooseLayer"), function()
	return fgui.GComponent:create({
		resName = "ThemeBioChapterChooseLayer",
		pkgPath = "ui/themeBio/themeBio",
		isFullScreen = true,
		pkgName = "themeBio"
	}, ...)
end)
local var_0_1 = g.core.const.ConstMgr.ThemeConst
local var_0_2 = g.core.const.ConstMgr.ThemeBioConst
local var_0_3 = 5
local var_0_4 = g.core.config.activity_theme_info
local var_0_6 = g.core.config.activity_theme_display_info
local var_0_7 = g.core.model.User.themeData

function ThemeBioChapterChooseLayer:ctor(arg_2_1)
	self._themeValue = arg_2_1 and arg_2_1.themeValue
	self._themeInfo = nil

	if self._themeValue == 0 then
		return
	end

	self._themeInfo = var_0_4.get(self._themeValue)
	self.m_chapterArr = {}
	self._chapterInfos = {}

	for iter_2_0 = 1, var_0_3 do
		self.m_chapterArr[iter_2_0] = self["m_chapterComp" .. iter_2_0]
	end

	self._themeBioData = var_0_7:getThemeData(self._themeValue):getThemeBioData()
	self._chapterInfos = {}

	for iter_2_1 = 1, var_0_3 do
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

function ThemeBioChapterChooseLayer:_initActivityMainUI()
	self.m_bgIcon:setURL(var_0_1.THEME_ACTIVITY_BG[self._themeValue])
	self.m_imgLoader:setURL(var_0_2.CHAPTER_CHOOSE_ILLUSTRATION[self._themeValue])

	self._displayInfo = var_0_6.get(self._themeValue)

	self.m_topBar:setResInfoById(self._displayInfo.biography_top_bar)
	self.m_topBar:setTitle(self._displayInfo.biography_name)
end

function ThemeBioChapterChooseLayer:onLoad()
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
end

function ThemeBioChapterChooseLayer:_onGetInfo(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self:updatePageView()
end

function ThemeBioChapterChooseLayer:_onCrossDayUpdate()
	local var_6_1 = g.core.model.User.activityDataManager:getShowActivityDataByCfg(var_0_1.THEME_TYPE, self._themeValue)

	if not ((var_6_1 and var_6_1:isOpen() or nil) and true) then
		g.core.module.ModuleManager:popToRoot()

		return
	end

	self:updatePageView()
end

function ThemeBioChapterChooseLayer:receiveCompEvent(arg_7_1, arg_7_2)
	return
end

function ThemeBioChapterChooseLayer:onUnload()
	return
end

function ThemeBioChapterChooseLayer:_updateChapterState()
	return
end

function ThemeBioChapterChooseLayer:updatePageView()
	for iter_10_0, iter_10_1 in ipairs(self._chapterInfos) do
		if self.m_chapterArr[iter_10_0] then
			self.m_chapterArr[iter_10_0]:updateData(iter_10_1, self._themeValue)
		end
	end
end

function ThemeBioChapterChooseLayer:_onPlayEnterAtPass()
	for iter_11_0, iter_11_1 in ipairs(self._chapterInfos) do
		if self.m_chapterArr[iter_11_0] then
			self.m_chapterArr[iter_11_0]:checkPlayedPassEffect()
		end
	end
end

function ThemeBioChapterChooseLayer:_onClickClose()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_THEME_BIO_EXIT_CHAPTER_CHOOSE_LAYER, true, {})
	self.m_backTransition:play(handler(self, function()
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end))
end

return ThemeBioChapterChooseLayer
