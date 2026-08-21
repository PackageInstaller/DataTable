local var_0_0 = class("AtelierMaterialSelectYumiaView", import("view.activity.Atelier.base.AtelierMaterialSelectView"))

function var_0_0.InitCustom(arg_1_0)
	arg_1_0.item = arg_1_0._tf:Find("left/Icon")
	arg_1_0.itemName = arg_1_0._tf:Find("left/titleBg/Name")
	arg_1_0.itemCnt = arg_1_0._tf:Find("left/titleBg/cntText")
	arg_1_0.itemDescription = arg_1_0._tf:Find("left/Description/Text")

	setText(arg_1_0._tf:Find("Frame/closeBtn/Text"), i18n("yumia_atelier_tip10"))
	setText(arg_1_0._tf:Find("left/titleBg/Text_1"), i18n("yumia_atelier_tip8"))

	return
end

function var_0_0.didEnter(arg_2_0)
	var_0_0.super.didEnter(arg_2_0)
	onButton(arg_2_0, arg_2_0._tf:Find("Frame/closeBtn"), function()
		arg_2_0:CloseCandicatePanel()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateCandicateItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = tf(arg_4_2)
	local var_4_1 = arg_4_0.candicates[arg_4_1]

	arg_4_0._parentClass:UpdateRyzaItem(var_4_0, arg_4_0.candicates[arg_4_1], true)

	local var_4_2 = arg_4_0.candicates[arg_4_1].count <= 0

	onButton(arg_4_0, var_4_0, function()
		if var_4_2 then
			var_4_1 = CreateShell(var_4_1)
			var_4_1.count = false

			arg_4_0._parentClass:ShowItemDetail(var_4_1)
		else
			arg_4_0._parentClass:OnSelectMaterial(arg_4_0.nodeTarget, var_4_1)
			arg_4_0:HideCandicatePanel()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateCandicatePanel(arg_6_0, arg_6_1)
	arg_6_0.candicates = {}

	local var_6_0 = arg_6_0.activity:GetItems()
	local var_6_1 = arg_6_0.activity:GetFormulas()[arg_6_0.contextData.formulaId]
	local var_6_2 = _.map(pg.activity_ryza_item.all, function(arg_7_0)
		local var_7_0 = var_6_0[arg_7_0] or AtelierMaterial.New({
			configId = arg_7_0
		})

		if var_7_0:IsShow() ~= 0 and arg_6_0.nodeTarget.Data:CanUseMaterial(var_7_0, var_6_1, arg_6_0.contextData.versionIndex) then
			if var_6_0[arg_7_0] then
				var_7_0 = AtelierMaterial.New({
					configId = arg_7_0,
					count = var_6_0[arg_7_0].count
				})
				var_7_0.count = _.reduce(arg_6_1, var_7_0.count, function(arg_8_0, arg_8_1)
					if arg_8_1.Instance and arg_8_1.Instance:GetConfigID() == arg_7_0 then
						arg_8_0 = arg_8_0 - 1
					end

					return arg_8_0
				end)
			end

			return var_7_0
		end

		return
	end)

	table.sort(var_6_2, function(arg_9_0, arg_9_1)
		if arg_9_0.count * arg_9_1.count == 0 and arg_9_0.count - arg_9_1.count ~= 0 then
			return arg_9_0.count > arg_9_1.count
		else
			return arg_9_0:GetConfigID() < arg_9_1:GetConfigID()
		end

		return
	end)
	_.each(var_6_2, function(arg_10_0)
		table.insert(arg_6_0.candicates, arg_10_0)

		return
	end)
	arg_6_0.candicatesRect:SetTotalCount(#arg_6_0.candicates, 0)

	return
end

function var_0_0.ShowCandicatePanel(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0._tf:Find("Target")

	setActive(arg_11_0._go, true)
	SetComponentEnabled(arg_11_0._parentClass.scrollView, typeof(ScrollRect), false)

	GetComponent(arg_11_0._parentClass.scrollView, typeof(CanvasGroup)).blocksRaycasts = false

	setParent(arg_11_0.BG, arg_11_0._parentClass.layerFormulaDetailPanel)
	arg_11_0.BG:SetSiblingIndex(0)

	arg_11_0.nodeTarget = arg_11_2

	arg_11_0:UpdateCandicatePanel(arg_11_3)
	arg_11_0:RefreshFormula()
	tf(arg_11_2.GO):SetAsLastSibling()
	setActive(arg_11_2.GO:Find("select"), true)

	return
end

function var_0_0.RefreshFormula(arg_12_0)
	local var_12_0 = arg_12_0.activity:GetFormulas()[arg_12_0.contextData.formulaId]

	arg_12_0._parentClass:UpdateRyzaDrop(arg_12_0.item, {
		type = var_12_0:GetProduction()[1],
		id = var_12_0:GetProduction()[2]
	})
	setText(arg_12_0.itemName, var_12_0:GetName())
	setText(arg_12_0.itemDescription, var_12_0:GetDesc())

	local var_12_1 = tostring(var_12_0:GetMaxLimit() - var_12_0:GetUsedCount())

	if var_12_0:GetMaxLimit() < 0 then
		var_12_1 = "∞"
	end

	setText(arg_12_0.itemCnt, var_12_1)

	return
end

function var_0_0.CloseCandicatePanel(arg_13_0)
	arg_13_0:StopBgAnimation(function()
		arg_13_0:HideCandicatePanel()

		return
	end)

	return
end

function var_0_0.HideCandicatePanel(arg_15_0)
	if not isActive(arg_15_0._go) then
		return
	end

	setActive(arg_15_0.nodeTarget.GO:Find("select"), false)
	setActive(arg_15_0._go, false)

	GetComponent(arg_15_0._parentClass.scrollView, typeof(CanvasGroup)).blocksRaycasts = true

	setParent(arg_15_0.BG, arg_15_0._tf)
	arg_15_0._parentClass:RefreshScrollViewPosition()

	arg_15_0.candicateTarget = nil

	return true
end

function var_0_0.PlayBgAnimation(arg_16_0)
	return
end

function var_0_0.StopBgAnimation(arg_17_0, arg_17_1)
	arg_17_1()

	return
end

return var_0_0
