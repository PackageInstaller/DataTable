local SkuldPuzzleGameView = class("SkuldPuzzleGameView", ReduxView)

function SkuldPuzzleGameView:UIName()
	return "Widget/System/Activity_Skuld/Activity_Skuld_PizzleStageView"
end

function SkuldPuzzleGameView:UIParent()
	return manager.ui.uiMain.transform
end

function SkuldPuzzleGameView:Init()
	self.isUseStoryMode = false

	self:InitUI()
	self:AddUIListeners()
end

function SkuldPuzzleGameView:AddUIListeners()
	self:AddBtnListener(self.tabOnBtn_, nil, function()
		if SkuldPuzzleBrige.CheckIsHaveDragging() then
			return
		end

		self:OnClickChangeStoryMode(true)
	end)
	self:AddBtnListener(self.tabOffBtn_, nil, function()
		if SkuldPuzzleBrige.CheckIsHaveDragging() then
			return
		end

		self:OnClickChangeStoryMode(false)
	end)
	self:AddBtnListener(self.talkbubbleclickareaBtn_, nil, function()
		self:SkuldTalkBubble()
	end)
	self:AddBtnListener(self.resetbtnBtn_, nil, function()
		if SkuldPuzzleBrige.CheckIsHaveDragging() then
			return
		end

		self.battle_times = self.battle_times + 1

		SkuldPuzzleBrige.ResetGame()
	end)
	self:AddBtnListener(self.heroClickAreaBtn_, nil, function()
		self.talkBubbleIndex = 0

		self:SkuldTalkBubble()
	end)
end

function SkuldPuzzleGameView:OnClickChangeStoryMode(arg_10_1)
	if self.isFinishGame then
		return
	end

	if not getData("SkuldPuzzleGame", "isUsedStoryMode") then
		SkuldPuzzleBrige.PauseGame(true)
		JumpTools.OpenPageByJump("skuldPuzzleTipsView", {
			textContent = GetTips("SKULD_EASY_MODE"),
			titleContent = GetTips("PROMPT"),
			sureCallback = function()
				saveData("SkuldPuzzleGame", "isUsedStoryMode", true)
				self:Back()
				SkuldPuzzleBrige.PauseGame(false)

				self.isClickChangeStoryMode = true

				self:ChangeStoryMode(arg_10_1)
			end,
			cancelCallback = function()
				self:Back()
				SkuldPuzzleBrige.PauseGame(false)
			end
		})
	else
		SkuldPuzzleBrige.PauseGame(false)

		self.isClickChangeStoryMode = true

		self:ChangeStoryMode(arg_10_1)
	end
end

function SkuldPuzzleGameView:InitUI()
	self:BindCfgUI()

	self.storyModeController_ = self.controllerexcollection_:GetController("storyMode")
	self.puzzleBgController_ = self.controllerexcollection_:GetController("puzzleBg")
	self.talkBubbleController_ = self.controllerexcollection_:GetController("talkBubble")
	self.playerStateController_ = self.controllerexcollection_:GetController("playerState")
	self.taskStateController_ = self.controllerexcollection_:GetController("taskState")
	self.talkMaskController_ = self.controllerexcollection_:GetController("talkmask")
	self.conditionItemList = {}
	self.skuldSpine_ = self.skuldGo_:GetComponent("Spine.Unity.SkeletonGraphic")
	self.adminSpine_ = self.adminGo_:GetComponent("Spine.Unity.SkeletonGraphic")
end

function SkuldPuzzleGameView:OnEnter()
	self:AddEventListeners()
	self.animator_:Play("Activity_Skuld_PizzleStageView", 0, 0)
	SetActive(self.gameovernodeGo_, false)

	self.stageID = self.params_.stageID
	self.battle_times = 0
	self.playTaskAni_ = false

	self:InitConditionList()
	self:StartGame()
	self:StartSkuldTalkBubble()

	self.isUseStoryMode = nil
	self.isClickChangeStoryMode = false
	self.beginUseStoryMode = false
	self.skuldSpine_.initialSkinName = SkuldPuzzleStageCfg[self.params_.stageID].skuld_skin

	self.skuldSpine_:Initialize(true)

	if SkuldPuzzleStageCfg[self.params_.stageID].admin_skin ~= "" then
		self.adminSpine_.initialSkinName = SkuldPuzzleStageCfg[self.params_.stageID].admin_skin

		self.adminSpine_.Initialize(self.skuldSpine_, true)
	end
end

function SkuldPuzzleGameView:OnEnterOver()
	if SkuldPuzzleStageCfg[self.stageID].story_id > 0 then
		manager.story:StartStoryById(SkuldPuzzleStageCfg[self.stageID].story_id, function()
			SkuldSystemAction.RefreshAudio()
		end)
	else
		SkuldSystemAction.RefreshAudio()
	end
end

function SkuldPuzzleGameView:AddEventListeners()
	self:RegistEventListener(SKULD_PUZZLE_CONDITION_UPDATE, function(arg_18_0, arg_18_1)
		self:UpdateConditionList(arg_18_0, arg_18_1)
	end)
	self:RegistEventListener(SKULD_PUZZLE_INIT_PUZZLE_STAGE, function(arg_19_0, arg_19_1, arg_19_2)
		self:InitPuzzleStageMapData(arg_19_0, arg_19_1, arg_19_2)
	end)
