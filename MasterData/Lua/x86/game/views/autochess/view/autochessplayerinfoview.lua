local AutoChessPlayerInfoView = class("AutoChessPlayerInfoView", ReduxView)

function AutoChessPlayerInfoView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()

	self.playerData_ = nil
end

function AutoChessPlayerInfoView:Init()
	self:BindCfgUI()
	self:InitController()

	self.dataItemList_ = {}

	for iter_2_0 = 1, 3 do
		local var_2_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_2_0, self["dataGo_" .. iter_2_0])

		var_2_0.tipsController = var_2_0.controllerEx_:GetController("tips")

		table.insert(self.dataItemList_, var_2_0)
	end

	self.stickerItem_ = AutoChessStickerItem.New(self.sitckerGo_)

	self:AddUIListener()
end

function AutoChessPlayerInfoView:AddUIListener()
	for iter_3_0 = 1, 3 do
		self:AddBtnListener(self.dataItemList_[iter_3_0].btn_, nil, function()
			self:OnClickItemBtn(self.dataItemList_[iter_3_0])
		end)
	end

	self:AddBtnListener(self.maskBtn_, nil, function()
		self:CloseTips()
	end)
end

function AutoChessPlayerInfoView:InitController()
	self.typeController_ = self.controllerEx_:GetController("type")
	self.maskController_ = self.controllerEx_:GetController("mask")
	self.dataController_ = self.controllerEx_:GetController("data")
	self.stickerController_ = self.controllerEx_:GetController("sticker")
end

function AutoChessPlayerInfoView:SetData(arg_7_1)
	self.playerData_ = arg_7_1

	self:UpdateUI()
end

function AutoChessPlayerInfoView:SetGameType(arg_8_1)
	self.gameType_ = arg_8_1
end

function AutoChessPlayerInfoView:UpdateUI()
	self:UpdateTips()
	self:UpdateType()
	self:UpdateBattleInfo()
end

function AutoChessPlayerInfoView:UpdateTips()
	self.hpTips_.text = GetTips("AUTO_CHESS_HEALTH_ICON_TIP")
	self.roundTips_.text = GetTips("AUTO_CHESS_ROUND_ICON_TIP")
	self.victoryTips_.text = self.gameType_ == AutoChessConst.GAME_TYPE.ONLINE and GetTips("AUTO_CHESS_2_WIN_ICON_TIP") or GetTips("AUTO_CHESS_WIN_ICON_TIP")
end

function AutoChessPlayerInfoView:UpdateType()
	if self.playerData_.playerType == AutoChessConst.PLAYER_TYPE.SELF then
		self.typeController_:SetSelectedState("self")
		self:UpdateSelfPlayerInfo()
	else
		self.typeController_:SetSelectedState("opponent")
		self:UpdateOtherPlayerInfo()
	end
end

function AutoChessPlayerInfoView:UpdateSelfPlayerInfo()
	if self.gameType_ == 0 then
		local var_12_0 = AutoChessStageCfg[self.playerData_:GetStageId()]

		self.headImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. var_12_0.my_icon)
		self.nameText_.text = GetI18NText(var_12_0.my_name)
	else
		local var_12_1 = PlayerData:GetPlayerInfo()

		self.headImg_.sprite = AutoChessTools.GetPlayerIcon(var_12_1.portrait)
		self.nameText_.text = GetI18NText(var_12_1.nick)
	end
end

function AutoChessPlayerInfoView:UpdateOtherPlayerInfo()
	if self.gameType_ == 0 then
		local var_13_0 = AutoChessStageCfg[self.playerData_:GetStageId()]

		self.headImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. var_13_0.enemy_icon)
		self.nameText_.text = GetI18NText(var_13_0.enemy_name)
	else
		self.headImg_.sprite = AutoChessTools.GetPlayerIcon(self.playerData_.icon)
		self.nameText_.text = GetI18NText(self.playerData_.nick)
	end
end

function AutoChessPlayerInfoView:UpdateBattleInfo()
	self.hpText_.text = self.playerData_.hp
	self.roundText_.text = self.playerData_.curRoundCount

	if self.gameType_ == AutoChessConst.GAME_TYPE.PVE then
		self.trophyText_.text = GetI18NText(self.playerData_.victoryRoundCount .. "/" .. AutoChessStageCfg[self.playerData_:GetStageId()].win_num)
	elseif AutoChessTools.GetIsPVPGame(self.gameType_) then
		self.trophyText_.text = GetI18NText(self.playerData_.victoryRoundCount .. "/" .. GameSetting.auto_chess_win_limit.value[1])
	elseif self.gameType_ == AutoChessConst.GAME_TYPE.ONLINE then
		self.trophyText_.text = self.playerData_.victoryRoundCount
	end
end

function AutoChessPlayerInfoView:OnClickItemBtn(arg_15_1)
	if self.selectItem_ then
		self.selectItem_.tipsController:SetSelectedState("off")
	end

	self.selectItem_ = arg_15_1

	arg_15_1.tipsController:SetSelectedState("on")
	self.maskController_:SetSelectedState("show")
end

function AutoChessPlayerInfoView:CloseTips()
	if self.selectItem_ then
		self.selectItem_.tipsController:SetSelectedState("off")

		self.selectItem_ = nil
	end

	self.maskController_:SetSelectedState("hide")
end

function AutoChessPlayerInfoView:SetHideData(arg_17_1)
	self.dataController_:SetSelectedState(arg_17_1 and "hide" or "show")
end

function AutoChessPlayerInfoView:SetSticker(arg_18_1)
	if not arg_18_1 or self.stickerItem_ == nil then
		return
	end

	self.stickerItem_:SetData(arg_18_1)
	self.stickerController_:SetSelectedState("show")

	if self.stickerTimer_ then
		self.stickerTimer_:Stop()

		self.stickerTimer_ = nil
	end

	self.stickerTimer_ = Timer.New(function()
		self.stickerController_:SetSelectedState("hide")
		self.stickerTimer_:Stop()
	end, GameSetting.auto_chess_2_sticker_display_time.value[1], 1)

	self.stickerTimer_:Start()
end

function AutoChessPlayerInfoView:OnExit()
	if self.stickerTimer_ then
		self.stickerTimer_:Stop()

		self.stickerTimer_ = nil
	end

	self.stickerController_:SetSelectedState("hide")
	AutoChessPlayerInfoView.super.OnExit(self)
end

function AutoChessPlayerInfoView:Dispose()
	if self.stickerItem_ then
		self.stickerItem_:Dispose()

		self.stickerItem_ = nil
	end

	AutoChessPlayerInfoView.super.Dispose(self)
end

return AutoChessPlayerInfoView
