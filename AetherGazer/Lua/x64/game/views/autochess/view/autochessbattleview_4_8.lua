local var_0_0 = import("game.views.autoChess.view.AutoChessBattleView")
local var_0_1 = class("AutoChessBattleView_4_8", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Activity_Xihe/Activity_Xihe_BattleUI"
end

function var_0_1.InitUI(arg_2_0)
	var_0_1.super.InitUI(arg_2_0)

	arg_2_0.stickerList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.stickerListGo_, AutoChessStickerItem)
	arg_2_0.autoChessCountDownView_ = AutoChessCountDownView.New(arg_2_0.timerGo_)
	arg_2_0.stickerClickHandler_ = handler(arg_2_0, arg_2_0.OnStickerClick)
	arg_2_0.receiveStickerHandler_ = handler(arg_2_0, arg_2_0.OnReceiveSticker)
end

function var_0_1.InitController(arg_3_0)
	var_0_1.super.InitController(arg_3_0)

	arg_3_0.stickerController_ = arg_3_0.controllerEx_:GetController("stickerPanel")
	arg_3_0.skipController_ = arg_3_0.btnCon_:GetController("skipBtn")
end

function var_0_1.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.playBtn_, nil, handler(arg_4_0, arg_4_0.OnClickPlayBtn))
	arg_4_0:AddBtnListener(arg_4_0.skipBtn_, nil, handler(arg_4_0, arg_4_0.OnClickSkipBtn))
	arg_4_0:AddBtnListener(arg_4_0.doubleSpeedBtn_, nil, handler(arg_4_0, arg_4_0.OnClickDoubleSpeedBtn))
	arg_4_0:AddBtnListener(arg_4_0.maskBtn_, nil, function()
		SetActive(arg_4_0.maskBtn_.gameObject, false)
		arg_4_0.tipsPanelView_:SetActive(false)
		arg_4_0.stickerController_:SetSelectedState("hide")
		arg_4_0:OnClickCloseTips()
	end)
	arg_4_0:AddBtnListener(arg_4_0.stickerBtn_, nil, function()
		arg_4_0.stickerController_:SetSelectedState("show")
		SetActive(arg_4_0.maskBtn_.gameObject, true)

		for iter_6_0, iter_6_1 in ipairs(arg_4_0.stickerList_:GetItemList()) do
			iter_6_1:RefreshLock(arg_4_0.isShowSticker_)
		end
	end)
end

function var_0_1.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_0.stickerIDList_[arg_7_1], false, arg_7_0.stickerClickHandler_)
end

