local ThemeAnubisBioVoteChapterChooseLayer = class("ThemeAnubisBioVoteChapterChooseLayer", require("app.fairyGUI.themeBio.UI_ThemeAnubisBioVoteChapterChooseLayer"), function()
	return fgui.GComponent:create({
		resName = "ThemeAnubisBioVoteChapterChooseLayer",
		pkgName = "themeBio",
		isFullScreen = true,
		pkgPath = "ui/themeBio/themeBio"
	}, ...)
end)
local var_0_2 = g.core.const.ConstMgr.ThemeBioConst
local var_0_3 = 5
local var_0_4 = g.core.config.activity_theme_info
local var_0_6 = g.core.config.activity_theme_display_info
local var_0_7 = g.core.model.User.themeData
local var_0_8 = g.core.module.ModuleManager

function ThemeAnubisBioVoteChapterChooseLayer:ctor(arg_2_1)
	self._activeThemeValue = arg_2_1 and arg_2_1.themeValue

	if self._activeThemeValue == 0 then
		return
	end

	self:_initData()
	self:_initActivityMainUI()
	self.m_voteEntranceBtn:addClickListener(handler(self, self._onClickVoteEntry))
	self.m_topBar:setReturnCallBack(handler(self, self._onClickClose))
end

function ThemeAnubisBioVoteChapterChooseLayer:_initData()
	self.m_chapterArr = {}
	self._chapterInfos = {}
	self._themeInfo = var_0_4.get(self._activeThemeValue)

	local var_3_0 = var_0_7:getThemeData(self._activeThemeValue)

	self._themeBioData = var_3_0 and var_3_0:getThemeBioData()

	if self._themeBioData then
		for iter_3_0 = 1, var_0_3 do
			if self._themeInfo["biography_id_" .. iter_3_0] > 0 then
				local var_3_1 = self._themeBioData:getChapter(self._themeInfo["biography_id_" .. iter_3_0])

				if var_3_1 then
					self._chapterInfos[#self._chapterInfos + 1] = var_3_1
				end
			end
		end
	end
end

function ThemeAnubisBioVoteChapterChooseLayer:_initActivityMainUI()
	self.m_bgIcon:setURL("bg/theme/bg_activity21_anubis_tuili.jpg")

	self._displayInfo = var_0_6.get(self._activeThemeValue)

	self.m_topBar:setResInfoById(self._displayInfo.biography_top_bar)
	self.m_topBar:setTitle(self._displayInfo.biography_name)
	self.m_voteEntranceBtn:setVisible(false)
	self.m_curChapterController:setSelectedIndex(0)
end

function ThemeAnubisBioVoteChapterChooseLayer:_refreshVoteBtn()
	local var_5_0 = self.m_voteEntranceBtn:isVisible()

	if not var_5_0 then
		var_5_0 = self:_needShowVoteEntry()

		self.m_voteEntranceBtn:setVisible(var_5_0)
	end

	if var_5_0 then
		local var_5_1 = false
		local var_5_2 = self._themeBioData:getVoteData()

		for iter_5_0 = 1, #var_5_2 do
			if self._themeBioData:hasFinishChapter(var_5_2[iter_5_0].chapterId) and self._themeBioData:isVoteOpen(var_5_2[iter_5_0].voteInfo.id) and not self._themeBioData:hasVoted(var_5_2[iter_5_0].voteInfo.id) then
				var_5_1 = true

				break
			end
		end

		self.m_voteEntranceBtn:updateVoteEntrance({
			state = var_5_1 and 1 or 0
		})
	end
end

function ThemeAnubisBioVoteChapterChooseLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_BIOGRAPHY_GETINFO, handler(self, self._onGetInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_BIOGRAPHY_VOTE_GETINFO, handler(self, self._onVoteGetInfo), self)

	if not self._themeBioData then
		return
	end

	if not self._themeBioData:isInited() then
		g.core.network.GameNetProxy:send_C2S_ThemeBiography_GetInfo({
			act_id = self._activeThemeValue
		})
	elseif self._themeBioData:isExpired() then
		self._themeBioData:resetExpired()
		g.core.network.GameNetProxy:send_C2S_ThemeBiography_GetInfo({
			act_id = self._activeThemeValue
		})
	else
		self.m_chapterComp:updatePageView(self._chapterInfos)
	end

	if self._themeBioData:hasVoteActivity() then
		g.core.network.GameNetProxy:send_C2S_ThemeBiography_Vote_GetInfo({
			act_id = self._activeThemeValue
		})
	end

	g.core.network.GameNetProxy:send_C2S_Flush({
		theme_bio_item = true
	})
	self.m_enterTransition:play()
	self:_onPlayEnterEffect()
end

function ThemeAnubisBioVoteChapterChooseLayer:onUnload()
	self.m_backTransition:play()
end

function ThemeAnubisBioVoteChapterChooseLayer:_addBgMusic()
	local var_8_0

	for iter_8_0, iter_8_1 in ipairs(self._chapterInfos) do
		local var_8_1, var_8_2, var_8_3 = self._themeBioData:getChapterUnlockStateAndTip(iter_8_1)

		if var_8_1 == var_0_2.BIO_CHAPTER_UNLOCK then
			var_8_0 = iter_8_1.music
		else
			break
		end
	end

	if var_8_0 then
		g.core.sound.SoundManager:playMusic(var_8_0, true)
	end
end

function ThemeAnubisBioVoteChapterChooseLayer:_onGetInfo(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self.m_chapterComp:updatePageView(self._chapterInfos)
end

function ThemeAnubisBioVoteChapterChooseLayer:_onVoteGetInfo(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self:_refreshVoteBtn()
	self:_checkJump2VoteLayer()
end

function ThemeAnubisBioVoteChapterChooseLayer:_onClickVoteEntry()
	var_0_8:pushModule(g.view.entrance.THEME_BIO_VOTE, {
		themeValue = self._activeThemeValue
	})
end

function ThemeAnubisBioVoteChapterChooseLayer:_onPlayEnterEffect()
	self.m_chapterComp:playEnterEffect(self._chapterInfos)
	self:_checkJump2VoteLayer()
end

function ThemeAnubisBioVoteChapterChooseLayer:_onClickClose()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_THEME_BIO_EXIT_CHAPTER_CHOOSE_LAYER, true, {})
	self.m_backTransition:play(handler(self, function()
		var_0_8:onlyPopSelfByDisplay(self)
	end))
end

function ThemeAnubisBioVoteChapterChooseLayer:_needShowVoteEntry()
	if not (self._themeBioData and self._themeBioData:hasVoteActivity() or false) then
		return
	end

	local var_15_0 = self._themeBioData:getVoteData()

	for iter_15_0 = 1, #var_15_0 do
		if self._themeBioData:hasFinishChapter(var_15_0[iter_15_0].chapterId) and self._themeBioData:isVoteOpen(var_15_0[iter_15_0].voteInfo.id) then
			return true
		end
	end

	return false
end

function ThemeAnubisBioVoteChapterChooseLayer:_checkJump2VoteLayer()
	if self._themeBioData:hasNewVoteResult() or self._themeBioData:needGotoLastVote() then
		var_0_8:pushModule(g.view.entrance.THEME_BIO_VOTE, {
			showResult = true,
			themeValue = self._activeThemeValue
		})
	end
end

function ThemeAnubisBioVoteChapterChooseLayer:receiveCompEvent(arg_17_1, arg_17_2)
	if arg_17_1 == "new_chapter_start" then
		local var_17_0 = arg_17_2.chapterIndex or 0

		self.m_curChapterController:setSelectedIndex(var_17_0)

		if arg_17_2 and not arg_17_2.clearEffect then
			self.m_chapterComp:playUnlockEffect(var_17_0)
		end
	end
end

return ThemeAnubisBioVoteChapterChooseLayer
