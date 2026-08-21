local var_0_0 = class("TangramGameStageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_Tangram/TangramGameStageView"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListener()

	arg_4_0.finChipIndex = {}
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.stageID = arg_5_0.params_.stageID
	arg_5_0.descText_.text = GetTips("ACTIVITY_TANGRAM_GAME_STAGE_TITLE_DESC")

	arg_5_0:RefreshBar()
	arg_5_0:StartGame()
	arg_5_0:RegisterEvents()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.resetbtnBtn_, nil, function()
		TangramGameBridge.ResetAllStageChip()
	end)
end

function var_0_0.SendSDK(arg_8_0, arg_8_1)
	local var_8_0 = ActivityTangramGameStageCfg[arg_8_0.stageID]
	local var_8_1 = TangramGameData:GetCurRunGameActivityID()

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = var_8_1,
		stage_id = var_8_0.stageID,
		result = arg_8_1 and 1 or 3,
		use_seconds = arg_8_0.useSecond or 0
	})
end

function var_0_0.RegisterEvents(arg_9_0)
	arg_9_0:RegistEventListener(TANGRAM_GAME_FINISH_STAGE, function()
		if manager.ChessBoardManager and manager.ChessBoardManager:IsBattleBack() then
			arg_9_0:OnStageClear()
		else
			arg_9_0:OnFinishStage()
		end
	end)
	arg_9_0:RegistEventListener(TANGRAM_GAME_STAGE_CLEAR, function(arg_11_0)
		arg_9_0:OnStageClear()
	end)
end

function var_0_0.OnFinishStage(arg_12_0)
	local var_12_0 = ActivityTangramGameStageCfg[arg_12_0.stageID].clue_num

	arg_12_0.finChipIndex = {}

	for iter_12_0 = 1, var_12_0 do
		table.insert(arg_12_0.finChipIndex, iter_12_0)
	end

	arg_12_0:SendSDK(true)
	TangramAction:SaveStageProcess(arg_12_0.stageID, arg_12_0.finChipIndex)
end

function var_0_0.OnStageClear(arg_13_0)
	TangramGameTools:ExitStage()
	JumpTools.OpenPageByJump("tangramGameCluePopView", {
		playAni = true,
		stageID = arg_13_0.stageID
	})
end

function var_0_0.StartGame(arg_14_0)
	arg_14_0.finChipIndex = {}

	local var_14_0 = TangramGameData:GetStageInfoByStageID(arg_14_0.stageID)

	if var_14_0 then
		if not manager.ChessBoardManager or not manager.ChessBoardManager:IsBattleBack() then
			arg_14_0.finChipIndex = deepClone(var_14_0.finishChipList)
		end

		if arg_14_0.stagePage then
			arg_14_0.stagePage:Dispose()
		end

		arg_14_0.stagePage = TangramGameStagePrefab.New(arg_14_0.stageGo, arg_14_0.stageID)

		TangramGameTools:StartStage(arg_14_0.stageID, arg_14_0.stagePage.gameObject_, arg_14_0.finChipIndex)
	end

	arg_14_0:AddSecondTimer()
end

function var_0_0.OnExit(arg_15_0)
	if arg_15_0.stagePage then
		arg_15_0.stagePage:OnExit()
	end

	manager.windowBar:HideBar()
	arg_15_0:RemoveAllEventListener()
end

function var_0_0.OnTop(arg_16_0)
	arg_16_0:RefreshBar()
end

function var_0_0.RefreshBar(arg_17_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_17_0:SendSDK(false)
		TangramGameTools:ExitStage()
		arg_17_0:Back()
	end)

	local var_17_0

	if ActivityTangramGameStageCfg[arg_17_0.stageID].stage_type == 3 then
		if arg_17_0.stageID == 3001 then
			var_17_0 = GameSetting.summer_tangram_describe1 and GameSetting.summer_tangram_describe1.value or {}
		else
			var_17_0 = GameSetting.summer_tangram_describe2 and GameSetting.summer_tangram_describe2.value or {}
		end

		if not getData(string.format("summer_tangram_%d", arg_17_0.stageID), "first") then
			JumpTools.OpenPageByJump("gameHelpPro", {
				isPrefab = true,
				pages = var_17_0
			})
			saveData(string.format("summer_tangram_%d", arg_17_0.stageID), "first", true)
		end
	else
		local var_17_1 = ActivityTangramGameChapterCfg.get_id_list_by_puzzle_stage_list[arg_17_0.stageID][1]

		if ActivityTangramGameChapterCfg[var_17_1].activityID == ActivityConst.SUMMER_CHESS_BOARD_PLUZZE_1 then
			var_17_0 = GameSetting.summer_tangram_describe1 and GameSetting.summer_tangram_describe1.value or {}
		else
			var_17_0 = GameSetting.summer_tangram_describe2 and GameSetting.summer_tangram_describe2.value or {}
		end
	end

	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_17_0
		})
	end)
end

function var_0_0.AddSecondTimer(arg_20_0)
	arg_20_0:DelSecondTimer()

	arg_20_0.useSecond = 0
	arg_20_0.secondTimer = Timer.New(function()
		arg_20_0.useSecond = arg_20_0.useSecond + 1
	end, 1, -1)

	arg_20_0.secondTimer:Start()
end

function var_0_0.DelSecondTimer(arg_22_0)
	if arg_22_0.secondTimer then
		arg_22_0.secondTimer:Stop()

		arg_22_0.secondTimer = nil
	end
end

function var_0_0.Dispose(arg_23_0)
	if arg_23_0.stagePage then
		arg_23_0.stagePage:Dispose()
	end

	var_0_0.super.Dispose(arg_23_0)
	arg_23_0:DelSecondTimer()
end

return var_0_0
