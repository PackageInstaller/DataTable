local var_0_0 = class("AutoChessPlayerInfoView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()

	arg_1_0.playerData_ = nil
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitController()

	arg_2_0.dataItemList_ = {}

	for iter_2_0 = 1, 3 do
		local var_2_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_2_0, arg_2_0["dataGo_" .. iter_2_0])

		var_2_0.tipsController = var_2_0.controllerEx_:GetController("tips")

		table.insert(arg_2_0.dataItemList_, var_2_0)
	end

	arg_2_0.stickerItem_ = AutoChessStickerItem.New(arg_2_0.sitckerGo_)

	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	for iter_3_0 = 1, 3 do
		arg_3_0:AddBtnListener(arg_3_0.dataItemList_[iter_3_0].btn_, nil, function()
			arg_3_0:OnClickItemBtn(arg_3_0.dataItemList_[iter_3_0])
		end)
	end

	arg_3_0:AddBtnListener(arg_3_0.maskBtn_, nil, function()
		arg_3_0:CloseTips()
	end)
end

function var_0_0.InitController(arg_6_0)
	arg_6_0.typeController_ = arg_6_0.controllerEx_:GetController("type")
	arg_6_0.maskController_ = arg_6_0.controllerEx_:GetController("mask")
	arg_6_0.dataController_ = arg_6_0.controllerEx_:GetController("data")
	arg_6_0.stickerController_ = arg_6_0.controllerEx_:GetController("sticker")
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.playerData_ = arg_7_1

	arg_7_0:UpdateUI()
end

function var_0_0.SetGameType(arg_8_0, arg_8_1)
	arg_8_0.gameType_ = arg_8_1
end

function var_0_0.UpdateUI(arg_9_0)
	arg_9_0:UpdateTips()
	arg_9_0:UpdateType()
	arg_9_0:UpdateBattleInfo()
end

function var_0_0.UpdateTips(arg_10_0)
	arg_10_0.hpTips_.text = GetTips("AUTO_CHESS_HEALTH_ICON_TIP")
	arg_10_0.roundTips_.text = GetTips("AUTO_CHESS_ROUND_ICON_TIP")
	arg_10_0.victoryTips_.text = arg_10_0.gameType_ == AutoChessConst.GAME_TYPE.ONLINE and GetTips("AUTO_CHESS_2_WIN_ICON_TIP") or GetTips("AUTO_CHESS_WIN_ICON_TIP")
end

function var_0_0.UpdateType(arg_11_0)
	if arg_11_0.playerData_.playerType == AutoChessConst.PLAYER_TYPE.SELF then
		arg_11_0.typeController_:SetSelectedState("self")
		arg_11_0:UpdateSelfPlayerInfo()
	else
		arg_11_0.typeController_:SetSelectedState("opponent")
		arg_11_0:UpdateOtherPlayerInfo()
	end
end

function var_0_0.UpdateSelfPlayerInfo(arg_12_0)
	if arg_12_0.gameType_ == 0 then
		local var_12_0 = arg_12_0.playerData_:GetStageId()
		local var_12_1 = AutoChessStageCfg[var_12_0]

		arg_12_0.headImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. var_12_1.my_icon)
		arg_12_0.nameText_.text = GetI18NText(var_12_1.my_name)
	else
		local var_12_2 = PlayerData:GetPlayerInfo()

		arg_12_0.headImg_.sprite = AutoChessTools.GetPlayerIcon(var_12_2.portrait)
		arg_12_0.nameText_.text = GetI18NText(var_12_2.nick)
	end
end

function var_0_0.UpdateOtherPlayerInfo(arg_13_0)
	if arg_13_0.gameType_ == 0 then
		local var_13_0 = arg_13_0.playerData_:GetStageId()
		local var_13_1 = AutoChessStageCfg[var_13_0]

		arg_13_0.headImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. var_13_1.enemy_icon)
		arg_13_0.nameText_.text = GetI18NText(var_13_1.enemy_name)
	else
		arg_13_0.headImg_.sprite = AutoChessTools.GetPlayerIcon(arg_13_0.playerData_.icon)
		arg_13_0.nameText_.text = GetI18NText(arg_13_0.playerData_.nick)
	end
end

function var_0_0.UpdateBattleInfo(arg_14_0)
	arg_14_0.hpText_.text = arg_14_0.playerData_.hp
	arg_14_0.roundText_.text = arg_14_0.playerData_.curRoundCount

	if arg_14_0.gameType_ == AutoChessConst.GAME_TYPE.PVE then
		local var_14_0 = arg_14_0.playerData_:GetStageId()
		local var_14_1 = AutoChessStageCfg[var_14_0]

		arg_14_0.trophyText_.text = GetI18NText(arg_14_0.playerData_.victoryRoundCount .. "/" .. var_14_1.win_num)
	elseif AutoChessTools.GetIsPVPGame(arg_14_0.gameType_) then
		arg_14_0.trophyText_.text = GetI18NText(arg_14_0.playerData_.victoryRoundCount .. "/" .. GameSetting.auto_chess_win_limit.value[1])
	elseif arg_14_0.gameType_ == AutoChessConst.GAME_TYPE.ONLINE then
		arg_14_0.trophyText_.text = arg_14_0.playerData_.victoryRoundCount
	end
end

function var_0_0.OnClickItemBtn(arg_15_0, arg_15_1)
	if arg_15_0.selectItem_ then
		arg_15_0.selectItem_.tipsController:SetSelectedState("off")
	end

	arg_15_0.selectItem_ = arg_15_1

	arg_15_1.tipsController:SetSelectedState("on")
	arg_15_0.maskController_:SetSelectedState("show")
end

function var_0_0.CloseTips(arg_16_0)
	if arg_16_0.selectItem_ then
		arg_16_0.selectItem_.tipsController:SetSelectedState("off")

		arg_16_0.selectItem_ = nil
	end

	arg_16_0.maskController_:SetSelectedState("hide")
end

function var_0_0.SetHideData(arg_17_0, arg_17_1)
	arg_17_0.dataController_:SetSelectedState(arg_17_1 and "hide" or "show")
end

function var_0_0.SetSticker(arg_18_0, arg_18_1)
	if not arg_18_1 or arg_18_0.stickerItem_ == nil then
		return
	end

	arg_18_0.stickerItem_:SetData(arg_18_1)
	arg_18_0.stickerController_:SetSelectedState("show")

	if arg_18_0.stickerTimer_ then
		arg_18_0.stickerTimer_:Stop()

		arg_18_0.stickerTimer_ = nil
	end

	local var_18_0 = GameSetting.auto_chess_2_sticker_display_time.value[1]

	arg_18_0.stickerTimer_ = Timer.New(function()
		arg_18_0.stickerController_:SetSelectedState("hide")
		arg_18_0.stickerTimer_:Stop()
	end, var_18_0, 1)

	arg_18_0.stickerTimer_:Start()
end

function var_0_0.OnExit(arg_20_0)
	if arg_20_0.stickerTimer_ then
		arg_20_0.stickerTimer_:Stop()

		arg_20_0.stickerTimer_ = nil
	end

	arg_20_0.stickerController_:SetSelectedState("hide")
	var_0_0.super.OnExit(arg_20_0)
end

function var_0_0.Dispose(arg_21_0)
	if arg_21_0.stickerItem_ then
		arg_21_0.stickerItem_:Dispose()

		arg_21_0.stickerItem_ = nil
	end

	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
