local var_0_0 = class("BackYardSettlementCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0.additionTF = findTF(arg_1_0._go, "addition_bg/Text")
	arg_1_0.levelText = findTF(arg_1_0._go, "exp/level"):GetComponent(typeof(Text))
	arg_1_0.additionText = arg_1_0.additionTF:GetComponent(typeof(Text))
	arg_1_0.nameTxt = findTF(arg_1_0._go, "name_bg/Mask/Text"):GetComponent(typeof(ScrollText))
	arg_1_0.icon = findTF(arg_1_0._go, "icon"):GetComponent(typeof(Image))
	arg_1_0.slider = findTF(arg_1_0._go, "exp/value"):GetComponent(typeof(Slider))

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

	arg_3_0.nameTxt:SetText(arg_3_1:getName())
	LoadSpriteAtlasAsync("HeroHrzIcon/" .. arg_3_1:getPainting(), "", function(arg_4_0)
		if arg_3_0.exited then
			return
		end

		arg_3_0.icon.sprite = arg_4_0

		return
	end)

	return
end

function var_0_0.DoAnimation(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2.level == arg_5_2:getMaxLevel() then
		return
	end

	local var_5_0 = 0.3
	local var_5_1 = arg_5_3.level - arg_5_2.level

	TweenValue(arg_5_0.additionTF, 0, arg_5_1, var_5_0 * (arg_5_3.level - arg_5_2.level + 1), 0, function(arg_6_0)
		arg_5_0.additionText.text = "EXP+" .. math.floor(arg_6_0)

		return
	end)

	local var_5_2 = math.max(arg_5_3:getLevelExpConfig().exp, 0.001)

	if var_5_1 > 0 then
		arg_5_0:DoLevelUpAnimation(arg_5_2.exp, math.max(arg_5_2:getLevelExpConfig().exp, 0.001), arg_5_3.exp, var_5_2, arg_5_3.level, var_5_1, var_5_0)
	else
		TweenValue(arg_5_0.slider, 0, arg_5_3.exp / var_5_2, var_5_0, 0, function(arg_7_0)
			arg_5_0:SetSliderValue(arg_5_0.slider, arg_7_0)

			return
		end)
	end

	return
end

function var_0_0.DoLevelUpAnimation(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7)
	local var_8_0

	local function var_8_3()
		TweenValue(arg_8_0.slider, 0, arg_8_3 / arg_8_4, arg_8_7, 0, function(arg_10_0)
			arg_8_0:SetSliderValue(arg_8_0.slider, arg_10_0)

			return
		end)

		return
	end

	local function var_8_4()
		TweenValue(arg_8_0.slider, 0, 1, arg_8_7, 0, function(arg_12_0)
			arg_8_0:SetSliderValue(arg_8_0.slider, arg_12_0)

			return
		end, var_8_0)

		return
	end

	TweenValue(arg_8_0.slider, arg_8_1, arg_8_2, arg_8_7, 0, function(arg_14_0)
		arg_8_0:SetSliderValue(arg_8_0.slider, arg_14_0 / arg_8_2)

		return
	end, function()
		arg_8_6 = arg_8_6 - 1

		if arg_8_6 == 0 then
			var_8_3()
		else
			var_8_4()
		end

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_BOAT_LEVEL_UP)

		arg_8_0.levelText.text = "LEVEL" .. arg_8_5 - arg_8_6

		return
	end)

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
	if LeanTween.isTweening(arg_16_0.slider.gameObject) then
		LeanTween.cancel(arg_16_0.slider.gameObject)
	end

	if LeanTween.isTweening(arg_16_0.additionTF.gameObject) then
		LeanTween.cancel(arg_16_0.additionTF.gameObject)
	end

	arg_16_0.exited = true

	return
end

return var_0_0
