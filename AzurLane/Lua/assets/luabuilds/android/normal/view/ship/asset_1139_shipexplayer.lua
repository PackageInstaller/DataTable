class = var_0_10000

local var_0_0 = "ShipExpLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.TypeDefault = 0
var_0_1.TypeClass = 1

function var_0_1.getUIName(arg_1_0)
	return "ShipExpUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0._grade = var_1.Find(var_2_0, "grade")

	local var_2_1 = arg_2_0._grade

	arg_2_0._gradeLabel = var_1.Find(var_2_1, "label")

	local var_2_2 = arg_2_0._grade

	arg_2_0._levelText = var_1.Find(var_2_2, "Text")

	local var_2_3 = arg_2_0._tf

	arg_2_0._main = var_1.Find(var_2_3, "main")

	local var_2_4 = arg_2_0._main

	arg_2_0._leftPanel = var_1.Find(var_2_4, "leftPanel")

	local var_2_5 = arg_2_0._leftPanel

	arg_2_0._topBar = var_1.Find(var_2_5, "topBar")

	local var_2_6 = arg_2_0._leftPanel

	arg_2_0._expResult = var_1.Find(var_2_6, "expResult")

	local var_2_7 = arg_2_0._expResult

	arg_2_0._expContainer = var_1.Find(var_2_7, "expContainer")
	arg_2_0._extpl = arg_2_0:getTpl("ShipCardTpl", arg_2_0._expContainer)

	local var_2_8 = arg_2_0._tf

	arg_2_0._skipBtn = var_1.Find(var_2_8, "skipLayer")
	setActive = var_1

	var_1(arg_2_0._topBar, false)

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0.tweenTFs = {}
	arg_3_0.timerId = {}
	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._skipBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.skip(var_4_0)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)

	pg = var_1

	local var_3_3 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_3, arg_3_0._tf)
	arg_3_0:display()

	return
end

