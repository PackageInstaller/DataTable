local var_0_0 = class("ChessBoardHomeTips", ReduxView)
local var_0_1 = {
	diceState = {
		name = "dice",
		OneDice = "OneDice",
		TwoDice = "TwoDice"
	},
	numState = {
		bad = "bad",
		name = "numState",
		good = "good"
	}
}
local var_0_2 = {
	[ChessBoardConst.TIPS_TYPE.DUCK_CREATE_TIPS] = {
		obj = "duckObj_",
		times = 2.2
	},
	[ChessBoardConst.TIPS_TYPE.NEW_ROUND_OPEN_TIPS] = {
		obj = "newRoundObj_",
		times = 2
	},
	[ChessBoardConst.TIPS_TYPE.ENEMY_TURN_TIPS] = {
		obj = "enemyObj_",
		times = 2
	},
	[ChessBoardConst.TIPS_TYPE.MY_TURN_TIPS] = {
		obj = "myTurnObj_",
		times = 2
	},
	[ChessBoardConst.TIPS_TYPE.MY_BANNER] = {
		obj = "myBannerGo_",
		times = 1.2
	},
	[ChessBoardConst.TIPS_TYPE.NPC_BANNER] = {
		obj = "npcBannerGo_",
		times = 1.2
	},
	[ChessBoardConst.TIPS_TYPE.EVENT_TIPS] = {
		obj = "gridtipsGo_",
		times = 1.5
	},
	[ChessBoardConst.TIPS_TYPE.BUBBLE] = {
		noBlocker = true,
		obj = "bubbleGo_",
		times = 2
	},
	[ChessBoardConst.TIPS_TYPE.GRID_BUBBLE] = {
		noBlocker = true,
		obj = "gridbubbleGo_",
		times = 2
	}
}

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.diceController_ = arg_3_0.controllerexcollection_:GetController(var_0_1.diceState.name)
	arg_3_0.NPCDiceController_ = arg_3_0.controllerexcollection_:GetController("NPCDice")
	arg_3_0.eventTipsController_ = arg_3_0.eventTipsCollection_:GetController("eventTips")
	arg_3_0.numTips = ChessBoardNumTips.New(arg_3_0.numtipscontentGo_)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:UpdateTurnShow()
end

function var_0_0.UpdateTurnShow(arg_5_0)
	local var_5_0 = manager.ChessBoardManager:GetCurMapTurnCount()

	arg_5_0.roundNumText_.text = var_5_0
	arg_5_0.turnText_.text = string.format(GetTips("CHESSBOARD_TURN"), var_5_0)
end

