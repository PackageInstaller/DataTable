local FiveAnniversaryPage = class("FiveAnniversaryPage", import("...base.BaseActivityPage"))
local var_0_1 = 42
local var_0_2 = {}
local var_0_3 = 3.5
local var_0_4 = 1
local var_0_5 = 6
local var_0_6 = SCENE.BACKHILL_CAMPUSFESTIVAL_2022

function FiveAnniversaryPage:OnInit()
	self.hideIndex = {}
	self.scrollAble = false

	local var_1_0 = findTF(self._tf, "BtnList")

	var_0_2 = PLATFORM_CODE == PLATFORM_CH and {
		2,
		3,
		5,
		8
	} or PLATFORM_CODE == PLATFORM_CHT and {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10,
		11
	} or {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10
	}

	if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_CHT then
		self.hideIndex = {}
		self.scrollAble = true
		var_1_0.anchoredPosition = Vector2(-11, -20)
		var_1_0.sizeDelta = Vector2(1437, 90)
	elseif PLATFORM_CODE == PLATFORM_US then
		self.hideIndex = {
			1,
			2,
			5,
			6
		}
		self.scrollAble = false
		var_1_0.anchoredPosition = Vector2(678, -20)
		var_1_0.sizeDelta = Vector2(1186, 90)
	else
		self.hideIndex = {
			5,
			6
		}
		self.scrollAble = false
		var_1_0.anchoredPosition = Vector2(115, -20)
		var_1_0.sizeDelta = Vector2(1186, 90)
	end

	self:findUI()
	self:initData()

	return
end

