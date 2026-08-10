local var_0_0 = class("AutoChessBattleView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_AutoChess/Activity_OsirisHorus_BattleUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListener()
	arg_4_0:InitController()
	arg_4_0:InitCallback()
	arg_4_0:InitSubView()
	arg_4_0:InitChessFormation()
	arg_4_0:InitFightTimeline()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.playBtn_, nil, handler(arg_5_0, arg_5_0.OnClickPlayBtn))
	arg_5_0:AddBtnListener(arg_5_0.skipBtn_, nil, handler(arg_5_0, arg_5_0.OnClickSkipBtn))
	arg_5_0:AddBtnListener(arg_5_0.doubleSpeedBtn_, nil, handler(arg_5_0, arg_5_0.OnClickDoubleSpeedBtn))
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		SetActive(arg_5_0.maskBtn_.gameObject, false)
		arg_5_0.tipsPanelView_:SetActive(false)
		arg_5_0:OnClickCloseTips()
	end)
end

function var_0_0.InitController(arg_7_0)
	arg_7_0.bottomController_ = arg_7_0.controllerEx_:GetController("bottom")
	arg_7_0.typeController_ = arg_7_0.controllerEx_:GetController("type")
	arg_7_0.playBtnController_ = arg_7_0.playBtnControllerEx_:GetController("status")
	arg_7_0.doubleSpeedBtnController_ = arg_7_0.speedBtnControllerEx_:GetController("speed")
end

function var_0_0.InitCallback(arg_8_0)
	arg_8_0.clickChessHandler_ = handler(arg_8_0, arg_8_0.OnPointerClick)
end

function var_0_0.InitSubView(arg_9_0)
	arg_9_0.chessContainPosX_ = -645
	arg_9_0.playerSelfInfoView_ = AutoChessPlayerInfoView.New(arg_9_0.playerSelfInfoViewGo_)
	arg_9_0.playerOpponentInfoView_ = AutoChessPlayerInfoView.New(arg_9_0.playerOpponentInfoViewGo_)
	arg_9_0.tipsPanelView_ = AutoChessTipsPanelView.New(arg_9_0.tipsPanelGo_)
	arg_9_0.buffDamageEffectItemList_ = {}

	for iter_9_0 = 1, 5 do
		local var_9_0 = Object.Instantiate(arg_9_0.buffDamageEffectGo_, arg_9_0.damageEffectContain_, false)

		freeItem = AutoChessBuffDamageEffectItem.New(var_9_0)

		table.insert(arg_9_0.buffDamageEffectItemList_, freeItem)
	end
end

function var_0_0.InitChessFormation(arg_10_0)
	arg_10_0.chessItemPool_ = {}
	arg_10_0.usingChessItemDic_ = {}
	arg_10_0.selfEnterChessItemList_ = {}
	arg_10_0.opEnterChessItemList_ = {}
	arg_10_0.selfFormationView_ = AutoChessFormationItemView.New(arg_10_0.selfFormationGo_)
	arg_10_0.opponentFormationView_ = AutoChessFormationItemView.New(arg_10_0.opFormationGo_)
	arg_10_0.formationTrans_ = arg_10_0.fightDirector_.transform
	arg_10_0.checkDeathWhisperTimerList_ = {}
end

function var_0_0.InitFightTimeline(arg_11_0)
	arg_11_0.fightDirector_.enabled = false
	arg_11_0.fightPlayable_ = arg_11_0.fightDirector_.playableAsset
end

