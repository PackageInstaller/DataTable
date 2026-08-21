local var_0_0 = class("MythicFinalTeamView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Mythic/MythicTeamToPrepareUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.changehandler_ = handler(arg_4_0, arg_4_0.OnChangeBtnClick)
	arg_4_0.confirmhandler_ = handler(arg_4_0, arg_4_0.OnConfirmBtnClick)
	arg_4_0.changeindex_1 = 0
	arg_4_0.changeindex_2 = 0
	arg_4_0.controller_ = ControllerUtil.GetController(arg_4_0.transform_, "isBattleIng")
	arg_4_0.heroList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexHeroList), arg_4_0.uilistGo_, MythicFinalTeamViewItem)
end

function var_0_0.OnChangeBtnClick(arg_5_0, arg_5_1)
	if arg_5_0.changeindex_1 == 0 then
		arg_5_0.changeindex_1 = arg_5_1

		local var_5_0 = arg_5_0.heroList_:GetItemList()

		for iter_5_0, iter_5_1 in pairs(var_5_0) do
			iter_5_1:OnChangeRefreshStatus(arg_5_1)
		end

		SetActive(arg_5_0.btn_resetGo_, false)
		SetActive(arg_5_0.btn_warbeganGo_, false)
	else
		arg_5_0:ResetStatus()
	end
end

function var_0_0.OnConfirmBtnClick(arg_6_0, arg_6_1)
	arg_6_0.changeindex_2 = arg_6_1

	if arg_6_0.changeindex_1 ~= 0 and arg_6_0.changeindex_2 ~= 0 then
		ReserveTools.SwapTeam(ReserveConst.RESERVE_TYPE.MYTHIC_FINAL, ReserveConst.MYTHIC_CONT_ID.FINAL_MULTI, arg_6_0.changeindex_1, arg_6_0.changeindex_2)
		arg_6_0.heroList_:StartScroll(arg_6_0.times_)
	end

	arg_6_0:ResetStatus()
end

function var_0_0.ResetStatus(arg_7_0)
	arg_7_0.changeindex_1 = 0
	arg_7_0.changeindex_2 = 0

	local var_7_0 = arg_7_0.heroList_:GetItemList()

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		iter_7_1:ResetState()
	end

	SetActive(arg_7_0.btn_warbeganGo_, true)
	SetActive(arg_7_0.btn_resetGo_, true)
end

