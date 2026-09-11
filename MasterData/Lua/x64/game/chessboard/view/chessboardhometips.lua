local ChessBoardHomeTips = class("ChessBoardHomeTips", ReduxView)
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

function ChessBoardHomeTips:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ChessBoardHomeTips:Init()
	self:InitUI()
end

function ChessBoardHomeTips:InitUI()
	self:BindCfgUI()

	self.diceController_ = self.controllerexcollection_:GetController(var_0_1.diceState.name)
	self.NPCDiceController_ = self.controllerexcollection_:GetController("NPCDice")
	self.eventTipsController_ = self.eventTipsCollection_:GetController("eventTips")
	self.numTips = ChessBoardNumTips.New(self.numtipscontentGo_)
end

function ChessBoardHomeTips:OnEnter()
	self:UpdateTurnShow()
end

function ChessBoardHomeTips:UpdateTurnShow()
	local var_5_0 = manager.ChessBoardManager:GetCurMapTurnCount()

	self.roundNumText_.text = var_5_0
	self.turnText_.text = string.format(GetTips("CHESSBOARD_TURN"), var_5_0)
end

function ChessBoardHomeTips:UpdateTipsShow(arg_6_1, arg_6_2)
	self:AddShowTimer(arg_6_1, arg_6_2)

	if arg_6_1 == ChessBoardConst.TIPS_TYPE.GET_PROP then
		self:ShowPropTips(arg_6_2, arg_6_1)
	elseif arg_6_1 == ChessBoardConst.TIPS_TYPE.NUM_TIPS then
		self.numTips:ShowTips(arg_6_2.num)
	elseif arg_6_1 == ChessBoardConst.TIPS_TYPE.NEW_ROUND_OPEN_TIPS then
		self:UpdateTurnShow()
	elseif arg_6_1 == ChessBoardConst.TIPS_TYPE.BUFF_TIPS then
		self:ShowBuffTips(arg_6_2, arg_6_1)
	elseif arg_6_1 == ChessBoardConst.TIPS_TYPE.EVENT_TIPS then
		self:ShowEventTips(arg_6_2, arg_6_1)
	elseif arg_6_1 == ChessBoardConst.TIPS_TYPE.BUBBLE then
		self:ShowBubbleTips(arg_6_2, arg_6_1)
	elseif arg_6_1 == ChessBoardConst.TIPS_TYPE.GRID_BUBBLE then
		self:ShowGridBubbleTips(arg_6_2, arg_6_1)
	end
end

function ChessBoardHomeTips:AddShowTimer(arg_7_1, arg_7_2)
	local var_7_0 = var_0_2[arg_7_1]

	if var_0_2[arg_7_1] then
		if not var_0_2[arg_7_1].noBlocker then
			manager.ChessBoardManager.blockerManager_:ShowBlocker()
		end

		local var_7_1 = var_0_2[arg_7_1].times
		local var_7_2 = var_0_2[arg_7_1].obj

		SetActive(self[var_0_2[arg_7_1].obj], true)
		self:AddDeleteTimer(var_7_1, arg_7_1, function()
			SetActive(self[var_7_2], false)

			if not var_7_0.noBlocker then
				manager.ChessBoardManager.blockerManager_:HideBlocker()
			end

			if arg_7_2 and arg_7_2.callback then
				arg_7_2.callback()
			end
		end)
	end
end

function ChessBoardHomeTips:ShowPropTips(arg_9_1, arg_9_2)
	local var_9_0

	if arg_9_1.isGet == false then
		var_9_0 = self.badObj_
		self.badText_.text = string.format(GetTips("CHESSBOARD_LOSE_PROP"), GetI18NText(ChessBoardPropCfg[arg_9_1.propID].name))
		self.badImg_.sprite = ChessBoardTools.GetPropImage(ChessBoardPropCfg[arg_9_1.propID].icon)
	else
		var_9_0 = self.goodObj_
		self.goodText_.text = string.format(GetTips("CHESSBOARD_GET_PROP"), GetI18NText(ChessBoardPropCfg[arg_9_1.propID].name))
		self.goodImg_.sprite = ChessBoardTools.GetPropImage(ChessBoardPropCfg[arg_9_1.propID].icon)
	end

	manager.ChessBoardManager.blockerManager_:ShowBlocker()
	SetActive(var_9_0, true)
	self:AddDeleteTimer(2, arg_9_2, function()
		SetActive(var_9_0, false)
		manager.ChessBoardManager.blockerManager_:HideBlocker()

		if arg_9_1.callback then
			arg_9_1.callback()
		end
	end)
end

