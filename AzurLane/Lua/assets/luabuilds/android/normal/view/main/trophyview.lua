class = var_0_10000

local var_0_0 = var_0_10000("TrophyView")

Color = var_1
var_0_0.GRAY_COLOR = var_1(0.764, 0.764, 0.764, 0.784)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	findTF = var_2
	arg_1_0._trophyNamePic = var_2(arg_1_0._tf, "frame/trophyName/Text")
	findTF = var_2
	arg_1_0._trophyNameBG = var_2(arg_1_0._tf, "frame/trophyName")
	findTF = var_2
	arg_1_0._trophyIcon = var_2(arg_1_0._tf, "frame/trophyIcon")
	findTF = var_2

	local var_1_0 = var_2(arg_1_0._tf, "frame/trophyDesc/Text_upper")
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0._trophyDescUpper = var_1_1(var_1_0, var_4(var_1_10005))
	findTF = var_2

	local var_1_2 = var_2(arg_1_0._tf, "frame/trophyDesc/Text_lower")
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0._trophyDescLower = var_1_3(var_1_2, var_4(var_1_10005))
	findTF = var_2
	arg_1_0._trophyCountBG = var_2(arg_1_0._tf, "frame/trophyCount")
	findTF = var_2

	local var_1_4 = var_2(arg_1_0._tf, "frame/trophyCount/Text")
	local var_1_5 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0._trophyCount = var_1_5(var_1_4, var_4(var_1_10005))
	findTF = var_2

	local var_1_6 = var_2(arg_1_0._tf, "frame/trophy_progress/Fill")
	local var_1_7 = var_2.GetComponent

	typeof = var_4
	Slider = var_1_10005
	arg_1_0._progressBar = var_1_7(var_1_6, var_4(var_1_10005))
	findTF = var_2
	arg_1_0._reminder = var_2(arg_1_0._tf, "frame/reminder")

	return
end

