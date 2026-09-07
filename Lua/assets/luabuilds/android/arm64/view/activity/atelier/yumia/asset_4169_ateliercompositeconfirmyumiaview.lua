local AtelierCompositeConfirmYumiaView = class("AtelierCompositeConfirmYumiaView", import("view.activity.Atelier.base.AtelierCompositeConfirmView"))

function AtelierCompositeConfirmYumiaView:InitCustom()
	setText(self._tf:Find("Window/titleBg/Name"), i18n("yumia_atelier_tip14"))

	return
end

function AtelierCompositeConfirmYumiaView:didEnter()
	AtelierCompositeConfirmYumiaView.super.didEnter(self)
	onButton(self, self._tf:Find("Window/titleBg/closeBtn"), function()
		self:HideCompositeConfirmWindow()

		return
	end, SFX_CANCEL)

	return
end

function AtelierCompositeConfirmYumiaView:HideCompositeConfirmWindow()
	if not isActive(self._go) then
		return
	end

	local var_4_0 = GetComponent(self._tf, typeof(Animation))

	var_4_0:Play("Anim_AtelierCompositeYumiaUI_ConfirmWindow_Out")
	pg.UIMgr.GetInstance():LoadingOn(false)

	self.closeTimer = FrameTimer.New(function()
		if not var_4_0:IsPlaying("Anim_AtelierCompositeYumiaUI_ConfirmWindow_Out") then
			self:StopCloseTimer()
			pg.UIMgr.GetInstance():LoadingOff()
			AtelierCompositeConfirmYumiaView.super.HideCompositeConfirmWindow(self)
		end

		return
	end, 1, -1)

	self.closeTimer:Start()

	return true
end

function AtelierCompositeConfirmYumiaView:StopCloseTimer()
	if self.closeTimer then
		self.closeTimer:Stop()

		self.closeTimer = nil
	end

	return
end

function AtelierCompositeConfirmYumiaView:ShowCompositeConfirmWindow(arg_7_1)
	GetComponent(self._tf, typeof(Animation)):Play("Anim_AtelierCompositeYumiaUI_ConfirmWindow_In")
	setActive(self._go, true)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	local var_7_0 = 1
	local var_7_1 = {}
	local var_7_2 = {}

	_.each(arg_7_1, function(arg_8_0)
		local var_8_0 = arg_8_0.Instance:GetConfigID()

		table.insert(var_7_1, {
			key = arg_8_0.Data:GetConfigID(),
			value = var_8_0
		})

		var_7_2[var_8_0] = (var_7_2[var_8_0] or 0) + 1

		return
	end)
	onButton(self, self._tf:Find("Window/Confirm"), function()
		self._parentClass:emit(GAME.COMPOSITE_ATELIER_RECIPE, var_7_1, var_7_0)
		self._parentClass:PlaySoundEffect(self._parentClass.soundStr.compositeConfirm)

		return
	end, SFX_PANEL)

	local var_7_3 = self.activity:GetFormulas()[self.contextData.formulaId]
	local var_7_4 = var_7_3:GetMaxLimit() ~= 1
	local var_7_5 = var_7_3:GetMaxLimit() > 0 and var_7_3:GetMaxLimit() - var_7_3:GetUsedCount() or 10000
	local var_7_6 = self.activity:GetItems()

	for iter_7_0, iter_7_1 in pairs(var_7_2) do
		var_7_5 = math.min(var_7_5, math.floor(((var_7_6[iter_7_0] or nil) and (var_7_6[iter_7_0].count or 0)) / iter_7_1))
	end

	local var_7_7 = {
		1,
		var_7_4 and var_7_5 or 1
	}
	local var_7_8 = Drop.New({
		type = var_7_3:GetProduction()[1],
		id = var_7_3:GetProduction()[2]
	})
	local var_7_9 = self._tf:Find("Window/Icon")
	local var_7_10 = self._tf:Find("Window/AtelierCommonYumiaItem")

	if var_7_8.type ~= DROP_TYPE_RYZA_DROP then
		self._parentClass:UpdateRyzaDrop(var_7_9, var_7_8)
		setActive(var_7_9, true)
		setActive(var_7_10, false)
	else
		local var_7_11 = {}

		var_7_11.configId = var_7_3:GetProduction()[2]

		local var_7_12 = AtelierMaterial.New(var_7_11)

		var_7_12.count = 1

		self._parentClass:UpdateRyzaItem(var_7_10, var_7_12)
		setActive(var_7_9, false)
		setActive(var_7_10, true)
	end

	local var_7_13 = self._tf:Find("Window/Counters")
	local var_7_14 = var_7_8:getConfig("name")

	setActive(var_7_13, var_7_4)

	if var_7_4 then
		local function var_7_15()
			setText(var_7_13:Find("Number"), var_7_0)
			setText(self._tf:Find("Window/Text"), i18n("yumia_atelier_tip20", var_7_14, var_7_0))
			setText(var_7_10:Find("cntText"), var_7_0)

			return
		end

		var_7_15()
		onButton(self, var_7_13:Find("Plus"), function()
			var_7_0 = var_7_0 + 1
			var_7_0 = math.clamp(var_7_0, var_7_7[1], var_7_7[2])

			if var_7_0 == var_7_0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("yumia_atelier_tip21"))

				return
			end

			var_7_15()

			return
		end)
		onButton(self, var_7_13:Find("Minus"), function()
			var_7_0 = var_7_0 - 1
			var_7_0 = math.clamp(var_7_0, var_7_7[1], var_7_7[2])

			var_7_15()

			return
		end)
		onButton(self, var_7_13:Find("Plus10"), function()
			var_7_0 = var_7_0 + 10
			var_7_0 = math.clamp(var_7_0, var_7_7[1], var_7_7[2])

			if var_7_0 == var_7_0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("yumia_atelier_tip21"))

				return
			end

			var_7_15()

			return
		end)
		onButton(self, var_7_13:Find("Minus10"), function()
			var_7_0 = var_7_0 - 10
			var_7_0 = math.clamp(var_7_0, var_7_7[1], var_7_7[2])

			var_7_15()

			return
		end)
	else
		setText(self._tf:Find("Window/Text"), i18n("yumia_atelier_tip19", var_7_14, var_7_0))
	end

	return
end

return AtelierCompositeConfirmYumiaView
