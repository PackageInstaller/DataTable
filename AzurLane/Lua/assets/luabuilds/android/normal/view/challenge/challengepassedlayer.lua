class = var_0_10000

local var_0_0 = "ChallengePassedLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.BOSS_NUM = 5
var_0_1.GROW_TIME = 0.55

function var_0_1.getUIName(arg_1_0)
	return "ChallengePassedUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:initData()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0.tweenObjs = {}
	pg = var_1

	local var_3_0 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_3_0, arg_3_0._tf)
	arg_3_0:updatePainting(arg_3_0.paintingName, arg_3_0.paintingTF, arg_3_0.paintingShadow1, true)

	if arg_3_0.paintingNamemNext then
		arg_3_0:updatePainting(arg_3_0.paintingNamemNext, arg_3_0.paintingNextTF, arg_3_0.paintingNextShadow1)
	end

	arg_3_0:updateSlider(arg_3_0.curIndex)
	arg_3_0:moveSlider(arg_3_0.curIndex)

	onButton = var_1

	var_1(arg_3_0, arg_3_0._tf, function()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_CLOSE)

		return
	end)

	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_1.GetComponent(var_3_1, "DftAniEvent")

	var_1.SetEndEvent(var_3_2, function(arg_5_0)
		local var_5_0 = arg_3_0

		var_1.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end)

	return
end

function var_0_1.willExit(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_6_0, arg_6_0._tf)

	LeanTween = var_1

	local var_6_1 = var_1.cancel

	go = var_6_0

	var_6_1(var_6_0(arg_6_0.slider))

	ipairs = var_6_1

	for iter_6_0, iter_6_1 in var_6_1(arg_6_0.tweenObjs) do
		LeanTween = var_1_10006

		var_1_10006.cancel(iter_6_1)
	end

	arg_6_0.tweenObjs = {}

	return
end

function var_0_1.onBackPressed(arg_7_0)
	triggerButton = var_1_10001

	var_1_10001(arg_7_0._tf)

	return
end

