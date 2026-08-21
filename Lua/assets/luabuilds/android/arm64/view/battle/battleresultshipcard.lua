local var_0_0 = class("BattleResultShipCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._expTF = arg_1_1

	arg_1_0:init()

	return
end

function var_0_0.init(arg_2_0)
	arg_2_0._expContent = findTF(arg_2_0._expTF, "content")
	arg_2_0._expInfo = findTF(arg_2_0._expContent, "exp")
	arg_2_0._nameTxt = findTF(arg_2_0._expContent, "info/name_mask/name")
	arg_2_0._intimacyUpFX = findTF(arg_2_0._expContent, "heartsfly")
	arg_2_0._intimacyDownFX = findTF(arg_2_0._expContent, "heartsbroken")
	arg_2_0._lvText = findTF(arg_2_0._expContent, "dockyard/lv/Text")
	arg_2_0._lvUp = findTF(arg_2_0._expContent, "dockyard/lv_bg/levelUpLabel")
	arg_2_0._lvFX = findTF(arg_2_0._expContent, "dockyard/lv_bg/levelup")
	arg_2_0._expText = findTF(arg_2_0._expInfo, "exp_text")
	arg_2_0._expProgress = findTF(arg_2_0._expInfo, "exp_progress")
	arg_2_0._expImage = arg_2_0._expProgress:GetComponent(typeof(Image))
	arg_2_0._expBuff = findTF(arg_2_0._expInfo, "exp_buff_mask/exp_buff")

	arg_2_0._expTF:GetComponent(typeof(DftAniEvent)):SetTriggerEvent(function(arg_3_0)
		arg_2_0:expAnimation()

		return
	end)
	SetActive(arg_2_0._expTF, false)

	return
end

function var_0_0.SetShipVO(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	flushShipCard(arg_4_0._expTF, arg_4_1)

	arg_4_0._oldShipVO = arg_4_1
	arg_4_0._newShipVO = arg_4_2
	arg_4_0._isMVP = arg_4_3
	arg_4_0._buffName = arg_4_4

	arg_4_0:setShipInfo()

	return
end

function var_0_0.RegisterPreEXPTF(arg_5_0, arg_5_1)
	arg_5_1:GetTF():GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_6_0)
		setActive(arg_5_0._expTF, true)

		return
	end)

	return
end

function var_0_0.ConfigCallback(arg_7_0, arg_7_1)
	arg_7_0._expTF:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_8_0)
		arg_7_1()

		return
	end)

	return
end

function var_0_0.setShipInfo(arg_9_0)
	setScrollText(arg_9_0._nameTxt, arg_9_0._oldShipVO:GetColorName())
	setActive(findTF(arg_9_0._expContent, "mvp"), arg_9_0._isMVP)
	SetActive(arg_9_0._expBuff, arg_9_0._buffName ~= nil)

	local var_9_0 = arg_9_0._buffName or ""

	setScrollText(arg_9_0._expBuff, var_9_0)

	return
end

function var_0_0.expAnimation(arg_10_0)
	SetActive(arg_10_0._expInfo, true)
	SetActive(arg_10_0._intimacyUpFX, arg_10_0._oldShipVO:getIntimacy() < arg_10_0._newShipVO:getIntimacy())
	SetActive(arg_10_0._intimacyDownFX, arg_10_0._oldShipVO:getIntimacy() > arg_10_0._newShipVO:getIntimacy())

	local var_10_0 = arg_10_0._oldShipVO:getConfig("rarity")
	local var_10_1 = getExpByRarityFromLv1(var_10_0, arg_10_0._oldShipVO.level)

	arg_10_0._expImage.fillAmount = arg_10_0._oldShipVO:getExp() / var_10_1

	if arg_10_0._oldShipVO.level < arg_10_0._newShipVO.level then
		local var_10_2 = 0

		for iter_10_0 = arg_10_0._oldShipVO.level, arg_10_0._newShipVO.level - 1 do
			var_10_2 = var_10_2 + getExpByRarityFromLv1(var_10_0, iter_10_0)
		end

		arg_10_0.playAnimation(arg_10_0._expTF, 0, var_10_2 + arg_10_0._newShipVO:getExp() - arg_10_0._oldShipVO:getExp(), 1, 0, function(arg_11_0)
			setText(arg_10_0._expText, "+" .. math.ceil(arg_11_0))

			return
		end)

		arg_10_0._animationLV = arg_10_0._oldShipVO.level

		arg_10_0:loopAnimation(arg_10_0._oldShipVO:getExp() / var_10_1, 1, 0.7, true)
	else
		setText(arg_10_0._expText, "+" .. math.ceil(arg_10_0._newShipVO:getExp() - arg_10_0._oldShipVO:getExp()))

		if arg_10_0._oldShipVO.level == arg_10_0._oldShipVO:getMaxLevel() then
			arg_10_0._expImage.fillAmount = 1

			return
		end

		arg_10_0.playAnimation(arg_10_0._expTF, arg_10_0._oldShipVO:getExp() / var_10_1, arg_10_0._newShipVO:getExp() / var_10_1, 1, 0, function(arg_12_0)
			arg_10_0._expImage.fillAmount = arg_12_0

			return
		end)
	end

	return
