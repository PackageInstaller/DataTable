class = var_0_10000

local var_0_0 = var_0_10000("BattleResultShipCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._expTF = arg_1_1

	arg_1_0:init()

	return
end

function var_0_0.init(arg_2_0)
	findTF = var_1_10001
	arg_2_0._expContent = var_1_10001(arg_2_0._expTF, "content")
	findTF = var_1
	arg_2_0._expInfo = var_1(arg_2_0._expContent, "exp")
	findTF = var_1
	arg_2_0._nameTxt = var_1(arg_2_0._expContent, "info/name_mask/name")
	findTF = var_1
	arg_2_0._intimacyUpFX = var_1(arg_2_0._expContent, "heartsfly")
	findTF = var_1
	arg_2_0._intimacyDownFX = var_1(arg_2_0._expContent, "heartsbroken")
	findTF = var_1
	arg_2_0._lvText = var_1(arg_2_0._expContent, "dockyard/lv/Text")
	findTF = var_1
	arg_2_0._lvUp = var_1(arg_2_0._expContent, "dockyard/lv_bg/levelUpLabel")
	findTF = var_1
	arg_2_0._lvFX = var_1(arg_2_0._expContent, "dockyard/lv_bg/levelup")
	findTF = var_1
	arg_2_0._expText = var_1(arg_2_0._expInfo, "exp_text")
	findTF = var_1
	arg_2_0._expProgress = var_1(arg_2_0._expInfo, "exp_progress")

	local var_2_0 = arg_2_0._expProgress
	local var_2_1 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0._expImage = var_2_1(var_2_0, var_4(var_1_10006))
	findTF = var_1
	arg_2_0._expBuff = var_1(arg_2_0._expInfo, "exp_buff_mask/exp_buff")

	local var_2_2 = arg_2_0._expTF
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006

	local var_2_4 = var_2_3(var_2_2, var_4(var_1_10006))

	var_1.SetTriggerEvent(var_2_4, function(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.expAnimation(var_3_0)

		return
	end)

	SetActive = var_2

	var_2(arg_2_0._expTF, false)

	return
end

function var_0_0.SetShipVO(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	flushShipCard = var_1_10005

	var_1_10005(arg_4_0._expTF, arg_4_1)

	arg_4_0._oldShipVO = arg_4_1
	arg_4_0._newShipVO = arg_4_2
	arg_4_0._isMVP = arg_4_3
	arg_4_0._buffName = arg_4_4

	arg_4_0:setShipInfo()

	return
end

function var_0_0.RegisterPreEXPTF(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:GetTF()
	local var_5_1 = var_2.GetComponent

	typeof = var_1_10005
	DftAniEvent = var_1_10007

	local var_5_2 = var_5_1(var_5_0, var_1_10005(var_1_10007))

	var_2.SetEndEvent(var_5_2, function(arg_6_0)
		setActive = var_2_10001

		var_2_10001(arg_5_0._expTF, true)

		return
	end)

	return
end

function var_0_0.ConfigCallback(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._expTF
	local var_7_1 = var_2.GetComponent

	typeof = var_1_10005
	DftAniEvent = var_1_10007

	local var_7_2 = var_7_1(var_7_0, var_1_10005(var_1_10007))

	var_2.SetEndEvent(var_7_2, function(arg_8_0)
		arg_7_1()

		return
	end)

	return
end

function var_0_0.setShipInfo(arg_9_0)
	setScrollText = var_1_10001

	local var_9_0 = arg_9_0._nameTxt
	local var_9_1 = arg_9_0._oldShipVO

	var_1_10001(var_9_0, var_4.GetColorName(var_9_1))

	setActive = var_1_10001
	findTF = var_9_0

	var_1_10001(var_9_0(arg_9_0._expContent, "mvp"), arg_9_0._isMVP)

	SetActive = var_1_10001

	var_1_10001(arg_9_0._expBuff, arg_9_0._buffName ~= nil)

	setScrollText = var_1_10001

	local var_9_2 = arg_9_0._expBuff
	local var_9_3

	if not arg_9_0._buffName then
		var_9_3 = ""
	end

	var_1_10001(var_9_2, var_9_3)

	return
end

function var_0_0.expAnimation(arg_10_0)
	SetActive = var_1_10001

	var_1_10001(arg_10_0._expInfo, true)

	SetActive = var_1_10001

	local var_10_0 = arg_10_0._intimacyUpFX
	local var_10_1 = arg_10_0._oldShipVO
	local var_10_2 = var_4.getIntimacy(var_10_1)
	local var_10_3 = arg_10_0._newShipVO

	var_1_10001(var_10_0, var_10_2 < var_5.getIntimacy(var_10_3))

	SetActive = var_1_10001

	local var_10_4 = arg_10_0._intimacyDownFX
	local var_10_5 = arg_10_0._oldShipVO
	local var_10_6 = var_4.getIntimacy(var_10_5)
	local var_10_7 = arg_10_0._newShipVO

	var_1_10001(var_10_4, var_10_6 > var_5.getIntimacy(var_10_7))

	local var_10_8 = arg_10_0._oldShipVO
	local var_10_9 = var_1.getConfig(var_10_8, "rarity")

	getExpByRarityFromLv1 = var_1_10002

	local var_10_10 = var_1_10002(var_10_9, arg_10_0._oldShipVO.level)
	local var_10_11 = arg_10_0._expImage
	local var_10_12 = arg_10_0._oldShipVO

	var_10_11.fillAmount = var_4.getExp(var_10_12) / var_10_10

	local var_10_13, var_10_14

	if arg_10_0._oldShipVO.level < arg_10_0._newShipVO.level then
		var_10_13 = 0

		for iter_10_0 = arg_10_0._oldShipVO.level, arg_10_0._newShipVO.level - 1 do
			getExpByRarityFromLv1 = var_1_10008
			var_10_13 = var_10_13 + var_1_10008(var_10_9, iter_10_0)
		end

		var_10_14 = arg_10_0.playAnimation

		local var_10_15 = arg_10_0._expTF
		local var_10_16 = 0
		local var_10_17 = arg_10_0._newShipVO
		local var_10_18 = var_10_13 + var_8.getExp(var_10_17)
		local var_10_19 = arg_10_0._oldShipVO

		var_10_14(var_10_15, var_10_16, var_10_18 - var_9.getExp(var_10_19), 1, 0, function(arg_11_0)
			setText = var_2_10001

			local var_11_0 = arg_10_0._expText
			local var_11_1 = "+"

			math = var_2_10005

			var_2_10001(var_11_0, var_11_1 .. var_2_10005.ceil(arg_11_0))

			return
		end)

		arg_10_0._animationLV = arg_10_0._oldShipVO.level

		local var_10_20 = arg_10_0

		var_10_14 = arg_10_0.loopAnimation

		local var_10_21 = arg_10_0._oldShipVO

		var_10_14(var_10_20, var_7.getExp(var_10_21) / var_10_10, 1, 0.7, true)
	else
		math = var_10_13

		local var_10_22 = var_10_13.ceil
		local var_10_23 = arg_10_0._newShipVO
		local var_10_24 = var_5.getExp(var_10_23)
		local var_10_25 = arg_10_0._oldShipVO
		local var_10_26 = var_10_22(var_10_24 - var_6.getExp(var_10_25))

		setText = var_10_14

		var_10_14(arg_10_0._expText, "+" .. var_10_26)

		local var_10_27 = arg_10_0._oldShipVO.level
		local var_10_28 = arg_10_0._oldShipVO

		if var_10_27 == var_5.getMaxLevel(var_10_28) then
			arg_10_0._expImage.fillAmount = 1

			return
		end

		local var_10_29 = arg_10_0.playAnimation
		local var_10_30 = arg_10_0._expTF
		local var_10_31 = arg_10_0._oldShipVO
		local var_10_32 = var_7.getExp(var_10_31) / var_10_10
		local var_10_33 = arg_10_0._newShipVO

		var_10_29(var_10_30, var_10_32, var_8.getExp(var_10_33) / var_10_10, 1, 0, function(arg_12_0)
			arg_10_0._expImage.fillAmount = arg_12_0

			return
		end)
	end

	return
end

function var_0_0.loopAnimation(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	getExpByRarityFromLv1 = var_1_10005

	local var_13_0 = arg_13_0._oldShipVO
	local var_13_1 = var_1_10005(var_7.getConfig(var_13_0, "rarity"), arg_13_0._newShipVO.level)

	LeanTween = var_1_10006

	local var_13_2 = var_1_10006.value

	go = var_8

	local var_13_3 = var_13_2(var_8(arg_13_0._expTF), arg_13_1, arg_13_2, arg_13_3)
	local var_13_4 = var_6.setOnUpdate

	System = var_9

	local var_13_5 = var_13_4(var_13_3, var_9.Action_float(function(arg_14_0)
		arg_13_0._expImage.fillAmount = arg_14_0

		return
	end))
	local var_13_6 = var_6.setOnComplete

	System = var_9

	var_13_6(var_13_5, var_9.Action(function()
		arg_13_0._animationLV = arg_13_0._animationLV + 1

		if arg_13_4 then
			local var_15_0 = arg_13_0

			var_0.levelUpEffect(var_15_0)
		end

		if arg_13_0._newShipVO.level == arg_13_0._animationLV then
			local var_15_1 = arg_13_0._animationLV
			local var_15_2 = arg_13_0._newShipVO

			if var_15_1 == var_1.getMaxLevel(var_15_2) then
				arg_13_0._expImage.fillAmount = 1
			else
				local var_15_3 = arg_13_0
				local var_15_4 = var_0.loopAnimation
				local var_15_5 = 0
				local var_15_6 = arg_13_0._newShipVO

				var_15_4(var_15_3, var_15_5, var_4.getExp(var_15_6) / var_13_1, 1, false)
			end
		elseif arg_13_0._newShipVO.level > arg_13_0._animationLV then
			local var_15_7 = arg_13_0

			var_0.loopAnimation(var_15_7, 0, 1, 0.7, true)
		end

		return
	end))

	return
end

function var_0_0.levelUpEffect(arg_16_0)
	SetActive = var_1_10001

	var_1_10001(arg_16_0._lvUp, true)

	SetActive = var_1_10001

	var_1_10001(arg_16_0._lvFX, true)

	local var_16_0 = arg_16_0._lvUp.localPosition

	LeanTween = var_1_10002

	local var_16_1 = var_1_10002.moveY

	rtf = var_4

	local var_16_2 = var_16_1(var_4(arg_16_0._lvUp), var_16_0.y + 30, 0.5)
	local var_16_3 = var_2.setOnComplete

	System = var_5

	var_16_3(var_16_2, var_5.Action(function()
		SetActive = var_2_10000

		var_2_10000(arg_16_0._lvUp, false)

		local var_17_0 = arg_16_0._lvUp

		var_17_0.localPosition = var_16_0
		pg = var_17_0

		local var_17_1 = var_17_0.CriMgr.GetInstance()
		local var_17_2 = var_0.PlaySoundEffect_V3

		SFX_BOAT_LEVEL_UP = var_3

		var_17_2(var_17_1, var_3)

		return
	end))

	if arg_16_0._animationLV <= arg_16_0._newShipVO.level then
		setText = var_2

		var_2(arg_16_0._lvText, arg_16_0._animationLV)
	end

	return
end

function var_0_0.Play(arg_18_0)
	setActive = var_1_10001

	var_1_10001(arg_18_0._expTF, true)

	return
end

function var_0_0.SkipAnimation(arg_19_0)
	local var_19_0 = arg_19_0._expTF
	local var_19_1 = var_1.GetComponent

	typeof = var_1_10004
	Animator = var_1_10006

	local var_19_2 = var_19_1(var_19_0, var_1_10004(var_1_10006))

	var_19_2.enabled = false
	SetActive = var_19_2

	var_19_2(arg_19_0._expTF, true)

	SetActive = var_19_2

	var_19_2(arg_19_0._expContent, true)

	SetActive = var_19_2

	var_19_2(arg_19_0._expInfo, true)

	local var_19_3 = arg_19_0._expTF
	local var_19_4 = var_1.GetComponent

	typeof = var_4
	CanvasGroup = var_1_10006

	local var_19_5 = var_19_4(var_19_3, var_4(var_1_10006))

	var_19_5.alpha = 1
	LeanTween = var_19_5

	local var_19_6 = var_19_5.cancel

	go = var_19_3

	var_19_6(var_19_3(arg_19_0._lvUp))

	LeanTween = var_19_6

	local var_19_7 = var_19_6.cancel

	go = var_3

	var_19_7(var_3(arg_19_0._expTF))

	SetActive = var_19_7

	local var_19_8 = arg_19_0._intimacyUpFX
	local var_19_9 = arg_19_0._oldShipVO
	local var_19_10 = var_4.getIntimacy(var_19_9)
	local var_19_11 = arg_19_0._newShipVO

	var_19_7(var_19_8, var_19_10 < var_5.getIntimacy(var_19_11))

	SetActive = var_19_7

	local var_19_12 = arg_19_0._intimacyDownFX
	local var_19_13 = arg_19_0._oldShipVO
	local var_19_14 = var_4.getIntimacy(var_19_13)
	local var_19_15 = arg_19_0._newShipVO

	var_19_7(var_19_12, var_19_14 > var_5.getIntimacy(var_19_15))

	local var_19_16 = arg_19_0._expContent

	Vector3 = var_2
	var_19_16.localPosition = var_2(0, 0, 0)
	setText = var_19_16

	var_19_16(arg_19_0._lvText, arg_19_0._newShipVO.level)

	local var_19_17 = arg_19_0._oldShipVO.level
	local var_19_18 = arg_19_0._oldShipVO

	if var_19_17 == var_2.getMaxLevel(var_19_18) then
		setText = var_19_17

		local var_19_19 = arg_19_0._expText
		local var_19_20 = "+"

		math = var_5

		local var_19_21 = var_5.ceil
		local var_19_22 = arg_19_0._newShipVO

		var_19_15 = var_19_15.getExp(var_19_22)

		local var_19_23 = arg_19_0._oldShipVO

		var_19_17(var_19_19, var_19_20 .. var_19_21(var_19_15 - var_8.getExp(var_19_23)))

		var_19_17 = arg_19_0._expImage
		var_19_17.fillAmount = 1
	else
		local var_19_24 = arg_19_0._oldShipVO

		var_19_17 = var_19_17.getConfig(var_19_24, "rarity")

		local var_19_25, var_19_30

		if arg_19_0._oldShipVO.level < arg_19_0._newShipVO.level then
			var_19_25 = 0

			for iter_19_0 = arg_19_0._oldShipVO.level, arg_19_0._newShipVO.level - 1 do
				getExpByRarityFromLv1 = var_19_15
				var_19_25 = var_19_25 + var_19_15(var_19_17, iter_19_0)
			end

			setText = var_3

			local var_19_26 = arg_19_0._expText

			iter_19_0 = "+"

			local var_19_27 = arg_19_0._newShipVO
			local var_19_28 = var_19_25 + var_7.getExp(var_19_27)
			local var_19_29 = arg_19_0._oldShipVO

			var_3(var_19_26, iter_19_0 .. var_19_28 - var_8.getExp(var_19_29))
		else
			setText = var_19_25
			var_19_30 = arg_19_0._expText

			local var_19_31 = "+"

			math = iter_19_0

			local var_19_32 = iter_19_0.ceil
			local var_19_33 = arg_19_0._newShipVO
			local var_19_34 = var_8.getExp(var_19_33)
			local var_19_35 = arg_19_0._oldShipVO

			var_19_25(var_19_30, var_19_31 .. var_19_32(var_19_34 - var_9.getExp(var_19_35)))
		end

		local var_19_36 = arg_19_0._expImage
		local var_19_37 = arg_19_0._newShipVO
		local var_19_38 = var_3.getExp(var_19_37)

		getExpByRarityFromLv1 = var_19_30
		var_19_36.fillAmount = var_19_38 / var_19_30(var_19_17, arg_19_0._newShipVO.level)
	end

	SetActive = var_19_17

	var_19_17(arg_19_0._lvUp, false)

	return
end

function var_0_0.GetTF(arg_20_0)
	return arg_20_0._expTF
end

function var_0_0.playAnimation(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
	LeanTween = var_1_10006

	local var_21_0 = var_1_10006.value(arg_21_0.gameObject, arg_21_1, arg_21_2, arg_21_3)
	local var_21_1 = var_6.setDelay(var_21_0, arg_21_4)
	local var_21_2 = var_6.setOnUpdate

	System = var_9

	var_21_2(var_21_1, var_9.Action_float(function(arg_22_0)
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
