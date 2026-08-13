class = var_0_10000

local var_0_0 = "CourtyardPlayTheLutePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardBaseSubPage"))

function var_0_1.getUIName(arg_1_0)
	return "CourtyardPlayTheLuteui"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "back")

	local var_2_1 = arg_2_0._tf

	arg_2_0.tpl = var_1.Find(var_2_1, "keys/key")

	local var_2_2 = arg_2_0._tf

	arg_2_0.noteTr = var_1.Find(var_2_2, "prints/tansou_yinfu")
	arg_2_0.keyTplPool = {
		arg_2_0.tpl
	}
	arg_2_0.tpls = {}

	return
end

function var_0_1.Show(arg_3_0, arg_3_1)
	arg_3_0.furniture = arg_3_1
	Input = var_1_10002
	var_1_10002.multiTouchEnabled = true

	if arg_3_0.isInit then
		arg_3_0:BlurPanel()
	else
		seriesAsync = var_2

		var_2({
			function(arg_4_0)
				local var_4_0 = arg_3_0

				var_1.InitKeys(var_4_0, arg_4_0)

				return
			end,
			function(arg_5_0)
				arg_3_0.isInit = true

				local var_5_0 = arg_3_0

				var_1.RegisetEvent(var_5_0)

				onNextTick = var_1

				var_1(arg_5_0)

				return
			end,
			function(arg_6_0)
				local var_6_0 = arg_3_0

				var_1.BlurPanel(var_6_0)
				arg_6_0()

				return
			end
		})
	end

	return
end

function var_0_1.BlurPanel(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_7_0, arg_7_0._tf)
	var_0_1.super.Show(arg_7_0)

	return
end

function var_0_1.GetKeys(arg_8_0)
	return {
		{
			"7D",
			"pipa_1"
		},
		{
			"1",
			"pipa_2"
		},
		{
			"2",
			"pipa_5"
		},
		{
			"3",
			"pipa_7"
		},
		{
			"4",
			"pipa_9"
		},
		{
			"5",
			"pipa_11"
		},
		{
			"6",
			"pipa_13"
		},
		{
			"7",
			"pipa_15"
		},
		{
			"D1",
			"pipa_3"
		},
		{
			"D2",
			"pipa_6"
		},
		{
			"D3",
			"pipa_8"
		},
		{
			"D4",
			"pipa_10"
		},
		{
			"D5",
			"pipa_12"
		},
		{
			"D6",
			"pipa_14"
		},
		{
			"D7",
			"pipa_16"
		},
		{
			"DD1",
			"pipa_4"
		}
	}
end

function var_0_1.GetTpl(arg_9_0)
	local var_9_0 = #arg_9_0.keyTplPool

	if 0 < var_9_0 then
		table = var_9_0

		return var_9_0.remove(arg_9_0.keyTplPool, 1)
	else
		local var_9_1 = arg_9_0.tpl

		Object = var_2

		return var_2.Instantiate(var_9_1, var_9_1.parent)
	end

	return
end

