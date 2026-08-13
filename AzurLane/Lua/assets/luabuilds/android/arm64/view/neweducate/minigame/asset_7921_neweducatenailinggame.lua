class = var_0_10000

local var_0_0 = "NewEducateNailingGame"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))
local var_0_2 = 125
local var_0_3 = -25
local var_0_4 = -115
local var_0_5 = 400
local var_0_6 = {
	-450,
	450
}
local var_0_7 = 9
local var_0_8 = 100
local var_0_9 = 30
local var_0_10 = 35
local var_0_11 = {
	NORMAL = 1,
	INVALID = 2
}
local var_0_12 = {
	NORMAL = 1,
	INSERTION = 2
}

function var_0_1.getUIName(arg_1_0)
	return "NewEducateNailingGame"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.meunUI = var_1.Find(var_2_0, "box/menu")

	local var_2_1 = arg_2_0._tf

	arg_2_0.countUI = var_1.Find(var_2_1, "box/count")
	setText = var_1

	local var_2_2 = arg_2_0.countUI
	local var_2_3 = var_3.Find(var_2_2, "tip/Text")

	i18n = var_4

	var_1(var_2_3, var_4("child2_nailing_game_tip"))

	local var_2_4 = arg_2_0.countUI
	local var_2_5 = var_1.Find(var_2_4, "count")
	local var_2_6 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_6
	arg_2_0.countdownDft = var_2_6(var_2_5, var_4(var_6))

	local var_2_7 = arg_2_0._tf

	arg_2_0.gameUI = var_1.Find(var_2_7, "box/game")

	local var_2_8 = arg_2_0.gameUI
	local var_2_9 = var_1.Find(var_2_8, "score/value")
	local var_2_10 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_2_0.scoreTextCom = var_2_10(var_2_9, var_4(var_6))
	setText = var_1

	local var_2_11 = arg_2_0.gameUI
	local var_2_12 = var_3.Find(var_2_11, "score/Text")

	i18n = var_4

	var_1(var_2_12, var_4("child2_nailing_game_score"))

	local var_2_13 = arg_2_0.gameUI
	local var_2_14 = var_1.Find(var_2_13, "count/value")
	local var_2_15 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_2_0.countTextCom = var_2_15(var_2_14, var_4(var_6))
	setText = var_1

	local var_2_16 = arg_2_0.gameUI
	local var_2_17 = var_3.Find(var_2_16, "count/Text")

	i18n = var_4

	var_1(var_2_17, var_4("child2_nailing_game_count"))

	local var_2_18 = arg_2_0.gameUI

	arg_2_0.charSDTF = var_1.Find(var_2_18, "dailog/char")

	local var_2_19 = arg_2_0.gameUI

	arg_2_0.hammerTF = var_1.Find(var_2_19, "hammer")

	local var_2_20 = arg_2_0.hammerTF
	local var_2_21 = var_1.GetComponent

	typeof = var_4
	SpineAnimUI = var_6
	arg_2_0.hammerAnimUI = var_2_21(var_2_20, var_4(var_6))

	local var_2_22 = arg_2_0.gameUI

	arg_2_0.nailContainer = var_1.Find(var_2_22, "nail_container")

	local var_2_23 = arg_2_0.gameUI

	arg_2_0.noramlNailTpl = var_1.Find(var_2_23, "tpls/nail_normal")

	local var_2_24 = arg_2_0.gameUI

	arg_2_0.invalidNailTpl = var_1.Find(var_2_24, "tpls/nail_invalid")

	local var_2_25 = arg_2_0._tf

	arg_2_0.resultUI = var_1.Find(var_2_25, "box/result")

	local var_2_26 = arg_2_0.resultUI
	local var_2_27 = var_1.Find(var_2_26, "score/Text")
	local var_2_28 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_2_0.resultScoreTextCom = var_2_28(var_2_27, var_4(var_6))

	local var_2_29 = arg_2_0._tf

	arg_2_0.resultEffectTF = var_1.Find(var_2_29, "box/VX_get")
	setActive = var_1

	var_1(arg_2_0.resultEffectTF, false)

	local var_2_30 = arg_2_0._tf
	local var_2_31 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_6
	arg_2_0.animDft = var_2_31(var_2_30, var_4(var_6))

	local var_2_32 = arg_2_0.animDft

	var_1.SetEndEvent(var_2_32, function(arg_3_0)
		local var_3_0 = arg_2_0

		var_1._Hide(var_3_0)

		return
	end)

	return
