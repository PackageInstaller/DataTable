local CrusingDisplayActPage = class("CrusingDisplayActPage", import("view.base.BaseActivityPage"))

function CrusingDisplayActPage:OnInit()
	self.bgBase = self._tf:Find("bg_base")
	self.bgPay = self._tf:Find("bg_pay")
	self.btnGoBase = self._tf:Find("AD/btn_go_base")

	onButton(self, self.btnGoBase, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CRUSING)

		return
	end, SFX_CONFIRM)

	self.btnGoPay = self._tf:Find("AD/btn_go_pay")

	onButton(self, self.btnGoPay, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CRUSING)

		return
	end, SFX_CONFIRM)

	local var_1_0 = self._tf:Find("AD/info_panel")

	self.toggleBase = var_1_0:Find("toggle_base")

	onToggle(self, self.toggleBase, function(arg_4_0)
		if self.LTBase then
			LeanTween.cancel(self.LTBase)
		end

		self.LTBase = LeanTween.alpha(self.bgBase, arg_4_0 and 1 or 0, 0.5).uniqueId

		return
	end, SFX_PANEL)

	self.togglePay = var_1_0:Find("toggle_pay")

	onToggle(self, self.togglePay, function(arg_5_0)
		if self.LTPay then
			LeanTween.cancel(self.LTPay)
		end

		self.LTPay = LeanTween.alpha(self.bgPay, arg_5_0 and 1 or 0, 0.5).uniqueId

		return
	end, SFX_PANEL)

	self.btnPay = var_1_0:Find("unlock_panel/btn_unlock")

	onButton(self, self.btnPay, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CHARGE, {
			wrap = ChargeScene.TYPE_PICK
		})

		return
	end, SFX_CONFIRM)

	self.markPay = var_1_0:Find("unlock_panel/mark_unlocked")
	self.textPay = var_1_0:Find("text_pay")

	return
end

function CrusingDisplayActPage:OnDataSetting()
	self.isPay = self.activity.data2 == 1

	return
end

function CrusingDisplayActPage:OnUpdateFlush()
	setActive(self.textPay:Find("before"), not self.isPay)
	setActive(self.textPay:Find("after"), self.isPay)
	setActive(self.btnPay, not self.isPay)
	setActive(self.markPay, self.isPay)

	local var_8_0 = #self.activity:GetCrusingUnreceiveAward() > 0

	setActive(self.btnGoBase:Find("tip"), var_8_0)
	setActive(self.btnGoPay:Find("tip"), var_8_0)
	onNextTick(function()
		if self.isPay then
			triggerToggle(self.togglePay, true)
		else
			triggerToggle(self.toggleBase, true)

			if PlayerPrefs.GetInt("first_crusing_page_display:" .. self.activity.id, 0) == 0 then
				PlayerPrefs.SetInt("first_crusing_page_display:" .. self.activity.id, 1)

				self.LTFirst = LeanTween.delayedCall(3, System.Action(function()
					triggerToggle(self.togglePay, true)

					self.LTFirst = LeanTween.delayedCall(3, System.Action(function()
						triggerToggle(self.toggleBase, true)

						return
					end)).uniqueId

					return
				end)).uniqueId
			end
		end

		return
	end)

	return
end

function CrusingDisplayActPage:OnHideFlush()
	if self.LTFirst then
		LeanTween.cancel(self.LTFirst)

		self.LTFirst = nil
	end

	return
end

function CrusingDisplayActPage:OnDestroy()
	if self.LTFirst then
		LeanTween.cancel(self.LTFirst)

		self.LTFirst = nil
	end

	if self.LTBase then
		LeanTween.cancel(self.LTBase)

		self.LTBase = nil
	end

	if self.LTPay then
		LeanTween.cancel(self.LTPay)

		self.LTPay = nil
	end

	return
end

return CrusingDisplayActPage
