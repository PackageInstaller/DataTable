local TangramGameStageView = class("TangramGameStageView", ReduxView)

function TangramGameStageView:UIName()
	return "Widget/System/Summer2024/Summer2024_Tangram/TangramGameStageView"
end

function TangramGameStageView:UIParent()
	return manager.ui.uiMain.transform
end

function TangramGameStageView:Init()
	self:InitUI()
end

function TangramGameStageView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.finChipIndex = {}
end

function TangramGameStageView:OnEnter()
	self.stageID = self.params_.stageID
	self.descText_.text = GetTips("ACTIVITY_TANGRAM_GAME_STAGE_TITLE_DESC")

	self:RefreshBar()
	self:StartGame()
	self:RegisterEvents()
end

function TangramGameStageView:AddUIListener()
	self:AddBtnListener(self.resetbtnBtn_, nil, function()
		TangramGameBridge.ResetAllStageChip()
	end)
end

function TangramGameStageView:SendSDK(arg_8_1)
	local var_8_0 = "activity_combat_over"
	local var_8_1 = {
		activity_id = TangramGameData:GetCurRunGameActivityID(),
		stage_id = ActivityTangramGameStageCfg[self.stageID].stageID,
		result = arg_8_1 and 1 or 3
	}

	var_8_1.use_seconds = self.useSecond or 0

	SDKTools.SendMessageToSDK(var_8_0, var_8_1)
end

function TangramGameStageView:RegisterEvents()
	self:RegistEventListener(TANGRAM_GAME_FINISH_STAGE, function()
		if manager.ChessBoardManager and manager.ChessBoardManager:IsBattleBack() then
			self:OnStageClear()
		else
			self:OnFinishStage()
		end
	end)
	self:RegistEventListener(TANGRAM_GAME_STAGE_CLEAR, function(arg_11_0)
		self:OnStageClear()
	end)
end

function TangramGameStageView:OnFinishStage()
	self.finChipIndex = {}

	for iter_12_0 = 1, ActivityTangramGameStageCfg[self.stageID].clue_num do
		table.insert(self.finChipIndex, iter_12_0)
	end

	self:SendSDK(true)
	TangramAction:SaveStageProcess(self.stageID, self.finChipIndex)
end

function TangramGameStageView:OnStageClear()
	TangramGameTools:ExitStage()
	JumpTools.OpenPageByJump("tangramGameCluePopView", {
		playAni = true,
		stageID = self.stageID
	})
end

function TangramGameStageView:StartGame()
	self.finChipIndex = {}

	local var_14_0 = TangramGameData:GetStageInfoByStageID(self.stageID)

	if var_14_0 then
		if not manager.ChessBoardManager or not manager.ChessBoardManager:IsBattleBack() then
			self.finChipIndex = deepClone(var_14_0.finishChipList)
		end

		if self.stagePage then
			self.stagePage:Dispose()
		end

		self.stagePage = TangramGameStagePrefab.New(self.stageGo, self.stageID)

		TangramGameTools:StartStage(self.stageID, self.stagePage.gameObject_, self.finChipIndex)
	end

	self:AddSecondTimer()
end

function TangramGameStageView:OnExit()
	if self.stagePage then
		self.stagePage:OnExit()
	end

	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function TangramGameStageView:OnTop()
	self:RefreshBar()
end

function TangramGameStageView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:SendSDK(false)
		TangramGameTools:ExitStage()
		self:Back()
	end)

	local var_17_0

	if ActivityTangramGameStageCfg[self.stageID].stage_type == 3 then
		var_17_0 = self.stageID == 3001 and (GameSetting.summer_tangram_describe1 and GameSetting.summer_tangram_describe1.value or {}) or GameSetting.summer_tangram_describe2 and GameSetting.summer_tangram_describe2.value or {}

		if not getData(string.format("summer_tangram_%d", self.stageID), "first") then
			JumpTools.OpenPageByJump("gameHelpPro", {
				isPrefab = true,
				pages = var_17_0
			})
			saveData(string.format("summer_tangram_%d", self.stageID), "first", true)
		end
	else
		var_17_0 = ActivityTangramGameChapterCfg[ActivityTangramGameChapterCfg.get_id_list_by_puzzle_stage_list[self.stageID][1]].activityID == ActivityConst.SUMMER_CHESS_BOARD_PLUZZE_1 and (GameSetting.summer_tangram_describe1 and GameSetting.summer_tangram_describe1.value or {}) or GameSetting.summer_tangram_describe2 and GameSetting.summer_tangram_describe2.value or {}
	end

	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_17_0
		})
	end)
end

function TangramGameStageView:AddSecondTimer()
	self:DelSecondTimer()

	self.useSecond = 0
	self.secondTimer = Timer.New(function()
		self.useSecond = self.useSecond + 1
	end, 1, -1)

	self.secondTimer:Start()
end

function TangramGameStageView:DelSecondTimer()
	if self.secondTimer then
		self.secondTimer:Stop()

		self.secondTimer = nil
	end
end

function TangramGameStageView:Dispose()
	if self.stagePage then
		self.stagePage:Dispose()
	end

	TangramGameStageView.super.Dispose(self)
	self:DelSecondTimer()
end

return TangramGameStageView
