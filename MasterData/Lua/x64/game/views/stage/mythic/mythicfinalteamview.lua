local MythicFinalTeamView = class("MythicFinalTeamView", ReduxView)

function MythicFinalTeamView:UIName()
	return "Widget/System/Challenge_Mythic/MythicTeamToPrepareUI"
end

function MythicFinalTeamView:UIParent()
	return manager.ui.uiMain.transform
end

function MythicFinalTeamView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MythicFinalTeamView:InitUI()
	self:BindCfgUI()

	self.changehandler_ = handler(self, self.OnChangeBtnClick)
	self.confirmhandler_ = handler(self, self.OnConfirmBtnClick)
	self.changeindex_1 = 0
	self.changeindex_2 = 0
	self.controller_ = ControllerUtil.GetController(self.transform_, "isBattleIng")
	self.heroList_ = LuaList.New(handler(self, self.indexHeroList), self.uilistGo_, MythicFinalTeamViewItem)
end

function MythicFinalTeamView:OnChangeBtnClick(arg_5_1)
	if self.changeindex_1 == 0 then
		self.changeindex_1 = arg_5_1

		for iter_5_0, iter_5_1 in pairs((self.heroList_:GetItemList())) do
			iter_5_1:OnChangeRefreshStatus(arg_5_1)
		end

		SetActive(self.btn_resetGo_, false)
		SetActive(self.btn_warbeganGo_, false)
	else
		self:ResetStatus()
	end
end

function MythicFinalTeamView:OnConfirmBtnClick(arg_6_1)
	self.changeindex_2 = arg_6_1

	if self.changeindex_1 ~= 0 and self.changeindex_2 ~= 0 then
		ReserveTools.SwapTeam(ReserveConst.RESERVE_TYPE.MYTHIC_FINAL, ReserveConst.MYTHIC_CONT_ID.FINAL_MULTI, self.changeindex_1, self.changeindex_2)
		self.heroList_:StartScroll(self.times_)
	end

	self:ResetStatus()
end

function MythicFinalTeamView:ResetStatus()
	self.changeindex_1 = 0
	self.changeindex_2 = 0

	for iter_7_0, iter_7_1 in pairs((self.heroList_:GetItemList())) do
		iter_7_1:ResetState()
	end

	SetActive(self.btn_warbeganGo_, true)
	SetActive(self.btn_resetGo_, true)
end

function MythicFinalTeamView:indexHeroList(arg_8_1, arg_8_2)
	arg_8_2:RefreshUI(arg_8_1, self.battleList_[arg_8_1], #self.battleList_)
	arg_8_2:RegionHandler(self.changehandler_, self.confirmhandler_)
end

function MythicFinalTeamView:LaunchBattle()
	if not MythicData:CheckCanEnterMutiBattle(#MythicData:GetCurLevelIdList()) then
		ShowTips("ERROR_MULTIPLE_BATTLES_REQUIREMENT")

		return
	end

	local var_9_0 = {}

	for iter_9_0 = 1, self.times_ do
		var_9_0[iter_9_0] = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL, self.battleList_[iter_9_0], self.activityID_, (ReserveParams.New(ReserveConst.RESERVE_TYPE.MYTHIC_FINAL, ReserveConst.MYTHIC_CONT_ID.FINAL_MULTI, iter_9_0, {
			stageType = BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL,
			stageID = self.battleList_[iter_9_0],
			activityID = self.activityID_
		})))

		if iter_9_0 > 1 then
			var_9_0[iter_9_0 - 1]:SetNextStage(var_9_0[iter_9_0])
		end
	end

	BattleController.GetInstance():LaunchBattle(var_9_0[1])
end

function MythicFinalTeamView:ContinueBattle()
	local var_10_0 = {}

	for iter_10_0 = 1, self.times_ do
		var_10_0[iter_10_0] = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL, self.battleList_[iter_10_0], self.activityID_, (ReserveParams.New(ReserveConst.RESERVE_TYPE.MYTHIC_FINAL, ReserveConst.MYTHIC_CONT_ID.FINAL_MULTI, iter_10_0, {
			stageType = BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL,
			stageID = self.battleList_[iter_10_0],
			activityID = self.activityID_
		})))

		if iter_10_0 > 1 then
			var_10_0[iter_10_0 - 1]:SetNextStage(var_10_0[iter_10_0])
		end
	end

	BattleController.GetInstance():LaunchBattle(var_10_0[MythicData:GetCurBattleIndex()])
