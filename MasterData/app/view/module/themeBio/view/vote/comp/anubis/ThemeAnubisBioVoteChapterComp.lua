local ThemeAnubisBioVoteChapterComp = class("ThemeAnubisBioVoteChapterComp", require("app.fairyGUI.themeBio.UI_ThemeAnubisBioVoteChapterComp"))
local ThemeBioConst = require("app.view.module.themeBio.const.ThemeBioConst")
local var_0_2 = g.core.model.User.themeData
local var_0_3 = g.core.module.ModuleManager
local var_0_4 = g.core.const.ConstMgr.ThemeConst
local var_0_5 = {
	GOING = "going",
	LOCK = "lock",
	PERFECT = "perfect",
	PASS = "pass"
}

function ThemeAnubisBioVoteChapterComp:ctor()
	self._info = nil
	self._chapterId = nil
	self._unlockMode = ThemeBioConst.BIO_CHAPTER_LOCK
	self._chapterIndex = 0

	self:addClickListener(handler(self, self._onClickSelf))
end

function ThemeAnubisBioVoteChapterComp:updateData(arg_2_1, arg_2_2, arg_2_3)
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
	local var_2_2

	if arg_2_1.finish then
		var_2_1 = arg_2_1.perfect and ThemeBioConst.BIO_CHAPTER_PERFECT or ThemeBioConst.BIO_CHAPTER_PASSED
	else
		var_2_1, var_2_2 = self._themeBioData:getChapterUnlockStateAndTip(arg_2_1)
	end

	self._unlockMode = var_2_1

	if var_2_1 == ThemeBioConst.BIO_CHAPTER_LOCK or var_2_1 == ThemeBioConst.BIO_CHAPTER_BEFORE then
		self.m_lockTxt:setText(var_2_2)
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

function ThemeAnubisBioVoteChapterComp:_changeAnimateMode(arg_3_1)
	self:stopAllFGActions()

	if arg_3_1 == ThemeBioConst.BIO_CHAPTER_UNLOCK then
		self.m_openStateController:setSelectedPage(var_0_5.GOING)
	elseif arg_3_1 == ThemeBioConst.BIO_CHAPTER_PASSED then
		if not self._themeBioData:checkPlayedChapterPassEffect(self._chapterId, arg_3_1) then
			self.m_openStateController:setSelectedPage(var_0_5.GOING)
		else
			self.m_openStateController:setSelectedPage(var_0_5.PASS)
		end
	elseif arg_3_1 == ThemeBioConst.BIO_CHAPTER_PERFECT then
		if not self._themeBioData:checkPlayedChapterPassEffect(self._chapterId, arg_3_1) then
			self.m_openStateController:setSelectedPage(var_0_5.GOING)
		else
			self.m_openStateController:setSelectedPage(var_0_5.PERFECT)
		end
	else
		self.m_openStateController:setSelectedPage(var_0_5.LOCK)
	end

	if arg_3_1 ~= ThemeBioConst.BIO_CHAPTER_LOCK and arg_3_1 ~= ThemeBioConst.BIO_CHAPTER_BEFORE then
		-- block empty
	end
end

function ThemeAnubisBioVoteChapterComp:getChapterUnlockStatus()
	return self._unlockMode
end

function ThemeAnubisBioVoteChapterComp:getChapterFinishStatus()
	return self._themeBioData:isHaveFinishMission(self._chapterId)
end

function ThemeAnubisBioVoteChapterComp:checkPlayedPassEffect()
	if self._unlockMode ~= ThemeBioConst.BIO_CHAPTER_PASSED then
		if self._unlockMode == ThemeBioConst.BIO_CHAPTER_PERFECT then
			local var_6_0 = self._themeBioData:checkPlayedChapterPassEffect(self._chapterId, 2)

			if not self._themeBioData:checkPlayedChapterPassEffect(self._chapterId, self._unlockMode) then
				self._themeBioData:setPlayedChapterPassEffect(self._chapterId, self._unlockMode)

				if self._unlockMode == ThemeBioConst.BIO_CHAPTER_PASSED then
					self.m_openStateController:setSelectedPage(var_0_5.PASS)
					self.m_effPerfect:addEffectSpine({
						anim = "pass",
						name = "eff_ui_themeAnubisBio_Pass",
						remove = true,
						isLoop = false
					})
				elseif self._unlockMode == ThemeBioConst.BIO_CHAPTER_PERFECT then
					self.m_openStateController:setSelectedPage(var_0_5.PERFECT)
					self.m_effPerfect:addEffectSpine({
						anim = "perfect",
						name = "eff_ui_themeAnubisBio_Pass",
						remove = true,
						isLoop = false
					})
				end

				self.m_passPerfectTransition:play()
				self:dispatchCompEvent("new_chapter_start", {
					chapterIndex = self._chapterIndex,
					clearEffect = var_6_0
				})
			end
		end
	end
end

function ThemeAnubisBioVoteChapterComp:_onClickSelf()
	local var_7_0 = g.core.model.User.activityDataManager:getShowActivityDataByCfg(var_0_4.THEME_TYPE, self._themeValue)

	if not var_7_0 or not var_7_0:isOpen() then
		var_0_3:tip(g.core.lang:get(1005))

		return
	end

	local var_7_1, var_7_2, var_7_3 = self._themeBioData:getChapterUnlockStateAndTip(self._info)

	if var_7_1 == ThemeBioConst.BIO_CHAPTER_LOCK or var_7_1 == ThemeBioConst.BIO_CHAPTER_BEFORE then
		self._unlockMode = var_7_1

		var_0_3:tip(var_7_3)

		return
	end

	self._themeBioData:setBioChapterNewSettingRecord(self._chapterId)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			id = self._chapterId
		}
	})

	if self._chapterIdIndex == 1 then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.MUSIC_ANUBIS_CHAPTER_1)
	else
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.MUSIC_ANUBIS_NEW_CHAPTER)
	end

	var_0_3:pushModule(g.view.entrance.THEME_BIO_STAGE, {
		themeValue = self._themeValue,
		chapterId = self._chapterId
	})
end

function ThemeAnubisBioVoteChapterComp:playUnlockEnterEffect()
	if self._chapterIndex == 0 then
		return
	end

	self.m_enterTransition:play()
	self.m_effLock:addEffectSpine({
		anim = "play",
		name = "eff_ui_themeBio_chapter",
		remove = true,
		isLoop = false
	})
end

return ThemeAnubisBioVoteChapterComp