end

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = arg_4_0.countdownDft

	var_1.SetEndEvent(var_4_0, function(arg_5_0)
		local var_5_0 = arg_4_0

		var_1.StartGame(var_5_0)

		return
	end)

	onButton = var_1

	local var_4_1 = arg_4_0
	local var_4_2 = arg_4_0._tf
	local var_4_3 = var_4.Find(var_4_2, "back")

	local function var_4_4()
		local var_6_0 = arg_4_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_4_2

	var_1(var_4_1, var_4_3, var_4_4, var_4_2)

	onButton = var_1

	local var_4_5 = arg_4_0
	local var_4_6 = arg_4_0._tf
	local var_4_7 = var_4.Find(var_4_6, "box/menu/help")

	local function var_4_8()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_7_2.type = var_2_10004
		pg = var_2_10004
		var_7_2.helps = var_2_10004.gametip.child2_nailing_minigame_help.tip

		var_7_1(var_7_0, var_7_2)

		return
	end

	SFX_PANEL = var_4_6

	var_1(var_4_5, var_4_7, var_4_8, var_4_6)

	onButton = var_1

	local var_4_9 = arg_4_0
	local var_4_10 = arg_4_0.meunUI
	local var_4_11 = var_4.Find(var_4_10, "start")

	local function var_4_12()
		local var_8_0 = arg_4_0

		var_0.StartCountDown(var_8_0)

		return
	end

	SFX_PANEL = var_4_10

	var_1(var_4_9, var_4_11, var_4_12, var_4_10)

	onButton = var_1

	local var_4_13 = arg_4_0
	local var_4_14 = arg_4_0.gameUI
	local var_4_15 = var_4.Find(var_4_14, "knock")

	local function var_4_16()
		local var_9_0 = arg_4_0

		var_0.Knock(var_9_0)

		return
	end

	SFX_PANEL = var_4_14

	var_1(var_4_13, var_4_15, var_4_16, var_4_14)

	onButton = var_1

	local var_4_17 = arg_4_0
	local var_4_18 = arg_4_0.resultUI
	local var_4_19 = var_4.Find(var_4_18, "sure")

	local function var_4_20()
		local var_10_0 = arg_4_0

		var_0.Hide(var_10_0)

		return
	end

	SFX_PANEL = var_4_18

	var_1(var_4_17, var_4_19, var_4_20, var_4_18)

	return
end

function var_0_1.Show(arg_11_0, arg_11_1, arg_11_2)
	var_0_1.super.Show(arg_11_0)

	arg_11_0.id = arg_11_1
	arg_11_0.onHide = arg_11_2
	pg = var_3
	arg_11_0.configData = var_3.child2_minigame[arg_11_0.id].config_data
	arg_11_0.totalCnt = arg_11_0.configData.count
	arg_11_0.speed = arg_11_0.configData.hammer_spd
	arg_11_0.normalCnt = arg_11_0.configData.nail_count
	arg_11_0.invalidCnt = arg_11_0.configData.red_nail_count
	arg_11_0.normalScore = arg_11_0.configData.nail_score
	arg_11_0.invalidScore = arg_11_0.configData.red_nail_score
	arg_11_0.slotList = {}

	for iter_11_0 = 1, var_0_7 do
		table = var_1_10007

		var_1_10007.insert(arg_11_0.slotList, iter_11_0)
	end

	arg_11_0:LoadCharSD()
	arg_11_0:BlurPanel(arg_11_0._tf, {
		groupDelta = 3
	})

	return
