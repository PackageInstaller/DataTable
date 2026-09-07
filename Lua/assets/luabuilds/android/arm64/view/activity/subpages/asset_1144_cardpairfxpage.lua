local CardPairFXPage = class("CardPairFXPage", import("...base.BaseActivityPage"))

function CardPairFXPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.startBtn = self.bg:Find("StartBtn")
	self.slider = self.bg:Find("Slider")
	self.heartImg = self.slider:Find("Fill/Heart")
	self.gotImg = self.bg:Find("GotImg")

	return
end

function CardPairFXPage:OnDataSetting()
	return
end

function CardPairFXPage:OnFirstFlush()
	onButton(self, self.startBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CARD_PAIRS)

		return
	end, SFX_PANEL)

	return
end

function CardPairFXPage:OnUpdateFlush()
	local var_5_0 = self.activity.data1

	setActive(self.gotImg, self.activity.data1 == 1)
	setActive(self.heartImg, var_5_0 ~= 1)

	if self.activity.data2 >= 7 then
		setActive(self.heartImg, false)
	end

	setSlider(self.slider, 0, 7, self.activity.data2)

	return
end

return CardPairFXPage
