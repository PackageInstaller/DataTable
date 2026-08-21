local var_0_0 = class("IslandLevelPanel", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandLevelPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.levelPanel = arg_2_0._tf:Find("level_panel")
	arg_2_0.levelTxt = arg_2_0.levelPanel:Find("level"):GetComponent(typeof(Text))
	arg_2_0.nameTxt = arg_2_0.levelPanel:Find("name"):GetComponent(typeof(Text))
	arg_2_0.expTr = arg_2_0.levelPanel:Find("exp")
	arg_2_0.prosperityTxt = arg_2_0.levelPanel:Find("prosperity/Text"):GetComponent(typeof(Text))
	arg_2_0.prosperityLabel = arg_2_0.levelPanel:Find("prosperity"):GetComponent(typeof(Text))
	arg_2_0.levelTip = arg_2_0.levelPanel:Find("red_dot")

	setActive(arg_2_0.levelPanel:Find("edit"), false)

	arg_2_0.expBtn = arg_2_0.levelPanel:Find("level")
	arg_2_0.expPanel = arg_2_0._tf:Find("exp")

	setActive(arg_2_0.expPanel, false)

	arg_2_0.expPanelTxt = arg_2_0.expPanel:Find("Text"):GetComponent(typeof(Text))
	arg_2_0.expPanelAddTF = arg_2_0.expPanel:Find("add")
	arg_2_0.expAnimation = arg_2_0.expPanel:GetComponent(typeof(Animation))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.nameTxt.gameObject, function()
		arg_3_0:emit(IslandMediator.OPEN_PAGE, "IslandSelfCardPage")

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.expBtn, function()
		arg_3_0:ShowExp()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_6_0)
	var_0_0.super.Show(arg_6_0)
	arg_6_0:UpdateIslandInfo()
	arg_6_0:UpdateTip()

	return
end

function var_0_0.UpdateIslandInfo(arg_7_0)
	local var_7_0 = getProxy(IslandProxy):GetIsland()

	arg_7_0.levelTxt.text = var_7_0:GetLevel()
	arg_7_0.nameTxt.text = var_7_0:GetName()

	if var_7_0:IsMaxLevel() then
		setFillAmount(arg_7_0.expTr, 1)
	else
		setFillAmount(arg_7_0.expTr, var_7_0:GetExp() / var_7_0:GetTargeExp())
	end

	arg_7_0.prosperityTxt.text = var_7_0:CanAddProsperity() and var_7_0:GetProsperity() .. "/" .. var_7_0:GetTargetProsperity() or "MAX"
	arg_7_0.prosperityLabel.text = i18n("island_prosperity_level")

	return
end

function var_0_0.UpdateTip(arg_8_0)
	setActive(arg_8_0.levelTip, getProxy(IslandProxy):ShouldTip())

	return
end

function var_0_0.ShowExp(arg_9_0)
	if arg_9_0.timer then
		arg_9_0.timer:Stop()

		arg_9_0.timer = nil
	end

	local var_9_0 = getProxy(IslandProxy):GetIsland()

	arg_9_0.expPanelTxt.text = "<color=#39bfff>" .. var_9_0:GetExp() .. "</color><color=#ffffff>/" .. var_9_0:GetTargeExp() .. "</color>"

	setActive(arg_9_0.expPanel:Find("effect"), false)
	setActive(arg_9_0.expPanelAddTF, false)
	setActive(arg_9_0.expPanel, true)
	arg_9_0.expAnimation:Play("anim_IslandUI_Exp_In")

	arg_9_0.timer = Timer.New(function()
		arg_9_0.expAnimation:Play("anim_IslandUI_Exp_Out")

		return
	end, 5, 1)

	arg_9_0.timer:Start()

	return
end

function var_0_0.ShowExpAdd(arg_11_0, arg_11_1, arg_11_2)
	onDelayTick(function()
		existCall(arg_11_2)

		return
	end, 0.5)

	if arg_11_0.timer then
		arg_11_0.timer:Stop()

		arg_11_0.timer = nil
	end

	local var_11_0 = getProxy(IslandProxy):GetIsland()

	arg_11_0.expPanelTxt.text = "<color=#39bfff>" .. var_11_0:GetExp() .. "</color><color=#ffffff>/" .. var_11_0:GetTargeExp() .. "</color>"

	setActive(arg_11_0.expPanel:Find("effect"), true)
	setActive(arg_11_0.expPanelAddTF, true)
	setText(arg_11_0.expPanelAddTF, "+" .. arg_11_1)
	setActive(arg_11_0.expPanel, true)
	arg_11_0.expAnimation:Play("anim_IslandUI_Exp_In")

	arg_11_0.timer = Timer.New(function()
		arg_11_0.expAnimation:Play("anim_IslandUI_Exp_Out")

		return
	end, 3, 1)

	arg_11_0.timer:Start()

	return
end

function var_0_0.OnDestroy(arg_14_0)
	if arg_14_0.timer then
		arg_14_0.timer:Stop()

		arg_14_0.timer = nil
	end

	return
end

return var_0_0
