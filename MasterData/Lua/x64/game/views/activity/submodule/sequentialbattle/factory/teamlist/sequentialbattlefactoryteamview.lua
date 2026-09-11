local SequentialBattleFactoryTeamView = class("SequentialBattleFactoryTeamView", ReduxView)

function SequentialBattleFactoryTeamView:UIName()
	return SequentialBattleUICfg[SequentialBattleUICfg.get_id_list_by_main_activity_id[SequentialBattleChapterCfg[self.params_.activityID].main_id][1]].team_prefab
end

function SequentialBattleFactoryTeamView:UIParent()
	return manager.ui.uiMain.transform
end

function SequentialBattleFactoryTeamView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.teamUIList_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, SequentialBattleFactoryTeamItem)
	self.needContinueController_ = self.controllerEx_:GetController("needContinue")
	self.finishControllerEx_ = {}

	for iter_3_0 = 1, 4 do
		table.insert(self.finishControllerEx_, self[string.format("finishStateControllerEx%s_", iter_3_0)]:GetController("finish"))
	end
end

function SequentialBattleFactoryTeamView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.activityID_ = self.params_.activityID

	self:RefreshUI()
end

function SequentialBattleFactoryTeamView:OnExit()
	manager.windowBar:HideBar()
end

function SequentialBattleFactoryTeamView:Dispose()
	SequentialBattleFactoryTeamView.super.Dispose(self)
	self.teamUIList_:Dispose()

	self.teamUIList_ = nil
end

function SequentialBattleFactoryTeamView:AddListeners()
	self:AddBtnListener(self.buffBtn_, nil, function()
		JumpTools.OpenPageByJump("sequentialBattleBuffInfo", {
			buffInfoActivityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.resetBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("SEQUENTIAL_BATTLE_RESET_TEAM"),
			OkCallback = function()
				SequentialBattleAction.ResetBattle(self.activityID_, 0, function(arg_11_0)
					SequentialBattleData:ResetChapterTeamData(self.activityID_)
					ReserveTools.ResetContData(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, self.activityID_)
					self:RefreshUI()
				end)
			end
		})
	end)
	self:AddBtnListener(self.exitBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("SEQUENTIAL_BATTLE_EXIT"),
			OkCallback = function()
				SequentialBattleAction.ResetBattle(self.activityID_, 1, function(arg_14_0)
					SequentialBattleData:ResetChapterTeamData(self.activityID_)
					self:RefreshUI()
				end)
			end
		})
	end)
	self:AddBtnListener(self.battleBtn_, nil, function()
		for iter_15_0 = 1, #SequentialBattleChapterCfg[self.activityID_].stage_id do
			if ReserveTools.GetHeroList((ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, self.activityID_, iter_15_0, {
				stageType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
				stageID = SequentialBattleChapterCfg[self.activityID_].stage_id[iter_15_0],
				activityID = self.activityID_
			})))[1] == 0 then
				ShowTips("SEQUENTIAL_BATTLE_TEAM_IS_NULL")

				return
			end
		end

		SequentialBattleAction.SaveAllTeam(self.activityID_, function(arg_16_0)
			if isSuccess(arg_16_0.result) then
				local var_16_0 = SequentialBattleData:GetCurrentFinishStageIndex(self.activityID_) + 1

				BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE, SequentialBattleChapterCfg[self.activityID_].stage_id[var_16_0], self.activityID_, (ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, self.activityID_, var_16_0, {
					stageType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
					stageID = SequentialBattleChapterCfg[self.activityID_].stage_id[var_16_0],
					activityID = self.activityID_
				})))))
			else
				ShowTips(arg_16_0.result)
			end
		end)
	end)
end

function SequentialBattleFactoryTeamView:RefreshItem(arg_17_1, arg_17_2)
	arg_17_2:SetData(self.activityID_, arg_17_1)
end

function SequentialBattleFactoryTeamView:RefreshUI()
	self.teamUIList_:StartScroll(#SequentialBattleChapterCfg[self.activityID_].stage_id, SequentialBattleData:GetCurrentFinishStageIndex(self.activityID_) + 1)
	self:RefreshContinuePanel()
end

function SequentialBattleFactoryTeamView:RefreshContinuePanel()
	local var_19_0 = SequentialBattleData:GetCurrentFinishStageIndex(self.activityID_)

	if var_19_0 > 0 then
		self.needContinueController_:SetSelectedState("true")

		for iter_19_0 = 1, 4 do
			if iter_19_0 <= var_19_0 then
				self.finishControllerEx_[iter_19_0]:SetSelectedState("true")
			else
				self.finishControllerEx_[iter_19_0]:SetSelectedState("false")
			end
		end
	else
		self.needContinueController_:SetSelectedState("false")
	end
end

return SequentialBattleFactoryTeamView