function var_0_0.OnExit(arg_12_0)
	AnimatorTools.Stop()

	if arg_12_0.enterTimer_ then
		arg_12_0.enterTimer_:Stop()

		arg_12_0.enterTimer_ = nil
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0.checkDeathWhisperTimerList_) do
		iter_12_1:Stop()

		iter_12_1 = nil
	end

	arg_12_0.checkDeathWhisperTimerList_ = {}
	arg_12_0.isSkipBattle_ = false
	arg_12_0.usingChessItemDic_ = {}
	arg_12_0.selfEnterChessItemList_ = {}
	arg_12_0.opEnterChessItemList_ = {}

	SetActive(arg_12_0.leftGo_, false)
	SetActive(arg_12_0.rightGo_, false)
	SetActive(arg_12_0.maskBtn_.gameObject, false)
	arg_12_0.tipsPanelView_:SetActive(false)
	arg_12_0.typeController_:SetSelectedIndex(0)

	arg_12_0.chessFormationCount_ = GameSetting.auto_chess_prepare_grid_num.value[1]
	arg_12_0.bg.localScale = Vector3.New(0.76, 0.76, 0.76)
	arg_12_0.formationTrans_.localScale = Vector3.New(0.97, 0.97, 0.97)
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.selfFormationView_:Dispose()
	arg_13_0.opponentFormationView_:Dispose()
	arg_13_0.playerSelfInfoView_:Dispose()
	arg_13_0.playerOpponentInfoView_:Dispose()
	arg_13_0.tipsPanelView_:Dispose()

	for iter_13_0, iter_13_1 in pairs(arg_13_0.buffDamageEffectItemList_) do
		iter_13_1:Dispose()
		Object.Destroy(iter_13_1.gameObject_)
	end

	for iter_13_2, iter_13_3 in pairs(arg_13_0.chessItemPool_) do
		if iter_13_3.item then
			iter_13_3.item:Dispose()
		end
	end

	arg_13_0.chessItemPool_ = nil

	var_0_0.super.Dispose(arg_13_0)
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0:Reset()
	arg_14_0:SetupBattleRenderer()
	arg_14_0:UpdateBattleView()
	arg_14_0:StartFormationTween()
end

function var_0_0.Reset(arg_15_0)
	arg_15_0:ResetAnim()
end

function var_0_0.SetupBattleRenderer(arg_16_0)
	AutoChessBattleRenderer.GetInstance():SetBattleView(arg_16_0)

	arg_16_0.blackboard_ = AutoChessBattleRenderer.GetInstance():GetBlackboard()
	arg_16_0.gameType_ = arg_16_0.blackboard_:GetGameType()
end

function var_0_0.UpdateBattleView(arg_17_0)
	arg_17_0.bottomController_:SetSelectedState(AutoChessTools.IsHideBottomButton() and "hide" or "show")
	arg_17_0:RefreshBg()
	arg_17_0:InitBtnStatus()
	arg_17_0:UpdateFormationView()
	arg_17_0:UpdatePlayerData()
end

function var_0_0.RefreshBg(arg_18_0)
	local var_18_0 = AutoChessTools.GetCurStageId(arg_18_0.gameType_)
	local var_18_1, var_18_2, var_18_3 = AutoChessTools.GetStagBgPath(var_18_0)

	arg_18_0.imgBg_.sprite = pureGetSpriteWithoutAtlas(var_18_1)
	arg_18_0.imgMachine_.sprite = pureGetSpriteWithoutAtlas(var_18_2)
	arg_18_0.imgFuzzy_.sprite = pureGetSpriteWithoutAtlas(var_18_3)
end

function var_0_0.StartSimulator(arg_19_0)
	AutoChessBattleSimulator.GetInstance():StartBattleSimulator()
end

function var_0_0.GetFormationView(arg_20_0, arg_20_1)
	if arg_20_1 == AutoChessConst.PLAYER_TYPE.SELF then
		return arg_20_0.selfFormationView_
	elseif arg_20_1 == AutoChessConst.PLAYER_TYPE.OPPONENT then
		return arg_20_0.opponentFormationView_
	end
end

function var_0_0.GetFreeDamageEffectItem(arg_21_0)
	local var_21_0

	for iter_21_0, iter_21_1 in pairs(arg_21_0.buffDamageEffectItemList_) do
		if iter_21_1:GetIsFree() then
			var_21_0 = iter_21_1

			break
		end
	end

	if var_21_0 == nil then
		local var_21_1 = Object.Instantiate(arg_21_0.buffDamageEffectGo_, arg_21_0.damageEffectContain_, false)

		var_21_0 = AutoChessBuffDamageEffectItem.New(var_21_1)

		table.insert(arg_21_0.buffDamageEffectItemList_, var_21_0)
	end

	return var_21_0
end

