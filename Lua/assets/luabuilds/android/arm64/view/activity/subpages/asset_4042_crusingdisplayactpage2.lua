local CrusingDisplayActPage2 = class("CrusingDisplayActPage2", import("view.base.BaseActivityPage"))

function CrusingDisplayActPage2:OnInit()
	self.bgBase = self._tf:Find("bg_base")
	self.bgPay = self._tf:Find("bg_pay")
	self.btnGo = self._tf:Find("AD/btn_go")

	setText(self.btnGo:Find("Text"), i18n("cruise_tip_skin"))
	onButton(self, self.btnGo, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CRUSING)

		return
	end, SFX_CONFIRM)

	self.btnPay = self._tf:Find("AD/btn_pay")

	setText(self.btnPay:Find("Text"), i18n("cruise_btn_pay"))
	onButton(self, self.btnPay, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CHARGE, {
			warp = ChargeScene.TYPE_PICK
		})

		return
	end, SFX_CONFIRM)

	local var_1_0 = self._tf:Find("AD/info_panel")

	self.toggleBase = var_1_0:Find("toggle_base")

	setText(self.toggleBase:Find("Text"), i18n("cruise_tip_base"))
	onToggle(self, self.toggleBase, function(arg_4_0)
		setTextAlpha(self.toggleBase:Find("Text"), arg_4_0 and 1 or 0.3)

		if self.LTBase then
			LeanTween.cancel(self.LTBase)
		end

		self.LTBase = LeanTween.alpha(self.bgBase, arg_4_0 and 1 or 0, 0.5).uniqueId

		return
	end, SFX_PANEL)

	self.togglePay = var_1_0:Find("toggle_pay")

	setText(self.togglePay:Find("Text"), i18n("cruise_tip_upgrade"))
	onToggle(self, self.togglePay, function(arg_5_0)
		setTextAlpha(self.togglePay:Find("Text"), arg_5_0 and 1 or 0.3)

		if self.LTPay then
			LeanTween.cancel(self.LTPay)
		end

		self.LTPay = LeanTween.alpha(self.bgPay, arg_5_0 and 1 or 0, 0.5).uniqueId

		return
	end, SFX_PANEL)

	self.textPay = var_1_0:Find("text_pay")

	return
end

function CrusingDisplayActPage2:OnDataSetting()
	self.isPay = self.activity.data2 == 1

	return
end

function CrusingDisplayActPage2:OnUpdateFlush()
	setActive(self.textPay:Find("before"), not self.isPay)
	setActive(self.textPay:Find("after"), self.isPay)
	setActive(self.btnPay, not self.isPay)
	setActive(self.btnGo:Find("tip"), #self.activity:GetCrusingUnreceiveAward() > 0)

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
end

function CrusingDisplayActPage2:OnHideFlush()
	if self.LTFirst then
		LeanTween.cancel(self.LTFirst)

		self.LTFirst = nil
	end

	return
end

function CrusingDisplayActPage2:OnDestroy()
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

return CrusingDisplayActPage2
