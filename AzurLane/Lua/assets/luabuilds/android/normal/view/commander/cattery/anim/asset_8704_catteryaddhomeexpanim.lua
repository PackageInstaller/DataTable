class = var_0_10000

local var_0_0 = var_0_10000("CatteryAddHomeExpAnim")
local var_0_1 = 1

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	findTF = var_1_10002

	local var_1_0 = var_1_10002(arg_1_0._tf, "slider")
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	Slider = var_1_10005
	arg_1_0.expSlider = var_1_1(var_1_0, var_4(var_1_10005))
	findTF = var_2

	local var_1_2 = var_2(arg_1_0._tf, "level")
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.levelTxt = var_1_3(var_1_2, var_4(var_1_10005))
	findTF = var_2

	local var_1_4 = var_2(arg_1_0._tf, "exp")
	local var_1_5 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.expTxt = var_1_5(var_1_4, var_4(var_1_10005))
	findTF = var_2
	arg_1_0.addition = var_2(arg_1_0._tf, "addition")
	findTF = var_2
	arg_1_0.additionExp = var_2(arg_1_0._tf, "addition/exp")

	local var_1_6 = arg_1_0.additionExp
	local var_1_7 = var_2.Find(var_1_6, "Text")
	local var_1_8 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.additionExpTxt = var_1_8(var_1_7, var_4(var_1_10005))
	findTF = var_2
	arg_1_0.additionItem = var_2(arg_1_0._tf, "addition/item")
	findTF = var_2
	arg_1_0.additionItemImg = var_2(arg_1_0._tf, "addition/item/icon")
	arg_1_0.animRiseH = arg_1_0.addition.localPosition.y
	setActive = var_2

	var_2(arg_1_0._tf, false)

	return
end

