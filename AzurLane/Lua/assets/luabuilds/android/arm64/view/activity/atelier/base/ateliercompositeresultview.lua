class = var_0_10000

local var_0_0 = "AtelierCompositeResultView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject
	arg_1_0._tf = arg_1_1
	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)

	setActive = var_3

	var_3(arg_1_0._go, false)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_3.Find(var_2_0, "Window/CountBG/Tip")

	i18n = var_1_10004

	var_1_10001(var_2_1, var_1_10004("ryza_composite_count"))

	return
end

function var_0_1.SetContextData(arg_3_0, arg_3_1)
	arg_3_0.contextData = arg_3_1

	return
end

function var_0_1.SetActivity(arg_4_0, arg_4_1)
	arg_4_0.activity = arg_4_1

	return
end

function var_0_1.didEnter(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0._tf
	local var_5_2 = var_4.Find(var_5_1, "BG")

	local function var_5_3()
		local var_6_0 = arg_5_0

		var_0.HideCompositeResult(var_6_0)

		return
	end

	SFX_CANCEL = var_5_1

	var_1_10001(var_5_0, var_5_2, var_5_3, var_5_1)

	return
end

function var_0_1.ShowCompositeResult(arg_7_0, arg_7_1)
	setActive = var_1_10002

	var_1_10002(arg_7_0._go, true)

	pg = var_1_10002

	local var_7_0 = var_1_10002.UIMgr.GetInstance()

	var_2.BlurPanel(var_7_0, arg_7_0._tf)

	if arg_7_1[1] == nil then
		return
	end

	local var_7_1 = arg_7_0._parentClass
	local var_7_2 = var_3.UpdateRyzaDrop
	local var_7_3 = arg_7_0._tf

	var_7_2(var_7_1, var_6.Find(var_7_3, "Window/Icon"), var_2)

	setScrollText = var_7_2

	local var_7_4 = arg_7_0._tf

	var_7_2(var_5.Find(var_7_4, "Window/NameBG/Rect/Name"), var_2:getName())

	setText = var_7_2

	local var_7_5 = arg_7_0._tf

	var_7_2(var_5.Find(var_7_5, "Window/CountBG/Text"), var_2.count)

	return
end

function var_0_1.HideCompositeResult(arg_8_0)
	isActive = var_1_10001

	if not var_1_10001(arg_8_0._go) then
		return
	end

	pg = var_1

	local var_8_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_8_0, arg_8_0._tf, arg_8_0._parentClass._tf)

	setActive = var_1

	var_1(arg_8_0._go, false)
	arg_8_0:PlayGuide()

	return true
end

function var_0_1.willExit(arg_9_0)
	arg_9_0:detach()

	return
end

function var_0_1.PlayGuide(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.NewStoryMgr.GetInstance()

	if var_1.IsPlayed(var_10_0, "NG0032") then
		pg = var_1

		local var_10_1 = var_1.SystemGuideMgr.GetInstance()

		var_1.PlayByGuideId(var_10_1, "NG0033", {
			2
		})
	end

	return
end

return var_0_1