function var_0_0.UpdateFormationView(arg_22_0)
	arg_22_0.chessFormationCount_ = GameSetting.auto_chess_prepare_grid_num.value[1]

	arg_22_0.selfFormationView_:SetGameType(arg_22_0.gameType_)
	arg_22_0.opponentFormationView_:SetPlayerType(AutoChessConst.PLAYER_TYPE.OPPONENT)
	arg_22_0.opponentFormationView_:SetGameType(arg_22_0.gameType_)
	arg_22_0:UpdateChessItem()
end

function var_0_0.GetChessItemByUniqueId(arg_23_0, arg_23_1)
	if arg_23_0.usingChessItemDic_[arg_23_1] then
		return arg_23_0.usingChessItemDic_[arg_23_1]
	end
end

function var_0_0.GetFormationItemByIndex(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 == AutoChessConst.PLAYER_TYPE.SELF then
		return arg_24_0.selfFormationView_:GetPosItem(arg_24_2)
	elseif arg_24_1 == AutoChessConst.PLAYER_TYPE.OPPONENT then
		return arg_24_0.opponentFormationView_:GetPosItem(arg_24_2)
	end
end

function var_0_0.RemoveChessItemByUniqueId(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.usingChessItemDic_[arg_25_1]

	if var_25_0 and var_25_0.chessItemData_.attributeData.hp <= 0 then
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_disappear", "")

		arg_25_0.usingChessItemDic_[arg_25_1] = nil

		arg_25_0:ReturnChessItem(var_25_0)
	end
end

function var_0_0.CheckDeathWhisper(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0.usingChessItemDic_[arg_26_1]

	if var_26_0 == nil then
		return false
	end

	for iter_26_0, iter_26_1 in pairs(var_26_0.chessItemData_:GetBuffList()) do
		if AutoChessBuffCfg[iter_26_1.buffId].keyword_type == AutoChessConst.BUFF_KEYWORD_TYPE.DEATH_WHISPE then
			return true
		end
	end

	return false
end

function var_0_0.UpdateChessItem(arg_27_0)
	arg_27_0:ResetChessItemPool()
	arg_27_0:UpdateChessFormation(AutoChessConst.PLAYER_TYPE.SELF)
	arg_27_0:UpdateChessFormation(AutoChessConst.PLAYER_TYPE.OPPONENT)
end

function var_0_0.ResetChessItemPool(arg_28_0)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0.chessItemPool_) do
		iter_28_1.isFree = true

		iter_28_1.item:SetActive(false)
	end
end

function var_0_0.UpdateChessFormation(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:GetFormationView(arg_29_1)
	local var_29_1 = AutoChessData:GetSimulatePlayerData(arg_29_1).chessDataDicByUniqueId
	local var_29_2 = {}

	for iter_29_0, iter_29_1 in pairs(var_29_1) do
		table.insert(var_29_2, iter_29_1)
	end

	table.sort(var_29_2, function(arg_30_0, arg_30_1)
		return arg_30_0.index < arg_30_1.index
	end)

	for iter_29_2, iter_29_3 in ipairs(var_29_2) do
		local var_29_3 = arg_29_0:CreateChessItem()

		iter_29_3.index = iter_29_2

		var_29_3:SetActive(true)
		var_29_3:SetParent(var_29_0:GetChessPanelTrans())
		var_29_3:SetLocalScale(Vector3.one)
		var_29_3:SetLocalPos(var_29_0:GetChessPos(iter_29_3.index))
		var_29_3:SetPlayerType(arg_29_1)
		var_29_3:SetData(iter_29_3)
		var_29_3:ShowGradeEffect()
		var_29_3:RegisterEvent("PointerClick", arg_29_0.clickChessHandler_)

		arg_29_0.usingChessItemDic_[iter_29_3.uniqueId] = var_29_3

		if arg_29_1 == AutoChessConst.PLAYER_TYPE.SELF then
			table.insert(arg_29_0.selfEnterChessItemList_, var_29_3)
		else
			table.insert(arg_29_0.opEnterChessItemList_, var_29_3)
		end
	end
end

function var_0_0.AddChess(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0:GetFormationView(arg_31_1)
	local var_31_1 = arg_31_0:CreateChessItem()

	var_31_1:SetActive(true)
	var_31_1:SetParent(var_31_0:GetChessPanelTrans())
	var_31_1:SetLocalScale(Vector3.one)
	var_31_1:SetLocalPos(var_31_0:GetChessPos(arg_31_2.index))
	var_31_1:SetPlayerType(arg_31_1)
	var_31_1:SetData(arg_31_2)
	var_31_1:ShowGradeEffect()
	var_31_1:RegisterEvent("PointerClick", arg_31_0.clickChessHandler_)

	arg_31_0.usingChessItemDic_[arg_31_2.uniqueId] = var_31_1

	return var_31_1
end

function var_0_0.PlayChangeBgAnim(arg_32_0, arg_32_1)
	if not arg_32_1 or arg_32_1 <= arg_32_0.chessFormationCount_ then
		return
	end

	local var_32_0 = {
		{
			index = 1,
			anim = "BgScale5_6"
		},
		{
			index = 2,
			anim = "BgScale5_7"
		},
		max = {
			index = 2,
			anim = "BgScale6_7"
		}
	}
	local var_32_1 = GameSetting.auto_chess_prepare_grid_num.value[1]
	local var_32_2 = arg_32_1 - var_32_1
	local var_32_3 = arg_32_0.chessFormationCount_ == var_32_1 and var_32_0[var_32_2] or var_32_0.max

	if var_32_3 and arg_32_0.typeController_ and arg_32_0.bgAnim_ then
		arg_32_0.typeController_:SetSelectedIndex(var_32_3.index)
		arg_32_0.bgAnim_:Play(var_32_3.anim, -1, 0)
	end

	arg_32_0.chessFormationCount_ = math.max(arg_32_0.chessFormationCount_, arg_32_1)
end

function var_0_0.GetChessFormationCount(arg_33_0)
	return arg_33_0.chessFormationCount_
end

function var_0_0.CreateChessItem(arg_34_0)
	local var_34_0

	for iter_34_0, iter_34_1 in pairs(arg_34_0.chessItemPool_) do
		if iter_34_1.isFree then
			iter_34_1.isFree = false
			var_34_0 = iter_34_1.item

			break
		end
	end

	if not var_34_0 then
		local var_34_1 = Object.Instantiate(arg_34_0.chessItemGo_, arg_34_0.chessItemGo_.transform.parent)

		var_34_0 = AutoChessTeamItem.New(var_34_1)

		local var_34_2 = {
			isFree = false,
			item = var_34_0
		}

		arg_34_0.chessItemPool_[#arg_34_0.chessItemPool_ + 1] = var_34_2
	end

	var_34_0:SetLocalPos(Vector3.New(9999, 9999, 0))

	return var_34_0
end

function var_0_0.ReturnChessItem(arg_35_0, arg_35_1)
	for iter_35_0, iter_35_1 in pairs(arg_35_0.chessItemPool_) do
		if arg_35_1 == iter_35_1.item then
			iter_35_1.isFree = true

			arg_35_1:Reset()
			arg_35_1:SetLocalPos(Vector3.New(9999, 9999, 0))
			arg_35_1:SetActive(false)

			break
		end
	end
end

function var_0_0.GetChessPosByPlayerType(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_1 == AutoChessConst.PLAYER_TYPE.SELF then
		return arg_36_0.selfFormationView_:GetChessPos(arg_36_2)
	else
		return arg_36_0.opponentFormationView_:GetChessPos(arg_36_2)
	end
end

function var_0_0.OnPointerClick(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_0.isPlay_ then
		arg_37_0.isTipPause_ = true

		arg_37_0:OnClickPlayBtn()
	end

	SetActive(arg_37_0.maskBtn_.gameObject, true)
	arg_37_0.tipsPanelView_:SetData(arg_37_1)
	arg_37_0.tipsPanelView_:SetGoldState(false)
	arg_37_0.tipsPanelView_:SetPivot(0, 1)

	local var_37_0 = arg_37_2:GetPos()

	arg_37_0.tipsPanelView_:SetPos(var_37_0)
	AutoChessTools.ScreenAdapter(arg_37_2, arg_37_0.tipsPanelView_)
	OperationRecorder.RecordButtonTouch({
		type = 1,
		button_name = "activity_autochess_combat_chess_touch",
		activity_id = AutoChessData:GetActivityID(),
		polyhedron_id_str = AutoChessData:GetSimulatePlayerData(AutoChessConst.PLAYER_TYPE.SELF).battleUID,
		other_data = AutoChessTools.GetChessTrackingPointStr(arg_37_1)
	})
end

function var_0_0.OnClickCloseTips(arg_38_0)
	if arg_38_0.isTipPause_ then
		arg_38_0.isTipPause_ = false

		arg_38_0:OnClickPlayBtn()
	end
end

function var_0_0.UpdatePlayerData(arg_39_0)
	arg_39_0:UpdateSelfPlayerData()
	arg_39_0:UpdateOpponentPlayerData()
end

function var_0_0.UpdateSelfPlayerData(arg_40_0)
	arg_40_0.playerSelfInfoView_:SetGameType(arg_40_0.gameType_)
	arg_40_0.playerSelfInfoView_:SetData(AutoChessData:GetSimulatePlayerData(AutoChessConst.PLAYER_TYPE.SELF))
end

function var_0_0.UpdateOpponentPlayerData(arg_41_0)
	local var_41_0 = AutoChessData:GetCurGameType() == AutoChessConst.GAME_TYPE.PVE

	arg_41_0.playerOpponentInfoView_:SetGameType(arg_41_0.gameType_)
	arg_41_0.playerOpponentInfoView_:SetData(AutoChessData:GetSimulatePlayerData(AutoChessConst.PLAYER_TYPE.OPPONENT))
	arg_41_0.playerOpponentInfoView_:SetHideData(var_41_0)
end

function var_0_0.InitBtnStatus(arg_42_0)
	arg_42_0.isPlay_ = true

	arg_42_0.playBtnController_:SetSelectedState("play")

	arg_42_0.isAccelerating_ = getData("AutoChess", "battleSpeed") == 1

	arg_42_0.doubleSpeedBtnController_:SetSelectedState(arg_42_0.isAccelerating_ and "2" or "1")
	AutoChessBattleRenderer.GetInstance():SetIsForceSpeedUp(false)
	AutoChessBattleRenderer.GetInstance():SetSpeed(arg_42_0.isAccelerating_ and 2 or 1)
end

function var_0_0.OnClickPlayBtn(arg_43_0)
	if arg_43_0.isPlay_ then
		arg_43_0.isPlay_ = false

		arg_43_0.playBtnController_:SetSelectedState("pause")
		AutoChessBattleSimulator.GetInstance():Pause()
	else
		arg_43_0.isPlay_ = true

		arg_43_0.playBtnController_:SetSelectedState("play")
		AutoChessBattleSimulator.GetInstance():Resume()
	end
end

function var_0_0.OnClickSkipBtn(arg_44_0)
	arg_44_0.isSkipBattle_ = true

	AutoChessBattleSimulator.GetInstance():Skip()
	OperationRecorder.RecordButtonTouch({
		button_name = "activity_autochess_combat_pvp_skip_touch",
		activity_id = AutoChessData:GetActivityID(),
		polyhedron_id_str = AutoChessData:GetSimulatePlayerData(AutoChessConst.PLAYER_TYPE.SELF).battleUID
	})
end

function var_0_0.OnClickDoubleSpeedBtn(arg_45_0)
	if arg_45_0.isAccelerating_ then
		arg_45_0.isAccelerating_ = false

		arg_45_0.doubleSpeedBtnController_:SetSelectedState("1")
		AutoChessBattleRenderer.GetInstance():SetSpeed(1)
	else
		arg_45_0.isAccelerating_ = true

		arg_45_0.doubleSpeedBtnController_:SetSelectedState("2")
		AutoChessBattleRenderer.GetInstance():SetSpeed(2)
	end

	saveData("AutoChess", "battleSpeed", arg_45_0.isAccelerating_ and 1 or 0)
end

function var_0_0.ResetAnim(arg_46_0)
	SetActive(arg_46_0.attackAniGo_, false)
end

function var_0_0.StartFormationTween(arg_47_0)
	local var_47_0 = false
	local var_47_1 = false

	arg_47_0.rightGo_.transform.anchoredPosition = Vector2.New(0, -60)

	SetActive(arg_47_0.selfChessContain_.gameObject, false)
	SetActive(arg_47_0.opChessContain_.gameObject, false)
	AnimatorTools.PlayAnimationWithCallback(arg_47_0.bgAnim_, "BgScale5x5", function()
		SetActive(arg_47_0.leftGo_, true)
		SetActive(arg_47_0.rightGo_, true)

		arg_47_0.selfChessContain_.transform.anchoredPosition = Vector2.New(arg_47_0.chessContainPosX_ - _G.SCREEN_WIDTH / 2, 0)
		arg_47_0.opChessContain_.transform.anchoredPosition = Vector2.New(arg_47_0.chessContainPosX_ + _G.SCREEN_WIDTH / 2, 0)

		SetActive(arg_47_0.selfChessContain_.gameObject, true)
		SetActive(arg_47_0.opChessContain_.gameObject, true)
		LeanTween.moveLocalX(arg_47_0.selfChessContain_, 2 * arg_47_0.chessContainPosX_, 1.5):setOnComplete(LuaHelper.VoidAction(function()
			var_47_0 = true
		end))
		LeanTween.moveLocalX(arg_47_0.opChessContain_, 0, 1.5):setOnComplete(LuaHelper.VoidAction(function()
			var_47_1 = true
		end))
		arg_47_0:PlayItemEnterAnim()

		if arg_47_0.enterTimer_ then
			arg_47_0.enterTimer_:Stop()

			arg_47_0.enterTimer_ = nil
		end

		arg_47_0.enterTimer_ = Timer.New(function()
			if var_47_0 and var_47_1 then
				arg_47_0:ResetItemAnim()
				arg_47_0.enterTimer_:Stop()

				arg_47_0.enterTimer_ = nil

				if not arg_47_0.isSkipBattle_ then
					arg_47_0:StartSimulator()
				end
			end
		end, 0.33, -1)

		arg_47_0.enterTimer_:Start()
	end, -1, 0)
	arg_47_0.bgAnim_:Update(0)
end

function var_0_0.PlayItemEnterAnim(arg_52_0)
	manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_jump", "")

	local var_52_0 = 1
	local var_52_1 = 1
	local var_52_2
	local var_52_3

	var_52_2 = Timer.New(function()
		if var_52_0 <= #arg_52_0.selfEnterChessItemList_ then
			arg_52_0.selfEnterChessItemList_[var_52_0]:PlayItemAnim("ChessItem_ruchang")

			var_52_0 = var_52_0 + 1
		else
			var_52_2:Stop()
		end
	end, 0.03, -1)
	var_52_3 = Timer.New(function()
		if var_52_1 <= #arg_52_0.opEnterChessItemList_ then
			arg_52_0.opEnterChessItemList_[var_52_1]:PlayItemAnim("ChessItem_ruchang")

			var_52_1 = var_52_1 + 1
		else
			var_52_3:Stop()
		end
	end, 0.03, -1)

	var_52_2:Start()
	var_52_3:Start()
end

function var_0_0.ResetItemAnim(arg_55_0)
	for iter_55_0, iter_55_1 in pairs(arg_55_0.usingChessItemDic_) do
		iter_55_1:PlayItemAnim("ChessIdleAnim")
	end
end

function var_0_0.PlayShakeAnim(arg_56_0, arg_56_1, arg_56_2)
	local var_56_0 = GameSetting.auto_chess_shake.value
	local var_56_1 = 1

	for iter_56_0, iter_56_1 in ipairs(var_56_0) do
		if iter_56_1 <= arg_56_1 then
			var_56_1 = iter_56_0 + 1
		end
	end

	local var_56_2

	var_56_2 = Timer.New(function()
		arg_56_0.shakeAnim_:Play("U_zhenping_0" .. var_56_1, -1, 0)
		arg_56_0.shakeAnim_:Update(0)
		var_56_2:Stop()

		var_56_2 = nil
	end, arg_56_2, 1)

	var_56_2:Start()
end

return var_0_0
