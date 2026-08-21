local var_0_0 = class("AtelierMaterialSelectView", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject
	arg_1_0._tf = arg_1_1
	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.BG = arg_2_0._tf:Find("BG")
	arg_2_0.candicatesRect = GetComponent(arg_2_0._tf:Find("Frame/List"), "LScrollRect")

	setActive(arg_2_0._tf:Find("Frame/Item"), false)

	function arg_2_0.candicatesRect.onUpdateItem(arg_3_0, arg_3_1)
		arg_2_0:UpdateCandicateItem(arg_3_0 + 1, arg_3_1)

		return
	end

	setActive(arg_2_0._go, false)
	arg_2_0:InitCustom()

	return
end

function var_0_0.InitCustom(arg_4_0)
	setText(arg_4_0._tf:Find("Frame/Item"):Find("IconBG/Lack/Text"), i18n("ryza_ui_show_acess"))

	return
end

function var_0_0.SetContextData(arg_5_0, arg_5_1)
	arg_5_0.contextData = arg_5_1

	return
end

function var_0_0.SetActivity(arg_6_0, arg_6_1)
	arg_6_0.activity = arg_6_1

	return
end

function var_0_0.didEnter(arg_7_0)
	onButton(arg_7_0, arg_7_0.BG, function()
		arg_7_0:CloseCandicatePanel()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.UpdateCandicateItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = tf(arg_9_2)
	local var_9_1 = arg_9_0.candicates[arg_9_1]

	arg_9_0._parentClass:UpdateRyzaItem(var_9_0:Find("IconBG"), arg_9_0.candicates[arg_9_1], true)
	setActive(var_9_0:Find("IconBG/Lack"), var_9_1.count <= 0)
	onButton(arg_9_0, var_9_0, function()
		if var_0 then
			var_9_1 = CreateShell(var_9_1)
			var_9_1.count = false

			arg_9_0._parentClass:ShowItemDetail(var_9_1)
		else
			arg_9_0._parentClass:OnSelectMaterial(arg_9_0.nodeTarget, var_9_1)
			arg_9_0:HideCandicatePanel()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.ShowCandicatePanel(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0._tf:Find("Target")
	local var_11_1 = tf(Instantiate(arg_11_1))

	SetComponentEnabled(var_11_1, typeof(Button), false)
	removeAllChildren(arg_11_0._tf:Find("Target"))
	setParent(var_11_1, var_11_0)
	setAnchoredPosition(var_11_1, Vector2.zero)
	arg_11_0:HideNodeLinks(var_11_1)
	setAnchoredPosition(arg_11_0._parentClass.scrollView:Find("Content"), var_11_0.anchoredPosition - (arg_11_1.anchoredPosition + arg_11_0._parentClass.scrollView.anchoredPosition))
	pg.UIMgr.GetInstance():BlurPanel(arg_11_0._parentClass.top)
	setActive(arg_11_0._go, true)
	SetComponentEnabled(arg_11_0._parentClass.scrollView, typeof(ScrollRect), false)

	arg_11_0.nodeTarget = arg_11_2

	arg_11_0:PlayBgAnimation()
	arg_11_0:UpdateCandicatePanel(arg_11_3)

	return
end

function var_0_0.CloseCandicatePanel(arg_12_0)
	arg_12_0:StopBgAnimation(function()
		arg_12_0:HideCandicatePanel()

		return
	end)

	return
end

function var_0_0.HideCandicatePanel(arg_14_0)
	if not isActive(arg_14_0._go) then
		return
	end

	pg.UIMgr.GetInstance():OverlayPanel(arg_14_0._parentClass.top)
	arg_14_0._parentClass.painting:SetSiblingIndex(1)
	setActive(arg_14_0._go, false)
	removeAllChildren(arg_14_0._tf:Find("Target"))
	SetComponentEnabled(arg_14_0._parentClass.scrollView, typeof(ScrollRect), true)

	arg_14_0.candicateTarget = nil

	return true
end

function var_0_0.UpdateCandicatePanel(arg_15_0, arg_15_1)
	arg_15_0.candicates = {}

	local var_15_0 = arg_15_0.activity:GetItems()
	local var_15_1 = arg_15_0.activity:GetFormulas()[arg_15_0.contextData.formulaId]
	local var_15_2 = _.map(pg.activity_ryza_item.all, function(arg_16_0)
		local var_16_0 = var_15_0[arg_16_0] or AtelierMaterial.New({
			configId = arg_16_0
		})

		if var_16_0:IsShow() ~= 0 and arg_15_0.nodeTarget.Data:CanUseMaterial(var_16_0, var_15_1, arg_15_0.contextData.versionIndex) then
			if var_15_0[arg_16_0] then
				var_16_0 = AtelierMaterial.New({
					configId = arg_16_0,
					count = var_15_0[arg_16_0].count
				})
				var_16_0.count = _.reduce(arg_15_1, var_16_0.count, function(arg_17_0, arg_17_1)
					if arg_17_1.Instance and arg_17_1.Instance:GetConfigID() == arg_16_0 then
						arg_17_0 = arg_17_0 - 1
					end

					return arg_17_0
				end)
			end

			return var_16_0
		end

		return
	end)

	table.sort(var_15_2, function(arg_18_0, arg_18_1)
		if arg_18_0.count * arg_18_1.count == 0 and arg_18_0.count - arg_18_1.count ~= 0 then
			return arg_18_0.count < arg_18_1.count
		else
			return arg_18_0:GetConfigID() < arg_18_1:GetConfigID()
		end

		return
	end)
	_.each(var_15_2, function(arg_19_0)
		for iter_19_0 = 1, math.max(arg_19_0.count, 1) do
			table.insert(arg_15_0.candicates, arg_19_0)
		end

		return
	end)
	arg_15_0.candicatesRect:SetTotalCount(#arg_15_0.candicates, 0)

	return
end

function var_0_0.willExit(arg_20_0)
	arg_20_0:detach()

	return
end

function var_0_0.HideNodeLinks(arg_21_0, arg_21_1)
	for iter_21_0 = 1, 6 do
		local var_21_0 = arg_21_1:Find("Links")

		setActive(var_21_0:GetChild(iter_21_0 - 1), false)
	end

	return
end

function var_0_0.PlayBgAnimation(arg_22_0)
	local var_22_0 = arg_22_0._tf:Find("TargetBG")

	var_22_0.localRotation = Quaternion.identity

	local var_22_1 = arg_22_0.nodeTarget.Data:GetType() == AtelierFormulaCircle.TYPE.BASE and 300 or 245

	setSizeDelta(var_22_0, {
		x = var_22_1,
		y = var_22_1
	})
	GetComponent(var_22_0, typeof(Animator)):SetBool("Selecting", true)

	return
end

function var_0_0.StopBgAnimation(arg_23_0, arg_23_1)
	arg_23_0._parentClass:LoadingOn()

	local var_23_0 = GetComponent(arg_23_0._tf:Find("TargetBG"), typeof(DftAniEvent))

	GetComponent(arg_23_0._tf:Find("TargetBG"), typeof(DftAniEvent)):SetEndEvent(function()
		arg_23_0._parentClass:LoadingOff()
		arg_23_1()
		var_23_0:SetEndEvent(nil)

		return
	end)
	GetComponent(arg_23_0._tf:Find("TargetBG"), typeof(Animator)):SetBool("Selecting", false)

	return
end

return var_0_0
