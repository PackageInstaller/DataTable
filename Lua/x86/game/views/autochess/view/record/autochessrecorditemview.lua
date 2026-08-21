local var_0_0 = class("AutoChessBattleView", ReduxView)

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
	arg_3_0:InitController()
	arg_3_0:AddUIListener()

	arg_3_0.formationView_ = AutoChessFormationItemView.New(arg_3_0.foremationGo_)
	arg_3_0.chessItemList_ = {}
	arg_3_0.clickChessHandler_ = handler(arg_3_0, arg_3_0.OnClickChess)
end

function var_0_0.InitController(arg_4_0)
	arg_4_0.typeController_ = arg_4_0.controllerEx_:GetController("type")
	arg_4_0.statusController_ = arg_4_0.controllerEx_:GetController("status")
	arg_4_0.iconController1001_ = arg_4_0.controller1001_:GetController("state")
	arg_4_0.iconController1002_ = arg_4_0.controller1002_:GetController("state")
	arg_4_0.iconController1003_ = arg_4_0.controller1003_:GetController("state")
	arg_4_0.iconController1004_ = arg_4_0.controller1004_:GetController("state")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.scoreDetailBtn_, nil, handler(arg_5_0, arg_5_0.OnClickSocreDetail))
	arg_5_0:AddBtnListener(arg_5_0.badgeBtn_, nil, function()
		if arg_5_0.medalClickHandler then
			arg_5_0.medalClickHandler()
		end

		JumpTools.OpenPageByJump("autoChessMedalInfoView", {
			id = arg_5_0.recordItemData_.medalId,
			medalLevel = AutoChessData.MedalCategory.Advanced
		})
		OperationRecorder.RecordButtonTouch({
			source = 2,
			button_name = "activity_autochess_achie_touch",
			activity_id = AutoChessData:GetActivityID()
		})
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.scrollView_ = arg_7_2
	arg_7_0.recordItemData_ = arg_7_1
	arg_7_0.playerData_ = arg_7_0.recordItemData_.playerData

	arg_7_0:UpdateUI()
end

function var_0_0.UpdateUI(arg_8_0)
	arg_8_0:UpdateType()
	arg_8_0:UpdateStatus()
	arg_8_0:UpdateChessList()
	arg_8_0:UpdateScore()
	arg_8_0:UpdatePlayerInfo()
	arg_8_0:UpdateMedal()
	arg_8_0:UpdateTimestamp()
	arg_8_0:UpdateRank()
end

function var_0_0.UpdateType(arg_9_0)
	if arg_9_0.recordItemData_.type == AutoChessConst.RECORD_TYPE.PVP_4_8_ONLINE then
		arg_9_0.typeController_:SetSelectedIndex(2)
	elseif arg_9_0.recordItemData_.type == AutoChessConst.RECORD_TYPE.PVP_4_8 then
		arg_9_0.typeController_:SetSelectedIndex(0)
	else
		arg_9_0.typeController_:SetSelectedIndex(arg_9_0.recordItemData_.type)
	end
end

function var_0_0.UpdateRank(arg_10_0)
	arg_10_0.txtRank_.text = "NO." .. arg_10_0.recordItemData_.rank

	local var_10_0, var_10_1 = AutoChessTools.GetRankLevelCfg(arg_10_0.recordItemData_.newRankScore)

	arg_10_0.txtRankName_.text = var_10_0.name

	local var_10_2 = arg_10_0.recordItemData_.newRankScore - arg_10_0.recordItemData_.oldRankScore

	arg_10_0.txtAddScore_.text = var_10_2 >= 0 and "+" .. tostring(var_10_2) or tostring(var_10_2)

	if var_10_0.rank_level ~= 0 then
		SetActive(arg_10_0.rankLevelGo_, true)

		arg_10_0.txtRankLevel_.text = NumberTools.IntToRomam(var_10_0.rank_level)
	else
		SetActive(arg_10_0.rankLevelGo_, false)
	end

	arg_10_0.rankImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. var_10_0.icon)
end

function var_0_0.UpdateStatus(arg_11_0)
	if arg_11_0.playerData_.curRoundCount == arg_11_0.playerData_.victoryRoundCount and arg_11_0.recordItemData_.isWin then
		arg_11_0.statusController_:SetSelectedState("perfectWin")
	else
		arg_11_0.statusController_:SetSelectedState("win")
	end
end