end

function var_0_1.LoadCharSD(arg_12_0)
	getProxy = var_1_10001
	NewEducateProxy = var_1_10003

	local var_12_0 = var_1_10001(var_1_10003)
	local var_12_1 = var_1.GetCurChar(var_12_0)
	local var_12_2 = var_1.getConfig(var_12_1, "spine_char").minigame_face

	PoolMgr = var_1_10002

	local var_12_3 = var_1_10002.GetInstance()

	var_2.GetSpineChar(var_12_3, var_12_2, true, function(arg_13_0)
		arg_12_0.charName = var_12_2

		local var_13_0 = arg_12_0

		var_13_0.charModel = arg_13_0
		tf = var_13_0

		local var_13_1 = var_13_0(arg_13_0)

		Vector3 = var_2
		var_13_1.localScale = var_2(1, 1, 1)

		local var_13_2 = arg_13_0:GetComponent("SpineAnimUI")

		var_1.SetAction(var_13_2, "normal", 0)

		setParent = var_1

		var_1(arg_13_0, arg_12_0.charSDTF)

		return
	end)

	return
end

function var_0_1.ResetGame(arg_14_0)
	arg_14_0.isKnocking = false
	arg_14_0.score = 0

	arg_14_0:UpdateScore()

	arg_14_0.remainCnt = arg_14_0.totalCnt

	arg_14_0:UpdateRemainCnt()

	setActive = var_1

	var_1(arg_14_0.meunUI, false)

	setActive = var_1

	var_1(arg_14_0.countUI, false)

	setActive = var_1

	var_1(arg_14_0.resultUI, false)

	setActive = var_1

	var_1(arg_14_0.gameUI, true)

	setActive = var_1

	var_1(arg_14_0.resultEffectTF, false)
	arg_14_0:ResetHammer()

	return
end

function var_0_1.StartCountDown(arg_15_0)
	setActive = var_1_10001

	var_1_10001(arg_15_0.meunUI, false)

	setActive = var_1_10001

	var_1_10001(arg_15_0.countUI, true)

	quickPlayAnimator = var_1_10001

	local var_15_0 = arg_15_0.countUI

	var_1_10001(var_3.Find(var_15_0, "count"), "countdown")

	return
end

function var_0_1.StartGame(arg_16_0)
	arg_16_0:ResetGame()
	arg_16_0:RandomNails()
	arg_16_0:MoveHammer()

	return
end

function var_0_1.RandomNails(arg_17_0)
	removeAllChildren = var_1_10001

	var_1_10001(arg_17_0.nailContainer)

	arg_17_0.nails = {}
	shuffle = var_1

	var_1(arg_17_0.slotList)

	for iter_17_0 = 1, arg_17_0.normalCnt + arg_17_0.invalidCnt do
		local var_17_0

		if not (iter_17_0 <= arg_17_0.normalCnt) or not var_0_11.NORMAL then
			var_17_0 = var_0_11.INVALID
		end

		local var_17_1

		if var_17_0 ~= var_0_11.NORMAL or not arg_17_0.noramlNailTpl then
			var_17_1 = arg_17_0.invalidNailTpl
		end

		cloneTplTo = var_1_10007
		var_1_10007 = var_1_10007(var_17_1, arg_17_0.nailContainer)

		local var_17_2 = (arg_17_0.slotList[iter_17_0] - 1) * var_0_8 + var_0_6[1]
		local var_17_3 = {
			y = 0
		}

		math = var_10
		var_17_3.x = var_17_2 + var_10.random(0, var_0_9)
		setLocalPosition = var_10

		var_10(var_1_10007, var_17_3)

		arg_17_0.nails[var_1_10007] = {
			type = var_17_0,
			pos = var_17_3,
			state = var_0_12.NORMAL
		}
	end

	return
