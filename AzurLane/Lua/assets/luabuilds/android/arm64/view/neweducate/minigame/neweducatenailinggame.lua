local var_0_0 = class("NewEducateNailingGame", import("view.base.BaseSubView"))
local var_0_1 = 125
local var_0_2 = -25
local var_0_3 = -115
local var_0_4 = 400
local var_0_5 = {
	-450,
	450
}
local var_0_6 = 9
local var_0_7 = 100
local var_0_8 = 30
local var_0_9 = 35
local var_0_10 = {
	NORMAL = 1,
	INVALID = 2
}
local var_0_11 = {
	NORMAL = 1,
	INSERTION = 2
}

function var_0_0.getUIName(arg_1_0)
	return "NewEducateNailingGame"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.meunUI = arg_2_0._tf:Find("box/menu")
	arg_2_0.countUI = arg_2_0._tf:Find("box/count")

	setText(arg_2_0.countUI:Find("tip/Text"), i18n("child2_nailing_game_tip"))

	arg_2_0.countdownDft = arg_2_0.countUI:Find("count"):GetComponent(typeof(DftAniEvent))
	arg_2_0.gameUI = arg_2_0._tf:Find("box/game")
	arg_2_0.scoreTextCom = arg_2_0.gameUI:Find("score/value"):GetComponent(typeof(Text))

	setText(arg_2_0.gameUI:Find("score/Text"), i18n("child2_nailing_game_score"))

	arg_2_0.countTextCom = arg_2_0.gameUI:Find("count/value"):GetComponent(typeof(Text))

	setText(arg_2_0.gameUI:Find("count/Text"), i18n("child2_nailing_game_count"))

	arg_2_0.charSDTF = arg_2_0.gameUI:Find("dailog/char")
	arg_2_0.hammerTF = arg_2_0.gameUI:Find("hammer")
	arg_2_0.hammerAnimUI = arg_2_0.hammerTF:GetComponent(typeof(SpineAnimUI))
	arg_2_0.nailContainer = arg_2_0.gameUI:Find("nail_container")
	arg_2_0.noramlNailTpl = arg_2_0.gameUI:Find("tpls/nail_normal")
	arg_2_0.invalidNailTpl = arg_2_0.gameUI:Find("tpls/nail_invalid")
	arg_2_0.resultUI = arg_2_0._tf:Find("box/result")
	arg_2_0.resultScoreTextCom = arg_2_0.resultUI:Find("score/Text"):GetComponent(typeof(Text))
	arg_2_0.resultEffectTF = arg_2_0._tf:Find("box/VX_get")

	setActive(arg_2_0.resultEffectTF, false)

	arg_2_0.animDft = arg_2_0._tf:GetComponent(typeof(DftAniEvent))

	arg_2_0.animDft:SetEndEvent(function(arg_3_0)
		arg_2_0:_Hide()

		return
	end)

	return
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.countdownDft:SetEndEvent(function(arg_5_0)
		arg_4_0:StartGame()

		return
	end)
	onButton(arg_4_0, arg_4_0._tf:Find("back"), function()
		arg_4_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0._tf:Find("box/menu/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.child2_nailing_minigame_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.meunUI:Find("start"), function()
		arg_4_0:StartCountDown()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.gameUI:Find("knock"), function()
		arg_4_0:Knock()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.resultUI:Find("sure"), function()
		arg_4_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_11_0, arg_11_1, arg_11_2)
	var_0_0.super.Show(arg_11_0)

	arg_11_0.id = arg_11_1
	arg_11_0.onHide = arg_11_2
	arg_11_0.configData = pg.child2_minigame[arg_11_0.id].config_data
	arg_11_0.totalCnt = arg_11_0.configData.count
	arg_11_0.speed = arg_11_0.configData.hammer_spd
	arg_11_0.normalCnt = arg_11_0.configData.nail_count
	arg_11_0.invalidCnt = arg_11_0.configData.red_nail_count
	arg_11_0.normalScore = arg_11_0.configData.nail_score
	arg_11_0.invalidScore = arg_11_0.configData.red_nail_score
	arg_11_0.slotList = {}

	for iter_11_0 = 1, var_0_6 do
		table.insert(arg_11_0.slotList, iter_11_0)
	end

	arg_11_0:LoadCharSD()
	arg_11_0:BlurPanel(arg_11_0._tf, {
		groupDelta = 3
	})

	return
end

function var_0_0.LoadCharSD(arg_12_0)
	PoolMgr.GetInstance():GetSpineChar(getProxy(NewEducateProxy):GetCurChar():getConfig("spine_char").minigame_face, true, function(arg_13_0)
		arg_12_0.charName = var_0
		arg_12_0.charModel = arg_13_0
		tf(arg_13_0).localScale = Vector3(1, 1, 1)

		arg_13_0:GetComponent("SpineAnimUI"):SetAction("normal", 0)
		setParent(arg_13_0, arg_12_0.charSDTF)

		return
	end)

	return
end

function var_0_0.ResetGame(arg_14_0)
	arg_14_0.isKnocking = false
	arg_14_0.score = 0

	arg_14_0:UpdateScore()

	arg_14_0.remainCnt = arg_14_0.totalCnt

	arg_14_0:UpdateRemainCnt()
	setActive(arg_14_0.meunUI, false)
	setActive(arg_14_0.countUI, false)
	setActive(arg_14_0.resultUI, false)
	setActive(arg_14_0.gameUI, true)
	setActive(arg_14_0.resultEffectTF, false)
	arg_14_0:ResetHammer()

	return
end

function var_0_0.StartCountDown(arg_15_0)
	setActive(arg_15_0.meunUI, false)
	setActive(arg_15_0.countUI, true)
	quickPlayAnimator(arg_15_0.countUI:Find("count"), "countdown")

	return
end

function var_0_0.StartGame(arg_16_0)
	arg_16_0:ResetGame()
	arg_16_0:RandomNails()
	arg_16_0:MoveHammer()

	return
end

function var_0_0.RandomNails(arg_17_0)
	removeAllChildren(arg_17_0.nailContainer)

	arg_17_0.nails = {}

	shuffle(arg_17_0.slotList)

	for iter_17_0 = 1, arg_17_0.normalCnt + arg_17_0.invalidCnt do
		if iter_17_0 <= arg_17_0.normalCnt then
			local var_17_0 = var_0_10.NORMAL or var_0_10.INVALID

			if var_17_0 == var_0_10.NORMAL then
				local var_17_1 = arg_17_0.noramlNailTpl or arg_17_0.invalidNailTpl
				local var_17_2 = cloneTplTo(var_17_1, arg_17_0.nailContainer)
				local var_17_3 = {
					y = 0,
					x = (arg_17_0.slotList[iter_17_0] - 1) * var_0_7 + var_0_5[1] + math.random(0, var_0_8)
				}

				setLocalPosition(var_17_2, var_17_3)

				arg_17_0.nails[var_17_2] = {
					type = var_17_0,
					pos = var_17_3,
					state = var_0_11.NORMAL
				}
			end
		end
	end

	return
end

function var_0_0.ResetHammer(arg_18_0)
	setLocalPosition(arg_18_0.hammerTF, {
		x = var_0_5[1],
		y = var_0_1
	})

	return
end

function var_0_0.MoveHammer(arg_19_0)
	arg_19_0.swayTweenId = LeanTween.moveX(arg_19_0.hammerTF, var_0_5[2], (var_0_5[2] - var_0_5[1]) / arg_19_0.speed):setLoopPingPong(0).uniqueId

	return
end

function var_0_0.PauseSway(arg_20_0)
	if LeanTween.isTweening(arg_20_0.swayTweenId) then
		LeanTween.pause(arg_20_0.swayTweenId)
	end

	return
end

function var_0_0.ResumeSway(arg_21_0)
	if LeanTween.isTweening(arg_21_0.swayTweenId) then
		LeanTween.resume(arg_21_0.swayTweenId)
	end

	return
end

function var_0_0.Knock(arg_22_0)
	if arg_22_0.isKnocking then
		return
	end

	arg_22_0.isKnocking = true

	arg_22_0:PauseSway()

	arg_22_0.remainCnt = arg_22_0.remainCnt - 1

	arg_22_0:UpdateRemainCnt()

	local var_22_0 = arg_22_0.nails[arg_22_0:GetHitNailTF()]
	local var_22_1 = var_22_0 and var_22_0.state == var_0_11.NORMAL

	seriesAsync({
		function(arg_23_0)
			arg_22_0:DownHammer(var_22_1, arg_23_0)

			return
		end,
		function(arg_24_0)
			arg_22_0:CheckHit(var_0, arg_24_0)

			return
		end,
		function(arg_25_0)
			arg_22_0:UpHammer(arg_25_0)

			return
		end
	}, function()
		arg_22_0:CheckGameOver()

		arg_22_0.isKnocking = false

		return
	end)

	return
end

function var_0_0.GetHitNailTF(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(arg_27_0.nails) do
		if arg_27_0.hammerTF.localPosition.x >= iter_27_0.localPosition.x - var_0_9 and arg_27_0.hammerTF.localPosition.x <= iter_27_0.localPosition.x + var_0_9 then
			return iter_27_0
		end
	end

	return nil
end

function var_0_0.DownHammer(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_1 then
		local var_28_0 = var_0_2 or var_0_3
		local var_28_1 = LeanTween.moveY(arg_28_0.hammerTF, var_28_0, (var_28_0 - var_0_1) / var_0_4)

		arg_28_0.downTweenId = var_28_1:setOnComplete(System.Action(arg_28_2)).uniqueId

		arg_28_0.hammerAnimUI:GetAnimationState():SetAnimation(0, "normal", false)

		return
	end
end

function var_0_0.CheckHit(arg_29_0, arg_29_1, arg_29_2)
	if not (arg_29_0.nails[arg_29_1] and arg_29_0.nails[arg_29_1].state == var_0_11.NORMAL) then
		-- block empty
	else
		if arg_29_0.nails[arg_29_1].type == var_0_10.NORMAL then
			arg_29_0.nails[arg_29_1].state = var_0_11.INSERTION
			arg_29_0.score = arg_29_0.score + arg_29_0.normalScore

			setActive(arg_29_1:Find("insertion"), true)
			setActive(arg_29_1:Find("normal"), false)
		else
			arg_29_0.score = math.max(arg_29_0.score + arg_29_0.invalidScore, 0)
		end

		arg_29_0:UpdateScore()
	end

	arg_29_2()

	return
end

function var_0_0.UpHammer(arg_30_0, arg_30_1)
	arg_30_0.upTweenId = LeanTween.moveY(arg_30_0.hammerTF, var_0_1, (var_0_1 - arg_30_0.hammerTF.localPosition.y) / var_0_4):setOnComplete(System.Action(arg_30_1)).uniqueId

	return
end

function var_0_0.CheckGameOver(arg_31_0)
	if arg_31_0.remainCnt == 0 then
		arg_31_0:EndGame()
	else
		arg_31_0:ResumeSway()
	end

	return
end

function var_0_0.UpdateScore(arg_32_0)
	arg_32_0.resultScoreTextCom.text = i18n("child2_nailing_game_result") .. arg_32_0.score
	arg_32_0.scoreTextCom.text = arg_32_0.score

	return
end

function var_0_0.UpdateRemainCnt(arg_33_0)
	arg_33_0.countTextCom.text = arg_33_0.remainCnt

	return
end

function var_0_0.EndGame(arg_34_0)
	setActive(arg_34_0.gameUI, false)
	setActive(arg_34_0.resultUI, true)
	setActive(arg_34_0.resultEffectTF, true)

	return
end

function var_0_0._Hide(arg_35_0)
	var_0_0.super.Hide(arg_35_0)
	arg_35_0:UnOverlayPanel(arg_35_0._tf)
	existCall(arg_35_0.onHide(arg_35_0.score))

	arg_35_0.onHide = nil

	if LeanTween.isTweening(arg_35_0.swayTweenId) then
		LeanTween.cancel(arg_35_0.swayTweenId)
	end

	arg_35_0.swayTweenId = nil

	if LeanTween.isTweening(arg_35_0.upTweenId) then
		LeanTween.cancel(arg_35_0.upTweenId)
	end

	arg_35_0.upTweenId = nil

	if LeanTween.isTweening(arg_35_0.downTweenId) then
		LeanTween.cancel(arg_35_0.downTweenId)
	end

	arg_35_0.downTweenId = nil

	if arg_35_0.charName and arg_35_0.charModel then
		PoolMgr.GetInstance():ReturnSpineChar(arg_35_0.charName, arg_35_0.charModel)

		arg_35_0.charName = nil
		arg_35_0.charModel = nil
	end

	return
end

function var_0_0.Hide(arg_36_0)
	quickPlayAnimation(arg_36_0._tf, "anim_NewEducateNailingGame_out")

	return
end

function var_0_0.OnDestroy(arg_37_0)
	arg_37_0.animDft:SetEndEvent(nil)
	arg_37_0.countdownDft:SetEndEvent(nil)
	arg_37_0.hammerAnimUI:SetActionCallBack(nil)

	return
end

return var_0_0
