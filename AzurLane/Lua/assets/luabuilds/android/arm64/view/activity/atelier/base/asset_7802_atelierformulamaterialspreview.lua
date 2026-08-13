class = var_0_10000

local var_0_0 = "AtelierFormulaMaterialsPreview"

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
	arg_2_0:InitCustom()

	return
end

function var_0_1.InitCustom(arg_3_0)
	setText = var_1_10001

	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_3.Find(var_3_0, "Frame/Text")

	i18n = var_1_10004

	var_1_10001(var_3_1, var_1_10004("ryza_tip_item_access"))

	return
end

function var_0_1.SetContextData(arg_4_0, arg_4_1)
	arg_4_0.contextData = arg_4_1

	return
end

function var_0_1.SetActivity(arg_5_0, arg_5_1)
	arg_5_0.activity = arg_5_1

	return
end

function var_0_1.didEnter(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0._tf
	local var_6_2 = var_4.Find(var_6_1, "BG")

	local function var_6_3()
		local var_7_0 = arg_6_0

		var_0.HideMaterialsPreview(var_7_0)

		return
	end

	SFX_CANCEL = var_6_1

	var_1_10001(var_6_0, var_6_2, var_6_3, var_6_1)

	return
end

function var_0_1.ShowMaterialsPreview(arg_8_0, arg_8_1)
	setActive = var_1_10002

	var_1_10002(arg_8_0._go, true)

	pg = var_1_10002

	local var_8_0 = var_1_10002.UIMgr.GetInstance()

	var_2.BlurPanel(var_8_0, arg_8_0._tf)

	local var_8_1 = arg_8_0.activity
	local var_8_2 = var_2.GetItems(var_8_1)
	local var_8_3 = arg_8_0.activity
	local var_8_4 = var_3.GetFormulas(var_8_3)[arg_8_0.contextData.formulaId]

	AtelierMaterial = var_4

	local var_8_5 = var_4.bindConfigTable()
	local var_8_6 = {}
	local var_8_7 = {}
	local var_8_8 = {}

	local function var_8_9(arg_9_0)
		local var_9_0

		if not var_8_8[arg_9_0:GetConfigID()] then
			Clone = var_9_0
			var_9_0 = var_9_0(var_8_2[arg_9_0:GetConfigID()])
		end

		assert = var_2

		var_2(var_9_0, "Using Unexist material")

		var_9_0.count = var_9_0.count - 1
		var_8_8[arg_9_0:GetConfigID()] = var_9_0

		return
	end

	_ = var_1_10009

	var_1_10009.each(arg_8_1, function(arg_10_0)
		local var_10_0 = arg_10_0.Data

		if var_1.GetLimitItemID(var_10_0) ~= 0 then
			local var_10_1

			if not var_8_8[var_2] then
				var_10_1 = var_8_2[var_2]
			end

			if var_10_1 and var_10_1.count > 0 then
				AtelierMaterial = var_10_0
				var_10_0 = var_10_0.New({
					configId = var_2
				})
				var_10_0.count = false
				table = var_5

				var_5.insert(var_8_6, var_10_0)
				var_8_9(var_10_1)
			else
				AtelierMaterial = var_10_0

				local var_10_2 = var_10_0.New({
					configId = var_2
				})

				var_10_2.count = false
				table = var_5

				var_5.insert(var_8_7, var_10_2)
			end
		end

		return
	end)

	local function var_8_10(arg_11_0)
		if arg_11_0.Instance then
			AtelierMaterial = var_1

			local var_11_0 = var_1.New

			var_2_10003 = {}

			local var_11_1 = arg_11_0.Instance

			var_2_10003.configId = var_4.GetConfigID(var_11_1)

			local var_11_2 = var_11_0(var_2_10003)

			var_11_2.count = false
			table = var_2

			var_2.insert(var_8_6, var_11_2)
			var_8_9(arg_11_0.Instance)

			return
		end

		local var_11_3 = arg_11_0.Data
		local var_11_4

		ipairs = var_2_10003

		for iter_11_0, iter_11_1 in var_2_10003(var_8_5.all) do
			local var_11_5

			if not var_8_8[iter_11_1] and not var_8_2[iter_11_1] then
				AtelierMaterial = var_11_5
				var_11_5 = var_11_5.New({
					configId = iter_11_1
				})
			end

			if var_11_5:IsNormal() and var_11_3:CanUseMaterial(var_11_5, var_8_4, arg_8_0.contextData.versionIndex) then
				var_11_4 = var_11_4 or iter_11_1

				if var_11_5.count > 0 then
					AtelierMaterial = var_9

					local var_11_6 = var_9.New({
						configId = iter_11_1
					})

					var_11_6.count = false
					table = var_10

					var_10.insert(var_8_6, var_11_6)
					var_8_9(var_11_5)

					return
				end
			end
		end

		AtelierMaterial = var_3

		local var_11_7 = var_3.New({
			configId = var_11_4
		})

		var_11_7.count = false
		table = var_4

		var_4.insert(var_8_7, var_11_7)

		return
	end

	_ = var_1_10010

	var_1_10010.each(arg_8_1, function(arg_12_0)
		local var_12_0 = arg_12_0.Data
		local var_12_1 = var_1.GetType(var_12_0)

		AtelierFormulaCircle = var_2_10003

		if var_12_1 == var_2_10003.TYPE.NORMAL then
			var_8_10(arg_12_0)
		end

		return
	end)

	_ = var_10

	var_10.each(arg_8_1, function(arg_13_0)
		local var_13_0 = arg_13_0.Data
		local var_13_1 = var_1.GetType(var_13_0)

		AtelierFormulaCircle = var_2_10003

		if var_13_1 == var_2_10003.TYPE.ANY then
			var_8_10(arg_13_0)
		end

		return
	end)

	_ = var_10

	var_10.each(arg_8_1, function(arg_14_0)
		local var_14_0 = arg_14_0.Data
		local var_14_1 = var_1.GetType(var_14_0)

		AtelierFormulaCircle = var_2_10003

		if var_14_1 == var_2_10003.TYPE.ELEMENT_CATEGORY then
			var_8_10(arg_14_0)
		end

		return
	end)

	_ = var_10

	var_10.each(arg_8_1, function(arg_15_0)
		local var_15_0 = arg_15_0.Data
		local var_15_1 = var_1.GetType(var_15_0)

		AtelierFormulaCircle = var_2_10003

		if var_15_1 == var_2_10003.TYPE.CATEGORY then
			var_8_10(arg_15_0)
		end

		return
	end)

	_ = var_10

	var_10.each(arg_8_1, function(arg_16_0)
		local var_16_0 = arg_16_0.Data
		local var_16_1 = var_1.GetType(var_16_0)

		AtelierFormulaCircle = var_2_10003

		if var_16_1 == var_2_10003.TYPE.ELEMENT then
			var_8_10(arg_16_0)
		end

		return
	end)

	_ = var_10

	var_10.each(arg_8_1, function(arg_17_0)
		local var_17_0 = arg_17_0.Data
		local var_17_1 = var_1.GetType(var_17_0)

		AtelierFormulaCircle = var_2_10003

		if var_17_1 == var_2_10003.TYPE.NONE then
			var_8_10(arg_17_0)
		end

		return
	end)

	local function var_8_11(arg_18_0, arg_18_1)
		return arg_18_0:GetConfigID() < arg_18_1:GetConfigID()
	end

	table = var_11

	var_11.sort(var_8_6, var_8_11)

	table = var_11

	var_11.sort(var_8_7, var_8_11)

	local function var_8_12()
		local var_19_0 = arg_8_0._tf
		local var_19_1 = var_0.Find(var_19_0, "Frame/Scroll/Content/Owned/List")

		setActive = var_2_10001

		var_2_10001(var_19_1.parent, #var_8_6 > 0)

		if #var_8_6 == 0 then
			return
		end

		CustomIndexLayer = var_1

		local var_19_2 = var_1.Clone2Full(var_19_1, #var_8_6)

		table = var_19_0

		var_19_0.Foreach(var_19_2, function(arg_20_0, arg_20_1)
			local var_20_0 = var_8_6[arg_20_0]
			local var_20_1 = arg_8_0._parentClass

			var_3.UpdateRyzaItem(var_20_1, arg_20_1:Find("IconBG"), var_20_0, true)

			onButton = var_3

			local var_20_2 = arg_8_0
			local var_20_3 = arg_20_1

			local function var_20_4()
				local var_21_0 = arg_8_0._parentClass

				var_0.ShowItemDetail(var_21_0, var_20_0)

				return
			end

			SFX_PANEL = var_8

			var_3(var_20_2, var_20_3, var_20_4, var_8)

			return
		end)

		return
	end

	local function var_8_13()
		local var_22_0 = arg_8_0._tf
		local var_22_1 = var_0.Find(var_22_0, "Frame/Scroll/Content/Lack/List")

		setActive = var_2_10001

		var_2_10001(var_22_1.parent, #var_8_7 > 0)

		if #var_8_7 == 0 then
			return
		end

		CustomIndexLayer = var_1

		local var_22_2 = var_1.Clone2Full(var_22_1, #var_8_7)

		table = var_22_0

		var_22_0.Foreach(var_22_2, function(arg_23_0, arg_23_1)
			local var_23_0 = var_8_7[arg_23_0]
			local var_23_1 = arg_8_0._parentClass

			var_3.UpdateRyzaItem(var_23_1, arg_23_1:Find("IconBG"), var_23_0, true)

			onButton = var_3

			local var_23_2 = arg_8_0
			local var_23_3 = arg_23_1

			local function var_23_4()
				local var_24_0 = arg_8_0._parentClass

				var_0.ShowItemDetail(var_24_0, var_23_0)

				return
			end

			SFX_PANEL = var_8

			var_3(var_23_2, var_23_3, var_23_4, var_8)

			return
		end)

		return
	end

	var_8_12()
	var_8_13()

	return
end

function var_0_1.HideMaterialsPreview(arg_25_0)
	isActive = var_1_10001

	if not var_1_10001(arg_25_0._go) then
		return
	end

	pg = var_1

	local var_25_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_25_0, arg_25_0._tf, arg_25_0._parentClass._tf)

	setActive = var_1

	var_1(arg_25_0._go, false)

	return true
end

function var_0_1.willExit(arg_26_0)
	arg_26_0:detach()

	return
end

return var_0_1
