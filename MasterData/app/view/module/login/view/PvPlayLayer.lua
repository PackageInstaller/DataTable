local PvPlayLayer = class("PvPlayLayer", require("app.fairyGUI.login.UI_PvPlayLayer"), function()
	return fgui.GComponent:create({
		resName = "PvPlayLayer",
		pkgPath = "ui/login/login",
		isFullScreen = true,
		pkgName = "login"
	}, ...)
end)

function PvPlayLayer:ctor(arg_2_1)
	self._pvName = arg_2_1.pvName or ""
	self._zimuName = arg_2_1.zimuName or ""
	self._bgSoundName = arg_2_1.bgPVSound
	self._saveLocalName = arg_2_1.localName or ""
	self._hideTime = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.PV_HIDE_JUMP_BTN_TIME).parameter

	self.m_skipBtn:setVisible(false)
	self.m_skipBtn:addClickListener(handler(self, self._onSkipClicked))
	self.m_touchComp:addClickListener(handler(self, self._onPvLayerClick))

	if string.len(self._pvName) > 0 then
		if g.core.utils.Rule.isHideLoginPv() and self._pvName == "pv2new_1920x1080_92300" then
			self:newScheduleOnce(handler(self, self._onSkipClicked), 0.5)
		else
			self:playVideo()
			self:playZimuVideo()
		end
	end

	if string.len(self._saveLocalName) > 0 then
		g.core.common.Storage:save(self._saveLocalName .. ".json", {
			played = true
		}, false)
	end
end

function PvPlayLayer:_onPvLayerClick()
	self:cancelAllSchedule()
	self:onShowSkipBtn()
end

function PvPlayLayer:onShowSkipBtn()
	self.m_skipBtn:setOpacity(255)
	self.m_skipBtn:setVisible(true)
	self:newScheduleOnce(handler(self, self.onHideSkipBtn), self._hideTime)
end

function PvPlayLayer:onHideSkipBtn()
	self.m_skipBtn:runFGAction((fgui.FSequence:create(fgui.FFadeOut:create(0.5), (fgui.FCallFunc:create(function()
		self.m_skipBtn:setVisible(false)
	end)))))
end

function PvPlayLayer:playVideo()
	g.core.sound.SoundManager:pauseMusic()

	if self._bgSoundName then
		g.core.sound.SoundManager:playSound(self._bgSoundName)
	end

	self._movie = self.m_videoPlaceHolder:addCriSprite({
		x = 0,
		y = 0,
		moduleName = "pv",
		fullScreenState = -1,
		movieName = self._pvName,
		listener = handler(self, self._onVideoCallBack)
	})
end

function PvPlayLayer:playZimuVideo()
	local var_8_0

	if self._zimuName == "" then
		do return end

		var_8_0 = {
			autoRemove = false,
			zOrder = 10,
			y = 0,
			moduleName = "pv",
			x = 0,
			fullScreenState = -1
		}
	end

	var_8_0.movieName = self._zimuName
	self._zimuMovie = self.m_videoPlaceHolder:addCriSprite(var_8_0)
end

function PvPlayLayer:_onVideoCallBack(arg_9_1)
	if arg_9_1 == "complete" then
		self:_onVideoPlayEnd()
	end
end

function PvPlayLayer:_onSkipClicked()
	self:_onVideoPlayEnd()
end

function PvPlayLayer:_onVideoPlayEnd()
	if self._isClosed then
		return
	end

	self._isClosed = true

	if self._zimuMovie then
		self._zimuMovie:dispose()

		self._zimuMovie = nil
	end

	if self._movie then
		self._movie:dispose()

		self._movie = nil
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_ENTER_PLAY_TRANSITION, false, {
		toRight = false,
		callback = function()
			g.core.module.ModuleManager:popComponent()
		end
	})
end

function PvPlayLayer:onUnload()
	if self._bgSoundName then
		g.core.sound.SoundManager:switchPVCG2Music()

		self._bgSoundName = nil
	end

	g.core.sound.SoundManager:resumeMusic()
	self:cancelAllSchedule()
end

return PvPlayLayer