function var_0_0.indexHeroList(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:RefreshUI(arg_8_1, arg_8_0.battleList_[arg_8_1], #arg_8_0.battleList_)
	arg_8_2:RegionHandler(arg_8_0.changehandler_, arg_8_0.confirmhandler_)
end

function var_0_0.LaunchBattle(arg_9_0)
	if not MythicData:CheckCanEnterMutiBattle(#MythicData:GetCurLevelIdList()) then
		ShowTips("ERROR_MULTIPLE_BATTLES_REQUIREMENT")

		return
	end

	local var_9_0 = {}

	for iter_9_0 = 1, arg_9_0.times_ do
		local var_9_1 = ReserveParams.New(ReserveConst.RESERVE_TYPE.MYTHIC_FINAL, ReserveConst.MYTHIC_CONT_ID.FINAL_MULTI, iter_9_0, {
			stageType = BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL,
			stageID = arg_9_0.battleList_[iter_9_0],
			activityID = arg_9_0.activityID_
		})

		var_9_0[iter_9_0] = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL, arg_9_0.battleList_[iter_9_0], arg_9_0.activityID_, var_9_1)

		if iter_9_0 > 1 then
			var_9_0[iter_9_0 - 1]:SetNextStage(var_9_0[iter_9_0])
		end
	end

	BattleController.GetInstance():LaunchBattle(var_9_0[1])
end

function var_0_0.ContinueBattle(arg_10_0)
	local var_10_0 = {}

	for iter_10_0 = 1, arg_10_0.times_ do
		local var_10_1 = ReserveParams.New(ReserveConst.RESERVE_TYPE.MYTHIC_FINAL, ReserveConst.MYTHIC_CONT_ID.FINAL_MULTI, iter_10_0, {
			stageType = BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL,
			stageID = arg_10_0.battleList_[iter_10_0],
			activityID = arg_10_0.activityID_
		})

		var_10_0[iter_10_0] = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL, arg_10_0.battleList_[iter_10_0], arg_10_0.activityID_, var_10_1)

		if iter_10_0 > 1 then
			var_10_0[iter_10_0 - 1]:SetNextStage(var_10_0[iter_10_0])
		end
	end

	BattleController.GetInstance():LaunchBattle(var_10_0[MythicData:GetCurBattleIndex()])
end

function var_0_0.AddUIListener(arg_11_0)
	arg_11_0:AddBtnListener(arg_11_0.btn_warbeganBtn_, nil, function()
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

		ReserveAction.SaveContData(ReserveConst.RESERVE_TYPE.MYTHIC_FINAL, ReserveConst.MYTHIC_CONT_ID.FINAL_MULTI, handler(arg_11_0, arg_11_0.LaunchBattle))
	end)
	arg_11_0:AddBtnListener(arg_11_0.btn_resetBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("MYTHIC_TEAM_RESET"),
			OkCallback = function()
				MythicAction.ReSetTeam(function()
					arg_11_0.heroList_:StartScroll(arg_11_0.times_)
				end)
			end
		})
	end)
	arg_11_0:AddBtnListener(arg_11_0.btn_restart_, nil, function()
		ShowMessageBox({
			content = GetTips("MYTHIC_PROCESS_RECORD"),
			OkCallback = function()
				MythicAction.QuitBattle()
			end
		})
	end)
	arg_11_0:AddBtnListener(arg_11_0.btn_continue_, nil, function()
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

		arg_11_0:ContinueBattle()
	end)
end

function var_0_0.OnMythicFinalQuitBattle(arg_21_0)
	arg_21_0:RefreshUIStatu()

	local var_21_0 = MythicData:GetCurTime()

	arg_21_0.timeText_.text = manager.time:DescCdTime2(var_21_0)
end

function var_0_0.OnEnter(arg_22_0)
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

	arg_22_0.times_ = #MythicData:GetCurLevelIdList()
	arg_22_0.battleList_ = MythicData:GetCurLevelIdList()
	arg_22_0.activityID_ = ActivityConst.MYTHIC_FINAL

	local var_22_0 = MythicData:GetCurTime()

	arg_22_0.timeText_.text = manager.time:DescCdTime2(var_22_0)

	arg_22_0:RefreshUIStatu()
end

function var_0_0.RefreshUIStatu(arg_24_0)
	if MythicData:GetIsBattleIng() then
		arg_24_0.controller_:SetSelectedState("true")

		local var_24_0 = string.format(GetTips("MYTHIC_FINAL_BASTTLE_TIPS"), MythicData:GetCurHotLevelId()) .. GetTips("TEAM_" .. MythicData:GetCurBattleIndex())

		arg_24_0.battleText_.text = var_24_0
	else
		arg_24_0.controller_:SetSelectedState("false")
	end

	arg_24_0.heroList_:Refresh()
end

function var_0_0.OnTop(arg_25_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_25_0.changeindex_1 ~= 0 then
			arg_25_0:ResetStatus()
		else
			JumpTools.Back()
		end
	end)
	arg_25_0.heroList_:StartScroll(arg_25_0.times_)
end

function var_0_0.OnExit(arg_27_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_28_0)
	if arg_28_0.heroList_ then
		arg_28_0.heroList_:Dispose()

		arg_28_0.heroList_ = nil
	end

	arg_28_0.changehandler_ = nil
	arg_28_0.confirmhandler_ = nil

	var_0_0.super.Dispose(arg_28_0)
end

return var_0_0
