local GuideUniteTokenMoviePop = class("GuideUniteTokenMoviePop", require("app.fairyGUI.guide.UI_GuideUniteTokenMoviePop"), function()
	return fgui.GComponent:create({
		resName = "GuideUniteTokenMoviePop",
		pkgName = "guide",
		pkgPath = "ui/guide/guide"
	}, ...)
end)

function GuideUniteTokenMoviePop:ctor()
	self._state = 0

	self:showAtCenter()
	self:setSize(display.width, display.height)
	self.m_touchPnl:addClickListener(handler(self, self._onClickActiveUniteToken))
	self:playMovie()
end

function GuideUniteTokenMoviePop:playMovie()
	self._state = 1

	self.m_spineHolder:addEffectSpine({
		isLoop = true,
		name = "50030awaken"
	})
	self.m_movieHolder:addCriSprite({
		movieName = "CjNvZhc_1334x750_6667",
		x = 0,
		isLoop = true,
		y = 0,
		fullScreenState = 2,
		moduleName = "create"
	})

	self._perLoadMovie = self.m_movie2Holder:addCriSprite({
		movieName = "50030awaken_1450x800_3000",
		x = 0,
		isLoop = false,
		y = 0,
		fullScreenState = 2,
		moduleName = "uniteToken",
		remove = true,
		listener = handler(self, self._onPlayFinish)
	})

	self._perLoadMovie:setVisible(false)
	self._perLoadMovie:pause(true)
end

function GuideUniteTokenMoviePop:_onClickActiveUniteToken()
	if self._state == 1 then
		self._state = 2

		self._perLoadMovie:setVisible(true)
		self._perLoadMovie:pause(false)
		self.m_spineHolder:setVisible(false)
	end
end

function GuideUniteTokenMoviePop:_onPlayFinish(arg_5_1)
	print("---------------->", arg_5_1)

	if arg_5_1 == "complete" then
		self:removeSelf()
	end
end

return GuideUniteTokenMoviePop