function var_0_0.UpdateTrophyGroup(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:getDisplayTrophy()
	local var_2_1 = arg_2_1:getProgressTrophy()

	arg_2_0:updateInfoView(var_2_0)
	arg_2_0:updateProgressView(var_2_1)

	return
end

function var_0_0.ProgressingForm(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getProgressTrophy()

	arg_3_0:updateInfoView(var_3_0)
	arg_3_0:updateProgressView(var_3_0)

	return
end

function var_0_0.ClaimForm(arg_4_0, arg_4_1)
	if arg_4_1:getMaxClaimedTrophy() then
		arg_4_0:updateInfoView(var_2)
		arg_4_0:updateProgressView(var_2)
	end

	return
end

function var_0_0.updateInfoView(arg_5_0, arg_5_1)
	arg_5_0._trophy = arg_5_1
	arg_5_0._trophyCount.text = arg_5_1:getConfig("rank")

	if not arg_5_1:isClaimed() and not arg_5_1:canClaimed() then
		setActive = var_2

		var_2(arg_5_0._trophyCount, false)
	end

	LoadImageSpriteAsync = var_2

	var_2("medal/" .. arg_5_1:getConfig("icon"), arg_5_0._trophyIcon, true)

	LoadImageSpriteAsync = var_2

	var_2("medal/" .. arg_5_1:getConfig("label"), arg_5_0._trophyNamePic, true)
	arg_5_0:setGray(arg_5_0._trophyIcon, not arg_5_1:isClaimed())
	arg_5_0:setGray(arg_5_0._trophyNamePic, not arg_5_1:isClaimed())
	arg_5_0:setGray(arg_5_0._trophyNameBG, not arg_5_1:isClaimed())
	arg_5_0:setGray(arg_5_0._trophyCountBG, not arg_5_1:isClaimed())

	arg_5_0._trophyDescUpper.text = arg_5_1:getConfig("explain1")
	arg_5_0._trophyDescLower.text = arg_5_1:getConfig("explain2")

	return
end

function var_0_0.setGray(arg_6_0, arg_6_1, arg_6_2)
	setGray = var_1_10003

	var_1_10003(arg_6_1, arg_6_2, true)

	if arg_6_2 then
		local var_6_0 = arg_6_1
		local var_6_1 = arg_6_1.GetComponent

		typeof = var_5
		Image = var_6
		var_6_1(var_6_0, var_5(var_6)).color = var_0_0.GRAY_COLOR
	else
		local var_6_2 = arg_6_1
		local var_6_3 = arg_6_1.GetComponent

		typeof = var_5
		Image = var_6

		local var_6_4 = var_6_3(var_6_2, var_5(var_6))

		Color = var_6_2
		var_6_4.color = var_6_2.white
	end

	return
end

function var_0_0.updateProgressView(arg_7_0, arg_7_1)
	arg_7_0._progressTrophy = arg_7_1

	local var_7_0 = arg_7_0._progressBar

	var_7_0.value = arg_7_1:getProgressRate()
	setActive = var_7_0

	local var_7_1 = arg_7_0._reminder
	local var_7_2 = arg_7_0._progressTrophy
	local var_7_4

	if var_4.canClaimed(var_7_2) then
		local var_7_3 = arg_7_0._progressTrophy

		var_7_4 = not var_4.isClaimed(var_7_3)
	end

	var_7_0(var_7_1, var_7_4)

	return
end

function var_0_0.GetTrophyClaimTipsID(arg_8_0)
	tonumber = var_1_10001

	local var_8_0 = arg_8_0._trophy
	local var_8_1

	if var_1_10001(var_2.getConfig(var_8_0, "icon")) < 9000 then
		var_8_1 = var_8_1 - var_8_1 % 10
	end

	return "xunzhang" .. var_8_1
end

function var_0_0.SetTrophyReminderMaterial(arg_9_0, arg_9_1)
	if arg_9_0._reminder then
		local var_9_0 = arg_9_0._reminder
		local var_9_1 = var_2.Find(var_9_0, "Image01")
		local var_9_2 = var_2.GetComponent

		typeof = var_4
		Image = var_1_10005
		var_9_2(var_9_1, var_4(var_1_10005)).material = arg_9_1
	end

	return
end

function var_0_0.PlayClaimAnima(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0._isPlaying = true
	setActive = var_4

	var_4(arg_10_0._reminder, false)

	local var_10_0 = arg_10_0._tf
	local var_10_1 = var_4.GetComponent

	typeof = var_6
	Animator = var_1_10007

	local var_10_2 = var_10_1(var_10_0, var_6(var_1_10007))

	var_10_2.enabled = true

	local var_10_3 = arg_10_0._tf
	local var_10_4 = var_5.GetComponent

	typeof = var_1_10007
	DftAniEvent = var_1_10008

	local var_10_5 = var_10_4(var_10_3, var_1_10007(var_1_10008))

	var_5.SetEndEvent(var_10_5, function(arg_11_0)
		arg_10_3()

		setActive = var_1

		local var_11_0 = arg_10_0._reminder
		local var_11_1 = arg_10_0._progressTrophy
		local var_11_3

		if var_3.canClaimed(var_11_1) then
			local var_11_2 = arg_10_0._progressTrophy

			var_11_3 = not var_3.isClaimed(var_11_2)
		end

		var_1(var_11_0, var_11_3)

		return
	end)
	var_10_2:Play("trophy_upper", -1, 0)

	setActive = var_6

	var_6(arg_10_2, true)

	tf = var_6

	local var_10_6 = var_6(arg_10_2)
	local var_10_7 = var_6.SetParent

	findTF = var_9

	var_10_7(var_10_6, var_9(arg_10_0._tf, "frame"), false)

	Vector3 = var_10_7
	var_6.localScale = var_10_7(1, 1, 0)
	LuaHelper = var_7

	var_7.SetParticleEndEvent(arg_10_2, function()
		local var_12_0 = arg_10_0

		var_12_0._isPlaying = false
		Object = var_12_0

		var_12_0.Destroy(arg_10_2)

		return
	end)

	return
end

function var_0_0.IsPlaying(arg_13_0)
	return arg_13_0._isPlaying
end

return var_0_0
