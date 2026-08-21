local var_0_0 = class("IdolCompetitionResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Competition/IdolCompetitionMatchResultPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stageItemList_ = {}

	for iter_4_0 = 1, 3 do
		if arg_4_0["stage" .. iter_4_0 .. "Go_"] then
			arg_4_0.stageItemList_[iter_4_0] = IdolCompetitionResultItem.New(arg_4_0["stage" .. iter_4_0 .. "Go_"])
		end
	end

	arg_4_0.scoreList_ = {}

	for iter_4_1 = 1, 4 do
		arg_4_0.scoreList_[iter_4_1] = BackHomeCricketBattleResuleItem.New(arg_4_0["score" .. iter_4_1 .. "Go_"])
	end

	arg_4_0.leftPortrait_ = CommonHeadPortrait.New(arg_4_0.p1headGo_)
	arg_4_0.rightPortrait_ = CommonHeadPortrait.New(arg_4_0.p2headGo_)
	arg_4_0.winnerController_ = arg_4_0.mainControllerEx_:GetController("winner")
	arg_4_0.meTagController_ = arg_4_0.mainControllerEx_:GetController("meTag")
	arg_4_0.detailsController_ = arg_4_0.mainControllerEx_:GetController("details")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.closeBtn_, nil, function()
		arg_5_0:Back()
	end)

	for iter_5_0 = 1, 3 do
		if arg_5_0["info" .. iter_5_0 .. "Btn_"] then
			arg_5_0:AddBtnListener(arg_5_0["info" .. iter_5_0 .. "Btn_"], nil, function()
				arg_5_0:ShowStageScoreDetail(iter_5_0)
			end)
		end
	end

	arg_5_0:AddBtnListener(arg_5_0.infoCloseBtn_, nil, function()
		arg_5_0:ShowStageScoreDetail(0)
	end)
end

function var_0_0.OnEnter(arg_9_0)
	manager.windowBar:SwitchBar({})

	arg_9_0.raceActivityID_ = arg_9_0.params_.activity
	arg_9_0.racePhase_ = arg_9_0.params_.phase
	arg_9_0.raceIndex_ = arg_9_0.params_.index
	arg_9_0.battleRecordData_ = IdolCompetitionData:GetBattleDetailInfo(arg_9_0.raceActivityID_, arg_9_0.racePhase_, arg_9_0.raceIndex_)

	arg_9_0:UpdateView()
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateView(arg_11_0)
	arg_11_0:ShowStageScoreDetail(0)
	arg_11_0.winnerController_:SetSelectedState(arg_11_0.battleRecordData_.result == 1 and "left" or "right")

	local var_11_0 = IdolCompetitionData:GetRacePlayerInfo(arg_11_0.raceActivityID_, arg_11_0.battleRecordData_.player1ID)
	local var_11_1 = IdolCompetitionData:GetRacePlayerInfo(arg_11_0.raceActivityID_, arg_11_0.battleRecordData_.player2ID)

	if var_11_0.npc == 0 then
		arg_11_0.leftPortrait_:RenderHead(var_11_0.head)
		arg_11_0.leftPortrait_:RenderFrame(var_11_0.frame)
	else
		arg_11_0.leftPortrait_:RenderCustomSpriteHead("TextureConfig/BackHouseUI/IdolCompetitionNpcHead/" .. var_11_0.head)
		arg_11_0.leftPortrait_:RenderFrame(2001)
	end

	if var_11_0.npc == 0 and arg_11_0.battleRecordData_.player1ID ~= USER_ID then
		arg_11_0.leftPortrait_:RegisteClickCallback(function()
			ForeignInfoAction:TryToCheckForeignDetailInfo(arg_11_0.battleRecordData_.player1ID, true)
		end)
	else
		arg_11_0.leftPortrait_:RegisteClickCallback(nil)
	end

	if var_11_1.npc == 0 then
		arg_11_0.rightPortrait_:RenderHead(var_11_1.head)
		arg_11_0.rightPortrait_:RenderFrame(var_11_1.frame)
	else
		arg_11_0.rightPortrait_:RenderCustomSpriteHead("TextureConfig/BackHouseUI/IdolCompetitionNpcHead/" .. var_11_1.head)
		arg_11_0.rightPortrait_:RenderFrame(2001)
	end

	if var_11_1.npc == 0 and arg_11_0.battleRecordData_.player2ID ~= USER_ID then
		arg_11_0.rightPortrait_:RegisteClickCallback(function()
			ForeignInfoAction:TryToCheckForeignDetailInfo(arg_11_0.battleRecordData_.player2ID, true)
		end)
	else
		arg_11_0.rightPortrait_:RegisteClickCallback(nil)
	end

	arg_11_0.p1nameText_.text = var_11_0.name
	arg_11_0.p2nameText_.text = var_11_1.name
	arg_11_0.p1scoreText_.text = arg_11_0.battleRecordData_.player1Score
	arg_11_0.p2scoreText_.text = arg_11_0.battleRecordData_.player2Score

	if arg_11_0.battleRecordData_.player1ID == USER_ID then
		arg_11_0.meTagController_:SetSelectedState("left")
	elseif arg_11_0.battleRecordData_.player2ID == USER_ID then
		arg_11_0.meTagController_:SetSelectedState("right")
	else
		arg_11_0.meTagController_:SetSelectedState("none")
	end

	for iter_11_0 = 1, #arg_11_0.stageItemList_ do
		arg_11_0.stageItemList_[iter_11_0]:SetData(arg_11_0.battleRecordData_.battleData[iter_11_0])
	end
