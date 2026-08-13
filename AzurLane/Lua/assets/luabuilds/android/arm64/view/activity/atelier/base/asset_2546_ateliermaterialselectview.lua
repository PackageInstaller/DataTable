class = var_0_10000

local var_0_0 = "AtelierMaterialSelectView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject
	arg_1_0._tf = arg_1_1
	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.BG = var_1.Find(var_2_0, "BG")
	GetComponent = var_1

	local var_2_1 = arg_2_0._tf

	arg_2_0.candicatesRect = var_1(var_3.Find(var_2_1, "Frame/List"), "LScrollRect")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "Frame/Item")

	setActive = var_1_10002

	var_1_10002(var_2_3, false)

	local var_2_4 = arg_2_0.candicatesRect

	function var_2_4.onUpdateItem(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.UpdateCandicateItem(var_3_0, arg_3_0 + 1, arg_3_1)

		return
	end

	setActive = var_2_4

	var_2_4(arg_2_0._go, false)
	arg_2_0:InitCustom()

	return
end

function var_0_1.InitCustom(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "Frame/Item")

	setText = var_1_10002

	local var_4_2 = var_4_1:Find("IconBG/Lack/Text")

	i18n = var_1_10005

	var_1_10002(var_4_2, var_1_10005("ryza_ui_show_acess"))

	return
end

function var_0_1.SetContextData(arg_5_0, arg_5_1)
	arg_5_0.contextData = arg_5_1

	return
end

function var_0_1.SetActivity(arg_6_0, arg_6_1)
	arg_6_0.activity = arg_6_1

	return
end

function var_0_1.didEnter(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.BG

	local function var_7_2()
		local var_8_0 = arg_7_0

		var_0.CloseCandicatePanel(var_8_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10006)

	return
end

function var_0_1.UpdateCandicateItem(arg_9_0, arg_9_1, arg_9_2)
	tf = var_1_10003

	local var_9_0 = var_1_10003(arg_9_2)
	local var_9_1 = arg_9_0.candicates[arg_9_1]
	local var_9_2 = arg_9_0._parentClass

	var_5.UpdateRyzaItem(var_9_2, var_9_0:Find("IconBG"), var_9_1, true)

	local var_9_3 = var_9_1.count <= 0

	setActive = var_6

	var_6(var_9_0:Find("IconBG/Lack"), var_9_3)

	onButton = var_6

	local var_9_4 = arg_9_0
	local var_9_5 = var_9_0

	local function var_9_6()
		if var_9_3 then
			CreateShell = var_0
			var_9_1 = var_0(var_9_1)
			var_9_1.count = false

			local var_10_0 = arg_9_0._parentClass

			var_0.ShowItemDetail(var_10_0, var_9_1)
		else
			local var_10_1 = arg_9_0._parentClass

			var_0.OnSelectMaterial(var_10_1, arg_9_0.nodeTarget, var_9_1)

			local var_10_2 = arg_9_0

			var_0.HideCandicatePanel(var_10_2)
		end

		return
	end

	SFX_PANEL = var_11

	var_6(var_9_4, var_9_5, var_9_6, var_11)

	return
end

function var_0_1.ShowCandicatePanel(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0._tf
	local var_11_1 = var_4.Find(var_11_0, "Target")

	tf = var_1_10005
	Instantiate = var_7

	local var_11_2 = var_1_10005(var_7(arg_11_1))

	SetComponentEnabled = var_11_0

	local var_11_3 = var_11_2

	typeof = var_9
	Button = var_1_10011

	var_11_0(var_11_3, var_9(var_1_10011), false)

	removeAllChildren = var_11_0

	local var_11_4 = arg_11_0._tf

	var_11_0(var_8.Find(var_11_4, "Target"))

	setParent = var_11_0

	var_11_0(var_11_2, var_11_1)

	setAnchoredPosition = var_11_0

	local var_11_5 = var_11_2

	Vector2 = var_9

	var_11_0(var_11_5, var_9.zero)
	arg_11_0:HideNodeLinks(var_11_2)

	local var_11_6 = arg_11_0._parentClass.layerFormulaDetailPanel
	local var_11_7 = var_11_1.anchoredPosition
	local var_11_8 = arg_11_0._parentClass.scrollView
	local var_11_9 = var_8.Find(var_11_8, "Content")
	local var_11_10 = arg_11_1.anchoredPosition + arg_11_0._parentClass.scrollView.anchoredPosition

	setAnchoredPosition = var_10

	var_10(var_11_9, var_11_7 - var_11_10)

	pg = var_10

	local var_11_11 = var_10.UIMgr.GetInstance()

	var_10.BlurPanel(var_11_11, arg_11_0._parentClass.top)

	setActive = var_10

	var_10(arg_11_0._go, true)

	SetComponentEnabled = var_10

	local var_11_12 = arg_11_0._parentClass.scrollView

	typeof = var_13
	ScrollRect = var_1_10015

	var_10(var_11_12, var_13(var_1_10015), false)

	arg_11_0.nodeTarget = arg_11_2

	arg_11_0:PlayBgAnimation()
	arg_11_0:UpdateCandicatePanel(arg_11_3)

	return
end

function var_0_1.CloseCandicatePanel(arg_12_0)
	arg_12_0:StopBgAnimation(function()
		local var_13_0 = arg_12_0

		var_0.HideCandicatePanel(var_13_0)

		return
	end)

	return
end

function var_0_1.HideCandicatePanel(arg_14_0)
	isActive = var_1_10001

	if not var_1_10001(arg_14_0._go) then
		return
	end

	pg = var_1

	local var_14_0 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_14_0, arg_14_0._parentClass.top)

	local var_14_1 = arg_14_0._parentClass.painting

	var_1.SetSiblingIndex(var_14_1, 1)

	setActive = var_1

	var_1(arg_14_0._go, false)

	removeAllChildren = var_1

	local var_14_2 = arg_14_0._tf

	var_1(var_3.Find(var_14_2, "Target"))

	SetComponentEnabled = var_1

	local var_14_3 = arg_14_0._parentClass.scrollView

	typeof = var_4
	ScrollRect = var_6

	var_1(var_14_3, var_4(var_6), true)

	arg_14_0.candicateTarget = nil

	return true
end

function var_0_1.UpdateCandicatePanel(arg_15_0, arg_15_1)
	arg_15_0.candicates = {}

	local var_15_0 = arg_15_0.activity
	local var_15_1 = var_2.GetItems(var_15_0)
	local var_15_2 = arg_15_0.activity
	local var_15_3 = var_3.GetFormulas(var_15_2)[arg_15_0.contextData.formulaId]

	_ = var_4

	local var_15_4 = var_4.map

	pg = var_1_10006

	local var_15_5 = var_15_4(var_1_10006.activity_ryza_item.all, function(arg_16_0)
		local var_16_0

		if not var_15_1[arg_16_0] then
			AtelierMaterial = var_16_0
			var_16_0 = var_16_0.New({
				configId = arg_16_0
			})
		end

		if var_16_0:IsShow() ~= 0 then
			local var_16_1 = arg_15_0.nodeTarget.Data

			if var_2.CanUseMaterial(var_16_1, var_16_0, var_15_3, arg_15_0.contextData.versionIndex) then
				if var_15_1[arg_16_0] then
					AtelierMaterial = var_2
					var_16_0 = var_2.New({
						configId = arg_16_0,
						count = var_15_1[arg_16_0].count
					})
					_ = var_2
					var_16_0.count = var_2.reduce(arg_15_1, var_16_0.count, function(arg_17_0, arg_17_1)
						if arg_17_1.Instance then
							local var_17_0 = arg_17_1.Instance

							if var_2.GetConfigID(var_17_0) == arg_16_0 then
								arg_17_0 = arg_17_0 - 1
							end
						end

						return arg_17_0
					end)
				end

				return var_16_0
			end
		end

		return
	end)

	table = var_15_2

	var_15_2.sort(var_15_5, function(arg_18_0, arg_18_1)
		if arg_18_0.count * arg_18_1.count == 0 and arg_18_0.count - arg_18_1.count ~= 0 then
			return arg_18_0.count < arg_18_1.count
		else
			return arg_18_0:GetConfigID() < arg_18_1:GetConfigID()
		end

		return
	end)

	_ = var_5

	var_5.each(var_15_5, function(arg_19_0)
		local var_19_0 = 1

		math = var_2_10002

		for iter_19_0 = var_19_0, var_2_10002.max(arg_19_0.count, 1) do
			table = var_5

			var_5.insert(arg_15_0.candicates, arg_19_0)
		end

		return
	end)

	local var_15_6 = arg_15_0.candicatesRect

	var_5.SetTotalCount(var_15_6, #arg_15_0.candicates, 0)

	return
end

function var_0_1.willExit(arg_20_0)
	arg_20_0:detach()

	return
end

function var_0_1.HideNodeLinks(arg_21_0, arg_21_1)
	for iter_21_0 = 1, 6 do
		setActive = var_1_10006

		local var_21_0 = arg_21_1:Find("Links")

		var_1_10006(var_8.GetChild(var_21_0, iter_21_0 - 1), false)
	end

	return
end

function var_0_1.PlayBgAnimation(arg_22_0)
	local var_22_0 = arg_22_0._tf
	local var_22_1 = var_1.Find(var_22_0, "TargetBG")

	Quaternion = var_1_10002
	var_22_1.localRotation = var_1_10002.identity

	local var_22_2 = arg_22_0.nodeTarget.Data
	local var_22_3 = var_2.GetType(var_22_2)

	AtelierFormulaCircle = var_22_0

	local var_22_4 = var_22_3 == var_22_0.TYPE.BASE and 300 or 245

	setSizeDelta = var_3

	var_3(var_22_1, {
		x = var_22_4,
		y = var_22_4
	})

	GetComponent = var_3

	local var_22_5 = var_22_1

	typeof = var_6
	Animator = var_1_10008

	local var_22_6 = var_3(var_22_5, var_6(var_1_10008))

	var_3.SetBool(var_22_6, "Selecting", true)

	return
end

function var_0_1.StopBgAnimation(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0._parentClass

	var_2.LoadingOn(var_23_0)

	GetComponent = var_2

	local var_23_1 = arg_23_0._tf
	local var_23_2 = var_4.Find(var_23_1, "TargetBG")

	typeof = var_1_10005
	DftAniEvent = var_7

	local var_23_3 = var_2(var_23_2, var_1_10005(var_7))

	var_2.SetEndEvent(var_23_3, function()
		local var_24_0 = arg_23_0._parentClass

		var_0.LoadingOff(var_24_0)
		arg_23_1()

		local var_24_1 = var_0

		var_0.SetEndEvent(var_24_1, nil)

		return
	end)

	GetComponent = var_3

	local var_23_4 = arg_23_0._tf
	local var_23_5 = var_5.Find(var_23_4, "TargetBG")

	typeof = var_6
	Animator = var_8

	local var_23_6 = var_3(var_23_5, var_6(var_8))

	var_3.SetBool(var_23_6, "Selecting", false)

	return
end

return var_0_1
