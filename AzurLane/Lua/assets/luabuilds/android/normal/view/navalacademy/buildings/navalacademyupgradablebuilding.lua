class = var_0_10000

local var_0_0 = "NavalAcademyUpgradableBuilding"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NavalAcademyBuilding"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	findTF = var_2
	arg_1_0.nameTF = var_2(arg_1_0._tf, "name")
	findTF = var_2

	local var_1_0 = var_2(arg_1_0._tf, "name/level")
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.levelTxt = var_1_1(var_1_0, var_4(var_1_10005))
	findTF = var_2
	arg_1_0.timeTF = var_2(arg_1_0._tf, "time")
	findTF = var_2

	local var_1_2 = var_2(arg_1_0._tf, "time/Text")
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.timeTxt = var_1_3(var_1_2, var_4(var_1_10005))
	findTF = var_2
	arg_1_0.floatTF = var_2(arg_1_0._tf, "float")

	local var_1_4 = arg_1_0.floatTF
	local var_1_5 = var_2.Find(var_1_4, "Text")
	local var_1_6 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.floatTxt = var_1_6(var_1_5, var_4(var_1_10005))
	findTF = var_2
	arg_1_0.bubble = var_2(arg_1_0._tf, "popup")
	arg_1_0.heigh = arg_1_0.bubble.localPosition.y
	setActive = var_2

	var_2(arg_1_0.floatTF, false)

	setText = var_2
	findTF = var_3

	local var_1_7 = var_3(arg_1_0._tf, "time/label")

	i18n = var_4

	var_2(var_1_7, var_4("class_label_upgrading"))

	return
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:UpdateResField()
	arg_2_0:UpdateBubble()

	return
end

function var_0_1.FloatAni(arg_3_0)
	LeanTween = var_1_10001

	local var_3_0 = var_1_10001.moveLocalY

	go = var_1_10002

	local var_3_1 = var_3_0(var_1_10002(arg_3_0.bubble), arg_3_0.heigh + 20, 2)
	local var_3_2 = var_1.setFrom(var_3_1, arg_3_0.heigh)

	var_1.setLoopPingPong(var_3_2)

	return
end

function var_0_1.UpdateBubble(arg_4_0)
	local var_4_0 = arg_4_0:GetResField()

	if var_1.HasRes(var_4_0) then
		arg_4_0:FloatAni()
	end

	setActive = var_4_0

	var_4_0(arg_4_0.bubble, var_2)

	onButton = var_4_0

	local var_4_1 = arg_4_0
	local var_4_2 = arg_4_0.bubble

	local function var_4_3()
		local var_5_0 = arg_4_0
		local var_5_1 = var_0.GetResField(var_5_0)
		local var_5_2 = arg_4_0
		local var_5_3 = var_1.emit

		NavalAcademyMediator = var_2_10003

		var_5_3(var_5_2, var_2_10003.ON_GET_RES, var_5_1:GetResourceType())

		return
	end

	SFX_PANEL = var_1_10007

	var_4_0(var_4_1, var_4_2, var_4_3, var_1_10007)

	return
end

function var_0_1.PlayGetResAnim(arg_6_0, arg_6_1)
	arg_6_0:UpdateBubble()

	local var_6_0 = arg_6_0.floatTxt

	var_6_0.text = "+" .. arg_6_1
	setActive = var_6_0

	var_6_0(arg_6_0.floatTF, true)

	LeanTween = var_6_0

	local var_6_1 = var_6_0.moveY

	rtf = var_3

	local var_6_2 = var_6_1(var_3(arg_6_0.floatTF), 30, 1)
	local var_6_3 = var_2.setFrom(var_6_2, 0)
	local var_6_4 = var_2.setOnComplete

	System = var_4

	var_6_4(var_6_3, var_4.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_6_0.floatTF, false)

		return
	end))

	return
end

function var_0_1.UpdateResField(arg_8_0)
	arg_8_0:RemoveTimer()

	local var_8_0 = arg_8_0:GetResField()

	arg_8_0.levelTxt.text = "Lv." .. var_8_0:GetLevel()

	local var_8_1 = var_8_0
	local var_8_2 = var_8_0.IsStarting(var_8_1)

	setActive = var_8_1

	var_8_1(arg_8_0.timeTF, var_8_2)

	setActive = var_8_1

	var_8_1(arg_8_0.nameTF, not var_8_2)

	if var_8_2 then
		arg_8_0:AddTimer()
	end

	arg_8_0:RefreshTip()

	return
end

function var_0_1.AddTimer(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.GetResField(var_9_0)

	Timer = var_9_0
	arg_9_0.timer = var_9_0.New(function()
		local var_10_0 = var_9_1

		if var_0.GetDuration(var_10_0) and var_0 > 0 then
			local var_10_1 = arg_9_0.timeTxt

			pg = var_2_10002

			local var_10_2 = var_2_10002.TimeMgr.GetInstance()

			var_10_1.text = var_2.DescCDTime(var_10_2, var_0)
		else
			local var_10_3 = arg_9_0

			var_1.UpdateResField(var_10_3)
		end

		return
	end, 1, -1)

	local var_9_2 = arg_9_0.timer

	var_2.Start(var_9_2)
	arg_9_0.timer.func()

	return
end

function var_0_1.RemoveTimer(arg_11_0)
	if arg_11_0.timer then
		local var_11_0 = arg_11_0.timer

		var_1.Stop(var_11_0)

		arg_11_0.timer = nil
	end

	return
end

function var_0_1.IsTip(arg_12_0)
	local var_12_0 = arg_12_0:GetResField()

	return var_1.CanUpgrade(var_12_0)
end

function var_0_1.Dispose(arg_13_0)
	var_0_1.super.Dispose(arg_13_0)

	local var_13_0 = arg_13_0

	arg_13_0.RemoveTimer(var_13_0)

	LeanTween = var_1

	local var_13_1 = var_1.isTweening

	go = var_13_0

	local var_13_2

	if var_13_1(var_13_0(arg_13_0.floatTF)) then
		LeanTween = var_13_2
		var_13_2 = var_13_2.cancel
		go = var_2

		var_13_2(var_2(arg_13_0.floatTF))
	end

	LeanTween = var_13_2

	local var_13_3 = var_13_2.cancel

	go = var_2

	var_13_3(var_2(arg_13_0.bubble))

	return
end

function var_0_1.GetResField(arg_14_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

return var_0_1
