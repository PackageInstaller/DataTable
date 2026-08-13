class = var_0_10000

local var_0_0 = "AtelierFormulaMaterialsYumiaPreview"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.Atelier.base.AtelierFormulaMaterialsPreview"))

function var_0_1.InitCustom(arg_1_0)
	setText = var_1_10001

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.Find(var_1_0, "Frame/closeText")

	i18n = var_1_0

	var_1_10001(var_1_1, var_1_0("yumia_atelier_tip13"))

	setText = var_1_10001

	local var_1_2 = arg_1_0._tf
	local var_1_3 = var_2.Find(var_1_2, "Frame/Text")

	i18n = var_1_2

	var_1_10001(var_1_3, var_1_2("yumia_atelier_tip11"))

	setText = var_1_10001

	local var_1_4 = arg_1_0._tf
	local var_1_5 = var_2.Find(var_1_4, "Frame/Text_1")

	i18n = var_1_4

	var_1_10001(var_1_5, var_1_4("yumia_atelier_tip12"))

	return
end

function var_0_1.didEnter(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "BG")

	local function var_2_3()
		local var_3_0 = arg_2_0

		var_0.HideMaterialsPreview(var_3_0, true)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_2_0, var_2_2, var_2_3, var_5)

	return
end

function var_0_1.ShowMaterialsPreview(arg_4_0, arg_4_1)
	GetComponent = var_1_10002

	local var_4_0 = arg_4_0._tf

	typeof = var_1_10004
	Animation = var_1_10005

	local var_4_1 = var_1_10002(var_4_0, var_1_10004(var_1_10005))

	var_2.Play(var_4_1, "Anim_AtelierCompositeYumiaUI_FormulaMaterialPreview_In")

	setActive = var_3

	var_3(arg_4_0._go, true)

	pg = var_3

	local var_4_2 = var_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_4_2, arg_4_0._tf)

	local var_4_3 = arg_4_0.activity
	local var_4_4 = var_3.GetItems(var_4_3)
	local var_4_5 = arg_4_0.activity
	local var_4_6 = var_4.GetFormulas(var_4_5)[arg_4_0.contextData.formulaId]

	AtelierMaterial = var_5

	local var_4_7 = var_5.bindConfigTable()
	local var_4_8 = {}
	local var_4_9 = {}
	local var_4_10 = {}

	local function var_4_11(arg_5_0)
		local var_5_0

		if not var_4_10[arg_5_0:GetConfigID()] then
			Clone = var_5_0
			var_5_0 = var_5_0(var_4_4[arg_5_0:GetConfigID()])
		end

		assert = var_2

		var_2(var_5_0, "Using Unexist material")

		var_5_0.count = var_5_0.count - 1
		var_4_10[arg_5_0:GetConfigID()] = var_5_0

		return
	end

	_ = var_1_10010

	var_1_10010.each(arg_4_1, function(arg_6_0)
		local var_6_0 = arg_6_0.Data

		if var_1.GetLimitItemID(var_6_0) ~= 0 then
			local var_6_1

			if not var_4_10[var_2] then
				var_6_1 = var_4_4[var_2]
			end

			if var_6_1 and var_6_1.count > 0 then
				local var_6_2 = var_4_8
				local var_6_3

				if not var_4_8[var_2] then
					var_6_3 = 0
				end

				var_6_2[var_2] = var_6_3 + 1

				var_4_11(var_6_1)
			else
				local var_6_4 = var_4_9
				local var_6_5

				if not var_4_9[var_2] then
					var_6_5 = 0
				end

				var_6_4[var_2] = var_6_5 + 1
			end
		end

		return
	end)

	local function var_4_12(arg_7_0)
		if arg_7_0.Instance then
			var_2_10003 = arg_7_0.Data

			if var_1.GetLimitItemID(var_2_10003) == 0 then
				var_2_10003 = var_4_8

				local var_7_0 = arg_7_0.Instance
				local var_7_1 = var_4.GetConfigID(var_7_0)
				local var_7_2 = var_4_8
				local var_7_3 = arg_7_0.Instance
				local var_7_4

				if not var_7_2[var_6.GetConfigID(var_7_3)] then
					var_7_4 = 0
				end

				var_2_10003[var_7_1] = var_7_4 + 1

				var_4_11(arg_7_0.Instance)
			end

			return
		end

		local var_7_5 = arg_7_0.Data
		local var_7_6

		ipairs = var_2_10003

		for iter_7_0, iter_7_1 in var_2_10003(var_4_7.all) do
			local var_7_7

			if not var_4_10[iter_7_1] and not var_4_4[iter_7_1] then
				AtelierMaterial = var_7_7
				var_7_7 = var_7_7.New({
					configId = iter_7_1
				})
			end

			if var_7_7:IsNormal() and var_7_5:CanUseMaterial(var_7_7, var_4_6, arg_4_0.contextData.versionIndex) then
				var_7_6 = var_7_6 or iter_7_1

				if var_7_7.count > 0 then
					local var_7_8 = var_4_8
					local var_7_9

					if not var_4_8[var_7_6] then
						var_7_9 = 0
					end

					var_7_8[var_7_6] = var_7_9 + 1

					var_4_11(var_7_7)

					return
				end
			end
		end

		local var_7_10

		if var_7_6 then
			var_7_10 = var_4_9

			local var_7_11

			if not var_4_9[var_7_6] then
				var_7_11 = 0
			end

			var_7_10[var_7_6] = var_7_11 + 1
		else
			assert = var_7_10

			local var_7_12 = false

			string = var_5

			var_7_10(var_7_12, var_5.format("节点 %s 找不到合适的材料", var_7_5:GetConfigID()))
		end

		return
	end

	_ = var_11

	var_11.each(arg_4_1, function(arg_8_0)
		local var_8_0 = arg_8_0.Data
		local var_8_1 = var_1.GetType(var_8_0)

		AtelierFormulaCircle = var_8_0

		if var_8_1 == var_8_0.TYPE.NORMAL then
			var_4_12(arg_8_0)
		end

		return
	end)

	_ = var_11

	var_11.each(arg_4_1, function(arg_9_0)
		local var_9_0 = arg_9_0.Data
		local var_9_1 = var_1.GetType(var_9_0)

		AtelierFormulaCircle = var_9_0

		if var_9_1 == var_9_0.TYPE.ANY then
			var_4_12(arg_9_0)
		end

		return
	end)

	_ = var_11

	var_11.each(arg_4_1, function(arg_10_0)
		local var_10_0 = arg_10_0.Data
		local var_10_1 = var_1.GetType(var_10_0)

		AtelierFormulaCircle = var_10_0

		if var_10_1 == var_10_0.TYPE.ELEMENT_CATEGORY then
			var_4_12(arg_10_0)
		end

		return
	end)

	_ = var_11

	var_11.each(arg_4_1, function(arg_11_0)
		local var_11_0 = arg_11_0.Data
		local var_11_1 = var_1.GetType(var_11_0)

		AtelierFormulaCircle = var_11_0

		if var_11_1 == var_11_0.TYPE.CATEGORY then
			var_4_12(arg_11_0)
		end

		return
	end)

	_ = var_11

	var_11.each(arg_4_1, function(arg_12_0)
		local var_12_0 = arg_12_0.Data
		local var_12_1 = var_1.GetType(var_12_0)

		AtelierFormulaCircle = var_12_0

		if var_12_1 == var_12_0.TYPE.ELEMENT then
			var_4_12(arg_12_0)
		end

		return
	end)

	_ = var_11

	var_11.each(arg_4_1, function(arg_13_0)
		local var_13_0 = arg_13_0.Data
		local var_13_1 = var_1.GetType(var_13_0)

		AtelierFormulaCircle = var_13_0

		if var_13_1 == var_13_0.TYPE.NONE then
			var_4_12(arg_13_0)
		end

		return
	end)

	local function var_4_13(arg_14_0, arg_14_1)
		return arg_14_0 < arg_14_1
	end

	local var_4_14 = {}

	pairs = var_13

	for iter_4_0, iter_4_1 in var_13(var_4_8) do
		table = var_1_10018

		var_1_10018.insert(var_4_14, iter_4_0)
	end

	local var_4_15 = {}

	pairs = var_14

	for iter_4_2, iter_4_3 in var_14(var_4_9) do
		table = var_1_10019

		var_1_10019.insert(var_4_15, iter_4_2)
	end

	table = var_14

	var_14.sort(var_4_14, var_4_13)

	table = var_14

	var_14.sort(var_4_15, var_4_13)

	local function var_4_16()
		local var_15_0 = arg_4_0._tf
		local var_15_1 = var_0.Find(var_15_0, "Frame/Scroll/Content")

		setActive = var_15_0

		var_15_0(var_15_1.parent, #var_4_14 > 0)

		if #var_4_14 == 0 then
			return
		end

		CustomIndexLayer = var_1

		local var_15_2 = var_1.Clone2Full(var_15_1, #var_4_14)

		table = var_2

		var_2.Foreach(var_15_2, function(arg_16_0, arg_16_1)
			local var_16_0 = var_4_14[arg_16_0]

			AtelierMaterial = var_3_10003

			local var_16_1 = var_3_10003.New({
				configId = var_16_0
			})

			var_16_1.count = var_4_8[var_16_0]

			local var_16_2 = arg_4_0._parentClass

			var_4.UpdateRyzaItem(var_16_2, arg_16_1, var_16_1, true)

			onButton = var_4

			local var_16_3 = arg_4_0
			local var_16_4 = arg_16_1

			local function var_16_5()
				local var_17_0 = arg_4_0._parentClass

				var_0.ShowItemDetail(var_17_0, var_16_1)

				return
			end

			SFX_PANEL = var_8

			var_4(var_16_3, var_16_4, var_16_5, var_8)

			return
		end)

		return
	end

	local function var_4_17()
		local var_18_0 = arg_4_0._tf
		local var_18_1 = var_0.Find(var_18_0, "Frame/LackScroll/Content")

		setActive = var_18_0

		var_18_0(var_18_1.parent, #var_4_15 > 0)

		if #var_4_15 == 0 then
			return
		end

		CustomIndexLayer = var_1

		local var_18_2 = var_1.Clone2Full(var_18_1, #var_4_15)

		table = var_2

		var_2.Foreach(var_18_2, function(arg_19_0, arg_19_1)
			local var_19_0 = var_4_15[arg_19_0]

			AtelierMaterial = var_3_10003

			local var_19_1 = var_3_10003.New({
				configId = var_19_0
			})

			var_19_1.count = var_4_9[var_19_0]

			local var_19_2 = arg_4_0._parentClass

			var_4.UpdateRyzaItem(var_19_2, arg_19_1, var_19_1, true)

			onButton = var_4

			local var_19_3 = arg_4_0
			local var_19_4 = arg_19_1

			local function var_19_5()
				local var_20_0 = arg_4_0._parentClass

				var_0.ShowItemDetail(var_20_0, var_19_1)

				return
			end

			SFX_PANEL = var_8

			var_4(var_19_3, var_19_4, var_19_5, var_8)

			return
		end)

		return
	end

	var_4_16()
	var_4_17()
	arg_4_0:AddTimer(#var_4_14, #var_4_15)

	return
end

function var_0_1.HideMaterialsPreview(arg_21_0, arg_21_1)
	isActive = var_1_10002

	if not var_1_10002(arg_21_0._go) then
		return
	end

	GetComponent = var_2

	local var_21_0 = arg_21_0._tf

	typeof = var_1_10004
	Animation = var_1_10005

	local var_21_1 = var_2(var_21_0, var_1_10004(var_1_10005))

	var_2.Play(var_21_1, "Anim_AtelierCompositeYumiaUI_FormulaMaterialPreview_Out")

	pg = var_3

	local var_21_2 = var_3.UIMgr.GetInstance()

	var_3.LoadingOn(var_21_2, false)

	if not arg_21_1 then
		arg_21_0:StopCloseTimer()

		pg = var_3

		local var_21_3 = var_3.UIMgr.GetInstance()

		var_3.LoadingOff(var_21_3)
		arg_21_0:StopTimer()
		var_0_1.super.HideMaterialsPreview(arg_21_0)

		return
	end

	FrameTimer = var_3
	arg_21_0.closeTimer = var_3.New(function()
		local var_22_0 = var_0

		if not var_0.IsPlaying(var_22_0, "Anim_AtelierCompositeYumiaUI_FormulaMaterialPreview_Out") then
			local var_22_1 = arg_21_0

			var_0.StopCloseTimer(var_22_1)

			pg = var_0

			local var_22_2 = var_0.UIMgr.GetInstance()

			var_0.LoadingOff(var_22_2)

			local var_22_3 = arg_21_0

			var_0.StopTimer(var_22_3)
			var_0_1.super.HideMaterialsPreview(arg_21_0)
		end

		return
	end, 1, -1)

	local var_21_4 = arg_21_0.closeTimer

	var_3.Start(var_21_4)

	return true
end

function var_0_1.StopCloseTimer(arg_23_0)
	if arg_23_0.closeTimer then
		local var_23_0 = arg_23_0.closeTimer

		var_1.Stop(var_23_0)

		arg_23_0.closeTimer = nil
	end

	return
end

function var_0_1.AddTimer(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = 0
	local var_24_1 = arg_24_0._tf
	local var_24_2 = var_4.Find(var_24_1, "Frame/Scroll/Content")
	local var_24_3 = arg_24_0._tf
	local var_24_4 = var_5.Find(var_24_3, "Frame/LackScroll/Content")

	FrameTimer = var_24_3
	arg_24_0.timer = var_24_3.New(function()
		local var_25_0 = 0

		for iter_25_0 = 0, var_24_2.childCount - 1 do
			local var_25_1 = var_24_2

			if var_5.GetChild(var_25_1, iter_25_0).gameObject.activeSelf then
				var_25_0 = var_25_0 + 1
			end
		end

		math = var_1

		local var_25_2 = var_1.min
		local var_25_3 = var_25_0

		math = var_3

		local var_25_4 = var_25_2(var_25_3, var_3.min(arg_24_1, 8))
		local var_25_5 = 0

		for iter_25_1 = 0, var_24_4.childCount - 1 do
			local var_25_6 = var_24_4

			if var_7.GetChild(var_25_6, iter_25_1).gameObject.activeSelf then
				var_25_5 = var_25_5 + 1
			end
		end

		math = var_3

		local var_25_7 = var_3.min
		local var_25_8 = var_25_5

		math = var_5

		local var_25_9 = var_25_7(var_25_8, var_5.min(arg_24_2, 8))

		if var_25_4 <= arg_24_1 and var_25_9 <= arg_24_2 then
			local var_25_10 = arg_24_0

			var_4.StopTimer(var_25_10)

			local var_25_11 = arg_24_0

			var_4.AddTimer2(var_25_11)
		end

		return
	end, 1, -1)

	local var_24_5 = arg_24_0.timer

	var_6.Start(var_24_5)

	return
end

function var_0_1.AddTimer2(arg_26_0)
	local var_26_0 = arg_26_0._tf
	local var_26_1 = var_1.Find(var_26_0, "Frame/Scroll/Content")
	local var_26_2 = arg_26_0._tf
	local var_26_3 = var_2.Find(var_26_2, "Frame/LackScroll/Content")
	local var_26_4 = var_26_1.childCount
	local var_26_5 = var_26_3.childCount

	for iter_26_0 = 0, var_26_4 - 1 do
		SetComponentEnabled = var_1_10009

		local var_26_6 = var_26_1
		local var_26_7 = var_26_1.GetChild(var_26_6, iter_26_0)

		typeof = var_26_6
		Animation = var_12

		var_1_10009(var_26_7, var_26_6(var_12), false)

		GetComponent = var_1_10009

		local var_26_8 = var_26_1
		local var_26_9 = var_26_1.GetChild(var_26_8, iter_26_0)

		typeof = var_26_8
		CanvasGroup = var_12
		var_1_10009 = var_1_10009(var_26_9, var_26_8(var_12))
		var_1_10009.alpha = 0
	end

	for iter_26_1 = 0, var_26_5 - 1 do
		SetComponentEnabled = var_1_10009

		local var_26_10 = var_26_3
		local var_26_11 = var_26_3.GetChild(var_26_10, iter_26_1)

		typeof = var_26_10
		Animation = var_12

		var_1_10009(var_26_11, var_26_10(var_12), false)

		GetComponent = var_1_10009

		local var_26_12 = var_26_3
		local var_26_13 = var_26_3.GetChild(var_26_12, iter_26_1)

		typeof = var_26_12
		CanvasGroup = var_12
		var_1_10009 = var_1_10009(var_26_13, var_26_12(var_12))
		var_1_10009.alpha = 0
	end

	local var_26_14 = 0

	Timer = var_6
	arg_26_0.timer = var_6.New(function()
		if var_26_14 >= var_26_4 and var_26_14 >= var_26_5 then
			local var_27_0 = arg_26_0

			var_0.StopTimer(var_27_0)

			return
		end

		if var_26_14 < var_26_4 then
			GetComponent = var_0

			local var_27_1 = var_26_1
			local var_27_2 = var_1.GetChild(var_27_1, var_26_14)

			typeof = var_27_1
			Animation = var_3

			local var_27_3 = var_0(var_27_2, var_27_1(var_3))

			var_27_3.enabled = true

			var_27_3:Stop()
			var_27_3:Play("Anim_AtelierStoreYumiaUI_Tpl_In")
		end

		if var_26_14 < var_26_5 then
			GetComponent = var_0

			local var_27_4 = var_26_3
			local var_27_5 = var_1.GetChild(var_27_4, var_26_14)

			typeof = var_27_4
			Animation = var_3

			local var_27_6 = var_0(var_27_5, var_27_4(var_3))

			var_27_6.enabled = true

			var_27_6:Stop()
			var_27_6:Play("Anim_AtelierStoreYumiaUI_Tpl_In")
		end

		var_26_14 = var_26_14 + 1

		return
	end, 0.08, -1)

	local var_26_15 = arg_26_0.timer

	var_6.Start(var_26_15)

	return
end

function var_0_1.StopTimer(arg_28_0)
	if arg_28_0.timer then
		local var_28_0 = arg_28_0.timer

		var_1.Stop(var_28_0)

		arg_28_0.timer = nil
	end

	return
end

return var_0_1
