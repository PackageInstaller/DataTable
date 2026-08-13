class = var_0_10000

local var_0_0 = "BgStoryPlayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".DialogueStoryPlayer"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0.bgPanel
	local var_1_1 = var_2.Find(var_1_0, "sub")
	local var_1_2 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.subImage = var_1_2(var_1_1, var_5(var_1_10007))
	setActive = var_2

	var_2(arg_1_0.subImage.gameObject, false)

	arg_1_0.bgRecord = nil

	return
end

function var_0_1.Reset(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_1.super.super.Reset(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	setActive = var_4

	var_4(arg_2_0.bgPanel, true)

	setActive = var_4

	var_4(arg_2_0.subImage.gameObject, false)

	setActive = var_4

	var_4(arg_2_0.actorPanel, false)
	arg_2_0:RecyclePainting({
		"actorLeft",
		"actorMiddle",
		"actorRgiht"
	})

	return
end

function var_0_1.OnBgUpdate(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:GetBgName()

	if arg_3_0.bgRecord ~= var_3_0 then
		arg_3_0.bgRecord = var_3_0

		local var_3_1 = arg_3_1:GetFadeSpeed()

		arg_3_0:TweenValueForcanvasGroup(arg_3_0.bgPanelCg, 0, 1, var_3_1, 0, nil)
	end

	return
end

function var_0_1.UpdateBg(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1

	if arg_4_1.GetSubBg(var_4_0) then
		setActive = var_1_10003

		var_1_10003(arg_4_0.subImage.gameObject, true)

		if arg_4_0:GetBg(var_2) then
			var_4_0 = arg_4_0.subImage
			var_4_0.sprite = var_1_10003
			originalPrint = var_4_0

			local var_4_1 = "story sub bg load : "

			tostring = var_1_10007

			var_4_0(var_4_1 .. var_1_10007(var_2))
		else
			warning = var_4_0

			local var_4_2 = "story sub bg load faild : "

			tostring = var_1_10007

			var_4_0(var_4_2 .. var_1_10007(var_2))
		end
	else
		setActive = var_1_10003

		var_1_10003(arg_4_0.subImage.gameObject, false)
	end

	if not arg_4_1:GetBgName() then
		return
	end

	var_0_1.super.UpdateBg(arg_4_0, arg_4_1)

	return
end

function var_0_1.OnInit(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_1:ShouldBlackScreen() then
		setActive = var_4

		var_4(arg_5_0.curtain, true)

		local var_5_0 = arg_5_0.curtain

		var_4.SetAsLastSibling(var_5_0)
		arg_5_3()
	else
		var_0_1.super.OnInit(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	end

	return
end

function var_0_1.OnEnter(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_1:ShouldBlackScreen() then
		arg_6_0:DelayCall(arg_6_1:ShouldBlackScreen(), function()
			setActive = var_2_10000

			var_2_10000(arg_6_0.curtain, true)

			local var_7_0 = arg_6_0.curtain

			var_0.SetAsFirstSibling(var_7_0)

			assert = var_0

			local var_7_1 = arg_6_1

			var_0(not var_2.ExistOption(var_7_1))
			arg_6_3()

			triggerButton = var_0

			var_0(arg_6_0._go)

			return
		end)
	else
		local var_6_0 = arg_6_1:GetUnscaleDelay()

		if arg_6_0.autoNext then
			local var_6_1 = arg_6_0.script

			var_6_0 = var_6_0 - var_5.GetTriggerDelayTime(var_6_1)
		end

		arg_6_0:UnscaleDelayCall(var_6_0, function()
			var_0_1.super.OnEnter(arg_6_0, arg_6_1, arg_6_2, arg_6_3)

			return
		end)
	end

	return
end

function var_0_1.GetSideTF(arg_9_0, arg_9_1)
	local var_9_0
	local var_9_1
	local var_9_2
	local var_9_3

	DialogueStep = var_1_10006

	local var_9_4

	if var_1_10006.SIDE_LEFT == arg_9_1 then
		var_9_4 = nil
		var_9_1, var_9_2, var_9_3 = arg_9_0.nameLeft, arg_9_0.nameLeftTxt
		var_9_0 = var_9_4
	else
		DialogueStep = var_9_4

		local var_9_5

		if var_9_4.SIDE_RIGHT == arg_9_1 then
			var_9_5 = nil
			var_9_1, var_9_2, var_9_3 = arg_9_0.nameRight, arg_9_0.nameRightTxt
			var_9_0 = var_9_5
		else
			DialogueStep = var_9_5

			if var_9_5.SIDE_MIDDLE == arg_9_1 then
				var_9_0, var_9_1, var_9_2, var_9_3 = nil, arg_9_0.nameLeft, arg_9_0.nameLeftTxt
			end
		end
	end

	return var_9_0, var_9_1, var_9_2, var_9_3
end

function var_0_1.Clear(arg_10_0, arg_10_1)
	arg_10_0.bgs = {}
	arg_10_0.goCG.alpha = 1
	arg_10_0.callback = nil
	arg_10_0.autoNext = nil
	arg_10_0.script = nil
	arg_10_0.subImage.sprite = nil

	arg_10_0:OnClear()

	if arg_10_1 then
		arg_10_1()
	end

	pg = var_2

	var_2.DelegateInfo.New(arg_10_0)

	return
end

function var_0_1.StoryEnd(arg_11_0)
	var_0_1.super.StoryEnd(arg_11_0)

	arg_11_0.bgRecord = nil
	arg_11_0.bgImage.sprite = nil

	return
end

return var_0_1