function ChessBoardHomeTips:ShowBuffTips(arg_11_1, arg_11_2)
	if ChessBoardBuffPoolCfg[arg_11_1.buffID] then
		local var_11_0

		if ChessBoardBuffPoolCfg[arg_11_1.buffID].buff_type == 1 then
			var_11_0 = self.goodObj_
			self.goodText_.text = arg_11_1.playerEntity == 0 and string.format(GetTips("CHESSBOARD_GET_BUFF"), GetI18NText(ChessBoardBuffPoolCfg[arg_11_1.buffID].name)) or string.format(GetTips("CHESSBOARD_DUCK_GET_BUFF"), GetI18NText(ChessBoardBuffPoolCfg[arg_11_1.buffID].name))
			self.goodImg_.sprite = ChessBoardTools.GetBuffImage(arg_11_1.buffID)
		elseif ChessBoardBuffPoolCfg[arg_11_1.buffID].buff_type == 2 then
			var_11_0 = self.badObj_
			self.badText_.text = arg_11_1.playerEntity == 0 and string.format(GetTips("CHESSBOARD_GET_BUFF"), GetI18NText(ChessBoardBuffPoolCfg[arg_11_1.buffID].name)) or string.format(GetTips("CHESSBOARD_DUCK_GET_BUFF"), GetI18NText(ChessBoardBuffPoolCfg[arg_11_1.buffID].name))
			self.badImg_.sprite = ChessBoardTools.GetBuffImage(arg_11_1.buffID)
		end

		manager.ChessBoardManager.blockerManager_:ShowBlocker()
		SetActive(var_11_0, true)
		self:AddDeleteTimer(2, arg_11_2, function()
			SetActive(var_11_0, false)
			manager.ChessBoardManager.blockerManager_:HideBlocker()

			if arg_11_1.callback then
				arg_11_1.callback()
			end
		end)
	end
end

function ChessBoardHomeTips:ShowEventTips(arg_13_1, arg_13_2)
	local var_13_0

	if arg_13_1.eventType == ChessBoardConst.EVENT_TIPS_TYPE.RANDOM then
		var_13_0 = "random"

		manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.DOUBT)
	elseif arg_13_1.eventType == ChessBoardConst.EVENT_TIPS_TYPE.PROP then
		var_13_0 = "gift"

		manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.HAPPY_BIG)
	elseif arg_13_1.eventType == ChessBoardConst.EVENT_TIPS_TYPE.GAMEPLAY then
		var_13_0 = "mechanism"

		manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.SHOCK)
	end

	self.eventTipsController_:SetSelectedState(var_13_0)
end

function ChessBoardHomeTips:ClearBubbleTips()
	SetActive(self.bubbleGo_, false)
	SetActive(self.gridbubbleGo_, false)
end

local var_0_3 = Vector3(0.5, 1.1, 0)

function ChessBoardHomeTips:ShowBubbleTips(arg_15_1, arg_15_2)
	local var_15_0

	if arg_15_1.actionType == ChessBoardConst.ACTIONTYPE.SAD_BIG then
		var_15_0 = GetTips("CHESSBOARD_SAD_BUBBLE_SAD")
	elseif arg_15_1.actionType == ChessBoardConst.ACTIONTYPE.NERVOUS then
		var_15_0 = GetTips("CHESSBOARD_SAD_BUBBLE_NERVOUS")
	elseif arg_15_1.actionType == ChessBoardConst.ACTIONTYPE.IDLE then
		var_15_0 = GetTips(string.format("CHESSBOARD_SAD_BUBBLE_IDLE%s", (math.random(1, 3))))
	end

	self.bubbleTrs_.anchoredPosition = self:GetBubblePos(ChessBoardLuaBridge.GetHeroTransPos() + var_0_3)
	self.bubbleText_.text = var_15_0
	self.bubbleImageTrs_.sizeDelta = Vector2(math.min(self.bubbleText_.preferredWidth + 27, 271), self.bubbleImageTrs_.sizeDelta.y)
end

local var_0_4 = Vector3(0.7, 0.4, 0)

function ChessBoardHomeTips:ShowGridBubbleTips(arg_16_1, arg_16_2)
	self.gridBubblePos = arg_16_1.modelPos + var_0_4
	self.gridbubbleTrs_.anchoredPosition = self:GetBubblePos(arg_16_1.modelPos + var_0_4)
	self.gridbubbleText_.text = ChessBoardHexCfg[arg_16_1.thingTypeID].dec

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.gridbubbleText_.transform.parent)

	self.gridbubbleImageTrs_.sizeDelta = Vector2(math.min(self.gridbubbleText_.preferredWidth + 27, 271), self.gridbubbleImageTrs_.sizeDelta.y)
end

function ChessBoardHomeTips:GetBubblePos(arg_17_1)
	local var_17_0 = UnityEngine.Camera.main:WorldToScreenPoint(arg_17_1)
	local var_17_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	return Vector2(var_17_0.x / Screen.width * manager.ui.canvasSize_.x, var_17_0.y / Screen.height * manager.ui.canvasSize_.y)
end

