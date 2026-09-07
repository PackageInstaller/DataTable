local Shrine2022ShipWordView = class("Shrine2022ShipWordView", import("...base.BaseSubView"))

function Shrine2022ShipWordView:getUIName()
	return "Shrine2022ShipWordUI"
end

function Shrine2022ShipWordView:OnInit()
	self:initData()
	self:initUI()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:Show()
	self:playEnterAni(true)

	return
end

function Shrine2022ShipWordView:OnDestroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	self:cleanManagedTween()

	return
end

function Shrine2022ShipWordView:setUIData()
	self.shipWordSpriteList = {}
	self.shipWordSpriteList[self.curSelectShip] = LoadSprite("Shrine2022/" .. "shipword_" .. self.curSelectShip, "shipword_" .. self.curSelectShip)

	return
end

function Shrine2022ShipWordView:initData()
	self.curSelectShip = self.contextData.curSelectShip

	return
end

function Shrine2022ShipWordView:initUI()
	self:setUIData()

	self.bg = self._tf:Find("BG")
	self.wordImg = self._tf:Find("Word")
	self.cloud1 = self._tf:Find("Cloud1")
	self.cloud2 = self._tf:Find("Cloud2")

	setImageSprite(self.wordImg, self.shipWordSpriteList[self.curSelectShip], true)
	onButton(self, self.bg, function()
		self:closeMySelf()

		return
	end, SFX_PANEL)

	return
end

function Shrine2022ShipWordView:playEnterAni(arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1 and 1000 or 0
	local var_8_1 = arg_8_1 and 0 or 1000
	local var_8_2 = {
		x = arg_8_1 and 1000 or 0,
		y = rtf(self.cloud1).anchoredPosition.y
	}
	local var_8_3 = arg_8_1 and -1000 or 0
	local var_8_4 = arg_8_1 and 0 or -1000
	local var_8_5 = {
		x = arg_8_1 and -1000 or 0,
		y = rtf(self.cloud2).anchoredPosition.y
	}
	local var_8_6 = arg_8_1 and 0 or 1
	local var_8_7 = arg_8_1 and 1 or 0
	local var_8_8 = {
		x = arg_8_1 and 0 or 1,
		y = arg_8_1 and 0 or 1
	}

	self.isPlaying = true

	setLocalScale(self.wordImg, {
		x = 0,
		y = 0
	})
	setActive(self.wordImg, true)
	self:managedTween(LeanTween.value, nil, go(self.cloud1), 0, 1, 0.3):setOnUpdate(System.Action_float(function(arg_9_0)
		var_8_2.x = var_8_0 + (var_8_1 - var_8_0) * arg_9_0

		setAnchoredPosition(self.cloud1, var_8_2)

		var_8_5.x = var_8_3 + (var_8_4 - var_8_3) * arg_9_0

		setAnchoredPosition(self.cloud2, var_8_5)

		var_8_8.x = var_8_6 + (var_8_7 - var_8_6) * arg_9_0
		var_8_8.y = var_8_6 + (var_8_7 - var_8_6) * arg_9_0

		setLocalScale(self.wordImg, var_8_8)

		return
	end)):setOnComplete(System.Action(function()
		self.isPlaying = false

		if arg_8_2 then
			arg_8_2()
		end

		return
	end))

	return
end

function Shrine2022ShipWordView:closeMySelf()
	if self.isPlaying then
		return
	end

	self:playEnterAni(false, function()
		self:Destroy()

		return
	end)

	return
end

return Shrine2022ShipWordView
