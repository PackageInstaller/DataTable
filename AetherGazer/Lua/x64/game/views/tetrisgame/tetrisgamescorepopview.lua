local var_0_0 = class("TetrisGameScorePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_TetrisGameUI/TetrisGameResultUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()

	arg_4_0.stateController = arg_4_0.controller:GetController("state")
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.activityID = TetrisGameData:GetCurActivityID()
	arg_6_0.stageID = arg_6_0.params_.stageID

	arg_6_0:RefreshView()

	local var_6_0 = TetrisGameRunTimeManager:GetBlackBoard()

	if ActivityTetrisGameStageCfg[arg_6_0.stageID].type ~= TetrisGameConst.stageType.endLess then
		if var_6_0.resultFlag then
			manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter", "")
			manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_bingo", "")
		else
			manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_fail", "")
			manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_error", "")
		end
	end
end

function var_0_0.OnTop(arg_7_0)
	arg_7_0:RefreshView()
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
	arg_8_0:RemoveAllEventListener()
end

function var_0_0.GetNextID(arg_9_0)
	local var_9_0 = ActivityTetrisGameChapterCfg.get_id_list_by_tetris_stage_list[arg_9_0.stageID][1]
	local var_9_1 = ActivityTetrisGameChapterCfg[var_9_0].tetris_stage_list

	return var_9_1[table.indexof(var_9_1, arg_9_0.stageID) + 1]
end

function var_0_0.AddUIListener(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.nextBtn_, nil, function()
		if arg_10_0.stageID then
			TetrisGameRunTimeManager:ExitGame()
			arg_10_0:Back()

			local var_11_0 = arg_10_0:GetNextID()

			TetrisGameTools:EnterStage(var_11_0)
		end
	end)
	arg_10_0:AddBtnListener(arg_10_0.restart, nil, function()
		if arg_10_0.stageID then
			TetrisGameRunTimeManager:ExitGame()
			arg_10_0:Back()
			TetrisGameTools:EnterStage(arg_10_0.stageID)
		end
	end)
	arg_10_0:AddBtnListener(arg_10_0.confirm, nil, function()
		local var_13_0 = TetrisGameRunTimeManager:GetBlackBoard()

		TetrisGameRunTimeManager:ExitGame()

		if ActivityTetrisGameStageCfg[arg_10_0.stageID].type == TetrisGameConst.stageType.endLess then
			JumpTools.OpenPageByJump("/tetrisGameSkillView")
		else
			local var_13_1 = arg_10_0.stageID
			local var_13_2 = ActivityTetrisGameChapterCfg.get_id_list_by_tetris_stage_list[arg_10_0.stageID][1]

			if var_13_0.resultFlag then
				local var_13_3 = ActivityTetrisGameChapterCfg[var_13_2].tetris_stage_list

				for iter_13_0, iter_13_1 in ipairs(var_13_3) do
					local var_13_4 = TetrisGameData:GetStageInfoByStageID(iter_13_1)

					if var_13_4 and var_13_4.isClear == false then
						var_13_1 = iter_13_1

						break
					end
				end
			end

			local var_13_5 = arg_10_0:GetNextID()
			local var_13_6 = arg_10_0.params_ and arg_10_0.params_.first_clear or false

			if not var_13_5 and var_13_6 then
				JumpTools.OpenPageByJump("/tetrisGameMainView")
			else
				JumpTools.OpenPageByJump("/tetrisGameChooseStageView", {
					chapterID = var_13_2,
					stageID = var_13_1
				})
			end
		end
	end)
end

function var_0_0.RefreshView(arg_14_0)
	local var_14_0 = TetrisGameRunTimeManager:GetBlackBoard()

	arg_14_0.score.text = var_14_0.totalScore
	arg_14_0.roundNum.text = var_14_0.usedRound

	if ActivityTetrisGameStageCfg[arg_14_0.stageID].type == TetrisGameConst.stageType.endLess then
		arg_14_0.stateController:SetSelectedState("endLess")
		SetActive(arg_14_0.nextBtn_, false)
		SetActive(arg_14_0.restart, true)
	elseif var_14_0.resultFlag then
		SetActive(arg_14_0.restart, false)
		arg_14_0.stateController:SetSelectedState("win")

		local var_14_1 = arg_14_0:GetNextID()
		local var_14_2 = false

		if var_14_1 then
			var_14_2 = TetrisGameTools:CheckStageIsOpen(var_14_1)
		end

		if var_14_2 then
			SetActive(arg_14_0.nextBtn_, true)
		else
			SetActive(arg_14_0.nextBtn_, false)
		end
	else
		arg_14_0.stateController:SetSelectedState("lose")
		SetActive(arg_14_0.nextBtn_, false)
		SetActive(arg_14_0.restart, true)
	end
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