end

function var_0_1.ResetHammer(arg_18_0)
	setLocalPosition = var_1_10001

	var_1_10001(arg_18_0.hammerTF, {
		x = var_0_6[1],
		y = var_0_2
	})

	return
end

function var_0_1.MoveHammer(arg_19_0)
	local var_19_0 = (var_0_6[2] - var_0_6[1]) / arg_19_0.speed

	LeanTween = var_2

	local var_19_1 = var_2.moveX(arg_19_0.hammerTF, var_0_6[2], var_19_0)

	arg_19_0.swayTweenId = var_2.setLoopPingPong(var_19_1, 0).uniqueId

	return
end

function var_0_1.PauseSway(arg_20_0)
	LeanTween = var_1_10001

	if var_1_10001.isTweening(arg_20_0.swayTweenId) then
		LeanTween = var_1

		var_1.pause(arg_20_0.swayTweenId)
	end

	return
end

function var_0_1.ResumeSway(arg_21_0)
	LeanTween = var_1_10001

	if var_1_10001.isTweening(arg_21_0.swayTweenId) then
		LeanTween = var_1

		var_1.resume(arg_21_0.swayTweenId)
	end

	return
end

function var_0_1.Knock(arg_22_0)
	if arg_22_0.isKnocking then
		return
	end

	arg_22_0.isKnocking = true

	arg_22_0:PauseSway()

	arg_22_0.remainCnt = arg_22_0.remainCnt - 1

	arg_22_0:UpdateRemainCnt()

	local var_22_0 = arg_22_0:GetHitNailTF()
	local var_22_1 = arg_22_0.nails[var_22_0] and var_2.state == var_0_12.NORMAL

	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_23_0)
			local var_23_0 = arg_22_0

			var_1.DownHammer(var_23_0, var_22_1, arg_23_0)

			return
		end,
		function(arg_24_0)
			local var_24_0 = arg_22_0

			var_1.CheckHit(var_24_0, var_22_0, arg_24_0)

			return
		end,
		function(arg_25_0)
			local var_25_0 = arg_22_0

			var_1.UpHammer(var_25_0, arg_25_0)

			return
		end
	}, function()
		local var_26_0 = arg_22_0

		var_0.CheckGameOver(var_26_0)

		arg_22_0.isKnocking = false

		return
	end)

	return
end

function var_0_1.GetHitNailTF(arg_27_0)
	local var_27_0 = arg_27_0.hammerTF.localPosition.x

	pairs = var_1_10002

	for iter_27_0, iter_27_1 in var_1_10002(arg_27_0.nails) do
		if var_27_0 >= iter_27_0.localPosition.x - var_0_10 and var_27_0 <= var_7 + var_0_10 then
			return iter_27_0
		end
	end

	return nil
end

