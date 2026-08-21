local var_0_0 = class("SharedIslandScene", import("..View.base.IslandBaseScene"))

function var_0_0.getUIName(arg_1_0)
	return "SharedIslandUI"
end

function var_0_0.GetIsland(arg_2_0)
	return getProxy(IslandProxy):GetSharedIsland()
end

function var_0_0.init(arg_3_0)
	arg_3_0.levelTxt = arg_3_0._tf:Find("top/level_panel/level"):GetComponent(typeof(Text))
	arg_3_0.expTr = arg_3_0._tf:Find("top/level_panel/exp")
	arg_3_0.nameTxt = arg_3_0._tf:Find("top/level_panel/name"):GetComponent(typeof(Text))
	arg_3_0.prosperityTxt = arg_3_0._tf:Find("top/level_panel/prosperity/Text"):GetComponent(typeof(Text))
	arg_3_0.prosperityLabel = arg_3_0._tf:Find("top/level_panel/prosperity"):GetComponent(typeof(Text))
	arg_3_0.mapBtn = arg_3_0._tf:Find("top/map_btn")
	arg_3_0.leaveBtn = arg_3_0._tf:Find("top/leave_btn")

	setText(arg_3_0.leaveBtn:Find("Text"), i18n("island_leave"))

	return
end

function var_0_0.didEnter(arg_4_0)
	onButton(arg_4_0, arg_4_0._tf:Find("top/level_panel"), function()
		arg_4_0:OpenPage(SharedIslandOtherCardPage, arg_4_0:GetIsland().id)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.mapBtn, function()
		arg_4_0:OpenPage(SharedIslandMapPage)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.leaveBtn, function()
		arg_4_0:emit(SharedIslandMediator.RETURN_SELF_ISLAND)

		return
	end, SFX_PANEL)
	arg_4_0:StartCore()
	arg_4_0:UpdateIslandInfo()

	return
end

function var_0_0.OnOpenAnimatonOpPage(arg_8_0)
	setActive(arg_8_0.homeBtn, false)
	setActive(arg_8_0.mapBtn, false)
	setActive(arg_8_0.leaveBtn, false)

	return
end

function var_0_0.OnCloseAnimatonOpPage(arg_9_0)
	setActive(arg_9_0.homeBtn, true)
	setActive(arg_9_0.mapBtn, true)
	setActive(arg_9_0.leaveBtn, true)

	return
end

function var_0_0.UpdateIslandInfo(arg_10_0)
	local var_10_0 = arg_10_0:GetIsland()

	arg_10_0.levelTxt.text = var_10_0:GetLevel()
	arg_10_0.nameTxt.text = var_10_0:GetName()

	if var_10_0:IsMaxLevel() then
		setFillAmount(arg_10_0.expTr, 1)
	else
		setFillAmount(arg_10_0.expTr, var_10_0:GetExp() / var_10_0:GetTargeExp())
	end

	arg_10_0.prosperityTxt.text = var_10_0:CanAddProsperity() and var_10_0:GetProsperity() .. "/" .. var_10_0:GetTargetProsperity() or "MAX"
	arg_10_0.prosperityLabel.text = i18n("island_prosperity_level")

	return
end

function var_0_0.willExit(arg_11_0)
	return
end

function var_0_0.onBackPressed(arg_12_0)
	arg_12_0:emit(var_0_0.ON_BACK_PRESSED)

	return
end

return var_0_0
