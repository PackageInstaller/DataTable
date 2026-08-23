local ThemeBioVoteChapterComp = class("ThemeBioVoteChapterComp", require("app.fairyGUI.themeBio.UI_ThemeBioVoteChapterComp"))
local ThemeBioConst = require("app.view.module.themeBio.const.ThemeBioConst")
local var_0_2 = g.core.model.User.themeData
local var_0_3 = g.core.module.ModuleManager
local var_0_4 = g.core.const.ConstMgr.ThemeConst
local var_0_6 = {
	PERFECT = "perfect",
	LOCK = "lock",
	PASS = "pass",
	GOING = "going"
}

function ThemeBioVoteChapterComp:ctor()
	self._info = nil
	self._chapterId = nil
	self._unlockMode = ThemeBioConst.BIO_CHAPTER_LOCK
	self._chapterIndex = 0

	self:addClickListener(handler(self, self._onClickSelf))
end

function ThemeBioVoteChapterComp:updateData(arg_2_1, arg_2_2, arg_2_3)
	self._themeValue = arg_2_2
	self._chapterIndex = arg_2_3

	if not arg_2_1 then
		return
	end

	local var_2_0 = var_0_2:getThemeData(self._themeValue)

	self._themeBioData = var_2_0 and var_2_0:getThemeBioData()
	self._info = arg_2_1
	self._chapterId = arg_2_1.id

	self.m_name:setText(arg_2_1.name)

	local var_2_1 = 0

	if arg_2_1.finish then
		var_2_1 = arg_2_1.perfect and ThemeBioConst.BIO_CHAPTER_PERFECT or ThemeBioConst.BIO_CHAPTER_PASSED
	else
		local var_2_3

		var_2_1, var_2_3 = self._themeBioData:getChapterUnlockStateAndTip(arg_2_1)
	end

	self:_changeAnimateMode(var_2_1)
	self.m_redPointComp:setId(398)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			themeValue = self._themeValue,
			ids = {
				self._chapterId
			}
		}
	})
end

function ThemeBioVoteChapterComp:_changeAnimateMode(arg_3_1)
	self:stopAllFGActions()

	if arg_3_1 == ThemeBioConst.BIO_CHAPTER_UNLOCK then
		self.m_openStateController:setSelectedPage(var_0_6.GOING)
	elseif arg_3_1 == ThemeBioConst.BIO_CHAPTER_PASSED then
		if not self._themeBioData:checkPlayedChapterPassEffect(self._chapterId, arg_3_1) then
			self.m_openStateController:setSelectedPage(var_0_6.GOING)
		else
			self.m_openStateController:setSelectedPage(var_0_6.PASS)
		end
	elseif arg_3_1 == ThemeBioConst.BIO_CHAPTER_PERFECT then
		if not self._themeBioData:checkPlayedChapterPassEffect(self._chapterId, arg_3_1) then
			self.m_openStateController:setSelectedPage(var_0_6.GOING)
		else
			self.m_openStateController:setSelectedPage(var_0_6.PERFECT)
		end
	else
		self.m_openStateController:setSelectedPage(var_0_6.LOCK)
	end

	if arg_3_1 ~= ThemeBioConst.BIO_CHAPTER_LOCK and arg_3_1 ~= ThemeBioConst.BIO_CHAPTER_BEFORE then
		self:_playUnlockEnterEffect()
	end

	self._unlockMode = arg_3_1
end

function ThemeBioVoteChapterComp:_onOpenBioMapClick()
	local var_4_1 = g.core.model.User.activityDataManager:getShowActivityDataByCfg(var_0_4.THEME_TYPE, self._themeValue)

	if not ((var_4_1 and var_4_1:isOpen() or nil) and true) then
		var_0_3:tip(g.core.lang:get(1005))

		return
	end

	local var_4_2, var_4_3, var_4_4 = self._themeBioData:getChapterUnlockStateAndTip(self._info)

	if var_4_2 == ThemeBioConst.BIO_CHAPTER_LOCK or var_4_2 == ThemeBioConst.BIO_CHAPTER_BEFORE then
		var_0_3:tip(var_4_4)

		return
	end

	self._themeBioData:setBioChapterNewSettingRecord(self._chapterId)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			id = self._chapterId
		}
	})
	var_0_3:pushModule(g.view.entrance.THEME_BIO_STAGE, {
		themeValue = self._themeValue,
		chapterId = self._chapterId
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.CLICK_ENTER)
end

function ThemeBioVoteChapterComp:checkPlayedPassEffect()
	if (self._unlockMode == ThemeBioConst.BIO_CHAPTER_PASSED or self._unlockMode == ThemeBioConst.BIO_CHAPTER_PERFECT) and not self._themeBioData:checkPlayedChapterPassEffect(self._chapterId, self._unlockMode) then
		self._themeBioData:setPlayedChapterPassEffect(self._chapterId, self._unlockMode)

		if self._unlockMode == ThemeBioConst.BIO_CHAPTER_PASSED then
			self.m_openStateController:setSelectedPage(var_0_6.PASS)
		elseif self._unlockMode == ThemeBioConst.BIO_CHAPTER_PERFECT then
			self.m_openStateController:setSelectedPage(var_0_6.PERFECT)
		end

		self.m_effPerfect:addEffectSpine({
			anim = "pass",
			remove = true,
			isLoop = false,
			name = "eff_ui_themeBioVote_pass"
		})
		self.m_passPerfectTransition:play()
	end
end

function ThemeBioVoteChapterComp:onLoad()
	return
end

function ThemeBioVoteChapterComp:onUnload()
	return
end

function ThemeBioVoteChapterComp:updateView()
	return
end

function ThemeBioVoteChapterComp:_onClickSelf()
	local var_9_1 = g.core.model.User.activityDataManager:getShowActivityDataByCfg(var_0_4.THEME_TYPE, self._themeValue)

	if not ((var_9_1 and var_9_1:isOpen() or nil) and true) then
		var_0_3:tip(g.core.lang:get(1005))

		return
	end

	local var_9_2, var_9_3, var_9_4 = self._themeBioData:getChapterUnlockStateAndTip(self._info)

	if var_9_2 == ThemeBioConst.BIO_CHAPTER_LOCK or var_9_2 == ThemeBioConst.BIO_CHAPTER_BEFORE then
		var_0_3:tip(var_9_4)

		return
	end

	self._themeBioData:setBioChapterNewSettingRecord(self._chapterId)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			id = self._chapterId
		}
	})
	var_0_3:pushModule(g.view.entrance.THEME_BIO_STAGE, {
		themeValue = self._themeValue,
		chapterId = self._chapterId
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.CLICK_ENTER)
end

function ThemeBioVoteChapterComp:_playUnlockEnterEffect()
	if self._chapterIndex == 0 then
		return
	end

	self.m_enterTransition:play()
	self.m_effEnter:addEffectSpine({
		remove = true,
		isLoop = false,
		name = "eff_ui_themeBioVote_mainLayerEnter",
		anim = "play" .. self._chapterIndex
	})

	if self._chapterIndex == 1 then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_HJWH_Card)
	end
end

return ThemeBioVoteChapterComp