function FiveAnniversaryPage:findUI()
	self.paintBackTF = self._tf:Find("Paints/PaintBack")
	self.paintFrontTF = self._tf:Find("Paints/PaintFront")
	self.skinShopBtn = self._tf:Find("BtnShop")
	self.btnContainer = self._tf:Find("BtnList/Viewport/Content")
	self.btnList1 = {}

	for iter_2_0 = 0, self.btnContainer.childCount / 3 - 1 do
		self.btnList1[iter_2_0 + 1] = self.btnContainer:GetChild(iter_2_0)
	end

	self.btnList2 = {}

	for iter_2_1 = self.btnContainer.childCount / 3, 2 * (self.btnContainer.childCount / 3) - 1 do
		self.btnList2[#self.btnList2 + 1] = self.btnContainer:GetChild(iter_2_1)
	end

	self.btnList3 = {}

	for iter_2_2 = self.btnContainer.childCount / 3 * 2, 3 * (self.btnContainer.childCount / 3) - 1 do
		self.btnList3[#self.btnList3 + 1] = self.btnContainer:GetChild(iter_2_2)
	end

	for iter_2_3 = 1, self.btnContainer.childCount / 3 * 3 do
		if table.contains(self.hideIndex, (iter_2_3 - 1) % var_0_5 + 1) or not self.scrollAble and iter_2_3 > var_0_5 then
			setActive(self.btnContainer:GetChild(iter_2_3 - 1), false)
		end
	end

	self.gridLayoutGroupCom = GetComponent(self.btnContainer, "GridLayoutGroup")

	return
end

function FiveAnniversaryPage:initData()
	self.paintCount = #var_0_2
	self.curPaintIndex = 1
	self.paintSwitchTime = var_0_4
	self.paintStaticTime = var_0_3
	self.paintStaticCountValue = 0
	self.paintPathPrefix = "clutter/"
	self.paintNamePrefix = "fivea"
	self.btnCount = self.btnContainer.childCount / 3
	self.btnSpeed = 50
	self.btnSizeX = self.gridLayoutGroupCom.cellSize.x
	self.btnMarginX = self.gridLayoutGroupCom.spacing.x
	self.moveLength = (self.btnCount - #self.hideIndex) * (self.btnSizeX + self.btnMarginX)
	self.startAnchoredPosX = self.btnContainer.anchoredPosition.x

	return
end

function FiveAnniversaryPage:switchNextPaint()
	self.frameTimer:Stop()

	local var_4_0 = self.curPaintIndex % self.paintCount + 1

	setImageSprite(self.paintBackTF, LoadSprite(self.paintPathPrefix .. self.paintNamePrefix .. var_0_2[self.curPaintIndex % self.paintCount + 1], self.paintNamePrefix .. var_0_2[self.curPaintIndex % self.paintCount + 1]))
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

function FiveAnniversaryPage:OnFirstFlush()
	onButton(self, self.skinShopBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	self:initPaint()
	self:initBtnList(self.btnList1)
	self:initBtnList(self.btnList2)
	self:initBtnList(self.btnList3)
	self:initTimer()

	return
end

function FiveAnniversaryPage:initPaint()
	setImageSprite(self.paintFrontTF, LoadSprite(self.paintPathPrefix .. self.paintNamePrefix .. var_0_2[(self.curPaintIndex - 1) % self.paintCount + 1], self.paintNamePrefix .. var_0_2[(self.curPaintIndex - 1) % self.paintCount + 1]))
	setImageSprite(self.paintBackTF, LoadSprite(self.paintPathPrefix .. self.paintNamePrefix .. var_0_2[(self.curPaintIndex - 1) % self.paintCount + 1], self.paintNamePrefix .. var_0_2[(self.curPaintIndex - 1) % self.paintCount + 1]))

	return
end

function FiveAnniversaryPage:initBtnList(arg_10_1)
	for iter_10_0 = 1, #arg_10_1 do
		self:initBtnEvent(arg_10_1[iter_10_0], iter_10_0)
	end

	return
end

function FiveAnniversaryPage:initBtnEvent(arg_11_1, arg_11_2)
	if arg_11_2 == 1 then
		onButton(self, arg_11_1, function()
			self:emit(ActivityMediator.GO_PRAY_POOL)

			return
		end, SFX_PANEL)
	elseif arg_11_2 == 2 then
		onButton(self, arg_11_1, function()
			if PLATFORM_CODE == PLATFORM_CHT then
				self:emit(ActivityMediator.SELECT_ACTIVITY, 41327)
			else
				self:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.ACTIVITY_TYPE_RETURN_AWARD_ID5)
			end

			return
		end, SFX_PANEL)
	elseif arg_11_2 == 3 then
		onButton(self, arg_11_1, function()
			if PLATFORM_CODE == PLATFORM_CHT then
				self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SIXTH_ANNIVERSARY_JP)
			else
				self:emit(ActivityMediator.EVENT_GO_SCENE, var_0_6)
			end

			return
		end, SFX_PANEL)
	elseif arg_11_2 == 4 then
		onButton(self, arg_11_1, function()
			if PLATFORM_CODE == PLATFORM_CHT then
				self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SIXTH_ANNIVERSARY_JP_DARK)
			else
				self:emit(ActivityMediator.GO_MINI_GAME, var_0_1)
			end

			return
		end, SFX_PANEL)
	elseif arg_11_2 == 5 then
		onButton(self, arg_11_1, function()
			self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SUMMARY)

			return
		end, SFX_PANEL)
	elseif arg_11_2 == 6 then
		onButton(self, arg_11_1, function()
			self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CHARGE, {
				wrap = ChargeScene.TYPE_DIAMOND
			})

			return
		end, SFX_PANEL)
	end

	return
end

function FiveAnniversaryPage:initTimer()
	local var_18_0 = 0.016666666666666666

	self.paintStaticCountValue = 0
	self.frameTimer = Timer.New(function()
		self.paintStaticCountValue = self.paintStaticCountValue + var_18_0

		if self.paintStaticCountValue >= self.paintStaticTime then
			self.paintStaticCountValue = 0

			self:switchNextPaint()
		end

		return
	end, 0.016666666666666666, -1, false)

	self.frameTimer:Start()

	if self.scrollAble then
		self.frameTimer2 = Timer.New(function()
			self.btnContainer.anchoredPosition = Vector3((self.startAnchoredPosX - (self.btnContainer.anchoredPosition.x - self.btnSpeed * var_18_0) >= self.moveLength or nil) and self.btnContainer.anchoredPosition.x + self.moveLength, 0, 0)

			return
		end, 0.016666666666666666, -1, false)

		self.frameTimer2:Start()
	end

	return
end

function FiveAnniversaryPage:OnDestroy()
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

return FiveAnniversaryPage
