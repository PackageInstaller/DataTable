local CardPairZQPage = class("CardPairZQPage", import("...base.BaseActivityPage"))

function CardPairZQPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.slider = self.bg:Find("slider")
	self.step = self.bg:Find("step")
	self.progress = self.bg:Find("progress")
	self.displayBtn = self.bg:Find("display_btn")
	self.battleBtn = self.bg:Find("battle_btn")
	self.getBtn = self.bg:Find("get_btn")
	self.gotBtn = self.bg:Find("got_btn")
	self.gotIcon = self.bg:Find("icon_got")
	self.maskList = self.bg:Find("maskList")

	return
end

function CardPairZQPage:OnDataSetting()
	local var_2_0 = self.activity:getConfig("config_data")[1]

	return
end

function CardPairZQPage:OnFirstFlush()
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CARD_PAIRS)

		return
	end, SFX_PANEL)

	return
end

function CardPairZQPage:OnUpdateFlush()
	local var_5_0 = self.activity.data2

	for iter_5_0 = 1, 7 do
		local var_5_1 = self.maskList:Find("mask" .. iter_5_0)

		setActive(var_5_1, iter_5_0 <= var_5_0)
		setActive(var_5_1:Find("frame"), var_5_0 <= iter_5_0)
	end

	setActive(self.gotIcon, var_5_0 >= 7)
	setSlider(self.slider, 0, 6, (var_5_0 - 1 >= 0 or nil) and (var_5_0 - 1 or 0))
	setActive(self.battleBtn, true)
	setActive(self.getBtn, false)
	setActive(self.gotBtn, false)

	return
end

return CardPairZQPage
