class = var_0_10000

local var_0_0 = "NewEducateScratchGame"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

var_0_1.HAND_MOVE_TIME = 1

function var_0_1.getUIName(arg_1_0)
	return "NewEducateScratchGame"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "panel/card/rawImage")
	local var_2_2 = var_1.GetComponent

	typeof = var_4
	UIScratch = var_1_10006
	arg_2_0.scratchCom = var_2_2(var_2_1, var_4(var_1_10006))

	local var_2_3 = arg_2_0._tf

	arg_2_0.resultTF = var_1.Find(var_2_3, "panel/card/result")

	local var_2_4 = arg_2_0._tf

	arg_2_0.handTF = var_1.Find(var_2_4, "panel/hand")

	local var_2_5 = arg_2_0._tf

	arg_2_0.sureBtn = var_1.Find(var_2_5, "panel/sure")

	local var_2_6 = arg_2_0._tf

	arg_2_0.resultEffectTF = var_1.Find(var_2_6, "bg/VX_get")
	setActive = var_1

	var_1(arg_2_0.resultEffectTF, false)

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_2_0.animDft = var_2_8(var_2_7, var_4(var_1_10006))

	local var_2_9 = arg_2_0.animDft

	var_1.SetEndEvent(var_2_9, function(arg_3_0)
		local var_3_0 = arg_2_0

		var_1._Hide(var_3_0)

		return
	end)

	return
end

function var_0_1.OnInit(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_4.Find(var_4_1, "back")

	local function var_4_3()
		local var_5_0 = arg_4_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_4_1

	var_1_10001(var_4_0, var_4_2, var_4_3, var_4_1)

	onButton = var_1_10001

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0.sureBtn

	local function var_4_6()
		local var_6_0 = arg_4_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_4_1

	var_1_10001(var_4_4, var_4_5, var_4_6, var_4_1)

	onButton = var_1_10001

	local var_4_7 = arg_4_0
	local var_4_8 = arg_4_0._tf
	local var_4_9 = var_4.Find(var_4_8, "help")

	local function var_4_10()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_7_2.type = var_2_10004
		pg = var_2_10004
		var_7_2.helps = var_2_10004.gametip.child2_scratch_minigame_help.tip

		var_7_1(var_7_0, var_7_2)

		return
	end

	SFX_PANEL = var_4_8

	var_1_10001(var_4_7, var_4_9, var_4_10, var_4_8)

	function arg_4_0.scratchCom.onUpdateErase(arg_8_0)
		local var_8_0 = arg_4_0

		tonumber = var_2_10002
		string = var_2_10004
		var_8_0.progress = var_2_10002(var_2_10004.format("%.2f", arg_8_0))

		local var_8_1 = arg_4_0

		var_1.UpdateProgress(var_8_1)

		isActive = var_1

		if var_1(arg_4_0.handTF) then
			local var_8_2 = arg_4_0

			var_1.ResetHand(var_8_2)
		end

		return
	end

	function arg_4_0.scratchCom.onFinishErase()
		local var_9_0 = arg_4_0

		var_0.EndGame(var_9_0)

		return
	end

	return
end

function var_0_1.Show(arg_10_0, arg_10_1, arg_10_2)
	var_0_1.super.Show(arg_10_0)

	arg_10_0.id = arg_10_1
	pg = var_3
	arg_10_0.configData = var_3.child2_minigame[arg_10_0.id].config_data
	arg_10_0.finishScore = arg_10_0.configData.finish_score
	arg_10_0.onHide = arg_10_2

	arg_10_0:StartGame()
	arg_10_0:BlurPanel(arg_10_0._tf, {
		groupDelta = 3
	})

	return
end

function var_0_1.ResetGame(arg_11_0)
	arg_11_0.score = 0
	arg_11_0.progress = 0

	arg_11_0:UpdateProgress()

	local var_11_0 = arg_11_0.scratchCom

	var_1.ResetErase(var_11_0)

	math = var_1

	local var_11_1 = var_1.random(3)

	eachChild = var_1_10002

	var_1_10002(arg_11_0.resultTF, function(arg_12_0)
		setActive = var_2_10001

		local var_12_0 = arg_12_0

		tonumber = var_2_10004

		var_2_10001(var_12_0, var_2_10004(arg_12_0.name) == var_11_1)

		return
	end)

	setActive = var_1_10002

	var_1_10002(arg_11_0.sureBtn, false)

	setActive = var_1_10002

	var_1_10002(arg_11_0.resultEffectTF, false)
	arg_11_0:ResetHand()

	return
end

function var_0_1.ResetHand(arg_13_0)
	arg_13_0:cleanManagedTween()

	setLocalPosition = var_1

	var_1(arg_13_0.handTF, {
		x = 318
	})

	setActive = var_1

	var_1(arg_13_0.handTF, false)

	return
end

function var_0_1.StartGame(arg_14_0)
	arg_14_0:ResetGame()

	setActive = var_1

	var_1(arg_14_0.handTF, true)

	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.managedTween

	LeanTween = var_4

	local var_14_2 = var_14_1(var_14_0, var_4.moveX, nil, arg_14_0.handTF, -220, var_0_1.HAND_MOVE_TIME)

	var_1.setLoopPingPong(var_14_2)

	return
end

function var_0_1.UpdateProgress(arg_15_0)
	return
end

function var_0_1.EndGame(arg_16_0)
	local var_16_0

	if not (arg_16_0.progress >= arg_16_0.scratchCom.finishPercent) or not arg_16_0.finishScore then
		var_16_0 = 0
	end

	arg_16_0.score = var_16_0
	arg_16_0.progress = 1

	arg_16_0:UpdateProgress()

	setActive = var_1

	var_1(arg_16_0.sureBtn, true)

	setActive = var_1

	var_1(arg_16_0.resultEffectTF, true)

	return
end

function var_0_1._Hide(arg_17_0)
	var_0_1.super.Hide(arg_17_0)
	arg_17_0:UnOverlayPanel(arg_17_0._tf)

	existCall = var_1

	var_1(arg_17_0.onHide(arg_17_0.score))

	arg_17_0.onHide = nil

	return
end

function var_0_1.Hide(arg_18_0)
	quickPlayAnimation = var_1_10001

	var_1_10001(arg_18_0._tf, "anim_NewEducateScratchGame_out")

	return
end

function var_0_1.OnDestroy(arg_19_0)
	local var_19_0 = arg_19_0.animDft

	var_1.SetEndEvent(var_19_0, nil)

	return
end

return var_0_1
