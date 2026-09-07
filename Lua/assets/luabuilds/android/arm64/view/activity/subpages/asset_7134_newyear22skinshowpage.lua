local NewYear22SkinShowPage = class("NewYear22SkinShowPage", import("...base.BaseActivityPage"))
local var_0_1 = {
	{
		id = 403101,
		name = "Y22_adaerbote"
	},
	{
		id = 499061,
		name = "Y22_aogusite"
	},
	{
		id = 399051,
		name = "Y22_bailong"
	},
	{
		id = 405011,
		name = "Y22_bisimai"
	},
	{
		id = 108021,
		name = "Y22_daqinghuayu"
	},
	{
		id = 205091,
		name = "Y22_hao"
	},
	{
		id = 402041,
		name = "Y22_laibixi"
	},
	{
		id = 302211,
		name = "Y22_lei"
	},
	{
		id = 402061,
		name = "Y22_magedebao"
	},
	{
		id = 699011,
		name = "Y22_makeboluo"
	},
	{
		id = 202071,
		name = "Y22_nananpudun"
	},
	{
		id = 303141,
		name = "Y22_niaohai"
	},
	{
		id = 202291,
		name = "Y22_peineiluopo"
	},
	{
		id = 408021,
		name = "Y22_U47"
	},
	{
		id = 408121,
		name = "Y22_U1206"
	},
	{
		id = 405031,
		name = "Y22_wuerlixi"
	},
	{
		id = 401461,
		name = "Y22_Z46"
	},
	{
		id = 406021,
		name = "Y22_yibei"
	},
	{
		id = 201331,
		name = "Y22_yikaluosi"
	},
	{
		id = 205011,
		name = "Y22_yilishabai"
	}
}

function NewYear22SkinShowPage:OnInit()
	self:findUI()
	self:initData()

	return
end

function NewYear22SkinShowPage:findUI()
	self.paintBackTF = self._tf:Find("Paints/PaintBack")
	self.paintFrontTF = self._tf:Find("Paints/PaintFront")
	self.skinShopBtn = self._tf:Find("BtnShop")
	self.goBtn = self._tf:Find("BtnGO")

	onButton(self, self.skinShopBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

		return
	end, SFX_PANEL)
	onButton(self, self.goBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.NEWYEAR_BACKHILL_2022)

		return
	end, SFX_PANEL)

	return
end

function NewYear22SkinShowPage:initData()
	self.paintCount = 20
	self.curPaintIndex = 1
	self.paintSwitchTime = 1
	self.paintStaticTime = 3.5
	self.paintStaticCountValue = 0
	self.paintPathPrefix = "NewYear22SkinShowPage/"

	return
end

function NewYear22SkinShowPage:switchNextPaint()
	self.frameTimer:Stop()

	local var_6_0 = self.curPaintIndex % self.paintCount + 1
	local var_6_1 = pg.ship_data_statistics[var_0_1[self.curPaintIndex % self.paintCount + 1].id].name

	setImageSprite(self.paintBackTF, LoadSprite(self.paintPathPrefix .. var_0_1[self.curPaintIndex % self.paintCount + 1].name, var_0_1[self.curPaintIndex % self.paintCount + 1].name))
	setText(findTF(self.paintBackTF, "txt"), pg.ship_data_statistics[var_0_1[self.curPaintIndex % self.paintCount + 1].id].name)
	setText(findTF(self.paintBackTF, "outlineTxt"), pg.ship_data_statistics[var_0_1[self.curPaintIndex % self.paintCount + 1].id].name)

	local var_6_2 = GetComponent(self.paintFrontTF, typeof(CanvasGroup))
	local var_6_3 = GetComponent(self.paintBackTF, typeof(CanvasGroup))

	LeanTween.value(go(self.paintFrontTF), 1, 0, self.paintSwitchTime):setOnUpdate(System.Action_float(function(arg_7_0)
		var_6_2.alpha = arg_7_0
		var_6_3.alpha = 1 - arg_7_0

		return
	end)):setOnComplete(System.Action(function()
		setImageFromImage(self.paintFrontTF, self.paintBackTF)

		var_6_2.alpha = 1
		var_6_3.alpha = 0

		setText(findTF(self.paintFrontTF, "txt"), var_6_1)
		setText(findTF(self.paintFrontTF, "outlineTxt"), var_6_1)

		self.curPaintIndex = var_6_0

		self.frameTimer:Start()

		return
	end))

	return
end

function NewYear22SkinShowPage:OnFirstFlush()
	self:initPaint()
	self:initTimer()

	return
end

function NewYear22SkinShowPage:initPaint()
	setImageSprite(self.paintFrontTF, LoadSprite(self.paintPathPrefix .. var_0_1[self.curPaintIndex].name, var_0_1[self.curPaintIndex].name))
	setText(findTF(self.paintFrontTF, "txt"), pg.ship_data_statistics[var_0_1[(self.curPaintIndex - 1) % self.paintCount + 1].id].name)
	setText(findTF(self.paintFrontTF, "outlineTxt"), pg.ship_data_statistics[var_0_1[(self.curPaintIndex - 1) % self.paintCount + 1].id].name)
	setImageSprite(self.paintBackTF, LoadSprite(self.paintPathPrefix .. var_0_1[(self.curPaintIndex - 1) % self.paintCount + 1].name, var_0_1[(self.curPaintIndex - 1) % self.paintCount + 1].name))
	setText(findTF(self.paintBackTF, "txt"), pg.ship_data_statistics[var_0_1[(self.curPaintIndex - 1) % self.paintCount + 1].id].name)
	setText(findTF(self.paintBackTF, "outlineTxt"), pg.ship_data_statistics[var_0_1[(self.curPaintIndex - 1) % self.paintCount + 1].id].name)

	return
end

function NewYear22SkinShowPage:initTimer()
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

function NewYear22SkinShowPage:OnDestroy()
	if self.frameTimer then
		self.frameTimer:Stop()

		self.frameTimer = nil
	end

	return
end

return NewYear22SkinShowPage