function var_0_1.OnEnter(arg_8_0)
	var_0_1.super.OnEnter(arg_8_0)
	arg_8_0.stickerController_:SetSelectedState("hide")

	arg_8_0.isShowSticker_ = false
	arg_8_0.stickerIDList_ = GameSetting.auto_chess_2_sticker_ID.value

	arg_8_0.stickerList_:StartScroll(#arg_8_0.stickerIDList_)
	manager.notify:RegistListener(AUTO_CHESS_RECEIVE_STICKER, arg_8_0.receiveStickerHandler_)
end

function var_0_1.UpdateBattleView(arg_9_0)
	arg_9_0:RefreshBg()
	arg_9_0:InitBtnStatus()
	arg_9_0:UpdateFormationView()
	arg_9_0:UpdatePlayerData()
	arg_9_0.autoChessCountDownView_:UpdateCountDownTime()
	arg_9_0:HideBottomTimer()
end

function var_0_1.RefreshBg(arg_10_0)
	local var_10_0, var_10_1, var_10_2 = AutoChessTools.GetRandomBgPath()

	arg_10_0.imgBg_.sprite = pureGetSpriteWithoutAtlas(var_10_0)
	arg_10_0.imgMachine_.sprite = pureGetSpriteWithoutAtlas(var_10_1)
	arg_10_0.imgFuzzy_.sprite = pureGetSpriteWithoutAtlas(var_10_2)
end

function var_0_1.HideBottomTimer(arg_11_0)
	if arg_11_0.hideBottomTimer_ then
		arg_11_0.hideBottomTimer_:Stop()

		arg_11_0.hideBottomTimer_ = nil
	end

	arg_11_0.skipController_:SetSelectedState("hide")

	local var_11_0 = AutoChessData:GetEndTimeStamp(AutoChessConst.GAME_TYPE.ONLINE)
	local var_11_1 = GameSetting.auto_chess_2_skip_time.value[1]
	local var_11_2 = GameSetting.auto_chess_2_speed_up.value[1]
	local var_11_3 = GameSetting.auto_chess_2_speed_up.value[2]
	local var_11_4 = var_11_0.startTime + var_11_1 - manager.time:GetServerTime()
	local var_11_5 = var_11_0.startTime + var_11_2 - manager.time:GetServerTime()

	if var_11_4 > 0 then
		arg_11_0.hideBottomTimer_ = Timer.New(function()
			arg_11_0.skipController_:SetSelectedState("show")
		end, var_11_4, 1)

		arg_11_0.hideBottomTimer_:Start()
	else
		arg_11_0.skipController_:SetSelectedState("show")
	end

	if var_11_5 > 0 then
		arg_11_0.speedUpTimer = Timer.New(function()
			AutoChessBattleRenderer.GetInstance():SetSpeed(var_11_3)
			AutoChessBattleRenderer.GetInstance():SetIsForceSpeedUp(true)
		end, var_11_5, 1)

		arg_11_0.speedUpTimer:Start()
	end
end

function var_0_1.OnStickerClick(arg_14_0, arg_14_1)
	if arg_14_0.isShowSticker_ then
		ShowTips("AUTO_CHESS_2_EMOTE_CD")

		return
	else
		arg_14_0.isShowSticker_ = true

		local var_14_0 = GameSetting.auto_chess_2_sticker_CD.value[1]

		arg_14_0.stickerTimer_ = Timer.New(function()
			arg_14_0.isShowSticker_ = false

			for iter_15_0, iter_15_1 in ipairs(arg_14_0.stickerList_:GetItemList()) do
				iter_15_1:RefreshLock(arg_14_0.isShowSticker_)
			end
		end, var_14_0, 1)

		arg_14_0.stickerTimer_:Start()
	end

	arg_14_0.stickerController_:SetSelectedState("hide")

	if arg_14_0.playerSelfInfoView_ then
		arg_14_0.playerSelfInfoView_:SetSticker(arg_14_1)
	end

	OperationRecorder.RecordButtonTouch({
		button_name = "activity_autochess_combat_pvp_talk_touch",
		activity_id = AutoChessData:GetActivityID(),
		polyhedron_id_str = AutoChessData:GetPrepareData(arg_14_0.gameType_):GetUUID(),
		emoji_id = arg_14_1
	})
	AutoChessMatchAction.SendSticker(arg_14_1)
end

function var_0_1.OnReceiveSticker(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0, var_16_1 = AutoChessData:GetBattlerPlayerUid()

	if arg_16_0.playerOpponentInfoView_ and var_16_1 == tonumber(arg_16_2) then
		arg_16_0.playerOpponentInfoView_:SetSticker(arg_16_1)
	end
end

function var_0_1.StopBottomTimer(arg_17_0)
	if arg_17_0.hideBottomTimer_ then
		arg_17_0.hideBottomTimer_:Stop()

		arg_17_0.hideBottomTimer_ = nil
	end

	if arg_17_0.speedUpTimer then
		arg_17_0.speedUpTimer:Stop()

		arg_17_0.speedUpTimer = nil

		AutoChessBattleRenderer.GetInstance():SetIsForceSpeedUp(false)
		AutoChessBattleRenderer.GetInstance():SetSpeed(1)
	end
end

function var_0_1.OnBehind(arg_18_0)
	if AutoChessBattleSimulator.GetInstance():GetStatus() == AutoChessConst.BATTLE_STATUS.END then
		arg_18_0:StopBottomTimer()
	end
end

function var_0_1.OnExit(arg_19_0)
	if arg_19_0.autoChessCountDownView_ then
		arg_19_0.autoChessCountDownView_:OnExit()
	end

	if arg_19_0.stickerTimer_ then
		arg_19_0.stickerTimer_:Stop()

		arg_19_0.stickerTimer_ = nil
	end

	arg_19_0:StopBottomTimer()
	arg_19_0:RemoveAllEventListener()
	var_0_1.super.OnExit(arg_19_0)
end

function var_0_1.Dispose(arg_20_0)
	if arg_20_0.autoChessCountDownView_ then
		arg_20_0.autoChessCountDownView_:Dispose()
	end

	if arg_20_0.stickerList_ then
		arg_20_0.stickerList_:Dispose()
	end

	var_0_1.super.Dispose(arg_20_0)
end

return var_0_1