function var_0_1.DownHammer(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0

	if not arg_28_1 or not var_0_3 then
		var_28_0 = var_0_4
	end

	local var_28_1 = (var_28_0 - var_0_2) / var_0_5

	LeanTween = var_5

	local var_28_2 = var_5.moveY(arg_28_0.hammerTF, var_28_0, var_28_1)
	local var_28_3 = var_5.setOnComplete

	System = var_8
	arg_28_0.downTweenId = var_28_3(var_28_2, var_8.Action(arg_28_2)).uniqueId

	local var_28_4 = arg_28_0.hammerAnimUI
	local var_28_5 = var_5.GetAnimationState(var_28_4)

	var_5.SetAnimation(var_28_5, 0, "normal", false)

	return
end

function var_0_1.CheckHit(arg_29_0, arg_29_1, arg_29_2)
	if not (arg_29_0.nails[arg_29_1] and var_3.state == var_0_12.NORMAL) then
		-- block empty
	else
		if var_3.type == var_0_11.NORMAL then
			var_3.state = var_0_12.INSERTION
			arg_29_0.score = arg_29_0.score + arg_29_0.normalScore
			setActive = var_5

			var_5(arg_29_1:Find("insertion"), true)

			setActive = var_5

			var_5(arg_29_1:Find("normal"), false)
		else
			math = var_5
			arg_29_0.score = var_5.max(arg_29_0.score + arg_29_0.invalidScore, 0)
		end

		arg_29_0:UpdateScore()
	end

	arg_29_2()

	return
end

function var_0_1.UpHammer(arg_30_0, arg_30_1)
	local var_30_0 = (var_0_2 - arg_30_0.hammerTF.localPosition.y) / var_0_5

	LeanTween = var_3

	local var_30_1 = var_3.moveY(arg_30_0.hammerTF, var_0_2, var_30_0)
	local var_30_2 = var_3.setOnComplete

	System = var_6
	arg_30_0.upTweenId = var_30_2(var_30_1, var_6.Action(arg_30_1)).uniqueId

	return
end

function var_0_1.CheckGameOver(arg_31_0)
	if arg_31_0.remainCnt == 0 then
		arg_31_0:EndGame()
	else
		arg_31_0:ResumeSway()
	end

	return
end

function var_0_1.UpdateScore(arg_32_0)
	local var_32_0 = arg_32_0.resultScoreTextCom

	i18n = var_1_10002
	var_32_0.text = var_1_10002("child2_nailing_game_result") .. arg_32_0.score
	arg_32_0.scoreTextCom.text = arg_32_0.score

	return
end

function var_0_1.UpdateRemainCnt(arg_33_0)
	arg_33_0.countTextCom.text = arg_33_0.remainCnt

	return
end

function var_0_1.EndGame(arg_34_0)
	setActive = var_1_10001

	var_1_10001(arg_34_0.gameUI, false)

	setActive = var_1_10001

	var_1_10001(arg_34_0.resultUI, true)

	setActive = var_1_10001

	var_1_10001(arg_34_0.resultEffectTF, true)

	return
end

function var_0_1._Hide(arg_35_0)
	var_0_1.super.Hide(arg_35_0)
	arg_35_0:UnOverlayPanel(arg_35_0._tf)

	existCall = var_1

	var_1(arg_35_0.onHide(arg_35_0.score))

	arg_35_0.onHide = nil
	LeanTween = var_1

	if var_1.isTweening(arg_35_0.swayTweenId) then
		LeanTween = var_1

		var_1.cancel(arg_35_0.swayTweenId)
	end

	arg_35_0.swayTweenId = nil
	LeanTween = var_1

	if var_1.isTweening(arg_35_0.upTweenId) then
		LeanTween = var_1

		var_1.cancel(arg_35_0.upTweenId)
	end

	arg_35_0.upTweenId = nil
	LeanTween = var_1

	if var_1.isTweening(arg_35_0.downTweenId) then
		LeanTween = var_1

		var_1.cancel(arg_35_0.downTweenId)
	end

	arg_35_0.downTweenId = nil

	if arg_35_0.charName and arg_35_0.charModel then
		PoolMgr = var_1

		local var_35_0 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_35_0, arg_35_0.charName, arg_35_0.charModel)

		arg_35_0.charName = nil
		arg_35_0.charModel = nil
	end

	return
end

function var_0_1.Hide(arg_36_0)
	quickPlayAnimation = var_1_10001

	var_1_10001(arg_36_0._tf, "anim_NewEducateNailingGame_out")

	return
end

function var_0_1.OnDestroy(arg_37_0)
	local var_37_0 = arg_37_0.animDft

	var_1.SetEndEvent(var_37_0, nil)

	local var_37_1 = arg_37_0.countdownDft

	var_1.SetEndEvent(var_37_1, nil)

	local var_37_2 = arg_37_0.hammerAnimUI

	var_1.SetActionCallBack(var_37_2, nil)

	return
end

return var_0_1
