local Shrine2022SelectBuffView = class("Shrine2022SelectBuffView", import("...base.BaseSubView"))

function Shrine2022SelectBuffView:getUIName()
	return "Shrine2022SelectBuffUI"
end

function Shrine2022SelectBuffView:OnInit()
	self:initData()
	self:initUI()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:Show()
	self:playEnterAni(true)

	return
end

function Shrine2022SelectBuffView:OnDestroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	self:cleanManagedTween()

	return
end

function Shrine2022SelectBuffView:initData()
	self.onSelectFunc = self.contextData.onSelect

	return
end

function Shrine2022SelectBuffView:initUI()
	self.bg = self._tf:Find("BG")
	self.cloud1 = self._tf:Find("Cloud1")
	self.cloud2 = self._tf:Find("Cloud2")
	self.buffListTF = self._tf:Find("BuffContainer")
	self.buffListCG = GetComponent(self.buffListTF, "CanvasGroup")

	for iter_5_0 = 1, 3 do
		onButton(self, self.buffListTF:GetChild(iter_5_0 - 1), function()
			if self.onSelectFunc then
				self.onSelectFunc(iter_5_0)
			end

			self:closeMySelf()

			return
		end, SFX_PANEL)
	end

	onButton(self, self.bg, function()
		self:closeMySelf()

		return
	end, SFX_CANCEL)

	return
end

function Shrine2022SelectBuffView:playEnterAni(arg_8_1, arg_8_2)
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

	self.isPlaying = true

	self:managedTween(LeanTween.value, nil, go(self.cloud1), 0, 1, 0.3):setOnUpdate(System.Action_float(function(arg_9_0)
		var_8_2.x = var_8_0 + (var_8_1 - var_8_0) * arg_9_0

		setAnchoredPosition(self.cloud1, var_8_2)

		var_8_5.x = var_8_3 + (var_8_4 - var_8_3) * arg_9_0

		setAnchoredPosition(self.cloud2, var_8_5)

		self.buffListCG.alpha = var_8_6 + (var_8_7 - var_8_6) * arg_9_0

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

function Shrine2022SelectBuffView:closeMySelf()
	if self.isPlaying then
		return
	end

	self:playEnterAni(false, function()
		self:Destroy()

		return
	end)

	return
end

return Shrine2022SelectBuffView