function var_0_1.InitKeys(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:GetKeys()
	local var_10_1 = {}

	ipairs = var_1_10004

	for iter_10_0, iter_10_1 in var_1_10004(var_10_0) do
		table = var_1_10009

		var_1_10009.insert(var_10_1, function(arg_11_0)
			local var_11_0 = arg_10_0
			local var_11_1 = var_1.GetTpl(var_11_0)
			local var_11_2 = arg_10_0

			var_2.InitKey(var_11_2, var_11_1, iter_10_1[1], iter_10_1[2])

			table = var_2

			var_2.insert(arg_10_0.tpls, var_11_1)

			if iter_10_0 % 3 == 0 then
				onNextTick = var_2

				var_2(arg_11_0)
			else
				arg_11_0()
			end

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_10_1, arg_10_1)

	return
end

function var_0_1.InitKey(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_1:Find("Text")
	local var_12_1 = var_4.GetComponent

	typeof = var_6
	Image = var_1_10007

	local var_12_2 = var_12_1(var_12_0, var_6(var_1_10007))

	GetSpriteFromAtlas = var_12_0
	var_12_2.sprite = var_12_0("ui/CourtyardLute_atlas", arg_12_2)

	var_12_2:SetNativeSize()

	local var_12_3 = arg_12_1
	local var_12_4 = arg_12_1.Find(var_12_3, "sel")

	onButton = var_12_3

	var_12_3(arg_12_0, arg_12_1, function()
		setActive = var_2_10000

		var_2_10000(var_12_4, true)

		local var_13_0 = arg_12_0

		var_0.AnimationForKey(var_13_0, arg_12_1)

		pg = var_0

		local var_13_1 = var_0.CriMgr.GetInstance()

		var_0.PlaySoundEffect_V3(var_13_1, "event:/ui/" .. arg_12_3)

		local var_13_2 = arg_12_0

		var_0.OnStartPlay(var_13_2, arg_12_2)

		return
	end)

	local var_12_5 = arg_12_1:Find("animation")
	local var_12_6 = var_6.GetComponent

	typeof = var_8
	DftAniEvent = var_9

	local var_12_7 = var_12_6(var_12_5, var_8(var_9))

	var_6.SetEndEvent(var_12_7, function()
		setActive = var_2_10000

		var_2_10000(var_12_4, false)

		local var_14_0 = arg_12_0

		var_0.OnEndPlay(var_14_0, arg_12_2)

		return
	end)

	return
end

function var_0_1.OnStartPlay(arg_15_0, arg_15_1)
	return
end

function var_0_1.OnEndPlay(arg_16_0, arg_16_1)
	return
end

function var_0_1.AnimationForKey(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1:Find("animation")
	local var_17_1 = var_2.GetComponent

	typeof = var_4
	Animation = var_1_10005

	local var_17_2 = var_17_1(var_17_0, var_4(var_1_10005))

	var_2.Stop(var_17_2)
	var_2:Play()

	return
end

function var_0_1.ClearAnimationForKey(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:Find("animation")
	local var_18_1 = var_2.GetComponent

	typeof = var_4
	Animation = var_1_10005

	local var_18_2 = var_18_1(var_18_0, var_4(var_1_10005))

	var_2.Stop(var_18_2)

	local var_18_3 = arg_18_1:Find("animation")
	local var_18_4 = var_3.GetComponent

	typeof = var_5
	DftAniEvent = var_1_10006

	local var_18_5 = var_18_4(var_18_3, var_5(var_1_10006))

	var_3.SetEndEvent(var_18_5, nil)

	return
end

function var_0_1.RegisetEvent(arg_19_0)
	onButton = var_1_10001

	local var_19_0 = arg_19_0
	local var_19_1 = arg_19_0.backBtn

	local function var_19_2()
		local var_20_0 = arg_19_0

		var_0.Hide(var_20_0)

		return
	end

	SFX = var_1_10005

	var_1_10001(var_19_0, var_19_1, var_19_2, var_1_10005)

	return
end

function var_0_1.Hide(arg_21_0)
	Input = var_1_10001
	var_1_10001.multiTouchEnabled = false

	var_0_1.super.Hide(arg_21_0)

	pg = var_1

	local var_21_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_21_0, arg_21_0._tf, arg_21_0._parentTf)
	arg_21_0:Emit("StopPlayMusicalInstruments", arg_21_0.furniture.id)

	return
end

function var_0_1.ClearAllAnimation(arg_22_0)
	ipairs = var_1_10001

	for iter_22_0, iter_22_1 in var_1_10001(arg_22_0.tpls) do
		arg_22_0:ClearAnimationForKey(iter_22_1)
	end

	return
end

function var_0_1.OnDestroy(arg_23_0)
	arg_23_0:ClearAllAnimation()

	if arg_23_0:isShowing() then
		arg_23_0:Hide()
	end

	return
end

return var_0_1