function var_0_0.Action(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	setActive = var_1_10006

	var_1_10006(arg_2_0._tf, true)

	arg_2_0.callback = arg_2_5

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.GetAwardOffset(var_2_0, arg_2_3, arg_2_4)

	setAnchoredPosition = var_2_0

	var_2_0(arg_2_0.addition, {
		x = var_2_1
	})
	arg_2_0:RefreshAward(arg_2_3, arg_2_4)
	arg_2_0:RefreshHome(arg_2_2)

	return
end

function var_0_0.GetAwardOffset(arg_3_0, arg_3_1, arg_3_2)
	return (arg_3_1 or arg_3_2) and -82 or -15
end

function var_0_0.RefreshAward(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 then
		GetImageSpriteFromAtlasAsync = var_1_10003

		var_1_10003("Props/20010", "", arg_4_0.additionItemImg)
	elseif arg_4_2 then
		GetImageSpriteFromAtlasAsync = var_1_10003

		var_1_10003("Props/dormMoney", "", arg_4_0.additionItemImg)
	end

	setActive = var_1_10003

	var_1_10003(arg_4_0.additionItem, arg_4_1 or arg_4_2)

	return
end

function var_0_0.RefreshHome(arg_5_0, arg_5_1)
	getProxy = var_1_10002
	CommanderProxy = var_1_10003

	local var_5_0 = var_1_10002(var_1_10003)
	local var_5_1 = var_2.GetCommanderHome(var_5_0)

	arg_5_0.additionExpTxt.text = arg_5_1 .. "<size=40>EXP</size>"

	if var_5_1.exp - arg_5_1 < 0 then
		arg_5_0:DoUpgradeAnim(var_5_1, arg_5_1)
	else
		arg_5_0:DoAddExpAnim(var_5_1, arg_5_1)
	end

	return
end

function var_0_0.DoUpgradeAnim(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.levelTxt.text = "LV." .. arg_6_1:GetLevel() - 1

	if arg_6_2 == 0 then
		arg_6_0:IfIsMaxLevel(arg_6_1, arg_6_2, true)

		return
	end

	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.GetPrevLevelExp(var_6_0)

	math = var_6_0

	local var_6_2 = var_6_1 - var_6_0.abs(arg_6_1.exp - arg_6_2)

	arg_6_0.expTxt.text = "<color=#92FC63FF>" .. var_6_2 .. "/</color>" .. var_6_1

	local var_6_3 = var_6_2 / var_6_1

	arg_6_0.expSlider.value = var_6_3

	local var_6_4 = arg_6_1:GetNextLevelExp()
	local var_6_5 = arg_6_1.exp / var_6_4

	arg_6_0:AddExpAnim(var_6_3, 1, var_6_2, var_6_1, var_6_1, function()
		local var_7_0 = arg_6_0.levelTxt
		local var_7_1 = "LV."
		local var_7_2 = arg_6_1

		var_7_0.text = var_7_1 .. var_2.GetLevel(var_7_2)

		local var_7_3 = arg_6_0

		var_0.AddExpAnim(var_7_3, 0, var_6_5, 0, arg_6_1.exp, var_6_4, function()
			local var_8_0 = arg_6_0

			var_0.IfIsMaxLevel(var_8_0, arg_6_1, arg_6_2)

			return
		end)

		return
	end)
	arg_6_0:AdditionAnim(var_0_1, function()
		if arg_6_0.callback then
			arg_6_0.callback()
		end

		arg_6_0.callback = nil

		return
	end)

	return
end

function var_0_0.DoAddExpAnim(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.levelTxt.text = "LV." .. arg_10_1:GetLevel()

	if arg_10_2 == 0 then
		arg_10_0:IfIsMaxLevel(arg_10_1, arg_10_2, true)

		return
	end

	local var_10_0 = arg_10_1:GetNextLevelExp()
	local var_10_1 = arg_10_1.exp / var_10_0
	local var_10_2 = (arg_10_1.exp - arg_10_2) / var_10_0

	arg_10_0:AddExpAnim(var_10_2, var_10_1, var_5, arg_10_1.exp, var_10_0)
	arg_10_0:AdditionAnim(var_0_1, function()
		if arg_10_0.callback then
			arg_10_0.callback()
		end

		arg_10_0.callback = nil

		local var_11_0 = arg_10_0

		var_0.IfIsMaxLevel(var_11_0, arg_10_1, arg_10_2)

		return
	end)

	return
end

function var_0_0.IfIsMaxLevel(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_1:IsMaxLevel() then
		arg_12_0.expTxt.text = "MAX"
		arg_12_0.expSlider.value = 1
	end

	arg_12_0:HideOrShowAddition(arg_12_2)

	if arg_12_3 then
		IsNil = var_4

		if not var_4(arg_12_0.additionItem) then
			isActive = var_4

			if var_4(arg_12_0.additionItem) then
				arg_12_0:AdditionAnim(var_0_1, function()
					if arg_12_0.callback then
						arg_12_0.callback()
					end

					arg_12_0.callback = nil

					return
				end)

				goto label_12_0
			end
		end

		Timer = var_4

		local var_12_0 = var_4.New(function()
			if arg_12_0.callback then
				arg_12_0.callback()
			end

			arg_12_0.callback = nil

			return
		end, var_0_1, 1)

		var_4.Start(var_12_0)
	end

	::label_12_0::

	return
end

function var_0_0.HideOrShowAddition(arg_15_0, arg_15_1)
	setActive = var_1_10002

	var_1_10002(arg_15_0.additionExp, arg_15_1 > 0)

	return
end

function var_0_0.Clear(arg_16_0)
	IsNil = var_1_10001

	local var_16_0

	if not var_1_10001(arg_16_0.expSlider) then
		LeanTween = var_16_0
		var_16_0 = var_16_0.isTweening
		go = var_2

		if var_16_0(var_2(arg_16_0.expSlider)) then
			LeanTween = var_16_0
			var_16_0 = var_16_0.cancel
			go = var_2

			var_16_0(var_2(arg_16_0.expSlider))
		end
	end

	IsNil = var_16_0

	local var_16_1

	if not var_16_0(arg_16_0.expTxt) then
		LeanTween = var_16_1
		var_16_1 = var_16_1.isTweening
		go = var_2

		if var_16_1(var_2(arg_16_0.expTxt)) then
			LeanTween = var_16_1
			var_16_1 = var_16_1.cancel
			go = var_2

			var_16_1(var_2(arg_16_0.expTxt))
		end
	end

	IsNil = var_16_1

	if not var_16_1(arg_16_0.addition) then
		LeanTween = var_1

		local var_16_2 = var_1.isTweening

		go = var_2

		if var_16_2(var_2(arg_16_0.addition)) then
			LeanTween = var_1

			local var_16_3 = var_1.cancel

			go = var_2

			var_16_3(var_2(arg_16_0.addition))
		end
	end

	return
end

function var_0_0.Hide(arg_17_0)
	arg_17_0:Clear()

	setActive = var_1

	var_1(arg_17_0._tf, false)

	return
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0:Hide()

	return
end

function var_0_0.AddExpAnim(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6)
	parallelAsync = var_1_10007

	var_1_10007({
		function(arg_20_0)
			LeanTween = var_2_10001

			local var_20_0 = var_2_10001.value

			go = var_2_10002

			local var_20_1 = var_20_0(var_2_10002(arg_19_0.expSlider), arg_19_1, arg_19_2, var_0_1)
			local var_20_2 = var_1.setOnUpdate

			System = var_3

			local var_20_3 = var_20_2(var_20_1, var_3.Action_float(function(arg_21_0)
				arg_19_0.expSlider.value = arg_21_0

				return
			end))
			local var_20_4 = var_1.setOnComplete

			System = var_3

			var_20_4(var_20_3, var_3.Action(arg_20_0))

			return
		end,
		function(arg_22_0)
			LeanTween = var_2_10001

			local var_22_0 = var_2_10001.value

			go = var_2_10002

			local var_22_1 = var_22_0(var_2_10002(arg_19_0.expTxt), arg_19_3, arg_19_4, var_0_1)
			local var_22_2 = var_1.setOnUpdate

			System = var_3

			local var_22_3 = var_22_2(var_22_1, var_3.Action_float(function(arg_23_0)
				math = var_3_10001

				local var_23_0 = var_3_10001.ceil(arg_23_0)

				arg_19_0.expTxt.text = "<color=#92FC63FF>" .. var_23_0 .. "/</color>" .. arg_19_5

				return
			end))
			local var_22_4 = var_1.setOnComplete

			System = var_3

			var_22_4(var_22_3, var_3.Action(arg_22_0))

			return
		end
	}, function()
		if arg_19_6 then
			arg_19_6()
		end

		return
	end)

	return
end

function var_0_0.AdditionAnim(arg_25_0, arg_25_1, arg_25_2)
	setActive = var_1_10003

	var_1_10003(arg_25_0.addition, true)

	LeanTween = var_1_10003

	local var_25_0 = var_1_10003.value

	go = var_4

	local var_25_1 = var_25_0(var_4(arg_25_0.addition), arg_25_0.animRiseH, arg_25_0.animRiseH + 25, arg_25_1)
	local var_25_2 = var_3.setOnUpdate

	System = var_5

	local var_25_3 = var_25_2(var_25_1, var_5.Action_float(function(arg_26_0)
		local var_26_0 = arg_25_0.addition

		Vector3 = var_2_10002
		var_26_0.localPosition = var_2_10002(arg_25_0.addition.localPosition.x, arg_26_0, 0)

		return
	end))
	local var_25_4 = var_3.setOnComplete

	System = var_5

	var_25_4(var_25_3, var_5.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_25_0.addition, false)
		arg_25_2()

		local var_27_0 = arg_25_0.addition

		Vector3 = var_1
		var_27_0.localPosition = var_1(arg_25_0.addition.localPosition.x, 0, 0)

		return
	end))

	return
end

return var_0_0
