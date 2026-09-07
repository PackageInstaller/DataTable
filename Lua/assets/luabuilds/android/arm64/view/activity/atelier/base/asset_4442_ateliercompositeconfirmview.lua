local AtelierCompositeConfirmView = class("AtelierCompositeConfirmView", import("view.base.BasePanel"))

function AtelierCompositeConfirmView:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject
	self._tf = arg_1_1
	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	setActive(self._go, false)
	self:Init()

	return
end

function AtelierCompositeConfirmView:Init()
	self:InitCustom()

	return
end

function AtelierCompositeConfirmView:InitCustom()
	return
end

function AtelierCompositeConfirmView:SetContextData(arg_4_1)
	self.contextData = arg_4_1

	return
end

function AtelierCompositeConfirmView:SetActivity(arg_5_1)
	self.activity = arg_5_1

	return
end

function AtelierCompositeConfirmView:didEnter()
	onButton(self, self._tf:Find("BG"), function()
		self:HideCompositeConfirmWindow()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("Window/Cancel"), function()
		self:HideCompositeConfirmWindow()

		return
	end, SFX_CANCEL)

	return
end

local var_0_1 = 41
local var_0_2 = 5

function AtelierCompositeConfirmView:ShowCompositeConfirmWindow(arg_9_1)
	setActive(self._go, true)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	local var_9_0 = 1
	local var_9_1 = {}
	local var_9_2 = {}

	_.each(arg_9_1, function(arg_10_0)
		local var_10_0 = arg_10_0.Instance:GetConfigID()

		table.insert(var_9_1, {
			key = arg_10_0.Data:GetConfigID(),
			value = var_10_0
		})

		var_9_2[var_10_0] = (var_9_2[var_10_0] or 0) + 1

		return
	end)
	onButton(self, self._tf:Find("Window/Confirm"), function()
		self._parentClass:emit(GAME.COMPOSITE_ATELIER_RECIPE, var_9_1, var_9_0)
		self._parentClass:PlaySoundEffect(self._parentClass.soundStr.compositeConfirm)

		return
	end, SFX_PANEL)

	local var_9_3 = self.activity:GetFormulas()[self.contextData.formulaId]
	local var_9_4 = var_9_3:GetMaxLimit() ~= 1
	local var_9_5 = var_9_3:GetMaxLimit() > 0 and var_9_3:GetMaxLimit() - var_9_3:GetUsedCount() or 10000
	local var_9_6 = self.activity:GetItems()

	for iter_9_0, iter_9_1 in pairs(var_9_2) do
		var_9_5 = math.min(var_9_5, math.floor(((var_9_6[iter_9_0] or nil) and (var_9_6[iter_9_0].count or 0)) / iter_9_1))
	end

	local var_9_7 = {
		1,
		var_9_4 and var_9_5 or 1
	}
	local var_9_8 = Drop.New({
		type = var_9_3:GetProduction()[1],
		id = var_9_3:GetProduction()[2]
	})

	self._parentClass:UpdateRyzaDrop(self._tf:Find("Window/Icon"), var_9_8)

	local var_9_9 = self._tf:Find("Window/Counters")
	local var_9_10 = var_9_8:getConfig("name")

	setActive(var_9_9, var_9_4)

	if var_9_4 then
		setAnchoredPosition(self._tf:Find("Window/Icon"), {
			y = var_0_1
		})

		local function var_9_11()
			setText(var_9_9:Find("Number"), var_9_0)
			setText(self._tf:Find("Window/Text"), i18n("ryza_composite_confirm", var_9_10, var_9_0))

			return
		end

		var_9_11()
		onButton(self, var_9_9:Find("Plus"), function()
			var_9_0 = var_9_0 + 1
			var_9_0 = math.clamp(var_9_0, var_9_7[1], var_9_7[2])

			if var_9_0 == var_9_0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_max_composite_count"))

				return
			end

			var_9_11()

			return
		end)
		onButton(self, var_9_9:Find("Minus"), function()
			var_9_0 = var_9_0 - 1
			var_9_0 = math.clamp(var_9_0, var_9_7[1], var_9_7[2])

			var_9_11()

			return
		end)
		onButton(self, var_9_9:Find("Plus10"), function()
			var_9_0 = var_9_0 + 10
			var_9_0 = math.clamp(var_9_0, var_9_7[1], var_9_7[2])

			if var_9_0 == var_9_0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_max_composite_count"))

				return
			end

			var_9_11()

			return
		end)
		onButton(self, var_9_9:Find("Minus10"), function()
			var_9_0 = var_9_0 - 10
			var_9_0 = math.clamp(var_9_0, var_9_7[1], var_9_7[2])

			var_9_11()

			return
		end)
	else
		setAnchoredPosition(self._tf:Find("Window/Icon"), {
			y = var_0_2
		})
		setText(self._tf:Find("Window/Text"), i18n("ryza_composite_confirm_single", var_9_10, var_9_0))
	end

	return
end

function AtelierCompositeConfirmView:HideCompositeConfirmWindow()
	if not isActive(self._go) then
		return
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentClass._tf)
	setActive(self._go, false)

	return true
end

function AtelierCompositeConfirmView:willExit()
	self:detach()

	return
end

return AtelierCompositeConfirmView