function ChessBoardHomeTips:GetTimerName(arg_18_1)
	return string.format("timer%s", arg_18_1)
end

function ChessBoardHomeTips:AddDeleteTimer(arg_19_1, arg_19_2, arg_19_3)
	if ChessBoardData:GetIsFastModule() then
		arg_19_1 = arg_19_1 / 2
	end

	local var_19_0 = self:GetTimerName(arg_19_2)

	self:DeleteTimer(var_19_0)

	self[var_19_0] = Timer.New(function()
		arg_19_3()
	end, arg_19_1)

	self[var_19_0]:Start()
end

function ChessBoardHomeTips:DeleteTimer(arg_21_1)
	if self[arg_21_1] then
		self[arg_21_1]:Stop()

		self[arg_21_1] = nil
	end
end

function ChessBoardHomeTips:SetDiceController(arg_22_1)
	self.diceController_:SetSelectedState(arg_22_1)
end

function ChessBoardHomeTips:PlayTwoDiceAni(arg_23_1)
	self.twoDiceAni_:Play("merge")

	self.diceOneText_.text = arg_23_1[1]
	self.diceTwoText_.text = arg_23_1[2]
end

function ChessBoardHomeTips:PlayOneDiceAni(arg_24_1)
	self.oneDiceAni_:Play("show")

	self.moveStepNum_.text = arg_24_1
end

function ChessBoardHomeTips:SetMoveStepNum(arg_25_1)
	self.moveStepNum_.text = arg_25_1
end

function ChessBoardHomeTips:SetDiceUIShow(arg_26_1)
	SetActive(self.diceUIGo_, arg_26_1)
end

function ChessBoardHomeTips:OnChessBoardFastModuleUpdate(arg_27_1)
	if arg_27_1 then
		self.twoDiceAni_.speed = 2
		self.oneDiceAni_.speed = 2
		self.NPCTwoDiceAni_.speed = 2
		self.NPCOneDiceAni_.speed = 2
		self.buffAni_.speed = 2
		self.debuffAni_.speed = 2
		self.duckTipsAni_.speed = 2
		self.newRoundAni_.speed = 2
		self.enemyTurnAni_.speed = 2
		self.myTurnAni_.speed = 2
		self.giftAni_.speed = 2
		self.randomAni_.speed = 2
		self.mechanismAni_.speed = 2
		self.myBannerAni_.speed = 2
		self.enemyBannerAni_.speed = 2
	else
		self.twoDiceAni_.speed = 1
		self.oneDiceAni_.speed = 1
		self.NPCTwoDiceAni_.speed = 1
		self.NPCOneDiceAni_.speed = 1
		self.buffAni_.speed = 1
		self.debuffAni_.speed = 1
		self.duckTipsAni_.speed = 1
		self.newRoundAni_.speed = 1
		self.enemyTurnAni_.speed = 1
		self.myTurnAni_.speed = 1
		self.giftAni_.speed = 1
		self.randomAni_.speed = 1
		self.mechanismAni_.speed = 1
		self.myBannerAni_.speed = 1
		self.enemyBannerAni_.speed = 1
	end
end

function ChessBoardHomeTips:SetNPCDiceController(arg_28_1)
	self.NPCDiceController_:SetSelectedState(arg_28_1)
end

function ChessBoardHomeTips:PlayNPCTwoDiceAni(arg_29_1)
	self.NPCTwoDiceAni_:Play("merge")

	self.NPCDiceOneText_.text = arg_29_1[1]
	self.NPCDiceTwoText_.text = arg_29_1[2]
end

function ChessBoardHomeTips:SetNPCDiceUIShow(arg_30_1)
	SetActive(self.NPCDiceUIGo_, arg_30_1)
end

function ChessBoardHomeTips:PlayNPCOneDiceAni(arg_31_1)
	self.NPCOneDiceAni_:Play("show")

	self.NPCMoveStepNum_.text = arg_31_1
end

function ChessBoardHomeTips:SetNPCMoveStepNum(arg_32_1)
	self.NPCMoveStepNum_.text = arg_32_1
end

function ChessBoardHomeTips:UpdateCameraMove()
	if self.bubbleGo_.activeSelf == true then
		self.bubbleTrs_.anchoredPosition = self:GetBubblePos(ChessBoardLuaBridge.GetHeroTransPos() + var_0_3)
	end

	if self.gridbubbleGo_.activeSelf == true then
		self.gridbubbleTrs_.anchoredPosition = self:GetBubblePos(self.gridBubblePos)
	end
end

function ChessBoardHomeTips:Dispose()
	for iter_34_0, iter_34_1 in pairs(ChessBoardConst.TIPS_TYPE) do
		self:DeleteTimer(self:GetTimerName(iter_34_1))
	end

	self.numTips:Dispose()
	self.super.Dispose(self)
end

return ChessBoardHomeTips
