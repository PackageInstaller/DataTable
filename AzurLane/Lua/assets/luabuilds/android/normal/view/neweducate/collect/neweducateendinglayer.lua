class = var_0_10000

local var_0_0 = "NewEducateEndingLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NewEducateCollectLayerTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "NewEducateEndingUI"
end

function var_0_1.initConfig(arg_2_0)
	pg = var_1_10001
	arg_2_0.config = var_1_10001.child2_ending

	local var_2_0 = arg_2_0.contextData.permanentData

	arg_2_0.allIds = var_1.GetAllEndingIds(var_2_0)

	local var_2_1 = arg_2_0.contextData.permanentData

	arg_2_0.unlockIds = var_1.GetActivatedEndings(var_2_1)

	local var_2_2 = arg_2_0.contextData.permanentData

	arg_2_0.finishedIds = var_1.GetFinishedEndings(var_2_2)
	getProxy = var_1
	NewEducateProxy = var_2_2

	local var_2_3 = var_1(var_2_2)

	arg_2_0.char = var_1.GetChar(var_2_3, arg_2_0.contextData.permanentData.id)

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_3.Find(var_3_1, "anim_root/close")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.PlayAnimClose(var_4_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)
	arg_3_0:InitPageInfo()

	setText = var_1

	local var_3_4 = arg_3_0.performTF
	local var_3_5 = var_2.Find(var_3_4, "review_btn/Text")

	i18n = var_3_4

	var_1(var_3_5, var_3_4("child_btn_review"))

	setText = var_1

	var_1(arg_3_0.curCntTF, #arg_3_0.unlockIds)

	setText = var_1

	var_1(arg_3_0.allCntTF, "/" .. #arg_3_0.allIds)

	local var_3_6 = arg_3_0.windowTF

	arg_3_0.toggleTF = var_1.Find(var_3_6, "toggle")
	setText = var_1

	local var_3_7 = arg_3_0.toggleTF
	local var_3_8 = var_2.Find(var_3_7, "on/Text")

	i18n = var_3_7

	var_1(var_3_8, var_3_7("child2_endings_toggle_on"))

	setText = var_1

	local var_3_9 = arg_3_0.toggleTF
	local var_3_10 = var_2.Find(var_3_9, "off/Text")

	i18n = var_3_9

	var_1(var_3_10, var_3_9("child2_endings_toggle_off"))

	local var_3_11 = arg_3_0.windowTF

	arg_3_0.tpl = var_1.Find(var_3_11, "condition_tpl")
	onToggle = var_1

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.toggleTF

	local function var_3_14(arg_5_0)
		local var_5_0 = arg_3_0

		var_1.UpdatePage(var_5_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_3_12, var_3_13, var_3_14, var_5)
	arg_3_0:UpdatePage()

	return
end

function var_0_1.UpdateItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.config[arg_6_1]

	table = var_1_10004

	local var_6_1 = var_1_10004.contains(arg_6_0.unlockIds, var_6_0.id)

	setActive = var_5

	var_5(arg_6_2:Find("unlock"), var_6_1)

	setActive = var_5

	var_5(arg_6_2:Find("lock"), not var_6_1)

	setActive = var_5

	local var_6_2 = arg_6_2
	local var_6_3 = arg_6_2.Find(var_6_2, "finished")

	table = var_6_2

	var_5(var_6_3, var_6_2.contains(arg_6_0.finishedIds, var_6_0.id))

	setText = var_5

	local var_6_4 = arg_6_2:Find("name")
	local var_6_5

	if not var_6_1 or not var_6_0.name then
		var_6_5 = "???"
	end

	var_5(var_6_4, var_6_5)

	local var_6_7

	if var_6_1 then
		LoadImageSpriteAsync = var_5

		local var_6_6 = "bg/" .. var_6_0.pic

		var_6_7 = arg_6_2

		var_5(var_6_6, arg_6_2.Find(var_6_7, "unlock/mask/Image"))

		onButton = var_5

		local var_6_8 = arg_6_0

		var_6_5 = arg_6_2

		function var_6_7()
			local var_7_0 = arg_6_0

			var_0.ShowPerformWindow(var_7_0, var_6_0)

			return
		end

		SFX_PANEL = var_9

		var_5(var_6_8, var_6_5, var_6_7, var_9)
	else
		removeOnButton = var_5

		var_5(arg_6_2)
	end

	local var_6_9 = arg_6_0.toggleTF
	local var_6_10 = var_5.GetComponent

	typeof = var_6_5
	Toggle = var_6_7

	local var_6_11 = var_6_10(var_6_9, var_6_5(var_6_7)).isOn
	local var_6_12 = {}

	if var_6_11 then
		setActive = var_7

		var_7(arg_6_2:Find("lock"), true)

		setActive = var_7

		var_7(arg_6_2:Find("lock/icon"), not var_6_1)

		setActive = var_7

		var_7(arg_6_2:Find("mask"), var_6_1)

		var_6_12 = var_6_0.condition_desc
	else
		setActive = var_7

		var_7(arg_6_2:Find("mask"), false)
	end

	arg_6_0:UpdateConditions(var_6_12, arg_6_2:Find("lock/conditions"))

	return
end

function var_0_1.UpdateConditions(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = 0

	for iter_8_0 = 1, #arg_8_1 do
		var_1_10008 = arg_8_1[iter_8_0]
		var_8_0 = var_8_0 + 1

		local var_8_1

		if not (iter_8_0 <= arg_8_2.childCount) or not arg_8_2:GetChild(iter_8_0 - 1) then
			cloneTplTo = var_8_1
			var_8_1 = var_8_1(arg_8_0.tpl, arg_8_2)
		end

		local var_8_2 = arg_8_0.char
		local var_8_3 = var_10.LogicalOperator(var_8_2, {
			operator = "||",
			conditions = var_1_10008[1]
		})

		setActive = var_8_2

		var_8_2(var_8_1:Find("icon/unlock"), var_8_3)

		local var_8_4 = var_8_3 and "F59F48" or "888888"

		setTextColor = var_12

		local var_8_5 = var_8_1
		local var_8_6 = var_8_1.Find(var_8_5, "Text")

		Color = var_8_5

		var_12(var_8_6, var_8_5.NewHex(var_8_4))

		setText = var_12

		var_12(var_8_1:Find("Text"), var_1_10008[2])
	end

	for iter_8_1 = 1, arg_8_2.childCount do
		setActive = var_1_10008

		var_1_10008(arg_8_2:GetChild(iter_8_1 - 1), iter_8_1 <= var_8_0)
	end

	return
end

function var_0_1.ShowPerformWindow(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.performTF
	local var_9_1 = var_2.Find(var_9_0, "Image")

	LoadImageSpriteAsync = var_9_0

	var_9_0("bg/" .. arg_9_1.pic, var_9_1)

	setActive = var_9_0

	var_9_0(arg_9_0.performTF, true)

	onButton = var_9_0

	local var_9_2 = arg_9_0
	local var_9_3 = var_9_1

	local function var_9_4()
		setActive = var_2_10000

		var_2_10000(arg_9_0.performTF, false)

		return
	end

	SFX_PANEL = var_1_10007

	var_9_0(var_9_2, var_9_3, var_9_4, var_1_10007)

	onButton = var_9_0

	local var_9_5 = arg_9_0
	local var_9_6 = arg_9_0.performTF
	local var_9_7 = var_5.Find(var_9_6, "review_btn")

	local function var_9_8()
		pg = var_2_10000

		local var_11_0 = var_2_10000.NewStoryMgr.GetInstance()

		var_0.Play(var_11_0, arg_9_1.performance, nil, true)

		return
	end

	SFX_PANEL = var_7

	var_9_0(var_9_5, var_9_7, var_9_8, var_7)

	return
end

function var_0_1.PlayAnimChange(arg_12_0)
	local var_12_0 = arg_12_0.anim

	var_1.Stop(var_12_0)

	local var_12_1 = arg_12_0.anim

	var_1.Play(var_12_1, "anim_educate_ending_change")

	return
end

function var_0_1.PlayAnimClose(arg_13_0)
	local var_13_0 = arg_13_0.anim

	var_1.Play(var_13_0, "anim_educate_ending_out")

	return
end

return var_0_1
