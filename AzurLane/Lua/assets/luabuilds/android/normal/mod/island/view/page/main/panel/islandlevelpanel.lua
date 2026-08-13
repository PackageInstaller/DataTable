class = var_0_10000

local var_0_0 = "IslandLevelPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandLevelPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.levelPanel = var_1.Find(var_2_0, "level_panel")

	local var_2_1 = arg_2_0.levelPanel
	local var_2_2 = var_1.Find(var_2_1, "level")
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.levelTxt = var_2_3(var_2_2, var_3(var_1_10004))

	local var_2_4 = arg_2_0.levelPanel
	local var_2_5 = var_1.Find(var_2_4, "name")
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nameTxt = var_2_6(var_2_5, var_3(var_1_10004))

	local var_2_7 = arg_2_0.levelPanel

	arg_2_0.expTr = var_1.Find(var_2_7, "exp")

	local var_2_8 = arg_2_0.levelPanel
	local var_2_9 = var_1.Find(var_2_8, "prosperity/Text")
	local var_2_10 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.prosperityTxt = var_2_10(var_2_9, var_3(var_1_10004))

	local var_2_11 = arg_2_0.levelPanel
	local var_2_12 = var_1.Find(var_2_11, "prosperity")
	local var_2_13 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.prosperityLabel = var_2_13(var_2_12, var_3(var_1_10004))

	local var_2_14 = arg_2_0.levelPanel

	arg_2_0.levelTip = var_1.Find(var_2_14, "red_dot")
	setActive = var_1

	local var_2_15 = arg_2_0.levelPanel

	var_1(var_2.Find(var_2_15, "edit"), false)

	local var_2_16 = arg_2_0.levelPanel

	arg_2_0.expBtn = var_1.Find(var_2_16, "level")

	local var_2_17 = arg_2_0._tf

	arg_2_0.expPanel = var_1.Find(var_2_17, "exp")
	setActive = var_1

	var_1(arg_2_0.expPanel, false)

	local var_2_18 = arg_2_0.expPanel
	local var_2_19 = var_1.Find(var_2_18, "Text")
	local var_2_20 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.expPanelTxt = var_2_20(var_2_19, var_3(var_4))

	local var_2_21 = arg_2_0.expPanel

	arg_2_0.expPanelAddTF = var_1.Find(var_2_21, "add")

	local var_2_22 = arg_2_0.expPanel
	local var_2_23 = var_1.GetComponent

	typeof = var_3
	Animation = var_4
	arg_2_0.expAnimation = var_2_23(var_2_22, var_3(var_4))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.nameTxt.gameObject

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		IslandMediator = var_2_10002

		var_4_1(var_4_0, var_2_10002.OPEN_PAGE, "IslandSelfCardPage")

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.expBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.ShowExp(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	return
end

function var_0_1.Show(arg_6_0)
	var_0_1.super.Show(arg_6_0)
	arg_6_0:UpdateIslandInfo()
	arg_6_0:UpdateTip()

	return
end

function var_0_1.UpdateIslandInfo(arg_7_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_7_0 = var_1_10001(var_1_10002)
	local var_7_1 = var_1.GetIsland(var_7_0)

	arg_7_0.levelTxt.text = var_7_1:GetLevel()
	arg_7_0.nameTxt.text = var_7_1:GetName()

	if var_7_1:IsMaxLevel() then
		setFillAmount = var_2

		var_2(arg_7_0.expTr, 1)
	else
		setFillAmount = var_2

		var_2(arg_7_0.expTr, var_7_1:GetExp() / var_7_1:GetTargeExp())
	end

	local var_7_2 = var_7_1

	if var_7_1.CanAddProsperity(var_7_2) then
		arg_7_0.prosperityTxt.text = var_7_1:GetProsperity() .. "/" .. var_7_1:GetTargetProsperity()
	else
		arg_7_0.prosperityTxt.text = "MAX"
	end

	local var_7_3 = arg_7_0.prosperityLabel

	i18n = var_7_2
	var_7_3.text = var_7_2("island_prosperity_level")

	return
end

function var_0_1.UpdateTip(arg_8_0)
	setActive = var_1_10001

	local var_8_0 = arg_8_0.levelTip

	getProxy = var_1_10003
	IslandProxy = var_1_10004

	local var_8_1 = var_1_10003(var_1_10004)

	var_1_10001(var_8_0, var_3.ShouldTip(var_8_1))

	return
end

function var_0_1.ShowExp(arg_9_0)
	if arg_9_0.timer then
		var_1_10002 = arg_9_0.timer

		var_1.Stop(var_1_10002)

		arg_9_0.timer = nil
	end

	getProxy = var_1
	IslandProxy = var_1_10002

	local var_9_0 = var_1(var_1_10002)
	local var_9_1 = var_1.GetIsland(var_9_0)
	local var_9_2 = arg_9_0.expPanelTxt

	var_9_2.text = "<color=#39bfff>" .. var_9_1:GetExp() .. "</color><color=#ffffff>/" .. var_9_1:GetTargeExp() .. "</color>"
	setActive = var_9_2

	local var_9_3 = arg_9_0.expPanel

	var_9_2(var_3.Find(var_9_3, "effect"), false)

	setActive = var_9_2

	var_9_2(arg_9_0.expPanelAddTF, false)

	setActive = var_9_2

	var_9_2(arg_9_0.expPanel, true)

	local var_9_4 = arg_9_0.expAnimation

	var_2.Play(var_9_4, "anim_IslandUI_Exp_In")

	Timer = var_2
	arg_9_0.timer = var_2.New(function()
		local var_10_0 = arg_9_0.expAnimation

		var_0.Play(var_10_0, "anim_IslandUI_Exp_Out")

		return
	end, 5, 1)

	local var_9_5 = arg_9_0.timer

	var_2.Start(var_9_5)

	return
end

function var_0_1.ShowExpAdd(arg_11_0, arg_11_1, arg_11_2)
	onDelayTick = var_1_10003

	var_1_10003(function()
		existCall = var_2_10000

		var_2_10000(arg_11_2)

		return
	end, 0.5)

	local var_11_0

	if arg_11_0.timer then
		var_11_0 = arg_11_0.timer

		var_3.Stop(var_11_0)

		arg_11_0.timer = nil
	end

	getProxy = var_3
	IslandProxy = var_11_0

	local var_11_1 = var_3(var_11_0)
	local var_11_2 = var_3.GetIsland(var_11_1)
	local var_11_3 = arg_11_0.expPanelTxt

	var_11_3.text = "<color=#39bfff>" .. var_11_2:GetExp() .. "</color><color=#ffffff>/" .. var_11_2:GetTargeExp() .. "</color>"
	setActive = var_11_3

	local var_11_4 = arg_11_0.expPanel

	var_11_3(var_5.Find(var_11_4, "effect"), true)

	setActive = var_11_3

	var_11_3(arg_11_0.expPanelAddTF, true)

	setText = var_11_3

	var_11_3(arg_11_0.expPanelAddTF, "+" .. arg_11_1)

	setActive = var_11_3

	var_11_3(arg_11_0.expPanel, true)

	local var_11_5 = arg_11_0.expAnimation

	var_4.Play(var_11_5, "anim_IslandUI_Exp_In")

	Timer = var_4
	arg_11_0.timer = var_4.New(function()
		local var_13_0 = arg_11_0.expAnimation

		var_0.Play(var_13_0, "anim_IslandUI_Exp_Out")

		return
	end, 3, 1)

	local var_11_6 = arg_11_0.timer

	var_4.Start(var_11_6)

	return
end

function var_0_1.OnDestroy(arg_14_0)
	if arg_14_0.timer then
		local var_14_0 = arg_14_0.timer

		var_1.Stop(var_14_0)

		arg_14_0.timer = nil
	end

	return
end

return var_0_1
