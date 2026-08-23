local RecruitSuccubaMoviePop = class("RecruitSuccubaMoviePop", require("app.fairyGUI.recruitSuccuba.UI_RecruitSuccubaMoviePop"), function()
	return fgui.GComponent:create({
		isFullScreen = false,
		pkgPath = "ui/recruitSuccuba/recruitSuccuba",
		resName = "RecruitSuccubaMoviePop",
		pkgName = "recruitSuccuba"
	}, ...)
end)

function RecruitSuccubaMoviePop:ctor(arg_2_1)
	self:showAtCenter()
	self.m_skipBtn:addClickListener(handler(self, self._onClick))

	self._cb = arg_2_1.cb

	self.m_movieHolder:addCriSprite({
		movieName = "succubaRecruitR_1334x750_4433",
		y = 0,
		fullScreenState = 2,
		remove = true,
		moduleName = "recruit",
		x = 0,
		isLoop = false,
		listener = handler(self, self._onPlayFinish)
	})
	self.m_skipBtn:setVisible(not g.core.model.User.recruitData:isNewPlayer())
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_MagicBookOpen)
end

function RecruitSuccubaMoviePop:_onClick()
	self.m_skipBtn:setVisible(false)

	if self._cb then
		self._cb()
	end

	self:removeSelf()
end

function RecruitSuccubaMoviePop:_onPlayFinish(arg_4_1)
	if arg_4_1 == "complete" then
		self.m_skipBtn:setVisible(false)

		if self._cb then
			self._cb()
		end

		self:removeSelf()
	end
end

function RecruitSuccubaMoviePop:onRemoved()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_MagicBookOpen_Stop)
end

return RecruitSuccubaMoviePop