end

function SkuldPuzzleGameView:InitPuzzleStageMapData(arg_20_1, arg_20_2, arg_20_3)
	if arg_20_1 == 5 and arg_20_2 == 5 then
		self.puzzleBgController_:SetSelectedState("55")
	else
		self.puzzleBgController_:SetSelectedState("44")
	end

	if not arg_20_3 then
		self.storyModeController_:SetSelectedState("hide")
	else
		self:ChangeStoryMode(false)
	end
end

function SkuldPuzzleGameView:ChangeStoryMode(arg_21_1)
	if self.isUseStoryMode == arg_21_1 then
		return
	end

	self.isUseStoryMode = arg_21_1

	self.storyModeController_:SetSelectedState(arg_21_1 and "on" or "off")
	SkuldPuzzleBrige.OpenStoryMode(arg_21_1)
end

function SkuldPuzzleGameView:StartSkuldTalkBubble()
	local var_22_0 = SkuldPuzzleStageCfg[self.stageID]

	if SkuldPuzzleStageCfg[self.stageID].character == 0 then
		self.playerStateController_:SetSelectedState("NoCamera")
	else
		self.playerStateController_:SetSelectedIndex(var_22_0.character - 1)
	end

	if next(var_22_0.talk_list) == nil then
		self.talkBubbleController_:SetSelectedState("none")
		self.taskStateController_:SetSelectedState("show")
		self.talkMaskController_:SetSelectedState("unshow")
	else
		self.talkMaskController_:SetSelectedState("show")
		self.taskStateController_:SetSelectedState("hide")

		self.talkBubbleIndex = 0

		self:SkuldTalkBubble()
	end
end

function SkuldPuzzleGameView:SkuldTalkBubble(arg_23_1)
	if self.talkBubbleIndex == #SkuldPuzzleStageCfg[self.stageID].talk_list then
		self.talkBubbleController_:SetSelectedState("hide")
		self.taskStateController_:SetSelectedState("show")
		self.talkMaskController_:SetSelectedState("unshow")

		if not self.playTaskAni_ then
			self.taskpanelAni_:Play("taskPanel", 0, 0)
		end

		self.playTaskAni_ = true
	else
		self.talkBubbleController_:SetSelectedState("show")

		self.talkBubbleTxt_.text = formatText(SkuldPuzzleStageCfg[self.stageID].talk_list[self.talkBubbleIndex + 1])
		self.talkBubbleIndex = self.talkBubbleIndex + 1
	end
end

function SkuldPuzzleGameView:InitConditionList()
	local var_24_0 = SkuldPuzzleStageCfg[self.stageID].condition_list

	var_24_0 = #SkuldPuzzleStageCfg[self.stageID].condition_list > 0 and var_24_0 or {}

	for iter_24_0, iter_24_1 in pairs(self.conditionItemList) do
		SetActive(iter_24_1.gameObject_, false)
	end

	for iter_24_2, iter_24_3 in pairs(var_24_0) do
		local var_24_1 = self.conditionItemList[iter_24_2]

		if not self.conditionItemList[iter_24_2] then
			var_24_1 = self:CreateConditionItem()

			table.insert(self.conditionItemList, var_24_1)
		end

		SetActive(var_24_1.gameObject_, true)
		var_24_1:RefreshUI(iter_24_3)
	end
end

function SkuldPuzzleGameView:CreateConditionItem()
	return SkuldPuzzleConditionItem.New((GameObject.Instantiate(self.conditionitemGo_, self.conditionListTrs_)))
end

function SkuldPuzzleGameView:UpdateConditionList(arg_26_1, arg_26_2)
	local var_26_0 = false

	for iter_26_0 = 0, arg_26_1.Length - 1 do
		if self.conditionItemList[iter_26_0 + 1] then
			self.conditionItemList[iter_26_0 + 1]:ChangeState(arg_26_1[iter_26_0])

			if self.conditionItemList[iter_26_0 + 1]:CheckIsUseAllChipCondition() then
				var_26_0 = self.conditionItemList[iter_26_0 + 1]:GetIsFinish()
			end
		end
	end

	for iter_26_1 = 0, arg_26_1.Length - 1 do
		if self.conditionItemList[iter_26_1 + 1] then
			self.conditionItemList[iter_26_1 + 1]:ShowRemindState(var_26_0)
			self.conditionItemList[iter_26_1 + 1]:UpdateShowNum(arg_26_2[iter_26_1])
		end
	end

	local var_26_1 = true

	for iter_26_2 = 0, arg_26_1.Length - 1 do
		var_26_1 = arg_26_1[iter_26_2]

		if arg_26_1[iter_26_2] == false then
			break
		end
	end

	self.isFinishGame = var_26_1

	if var_26_1 then
		self:PlayFinishAni()
	end
end

