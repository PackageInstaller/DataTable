local TetrisGameScorePopView = class("TetrisGameScorePopView", ReduxView)

function TetrisGameScorePopView:UIName()
	return "Widget/Version/Alone_TetrisGameUI/TetrisGameResultUI"
end

function TetrisGameScorePopView:UIParent()
	return manager.ui.uiPop.transform
end

function TetrisGameScorePopView:OnCtor()
	return
end

function TetrisGameScorePopView:Init()
	self:InitUI()
	self:AddUIListener()

	self.stateController = self.controller:GetController("state")
end

function TetrisGameScorePopView:InitUI()
	self:BindCfgUI()
end

function TetrisGameScorePopView:OnEnter()
	self.activityID = TetrisGameData:GetCurActivityID()
	self.stageID = self.params_.stageID

	self:RefreshView()

	if ActivityTetrisGameStageCfg[self.stageID].type ~= TetrisGameConst.stageType.endLess then
		if TetrisGameRunTimeManager:GetBlackBoard().resultFlag then
			manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter", "")
			manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_bingo", "")
		else
			manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_fail", "")
			manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_error", "")
		end
	end
end

function TetrisGameScorePopView:OnTop()
	self:RefreshView()
end

function TetrisGameScorePopView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function TetrisGameScorePopView:GetNextID()
	return ActivityTetrisGameChapterCfg[ActivityTetrisGameChapterCfg.get_id_list_by_tetris_stage_list[self.stageID][1]].tetris_stage_list[table.indexof(ActivityTetrisGameChapterCfg[ActivityTetrisGameChapterCfg.get_id_list_by_tetris_stage_list[self.stageID][1]].tetris_stage_list, self.stageID) + 1]
end

function TetrisGameScorePopView:AddUIListener()
	self:AddBtnListener(self.nextBtn_, nil, function()
		if self.stageID then
			TetrisGameRunTimeManager:ExitGame()
			self:Back()
			TetrisGameTools:EnterStage((self:GetNextID()))
		end
	end)
	self:AddBtnListener(self.restart, nil, function()
		if self.stageID then
			TetrisGameRunTimeManager:ExitGame()
			self:Back()
			TetrisGameTools:EnterStage(self.stageID)
		end
	end)
	self:AddBtnListener(self.confirm, nil, function()
		TetrisGameRunTimeManager:ExitGame()

		if ActivityTetrisGameStageCfg[self.stageID].type == TetrisGameConst.stageType.endLess then
			JumpTools.OpenPageByJump("/tetrisGameSkillView")
		else
			local var_13_0 = self.stageID
			local var_13_1 = ActivityTetrisGameChapterCfg.get_id_list_by_tetris_stage_list[self.stageID][1]

			if TetrisGameRunTimeManager:GetBlackBoard().resultFlag then
				for iter_13_0, iter_13_1 in ipairs(ActivityTetrisGameChapterCfg[var_13_1].tetris_stage_list) do
					local var_13_2 = TetrisGameData:GetStageInfoByStageID(iter_13_1)

					if var_13_2 and var_13_2.isClear == false then
						var_13_0 = iter_13_1

						break
					end
				end
			end

			if self.params_ then
				if not self:GetNextID() and (self.params_.first_clear or false) then
					JumpTools.OpenPageByJump("/tetrisGameMainView")

					goto label_13_0
				end
			end

			JumpTools.OpenPageByJump("/tetrisGameChooseStageView", {
				chapterID = var_13_1,
				stageID = var_13_0
			})
		end

		::label_13_0::
	end)
end

function TetrisGameScorePopView:RefreshView()
	local var_14_0 = TetrisGameRunTimeManager:GetBlackBoard()

	self.score.text = var_14_0.totalScore
	self.roundNum.text = var_14_0.usedRound

	if ActivityTetrisGameStageCfg[self.stageID].type == TetrisGameConst.stageType.endLess then
		self.stateController:SetSelectedState("endLess")
		SetActive(self.nextBtn_, false)
		SetActive(self.restart, true)
	elseif var_14_0.resultFlag then
		SetActive(self.restart, false)
		self.stateController:SetSelectedState("win")

		local var_14_1 = self:GetNextID()

		if (var_14_1 or nil) and TetrisGameTools:CheckStageIsOpen(var_14_1) then
			SetActive(self.nextBtn_, true)
		else
			SetActive(self.nextBtn_, false)
		end
	else
		self.stateController:SetSelectedState("lose")
		SetActive(self.nextBtn_, false)
		SetActive(self.restart, true)
	end
end

function TetrisGameScorePopView:Dispose()
	TetrisGameScorePopView.super.Dispose(self)
end

return TetrisGameScorePopView
