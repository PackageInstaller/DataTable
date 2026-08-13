class = var_0_10000

local var_0_0 = var_0_10000("DOAPPMiniGameController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.binder = arg_1_1

	arg_1_0:InitTimer()
	arg_1_0:InitGameUI(arg_1_2)

	return
end

local function var_0_1(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.GetComponentsInChildren

	typeof = var_1_10004
	Animator = var_1_10005

	local var_2_2 = var_2_1(var_2_0, var_1_10004(var_1_10005), true)
	local var_2_3 = var_2.ToTable(var_2_2)

	ipairs = var_2_2

	for iter_2_0, iter_2_1 in var_2_2(var_2_3) do
		iter_2_1.speed = arg_2_1
	end

	return
end

function var_0_0.InitTimer(arg_3_0)
	Timer = var_1_10001

	local var_3_0 = var_1_10001.New

	local function var_3_1()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.OnTimer

		DOAPPGameConfig = var_2_10002

		var_4_1(var_4_0, var_2_10002.TIME_INTERVAL)

		return
	end

	DOAPPGameConfig = var_1_10003
	arg_3_0.timer = var_3_0(var_3_1, var_1_10003.TIME_INTERVAL, -1)
	IsUnityEditor = var_1

	if var_1 and not arg_3_0.handle then
		UpdateBeat = var_1
		arg_3_0.handle = var_1:CreateListener(arg_3_0.AddDebugInput, arg_3_0)
		UpdateBeat = var_1

		var_1:AddListener(arg_3_0.handle)
	end

	return
end

function var_0_0.AddDebugInput(arg_5_0)
	local var_5_0 = {
		"E",
		"S",
		"W",
		"N"
	}
	local var_5_1 = {
		"D",
		"S",
		"A",
		"W"
	}

	ipairs = var_1_10003

	for iter_5_0, iter_5_1 in var_1_10003(var_5_1) do
		Input = var_1_10008
		var_1_10008 = var_1_10008.GetKeyDown
		KeyCode = var_1_10009

		if var_1_10008(var_1_10009[iter_5_1]) then
			arg_5_0.cacheInput = var_5_0[iter_5_0]
		end

		Input = var_1_10008
		var_1_10008 = var_1_10008.GetKeyUp
		KeyCode = var_1_10009

		if var_1_10008(var_1_10009[iter_5_1]) and arg_5_0.cacheInput == var_5_0[iter_5_0] then
			arg_5_0.cacheInput = nil
		end
	end

	return
end

local var_0_2 = {
	"Light",
	"Heavy",
	"Dodge"
}

function var_0_0.InitGameUI(arg_6_0, arg_6_1)
	arg_6_0.rtViewport = arg_6_1:Find("Viewport")

	local var_6_0 = arg_6_0.rtViewport

	arg_6_0.rtBg = var_2.Find(var_6_0, "MainContent/bg")

	local var_6_1 = arg_6_0.rtViewport

	arg_6_0.rtCharacter = var_2.Find(var_6_1, "MainContent/character")

	local var_6_2 = arg_6_0.rtViewport

	arg_6_0.rtPlayContent = var_2.Find(var_6_2, "MainContent/playContent")
	arg_6_0.rtBtns = arg_6_1:Find("Controller/middle/btn")
	eachChild = var_2

	var_2(arg_6_0.rtBtns, function(arg_7_0)
		onButton = var_2_10001

		local var_7_0 = arg_6_0.binder
		local var_7_1 = arg_7_0

		local function var_7_2()
			local var_8_0 = arg_6_0

			table = var_3_10001
			var_8_0.selectAction = var_3_10001.indexof(var_0_2, arg_7_0.name)
			setActive = var_8_0

			var_8_0(arg_6_0.rtBtns, false)

			local var_8_1 = arg_6_0

			var_0.AfterSelect(var_8_1)

			return
		end

		SFX_CONFIRM = var_2_10005

		var_2_10001(var_7_0, var_7_1, var_7_2, var_2_10005)

		return
	end)

	setActive = var_2

	var_2(arg_6_0.rtBtns, false)

	arg_6_0.rtFloatUI = arg_6_1:Find("Controller/middle/targetUI")
	setActive = var_2

	var_2(arg_6_0.rtFloatUI, false)

	eachChild = var_2

	local var_6_3 = arg_6_0.rtPlayContent

	var_2(var_3.Find(var_6_3, "middle/EffectObject"), function(arg_9_0)
		local var_9_0 = arg_9_0:Find("Image")
		local var_9_1 = var_1.GetComponent

		typeof = var_3
		DftAniEvent = var_2_10004

		local var_9_2 = var_9_1(var_9_0, var_3(var_2_10004))

		var_1.SetEndEvent(var_9_2, function()
			setActive = var_3_10000

			var_3_10000(arg_9_0, false)

			return
		end)

		return
	end)

	eachChild = var_2

	local var_6_4 = arg_6_0.rtPlayContent

	var_2(var_3.Find(var_6_4, "middle/EffectOtherObject"), function(arg_11_0)
		local var_11_0 = arg_11_0:Find("Image")
		local var_11_1 = var_1.GetComponent

		typeof = var_3
		DftAniEvent = var_2_10004

		local var_11_2 = var_11_1(var_11_0, var_3(var_2_10004))

		var_1.SetEndEvent(var_11_2, function()
			setActive = var_3_10000

			var_3_10000(arg_11_0, false)

			return
		end)

		return
	end)

	arg_6_0.rtPointShow = arg_6_1:Find("Controller/middle/point")
	arg_6_0.textTime = arg_6_1:Find("Controller/top/panel/time")
	arg_6_0.rtPoint = arg_6_1:Find("Controller/top/self")
	arg_6_0.rtPointOther = arg_6_1:Find("Controller/top/others")

	return
end

local var_0_3 = {
	"Misaki",
	"Marie",
	"Tamaki",
	"Luna"
}

function var_0_0.SetCharacter(arg_13_0, arg_13_1)
	table = var_1_10002

	local var_13_0 = var_1_10002.indexof(var_0_3, arg_13_1)

	cloneTplTo = var_3

	local var_13_1 = arg_13_0.rtCharacter
	local var_13_2 = var_4.Find(var_13_1, arg_13_1)
	local var_13_3 = arg_13_0.rtPlayContent

	arg_13_0.rtTarget = var_3(var_13_2, var_5.Find(var_13_3, "front"), arg_13_1)

	local var_13_4 = arg_13_0.rtTarget
	local var_13_5 = var_3.Find(var_13_4, "Image")
	local var_13_6 = var_3.GetComponent

	typeof = var_5
	DftAniEvent = var_6

	local var_13_7 = var_13_6(var_13_5, var_5(var_6))

	var_3.SetEndEvent(var_13_7, function()
		math = var_2_10000

		if var_2_10000.abs(arg_13_0.deltaMove) > 2 then
			local var_14_0 = arg_13_0

			var_0.ReadyPoint(var_14_0)
		else
			local var_14_1 = arg_13_0

			var_0.UpdateReady(var_14_1, arg_13_0.rtTarget)
		end

		return
	end)
	var_3:SetTriggerEvent(function()
		local var_15_0 = arg_13_0

		var_15_0.countTarget = arg_13_0.countTarget + 1
		eachChild = var_15_0

		local var_15_1 = arg_13_0.rtTarget

		var_15_0(var_1.Find(var_15_1, "effect"), function(arg_16_0)
			if arg_16_0.name == arg_13_0.statusTarget .. "_" .. arg_13_0.countTarget then
				setActive = var_1

				var_1(arg_16_0, true)
			end

			return
		end)

		return
	end)

	eachChild = var_4

	local var_13_8 = arg_13_0.rtTarget

	var_4(var_5.Find(var_13_8, "effect"), function(arg_17_0)
		local var_17_0 = arg_17_0
		local var_17_1 = arg_17_0.GetComponent

		typeof = var_2_10003
		DftAniEvent = var_2_10004

		local var_17_2 = var_17_1(var_17_0, var_2_10003(var_2_10004))

		var_1.SetEndEvent(var_17_2, function()
			setActive = var_3_10000

			var_3_10000(arg_17_0, false)

			return
		end)

		return
	end)

	eachChild = var_4

	local var_13_9 = arg_13_0.rtPoint

	var_4(var_5.Find(var_13_9, "icon/mask"), function(arg_19_0)
		setActive = var_2_10001

		var_2_10001(arg_19_0, arg_19_0.name == arg_13_1)

		return
	end)

	local var_13_10 = var_0_3

	math = var_5

	local var_13_11 = var_13_10[(var_13_0 + var_5.random(3) + 3) % 4 + 1]

	cloneTplTo = var_5

	local var_13_12 = arg_13_0.rtCharacter
	local var_13_13 = var_6.Find(var_13_12, var_13_11)
	local var_13_14 = arg_13_0.rtPlayContent

	arg_13_0.rtOtherTarget = var_5(var_13_13, var_7.Find(var_13_14, "back"), var_13_11)
	eachChild = var_5

	var_5(arg_13_0.rtOtherTarget, function(arg_20_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(arg_20_0, {
			x = 5
		})

		return
	end)

	setLocalScale = var_5

	var_5(arg_13_0.rtOtherTarget, {
		x = -1
	})

	local var_13_15 = arg_13_0.rtOtherTarget
	local var_13_16 = var_5.Find(var_13_15, "Image")
	local var_13_17 = var_5.GetComponent

	typeof = var_7
	DftAniEvent = var_8

	local var_13_18 = var_13_17(var_13_16, var_7(var_8))

	var_3.SetEndEvent(var_13_18, function()
		math = var_2_10000

		if var_2_10000.abs(arg_13_0.deltaMove) > 2 then
			local var_21_0 = arg_13_0

			var_0.ReadyPoint(var_21_0)
		else
			local var_21_1 = arg_13_0

			var_0.UpdateReady(var_21_1, arg_13_0.rtOtherTarget)
		end

		return
	end)
	var_3:SetTriggerEvent(function()
		local var_22_0 = arg_13_0

		var_22_0.countOther = arg_13_0.countOther + 1
		eachChild = var_22_0

		local var_22_1 = arg_13_0.rtOtherTarget

		var_22_0(var_1.Find(var_22_1, "effect"), function(arg_23_0)
			if arg_23_0.name == arg_13_0.statusOther .. "_" .. arg_13_0.countOther then
				setActive = var_1

				var_1(arg_23_0, true)
			end

			return
		end)

		return
	end)

	eachChild = var_5

	local var_13_19 = arg_13_0.rtOtherTarget

	var_5(var_6.Find(var_13_19, "effect"), function(arg_24_0)
		local var_24_0 = arg_24_0
		local var_24_1 = arg_24_0.GetComponent

		typeof = var_2_10003
		DftAniEvent = var_2_10004

		local var_24_2 = var_24_1(var_24_0, var_2_10003(var_2_10004))

		var_1.SetEndEvent(var_24_2, function()
			setActive = var_3_10000

			var_3_10000(arg_24_0, false)

			return
		end)

		return
	end)

	eachChild = var_5

	local var_13_20 = arg_13_0.rtPointOther

	var_5(var_6.Find(var_13_20, "icon/mask"), function(arg_26_0)
		setActive = var_2_10001

		var_2_10001(arg_26_0, arg_26_0.name == var_13_11)

		return
	end)

	local var_13_21 = arg_13_0.rtPlayContent

	arg_13_0.rtEffectObject = var_5.Find(var_13_21, "middle/EffectObject")

	return
end

local function var_0_4(arg_27_0, arg_27_1)
	for iter_27_0 = arg_27_0:Find("point").childCount, 1, -1 do
		triggerToggle = var_1_10007

		var_1_10007(var_2:GetChild(iter_27_0 - 1), iter_27_0 <= arg_27_1)
	end

	return
end

function var_0_0.UpdatePoint(arg_28_0)
	var_0_4(arg_28_0.rtPoint, arg_28_0.myPoint)
	var_0_4(arg_28_0.rtPointOther, arg_28_0.otherPoint)

	return
end

function var_0_0.UpdateReady(arg_29_0, arg_29_1)
	onNextTick = var_1_10002

	var_1_10002(function()
		local var_30_0

		if arg_29_1 == arg_29_0.rtTarget then
			setActive = var_30_0

			var_30_0(arg_29_0.rtBtns, true)
		elseif arg_29_1 == arg_29_0.rtOtherTarget then
			setAnchoredPosition = var_30_0

			var_30_0(arg_29_0.rtFloatUI, {
				x = arg_29_0.deltaMove * 60
			})

			var_30_0 = arg_29_0
			math = var_1
			var_30_0.otherSelectAction = var_1.random(3)
			eachChild = var_30_0

			var_30_0(arg_29_0.rtFloatUI, function(arg_31_0)
				setActive = var_3_10001

				local var_31_0 = arg_31_0
				local var_31_1 = arg_31_0.name

				tostring = var_3_10004

				var_3_10001(var_31_0, var_31_1 == var_3_10004(arg_29_0.otherSelectAction))

				return
			end)

			var_30_0 = arg_29_0
			DOAPPGameConfig = var_1
			var_30_0.selectCountdown = var_1.SELECT_TIME
			setSlider = var_30_0

			local var_30_1 = arg_29_0.rtFloatUI
			local var_30_2 = var_1.Find(var_30_1, arg_29_0.otherSelectAction .. "/Slider")
			local var_30_3 = 0

			DOAPPGameConfig = var_3

			local var_30_4 = var_3.SELECT_TIME

			DOAPPGameConfig = var_4

			var_30_0(var_30_2, var_30_3, var_30_4, var_4.SELECT_TIME - arg_29_0.selectCountdown)

			setActive = var_30_0

			var_30_0(arg_29_0.rtFloatUI, true)

			local var_30_5 = arg_29_0

			var_30_0.AfterSelect(var_30_5)
		else
			assert = var_30_0

			var_30_0(false)
		end

		setAnchoredPosition = var_30_0

		var_30_0(arg_29_1, {
			x = arg_29_0.deltaMove * 10
		})

		return
	end)

	quickPlayAnimator = var_1_10002

	var_1_10002(arg_29_1:Find("Image"), "Idle")

	return
end

function var_0_0.PlayEffect(arg_32_0, arg_32_1)
	setAnchoredPosition = var_1_10002

	var_1_10002(arg_32_0.rtEffectObject, {
		x = arg_32_0.deltaMove * 10
	})

	local var_32_0 = arg_32_0.effectCountdownDic

	DOAPPGameConfig = var_3
	var_32_0[arg_32_1] = var_3.EFFECT_COUNTDOWN[arg_32_1]

	return
end

function var_0_0.AfterSelect(arg_33_0)
	if arg_33_0.selectAction and arg_33_0.otherSelectAction then
		setActive = var_1

		var_1(arg_33_0.rtFloatUI, false)

		switch = var_1

		var_1((arg_33_0.selectAction - arg_33_0.otherSelectAction + 3) % 3, {
			[0] = function()
				quickPlayAnimator = var_2_10000

				local var_34_0 = arg_33_0.rtTarget

				var_2_10000(var_1.Find(var_34_0, "Image"), "Draw")

				quickPlayAnimator = var_2_10000

				local var_34_1 = arg_33_0.rtOtherTarget

				var_2_10000(var_1.Find(var_34_1, "Image"), "Draw")

				arg_33_0.stopTarget = nil

				local var_34_2 = arg_33_0

				var_0.PlayEffect(var_34_2, "Draw")

				arg_33_0.blockMoveBg = true

				return
			end,
			function()
				local var_35_0 = arg_33_0

				var_35_0.deltaMove = arg_33_0.deltaMove + 1
				math = var_35_0

				local var_35_1 = var_35_0.abs(arg_33_0.deltaMove)
				local var_35_2

				if not (2 < var_35_1) or not {
					"Win_",
					"Lose_"
				} then
					var_35_2 = {
						"Attack_",
						"Damage_"
					}
				end

				setParent = var_1

				local var_35_3 = arg_33_0.rtTarget
				local var_35_4 = arg_33_0.rtPlayContent

				var_1(var_35_3, var_3.Find(var_35_4, "front"))

				quickPlayAnimator = var_1

				local var_35_5 = arg_33_0.rtTarget

				var_1(var_2.Find(var_35_5, "Image"), var_35_2[1] .. var_0_2[arg_33_0.selectAction])

				arg_33_0.statusTarget = var_35_2[1] .. var_0_2[arg_33_0.selectAction]

				local var_35_6 = arg_33_0

				var_35_6.countTarget = 0
				setParent = var_35_6

				local var_35_7 = arg_33_0.rtOtherTarget
				local var_35_8 = arg_33_0.rtPlayContent

				var_35_6(var_35_7, var_3.Find(var_35_8, "back"))

				quickPlayAnimator = var_35_6

				local var_35_9 = arg_33_0.rtOtherTarget

				var_35_6(var_2.Find(var_35_9, "Image"), var_35_2[2] .. var_0_2[arg_33_0.otherSelectAction])

				arg_33_0.statusOther = var_35_2[2] .. var_0_2[arg_33_0.otherSelectAction]
				arg_33_0.countOther = 0

				local var_35_10 = arg_33_0
				local var_35_11 = arg_33_0.rtPlayContent

				var_35_10.rtEffectObject = var_2.Find(var_35_11, "middle/EffectObject")
				arg_33_0.stopTarget = arg_33_0.rtOtherTarget

				local var_35_12 = arg_33_0

				var_1.PlayEffect(var_35_12, var_0_2[arg_33_0.selectAction])

				local var_35_13 = arg_33_0

				var_35_13.blockMoveBg = true
				math = var_35_13

				local var_35_14 = var_35_13.abs(arg_33_0.deltaMove)

				if 2 < var_35_14 then
					local var_35_15 = arg_33_0

					DOAPPGameConfig = var_2

					local var_35_16 = var_2.LOSE_SOUND_COUNTDOWN[var_0_2[arg_33_0.otherSelectAction]]

					defaultValue = var_3
					DOAPPGameConfig = var_4
					var_35_15.loseDropCountdown = var_35_16 + var_3(var_4.EFFECT_STOP_TIME[var_0_2[arg_33_0.selectAction]], 0)
				end

				return
			end,
			function()
				local var_36_0 = arg_33_0

				var_36_0.deltaMove = arg_33_0.deltaMove - 1
				math = var_36_0

				local var_36_1 = var_36_0.abs(arg_33_0.deltaMove)
				local var_36_2

				if not (2 < var_36_1) or not {
					"Win_",
					"Lose_"
				} then
					var_36_2 = {
						"Attack_",
						"Damage_"
					}
				end

				setParent = var_1

				local var_36_3 = arg_33_0.rtTarget
				local var_36_4 = arg_33_0.rtPlayContent

				var_1(var_36_3, var_3.Find(var_36_4, "back"))

				quickPlayAnimator = var_1

				local var_36_5 = arg_33_0.rtTarget

				var_1(var_2.Find(var_36_5, "Image"), var_36_2[2] .. var_0_2[arg_33_0.selectAction])

				arg_33_0.statusTarget = var_36_2[2] .. var_0_2[arg_33_0.selectAction]

				local var_36_6 = arg_33_0

				var_36_6.countTarget = 0
				setParent = var_36_6

				local var_36_7 = arg_33_0.rtOtherTarget
				local var_36_8 = arg_33_0.rtPlayContent

				var_36_6(var_36_7, var_3.Find(var_36_8, "front"))

				quickPlayAnimator = var_36_6

				local var_36_9 = arg_33_0.rtOtherTarget

				var_36_6(var_2.Find(var_36_9, "Image"), var_36_2[1] .. var_0_2[arg_33_0.otherSelectAction])

				arg_33_0.statusOther = var_36_2[1] .. var_0_2[arg_33_0.otherSelectAction]
				arg_33_0.countOther = 0

				local var_36_10 = arg_33_0
				local var_36_11 = arg_33_0.rtPlayContent

				var_36_10.rtEffectObject = var_2.Find(var_36_11, "middle/EffectOtherObject")
				arg_33_0.stopTarget = arg_33_0.rtTarget

				local var_36_12 = arg_33_0

				var_1.PlayEffect(var_36_12, var_0_2[arg_33_0.otherSelectAction])

				local var_36_13 = arg_33_0

				var_36_13.blockMoveBg = true
				math = var_36_13

				local var_36_14 = var_36_13.abs(arg_33_0.deltaMove)

				if 2 < var_36_14 then
					local var_36_15 = arg_33_0

					DOAPPGameConfig = var_2

					local var_36_16 = var_2.LOSE_SOUND_COUNTDOWN[var_0_2[arg_33_0.selectAction]]

					defaultValue = var_3
					DOAPPGameConfig = var_4
					var_36_15.loseDropCountdown = var_36_16 + var_3(var_4.EFFECT_STOP_TIME[var_0_2[arg_33_0.otherSelectAction]], 0)
				end

				return
			end
		})

		arg_33_0.selectAction = nil
		arg_33_0.otherSelectAction = nil
		arg_33_0.selectCountdown = nil
	end

	return
end

function var_0_0.ReadyPoint(arg_37_0)
	if arg_37_0.readyPointCount > 0 then
		arg_37_0.readyPointCount = 0

		if arg_37_0.deltaMove > 0 then
			arg_37_0.myPoint = arg_37_0.myPoint + 1
		else
			arg_37_0.otherPoint = arg_37_0.otherPoint + 1
		end

		arg_37_0:UpdatePoint()

		if arg_37_0.myPoint > 2 or arg_37_0.otherPoint > 2 then
			arg_37_0:EndGame(arg_37_0.myPoint - arg_37_0.otherPoint)
		else
			DOAPPGameConfig = var_1
			arg_37_0.nextCountdown = var_1.NEXT_ROUND_COUNTDOWN
			eachChild = var_1

			local var_37_0 = arg_37_0.rtPointShow

			var_1(var_2.Find(var_37_0, "left"), function(arg_38_0)
				setActive = var_2_10001

				local var_38_0 = arg_38_0
				local var_38_1 = arg_38_0.name

				tostring = var_2_10004

				var_2_10001(var_38_0, var_38_1 == var_2_10004(arg_37_0.myPoint))

				return
			end)

			eachChild = var_1

			local var_37_1 = arg_37_0.rtPointShow

			var_1(var_2.Find(var_37_1, "right"), function(arg_39_0)
				setActive = var_2_10001

				local var_39_0 = arg_39_0
				local var_39_1 = arg_39_0.name

				tostring = var_2_10004

				var_2_10001(var_39_0, var_39_1 == var_2_10004(arg_37_0.otherPoint))

				return
			end)

			setActive = var_1

			var_1(arg_37_0.rtPointShow, true)
		end
	else
		arg_37_0.readyPointCount = arg_37_0.readyPointCount + 1
	end

	return
end

function var_0_0.GetResultInfo(arg_40_0, arg_40_1)
	if arg_40_1 then
		return arg_40_0.rtOtherTarget.name, arg_40_0.otherPoint, arg_40_0.result * -1
	else
		return arg_40_0.rtTarget.name, arg_40_0.myPoint, arg_40_0.result
	end

	return
end

function var_0_0.ResetGame(arg_41_0)
	DOAPPGameConfig = var_1_10001
	arg_41_0.timeCount = var_1_10001.ALL_TIME
	setText = var_1

	local var_41_0 = arg_41_0.textTime

	string = var_1_10003

	var_1(var_41_0, var_1_10003.format("%02ds", arg_41_0.timeCount))

	arg_41_0.deltaMove = 0
	IsNil = var_1

	if not var_1(arg_41_0.rtTarget) then
		Destroy = var_1

		var_1(arg_41_0.rtTarget)

		arg_41_0.rtTarget = nil
	end

	IsNil = var_1

	if not var_1(arg_41_0.rtOtherTarget) then
		Destroy = var_1

		var_1(arg_41_0.rtOtherTarget)

		arg_41_0.rtOtherTarget = nil
	end

	setAnchoredPosition = var_1

	local var_41_1 = arg_41_0.rtViewport

	var_1(var_2.Find(var_41_1, "MainContent"), {
		x = 0
	})

	eachChild = var_1

	local var_41_2 = arg_41_0.rtViewport

	var_1(var_2.Find(var_41_2, "MainContent/bg"), function(arg_42_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(arg_42_0, {
			x = 0
		})

		return
	end)

	arg_41_0.myPoint = 0
	arg_41_0.otherPoint = 0
	arg_41_0.readyPointCount = 0
	setActive = var_1

	var_1(arg_41_0.rtPointShow, false)

	arg_41_0.effectCountdownDic = {}

	return
end

function var_0_0.ReadyGame(arg_43_0, arg_43_1)
	arg_43_0:SetCharacter(arg_43_1.name)
	arg_43_0:UpdatePoint()
	arg_43_0:PauseGame()

	return
end

function var_0_0.StartGame(arg_44_0)
	arg_44_0.isStart = true

	arg_44_0:UpdateReady(arg_44_0.rtTarget)
	arg_44_0:UpdateReady(arg_44_0.rtOtherTarget)
	arg_44_0:ResumeGame()

	return
end

function var_0_0.EndGame(arg_45_0, arg_45_1)
	arg_45_0.isStart = false

	arg_45_0:PauseGame()

	arg_45_0.result = arg_45_1 or 0

	local var_45_0 = arg_45_0.binder

	var_2.openUI(var_45_0, "result")

	return
end

function var_0_0.ResumeGame(arg_46_0)
	arg_46_0.isPause = false

	local var_46_0 = arg_46_0.timer

	var_1.Start(var_46_0)
	var_0_1(arg_46_0.rtViewport, 1)

	return
end

function var_0_0.PauseGame(arg_47_0)
	arg_47_0.isPause = true

	local var_47_0 = arg_47_0.timer

	var_1.Stop(var_47_0)
	var_0_1(arg_47_0.rtViewport, 0)

	return
end

function var_0_0.OnTimer(arg_48_0, arg_48_1)
	arg_48_0.timeCount = arg_48_0.timeCount - arg_48_1
	setText = var_2

	local var_48_0 = arg_48_0.textTime

	string = var_1_10004

	var_2(var_48_0, var_1_10004.format("%02ds", arg_48_0.timeCount))

	if arg_48_0.timeCount <= 0 then
		arg_48_0:EndGame(arg_48_0.myPoint - arg_48_0.otherPoint)

		return
	end

	if arg_48_0.selectCountdown then
		arg_48_0.selectCountdown = arg_48_0.selectCountdown - arg_48_1
		setSlider = var_2

		local var_48_1 = arg_48_0.rtFloatUI
		local var_48_2 = var_3.Find(var_48_1, arg_48_0.otherSelectAction .. "/Slider")
		local var_48_3 = 0

		DOAPPGameConfig = var_5

		local var_48_4 = var_5.SELECT_TIME

		DOAPPGameConfig = var_6

		var_2(var_48_2, var_48_3, var_48_4, var_6.SELECT_TIME - arg_48_0.selectCountdown)

		setText = var_2

		local var_48_5 = arg_48_0.rtFloatUI
		local var_48_6 = var_3.Find(var_48_5, arg_48_0.otherSelectAction .. "/Text")

		string = var_48_5

		local var_48_7 = var_48_5.format
		local var_48_8 = "%2d%%"

		DOAPPGameConfig = var_6

		local var_48_9 = (var_6.SELECT_TIME - arg_48_0.selectCountdown) * 100

		DOAPPGameConfig = var_7

		var_2(var_48_6, var_48_7(var_48_8, var_48_9 / var_7.SELECT_TIME))

		if arg_48_0.selectCountdown <= 0 then
			arg_48_0.selectAction = (arg_48_0.otherSelectAction + 1) % 3 + 1
			setActive = var_2

			var_2(arg_48_0.rtBtns, false)
			arg_48_0:AfterSelect()
		end
	end

	if arg_48_0.nextCountdown then
		arg_48_0.nextCountdown = arg_48_0.nextCountdown - arg_48_1

		if arg_48_0.nextCountdown <= 0 then
			arg_48_0.nextCountdown = nil
			setActive = var_2

			var_2(arg_48_0.rtPointShow, false)

			arg_48_0.deltaMove = 0

			arg_48_0:UpdateReady(arg_48_0.rtTarget)
			arg_48_0:UpdateReady(arg_48_0.rtOtherTarget)
		end
	end

	pairs = var_2

	for iter_48_0, iter_48_1 in var_2(arg_48_0.effectCountdownDic) do
		arg_48_0.effectCountdownDic[iter_48_0] = arg_48_0.effectCountdownDic[iter_48_0] - arg_48_1

		if arg_48_0.effectCountdownDic[iter_48_0] <= 0 then
			local var_48_10 = arg_48_0.effectCountdownDic

			var_48_10[iter_48_0] = nil
			setActive = var_48_10

			local var_48_11 = arg_48_0.rtEffectObject

			var_48_10(var_8.Find(var_48_11, iter_48_0), true)

			pg = var_48_10

			local var_48_12 = var_48_10.CriMgr.GetInstance()
			local var_48_13 = var_7.PlaySoundEffect_V3

			DOAPPGameConfig = var_9

			var_48_13(var_48_12, var_9.SOUND_EFFECT_PP)

			arg_48_0.blockMoveBg = false

			if arg_48_0.stopTarget then
				DOAPPGameConfig = var_7
				arg_48_0.stopCount = var_7.EFFECT_STOP_TIME[iter_48_0]

				if arg_48_0.stopCount then
					onNextTick = var_7

					var_7(function()
						var_0_1(arg_48_0.stopTarget, 0)

						return
					end)
				end
			end
		end
	end

	if arg_48_0.stopCount then
		arg_48_0.stopCount = arg_48_0.stopCount - arg_48_1

		if arg_48_0.stopCount <= 0 then
			arg_48_0.stopCount = nil

			var_0_1(arg_48_0.stopTarget, 1)
		end
	end

	if arg_48_0.loseDropCountdown then
		arg_48_0.loseDropCountdown = arg_48_0.loseDropCountdown - arg_48_1

		if arg_48_0.loseDropCountdown <= 0 then
			arg_48_0.loseDropCountdown = nil
			pg = var_2

			local var_48_14 = var_2.CriMgr.GetInstance()
			local var_48_15 = var_2.PlaySoundEffect_V3

			DOAPPGameConfig = var_4

			var_48_15(var_48_14, var_4.SOUND_EFFECT_DROP)
		end
	end

	if not arg_48_0.blockMoveBg then
		local function var_48_16(arg_50_0, arg_50_1)
			local var_50_0 = arg_50_0.anchoredPosition.x / arg_50_1
			local var_50_1 = arg_48_0.deltaMove - var_50_0 > 0 and 1 or -1
			local var_50_2 = arg_48_1

			DOAPPGameConfig = var_2_10005

			local var_50_3 = var_50_0 + var_50_1 * (var_50_2 / var_2_10005.BG_MOVE_TIME)
			local var_50_4

			if not (var_50_0 < arg_48_0.deltaMove) or not {
				var_50_0,
				arg_48_0.deltaMove
			} then
				var_50_4 = {
					arg_48_0.deltaMove,
					var_50_0
				}
			end

			math = var_5

			local var_50_5 = var_5.clamp
			local var_50_6 = var_50_3

			unpack = var_2_10007

			local var_50_7 = var_50_5(var_50_6, var_2_10007(var_50_4))

			setAnchoredPosition = var_5

			var_5(arg_50_0, {
				x = var_50_7 * arg_50_1
			})

			return
		end

		local var_48_17 = arg_48_0.rtViewport
		local var_48_18 = var_3.Find(var_48_17, "MainContent").anchoredPosition.x
		local var_48_19 = arg_48_0.deltaMove

		DOAPPGameConfig = iter_48_1

		if var_48_18 ~= var_48_19 * iter_48_1.BG_DISTANCE then
			local var_48_20 = var_48_16
			local var_48_21 = var_3

			DOAPPGameConfig = var_6

			var_48_20(var_48_21, -1 * var_6.BG_DISTANCE)

			local var_48_22 = var_3:Find("bg").childCount

			for iter_48_2 = 1, var_48_22 - 1 do
				local var_48_23 = var_48_16
				local var_48_24 = var_4:GetChild(iter_48_2 - 1)
				local var_48_25 = iter_48_2 - var_48_22

				DOAPPGameConfig = var_13

				var_48_23(var_48_24, var_48_25 * var_13.BG_DISTANCE)
			end
		end
	end

	return
end

function var_0_0.willExit(arg_51_0)
	if arg_51_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_51_0.handle)
	end

	return
end

return var_0_0
