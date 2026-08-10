local var_0_0 = class("AutoChessScoreBoardPopItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.isShowChess_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.colorController_ = arg_3_0.controllerEx_:GetController("color")
	arg_3_0.tipsController_ = arg_3_0.controllerEx_:GetController("tips")
	arg_3_0.btnAddFriendController_ = arg_3_0.controllerEx_:GetController("btnAddFriend")
	arg_3_0.rankStatController_ = arg_3_0.controllerEx_:GetController("rankStatus")
	arg_3_0.formationView_ = AutoChessFormationItemView.New(arg_3_0.formationGo_)
	arg_3_0.chessItemList_ = {}
	arg_3_0.clickChessHandler_ = handler(arg_3_0, arg_3_0.OnClickChess)
	arg_3_0.commonPortrait_ = CommonHeadPortrait.New(arg_3_0.headItem_)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.scoreBoardData_ = arg_4_1
	arg_4_0.scrollView_ = arg_4_2
	arg_4_0.isShowRankChange_ = arg_4_3
	arg_4_0.playerData_ = arg_4_0.scoreBoardData_.playerData

	arg_4_0:UpdateUI()
end

function var_0_0.UpdateUI(arg_5_0)
	arg_5_0:UpdateStatus()
	arg_5_0:UpdateChessList()
	arg_5_0:UpdatePlayerInfo()
end

function var_0_0.UpdateStatus(arg_6_0)
	if arg_6_0.playerData_.hp > 0 then
		arg_6_0.colorController_:SetSelectedState(arg_6_0.scoreBoardData_.isSelf and "orange" or "blue")
	else
		arg_6_0.colorController_:SetSelectedState("grey")
	end
end

function var_0_0.UpdateChessList(arg_7_0)
	if not arg_7_0.playerData_.chessDataDicByUniqueId then
		return
	end

	local var_7_0 = arg_7_0.playerData_.chessDataDicByUniqueId
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		table.insert(var_7_1, iter_7_1)
	end

	table.sort(var_7_1, function(arg_8_0, arg_8_1)
		return arg_8_0.index < arg_8_1.index
	end)

	local var_7_2 = GameSetting.auto_chess_prepare_grid_num.value[1]

	for iter_7_2 = 1, var_7_2 do
		local var_7_3 = var_7_1[iter_7_2]
		local var_7_4 = arg_7_0.chessItemList_[iter_7_2]

		if var_7_3 then
			if var_7_4 == nil then
				local var_7_5 = Object.Instantiate(arg_7_0.chessItemGo_, arg_7_0.formationView_:GetChessPanelTrans())

				var_7_4 = AutoChessSimpleItem.New(var_7_5)
				arg_7_0.chessItemList_[iter_7_2] = var_7_4
			end

			local var_7_6 = arg_7_0.scoreBoardData_.isSelf and var_7_3.index or var_7_2 - var_7_3.index + 1

			var_7_4:SetActive(true)
			var_7_4:SetLocalScale(Vector3.one)
			var_7_4:SetLocalPos(arg_7_0.formationView_:GetChessPos(var_7_6))
			var_7_4:SetPlayerType(arg_7_0.scoreBoardData_.isSelf and AutoChessConst.PLAYER_TYPE.SELF or AutoChessConst.PLAYER_TYPE.OPPONENT)
			var_7_4:SetAppearance(arg_7_0.playerData_.sunglassFlag, arg_7_0.playerData_.chessSkinList_[var_7_3.chessId])
			var_7_4:SetData(var_7_3)
			var_7_4:RegisterEvent("PointerClick", arg_7_0.clickChessHandler_)
			var_7_4:RegisterEvent("BeginDrag", handler(arg_7_0, arg_7_0.OnBeginDrag))
			var_7_4:RegisterEvent("EndDrag", handler(arg_7_0, arg_7_0.OnEndDrag))
			var_7_4:RegisterEvent("Drag", handler(arg_7_0, arg_7_0.OnDrag))
		elseif var_7_4 ~= nil then
			var_7_4:SetActive(false)
			var_7_4:SetData(nil)
		end
	end
end

function var_0_0.UpdateTipsState(arg_9_0, arg_9_1)
	arg_9_0.tipsController_:SetSelectedState(arg_9_1 and "on" or "off")
end

function var_0_0.OnBeginDrag(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.scrollView_:OnBeginDrag(arg_10_2)
end

function var_0_0.OnEndDrag(arg_11_0, arg_11_1)
	arg_11_0.scrollView_:OnEndDrag(arg_11_1)
end

function var_0_0.OnDrag(arg_12_0, arg_12_1)
	arg_12_0.scrollView_:OnDrag(arg_12_1)
end

function var_0_0.UpdatePlayerInfo(arg_13_0)
	if arg_13_0.scoreBoardData_.oldRankIndex and arg_13_0.isShowRankChange_ then
		local var_13_0 = arg_13_0.scoreBoardData_.oldRankIndex - arg_13_0.scoreBoardData_.rankIndex

		if var_13_0 == 0 then
			arg_13_0.rankStatController_:SetSelectedState("draw")

			arg_13_0.rankChangeText_.text = "--"
		elseif var_13_0 > 0 then
			arg_13_0.rankStatController_:SetSelectedState("up")

			arg_13_0.rankChangeText_.text = var_13_0
		else
			arg_13_0.rankStatController_:SetSelectedState("down")

			arg_13_0.rankChangeText_.text = math.abs(var_13_0)
		end
	else
		arg_13_0.rankStatController_:SetSelectedState("hide")
	end

	arg_13_0.indexText_.text = tostring(arg_13_0.scoreBoardData_.rankIndex)
	arg_13_0.playerNameText_.text = arg_13_0.scoreBoardData_.name

	arg_13_0.commonPortrait_:RenderHead(arg_13_0.scoreBoardData_.icon)
	arg_13_0.commonPortrait_:ChangeFrameActive(true)
	arg_13_0.commonPortrait_:RenderFrame(arg_13_0.scoreBoardData_.iconFrame)

	arg_13_0.hpText_.text = arg_13_0.playerData_.hp
	arg_13_0.trophyText_.text = arg_13_0.playerData_.victoryRoundCount
end

function var_0_0.OnClickChess(arg_14_0, arg_14_1, arg_14_2)
	manager.notify:Invoke("AUTO_CHESS_SCORE_BOARD_CHESS_CLICK", arg_14_1, arg_14_2)
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.formationView_ then
		arg_15_0.formationView_:Dispose()
	end

	arg_15_0.formationView_ = nil

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.chessItemList_) do
		iter_15_1:Dispose()
	end

	arg_15_0.chessItemList_ = {}

	if arg_15_0.commonPortrait_ then
		arg_15_0.commonPortrait_:Dispose()

		arg_15_0.commonPortrait_ = nil
	end

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