function var_0_1.findUI(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0.bg = var_1.Find(var_8_0, "BG")

	local var_8_1 = arg_8_0._tf

	arg_8_0.paintingTF = var_1.Find(var_8_1, "Painting")

	local var_8_2 = arg_8_0._tf

	arg_8_0.paintingShadow1 = var_1.Find(var_8_2, "Painting/PaintingShadow1")

	local var_8_3 = arg_8_0._tf

	arg_8_0.paintingNextTF = var_1.Find(var_8_3, "PaintingNext")

	local var_8_4 = arg_8_0._tf

	arg_8_0.paintingNextShadow1 = var_1.Find(var_8_4, "PaintingNext/PaintingShadow1")

	local var_8_5 = arg_8_0._tf
	local var_8_6 = var_1.Find(var_8_5, "material1")
	local var_8_7 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_8_0.material1 = var_8_7(var_8_6, var_3(var_1_10004)).material

	local var_8_8 = arg_8_0._tf

	arg_8_0.slider = var_1.Find(var_8_8, "Slider")

	local var_8_9 = arg_8_0.slider

	arg_8_0.squareContainer = var_1.Find(var_8_9, "SquareList")

	local var_8_10 = arg_8_0.slider

	arg_8_0.squareTpl = var_1.Find(var_8_10, "Squre")
	UIItemList = var_1
	arg_8_0.squareList = var_1.New(arg_8_0.squareContainer, arg_8_0.squareTpl)
	GetComponent = var_1
	arg_8_0.sliderSC = var_1(arg_8_0.slider, "Slider")

	return
end

function var_0_1.initData(arg_9_0)
	local var_9_0 = arg_9_0.contextData.mode

	getProxy = var_1_10002
	ChallengeProxy = var_1_10003

	local var_9_1 = var_1_10002(var_1_10003)
	local var_9_2 = var_2.getUserChallengeInfo(var_9_1, var_9_0)

	arg_9_0.curIndex = var_2.getLevel(var_9_2)

	local var_9_3 = arg_9_0.curIndex

	ChallengeConst = var_9_2

	local var_9_4

	if var_9_3 % var_9_2.BOSS_NUM == 0 then
		ChallengeConst = var_4
		var_9_4 = var_4.BOSS_NUM
	end

	local var_9_5 = var_2:getDungeonIDList()[var_9_4]
	local var_9_6 = 0

	ChallengeProxy = var_1_10007

	if var_9_0 == var_1_10007.MODE_CASUAL then
		ChallengeConst = var_7

		if var_9_4 ~= var_7.BOSS_NUM then
			var_9_6 = var_4[var_9_4 + 1]
		end
	else
		ChallengeConst = var_7

		if var_9_4 == var_7.BOSS_NUM then
			var_9_6 = var_2:getNextInfiniteDungeonIDList()[1]
		else
			var_9_6 = var_4[var_9_4 + 1]
		end
	end

	pg = var_7
	arg_9_0.paintingName = var_7.expedition_challenge_template[var_9_5].char_icon[1]

	if var_9_6 ~= 0 then
		pg = var_7
		arg_9_0.paintingNamemNext = var_7.expedition_challenge_template[var_9_6].char_icon[1]
	end

	return
end

function var_0_1.addListener(arg_10_0)
	onButton = var_1_10001

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0._tf

	local function var_10_2()
		LeanTween = var_2_10000

		local var_11_0 = var_2_10000.cancel

		go = var_2_10001

		var_11_0(var_2_10001(arg_10_0.slider))

		local var_11_1 = arg_10_0

		var_0.emit(var_11_1, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_10_0, var_10_1, var_10_2, var_1_10005)

	return
end

function var_0_1.updatePainting(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local function var_12_0(arg_13_0)
		local var_13_0 = arg_13_0.material

		var_1.SetFloat(var_13_0, "_LineGray", 0.3)

		local var_13_1 = arg_13_0.material

		var_1.SetFloat(var_13_1, "_TearDistance", 0)

		LeanTween = var_1

		var_1.cancel(arg_13_0.gameObject)

		table = var_1

		var_1.insert(arg_12_0.tweenObjs, arg_13_0.gameObject)

		LeanTween = var_1

		local var_13_2 = var_1.value(arg_13_0.gameObject, 0, 2, 2)
		local var_13_3 = var_1.setLoopClamp(var_13_2)
		local var_13_4 = var_1.setOnUpdate

		System = var_3

		var_13_4(var_13_3, var_3.Action_float(function(arg_14_0)
			if arg_14_0 >= 1.2 then
				local var_14_0 = arg_13_0.material

				var_1.SetFloat(var_14_0, "_LineGray", 0.3)
			elseif arg_14_0 >= 1.1 then
				local var_14_1 = arg_13_0.material

				var_1.SetFloat(var_14_1, "_LineGray", 0.45)
			elseif arg_14_0 >= 1.03 then
				local var_14_2 = arg_13_0.material

				var_1.SetFloat(var_14_2, "_TearDistance", 0)
			elseif arg_14_0 >= 1 then
				local var_14_3 = arg_13_0.material

				var_1.SetFloat(var_14_3, "_TearDistance", 0.3)
			elseif arg_14_0 >= 0.35 then
				local var_14_4 = arg_13_0.material

				var_1.SetFloat(var_14_4, "_LineGray", 0.3)
			elseif arg_14_0 >= 0.3 then
				local var_14_5 = arg_13_0.material

				var_1.SetFloat(var_14_5, "_LineGray", 0.4)
			elseif arg_14_0 >= 0.25 then
				local var_14_6 = arg_13_0.material

				var_1.SetFloat(var_14_6, "_LineGray", 0.3)
			elseif arg_14_0 >= 0.2 then
				local var_14_7 = arg_13_0.material

				var_1.SetFloat(var_14_7, "_LineGray", 0.4)
			end

			return
		end))

		return
	end

	setPaintingPrefab = var_1_10006

	var_1_10006(arg_12_2, arg_12_1, "chuanwu")

	local var_12_1 = arg_12_2:Find("fitter")

	if var_6.GetChild(var_12_1, 0) then
		GetComponent = var_12_1
		var_12_1 = var_12_1(var_6, "MeshImage")

		if arg_12_4 then
			var_12_1.material = arg_12_0.material1

			local var_12_2 = var_12_1.material

			var_8.SetFloat(var_12_2, "_LineDensity", 7)
			var_12_0(var_12_1)
		end
	end

	setPaintingPrefabAsync = var_12_1

	var_12_1(arg_12_3, arg_12_1, "chuanwu")

	local var_12_3 = arg_12_3:Find("fitter")

	if var_7.GetChild(var_12_3, 0) then
		local var_12_4 = var_7

		var_12_3 = var_7.GetComponent(var_12_4, "Image")
		Color = var_12_4
		var_12_3.color = var_12_4.New(1, 1, 1, 0.15)
	end

	Vector3 = var_12_3
	arg_12_3.localScale = var_12_3(2.2, 2.2, 1)

	return
end

function var_0_1.updateSlider(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1 or arg_15_0.curIndex

	ChallengeConst = var_1_10003

	if var_1_10003.BOSS_NUM < var_15_0 then
		ChallengeConst = var_3

		if var_15_0 % var_3.BOSS_NUM == 0 then
			ChallengeConst = var_3

			if not var_3.BOSS_NUM then
				::label_15_0::

				ChallengeConst = var_3
				var_15_0 = var_15_0 % var_3.BOSS_NUM
			end

			ChallengeConst = var_3

			local var_15_1 = 1 / (var_3.BOSS_NUM - 1)
			local var_15_2 = (var_15_0 - 1) * var_15_1

			arg_15_0.sliderSC.value = var_15_2

			local var_15_3 = arg_15_0.squareList

			var_5.make(var_15_3, function(arg_16_0, arg_16_1, arg_16_2)
				local var_16_0 = arg_16_2:Find("UnFinished")
				local var_16_1 = arg_16_2:Find("Finished")
				local var_16_2 = arg_16_2:Find("Challengeing")
				local var_16_3 = arg_16_2:Find("Arrow")

				local function var_16_4()
					setActive = var_3_10000

					var_3_10000(var_16_1, true)

					setActive = var_3_10000

					var_3_10000(var_16_0, false)

					setActive = var_3_10000

					var_3_10000(var_16_2, false)

					return
				end

				local function var_16_5()
					setActive = var_3_10000

					var_3_10000(var_16_1, false)

					setActive = var_3_10000

					var_3_10000(var_16_0, true)

					setActive = var_3_10000

					var_3_10000(var_16_2, false)

					return
				end

				local function var_16_6()
					setActive = var_3_10000

					var_3_10000(var_16_1, false)

					setActive = var_3_10000

					var_3_10000(var_16_0, false)

					setActive = var_3_10000

					var_3_10000(var_16_2, true)

					return
				end

				UIItemList = var_2_10010

				if arg_16_0 == var_2_10010.EventUpdate then
					if arg_16_1 + 1 < var_15_0 then
						setActive = var_10

						var_10(var_16_3, false)
						var_16_4()
					elseif arg_16_1 + 1 == var_15_0 then
						setActive = var_10

						var_10(var_16_3, true)
						var_16_6()
					elseif arg_16_1 + 1 > var_15_0 then
						setActive = var_10

						var_10(var_16_3, false)
						var_16_5()
					end
				end

				return
			end)

			local var_15_4 = arg_15_0.squareList
			local var_15_5 = var_5.align

			ChallengeConst = var_7

			var_15_5(var_15_4, var_7.BOSS_NUM)

			return
		end
	end
end

function var_0_1.moveSlider(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1 or arg_20_0.curIndex

	ChallengeConst = var_1_10003

	if var_1_10003.BOSS_NUM < var_20_0 then
		ChallengeConst = var_3

		if var_20_0 % var_3.BOSS_NUM == 0 then
			ChallengeConst = var_3

			if not var_3.BOSS_NUM then
				::label_20_0::

				ChallengeConst = var_3
				var_20_0 = var_20_0 % var_3.BOSS_NUM
			end

			ChallengeConst = var_3

			local var_20_1 = 1 / (var_3.BOSS_NUM - 1)
			local var_20_2 = (var_20_0 - 1) * var_20_1
			local var_20_3 = var_20_0 * var_20_1

			LeanTween = var_1_10006

			local var_20_4 = var_1_10006.value

			go = var_1_10007

			local var_20_5 = var_20_4(var_1_10007(arg_20_0.slider), var_20_2, var_20_3, var_0_1.GROW_TIME)
			local var_20_6 = var_6.setDelay(var_20_5, 1.4)
			local var_20_7 = var_6.setOnUpdate

			System = var_8

			local var_20_8 = var_20_7(var_20_6, var_8.Action_float(function(arg_21_0)
				arg_20_0.sliderSC.value = arg_21_0

				return
			end))
			local var_20_9 = var_6.setOnComplete

			System = var_8

			var_20_9(var_20_8, var_8.Action(function()
				local var_22_0 = arg_20_0

				var_0.updateSlider(var_22_0, var_20_0 + 1)

				return
			end))

			return
		end
	end
end

return var_0_1
