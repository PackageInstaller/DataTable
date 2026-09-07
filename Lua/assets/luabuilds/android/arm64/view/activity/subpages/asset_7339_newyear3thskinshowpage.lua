local NewYear3thSkinShowPage = class("NewYear3thSkinShowPage", import("...base.BaseActivityPage"))

function NewYear3thSkinShowPage:OnInit()
	self:findUI()
	self:initData()

	return
end

function NewYear3thSkinShowPage:findUI()
	self.paintBackTF = self._tf:Find("Paints/PaintBack")
	self.paintFrontTF = self._tf:Find("Paints/PaintFront")
	self.skinShopBtn = self._tf:Find("BtnShop")
	self.goBtn = self._tf:Find("BtnGO")

	onButton(self, self.skinShopBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

		return
	end, SFX_PANEL)
	onButton(self, self.goBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SPRING_TOWN)

		return
	end, SFX_PANEL)

	return
end

function NewYear3thSkinShowPage:initData()
	self.paintCount = 20
	self.curPaintIndex = 1
	self.paintSwitchTime = 1
	self.paintStaticTime = 3.5
	self.paintStaticCountValue = 0
	self.paintPathPrefix = "newyear3thskinshowpage/"
	self.paintNamePrefix = "NewYearSkin"

	return
end

function NewYear3thSkinShowPage:switchNextPaint()
	self.frameTimer:Stop()

	local var_6_0 = self.curPaintIndex % self.paintCount + 1

	setImageSprite(self.paintBackTF, LoadSprite(self.paintPathPrefix .. self.paintNamePrefix .. self.curPaintIndex % self.paintCount + 1, self.paintNamePrefix .. self.curPaintIndex % self.paintCount + 1))
	LeanTween.value(go(self.paintFrontTF), 1, 0, self.paintSwitchTime):setOnUpdate(System.Action_float(function(arg_7_0)
		setImageAlpha(self.paintFrontTF, arg_7_0)
		setImageAlpha(self.paintBackTF, 1 - arg_7_0)

		return
	end)):setOnComplete(System.Action(function()
		setImageFromImage(self.paintFrontTF, self.paintBackTF)
		setImageAlpha(self.paintFrontTF, 1)
		setImageAlpha(self.paintBackTF, 0)

		self.curPaintIndex = var_6_0

		self.frameTimer:Start()

		return
	end))

	return
end

function NewYear3thSkinShowPage:OnFirstFlush()
	self:initPaint()
	self:initTimer()

	return
end

function NewYear3thSkinShowPage:initPaint()
	setImageSprite(self.paintFrontTF, LoadSprite(self.paintPathPrefix .. self.paintNamePrefix .. self.curPaintIndex, self.paintNamePrefix .. self.curPaintIndex))
	setImageSprite(self.paintBackTF, LoadSprite(self.paintPathPrefix .. self.paintNamePrefix .. (self.curPaintIndex - 1) % self.paintCount + 1, self.paintNamePrefix .. (self.curPaintIndex - 1) % self.paintCount + 1))

	return
end

function NewYear3thSkinShowPage:initTimer()
	local var_11_0 = 0.016666666666666666

	self.paintStaticCountValue = 0
	self.frameTimer = Timer.New(function()
		self.paintStaticCountValue = self.paintStaticCountValue + var_11_0

		if self.paintStaticCountValue >= self.paintStaticTime then
			self.paintStaticCountValue = 0

			self:switchNextPaint()
		end

		return
	end, 0.016666666666666666, -1, false)

	self.frameTimer:Start()

	return
end

function NewYear3thSkinShowPage:OnDestroy()
	if self.frameTimer then
		self.frameTimer:Stop()

		self.frameTimer = nil
	end

	return
end

return NewYear3thSkinShowPage
