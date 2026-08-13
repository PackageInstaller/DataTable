class = var_0_10000

local var_0_0 = "SharedIslandScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..View.base.IslandBaseScene"))

function var_0_1.getUIName(arg_1_0)
	return "SharedIslandUI"
end

function var_0_1.GetIsland(arg_2_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)

	return var_1.GetSharedIsland(var_2_0)
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "top/level_panel/level")
	local var_3_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_3_0.levelTxt = var_3_2(var_3_1, var_3(var_1_10004))

	local var_3_3 = arg_3_0._tf

	arg_3_0.expTr = var_1.Find(var_3_3, "top/level_panel/exp")

	local var_3_4 = arg_3_0._tf
	local var_3_5 = var_1.Find(var_3_4, "top/level_panel/name")
	local var_3_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_3_0.nameTxt = var_3_6(var_3_5, var_3(var_1_10004))

	local var_3_7 = arg_3_0._tf
	local var_3_8 = var_1.Find(var_3_7, "top/level_panel/prosperity/Text")
	local var_3_9 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_3_0.prosperityTxt = var_3_9(var_3_8, var_3(var_1_10004))

	local var_3_10 = arg_3_0._tf
	local var_3_11 = var_1.Find(var_3_10, "top/level_panel/prosperity")
	local var_3_12 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_3_0.prosperityLabel = var_3_12(var_3_11, var_3(var_1_10004))

	local var_3_13 = arg_3_0._tf

	arg_3_0.mapBtn = var_1.Find(var_3_13, "top/map_btn")

	local var_3_14 = arg_3_0._tf

	arg_3_0.leaveBtn = var_1.Find(var_3_14, "top/leave_btn")
	setText = var_1

	local var_3_15 = arg_3_0.leaveBtn
	local var_3_16 = var_2.Find(var_3_15, "Text")

	i18n = var_3_15

	var_1(var_3_16, var_3_15("island_leave"))

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_3.Find(var_4_1, "top/level_panel")

	local function var_4_3()
		local var_5_0 = arg_4_0
		local var_5_1 = var_0.OpenPage

		SharedIslandOtherCardPage = var_2_10002

		local var_5_2 = arg_4_0

		var_5_1(var_5_0, var_2_10002, var_3.GetIsland(var_5_2).id)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_4_0, var_4_2, var_4_3, var_5)

	onButton = var_1_10001

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0.mapBtn

	local function var_4_6()
		local var_6_0 = arg_4_0
		local var_6_1 = var_0.OpenPage

		SharedIslandMapPage = var_2_10002

		var_6_1(var_6_0, var_2_10002)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_4_4, var_4_5, var_4_6, var_5)

	onButton = var_1_10001

	local var_4_7 = arg_4_0
	local var_4_8 = arg_4_0.leaveBtn

	local function var_4_9()
		local var_7_0 = arg_4_0
		local var_7_1 = var_0.emit

		SharedIslandMediator = var_2_10002

		var_7_1(var_7_0, var_2_10002.RETURN_SELF_ISLAND)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_4_7, var_4_8, var_4_9, var_5)
	arg_4_0:StartCore()
	arg_4_0:UpdateIslandInfo()

	return
end

function var_0_1.OnOpenAnimatonOpPage(arg_8_0)
	setActive = var_1_10001

	var_1_10001(arg_8_0.homeBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_8_0.mapBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_8_0.leaveBtn, false)

	return
end

function var_0_1.OnCloseAnimatonOpPage(arg_9_0)
	setActive = var_1_10001

	var_1_10001(arg_9_0.homeBtn, true)

	setActive = var_1_10001

	var_1_10001(arg_9_0.mapBtn, true)

	setActive = var_1_10001

	var_1_10001(arg_9_0.leaveBtn, true)

	return
end

function var_0_1.UpdateIslandInfo(arg_10_0)
	local var_10_0 = arg_10_0:GetIsland()

	arg_10_0.levelTxt.text = var_10_0:GetLevel()
	arg_10_0.nameTxt.text = var_10_0:GetName()

	if var_10_0:IsMaxLevel() then
		setFillAmount = var_2

		var_2(arg_10_0.expTr, 1)
	else
		setFillAmount = var_2

		var_2(arg_10_0.expTr, var_10_0:GetExp() / var_10_0:GetTargeExp())
	end

	local var_10_1 = var_10_0

	if var_10_0.CanAddProsperity(var_10_1) then
		arg_10_0.prosperityTxt.text = var_10_0:GetProsperity() .. "/" .. var_10_0:GetTargetProsperity()
	else
		arg_10_0.prosperityTxt.text = "MAX"
	end

	local var_10_2 = arg_10_0.prosperityLabel

	i18n = var_10_1
	var_10_2.text = var_10_1("island_prosperity_level")

	return
end

function var_0_1.willExit(arg_11_0)
	return
end

function var_0_1.onBackPressed(arg_12_0)
	arg_12_0:emit(var_0_1.ON_BACK_PRESSED)

	return
end

return var_0_1
