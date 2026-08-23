local ThemeBioVoteChapterChooseLayer = class("ThemeBioVoteChapterChooseLayer", require("app.fairyGUI.themeBio.UI_ThemeBioVoteChapterChooseLayer"), function()
	return fgui.GComponent:create({
		resName = "ThemeBioVoteChapterChooseLayer",
		pkgPath = "ui/themeBio/themeBio",
		isFullScreen = true,
		pkgName = "themeBio"
	}, ...)
end)
local var_0_2 = g.core.const.ConstMgr.ThemeBioConst
local var_0_3 = 5
local var_0_4 = g.core.config.activity_theme_info
local var_0_6 = g.core.config.activity_theme_display_info
local var_0_7 = g.core.model.User.themeData

function ThemeBioVoteChapterChooseLayer:ctor(arg_2_1)
	self._activeThemeValue = arg_2_1 and arg_2_1.themeValue
	self._themeInfo = nil

	if self._activeThemeValue == 0 then
		return
	end

	self._themeInfo = var_0_4.get(self._activeThemeValue)
	self.m_chapterArr = {}
	self.m_buildingArr = {}
	self._chapterInfos = {}

	for iter_2_0 = 1, var_0_3 do
		self.m_chapterArr[iter_2_0] = self["m_chapterComp" .. iter_2_0]
	end

	for iter_2_1 = 1, var_0_3 do
		self.m_buildingArr[iter_2_1] = self["m_buildingComp" .. iter_2_1]

		if not self.m_buildingArr[iter_2_1] then
			break
		end

		self.m_buildingArr[iter_2_1]:setCtrlState("open", {
			index = 0
		})
	end

	local var_2_0 = var_0_7:getThemeData(self._activeThemeValue)

	self._themeBioData = var_2_0 and var_2_0:getThemeBioData()
	self._chapterInfos = {}

	if self._themeBioData then
		for iter_2_2 = 1, var_0_3 do
			if self._themeInfo["biography_id_" .. iter_2_2] > 0 then
				local var_2_1 = self._themeBioData:getChapter(self._themeInfo["biography_id_" .. iter_2_2])

				if var_2_1 then
					self._chapterInfos[#self._chapterInfos + 1] = var_2_1
				end
			end
		end
	end

	self:_initActivityMainUI()
	self.m_voteEntranceBtn:addClickListener(handler(self, self._onClickVoteEntry))
	self.m_topBar:setReturnCallBack(handler(self, self._onClickClose))
end

function ThemeBioVoteChapterChooseLayer:_refreshVoteBtn()
	local var_3_0 = self.m_voteEntranceBtn:isVisible()

	if not var_3_0 then
		var_3_0 = self:_needShowVoteEntry()

		self.m_voteEntranceBtn:setVisible(var_3_0)
	end

	if var_3_0 then
		local var_3_1 = false
		local var_3_2 = self._themeBioData:getVoteData()

		for iter_3_0 = 1, #var_3_2 do
			if self._themeBioData:hasFinishChapter(var_3_2[iter_3_0].chapterId) and self._themeBioData:isVoteOpen(var_3_2[iter_3_0].voteInfo.id) and not self._themeBioData:hasVoted(var_3_2[iter_3_0].voteInfo.id) then
				var_3_1 = true

				break
			end
		end

		self.m_voteEntranceBtn:updateVoteEntrance({
			state = var_3_1 and 1 or 0
		})
	end
end

function ThemeBioVoteChapterChooseLayer:_initActivityMainUI()
	self.m_bgIcon:setURL("bg/theme/bg_activity15_nyla_tuili.jpg")

	self._displayInfo = var_0_6.get(self._activeThemeValue)

	self.m_topBar:setResInfoById(self._displayInfo.biography_top_bar)
	self.m_topBar:setTitle(self._displayInfo.biography_name)
	self.m_voteEntranceBtn:setVisible(false)
end

function ThemeBioVoteChapterChooseLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_BIOGRAPHY_GETINFO, handler(self, self._onGetInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_BIOGRAPHY_VOTE_GETINFO, handler(self, self._onVoteGetInfo), self)

	if self._themeBioData then
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
			self:updatePageView()
		end

		if self._themeBioData:hasVoteActivity() then
			g.core.network.GameNetProxy:send_C2S_ThemeBiography_Vote_GetInfo({
				act_id = self._activeThemeValue
			})
		end

		g.core.network.GameNetProxy:send_C2S_Flush({
			theme_bio_item = true
		})
	end

	self.m_enterTransition:play()
	self:_onPlayEnterEffect()
	self:_addBgMusic()
end

function ThemeBioVoteChapterChooseLayer:_addBgMusic()
	local var_6_0

	for iter_6_0, iter_6_1 in ipairs(self._chapterInfos) do
		local var_6_1, var_6_2, var_6_3 = self._themeBioData:getChapterUnlockStateAndTip(iter_6_1)

		if var_6_1 == var_0_2.BIO_CHAPTER_UNLOCK then
			var_6_0 = iter_6_1.music
		else
			break
		end
	end

	if var_6_0 then
		g.core.sound.SoundManager:playMusic(var_6_0, true)
	end
end

function ThemeBioVoteChapterChooseLayer:_onGetInfo(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self:updatePageView()
end

function ThemeBioVoteChapterChooseLayer:_onVoteGetInfo(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self:_refreshVoteBtn()
	self:_checkJump2VoteLayer()
end

function ThemeBioVoteChapterChooseLayer:receiveCompEvent(arg_9_1, arg_9_2)
	arg_9_2 = arg_9_2 or {}
end

function ThemeBioVoteChapterChooseLayer:onUnload()
	g.core.sound.SoundManager:rewindMusic()
end

function ThemeBioVoteChapterChooseLayer:_updateChapterComp()
	return
end

function ThemeBioVoteChapterChooseLayer:_onClickVoteEntry()
	g.core.module.ModuleManager:pushModule(g.view.entrance.THEME_BIO_VOTE, {
		themeValue = self._activeThemeValue
	})
end

function ThemeBioVoteChapterChooseLayer:updatePageView()
	for iter_13_0, iter_13_1 in ipairs(self._chapterInfos) do
		if self.m_chapterArr[iter_13_0] then
			self.m_chapterArr[iter_13_0]:updateData(iter_13_1, self._activeThemeValue, iter_13_0)
		end
	end
end

function ThemeBioVoteChapterChooseLayer:_onPlayEnterEffect()
	for iter_14_0, iter_14_1 in ipairs(self._chapterInfos) do
		if self.m_chapterArr[iter_14_0] then
			self.m_chapterArr[iter_14_0]:checkPlayedPassEffect()
		end

		local var_14_0 = self.m_buildingArr[iter_14_0]

		if self.m_buildingArr[iter_14_0] then
			local var_14_1 = self._themeInfo["biography_id_" .. iter_14_0]
			local var_14_2 = self._themeBioData:getChapterUnlockStateAndTip((self._themeBioData:getChapter(self._themeInfo["biography_id_" .. iter_14_0])))
			local var_14_3 = var_14_2 ~= var_0_2.BIO_CHAPTER_LOCK and var_14_2 ~= var_0_2.BIO_CHAPTER_BEFORE

			var_14_0:setCtrlState("open", {
				index = var_14_2 ~= var_0_2.BIO_CHAPTER_LOCK and var_14_2 ~= var_0_2.BIO_CHAPTER_BEFORE and 1 or 0
			})

			if var_14_3 then
				self._themeBioData:setBioChapterRecordByType(var_14_1, "_BUILDING")
				var_14_0:playUnlockEffect()
			end
		end
	end

	self:_checkJump2VoteLayer()
end

function ThemeBioVoteChapterChooseLayer:_onClickClose()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_THEME_BIO_EXIT_CHAPTER_CHOOSE_LAYER, true, {})
	self.m_backTransition:play(handler(self, function()
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end))
end

function ThemeBioVoteChapterChooseLayer:_needShowVoteEntry()
	if not (self._themeBioData and self._themeBioData:hasVoteActivity() or false) then
		return
	end

	local var_17_0 = self._themeBioData:getVoteData()

	for iter_17_0 = 1, #var_17_0 do
		if self._themeBioData:hasFinishChapter(var_17_0[iter_17_0].chapterId) and self._themeBioData:isVoteOpen(var_17_0[iter_17_0].voteInfo.id) then
			return true
		end
	end

	return false
end

function ThemeBioVoteChapterChooseLayer:_checkJump2VoteLayer()
	if self._themeBioData:hasNewVoteResult() or self._themeBioData:needGotoLastVote() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.THEME_BIO_VOTE, {
			showResult = true,
			themeValue = self._activeThemeValue
		})
	end
end

return ThemeBioVoteChapterChooseLayer
