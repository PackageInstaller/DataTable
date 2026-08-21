local var_0_0 = class("AtelierCompositeConfirmView", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject
	arg_1_0._tf = arg_1_1
	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	setActive(arg_1_0._go, false)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitCustom()

	return
end

function var_0_0.InitCustom(arg_3_0)
	return
end

function var_0_0.SetContextData(arg_4_0, arg_4_1)
	arg_4_0.contextData = arg_4_1

	return
end

function var_0_0.SetActivity(arg_5_0, arg_5_1)
	arg_5_0.activity = arg_5_1

	return
end

function var_0_0.didEnter(arg_6_0)
	onButton(arg_6_0, arg_6_0._tf:Find("BG"), function()
		arg_6_0:HideCompositeConfirmWindow()

		return
	end, SFX_CANCEL)
	onButton(arg_6_0, arg_6_0._tf:Find("Window/Cancel"), function()
		arg_6_0:HideCompositeConfirmWindow()

		return
	end, SFX_CANCEL)

	return
end

local var_0_1 = 41
local var_0_2 = 5

function var_0_0.ShowCompositeConfirmWindow(arg_9_0, arg_9_1)
	setActive(arg_9_0._go, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_9_0._tf)

	local var_9_0 = 1
	local var_9_1 = {}
	local var_9_2 = {}

	_.each(arg_9_1, function(arg_10_0)
		local var_10_0 = arg_10_0.Instance:GetConfigID()

		table.insert(var_9_1, {
			key = arg_10_0.Data:GetConfigID(),
			value = var_10_0
		})

		local var_10_1 = var_9_2[var_10_0] or 0

		var_9_2[var_10_0] = var_10_1 + 1

		return
	end)
	onButton(arg_9_0, arg_9_0._tf:Find("Window/Confirm"), function()
		arg_9_0._parentClass:emit(GAME.COMPOSITE_ATELIER_RECIPE, var_9_1, var_9_0)
		arg_9_0._parentClass:PlaySoundEffect(arg_9_0._parentClass.soundStr.compositeConfirm)

		return
	end, SFX_PANEL)

	local var_9_3 = arg_9_0.activity:GetFormulas()[arg_9_0.contextData.formulaId]
	local var_9_4 = var_9_3:GetMaxLimit() ~= 1
	local var_9_5 = var_9_3:GetMaxLimit() > 0 and var_9_3:GetMaxLimit() - var_9_3:GetUsedCount() or 10000
	local var_9_6 = arg_9_0.activity:GetItems()

	for iter_9_0, iter_9_1 in pairs(var_9_2) do
		if var_9_6[iter_9_0] then
			var_9_5 = math.min(var_9_5, math.floor(var_9_7 / iter_9_1))
		end
	end

	local var_9_8 = {
		1,
		var_9_4 and var_9_5 or 1
	}
	local var_9_9 = Drop.New({
		type = var_9_3:GetProduction()[1],
		id = var_9_3:GetProduction()[2]
	})

	arg_9_0._parentClass:UpdateRyzaDrop(arg_9_0._tf:Find("Window/Icon"), var_9_9)

	local var_9_10 = arg_9_0._tf:Find("Window/Counters")
	local var_9_11 = var_9_9:getConfig("name")

	setActive(var_9_10, var_9_4)

	if var_9_4 then
		setAnchoredPosition(arg_9_0._tf:Find("Window/Icon"), {
			y = var_0_1
		})
		;(function()
			setText(var_9_10:Find("Number"), var_9_0)
			setText(arg_9_0._tf:Find("Window/Text"), i18n("ryza_composite_confirm", var_9_11, var_9_0))

			return
		end)()
		onButton(arg_9_0, var_9_10:Find("Plus"), function()
			var_9_0 = var_9_0 + 1
			var_9_0 = math.clamp(var_9_0, var_9_8[1], var_9_8[2])

			if var_9_0 == var_9_0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_max_composite_count"))

				return
			end

			var_0()

			return
		end)
		onButton(arg_9_0, var_9_10:Find("Minus"), function()
			var_9_0 = var_9_0 - 1
			var_9_0 = math.clamp(var_9_0, var_9_8[1], var_9_8[2])

			var_0()

			return
		end)
		onButton(arg_9_0, var_9_10:Find("Plus10"), function()
			var_9_0 = var_9_0 + 10
			var_9_0 = math.clamp(var_9_0, var_9_8[1], var_9_8[2])

			if var_9_0 == var_9_0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_max_composite_count"))

				return
			end

			var_0()

			return
		end)
		onButton(arg_9_0, var_9_10:Find("Minus10"), function()
			var_9_0 = var_9_0 - 10
			var_9_0 = math.clamp(var_9_0, var_9_8[1], var_9_8[2])

			var_0()

			return
		end)
	else
		setAnchoredPosition(arg_9_0._tf:Find("Window/Icon"), {
			y = var_0_2
		})
		setText(arg_9_0._tf:Find("Window/Text"), i18n("ryza_composite_confirm_single", var_9_9:getConfig("name"), var_9_0))
	end

	return
end

function var_0_0.HideCompositeConfirmWindow(arg_17_0)
	if not isActive(arg_17_0._go) then
		return
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_17_0._tf, arg_17_0._parentClass._tf)
	setActive(arg_17_0._go, false)

	return true
end

function var_0_0.willExit(arg_18_0)
	arg_18_0:detach()

	return
end

return var_0_0