function var_0_0.UpdateTipsShow(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:AddShowTimer(arg_6_1, arg_6_2)

	if arg_6_1 == ChessBoardConst.TIPS_TYPE.GET_PROP then
		arg_6_0:ShowPropTips(arg_6_2, arg_6_1)
	elseif arg_6_1 == ChessBoardConst.TIPS_TYPE.NUM_TIPS then
		arg_6_0.numTips:ShowTips(arg_6_2.num)
	elseif arg_6_1 == ChessBoardConst.TIPS_TYPE.NEW_ROUND_OPEN_TIPS then
		arg_6_0:UpdateTurnShow()
	elseif arg_6_1 == ChessBoardConst.TIPS_TYPE.BUFF_TIPS then
		arg_6_0:ShowBuffTips(arg_6_2, arg_6_1)
	elseif arg_6_1 == ChessBoardConst.TIPS_TYPE.EVENT_TIPS then
		arg_6_0:ShowEventTips(arg_6_2, arg_6_1)
	elseif arg_6_1 == ChessBoardConst.TIPS_TYPE.BUBBLE then
		arg_6_0:ShowBubbleTips(arg_6_2, arg_6_1)
	elseif arg_6_1 == ChessBoardConst.TIPS_TYPE.GRID_BUBBLE then
		arg_6_0:ShowGridBubbleTips(arg_6_2, arg_6_1)
	end
end

function var_0_0.AddShowTimer(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = var_0_2[arg_7_1]

	if var_7_0 then
		if not var_7_0.noBlocker then
			manager.ChessBoardManager.blockerManager_:ShowBlocker()
		end

		local var_7_1 = var_7_0.times
		local var_7_2 = var_7_0.obj

		SetActive(arg_7_0[var_7_2], true)
		arg_7_0:AddDeleteTimer(var_7_1, arg_7_1, function()
			SetActive(arg_7_0[var_7_2], false)

			if not var_7_0.noBlocker then
				manager.ChessBoardManager.blockerManager_:HideBlocker()
			end

			if arg_7_2 and arg_7_2.callback then
				arg_7_2.callback()
			end
		end)
	end
end

function var_0_0.ShowPropTips(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = ChessBoardPropCfg[arg_9_1.propID]
	local var_9_1

	if arg_9_1.isGet == false then
		var_9_1 = arg_9_0.badObj_
		arg_9_0.badText_.text = string.format(GetTips("CHESSBOARD_LOSE_PROP"), GetI18NText(var_9_0.name))
		arg_9_0.badImg_.sprite = ChessBoardTools.GetPropImage(var_9_0.icon)
	else
		var_9_1 = arg_9_0.goodObj_
		arg_9_0.goodText_.text = string.format(GetTips("CHESSBOARD_GET_PROP"), GetI18NText(var_9_0.name))
		arg_9_0.goodImg_.sprite = ChessBoardTools.GetPropImage(var_9_0.icon)
	end

	manager.ChessBoardManager.blockerManager_:ShowBlocker()
	SetActive(var_9_1, true)
	arg_9_0:AddDeleteTimer(2, arg_9_2, function()
		SetActive(var_9_1, false)
		manager.ChessBoardManager.blockerManager_:HideBlocker()

		if arg_9_1.callback then
			arg_9_1.callback()
		end
	end)
end

function var_0_0.ShowBuffTips(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1.buffID
	local var_11_1 = ChessBoardBuffPoolCfg[var_11_0]

	if var_11_1 then
		local var_11_2

		if var_11_1.buff_type == 1 then
			var_11_2 = arg_11_0.goodObj_

			if arg_11_1.playerEntity == 0 then
				arg_11_0.goodText_.text = string.format(GetTips("CHESSBOARD_GET_BUFF"), GetI18NText(var_11_1.name))
			else
				arg_11_0.goodText_.text = string.format(GetTips("CHESSBOARD_DUCK_GET_BUFF"), GetI18NText(var_11_1.name))
			end

			arg_11_0.goodImg_.sprite = ChessBoardTools.GetBuffImage(var_11_0)
		elseif var_11_1.buff_type == 2 then
			var_11_2 = arg_11_0.badObj_

			if arg_11_1.playerEntity == 0 then
				arg_11_0.badText_.text = string.format(GetTips("CHESSBOARD_GET_BUFF"), GetI18NText(var_11_1.name))
			else
				arg_11_0.badText_.text = string.format(GetTips("CHESSBOARD_DUCK_GET_BUFF"), GetI18NText(var_11_1.name))
			end

			arg_11_0.badImg_.sprite = ChessBoardTools.GetBuffImage(var_11_0)
		end

		manager.ChessBoardManager.blockerManager_:ShowBlocker()
		SetActive(var_11_2, true)
		arg_11_0:AddDeleteTimer(2, arg_11_2, function()
			SetActive(var_11_2, false)
			manager.ChessBoardManager.blockerManager_:HideBlocker()

			if arg_11_1.callback then
				arg_11_1.callback()
			end
		end)
	end
end

function var_0_0.ShowEventTips(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1.eventType
	local var_13_1

	if var_13_0 == ChessBoardConst.EVENT_TIPS_TYPE.RANDOM then
		var_13_1 = "random"

		manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.DOUBT)
	elseif var_13_0 == ChessBoardConst.EVENT_TIPS_TYPE.PROP then
		var_13_1 = "gift"

		manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.HAPPY_BIG)
	elseif var_13_0 == ChessBoardConst.EVENT_TIPS_TYPE.GAMEPLAY then
		var_13_1 = "mechanism"

		manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.SHOCK)
	end

	arg_13_0.eventTipsController_:SetSelectedState(var_13_1)
end

function var_0_0.ClearBubbleTips(arg_14_0)
	SetActive(arg_14_0.bubbleGo_, false)
	SetActive(arg_14_0.gridbubbleGo_, false)
end

local var_0_3 = Vector3(0.5, 1.1, 0)

function var_0_0.ShowBubbleTips(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1.actionType
	local var_15_1

	if var_15_0 == ChessBoardConst.ACTIONTYPE.SAD_BIG then
		var_15_1 = GetTips("CHESSBOARD_SAD_BUBBLE_SAD")
	elseif var_15_0 == ChessBoardConst.ACTIONTYPE.NERVOUS then
		var_15_1 = GetTips("CHESSBOARD_SAD_BUBBLE_NERVOUS")
	elseif var_15_0 == ChessBoardConst.ACTIONTYPE.IDLE then
		local var_15_2 = math.random(1, 3)

		var_15_1 = GetTips(string.format("CHESSBOARD_SAD_BUBBLE_IDLE%s", var_15_2))
	end

	local var_15_3 = ChessBoardLuaBridge.GetHeroTransPos() + var_0_3

	arg_15_0.bubbleTrs_.anchoredPosition = arg_15_0:GetBubblePos(var_15_3)
	arg_15_0.bubbleText_.text = var_15_1

	local var_15_4 = arg_15_0.bubbleText_.preferredWidth + 27
	local var_15_5 = math.min(var_15_4, 271)

	arg_15_0.bubbleImageTrs_.sizeDelta = Vector2(var_15_5, arg_15_0.bubbleImageTrs_.sizeDelta.y)
end

local var_0_4 = Vector3(0.7, 0.4, 0)

function var_0_0.ShowGridBubbleTips(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1.thingTypeID
	local var_16_1 = arg_16_1.modelPos
	local var_16_2 = ChessBoardHexCfg[var_16_0]
	local var_16_3 = var_16_1 + var_0_4

	arg_16_0.gridBubblePos = var_16_3
	arg_16_0.gridbubbleTrs_.anchoredPosition = arg_16_0:GetBubblePos(var_16_3)
	arg_16_0.gridbubbleText_.text = var_16_2.dec

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_0.gridbubbleText_.transform.parent)

	local var_16_4 = arg_16_0.gridbubbleText_.preferredWidth + 27
	local var_16_5 = math.min(var_16_4, 271)

	arg_16_0.gridbubbleImageTrs_.sizeDelta = Vector2(var_16_5, arg_16_0.gridbubbleImageTrs_.sizeDelta.y)
end

function var_0_0.GetBubblePos(arg_17_0, arg_17_1)
	local var_17_0 = UnityEngine.Camera.main:WorldToScreenPoint(arg_17_1)
	local var_17_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_17_2 = var_17_0.x / Screen.width * manager.ui.canvasSize_.x
	local var_17_3 = var_17_0.y / Screen.height * manager.ui.canvasSize_.y

	return Vector2(var_17_2, var_17_3)
end

function var_0_0.GetTimerName(arg_18_0, arg_18_1)
	return string.format("timer%s", arg_18_1)
end

function var_0_0.AddDeleteTimer(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if ChessBoardData:GetIsFastModule() then
		arg_19_1 = arg_19_1 / 2
	end

	local var_19_0 = arg_19_0:GetTimerName(arg_19_2)

	arg_19_0:DeleteTimer(var_19_0)

	arg_19_0[var_19_0] = Timer.New(function()
		arg_19_3()
	end, arg_19_1)

	arg_19_0[var_19_0]:Start()
end

function var_0_0.DeleteTimer(arg_21_0, arg_21_1)
	if arg_21_0[arg_21_1] then
		arg_21_0[arg_21_1]:Stop()

		arg_21_0[arg_21_1] = nil
	end
end

function var_0_0.SetDiceController(arg_22_0, arg_22_1)
	arg_22_0.diceController_:SetSelectedState(arg_22_1)
end

function var_0_0.PlayTwoDiceAni(arg_23_0, arg_23_1)
	arg_23_0.twoDiceAni_:Play("merge")

	arg_23_0.diceOneText_.text = arg_23_1[1]
	arg_23_0.diceTwoText_.text = arg_23_1[2]
end

function var_0_0.PlayOneDiceAni(arg_24_0, arg_24_1)
	arg_24_0.oneDiceAni_:Play("show")

	arg_24_0.moveStepNum_.text = arg_24_1
end

function var_0_0.SetMoveStepNum(arg_25_0, arg_25_1)
	arg_25_0.moveStepNum_.text = arg_25_1
end

function var_0_0.SetDiceUIShow(arg_26_0, arg_26_1)
	SetActive(arg_26_0.diceUIGo_, arg_26_1)
end

function var_0_0.OnChessBoardFastModuleUpdate(arg_27_0, arg_27_1)
	if arg_27_1 then
		arg_27_0.twoDiceAni_.speed = 2
		arg_27_0.oneDiceAni_.speed = 2
		arg_27_0.NPCTwoDiceAni_.speed = 2
		arg_27_0.NPCOneDiceAni_.speed = 2
		arg_27_0.buffAni_.speed = 2
		arg_27_0.debuffAni_.speed = 2
		arg_27_0.duckTipsAni_.speed = 2
		arg_27_0.newRoundAni_.speed = 2
		arg_27_0.enemyTurnAni_.speed = 2
		arg_27_0.myTurnAni_.speed = 2
		arg_27_0.giftAni_.speed = 2
		arg_27_0.randomAni_.speed = 2
		arg_27_0.mechanismAni_.speed = 2
		arg_27_0.myBannerAni_.speed = 2
		arg_27_0.enemyBannerAni_.speed = 2
	else
		arg_27_0.twoDiceAni_.speed = 1
		arg_27_0.oneDiceAni_.speed = 1
		arg_27_0.NPCTwoDiceAni_.speed = 1
		arg_27_0.NPCOneDiceAni_.speed = 1
		arg_27_0.buffAni_.speed = 1
		arg_27_0.debuffAni_.speed = 1
		arg_27_0.duckTipsAni_.speed = 1
		arg_27_0.newRoundAni_.speed = 1
		arg_27_0.enemyTurnAni_.speed = 1
		arg_27_0.myTurnAni_.speed = 1
		arg_27_0.giftAni_.speed = 1
		arg_27_0.randomAni_.speed = 1
		arg_27_0.mechanismAni_.speed = 1
		arg_27_0.myBannerAni_.speed = 1
		arg_27_0.enemyBannerAni_.speed = 1
	end
end

function var_0_0.SetNPCDiceController(arg_28_0, arg_28_1)
	arg_28_0.NPCDiceController_:SetSelectedState(arg_28_1)
end

function var_0_0.PlayNPCTwoDiceAni(arg_29_0, arg_29_1)
	arg_29_0.NPCTwoDiceAni_:Play("merge")

	arg_29_0.NPCDiceOneText_.text = arg_29_1[1]
	arg_29_0.NPCDiceTwoText_.text = arg_29_1[2]
end

function var_0_0.SetNPCDiceUIShow(arg_30_0, arg_30_1)
	SetActive(arg_30_0.NPCDiceUIGo_, arg_30_1)
end

function var_0_0.PlayNPCOneDiceAni(arg_31_0, arg_31_1)
	arg_31_0.NPCOneDiceAni_:Play("show")

	arg_31_0.NPCMoveStepNum_.text = arg_31_1
end

function var_0_0.SetNPCMoveStepNum(arg_32_0, arg_32_1)
	arg_32_0.NPCMoveStepNum_.text = arg_32_1
end

function var_0_0.UpdateCameraMove(arg_33_0)
	if arg_33_0.bubbleGo_.activeSelf == true then
		local var_33_0 = ChessBoardLuaBridge.GetHeroTransPos() + var_0_3

		arg_33_0.bubbleTrs_.anchoredPosition = arg_33_0:GetBubblePos(var_33_0)
	end

	if arg_33_0.gridbubbleGo_.activeSelf == true then
		arg_33_0.gridbubbleTrs_.anchoredPosition = arg_33_0:GetBubblePos(arg_33_0.gridBubblePos)
	end
end

function var_0_0.Dispose(arg_34_0)
	for iter_34_0, iter_34_1 in pairs(ChessBoardConst.TIPS_TYPE) do
		arg_34_0:DeleteTimer(arg_34_0:GetTimerName(iter_34_1))
	end

	arg_34_0.numTips:Dispose()
	arg_34_0.super.Dispose(arg_34_0)
end

return var_0_0
