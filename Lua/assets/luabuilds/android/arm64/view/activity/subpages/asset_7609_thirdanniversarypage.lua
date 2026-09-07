local ThirdAnniversaryPage = class("ThirdAnniversaryPage", import("...base.BaseActivityPage"))

function ThirdAnniversaryPage:OnInit()
	self:findUI()
	self:initData()

	return
end

function ThirdAnniversaryPage:findUI()
	self.paintBackTF = self._tf:Find("Paints/PaintBack")
	self.paintFrontTF = self._tf:Find("Paints/PaintFront")
	self.skinShopBtn = self._tf:Find("BtnShop")
	self.btnContainer = self._tf:Find("BtnList/Viewport/Content")
	self.btnList1 = {}

	for iter_2_0 = 0, self.btnContainer.childCount / 2 - 1 do
		self.btnList1[iter_2_0 + 1] = self.btnContainer:GetChild(iter_2_0)
	end

	self.btnList2 = {}

	for iter_2_1 = 7, 2 * (self.btnContainer.childCount / 2) - 1 do
		self.btnList2[#self.btnList2 + 1] = self.btnContainer:GetChild(iter_2_1)
	end

	self.gridLayoutGroupCom = GetComponent(self.btnContainer, "GridLayoutGroup")

	return
end

function ThirdAnniversaryPage:initData()
	self.paintCount = 14
	self.curPaintIndex = 1
	self.paintSwitchTime = 1
	self.paintStaticTime = 3.5
	self.paintStaticCountValue = 0
	self.paintPathPrefix = "thirdanniversarypage/"
	self.paintNamePrefix = "thirda"
	self.btnCount = self.btnContainer.childCount / 2
	self.btnSpeed = 50
	self.btnSizeX = self.gridLayoutGroupCom.cellSize.x
	self.btnMarginX = self.gridLayoutGroupCom.spacing.x
	self.moveLength = self.btnCount * (self.btnSizeX + self.btnMarginX)
	self.startAnchoredPosX = self.btnContainer.anchoredPosition.x

	return
end

function ThirdAnniversaryPage:switchNextPaint()
	self.frameTimer:Stop()

	local var_4_0 = self.curPaintIndex % self.paintCount + 1

	setImageSprite(self.paintBackTF, LoadSprite(self.paintPathPrefix .. self.paintNamePrefix .. self.curPaintIndex % self.paintCount + 1, self.paintNamePrefix .. self.curPaintIndex % self.paintCount + 1))
	LeanTween.value(go(self.paintFrontTF), 1, 0, self.paintSwitchTime):setOnUpdate(System.Action_float(function(arg_5_0)
		setImageAlpha(self.paintFrontTF, arg_5_0)
		setImageAlpha(self.paintBackTF, 1 - arg_5_0)

		return
	end)):setOnComplete(System.Action(function()
		setImageFromImage(self.paintFrontTF, self.paintBackTF)
		setImageAlpha(self.paintFrontTF, 1)
		setImageAlpha(self.paintBackTF, 0)

		self.curPaintIndex = var_4_0

		self.frameTimer:Start()

		return
	end))

	return
end

function ThirdAnniversaryPage:OnFirstFlush()
	self:initPaint()
	self:initBtnList(self.btnList1)
	self:initBtnList(self.btnList2)
	self:initTimer()

	return
end

function ThirdAnniversaryPage:initPaint()
	setImageSprite(self.paintFrontTF, LoadSprite(self.paintPathPrefix .. self.paintNamePrefix .. self.curPaintIndex, self.paintNamePrefix .. self.curPaintIndex))
	setImageSprite(self.paintBackTF, LoadSprite(self.paintPathPrefix .. self.paintNamePrefix .. (self.curPaintIndex - 1) % self.paintCount + 1, self.paintNamePrefix .. (self.curPaintIndex - 1) % self.paintCount + 1))

	return
end

function ThirdAnniversaryPage:initBtnList(arg_9_1)
	onButton(self, arg_9_1[1], function()
		self:emit(ActivityMediator.GO_PRAY_POOL)

		return
	end, SFX_PANEL)
	onButton(self, arg_9_1[2], function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SUMMARY)

		return
	end, SFX_PANEL)
	onButton(self, arg_9_1[3], function()
		self:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.ACTIVITY_TYPE_RETURN_AWARD_ID3)

		return
	end, SFX_PANEL)
	onButton(self, arg_9_1[4], function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CHARGE, {
			wrap = ChargeScene.TYPE_DIAMOND
		})

		return
	end, SFX_PANEL)
	onButton(self, arg_9_1[5], function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.THIRD_ANNIVERSARY_AKIBA)

		return
	end, SFX_PANEL)
	onButton(self, arg_9_1[6], function()
		self:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.PIZZAHUT_PT_PAGE)

		return
	end, SFX_PANEL)
	onButton(self, arg_9_1[7], function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

		return
	end, SFX_PANEL)

	return
end

function ThirdAnniversaryPage:initTimer()
	local var_17_0 = 0.016666666666666666

	self.paintStaticCountValue = 0
	self.frameTimer = Timer.New(function()
		self.paintStaticCountValue = self.paintStaticCountValue + var_17_0

		if self.paintStaticCountValue >= self.paintStaticTime then
			self.paintStaticCountValue = 0

			self:switchNextPaint()
		end

		return
	end, 0.016666666666666666, -1, false)

	self.frameTimer:Start()

	self.frameTimer2 = Timer.New(function()
		self.btnContainer.anchoredPosition = Vector3((self.startAnchoredPosX - (self.btnContainer.anchoredPosition.x - self.btnSpeed * var_17_0) >= self.moveLength or nil) and self.btnContainer.anchoredPosition.x + self.moveLength, 0, 0)

		return
	end, 0.016666666666666666, -1, false)

	self.frameTimer2:Start()

	return
end

function ThirdAnniversaryPage:OnDestroy()
	if self.frameTimer then
		self.frameTimer:Stop()

		self.frameTimer = nil
	end

	if self.frameTimer2 then
		self.frameTimer2:Stop()

		self.frameTimer2 = nil
	end

	return
end

return ThirdAnniversaryPage