function var_0_1.display(arg_5_0)
	setActive = var_1_10001

	var_1_10001(arg_5_0._grade, true)

	setText = var_1_10001

	var_1_10001(arg_5_0._levelText, arg_5_0.contextData.title)

	if arg_5_0.contextData.type == var_0_1.TypeClass then
		setActive = var_1

		var_1(arg_5_0._gradeLabel, false)
	else
		setActive = var_1

		var_1(arg_5_0._gradeLabel, true)

		local var_5_0 = arg_5_0.contextData.isCri and "grade_label_task_perfect" or "grade_label_task_complete"

		LoadImageSpriteAsync = var_2

		var_2("battlescore/" .. var_5_0, arg_5_0._gradeLabel, true)
	end

	local var_5_1 = arg_5_0.contextData.top

	setActive = var_2

	var_2(arg_5_0._topBar, var_5_1)

	local var_5_5

	if var_5_1 then
		setText = var_2

		local var_5_2 = arg_5_0._topBar

		var_2(var_5_5.Find(var_5_2, "text_1"), var_5_1.text1)

		setText = var_2

		local var_5_3 = arg_5_0._topBar

		var_2(var_5_5.Find(var_5_3, "text_2"), var_5_1.text2)

		setText = var_2

		local var_5_4 = arg_5_0._topBar

		var_2(var_5_5.Find(var_5_4, "text_3"), var_5_1.text3)

		var_5_5 = arg_5_0._topBar
		var_5_5 = var_2.Find(var_5_5, "progress")

		local var_5_6 = var_2.GetComponent

		typeof = var_4
		Image = var_5
		var_5_6(var_5_5, var_4(var_5)).fillAmount = var_5_1.progress
	end

	arg_5_0._expTFs = {}
	arg_5_0._skipExp = {}
	arg_5_0._maxRightDelay = 0

	local var_5_7 = {}

	ipairs = var_5_5

	for iter_5_0, iter_5_1 in var_5_5(arg_5_0.contextData.newShips) do
		var_5_7[iter_5_1.id] = iter_5_1
	end

	local var_5_8 = arg_5_0.contextData.oldShips
	local var_5_9 = 0.5

	ipairs = var_5

	for iter_5_2, iter_5_3 in var_5(var_5_8) do
		local var_5_10 = var_5_7[iter_5_3.id]

		cloneTplTo = var_1_10011

		local var_5_11 = var_1_10011(arg_5_0._extpl, arg_5_0._expContainer).transform.anchoredPosition

		rtf = var_13

		local var_5_12 = var_13(var_1_10011).rect.width

		findTF = var_14

		local var_5_13 = var_14(var_1_10011, "content")
		local var_5_14 = var_1_10011.transform

		Vector3 = var_16
		var_5_14.anchoredPosition = var_16(var_5_11.x + (16.2 + var_5_12) * (iter_5_2 - 1), var_5_11.y, var_5_11.z)

		local var_5_15 = arg_5_0._expTFs

		var_5_15[#arg_5_0._expTFs + 1] = var_1_10011
		flushShipCard = var_5_15

		var_5_15(var_1_10011, iter_5_3)

		setScrollText = var_5_15
		findTF = var_16

		var_5_15(var_16(var_5_13, "info/name_mask/name"), iter_5_3:GetColorName())

		findTF = var_5_15

		local var_5_16 = var_5_15(var_5_13, "dockyard/lv/Text")

		findTF = var_16

		local var_5_17 = var_16(var_5_13, "dockyard/lv_bg/levelUpLabel")

		findTF = var_17

		local var_5_18 = var_17(var_5_13, "dockyard/lv_bg/levelup")

		setText = var_18

		var_18(var_5_16, iter_5_3.level)

		findTF = var_18

		local var_5_19 = var_18(var_5_13, "exp")

		findTF = var_19

		local var_5_20 = var_19(var_5_19, "exp_text")

		findTF = var_20

		local var_5_21 = var_20(var_5_19, "exp_progress")

		math = var_21
		arg_5_0._maxRightDelay = var_21.max(arg_5_0._maxRightDelay, var_5_10.level - iter_5_3.level + iter_5_2 * 0.5)

		local function var_5_22()
			SetActive = var_2_10000

			var_2_10000(var_5_19, true)

			local var_6_0 = iter_5_3
			local var_6_1 = var_0.getLevelExpConfig(var_6_0).exp
			local var_6_2 = var_5_10
			local var_6_3 = var_1.getLevelExpConfig(var_6_2).exp
			local var_6_4 = var_5_21
			local var_6_5 = var_2.GetComponent

			typeof = var_2_10004
			Image = var_2_10005
			var_6_5(var_6_4, var_2_10004(var_2_10005)).fillAmount = iter_5_3.exp / var_6_1

			local var_6_6

			if iter_5_3.level < var_5_10.level then
				var_6_6 = 0

				for iter_6_0 = iter_5_3.level, var_5_10.level - 1 do
					local var_6_7 = iter_5_3

					var_6_6 = var_6_6 + var_7.getLevelExpConfig(var_6_7, iter_6_0).exp
				end

				local var_6_8 = arg_5_0

				var_3.PlayAnimation(var_6_8, var_1_10011, 0, var_6_6 + var_5_10.exp - iter_5_3.exp, 1, 0, function(arg_7_0)
					setText = var_3_10001

					local var_7_0 = var_5_20
					local var_7_1 = "+"

					math = var_3_10004

					var_3_10001(var_7_0, var_7_1 .. var_3_10004.ceil(arg_7_0))

					return
				end)

				local function var_6_9(arg_8_0)
					SetActive = var_3_10001

					var_3_10001(var_5_17, true)

					SetActive = var_3_10001

					var_3_10001(var_5_18, true)

					local var_8_0 = var_5_17.localPosition

					LeanTween = var_2

					local var_8_1 = var_2.moveY

					rtf = var_3

					local var_8_2 = var_8_1(var_3(var_5_17), var_8_0.y + 30, 0.5)
					local var_8_3 = var_2.setOnComplete

					System = var_4

					var_8_3(var_8_2, var_4.Action(function()
						SetActive = var_4_10000

						var_4_10000(var_5_17, false)

						local var_9_0 = var_5_17

						var_9_0.localPosition = var_8_0
						pg = var_9_0

						local var_9_1 = var_9_0.CriMgr.GetInstance()
						local var_9_2 = var_0.PlaySoundEffect_V3

						SFX_BOAT_LEVEL_UP = var_2

						var_9_2(var_9_1, var_2)

						return
					end))

					setText = var_8_3

					var_8_3(var_5_16, arg_8_0)

					table = var_8_3

					var_8_3.insert(arg_5_0.tweenTFs, var_5_17)

					return
				end

				LeanTween = var_6_8

				local var_6_10 = var_6_8.value

				go = var_5

				local var_6_11 = var_6_10(var_5(var_1_10011), iter_5_3.exp / var_6_1, 1, 0.5)
				local var_6_12 = var_4.setOnUpdate

				System = var_6

				local var_6_13 = var_6_12(var_6_11, var_6.Action_float(function(arg_10_0)
					local var_10_0 = var_5_21
					local var_10_1 = var_1.GetComponent

					typeof = var_3_10003
					Image = var_3_10004
					var_10_1(var_10_0, var_3_10003(var_3_10004)).fillAmount = arg_10_0

					return
				end))
				local var_6_14 = var_4.setOnComplete

				System = var_6

				var_6_14(var_6_13, var_6.Action(function()
					local var_11_0 = iter_5_3.level + 1

					var_6_9(var_11_0)

					local var_11_1 = var_11_0 + 1
					local var_11_2 = 0.1

					while var_11_1 <= var_5_10.level do
						local var_11_3 = var_11_1

						LeanTween = var_3_10003
						var_3_10003 = var_3_10003.value
						go = var_3_10004
						var_3_10004 = var_3_10003(var_3_10004(var_1_10011), 0, 1, 1)
						var_3_10003 = var_3_10003.setOnUpdate
						System = var_5
						var_3_10004 = var_3_10003(var_3_10004, var_5.Action_float(function(arg_12_0)
							local var_12_0 = var_5_21
							local var_12_1 = var_1.GetComponent

							typeof = var_4_10003
							Image = var_4_10004
							var_12_1(var_12_0, var_4_10003(var_4_10004)).fillAmount = arg_12_0

							return
						end))
						var_3_10004 = var_3_10003.setDelay(var_3_10004, var_11_2)
						var_3_10003 = var_3_10003.setOnComplete
						System = var_5

						var_3_10003(var_3_10004, var_5.Action(function()
							var_6_9(var_11_3)

							return
						end))

						var_11_2 = var_11_2 + 1
						var_11_1 = var_11_1 + 1
					end

					local var_11_4 = arg_5_0.timerId
					local var_11_5 = iter_5_3.id

					pg = var_3_10004

					local var_11_6 = var_3_10004.TimeMgr.GetInstance()

					var_11_4[var_11_5] = var_4.AddTimer(var_11_6, "delayTimer", var_11_2, 0, function()
						local var_14_0 = var_5_10.level
						local var_14_1 = var_5_10

						if var_14_0 == var_1.getMaxLevel(var_14_1) then
							local var_14_2 = var_5_21
							local var_14_3 = var_0.GetComponent

							typeof = var_14_1
							Image = var_4_10003
							var_14_3(var_14_2, var_14_1(var_4_10003)).fillAmount = 1
							arg_5_0._skipExp[iter_5_2] = false

							return
						end

						local var_14_4 = arg_5_0

						var_0.PlayAnimation(var_14_4, var_1_10011, 0, var_5_10.exp / var_6_3, 0.5, 0, function(arg_15_0)
							local var_15_0 = var_5_21
							local var_15_1 = var_1.GetComponent

							typeof = var_5_10003
							Image = var_5_10004
							var_15_1(var_15_0, var_5_10003(var_5_10004)).fillAmount = arg_15_0
							arg_5_0._skipExp[iter_5_2] = false

							return
						end)

						return
					end)

					return
				end))

				table = var_6_14

				var_6_14.insert(arg_5_0.tweenTFs, var_1_10011)
			else
				math = var_6_6

				local var_6_15 = var_6_6.ceil
				local var_6_16 = var_5_10
				local var_6_17 = var_3.getExp(var_6_16)
				local var_6_18 = iter_5_3
				local var_6_19 = var_6_15(var_6_17 - var_4.getExp(var_6_18))

				setText = var_3

				var_3(var_5_20, "+" .. var_6_19)

				local var_6_20 = iter_5_3.level
				local var_6_21 = iter_5_3

				if var_6_20 == var_4.getMaxLevel(var_6_21) then
					local var_6_22 = var_5_21
					local var_6_23 = var_3.GetComponent

					typeof = var_6_21
					Image = var_6
					var_6_23(var_6_22, var_6_21(var_6)).fillAmount = 1
					arg_5_0._skipExp[iter_5_2] = false

					return
				end

				local var_6_24 = arg_5_0

				var_3.PlayAnimation(var_6_24, var_1_10011, iter_5_3.exp / var_6_1, var_5_10.exp / var_6_1, 1, 0, function(arg_16_0)
					local var_16_0 = var_5_21
					local var_16_1 = var_1.GetComponent

					typeof = var_3_10003
					Image = var_3_10004
					var_16_1(var_16_0, var_3_10003(var_3_10004)).fillAmount = arg_16_0
					arg_5_0._skipExp[iter_5_2] = false

					return
				end)
			end

			return
		end

		arg_5_0._skipExp[iter_5_2] = function()
			LeanTween = var_2_10000

			local var_17_0 = var_2_10000.cancel

			go = var_2_10001

			var_17_0(var_2_10001(var_5_17))

			LeanTween = var_17_0

			local var_17_1 = var_17_0.cancel

			go = var_1

			var_17_1(var_1(var_1_10011))

			SetActive = var_17_1

			var_17_1(var_1_10011, true)

			SetActive = var_17_1

			var_17_1(var_5_19, true)

			setText = var_17_1

			var_17_1(var_5_16, var_5_10.level)

			local var_17_2 = iter_5_3.level
			local var_17_3 = iter_5_3

			if var_17_2 == var_1.getMaxLevel(var_17_3) then
				setText = var_17_2

				local var_17_4 = var_5_20

				var_17_3 = "+"
				math = var_2_10003
				var_2_10003 = var_2_10003.ceil

				local var_17_5 = var_5_10
				local var_17_6 = var_4.getExp(var_17_5)
				local var_17_7 = iter_5_3

				var_17_2(var_17_4, var_17_3 .. var_2_10003(var_17_6 - var_5.getExp(var_17_7)))

				local var_17_8 = var_5_21

				var_17_2 = var_17_2.GetComponent
				typeof = var_17_3
				Image = var_2_10003
				var_17_2 = var_17_2(var_17_8, var_17_3(var_2_10003))
				var_17_2.fillAmount = 1
			else
				if iter_5_3.level < var_5_10.level then
					var_17_2 = 0

					for iter_17_0 = iter_5_3.level, var_5_10.level - 1 do
						local var_17_9 = iter_5_3

						var_17_2 = var_17_2 + var_5.getLevelExpConfig(var_17_9, iter_17_0).exp
					end

					setText = var_1

					var_1(var_5_20, "+" .. var_17_2 + var_5_10.exp - iter_5_3.exp)
				else
					setText = var_17_2

					local var_17_10 = var_5_20

					var_17_3 = "+"
					math = var_2_10003

					var_17_2(var_17_10, var_17_3 .. var_2_10003.ceil(var_5_10.exp - iter_5_3.exp))
				end

				local var_17_11 = var_5_21

				var_17_2 = var_17_2.GetComponent
				typeof = var_17_3
				Image = var_2_10003
				var_17_2 = var_17_2(var_17_11, var_17_3(var_2_10003))

				local var_17_12 = var_5_10.exp
				local var_17_13 = var_5_10

				var_17_2.fillAmount = var_17_12 / var_2.getLevelExpConfig(var_17_13).exp
			end

			SetActive = var_17_2

			var_17_2(var_5_17, false)

			local var_17_14 = var_1_10011
			local var_17_15 = var_0.GetComponent(var_17_14, "CanvasGroup")

			var_17_15.alpha = 1
			rtf = var_17_15

			local var_17_16 = var_17_15(var_1_10011)

			Vector2 = var_1
			rtf = var_2
			var_17_16.anchoredPosition = var_1(var_2(var_1_10011).anchoredPosition.x, 0)

			return
		end

		local var_5_23 = var_1_10011:GetComponent("CanvasGroup")
		local var_5_24 = iter_5_2 * 0.2

		setActive = var_24

		var_24(var_1_10011, false)

		LeanTween = var_24

		local var_5_25 = var_24.moveY

		rtf = var_25

		local var_5_26 = var_5_25(var_25(var_1_10011), 0, 0.2)
		local var_5_27 = var_24.setOnComplete

		System = var_26

		local var_5_28 = var_5_27(var_5_26, var_26.Action(function()
			setActive = var_2_10000

			var_2_10000(var_1_10011, true)
			var_5_22()

			return
		end))

		var_24.setDelay(var_5_28, var_5_24)

		table = var_24

		var_24.insert(arg_5_0.tweenTFs, var_1_10011)

		LeanTween = var_24

		local var_5_29 = var_24.value

		go = var_25

		local var_5_30 = var_5_29(var_25(var_1_10011), 0, 1, 0.2)
		local var_5_31 = var_24.setOnUpdate

		System = var_26

		local var_5_32 = var_5_31(var_5_30, var_26.Action_float(function(arg_19_0)
			var_5_23.alpha = arg_19_0

			return
		end))

		var_24.setDelay(var_5_32, var_5_24)
	end

	return
end

function var_0_1.skip(arg_20_0)
	_ = var_1_10001

	if var_1_10001.any(arg_20_0._skipExp, function(arg_21_0)
		return arg_21_0
	end) then
		for iter_20_0 = 1, #arg_20_0._skipExp do
			if arg_20_0._skipExp[iter_20_0] then
				arg_20_0._skipExp[iter_20_0]()

				arg_20_0._skipExp[iter_20_0] = false
			end
		end
	else
		local var_20_0 = arg_20_0
		local var_20_1 = arg_20_0.emit

		BaseUI = var_3

		var_20_1(var_20_0, var_3.ON_CLOSE)
	end

	return
end

function var_0_1.PlayAnimation(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6)
	LeanTween = var_1_10007

	local var_22_0 = var_1_10007.value(arg_22_1.gameObject, arg_22_2, arg_22_3, arg_22_4)
	local var_22_1 = var_7.setDelay(var_22_0, arg_22_5)
	local var_22_2 = var_7.setOnUpdate

	System = var_9

	var_22_2(var_22_1, var_9.Action_float(function(arg_23_0)
		arg_22_6(arg_23_0)

		return
	end))

	table = var_22_2

	var_22_2.insert(arg_22_0.tweenTFs, arg_22_1)

	return
end

function var_0_1.willExit(arg_24_0)
	pairs = var_1_10001

	for iter_24_0, iter_24_1 in var_1_10001(arg_24_0.tweenTFs) do
		LeanTween = var_1_10006
		var_1_10006 = var_1_10006.isTweening
		go = var_1_10007

		if var_1_10006(var_1_10007(iter_24_1)) then
			LeanTween = var_1_10006
			var_1_10006 = var_1_10006.cancel
			go = var_1_10007

			var_1_10006(var_1_10007(iter_24_1))
		end
	end

	arg_24_0.tweenTFs = nil
	pairs = var_1

	for iter_24_2, iter_24_3 in var_1(arg_24_0.timerId) do
		pg = var_1_10006

		local var_24_0 = var_1_10006.TimeMgr.GetInstance()

		var_1_10006.RemoveTimer(var_24_0, iter_24_3)
	end

	arg_24_0.timerId = nil
	pg = var_1

	local var_24_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_24_1, arg_24_0._tf)

	return
end

return var_0_1
