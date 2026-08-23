local var_0_0 = g.core.service.ServiceManager:getServiceByName("BioTeamInviteFloatService")
local StoryDarkCurtainLayer = class("StoryDarkCurtainLayer", require("app.fairyGUI.story.UI_StoryDarkCurtainLayer"), function()
	return fgui.GComponent:create({
		resName = "StoryDarkCurtainLayer",
		pkgName = "story",
		isFullScreen = true,
		pkgPath = "ui/story/story"
	}, ...)
end)

StoryDarkCurtainLayer.WAIT_TIME = 3

local TypeWriter = require("app.view.common.TypeWriter")

function StoryDarkCurtainLayer:ctor(arg_2_1)
	self._showTrans = tonumber(arg_2_1.showtrans) == 1
	self._useCenterLabel = tonumber(arg_2_1.usecenter) == 2

	if self._useCenterLabel then
		self._lblText = self.m_darkCurtainCenterTxt or self.m_darkCurtainTxt
	end

	self._lblText:setVisible(true)
	self.m_bgImg:setVisible(tonumber(arg_2_1.transparent) ~= 1)

	self._isLast = arg_2_1.islast

	local var_2_0

	if arg_2_1.soundpath and arg_2_1.soundpath ~= "" then
		self._soundPath = g.core.model.User.storyData:formatSoundPath(arg_2_1.soundpath, 0)
		var_2_0 = {
			label = self._lblText
		}
	end

	var_2_0.str = arg_2_1.str
	var_2_0.speed = arg_2_1.speed
	var_2_0.callback = handler(self, self.waitForEnd)
	self._typeWriter = TypeWriter.new(var_2_0)
	self._showCallback = arg_2_1.showcallback
	self._endCallback = arg_2_1.callback
	self._changeSkipStateCallBack = arg_2_1.changeSkipStateCallBack

	self:addClickListener(handler(self, self.onClick))
end

function StoryDarkCurtainLayer:onLoad()
	if var_0_0 and var_0_0.judgeIsRefuseBioInviteIfEnterModule then
		var_0_0:judgeIsRefuseBioInviteIfEnterModule()
	end

	if self._showTrans then
		self:getView():getTransition("show"):play()
		self:newScheduleOnce(handler(self, function()
			if self._typeWriter then
				self._typeWriter:start()
			end

			if self._soundPath then
				g.core.sound.SoundManager:playSound(self._soundPath)
			end

			self._writeStart = true
		end), 0.4)
	else
		if self._typeWriter then
			self._typeWriter:start()
		end

		if self._soundPath then
			g.core.sound.SoundManager:playSound(self._soundPath)
		end

		self._writeStart = true
	end

	if self._changeSkipStateCallBack then
		self._changeSkipStateCallBack(false)
	end
end

function StoryDarkCurtainLayer:onClick()
	if not self._writeStart then
		return
	end

	if self._typeWriter then
		self._typeWriter:finish()

		self._typeWriter = nil
	elseif not self._inFinish then
		self:finish()
	end
end

function StoryDarkCurtainLayer:waitForEnd()
	self._typeWriter = nil

	self.m_tipTxt:setVisible(true)
end

function StoryDarkCurtainLayer:finish()
	self._inFinish = true
	self._writeStart = false

	if self._delayHandler then
		self:cancelSchedule(self._delayHandler)

		self._delayHandler = nil
	end

	self.m_tipTxt:setVisible(false)

	if self._showCallback then
		self._showCallback()

		self._showCallback = nil
	end

	if not self._isLast then
		self:getView():getTransition("hide"):play(function()
			self:removeFromParent()

			if self._changeSkipStateCallBack then
				self._changeSkipStateCallBack(true)
			end

			if self._endCallback then
				self._endCallback()
			end
		end)
	else
		local var_7_0 = self._endCallback

		self:removeFromParent()

		if self._changeSkipStateCallBack then
			self._changeSkipStateCallBack(true)
		end

		if var_7_0 then
			var_7_0()
		end
	end
end

function StoryDarkCurtainLayer:onUnload()
	self._inFinish = false
	self._endCallback = nil

	if self._delayHandler then
		self:cancelSchedule(self._delayHandler)

		self._delayHandler = nil
	end

	if self._typeWriter then
		self._typeWriter:finish()

		self._typeWriter = nil
	end

	g.core.sound.SoundManager:stopSound(self._soundPath)
end

function StoryDarkCurtainLayer:doAutoAction()
	self:onClick()
end

return StoryDarkCurtainLayer
