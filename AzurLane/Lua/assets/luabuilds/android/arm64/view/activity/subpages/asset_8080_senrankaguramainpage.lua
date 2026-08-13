class = var_0_10000

local var_0_0 = "SenrankaguraMainPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PreviewTemplatePage"))

var_0_1.SWITCH_INTERVAL = 6
var_0_1.SWITCH_TIME = 0.5
var_0_1.SWITCH_WIDTH = 367
var_0_1.TACHIE_DELAY = 0.03

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD/mask")

	local var_1_1 = arg_1_0.bg

	arg_1_0.btnList = var_1.Find(var_1_1, "btn_list")

	local var_1_2 = arg_1_0.bg

	arg_1_0.main = var_1.Find(var_1_2, "main")
	arg_1_0.totalNum = arg_1_0.main.childCount
	arg_1_0.randomList = {}
	arg_1_0.children = {}

	for iter_1_0 = 1, arg_1_0.totalNum do
		local var_1_3 = arg_1_0.main
		local var_1_4 = var_5.GetChild(var_1_3, iter_1_0 - 1)

		table = var_1_10006

		var_1_10006.insert(arg_1_0.children, var_1_4)

		setActive = var_1_10006

		var_1_10006(var_1_4, false)

		PLATFORM_CODE = var_1_10006
		PLATFORM_CH = var_1_3

		if var_1_10006 ~= var_1_3 then
			findTF = var_1_10006

			if var_1_10006(var_1_4, "hx") then
				setActive = var_1_3

				var_1_3(var_1_10006, false)
			end
		end
	end

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.btnList
	local var_2_2 = var_4.Find(var_2_1, "mountain")

	local function var_2_3()
		pg = var_2_10000

		local var_3_0 = var_2_10000.m02
		local var_3_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_3_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_3_1(var_3_0, var_3_2, var_2_10004.SENRANKAGURA_BACKHILL)

		return
	end

	SFX_PANEL = var_2_1

	var_1(var_2_0, var_2_2, var_2_3, var_2_1)

	for iter_2_0 = 1, arg_2_0.totalNum do
		table = var_2_3

		var_2_3.insert(arg_2_0.randomList, iter_2_0)
	end

	shuffle = var_1

	var_1(arg_2_0.randomList)

	arg_2_0.index = 1
	setActive = var_1

	var_1(arg_2_0.children[arg_2_0.randomList[arg_2_0.index]], true)

	arg_2_0.LTList = {}

	function arg_2_0.Interval()
		table = var_2_10000

		local var_4_0 = var_2_10000.insert
		local var_4_1 = arg_2_0.LTList

		LeanTween = var_2_10003

		local var_4_2 = var_2_10003.delayedCall

		go = var_2_10005

		local var_4_3 = var_2_10005(arg_2_0._tf)
		local var_4_4 = var_0_1.SWITCH_INTERVAL

		System = var_7

		var_4_0(var_4_1, var_4_2(var_4_3, var_4_4, var_7.Action(arg_2_0.FadeIn)).uniqueId)

		return
	end

	function arg_2_0.FadeIn()
		local var_5_0 = arg_2_0.children[arg_2_0.randomList[arg_2_0.index]]

		arg_2_0.index = arg_2_0.index % arg_2_0.totalNum + 1

		local var_5_1 = arg_2_0.children[arg_2_0.randomList[arg_2_0.index]]
		local var_5_2 = var_0_1.SWITCH_WIDTH

		setActive = var_3

		var_3(var_5_1, true)

		local var_5_3 = {}

		findTF = var_2_10004
		var_5_3[1] = var_2_10004(var_5_1, "bg")
		findTF = var_4
		var_5_3[2] = var_4(var_5_1, "tachie")
		findTF = var_4
		var_5_3[3] = var_4(var_5_1, "hx")

		local var_5_4 = {}

		findTF = var_5
		var_5_4[1] = var_5(var_5_0, "bg")
		findTF = var_5
		var_5_4[2] = var_5(var_5_0, "tachie")
		findTF = var_5
		var_5_4[3] = var_5(var_5_0, "hx")

		local var_5_5 = {
			0,
			var_0_1.TACHIE_DELAY,
			var_0_1.TACHIE_DELAY
		}

		table = var_6

		local var_5_6 = var_6.insert
		local var_5_7 = arg_2_0.LTList

		LeanTween = var_2_10009

		local var_5_8 = var_2_10009.delayedCall

		go = var_2_10011

		local var_5_9 = var_2_10011(arg_2_0._tf)
		local var_5_10 = var_0_1.SWITCH_TIME + var_0_1.TACHIE_DELAY

		System = var_13

		var_5_6(var_5_7, var_5_8(var_5_9, var_5_10, var_13.Action(arg_2_0.Interval)).uniqueId)

		table = var_5_6

		var_5_6.Foreach(var_5_3, function(arg_6_0, arg_6_1)
			setImageAlpha = var_3_10002

			var_3_10002(arg_6_1, 0)

			rtf = var_3_10002

			local var_6_0 = var_3_10002(arg_6_1).anchoredPosition.x

			setAnchoredPosition = var_3_10003

			var_3_10003(arg_6_1, {
				x = var_5_2 + var_6_0
			})

			local function var_6_1()
				table = var_4_10000

				local var_7_0 = var_4_10000.insert
				local var_7_1 = arg_2_0.LTList

				LeanTween = var_4_10003

				local var_7_2 = var_4_10003.alpha(arg_6_1, 1, var_0_1.SWITCH_TIME)
				local var_7_3 = var_3.setEase

				LeanTweenType = var_6

				var_7_0(var_7_1, var_7_3(var_7_2, var_6.easeOutSine).uniqueId)

				table = var_7_0

				local var_7_4 = var_7_0.insert
				local var_7_5 = arg_2_0.LTList

				LeanTween = var_3

				local var_7_6 = var_3.moveX

				rtf = var_7_2

				local var_7_7 = var_7_6(var_7_2(arg_6_1), 0 + var_6_0, var_0_1.SWITCH_TIME)
				local var_7_8 = var_3.setEase

				LeanTweenType = var_6

				var_7_4(var_7_5, var_7_8(var_7_7, var_6.easeOutSine).uniqueId)

				return
			end

			if var_5_5[arg_6_0] > 0 then
				table = var_4

				local var_6_2 = var_4.insert
				local var_6_3 = arg_2_0.LTList

				LeanTween = var_7

				local var_6_4 = var_7.delayedCall

				go = var_3_10009

				local var_6_5 = var_3_10009(arg_6_1)
				local var_6_6 = var_5_5[arg_6_0]

				System = var_11

				var_6_2(var_6_3, var_6_4(var_6_5, var_6_6, var_11.Action(var_6_1)).uniqueId)
			else
				var_6_1()
			end

			return
		end)

		table = var_6

		var_6.Foreach(var_5_4, function(arg_8_0, arg_8_1)
			rtf = var_3_10002

			local var_8_0 = var_3_10002(arg_8_1).anchoredPosition.x

			local function var_8_1()
				setAnchoredPosition = var_4_10000

				var_4_10000(arg_8_1, {
					x = var_8_0
				})

				return
			end

			local function var_8_2()
				table = var_4_10000

				local var_10_0 = var_4_10000.insert
				local var_10_1 = arg_2_0.LTList

				LeanTween = var_4_10003

				local var_10_2 = var_4_10003.alpha(arg_8_1, 0, var_0_1.SWITCH_TIME)
				local var_10_3 = var_3.setEase

				LeanTweenType = var_6

				var_10_0(var_10_1, var_10_3(var_10_2, var_6.easeOutSine).uniqueId)

				table = var_10_0

				local var_10_4 = var_10_0.insert
				local var_10_5 = arg_2_0.LTList

				LeanTween = var_3

				local var_10_6 = var_3.moveX

				rtf = var_10_2

				local var_10_7 = var_10_6(var_10_2(arg_8_1), -var_5_2 + var_8_0, var_0_1.SWITCH_TIME)
				local var_10_8 = var_3.setOnComplete

				System = var_6

				local var_10_9 = var_10_8(var_10_7, var_6.Action(var_8_1))
				local var_10_10 = var_3.setEase

				LeanTweenType = var_6

				var_10_4(var_10_5, var_10_10(var_10_9, var_6.easeOutSine).uniqueId)

				return
			end

			if var_5_5[arg_8_0] > 0 then
				table = var_5

				local var_8_3 = var_5.insert
				local var_8_4 = arg_2_0.LTList

				LeanTween = var_3_10008

				local var_8_5 = var_3_10008.delayedCall

				go = var_3_10010

				local var_8_6 = var_3_10010(arg_8_1)
				local var_8_7 = var_5_5[arg_8_0]

				System = var_12

				var_8_3(var_8_4, var_8_5(var_8_6, var_8_7, var_12.Action(var_8_2)).uniqueId)
			else
				var_8_2()
			end

			return
		end)

		return
	end

	arg_2_0.Interval()

	return
end

function var_0_1.OnDestroy(arg_11_0)
	ipairs = var_1_10001

	local var_11_0

	if not arg_11_0.LTList then
		var_11_0 = {}
	end

	for iter_11_0, iter_11_1 in var_1_10001(var_11_0) do
		LeanTween = var_1_10006

		var_1_10006.cancel(iter_11_1)
	end

	return
end

return var_0_1
