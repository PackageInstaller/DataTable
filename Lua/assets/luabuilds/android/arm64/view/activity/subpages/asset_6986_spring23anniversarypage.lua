local Spring23AnniversaryPage = class("Spring23AnniversaryPage", import("...base.BaseActivityPage"))
local var_0_1 = 42
local var_0_2 = {}
local var_0_3 = 3.5
local var_0_4 = 1
local var_0_5 = 6
local var_0_6 = SCENE.NEWYEAR_BACKHILL_2023
local var_0_7 = "spring23a"

function Spring23AnniversaryPage:OnInit()
	self.hideIndex = {}
	self.scrollAble = false

	local var_1_0 = findTF(self._tf, "BtnList")

	setActive(var_1_0, false)

	var_0_2 = PLATFORM_CODE == PLATFORM_CH and {
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
		11,
		12,
		13,
		14,
		15,
		16
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
		11,
		12,
		13,
		14,
		15,
		16
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
		10,
		11,
		12,
		13,
		14,
		15,
		16
	}

	if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_CHT then
		self.hideIndex = {}
		self.scrollAble = true
		var_1_0.anchoredPosition = Vector2(-11, -20)
		var_1_0.sizeDelta = Vector2(1437, 90)
	elseif PLATFORM_CODE == PLATFORM_US then
		self.hideIndex = {}
		self.scrollAble = false
		var_1_0.anchoredPosition = Vector2(678, -20)
		var_1_0.sizeDelta = Vector2(1186, 90)
	else
		self.hideIndex = {}
		self.scrollAble = false
		var_1_0.anchoredPosition = Vector2(115, -20)
		var_1_0.sizeDelta = Vector2(1186, 90)
	end

	self:findUI()

	return
end

function Spring23AnniversaryPage:findUI()
	self.paintBackTF = self._tf:Find("Paints/PaintBack")
	self.paintFrontTF = self._tf:Find("Paints/PaintFront")
	self.skinShopBtn = self._tf:Find("BtnShop")
	self.btnGo = self._tf:Find("BtnGo")
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

function Spring23AnniversaryPage:initData()
	self.displayDatas = self.activity:getConfig("config_client").display_link

	local var_3_0 = {}

	if self.displayDatas and #self.displayDatas then
		for iter_3_0 = 1, #self.displayDatas do
			if self.displayDatas[iter_3_0][2] and self.displayDatas[iter_3_0][2] ~= 0 then
				local var_3_1, var_3_2 = pg.TimeMgr.GetInstance():inTime(pg.shop_template[self.displayDatas[iter_3_0][2]].time)

				if not var_3_1 then
					table.insert(var_3_0, self.displayDatas[iter_3_0][1])
				end
			end
		end
	end

	if var_3_0 and #var_3_0 > 0 then
		for iter_3_1 = #var_0_2, 1, -1 do
			if table.contains(var_3_0, var_0_2[iter_3_1]) then
				table.remove(var_0_2, iter_3_1)
			end
		end
	end

	self.paintCount = #var_0_2
	self.curPaintIndex = math.random(1, #var_0_2)
	self.paintSwitchTime = var_0_4
	self.paintStaticTime = var_0_3
	self.paintStaticCountValue = 0
	self.paintPathPrefix = "clutter/"
	self.paintNamePrefix = var_0_7
	self.btnCount = self.btnContainer.childCount / 3
	self.btnSpeed = 50
	self.btnSizeX = self.gridLayoutGroupCom.cellSize.x
	self.btnMarginX = self.gridLayoutGroupCom.spacing.x
	self.moveLength = (self.btnCount - #self.hideIndex) * (self.btnSizeX + self.btnMarginX)
	self.startAnchoredPosX = self.btnContainer.anchoredPosition.x

	return
end

function Spring23AnniversaryPage:switchNextPaint()
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

function Spring23AnniversaryPage:OnFirstFlush()
	self:initData()
	onButton(self, self.skinShopBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	onButton(self, self.btnGo, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SPRING_FESTIVAL_BACKHILL_2023)

		return
	end)
	self:initPaint()
	self:initBtnList(self.btnList1)
	self:initBtnList(self.btnList2)
	self:initBtnList(self.btnList3)
	self:initTimer()

	return
end

function Spring23AnniversaryPage:initPaint()
	setImageSprite(self.paintFrontTF, LoadSprite(self.paintPathPrefix .. self.paintNamePrefix .. var_0_2[(self.curPaintIndex - 1) % self.paintCount + 1], self.paintNamePrefix .. var_0_2[(self.curPaintIndex - 1) % self.paintCount + 1]))
	setImageSprite(self.paintBackTF, LoadSprite(self.paintPathPrefix .. self.paintNamePrefix .. var_0_2[(self.curPaintIndex - 1) % self.paintCount + 1], self.paintNamePrefix .. var_0_2[(self.curPaintIndex - 1) % self.paintCount + 1]))

	return
end

function Spring23AnniversaryPage:initBtnList(arg_11_1)
	for iter_11_0 = 1, #arg_11_1 do
		self:initBtnEvent(arg_11_1[iter_11_0], iter_11_0)
	end

	return
end

function Spring23AnniversaryPage:initBtnEvent(arg_12_1, arg_12_2)
	if arg_12_2 == 1 then
		onButton(self, arg_12_1, function()
			self:emit(ActivityMediator.GO_PRAY_POOL)

			return
		end, SFX_PANEL)
	elseif arg_12_2 == 2 then
		onButton(self, arg_12_1, function()
			self:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.ACTIVITY_TYPE_RETURN_AWARD_ID5)

			return
		end, SFX_PANEL)
	elseif arg_12_2 == 3 then
		onButton(self, arg_12_1, function()
			self:emit(ActivityMediator.EVENT_GO_SCENE, var_0_6)

			return
		end, SFX_PANEL)
	elseif arg_12_2 == 4 then
		onButton(self, arg_12_1, function()
			self:emit(ActivityMediator.GO_MINI_GAME, var_0_1)

			return
		end, SFX_PANEL)
	elseif arg_12_2 == 5 then
		onButton(self, arg_12_1, function()
			self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SUMMARY)

			return
		end, SFX_PANEL)
	elseif arg_12_2 == 6 then
		onButton(self, arg_12_1, function()
			self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CHARGE, {
				wrap = ChargeScene.TYPE_DIAMOND
			})

			return
		end, SFX_PANEL)
	end

	return
end

function Spring23AnniversaryPage:initTimer()
	local var_19_0 = 0.016666666666666666

	self.paintStaticCountValue = 0
	self.frameTimer = Timer.New(function()
		self.paintStaticCountValue = self.paintStaticCountValue + var_19_0

		if self.paintStaticCountValue >= self.paintStaticTime then
			self.paintStaticCountValue = 0

			self:switchNextPaint()
		end

		return
	end, 0.016666666666666666, -1, false)

	self.frameTimer:Start()

	if self.scrollAble then
		self.frameTimer2 = Timer.New(function()
			self.btnContainer.anchoredPosition = Vector3((self.startAnchoredPosX - (self.btnContainer.anchoredPosition.x - self.btnSpeed * var_19_0) >= self.moveLength or nil) and self.btnContainer.anchoredPosition.x + self.moveLength, 0, 0)

			return
		end, 0.016666666666666666, -1, false)

		self.frameTimer2:Start()
	end

	return
end

function Spring23AnniversaryPage:OnDestroy()
	if LeanTween.isTweening(go(self.paintFrontTF)) then
		LeanTween.cancel(go(self.paintFrontTF))
	end

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

return Spring23AnniversaryPage
