class = var_0_10000

local var_0_0 = "AtelierStoreYumiaScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.Atelier.Store.AtelierStoreBaseScene"))

function var_0_1.getUIName(arg_1_0)
	return "AtelierStoreYumiaUI"
end

function var_0_1.InitCustom(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_3.Find(var_2_0, "Window/Text")

	i18n = var_1_10004

	var_1_10001(var_2_1, var_1_10004("yumia_atelier_tip13"))

	setText = var_1_10001

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_3.Find(var_2_2, "Window/textBg/Name")

	i18n = var_4

	var_1_10001(var_2_3, var_4("yumia_atelier_tip16"))

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0.activity = arg_3_0.contextData.activity
	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "Window/textBg/closeBtn")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.PlayCloseAni(var_4_0)

		return
	end

	SFX_CANCEL = var_3_1

	var_1(var_3_0, var_3_2, var_3_3, var_3_1)

	onButton = var_1

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_4.Find(var_3_5, "BG")

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.PlayCloseAni(var_5_0)

		return
	end

	SFX_CANCEL = var_3_5

	var_1(var_3_4, var_3_6, var_3_7, var_3_5)
	arg_3_0:ShowStoreHouseWindow()

	return
end

function var_0_1.PlayCloseAni(arg_6_0)
	GetComponent = var_1_10001

	local var_6_0 = arg_6_0._tf

	typeof = var_1_10004
	Animation = var_1_10006

	local var_6_1 = var_1_10001(var_6_0, var_1_10004(var_1_10006))

	var_1.Play(var_6_1, "Anim_AtelierStoreYumiaUI_Out")

	pg = var_2

	local var_6_2 = var_2.UIMgr.GetInstance()

	var_2.LoadingOn(var_6_2, false)

	FrameTimer = var_2
	arg_6_0.closeTimer = var_2.New(function()
		local var_7_0 = var_0

		if not var_0.IsPlaying(var_7_0, "Anim_AtelierStoreYumiaUI_Out") then
			local var_7_1 = arg_6_0

			var_0.StopCloseTimer(var_7_1)

			pg = var_0

			local var_7_2 = var_0.UIMgr.GetInstance()

			var_0.LoadingOff(var_7_2)

			local var_7_3 = arg_6_0

			var_0.closeView(var_7_3)
		end

		return
	end, 1, -1)

	local var_6_3 = arg_6_0.closeTimer

	var_2.Start(var_6_3)

	return
end

function var_0_1.StopCloseTimer(arg_8_0)
	if arg_8_0.closeTimer then
		local var_8_0 = arg_8_0.closeTimer

		var_1.Stop(var_8_0)

		arg_8_0.closeTimer = nil
	end

	return
end

