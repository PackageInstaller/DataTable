class = var_0_10000

local var_0_0 = var_0_10000("BackYardSettlementCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	findTF = var_1_10002
	arg_1_0.additionTF = var_1_10002(arg_1_0._go, "addition_bg/Text")
	findTF = var_2

	local var_1_0 = var_2(arg_1_0._go, "exp/level")
	local var_1_1 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.levelText = var_1_1(var_1_0, var_5(var_1_10007))

	local var_1_2 = arg_1_0.additionTF
	local var_1_3 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.additionText = var_1_3(var_1_2, var_5(var_1_10007))
	findTF = var_2

	local var_1_4 = var_2(arg_1_0._go, "name_bg/Mask/Text")
	local var_1_5 = var_2.GetComponent

	typeof = var_5
	ScrollText = var_1_10007
	arg_1_0.nameTxt = var_1_5(var_1_4, var_5(var_1_10007))
	findTF = var_2

	local var_1_6 = var_2(arg_1_0._go, "icon")
	local var_1_7 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.icon = var_1_7(var_1_6, var_5(var_1_10007))
	findTF = var_2

	local var_1_8 = var_2(arg_1_0._go, "exp/value")
	local var_1_9 = var_2.GetComponent

	typeof = var_5
	Slider = var_1_10007
	arg_1_0.slider = var_1_9(var_1_8, var_5(var_1_10007))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:UpdateInfo(arg_2_2)
	arg_2_0:DoAnimation(arg_2_1, arg_2_2, arg_2_3)

	return
end

function var_0_0.UpdateInfo(arg_3_0, arg_3_1)
	arg_3_0.additionText.text = "EXP+" .. 0
	arg_3_0.levelText.text = "LEVEL" .. arg_3_1.level

	local var_3_0 = arg_3_0.nameTxt

	var_2.SetText(var_3_0, arg_3_1:getName())

	LoadSpriteAtlasAsync = var_2

	var_2("HeroHrzIcon/" .. arg_3_1:getPainting(), "", function(arg_4_0)
		if arg_3_0.exited then
			return
		end

		arg_3_0.icon.sprite = arg_4_0

		return
	end)

	return
end

function var_0_0.DoAnimation(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_2.level
	local var_5_1 = arg_5_2

	if var_5_0 == arg_5_2.getMaxLevel(var_5_1) then
		return
	end

	local var_5_2 = 0.3
	local var_5_3 = arg_5_3.level - arg_5_2.level

	TweenValue = var_6

	var_6(arg_5_0.additionTF, 0, arg_5_1, var_5_2 * (var_5_3 + 1), 0, function(arg_6_0)
		local var_6_0 = arg_5_0.additionText
		local var_6_1 = "EXP+"

		math = var_2_10003
		var_6_0.text = var_6_1 .. var_2_10003.floor(arg_6_0)

		return
	end)

	local var_5_4 = var_5_3 > 0

	math = var_5_1

	local var_5_5 = var_5_1.max(arg_5_3:getLevelExpConfig().exp, 0.001)
	local var_5_6

	if var_5_4 then
		math = var_5_6
		var_5_6 = var_5_6.max(arg_5_2:getLevelExpConfig().exp, 0.001)

		arg_5_0:DoLevelUpAnimation(arg_5_2.exp, var_5_6, arg_5_3.exp, var_5_5, arg_5_3.level, var_5_3, var_5_2)
	else
		TweenValue = var_5_6

		var_5_6(arg_5_0.slider, 0, arg_5_3.exp / var_5_5, var_5_2, 0, function(arg_7_0)
			local var_7_0 = arg_5_0

			var_1.SetSliderValue(var_7_0, arg_5_0.slider, arg_7_0)

			return
		end)
	end

	return
end

function var_0_0.DoLevelUpAnimation(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7)
	local var_8_0
	local var_8_1
	local var_8_2

	local function var_8_3()
		TweenValue = var_2_10000

		var_2_10000(arg_8_0.slider, 0, arg_8_3 / arg_8_4, arg_8_7, 0, function(arg_10_0)
			local var_10_0 = arg_8_0

			var_1.SetSliderValue(var_10_0, arg_8_0.slider, arg_10_0)

			return
		end)

		return
	end

	local function var_8_4()
		TweenValue = var_2_10000

		var_2_10000(arg_8_0.slider, 0, 1, arg_8_7, 0, function(arg_12_0)
			local var_12_0 = arg_8_0

			var_1.SetSliderValue(var_12_0, arg_8_0.slider, arg_12_0)

			return
		end, var_8_0)

		return
	end

	function var_8_0()
		arg_8_6 = arg_8_6 - 1

		if arg_8_6 == 0 then
			var_8_3()
		else
			var_8_4()
		end

		pg = var_0

		local var_13_0 = var_0.CriMgr.GetInstance()
		local var_13_1 = var_0.PlaySoundEffect_V3

		SFX_BOAT_LEVEL_UP = var_2_10003

		var_13_1(var_13_0, var_2_10003)

		arg_8_0.levelText.text = "LEVEL" .. arg_8_5 - arg_8_6

		return
	end

	TweenValue = var_1_10011

	var_1_10011(arg_8_0.slider, arg_8_1, arg_8_2, arg_8_7, 0, function(arg_14_0)
		local var_14_0 = arg_8_0

		var_1.SetSliderValue(var_14_0, arg_8_0.slider, arg_14_0 / arg_8_2)

		return
	end, var_8_0)

	return
end

function var_0_0.SetSliderValue(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_2 ~= 0 and arg_15_2 < 0.03 then
		arg_15_2 = 0.03
	end

	arg_15_1.value = arg_15_2

	return
end

function var_0_0.Dispose(arg_16_0)
	LeanTween = var_1_10001

	if var_1_10001.isTweening(arg_16_0.slider.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_16_0.slider.gameObject)
	end

	LeanTween = var_1

	if var_1.isTweening(arg_16_0.additionTF.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_16_0.additionTF.gameObject)
	end

	arg_16_0.exited = true

	return
end

return var_0_0
