class = var_0_10000

local var_0_0 = "CryptolaliaListView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CryptolaliaListui"
end

function var_0_1.OnLoaded(arg_2_0)
	arg_2_0.cards = {}

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/view")

	arg_2_0.scrollrect = var_1.GetComponent(var_2_1, "LScrollRect")

	function arg_2_0.scrollrect.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.OnInitItem(var_3_0, arg_3_0)

		return
	end

	function arg_2_0.scrollrect.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.onUpdateItem(var_4_0, arg_4_0, arg_4_1)

		return
	end

	local var_2_2 = arg_2_0._tf

	arg_2_0.frameTr = var_1.Find(var_2_2, "frame")

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "frame/subtitle")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.subTitleTxt = var_2_5(var_2_4, var_4(var_1_10006))
	setText = var_1

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_3.Find(var_2_6, "frame/title")

	i18n = var_4

	var_1(var_2_7, var_4("cryptolalia_list_title"))

	return
end

function var_0_1.OnInit(arg_5_0)
	return
end

function var_0_1.OnInitItem(arg_6_0, arg_6_1)
	local function var_6_0()
		if not arg_6_0.cryptolaliaId then
			return
		end

		pairs = var_0

		for iter_7_0, iter_7_1 in var_0(arg_6_0.cards) do
			if iter_7_1.cryptolalia.id == arg_6_0.cryptolaliaId then
				iter_7_1:Update(iter_7_1.cryptolalia, arg_6_0.langType, false)
			end
		end

		return
	end

	CryptolaliaCard = var_1_10003

	local var_6_1 = var_1_10003.New(arg_6_1)

	onButton = var_1_10004

	local var_6_2 = arg_6_0
	local var_6_3 = var_6_1._go

	local function var_6_4()
		local var_8_0 = arg_6_0

		if var_0.CanSwitch(var_8_0) then
			var_6_0()

			arg_6_0.cryptolaliaId = var_6_1.cryptolalia.id

			local var_8_1 = var_6_1

			var_0.Update(var_8_1, var_6_1.cryptolalia, arg_6_0.langType, true)

			local var_8_2 = arg_6_0

			var_0.SelectCard(var_8_2, arg_6_0.cryptolaliaId)
		end

		return
	end

	SFX_PANEL = var_1_10009

	var_1_10004(var_6_2, var_6_3, var_6_4, var_1_10009)

	arg_6_0.cards[arg_6_1] = var_6_1

	return
end

function var_0_1.CanSwitch(arg_9_0)
	return not arg_9_0.scrollRect.inAnimation
end

function var_0_1.onUpdateItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0

	if not arg_10_0.cards[arg_10_2] then
		arg_10_0:OnInitItem(arg_10_2)

		var_10_0 = arg_10_0.cards[arg_10_2]
	end

	local var_10_1 = arg_10_0.displays[arg_10_1 + 1].id == arg_10_0.cryptolaliaId

	var_10_0:Update(var_4, arg_10_0.langType, var_10_1)

	return
end

function var_0_1.Show(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	arg_11_0.scrollRect = arg_11_4

	var_0_1.super.Show(arg_11_0)

	seriesAsync = var_5

	var_5({
		function(arg_12_0)
			local var_12_0 = arg_11_0

			var_1.EnterAnimation(var_12_0, arg_12_0)

			return
		end,
		function(arg_13_0)
			local var_13_0 = arg_11_0

			var_1.InitList(var_13_0, arg_11_1, arg_11_2, arg_11_3)

			local var_13_1 = arg_11_0

			var_1.RegisterEvent(var_13_1)
			arg_13_0()

			return
		end
	})

	return
end

function var_0_1.EnterAnimation(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.frameTr.sizeDelta.x

	LeanTween = var_1_10003

	local var_14_1 = var_1_10003.value(arg_14_0._tf.gameObject, var_14_0, 0, 0.3)
	local var_14_2 = var_3.setOnUpdate

	System = var_6

	local var_14_3 = var_14_2(var_14_1, var_6.Action_float(function(arg_15_0)
		local var_15_0 = arg_14_0._tf

		Vector3 = var_2_10002
		var_15_0.localPosition = var_2_10002(arg_15_0, arg_14_0._tf.localPosition.y, 0)

		return
	end))
	local var_14_4 = var_3.setFrom(var_14_3, var_14_0)
	local var_14_5 = var_3.setEase

	LeanTweenType = var_6

	local var_14_6 = var_14_5(var_14_4, var_6.easeInOutSine)
	local var_14_7 = var_3.setOnComplete

	System = var_6

	var_14_7(var_14_6, var_6.Action(arg_14_1))

	return
end

function var_0_1.InitList(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0.cryptolaliaId = arg_16_3
	arg_16_0.langType = arg_16_2
	arg_16_0.displays = arg_16_1

	local var_16_0 = arg_16_0.scrollrect

	var_4.SetTotalCount(var_16_0, #arg_16_0.displays)

	local var_16_1 = arg_16_0.subTitleTxt

	i18n = var_1_10005
	var_16_1.text = var_1_10005("cryptolalia_list_subtitle", #arg_16_0.displays)

	return
end

function var_0_1.RegisterEvent(arg_17_0)
	onButton = var_1_10001

	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0._tf

	local function var_17_2()
		local var_18_0 = arg_17_0

		var_0.Hide(var_18_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_17_0, var_17_1, var_17_2, var_1_10006)

	return
end

function var_0_1.Hide(arg_19_0)
	var_0_1.super.Hide(arg_19_0)

	removeOnButton = var_1

	var_1(arg_19_0._tf)

	LeanTween = var_1

	if var_1.isTweening(arg_19_0._tf.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_19_0._tf.gameObject)
	end

	return
end

function var_0_1.SelectCard(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.emit

	CryptolaliaScene = var_1_10005

	var_20_1(var_20_0, var_1_10005.ON_SELECT, arg_20_1)

	return
end

function var_0_1.OnDestroy(arg_21_0)
	pairs = var_1_10001

	for iter_21_0, iter_21_1 in var_1_10001(arg_21_0.cards) do
		iter_21_1:Dispose()
	end

	arg_21_0.cards = {}
	ClearLScrollrect = var_1

	var_1(arg_21_0.scrollrect)

	return
end

return var_0_1