function SkuldPuzzleGameView:DisposeFinishTimer()
	if self.gameOverTimer then
		self.gameOverTimer:Stop()

		self.gameOverTimer = nil
	end
end

function SkuldPuzzleGameView:PlayFinishAni()
	self:DisposeFinishTimer()
	SetActive(self.gameovernodeGo_, true)
	self.animator_:Play("GameOver_exit", 0, 0)

	self.gameOverTimer = Timer.New(function()
		self:FinishGame()
	end, 3.75)

	self.gameOverTimer:Start()
end

function SkuldPuzzleGameView:FinishGame()
	SkuldSystemAction.QuerySkuldPizzleCompelet(self.params_.levelID)
	self:SendSDK(true)
end

function SkuldPuzzleGameView:SendSDK(arg_31_1)
	local var_31_0 = "activity_combat_over"
	local var_31_1 = {
		activity_id = SkuldStageCfg[self.params_.levelID].activity,
		hard = self.isUseStoryMode and 1 or 2,
		stage_id = SkuldPuzzleStageCfg[self.stageID].id,
		result = arg_31_1 and 1 or 3,
		use_seconds = math.floor(SkuldPuzzleBrige.GetUseTimes() + 0.5),
		is_help = self.isClickChangeStoryMode,
		is_restart = self.beginUseStoryMode
	}

	var_31_1.battle_times = self.battle_times or 0

	SDKTools.SendMessageToSDK(var_31_0, var_31_1)
end

function SkuldPuzzleGameView:StartGame()
	local var_32_0 = SkuldPuzzleStageCfg[self.stageID]
	local var_32_1 = SkuldPuzzleStageCfg[self.stageID].condition_list

	var_32_1 = #SkuldPuzzleStageCfg[self.stageID].condition_list > 0 and var_32_1 or {}

	local var_32_2 = SkuldPuzzleConditionDataList.New()
	local var_32_3 = {}

	for iter_32_0, iter_32_1 in pairs(var_32_1) do
		local var_32_4 = SkuldPuzzleConditionData.New()
		local var_32_5 = {}
		local var_32_6 = 0
		local var_32_7 = 0

		var_32_4.conditionType = SkuldPuzzleConditionCfg[iter_32_1].condition_type

		if SkuldPuzzleConditionCfg[iter_32_1].condition_value[1] ~= nil then
			var_32_7 = SkuldPuzzleConditionCfg[iter_32_1].condition_value[1]
		end

		if SkuldPuzzleConditionCfg[iter_32_1].condition_value[2] ~= nil then
			var_32_6 = SkuldPuzzleConditionCfg[iter_32_1].condition_value[2]
		end

		if SkuldPuzzleConditionCfg[iter_32_1].condition_value[3] ~= nil then
			for iter_32_2, iter_32_3 in pairs(SkuldPuzzleConditionCfg[iter_32_1].condition_value[3]) do
				table.insert(var_32_5, iter_32_3)
			end
		end

		var_32_4.aimList = var_32_5
		var_32_4.aimCount = var_32_6
		var_32_4.chipID = var_32_7

		table.insert(var_32_3, var_32_4)
	end

	var_32_2.conditonList = var_32_3

	SkuldPuzzleBrige.StartGame(var_32_0.map, self.stageGo_, var_32_2)

	local var_32_8 = var_32_0.chip_name_list

	var_32_8 = var_32_0.chip_name_list == "" and {} or var_32_8

	for iter_32_4, iter_32_5 in pairs(var_32_8 or {}) do
		local var_32_9 = self.chipContentTrs_:GetChild(iter_32_4 - 1)

		if var_32_9 then
			var_32_9:Find("puzzleName"):GetComponent("Text").text = GetI18NText(iter_32_5)
		end
	end
end

function SkuldPuzzleGameView:OnTop()
	self:UpdateBarInfo()
end

function SkuldPuzzleGameView:UpdateBarInfo()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		SkuldPuzzleBrige.PauseGame(true)
		JumpTools.OpenPageByJump("skuldPuzzleTipsView", {
			textContent = GetTips("SKULD_PUZZLE_QUIT"),
			titleContent = GetTips("PROMPT"),
			sureCallback = function()
				self:SendSDK(false)
				self:Back()
				self:Back()
			end,
			cancelCallback = function()
				self:Back()
				SkuldPuzzleBrige.PauseGame(false)
			end
		})
	end)

	if GameSetting.skuld_puzzle_describe then
		local var_34_0 = GameSetting.skuld_puzzle_describe.value or {}
	end

	manager.windowBar:RegistInfoCallBack(function()
		if self.isOpenPerformance then
			return
		end

		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_34_0
		})
	end)
end

function SkuldPuzzleGameView:OnExit()
	self:DisposeFinishTimer()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function SkuldPuzzleGameView:Cacheable()
	return false
end

function SkuldPuzzleGameView:Dispose()
	SkuldPuzzleBrige.ExitGame()
	SkuldPuzzleGameView.super.Dispose(self)

	for iter_41_0, iter_41_1 in pairs(self.conditionItemList) do
		if iter_41_1 then
			iter_41_1:Dispose()
		end
	end
end

return SkuldPuzzleGameView
