local AutoChessBattleView_4_8 = class("AutoChessBattleView_4_8", (import("game.views.autoChess.view.AutoChessBattleView")))

function AutoChessBattleView_4_8:UIName()
	return "Widget/System/Activity_Xihe/Activity_Xihe_BattleUI"
end

function AutoChessBattleView_4_8:InitUI()
	AutoChessBattleView_4_8.super.InitUI(self)

	self.stickerList_ = LuaList.New(handler(self, self.IndexItem), self.stickerListGo_, AutoChessStickerItem)
	self.autoChessCountDownView_ = AutoChessCountDownView.New(self.timerGo_)
	self.stickerClickHandler_ = handler(self, self.OnStickerClick)
	self.receiveStickerHandler_ = handler(self, self.OnReceiveSticker)
end

function AutoChessBattleView_4_8:InitController()
	AutoChessBattleView_4_8.super.InitController(self)

	self.stickerController_ = self.controllerEx_:GetController("stickerPanel")
	self.skipController_ = self.btnCon_:GetController("skipBtn")
end

function AutoChessBattleView_4_8:AddUIListener()
	self:AddBtnListener(self.playBtn_, nil, handler(self, self.OnClickPlayBtn))
	self:AddBtnListener(self.skipBtn_, nil, handler(self, self.OnClickSkipBtn))
	self:AddBtnListener(self.doubleSpeedBtn_, nil, handler(self, self.OnClickDoubleSpeedBtn))
	self:AddBtnListener(self.maskBtn_, nil, function()
		SetActive(self.maskBtn_.gameObject, false)
		self.tipsPanelView_:SetActive(false)
		self.stickerController_:SetSelectedState("hide")
		self:OnClickCloseTips()
	end)
	self:AddBtnListener(self.stickerBtn_, nil, function()
		self.stickerController_:SetSelectedState("show")
		SetActive(self.maskBtn_.gameObject, true)

		for iter_6_0, iter_6_1 in ipairs(self.stickerList_:GetItemList()) do
			iter_6_1:RefreshLock(self.isShowSticker_)
		end
	end)
end

function AutoChessBattleView_4_8:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(self.stickerIDList_[arg_7_1], false, self.stickerClickHandler_)
end