function var_0_0.UpdateChessList(arg_12_0)
	local var_12_0 = arg_12_0.playerData_.chessDataDicByUniqueId
	local var_12_1 = {}

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		table.insert(var_12_1, iter_12_1)
	end

	table.sort(var_12_1, function(arg_13_0, arg_13_1)
		return arg_13_0.index < arg_13_1.index
	end)

	local var_12_2 = GameSetting.auto_chess_prepare_grid_num.value[1]

	for iter_12_2 = 1, var_12_2 do
		local var_12_3 = var_12_1[iter_12_2]
		local var_12_4 = arg_12_0.chessItemList_[iter_12_2]

		if var_12_3 then
			if var_12_4 == nil then
				local var_12_5 = Object.Instantiate(arg_12_0.chessItemGo_, arg_12_0.chessItemGo_.transform.parent)

				var_12_4 = AutoChessTeamItem.New(var_12_5)
				arg_12_0.chessItemList_[iter_12_2] = var_12_4
			end

			var_12_4:SetActive(true)
			var_12_4:SetParent(arg_12_0.formationView_:GetChessPanelTrans())
			var_12_4:SetLocalScale(Vector3.one)
			var_12_4:SetLocalPos(arg_12_0.formationView_:GetChessPos(var_12_3.index))
			var_12_4:SetData(var_12_3)
			var_12_4:RegisterEvent("PointerClick", arg_12_0.clickChessHandler_)
			var_12_4:RegisterEvent("BeginDrag", handler(arg_12_0, arg_12_0.OnBeginDrag))
			var_12_4:RegisterEvent("EndDrag", handler(arg_12_0, arg_12_0.OnEndDrag))
			var_12_4:RegisterEvent("Drag", handler(arg_12_0, arg_12_0.OnDrag))
		elseif var_12_4 ~= nil then
			var_12_4:SetActive(false)
			var_12_4:SetData(nil)
		end
	end
end

function var_0_0.OnBeginDrag(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.scrollView_:OnBeginDrag(arg_14_2)
end

function var_0_0.OnEndDrag(arg_15_0, arg_15_1)
	arg_15_0.scrollView_:OnEndDrag(arg_15_1)
end

function var_0_0.OnDrag(arg_16_0, arg_16_1)
	arg_16_0.scrollView_:OnDrag(arg_16_1)
end

function var_0_0.UpdateScore(arg_17_0)
	arg_17_0.socreText_.text = arg_17_0.recordItemData_.score
end

function var_0_0.UpdatePlayerInfo(arg_18_0)
	arg_18_0.hpText_.text = arg_18_0.playerData_.hp
	arg_18_0.roundText_.text = arg_18_0.playerData_.curRoundCount
	arg_18_0.trophyText_.text = arg_18_0.playerData_.victoryRoundCount
end

function var_0_0.UpdateTimestamp(arg_19_0)
	arg_19_0.timeText_.text = manager.time:DescCTime(arg_19_0.recordItemData_.timestamp, "%Y-%m-%d %H:%M")
end

function var_0_0.UpdateMedal(arg_20_0)
	local var_20_0 = arg_20_0.recordItemData_.medalId

	for iter_20_0, iter_20_1 in ipairs(AutoChessMedalCfg.all) do
		if iter_20_1 == var_20_0 then
			SetActive(arg_20_0["controller" .. iter_20_1 .. "_"].gameObject, true)
		else
			SetActive(arg_20_0["controller" .. iter_20_1 .. "_"].gameObject, false)
		end
	end

	if arg_20_0.recordItemData_.type == AutoChessConst.RECORD_TYPE.GLORY then
		arg_20_0["iconController" .. var_20_0 .. "_"]:SetSelectedState("03")
	end
end

function var_0_0.OnClickSocreDetail(arg_21_0)
	manager.notify:Invoke(AUTO_CHESS_RECORD_SCORE_DETAIL_CLICK, arg_21_0)
	OperationRecorder.RecordButtonTouch({
		button_name = "activity_autochess_record_score_touch",
		activity_id = AutoChessData:GetActivityID(),
		score = arg_21_0.recordItemData_.score,
		type = arg_21_0.recordItemData_.type == 1 and 1 or 2
	})
end

function var_0_0.OnClickChess(arg_22_0, arg_22_1, arg_22_2)
	manager.notify:Invoke(AUTO_CHESS_RECORD_CHESS_CLICK, arg_22_1, arg_22_2)
	OperationRecorder.RecordButtonTouch({
		button_name = "activity_autochess_record_chess_touch",
		activity_id = AutoChessData:GetActivityID(),
		other_data = AutoChessTools.GetChessTrackingPointStr(arg_22_1),
		polyhedron_id_str = arg_22_0.playerData_.battleUID or AutoChessData:GetPrepareData():GetUUID()
	})
end

function var_0_0.SetMedalClickHandler(arg_23_0, arg_23_1)
	arg_23_0.medalClickHandler = arg_23_1
end

function var_0_0.Dispose(arg_24_0)
	arg_24_0.formationView_:Dispose()

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.chessItemList_) do
		iter_24_1:Dispose()
	end

	var_0_0.super.Dispose(arg_24_0)
end

return var_0_0
