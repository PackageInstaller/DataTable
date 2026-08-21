local var_0_0 = class("TrophyView")

var_0_0.GRAY_COLOR = Color(0.764, 0.764, 0.764, 0.784)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0._trophyNamePic = findTF(arg_1_0._tf, "frame/trophyName/Text")
	arg_1_0._trophyNameBG = findTF(arg_1_0._tf, "frame/trophyName")
	arg_1_0._trophyIcon = findTF(arg_1_0._tf, "frame/trophyIcon")
	arg_1_0._trophyDescUpper = findTF(arg_1_0._tf, "frame/trophyDesc/Text_upper"):GetComponent(typeof(Text))
	arg_1_0._trophyDescLower = findTF(arg_1_0._tf, "frame/trophyDesc/Text_lower"):GetComponent(typeof(Text))
	arg_1_0._trophyCountBG = findTF(arg_1_0._tf, "frame/trophyCount")
	arg_1_0._trophyCount = findTF(arg_1_0._tf, "frame/trophyCount/Text"):GetComponent(typeof(Text))
	arg_1_0._progressBar = findTF(arg_1_0._tf, "frame/trophy_progress/Fill"):GetComponent(typeof(Slider))
	arg_1_0._reminder = findTF(arg_1_0._tf, "frame/reminder")

	return
end

function var_0_0.UpdateTrophyGroup(arg_2_0, arg_2_1)
	arg_2_0:updateInfoView((arg_2_1:getDisplayTrophy()))
	arg_2_0:updateProgressView((arg_2_1:getProgressTrophy()))

	return
end

function var_0_0.ProgressingForm(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getProgressTrophy()

	arg_3_0:updateInfoView(var_3_0)
	arg_3_0:updateProgressView(var_3_0)

	return
end

function var_0_0.ClaimForm(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getMaxClaimedTrophy()

	if var_4_0 then
		arg_4_0:updateInfoView(var_4_0)
		arg_4_0:updateProgressView(var_4_0)
	end

	return
end

function var_0_0.updateInfoView(arg_5_0, arg_5_1)
	arg_5_0._trophy = arg_5_1
	arg_5_0._trophyCount.text = arg_5_1:getConfig("rank")

	if not arg_5_1:isClaimed() and not arg_5_1:canClaimed() then
		setActive(arg_5_0._trophyCount, false)
	end

	LoadImageSpriteAsync("medal/" .. arg_5_1:getConfig("icon"), arg_5_0._trophyIcon, true)
	LoadImageSpriteAsync("medal/" .. arg_5_1:getConfig("label"), arg_5_0._trophyNamePic, true)
	arg_5_0:setGray(arg_5_0._trophyIcon, not arg_5_1:isClaimed())
	arg_5_0:setGray(arg_5_0._trophyNamePic, not arg_5_1:isClaimed())
	arg_5_0:setGray(arg_5_0._trophyNameBG, not arg_5_1:isClaimed())
	arg_5_0:setGray(arg_5_0._trophyCountBG, not arg_5_1:isClaimed())

	arg_5_0._trophyDescUpper.text = arg_5_1:getConfig("explain1")
	arg_5_0._trophyDescLower.text = arg_5_1:getConfig("explain2")

	return
end

function var_0_0.setGray(arg_6_0, arg_6_1, arg_6_2)
	setGray(arg_6_1, arg_6_2, true)

	arg_6_1:GetComponent(typeof(Image)).color = arg_6_2 and var_0_0.GRAY_COLOR or Color.white

	return
end

function var_0_0.updateProgressView(arg_7_0, arg_7_1)
	arg_7_0._progressTrophy = arg_7_1
	arg_7_0._progressBar.value = arg_7_1:getProgressRate()

	local var_7_0 = arg_7_0._progressTrophy:canClaimed() and not arg_7_0._progressTrophy:isClaimed()

	setActive(arg_7_0._reminder, var_7_0)

	return
end

function var_0_0.GetTrophyClaimTipsID(arg_8_0)
	local var_8_0 = tonumber(arg_8_0._trophy:getConfig("icon"))

	if var_8_0 < 9000 then
		var_8_0 = var_8_0 - var_8_0 % 10
	end

	return "xunzhang" .. var_8_0
end

function var_0_0.SetTrophyReminderMaterial(arg_9_0, arg_9_1)
	if arg_9_0._reminder then
		arg_9_0._reminder:Find("Image01"):GetComponent(typeof(Image)).material = arg_9_1
	end

	return
end

function var_0_0.PlayClaimAnima(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0._isPlaying = true

	setActive(arg_10_0._reminder, false)

	local var_10_0 = arg_10_0._tf:GetComponent(typeof(Animator))

	var_10_0.enabled = true

	arg_10_0._tf:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_11_0)
		arg_10_3()

		local var_11_0 = arg_10_0._progressTrophy:canClaimed() and not arg_10_0._progressTrophy:isClaimed()

		setActive(arg_10_0._reminder, var_11_0)

		return
	end)
	var_10_0:Play("trophy_upper", -1, 0)
	setActive(arg_10_2, true)

	local var_10_1 = tf(arg_10_2)

	var_10_1:SetParent(findTF(arg_10_0._tf, "frame"), false)

	var_10_1.localScale = Vector3(1, 1, 0)

	LuaHelper.SetParticleEndEvent(arg_10_2, function()
		arg_10_0._isPlaying = false

		Object.Destroy(arg_10_2)

		return
	end)

	return
end

function var_0_0.IsPlaying(arg_13_0)
	return arg_13_0._isPlaying
end

return var_0_0