function AutoChessBattleView_4_8:OnEnter()
	AutoChessBattleView_4_8.super.OnEnter(self)
	self.stickerController_:SetSelectedState("hide")

	self.isShowSticker_ = false
	self.stickerIDList_ = GameSetting.auto_chess_2_sticker_ID.value

	self.stickerList_:StartScroll(#self.stickerIDList_)
	manager.notify:RegistListener(AUTO_CHESS_RECEIVE_STICKER, self.receiveStickerHandler_)
end

function AutoChessBattleView_4_8:UpdateBattleView()
	self:RefreshBg()
	self:InitBtnStatus()
	self:UpdateFormationView()
	self:UpdatePlayerData()
	self.autoChessCountDownView_:UpdateCountDownTime()
	self:HideBottomTimer()
end

function AutoChessBattleView_4_8:RefreshBg()
	local var_10_0, var_10_1, var_10_2 = AutoChessTools.GetRandomBgPath()

	self.imgBg_.sprite = pureGetSpriteWithoutAtlas(var_10_0)
	self.imgMachine_.sprite = pureGetSpriteWithoutAtlas(var_10_1)
	self.imgFuzzy_.sprite = pureGetSpriteWithoutAtlas(var_10_2)
end

function AutoChessBattleView_4_8:HideBottomTimer()
	if self.hideBottomTimer_ then
		self.hideBottomTimer_:Stop()

		self.hideBottomTimer_ = nil
	end

	self.skipController_:SetSelectedState("hide")

	local var_11_0 = AutoChessData:GetEndTimeStamp(AutoChessConst.GAME_TYPE.ONLINE)
	local var_11_1 = GameSetting.auto_chess_2_speed_up.value[2]
	local var_11_2 = var_11_0.startTime + GameSetting.auto_chess_2_skip_time.value[1] - manager.time:GetServerTime()
	local var_11_3 = var_11_0.startTime + GameSetting.auto_chess_2_speed_up.value[1] - manager.time:GetServerTime()

	if var_11_2 > 0 then
		self.hideBottomTimer_ = Timer.New(function()
			self.skipController_:SetSelectedState("show")
		end, var_11_2, 1)

		self.hideBottomTimer_:Start()
	else
		self.skipController_:SetSelectedState("show")
	end

	if var_11_3 > 0 then
		self.speedUpTimer = Timer.New(function()
			AutoChessBattleRenderer.GetInstance():SetSpeed(var_11_1)
			AutoChessBattleRenderer.GetInstance():SetIsForceSpeedUp(true)
		end, var_11_3, 1)

		self.speedUpTimer:Start()
	end
end

function AutoChessBattleView_4_8:OnStickerClick(arg_14_1)
	if self.isShowSticker_ then
		ShowTips("AUTO_CHESS_2_EMOTE_CD")

		return
	else
		self.isShowSticker_ = true
		self.stickerTimer_ = Timer.New(function()
			self.isShowSticker_ = false

			for iter_15_0, iter_15_1 in ipairs(self.stickerList_:GetItemList()) do
				iter_15_1:RefreshLock(self.isShowSticker_)
			end
		end, GameSetting.auto_chess_2_sticker_CD.value[1], 1)

		self.stickerTimer_:Start()
	end

	self.stickerController_:SetSelectedState("hide")

	if self.playerSelfInfoView_ then
		self.playerSelfInfoView_:SetSticker(arg_14_1)
	end

	local var_14_0 = {
		button_name = "activity_autochess_combat_pvp_talk_touch",
		activity_id = AutoChessData:GetActivityID()
	}

	var_14_0.polyhedron_id_str = AutoChessData:GetPrepareData(self.gameType_):GetUUID()
	var_14_0.emoji_id = arg_14_1

	OperationRecorder.RecordButtonTouch(var_14_0)
	AutoChessMatchAction.SendSticker(arg_14_1)
end

function AutoChessBattleView_4_8:OnReceiveSticker(arg_16_1, arg_16_2)
	local var_16_0, var_16_1 = AutoChessData:GetBattlerPlayerUid()

	if self.playerOpponentInfoView_ and var_16_1 == tonumber(arg_16_2) then
		self.playerOpponentInfoView_:SetSticker(arg_16_1)
	end
end

function AutoChessBattleView_4_8:StopBottomTimer()
	if self.hideBottomTimer_ then
		self.hideBottomTimer_:Stop()

		self.hideBottomTimer_ = nil
	end

	if self.speedUpTimer then
		self.speedUpTimer:Stop()

		self.speedUpTimer = nil

		AutoChessBattleRenderer.GetInstance():SetIsForceSpeedUp(false)
		AutoChessBattleRenderer.GetInstance():SetSpeed(1)
	end
end

function AutoChessBattleView_4_8:OnBehind()
	if AutoChessBattleSimulator.GetInstance():GetStatus() == AutoChessConst.BATTLE_STATUS.END then
		self:StopBottomTimer()
	end
end

function AutoChessBattleView_4_8:OnExit()
	if self.autoChessCountDownView_ then
		self.autoChessCountDownView_:OnExit()
	end

	if self.stickerTimer_ then
		self.stickerTimer_:Stop()

		self.stickerTimer_ = nil
	end

	self:StopBottomTimer()
	self:RemoveAllEventListener()
	AutoChessBattleView_4_8.super.OnExit(self)
end

function AutoChessBattleView_4_8:Dispose()
	if self.autoChessCountDownView_ then
		self.autoChessCountDownView_:Dispose()
	end

	if self.stickerList_ then
		self.stickerList_:Dispose()
	end

	AutoChessBattleView_4_8.super.Dispose(self)
end

return AutoChessBattleView_4_8