function var_0_1.ShowStoreHouseWindow(arg_9_0)
	local var_9_0

	if not arg_9_0.contextData.versionIndex then
		var_9_0 = 2
	end

	pg = var_1_10002

	local var_9_1 = var_1_10002.UIMgr.GetInstance()

	var_2.BlurPanel(var_9_1, arg_9_0._tf)

	_ = var_2

	local var_9_2 = var_2.filter

	_ = var_9_1

	local var_9_3 = var_9_1.values
	local var_9_4 = arg_9_0.activity
	local var_9_5 = var_9_2(var_9_3(var_6.GetItems(var_9_4)), function(arg_10_0)
		return arg_10_0.count > 0 and arg_10_0:GetVersion() == var_9_0 and arg_10_0:IsShow() ~= 0
	end)

	table = var_1_10003

	var_1_10003.sort(var_9_5, function(arg_11_0, arg_11_1)
		return arg_11_0:GetConfigID() < arg_11_1:GetConfigID()
	end)

	setActive = var_3

	local var_9_6 = arg_9_0._tf

	var_3(var_5.Find(var_9_6, "Window/Empty"), #var_9_5 == 0)

	setActive = var_3

	local var_9_7 = arg_9_0._tf

	var_3(var_5.Find(var_9_7, "Window/ScrollView"), #var_9_5 > 0)

	if #var_9_5 == 0 then
		return
	end

	function arg_9_0.storehouseRect.onUpdateItem(arg_12_0, arg_12_1)
		arg_12_0 = arg_12_0 + 1
		tf = var_2_10002

		local var_12_0 = var_2_10002(arg_12_1)
		local var_12_1 = var_9_5[arg_12_0]
		local var_12_2 = arg_9_0

		var_4.UpdateRyzaItem(var_12_2, var_12_0, var_12_1)

		onButton = var_4

		local var_12_3 = arg_9_0
		local var_12_4 = var_12_0

		local function var_12_5()
			local var_13_0 = arg_9_0

			var_0.ShowItemDetail(var_13_0, var_12_1)

			return
		end

		SFX_PANEL = var_2_10009

		var_4(var_12_3, var_12_4, var_12_5, var_2_10009)

		return
	end

	local var_9_8 = arg_9_0.storehouseRect

	var_3.SetTotalCount(var_9_8, #var_9_5)
	arg_9_0:AddTimer(#var_9_5)

	return
end

function var_0_1.UpdateRyzaItem(arg_14_0, arg_14_1, arg_14_2)
	AtelierTools = var_1_10003

	var_1_10003.UpdateYumiaItem(arg_14_1, arg_14_2)

	return
end

function var_0_1.ShowItemDetail(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.emit

	AtelierMaterialDetailMediator = var_1_10005

	var_15_1(var_15_0, var_1_10005.SHOW_DETAIL, arg_15_1)

	return
end

function var_0_1.AddTimer(arg_16_0, arg_16_1)
	local var_16_0 = 0
	local var_16_1 = arg_16_0._tf
	local var_16_2 = var_3.Find(var_16_1, "Window/ScrollView/Viewport/Content")

	FrameTimer = var_1_10004
	arg_16_0.timer = var_1_10004.New(function()
		math = var_2_10000

		if var_2_10000.min(var_16_2.childCount, 15) <= arg_16_1 then
			local var_17_0 = arg_16_0

			var_1.StopTimer(var_17_0)

			local var_17_1 = arg_16_0

			var_1.AddTimer2(var_17_1)
		end

		return
	end, 1, -1)

	local var_16_3 = arg_16_0.timer

	var_4.Start(var_16_3)

	return
end

function var_0_1.AddTimer2(arg_18_0)
	local var_18_0 = arg_18_0._tf
	local var_18_1 = var_1.Find(var_18_0, "Window/ScrollView/Viewport/Content").childCount

	SetComponentEnabled = var_18_0

	local var_18_2 = arg_18_0._tf

	var_18_0(var_5.Find(var_18_2, "Window/ScrollView"), "LScrollRect", false)

	for iter_18_0 = 0, var_18_1 - 1 do
		SetComponentEnabled = var_18_5

		local var_18_3 = var_1:GetChild(iter_18_0)

		typeof = var_1_10010
		Animation = var_12

		var_18_5(var_18_3, var_1_10010(var_12), false)

		GetComponent = var_18_5

		local var_18_4 = var_1:GetChild(iter_18_0)

		typeof = var_1_10010
		CanvasGroup = var_12

		local var_18_5 = var_18_5(var_18_4, var_1_10010(var_12))

		var_18_5.alpha = 0
	end

	local var_18_6 = 0

	Timer = var_4
	arg_18_0.timer = var_4.New(function()
		if var_18_6 >= var_18_1 then
			local var_19_0 = arg_18_0

			var_0.StopTimer(var_19_0)

			SetComponentEnabled = var_0

			local var_19_1 = arg_18_0._tf

			var_0(var_2.Find(var_19_1, "Window/ScrollView"), "LScrollRect", true)

			return
		end

		GetComponent = var_0

		local var_19_2 = var_0
		local var_19_3 = var_2.GetChild(var_19_2, var_18_6)

		typeof = var_2_10003
		Animation = var_5

		local var_19_4 = var_0(var_19_3, var_2_10003(var_5))

		var_19_4.enabled = true

		var_19_4:Stop()
		var_19_4:Play("Anim_AtelierStoreYumiaUI_Tpl_In")

		var_18_6 = var_18_6 + 1

		return
	end, 0.08, -1)

	local var_18_7 = arg_18_0.timer

	var_4.Start(var_18_7)

	return
end

function var_0_1.StopTimer(arg_20_0)
	if arg_20_0.timer then
		local var_20_0 = arg_20_0.timer

		var_1.Stop(var_20_0)

		arg_20_0.timer = nil
	end

	return
end

function var_0_1.willExit(arg_21_0)
	arg_21_0:StopTimer()
	var_0_1.super.willExit(arg_21_0)

	return
end

return var_0_1
