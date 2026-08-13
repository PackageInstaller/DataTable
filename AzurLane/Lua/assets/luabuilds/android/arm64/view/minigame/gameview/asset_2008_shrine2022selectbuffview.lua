class = var_0_10000

local var_0_0 = "Shrine2022SelectBuffView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "Shrine2022SelectBuffUI"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()

	pg = var_1

	local var_2_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf)
	arg_2_0:Show()
	arg_2_0:playEnterAni(true)

	return
end

function var_0_1.OnDestroy(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_3_0, arg_3_0._tf)
	arg_3_0:cleanManagedTween()

	return
end

function var_0_1.initData(arg_4_0)
	arg_4_0.onSelectFunc = arg_4_0.contextData.onSelect

	return
end

function var_0_1.initUI(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.bg = var_1.Find(var_5_0, "BG")

	local var_5_1 = arg_5_0._tf

	arg_5_0.cloud1 = var_1.Find(var_5_1, "Cloud1")

	local var_5_2 = arg_5_0._tf

	arg_5_0.cloud2 = var_1.Find(var_5_2, "Cloud2")

	local var_5_3 = arg_5_0._tf

	arg_5_0.buffListTF = var_1.Find(var_5_3, "BuffContainer")
	GetComponent = var_1
	arg_5_0.buffListCG = var_1(arg_5_0.buffListTF, "CanvasGroup")

	for iter_5_0 = 1, 3 do
		local var_5_4 = arg_5_0.buffListTF
		local var_5_5 = var_5.GetChild(var_5_4, iter_5_0 - 1)

		onButton = var_1_10006

		local var_5_6 = arg_5_0
		local var_5_7 = var_5_5

		local function var_5_8()
			if arg_5_0.onSelectFunc then
				arg_5_0.onSelectFunc(iter_5_0)
			end

			local var_6_0 = arg_5_0

			var_0.closeMySelf(var_6_0)

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_5_6, var_5_7, var_5_8, var_1_10011)
	end

	onButton = var_1

	local var_5_9 = arg_5_0
	local var_5_10 = arg_5_0.bg

	local function var_5_11()
		local var_7_0 = arg_5_0

		var_0.closeMySelf(var_7_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_5_9, var_5_10, var_5_11, var_1_10006)

	return
end

function var_0_1.playEnterAni(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1 and 1000 or 0
	local var_8_1 = arg_8_1 and 0 or 1000
	local var_8_2 = {
		x = var_8_0
	}

	rtf = var_1_10006
	var_8_2.y = var_1_10006(arg_8_0.cloud1).anchoredPosition.y

	local var_8_3 = arg_8_1 and -1000 or 0
	local var_8_4 = arg_8_1 and 0 or -1000
	local var_8_5 = {
		x = var_8_3
	}

	rtf = var_1_10009
	var_8_5.y = var_1_10009(arg_8_0.cloud2).anchoredPosition.y

	local var_8_6 = arg_8_1 and 0 or 1
	local var_8_7 = arg_8_1 and 1 or 0
	local var_8_8 = 0.3

	arg_8_0.isPlaying = true

	local var_8_9 = arg_8_0
	local var_8_10 = arg_8_0.managedTween

	LeanTween = var_1_10015

	local var_8_11 = var_1_10015.value
	local var_8_12

	go = var_1_10017

	local var_8_13 = var_8_10(var_8_9, var_8_11, var_8_12, var_1_10017(arg_8_0.cloud1), 0, 1, var_8_8)
	local var_8_14 = var_12.setOnUpdate

	System = var_8_11

	local var_8_15 = var_8_14(var_8_13, var_8_11.Action_float(function(arg_9_0)
		local var_9_0 = var_8_0 + (var_8_1 - var_8_0) * arg_9_0
		local var_9_1 = var_8_3 + (var_8_4 - var_8_3) * arg_9_0
		local var_9_2 = var_8_6 + (var_8_7 - var_8_6) * arg_9_0
		local var_9_3 = var_8_2

		var_9_3.x = var_9_0
		setAnchoredPosition = var_9_3

		var_9_3(arg_8_0.cloud1, var_8_2)

		local var_9_4 = var_8_5

		var_9_4.x = var_9_1
		setAnchoredPosition = var_9_4

		var_9_4(arg_8_0.cloud2, var_8_5)

		arg_8_0.buffListCG.alpha = var_9_2

		return
	end))
	local var_8_16 = var_12.setOnComplete

	System = var_15

	var_8_16(var_8_15, var_15.Action(function()
		arg_8_0.isPlaying = false

		if arg_8_2 then
			arg_8_2()
		end

		return
	end))

	return
end

function var_0_1.closeMySelf(arg_11_0)
	if arg_11_0.isPlaying then
		return
	end

	arg_11_0:playEnterAni(false, function()
		local var_12_0 = arg_11_0

		var_0.Destroy(var_12_0)

		return
	end)

	return
end

return var_0_1
