class = var_0_10000

local var_0_0 = "AtelierMaterialSelectYumiaView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.Atelier.base.AtelierMaterialSelectView"))

function var_0_1.InitCustom(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.item = var_1.Find(var_1_0, "left/Icon")

	local var_1_1 = arg_1_0._tf

	arg_1_0.itemName = var_1.Find(var_1_1, "left/titleBg/Name")

	local var_1_2 = arg_1_0._tf

	arg_1_0.itemCnt = var_1.Find(var_1_2, "left/titleBg/cntText")

	local var_1_3 = arg_1_0._tf

	arg_1_0.itemDescription = var_1.Find(var_1_3, "left/Description/Text")
	setText = var_1

	local var_1_4 = arg_1_0._tf
	local var_1_5 = var_2.Find(var_1_4, "Frame/closeBtn/Text")

	i18n = var_1_4

	var_1(var_1_5, var_1_4("yumia_atelier_tip10"))

	setText = var_1

	local var_1_6 = arg_1_0._tf
	local var_1_7 = var_2.Find(var_1_6, "left/titleBg/Text_1")

	i18n = var_1_6

	var_1(var_1_7, var_1_6("yumia_atelier_tip8"))

	return
end

function var_0_1.didEnter(arg_2_0)
	var_0_1.super.didEnter(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "Frame/closeBtn")

	local function var_2_3()
		local var_3_0 = arg_2_0

		var_0.CloseCandicatePanel(var_3_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_0, var_2_2, var_2_3, var_5)

	return
end

function var_0_1.UpdateCandicateItem(arg_4_0, arg_4_1, arg_4_2)
	tf = var_1_10003

	local var_4_0 = var_1_10003(arg_4_2)
	local var_4_1 = arg_4_0.candicates[arg_4_1]
	local var_4_2 = arg_4_0._parentClass

	var_5.UpdateRyzaItem(var_4_2, var_4_0, var_4_1, true)

	local var_4_3 = var_4_1.count <= 0

	onButton = var_6

	local var_4_4 = arg_4_0
	local var_4_5 = var_4_0

	local function var_4_6()
		if var_4_3 then
			CreateShell = var_0
			var_4_1 = var_0(var_4_1)
			var_4_1.count = false

			local var_5_0 = arg_4_0._parentClass

			var_0.ShowItemDetail(var_5_0, var_4_1)
		else
			local var_5_1 = arg_4_0._parentClass

			var_0.OnSelectMaterial(var_5_1, arg_4_0.nodeTarget, var_4_1)

			local var_5_2 = arg_4_0

			var_0.HideCandicatePanel(var_5_2)
		end

		return
	end

	SFX_PANEL = var_1_10010

	var_6(var_4_4, var_4_5, var_4_6, var_1_10010)

	return
end

function var_0_1.UpdateCandicatePanel(arg_6_0, arg_6_1)
	arg_6_0.candicates = {}

	local var_6_0 = arg_6_0.activity
	local var_6_1 = var_2.GetItems(var_6_0)
	local var_6_2 = arg_6_0.activity
	local var_6_3 = var_3.GetFormulas(var_6_2)[arg_6_0.contextData.formulaId]

	_ = var_4

	local var_6_4 = var_4.map

	pg = var_1_10005

	local var_6_5 = var_6_4(var_1_10005.activity_ryza_item.all, function(arg_7_0)
		local var_7_0

		if not var_6_1[arg_7_0] then
			AtelierMaterial = var_7_0
			var_7_0 = var_7_0.New({
				configId = arg_7_0
			})
		end

		if var_7_0:IsShow() ~= 0 then
			local var_7_1 = arg_6_0.nodeTarget.Data

			if var_2.CanUseMaterial(var_7_1, var_7_0, var_6_3, arg_6_0.contextData.versionIndex) then
				if var_6_1[arg_7_0] then
					AtelierMaterial = var_2
					var_7_0 = var_2.New({
						configId = arg_7_0,
						count = var_6_1[arg_7_0].count
					})
					_ = var_2
					var_7_0.count = var_2.reduce(arg_6_1, var_7_0.count, function(arg_8_0, arg_8_1)
						if arg_8_1.Instance then
							local var_8_0 = arg_8_1.Instance

							if var_2.GetConfigID(var_8_0) == arg_7_0 then
								arg_8_0 = arg_8_0 - 1
							end
						end

						return arg_8_0
					end)
				end

				return var_7_0
			end
		end

		return
	end)

	table = var_5

	var_5.sort(var_6_5, function(arg_9_0, arg_9_1)
		if arg_9_0.count * arg_9_1.count == 0 and arg_9_0.count - arg_9_1.count ~= 0 then
			return arg_9_0.count > arg_9_1.count
		else
			return arg_9_0:GetConfigID() < arg_9_1:GetConfigID()
		end

		return
	end)

	_ = var_5

	var_5.each(var_6_5, function(arg_10_0)
		table = var_2_10001

		var_2_10001.insert(arg_6_0.candicates, arg_10_0)

		return
	end)

	local var_6_6 = arg_6_0.candicatesRect

	var_5.SetTotalCount(var_6_6, #arg_6_0.candicates, 0)

	return
end

function var_0_1.ShowCandicatePanel(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0._tf
	local var_11_1 = var_4.Find(var_11_0, "Target")

	setActive = var_11_0

	var_11_0(arg_11_0._go, true)

	SetComponentEnabled = var_11_0

	local var_11_2 = arg_11_0._parentClass.scrollView

	typeof = var_7
	ScrollRect = var_1_10008

	var_11_0(var_11_2, var_7(var_1_10008), false)

	GetComponent = var_11_0

	local var_11_3 = arg_11_0._parentClass.scrollView

	typeof = var_7
	CanvasGroup = var_8

	local var_11_4 = var_11_0(var_11_3, var_7(var_8))

	var_11_4.blocksRaycasts = false
	setParent = var_11_4

	var_11_4(arg_11_0.BG, arg_11_0._parentClass.layerFormulaDetailPanel)

	local var_11_5 = arg_11_0.BG

	var_5.SetSiblingIndex(var_11_5, 0)

	arg_11_0.nodeTarget = arg_11_2

	arg_11_0:UpdateCandicatePanel(arg_11_3)
	arg_11_0:RefreshFormula()

	tf = var_5

	local var_11_6 = var_5(arg_11_2.GO)

	var_5.SetAsLastSibling(var_11_6)

	setActive = var_5

	local var_11_7 = arg_11_2.GO

	var_5(var_6.Find(var_11_7, "select"), true)

	return
end

function var_0_1.RefreshFormula(arg_12_0)
	local var_12_0 = arg_12_0.activity
	local var_12_1 = var_1.GetFormulas(var_12_0)[arg_12_0.contextData.formulaId]
	local var_12_2 = {
		type = var_12_1:GetProduction()[1],
		id = var_12_1:GetProduction()[2]
	}
	local var_12_3 = arg_12_0._parentClass

	var_3.UpdateRyzaDrop(var_12_3, arg_12_0.item, var_12_2)

	setText = var_3

	var_3(arg_12_0.itemName, var_12_1:GetName())

	setText = var_3

	var_3(arg_12_0.itemDescription, var_12_1:GetDesc())

	tostring = var_3

	local var_12_4 = var_3(var_12_1:GetMaxLimit() - var_12_1:GetUsedCount())

	if var_12_1:GetMaxLimit() < 0 then
		var_12_4 = "∞"
	end

	setText = var_4

	var_4(arg_12_0.itemCnt, var_12_4)

	return
end

function var_0_1.CloseCandicatePanel(arg_13_0)
	arg_13_0:StopBgAnimation(function()
		local var_14_0 = arg_13_0

		var_0.HideCandicatePanel(var_14_0)

		return
	end)

	return
end

function var_0_1.HideCandicatePanel(arg_15_0)
	isActive = var_1_10001

	if not var_1_10001(arg_15_0._go) then
		return
	end

	setActive = var_1

	local var_15_0 = arg_15_0.nodeTarget.GO

	var_1(var_2.Find(var_15_0, "select"), false)

	setActive = var_1

	var_1(arg_15_0._go, false)

	GetComponent = var_1

	local var_15_1 = arg_15_0._parentClass.scrollView

	typeof = var_3
	CanvasGroup = var_4

	local var_15_2 = var_1(var_15_1, var_3(var_4))

	var_15_2.blocksRaycasts = true
	setParent = var_15_2

	var_15_2(arg_15_0.BG, arg_15_0._tf)

	local var_15_3 = arg_15_0._parentClass

	var_1.RefreshScrollViewPosition(var_15_3)

	arg_15_0.candicateTarget = nil

	return true
end

function var_0_1.PlayBgAnimation(arg_16_0)
	return
end

function var_0_1.StopBgAnimation(arg_17_0, arg_17_1)
	arg_17_1()

	return
end

return var_0_1