end

function var_0_0.loopAnimation(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = getExpByRarityFromLv1(arg_13_0._oldShipVO:getConfig("rarity"), arg_13_0._newShipVO.level)

	LeanTween.value(go(arg_13_0._expTF), arg_13_1, arg_13_2, arg_13_3):setOnUpdate(System.Action_float(function(arg_14_0)
		arg_13_0._expImage.fillAmount = arg_14_0

		return
	end)):setOnComplete(System.Action(function()
		arg_13_0._animationLV = arg_13_0._animationLV + 1

		if arg_13_4 then
			arg_13_0:levelUpEffect()
		end

		if arg_13_0._newShipVO.level == arg_13_0._animationLV then
			if arg_13_0._animationLV == arg_13_0._newShipVO:getMaxLevel() then
				arg_13_0._expImage.fillAmount = 1
			else
				arg_13_0:loopAnimation(0, arg_13_0._newShipVO:getExp() / var_13_0, 1, false)
			end
		elseif arg_13_0._newShipVO.level > arg_13_0._animationLV then
			arg_13_0:loopAnimation(0, 1, 0.7, true)
		end

		return
	end))

	return
end

function var_0_0.levelUpEffect(arg_16_0)
	SetActive(arg_16_0._lvUp, true)
	SetActive(arg_16_0._lvFX, true)
	LeanTween.moveY(rtf(arg_16_0._lvUp), arg_16_0._lvUp.localPosition.y + 30, 0.5):setOnComplete(System.Action(function()
		SetActive(arg_16_0._lvUp, false)

		arg_16_0._lvUp.localPosition = var_0

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_BOAT_LEVEL_UP)

		return
	end))

	if arg_16_0._animationLV <= arg_16_0._newShipVO.level then
		setText(arg_16_0._lvText, arg_16_0._animationLV)
	end

	return
end

function var_0_0.Play(arg_18_0)
	setActive(arg_18_0._expTF, true)

	return
end

function var_0_0.SkipAnimation(arg_19_0)
	arg_19_0._expTF:GetComponent(typeof(Animator)).enabled = false

	SetActive(arg_19_0._expTF, true)
	SetActive(arg_19_0._expContent, true)
	SetActive(arg_19_0._expInfo, true)

	arg_19_0._expTF:GetComponent(typeof(CanvasGroup)).alpha = 1

	LeanTween.cancel(go(arg_19_0._lvUp))
	LeanTween.cancel(go(arg_19_0._expTF))
	SetActive(arg_19_0._intimacyUpFX, arg_19_0._oldShipVO:getIntimacy() < arg_19_0._newShipVO:getIntimacy())
	SetActive(arg_19_0._intimacyDownFX, arg_19_0._oldShipVO:getIntimacy() > arg_19_0._newShipVO:getIntimacy())

	arg_19_0._expContent.localPosition = Vector3(0, 0, 0)

	setText(arg_19_0._lvText, arg_19_0._newShipVO.level)

	if arg_19_0._oldShipVO.level == arg_19_0._oldShipVO:getMaxLevel() then
		setText(arg_19_0._expText, "+" .. math.ceil(arg_19_0._newShipVO:getExp() - arg_19_0._oldShipVO:getExp()))

		arg_19_0._expImage.fillAmount = 1
	else
		local var_19_0 = arg_19_0._oldShipVO:getConfig("rarity")

		if arg_19_0._oldShipVO.level < arg_19_0._newShipVO.level then
			local var_19_1 = 0

			for iter_19_0 = arg_19_0._oldShipVO.level, arg_19_0._newShipVO.level - 1 do
				var_19_1 = var_19_1 + getExpByRarityFromLv1(var_19_0, iter_19_0)
			end

			setText(arg_19_0._expText, "+" .. var_19_1 + arg_19_0._newShipVO:getExp() - arg_19_0._oldShipVO:getExp())
		else
			setText(arg_19_0._expText, "+" .. math.ceil(arg_19_0._newShipVO:getExp() - arg_19_0._oldShipVO:getExp()))
		end

		arg_19_0._expImage.fillAmount = arg_19_0._newShipVO:getExp() / getExpByRarityFromLv1(var_19_0, arg_19_0._newShipVO.level)
	end

	SetActive(arg_19_0._lvUp, false)

	return
end

function var_0_0.GetTF(arg_20_0)
	return arg_20_0._expTF
end

function var_0_0.playAnimation(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
	LeanTween.value(arg_21_0.gameObject, arg_21_1, arg_21_2, arg_21_3):setDelay(arg_21_4):setOnUpdate(System.Action_float(function(arg_22_0)
		arg_21_5(arg_22_0)

		return
	end))

	return
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0._oldShipVO = nil
	arg_23_0._newShipVO = nil

	return
end

return var_0_0