end

function MythicFinalTeamView:AddUIListener()
	self:AddBtnListener(self.btn_warbeganBtn_, nil, function()
		if MythicData:GetIsNew() then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				title = GetTips("PROMPT"),
				content = GetTips("MYTHIC_REFRESH_DATA"),
				OkCallback = function()
					JumpTools.OpenPageByJump("/mythicUltimateView/mythicDifficulty", nil)
				end
			})

			return
		end

		ReserveAction.SaveContData(ReserveConst.RESERVE_TYPE.MYTHIC_FINAL, ReserveConst.MYTHIC_CONT_ID.FINAL_MULTI, handler(self, self.LaunchBattle))
	end)
	self:AddBtnListener(self.btn_resetBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("MYTHIC_TEAM_RESET"),
			OkCallback = function()
				MythicAction.ReSetTeam(function()
					self.heroList_:StartScroll(self.times_)
				end)
			end
		})
	end)
	self:AddBtnListener(self.btn_restart_, nil, function()
		ShowMessageBox({
			content = GetTips("MYTHIC_PROCESS_RECORD"),
			OkCallback = function()
				MythicAction.QuitBattle()
			end
		})
	end)
	self:AddBtnListener(self.btn_continue_, nil, function()
		if MythicData:GetIsNew() then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				title = GetTips("PROMPT"),
				content = GetTips("MYTHIC_REFRESH_DATA"),
				OkCallback = function()
					JumpTools.OpenPageByJump("/mythicUltimateView/mythicDifficulty", nil)
				end
			})

			return
		end

		self:ContinueBattle()
	end)
end

function MythicFinalTeamView:OnMythicFinalQuitBattle()
	self:RefreshUIStatu()

	self.timeText_.text = manager.time:DescCdTime2((MythicData:GetCurTime()))
end

function MythicFinalTeamView:OnEnter()
	if MythicData:GetIsNew() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MYTHIC_REFRESH_DATA"),
			OkCallback = function()
				JumpTools.OpenPageByJump("/mythicUltimateView/mythicDifficulty", nil)
			end
		})

		return
	end

	self.times_ = #MythicData:GetCurLevelIdList()
	self.battleList_ = MythicData:GetCurLevelIdList()
	self.activityID_ = ActivityConst.MYTHIC_FINAL
	self.timeText_.text = manager.time:DescCdTime2((MythicData:GetCurTime()))

	self:RefreshUIStatu()
end

function MythicFinalTeamView:RefreshUIStatu()
	if MythicData:GetIsBattleIng() then
		self.controller_:SetSelectedState("true")

		self.battleText_.text = string.format(GetTips("MYTHIC_FINAL_BASTTLE_TIPS"), MythicData:GetCurHotLevelId()) .. GetTips("TEAM_" .. MythicData:GetCurBattleIndex())
	else
		self.controller_:SetSelectedState("false")
	end

	self.heroList_:Refresh()
end

function MythicFinalTeamView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if self.changeindex_1 ~= 0 then
			self:ResetStatus()
		else
			JumpTools.Back()
		end
	end)
	self.heroList_:StartScroll(self.times_)
end

function MythicFinalTeamView:OnExit()
	manager.windowBar:HideBar()
end

function MythicFinalTeamView:Dispose()
	if self.heroList_ then
		self.heroList_:Dispose()

		self.heroList_ = nil
	end

	self.changehandler_ = nil
	self.confirmhandler_ = nil

	MythicFinalTeamView.super.Dispose(self)
end

return MythicFinalTeamView
