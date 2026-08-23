local CommonThemeBioChapterComp = class("CommonThemeBioChapterComp", require("app.fairyGUI.themeBio.UI_BrownThemeBioChapterComp"))
local ThemeBioConst = require("app.view.module.themeBio.const.ThemeBioConst")
local var_0_2 = g.core.model.User.themeData
local var_0_3 = g.core.module.ModuleManager
local var_0_4 = g.core.const.ConstMgr.ThemeConst
local var_0_5 = {
	LOCK = "lock",
	PERFECT = "perfect",
	GOING = "going",
	PASS = "pass"
}

function CommonThemeBioChapterComp:ctor()
	self._info = nil
	self._chapterId = nil
	self._unlockMode = ThemeBioConst.BIO_CHAPTER_LOCK

	self:addClickListener(handler(self, self._onOpenBioMapClick))
end

function CommonThemeBioChapterComp:updateData(arg_2_1, arg_2_2)
	self._themeValue = arg_2_2

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
		var_2_1, var_2_2 = self:_checkUnlock(arg_2_1)
	end

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

function CommonThemeBioChapterComp:_changeAnimateMode(arg_3_1)
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

	self._unlockMode = arg_3_1
end

function CommonThemeBioChapterComp:playAnimateUnlock(arg_4_1)
	return
end

function CommonThemeBioChapterComp:_checkUnlock(arg_5_1)
	if not arg_5_1 then
		return
	end

	local var_5_0 = self._themeBioData:getThemeBioChapterStartTime(arg_5_1.number)
	local var_5_1 = g.core.common.ServerTime:getTime()

	if var_5_0 > 0 and var_5_1 < var_5_0 then
		local var_5_3 = math.ceil((var_5_0 - var_5_1) / 86400)
		local var_5_4 = var_5_3 > 1 and g.core.lang:get(409136, {
			num = var_5_3
		}) or g.core.lang:get(409137)

		return ThemeBioConst.BIO_CHAPTER_LOCK, "", (g.core.lang:get(409135))
	end

	if not arg_5_1.unlock then
		local var_5_5 = self._themeBioData:getChapter(self._chapterId)

		if var_5_5.preset > 0 then
			local var_5_6 = self._themeBioData:getChapter(var_5_5.preset)

			return ThemeBioConst.BIO_CHAPTER_BEFORE, g.core.lang:get(409138, {
				name = var_5_6.name
			}), (g.core.lang:get(409139, {
				name = var_5_6.name
			}))
		end
	end

	return ThemeBioConst.BIO_CHAPTER_UNLOCK
end

function CommonThemeBioChapterComp:_onOpenBioMapClick()
	local var_6_1 = g.core.model.User.activityDataManager:getShowActivityDataByCfg(var_0_4.THEME_TYPE, self._themeValue)

	if not ((var_6_1 and var_6_1:isOpen() or nil) and true) then
		var_0_3:tip(g.core.lang:get(1005))

		return
	end

	local var_6_2, var_6_3, var_6_4 = self:_checkUnlock(self._info)

	if var_6_2 == ThemeBioConst.BIO_CHAPTER_LOCK or var_6_2 == ThemeBioConst.BIO_CHAPTER_BEFORE then
		var_0_3:tip(var_6_4)

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

function CommonThemeBioChapterComp:checkPlayedPassEffect()
	if (self._unlockMode == ThemeBioConst.BIO_CHAPTER_PASSED or self._unlockMode == ThemeBioConst.BIO_CHAPTER_PERFECT) and not self._themeBioData:checkPlayedChapterPassEffect(self._chapterId, self._unlockMode) then
		self._themeBioData:setPlayedChapterPassEffect(self._chapterId, self._unlockMode)

		if self._unlockMode == ThemeBioConst.BIO_CHAPTER_PASSED then
			self.m_openStateController:setSelectedPage(var_0_5.PASS)

			if self:getTransition("pass") then
				self.m_passTransition:play()
			end
		elseif self._unlockMode == ThemeBioConst.BIO_CHAPTER_PERFECT then
			self.m_openStateController:setSelectedPage(var_0_5.PERFECT)

			if self:getTransition("perfect") then
				self.m_perfectTransition:play()
			end

			self.m_effPerfect:addEffectSpine({
				name = "eff_ui_themeBiochapter_perfect",
				isLoop = false,
				remove = true
			})
		end
	end
end

return CommonThemeBioChapterComp