end

function var_0_0.ShowStageScoreDetail(arg_14_0, arg_14_1)
	if arg_14_1 == 0 then
		arg_14_0.detailsController_:SetSelectedState("off")
	elseif arg_14_1 == 1 or arg_14_1 == 2 or arg_14_1 == 3 then
		arg_14_0.detailsController_:SetSelectedState("on" .. arg_14_1)

		local var_14_0 = {
			totalNum = arg_14_0.battleRecordData_.battleData[arg_14_1].player1Info.score,
			peculiar = arg_14_0.battleRecordData_.battleData[arg_14_1].player1Info.advantage,
			skillAdd = arg_14_0.battleRecordData_.battleData[arg_14_1].player1Info.skillAdd,
			skillDec = arg_14_0.battleRecordData_.battleData[arg_14_1].player1Info.skillReduce
		}
		local var_14_1 = {
			totalNum = arg_14_0.battleRecordData_.battleData[arg_14_1].player2Info.score,
			peculiar = arg_14_0.battleRecordData_.battleData[arg_14_1].player2Info.advantage,
			skillAdd = arg_14_0.battleRecordData_.battleData[arg_14_1].player2Info.skillAdd,
			skillDec = arg_14_0.battleRecordData_.battleData[arg_14_1].player2Info.skillReduce
		}

		for iter_14_0 = 1, #arg_14_0.scoreList_ do
			local var_14_2 = {
				type = BackHomeCricketConst.SCORE_LIST[iter_14_0],
				attackData = var_14_0,
				defendData = var_14_1
			}

			arg_14_0.scoreList_[iter_14_0]:RefreshUI(var_14_2, true)
		end
	end
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)

	if arg_15_0.leftPortrait_ then
		arg_15_0.leftPortrait_:Dispose()

		arg_15_0.leftPortrait_ = nil
	end

	if arg_15_0.rightPortrait_ then
		arg_15_0.rightPortrait_:Dispose()

		arg_15_0.rightPortrait_ = nil
	end

	for iter_15_0 = 1, #arg_15_0.stageItemList_ do
		if arg_15_0.stageItemList_[iter_15_0] then
			arg_15_0.stageItemList_[iter_15_0]:Dispose()

			arg_15_0.stageItemList_[iter_15_0] = nil
		end
	end

	for iter_15_1 = 1, #arg_15_0.scoreList_ do
		if arg_15_0.scoreList_[iter_15_1] then
			arg_15_0.scoreList_[iter_15_1]:Dispose()

			arg_15_0.scoreList_[iter_15_1] = nil
		end
	end
end

return var_0_0
