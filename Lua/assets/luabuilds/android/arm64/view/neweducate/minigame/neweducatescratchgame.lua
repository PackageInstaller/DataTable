local var_0_0 = class("NewEducateScratchGame", import("view.base.BaseSubView"))

var_0_0.HAND_MOVE_TIME = 1

function var_0_0.getUIName(arg_1_0)
	return "NewEducateScratchGame"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.scratchCom = arg_2_0._tf:Find("panel/card/rawImage"):GetComponent(typeof(UIScratch))
	arg_2_0.resultTF = arg_2_0._tf:Find("panel/card/result")
	arg_2_0.handTF = arg_2_0._tf:Find("panel/hand")
	arg_2_0.sureBtn = arg_2_0._tf:Find("panel/sure")
	arg_2_0.resultEffectTF = arg_2_0._tf:Find("bg/VX_get")

	setActive(arg_2_0.resultEffectTF, false)

	arg_2_0.animDft = arg_2_0._tf:GetComponent(typeof(DftAniEvent))

	arg_2_0.animDft:SetEndEvent(function(arg_3_0)
		arg_2_0:_Hide()

		return
	end)

	return
end

function var_0_0.OnInit(arg_4_0)
	onButton(arg_4_0, arg_4_0._tf:Find("back"), function()
		arg_4_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.sureBtn, function()
		arg_4_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0._tf:Find("help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.child2_scratch_minigame_help.tip
		})

		return
	end, SFX_PANEL)

	function arg_4_0.scratchCom.onUpdateErase(arg_8_0)
		arg_4_0.progress = tonumber(string.format("%.2f", arg_8_0))

		arg_4_0:UpdateProgress()

		if isActive(arg_4_0.handTF) then
			arg_4_0:ResetHand()
		end

		return
	end

	function arg_4_0.scratchCom.onFinishErase()
		arg_4_0:EndGame()

		return
	end

	return
end

function var_0_0.Show(arg_10_0, arg_10_1, arg_10_2)
	var_0_0.super.Show(arg_10_0)

	arg_10_0.id = arg_10_1
	arg_10_0.configData = pg.child2_minigame[arg_10_0.id].config_data
	arg_10_0.finishScore = arg_10_0.configData.finish_score
	arg_10_0.onHide = arg_10_2

	arg_10_0:StartGame()
	arg_10_0:BlurPanel(arg_10_0._tf, {
		groupDelta = 3
	})

	return
end

function var_0_0.ResetGame(arg_11_0)
	arg_11_0.score = 0
	arg_11_0.progress = 0

	arg_11_0:UpdateProgress()
	arg_11_0.scratchCom:ResetErase()

	local var_11_0 = math.random(3)

	eachChild(arg_11_0.resultTF, function(arg_12_0)
		setActive(arg_12_0, tonumber(arg_12_0.name) == var_11_0)

		return
	end)
	setActive(arg_11_0.sureBtn, false)
	setActive(arg_11_0.resultEffectTF, false)
	arg_11_0:ResetHand()

	return
end

function var_0_0.ResetHand(arg_13_0)
	arg_13_0:cleanManagedTween()
	setLocalPosition(arg_13_0.handTF, {
		x = 318
	})
	setActive(arg_13_0.handTF, false)

	return
end

function var_0_0.StartGame(arg_14_0)
	arg_14_0:ResetGame()
	setActive(arg_14_0.handTF, true)
	arg_14_0:managedTween(LeanTween.moveX, nil, arg_14_0.handTF, -220, var_0_0.HAND_MOVE_TIME):setLoopPingPong()

	return
end

function var_0_0.UpdateProgress(arg_15_0)
	return
end

function var_0_0.EndGame(arg_16_0)
	if arg_16_0.progress >= arg_16_0.scratchCom.finishPercent then
		arg_16_0.score = arg_16_0.finishScore or 0
		arg_16_0.progress = 1

		arg_16_0:UpdateProgress()
		setActive(arg_16_0.sureBtn, true)
		setActive(arg_16_0.resultEffectTF, true)

		return
	end
end

function var_0_0._Hide(arg_17_0)
	var_0_0.super.Hide(arg_17_0)
	arg_17_0:UnOverlayPanel(arg_17_0._tf)
	existCall(arg_17_0.onHide(arg_17_0.score))

	arg_17_0.onHide = nil

	return
end

function var_0_0.Hide(arg_18_0)
	quickPlayAnimation(arg_18_0._tf, "anim_NewEducateScratchGame_out")

	return
end

function var_0_0.OnDestroy(arg_19_0)
	arg_19_0.animDft:SetEndEvent(nil)

	return
end

return var_0_0
