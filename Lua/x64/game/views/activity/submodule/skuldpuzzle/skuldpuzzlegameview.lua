local var_0_0 = class("SkuldPuzzleGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Skuld/Activity_Skuld_PizzleStageView"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.isUseStoryMode = false

	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.tabOnBtn_, nil, function()
		if SkuldPuzzleBrige.CheckIsHaveDragging() then
			return
		end

		arg_4_0:OnClickChangeStoryMode(true)
	end)
	arg_4_0:AddBtnListener(arg_4_0.tabOffBtn_, nil, function()
		if SkuldPuzzleBrige.CheckIsHaveDragging() then
			return
		end

		arg_4_0:OnClickChangeStoryMode(false)
	end)
	arg_4_0:AddBtnListener(arg_4_0.talkbubbleclickareaBtn_, nil, function()
		arg_4_0:SkuldTalkBubble()
	end)
	arg_4_0:AddBtnListener(arg_4_0.resetbtnBtn_, nil, function()
		if SkuldPuzzleBrige.CheckIsHaveDragging() then
			return
		end

		arg_4_0.battle_times = arg_4_0.battle_times + 1

		SkuldPuzzleBrige.ResetGame()
	end)
	arg_4_0:AddBtnListener(arg_4_0.heroClickAreaBtn_, nil, function()
		arg_4_0.talkBubbleIndex = 0

		arg_4_0:SkuldTalkBubble()
	end)
end

function var_0_0.OnClickChangeStoryMode(arg_10_0, arg_10_1)
	if arg_10_0.isFinishGame then
		return
	end

	if not getData("SkuldPuzzleGame", "isUsedStoryMode") then
		SkuldPuzzleBrige.PauseGame(true)
		JumpTools.OpenPageByJump("skuldPuzzleTipsView", {
			textContent = GetTips("SKULD_EASY_MODE"),
			titleContent = GetTips("PROMPT"),
			sureCallback = function()
				saveData("SkuldPuzzleGame", "isUsedStoryMode", true)
				arg_10_0:Back()
				SkuldPuzzleBrige.PauseGame(false)

				arg_10_0.isClickChangeStoryMode = true

				arg_10_0:ChangeStoryMode(arg_10_1)
			end,
			cancelCallback = function()
				arg_10_0:Back()
				SkuldPuzzleBrige.PauseGame(false)
			end
		})
	else
		SkuldPuzzleBrige.PauseGame(false)

		arg_10_0.isClickChangeStoryMode = true

		arg_10_0:ChangeStoryMode(arg_10_1)
	end
end

function var_0_0.InitUI(arg_13_0)
	arg_13_0:BindCfgUI()

	arg_13_0.storyModeController_ = arg_13_0.controllerexcollection_:GetController("storyMode")
	arg_13_0.puzzleBgController_ = arg_13_0.controllerexcollection_:GetController("puzzleBg")
	arg_13_0.talkBubbleController_ = arg_13_0.controllerexcollection_:GetController("talkBubble")
	arg_13_0.playerStateController_ = arg_13_0.controllerexcollection_:GetController("playerState")
	arg_13_0.taskStateController_ = arg_13_0.controllerexcollection_:GetController("taskState")
	arg_13_0.talkMaskController_ = arg_13_0.controllerexcollection_:GetController("talkmask")
	arg_13_0.conditionItemList = {}
	arg_13_0.skuldSpine_ = arg_13_0.skuldGo_:GetComponent("Spine.Unity.SkeletonGraphic")
	arg_13_0.adminSpine_ = arg_13_0.adminGo_:GetComponent("Spine.Unity.SkeletonGraphic")
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0:AddEventListeners()
	arg_14_0.animator_:Play("Activity_Skuld_PizzleStageView", 0, 0)
	SetActive(arg_14_0.gameovernodeGo_, false)

	local var_14_0 = arg_14_0.params_.stageID

	arg_14_0.stageID = var_14_0
	arg_14_0.battle_times = 0
	arg_14_0.playTaskAni_ = false

	arg_14_0:InitConditionList()
	arg_14_0:StartGame()
	arg_14_0:StartSkuldTalkBubble()

	arg_14_0.isUseStoryMode = nil
	arg_14_0.isClickChangeStoryMode = false
	arg_14_0.beginUseStoryMode = false

	local var_14_1 = SkuldStageCfg[arg_14_0.params_.levelID]
	local var_14_2 = SkuldPuzzleStageCfg[var_14_0]

	arg_14_0.skuldSpine_.initialSkinName = var_14_2.skuld_skin

	arg_14_0.skuldSpine_.Initialize(arg_14_0.skuldSpine_, true)

	if var_14_2.admin_skin ~= "" then
		arg_14_0.adminSpine_.initialSkinName = var_14_2.admin_skin

		arg_14_0.adminSpine_.Initialize(arg_14_0.skuldSpine_, true)
	end
end

function var_0_0.OnEnterOver(arg_15_0)
	local var_15_0 = arg_15_0.stageID
	local var_15_1 = SkuldPuzzleStageCfg[var_15_0]

	if var_15_1.story_id > 0 then
		manager.story:StartStoryById(var_15_1.story_id, function()
			SkuldSystemAction.RefreshAudio()
		end)
	else
		SkuldSystemAction.RefreshAudio()
	end
end

function var_0_0.AddEventListeners(arg_17_0)
	arg_17_0:RegistEventListener(SKULD_PUZZLE_CONDITION_UPDATE, function(arg_18_0, arg_18_1)
		arg_17_0:UpdateConditionList(arg_18_0, arg_18_1)
	end)
	arg_17_0:RegistEventListener(SKULD_PUZZLE_INIT_PUZZLE_STAGE, function(arg_19_0, arg_19_1, arg_19_2)
		arg_17_0:InitPuzzleStageMapData(arg_19_0, arg_19_1, arg_19_2)
	end)
end

function var_0_0.InitPuzzleStageMapData(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_1 == 5 and arg_20_2 == 5 then
		arg_20_0.puzzleBgController_:SetSelectedState("55")
	else
		arg_20_0.puzzleBgController_:SetSelectedState("44")
	end

	if not arg_20_3 then
		arg_20_0.storyModeController_:SetSelectedState("hide")
	else
		arg_20_0:ChangeStoryMode(false)
	end
end

function var_0_0.ChangeStoryMode(arg_21_0, arg_21_1)
	if arg_21_0.isUseStoryMode == arg_21_1 then
		return
	end

	arg_21_0.isUseStoryMode = arg_21_1

	arg_21_0.storyModeController_:SetSelectedState(arg_21_1 and "on" or "off")
	SkuldPuzzleBrige.OpenStoryMode(arg_21_1)
end

function var_0_0.StartSkuldTalkBubble(arg_22_0)
	local var_22_0 = SkuldPuzzleStageCfg[arg_22_0.stageID]

	if var_22_0.character == 0 then
		arg_22_0.playerStateController_:SetSelectedState("NoCamera")
	else
		arg_22_0.playerStateController_:SetSelectedIndex(var_22_0.character - 1)
	end

	if next(var_22_0.talk_list) == nil then
		arg_22_0.talkBubbleController_:SetSelectedState("none")
		arg_22_0.taskStateController_:SetSelectedState("show")
		arg_22_0.talkMaskController_:SetSelectedState("unshow")
	else
		arg_22_0.talkMaskController_:SetSelectedState("show")
		arg_22_0.taskStateController_:SetSelectedState("hide")

		arg_22_0.talkBubbleIndex = 0

		arg_22_0:SkuldTalkBubble()
	end
end

function var_0_0.SkuldTalkBubble(arg_23_0, arg_23_1)
	local var_23_0 = SkuldPuzzleStageCfg[arg_23_0.stageID].talk_list

	if arg_23_0.talkBubbleIndex == #var_23_0 then
		arg_23_0.talkBubbleController_:SetSelectedState("hide")
		arg_23_0.taskStateController_:SetSelectedState("show")
		arg_23_0.talkMaskController_:SetSelectedState("unshow")

		if not arg_23_0.playTaskAni_ then
			arg_23_0.taskpanelAni_:Play("taskPanel", 0, 0)
		end

		arg_23_0.playTaskAni_ = true
	else
		arg_23_0.talkBubbleController_:SetSelectedState("show")

		arg_23_0.talkBubbleTxt_.text = formatText(var_23_0[arg_23_0.talkBubbleIndex + 1])
		arg_23_0.talkBubbleIndex = arg_23_0.talkBubbleIndex + 1
	end
end

function var_0_0.InitConditionList(arg_24_0)
	local var_24_0 = SkuldPuzzleStageCfg[arg_24_0.stageID].condition_list

	var_24_0 = #var_24_0 > 0 and var_24_0 or {}

	for iter_24_0, iter_24_1 in pairs(arg_24_0.conditionItemList) do
		SetActive(iter_24_1.gameObject_, false)
	end

	for iter_24_2, iter_24_3 in pairs(var_24_0) do
		local var_24_1 = arg_24_0.conditionItemList[iter_24_2]

		if not var_24_1 then
			var_24_1 = arg_24_0:CreateConditionItem()

			table.insert(arg_24_0.conditionItemList, var_24_1)
		end

		SetActive(var_24_1.gameObject_, true)
		var_24_1:RefreshUI(iter_24_3)
	end
end

function var_0_0.CreateConditionItem(arg_25_0)
	local var_25_0 = GameObject.Instantiate(arg_25_0.conditionitemGo_, arg_25_0.conditionListTrs_)

	return SkuldPuzzleConditionItem.New(var_25_0)
end

function var_0_0.UpdateConditionList(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = false

	for iter_26_0 = 0, arg_26_1.Length - 1 do
		local var_26_1 = arg_26_0.conditionItemList[iter_26_0 + 1]

		if var_26_1 then
			var_26_1:ChangeState(arg_26_1[iter_26_0])

			if var_26_1:CheckIsUseAllChipCondition() then
				var_26_0 = var_26_1:GetIsFinish()
			end
		end
	end

	for iter_26_1 = 0, arg_26_1.Length - 1 do
		if arg_26_0.conditionItemList[iter_26_1 + 1] then
			arg_26_0.conditionItemList[iter_26_1 + 1]:ShowRemindState(var_26_0)
			arg_26_0.conditionItemList[iter_26_1 + 1]:UpdateShowNum(arg_26_2[iter_26_1])
		end
	end

	local var_26_2 = true

	for iter_26_2 = 0, arg_26_1.Length - 1 do
		var_26_2 = arg_26_1[iter_26_2]

		if var_26_2 == false then
			break
		end
	end

	arg_26_0.isFinishGame = var_26_2

	if var_26_2 then
		arg_26_0:PlayFinishAni()
	end
end

function var_0_0.DisposeFinishTimer(arg_27_0)
	if arg_27_0.gameOverTimer then
		arg_27_0.gameOverTimer:Stop()

		arg_27_0.gameOverTimer = nil
	end
end

function var_0_0.PlayFinishAni(arg_28_0)
	arg_28_0:DisposeFinishTimer()
	SetActive(arg_28_0.gameovernodeGo_, true)
	arg_28_0.animator_:Play("GameOver_exit", 0, 0)

	arg_28_0.gameOverTimer = Timer.New(function()
		arg_28_0:FinishGame()
	end, 3.75)

	arg_28_0.gameOverTimer:Start()
end

function var_0_0.FinishGame(arg_30_0)
	SkuldSystemAction.QuerySkuldPizzleCompelet(arg_30_0.params_.levelID)
	arg_30_0:SendSDK(true)
end

function var_0_0.SendSDK(arg_31_0, arg_31_1)
	local var_31_0 = SkuldPuzzleStageCfg[arg_31_0.stageID]
	local var_31_1 = SkuldStageCfg[arg_31_0.params_.levelID]

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = var_31_1.activity,
		hard = arg_31_0.isUseStoryMode and 1 or 2,
		stage_id = var_31_0.id,
		result = arg_31_1 and 1 or 3,
		use_seconds = math.floor(SkuldPuzzleBrige.GetUseTimes() + 0.5),
		is_help = arg_31_0.isClickChangeStoryMode,
		is_restart = arg_31_0.beginUseStoryMode,
		battle_times = arg_31_0.battle_times or 0
	})
end

function var_0_0.StartGame(arg_32_0)
	local var_32_0 = SkuldPuzzleStageCfg[arg_32_0.stageID]
	local var_32_1 = var_32_0.condition_list

	var_32_1 = #var_32_1 > 0 and var_32_1 or {}

	local var_32_2 = SkuldPuzzleConditionDataList.New()
	local var_32_3 = {}

	for iter_32_0, iter_32_1 in pairs(var_32_1) do
		local var_32_4 = SkuldPuzzleConditionData.New()
		local var_32_5 = SkuldPuzzleConditionCfg[iter_32_1]
		local var_32_6 = {}
		local var_32_7 = 0
		local var_32_8 = 0

		var_32_4.conditionType = var_32_5.condition_type

		local var_32_9 = var_32_5.condition_value

		if var_32_9[1] ~= nil then
			var_32_8 = var_32_9[1]
		end

		if var_32_9[2] ~= nil then
			var_32_7 = var_32_9[2]
		end

		if var_32_9[3] ~= nil then
			for iter_32_2, iter_32_3 in pairs(var_32_9[3]) do
				table.insert(var_32_6, iter_32_3)
			end
		end

		var_32_4.aimList = var_32_6
		var_32_4.aimCount = var_32_7
		var_32_4.chipID = var_32_8

		table.insert(var_32_3, var_32_4)
	end

	var_32_2.conditonList = var_32_3

	SkuldPuzzleBrige.StartGame(var_32_0.map, arg_32_0.stageGo_, var_32_2)

	local var_32_10 = var_32_0.chip_name_list

	var_32_10 = var_32_10 == "" and {} or var_32_10

	for iter_32_4, iter_32_5 in pairs(var_32_10 or {}) do
		local var_32_11 = arg_32_0.chipContentTrs_:GetChild(iter_32_4 - 1)

		if var_32_11 then
			var_32_11:Find("puzzleName"):GetComponent("Text").text = GetI18NText(iter_32_5)
		end
	end
end

function var_0_0.OnTop(arg_33_0)
	arg_33_0:UpdateBarInfo()
end

function var_0_0.UpdateBarInfo(arg_34_0)
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
				arg_34_0:SendSDK(false)
				arg_34_0:Back()
				arg_34_0:Back()
			end,
			cancelCallback = function()
				arg_34_0:Back()
				SkuldPuzzleBrige.PauseGame(false)
			end
		})
	end)

	local var_34_0 = GameSetting.skuld_puzzle_describe and GameSetting.skuld_puzzle_describe.value or {}

	manager.windowBar:RegistInfoCallBack(function()
		if arg_34_0.isOpenPerformance then
			return
		end

		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_34_0
		})
	end)
end

function var_0_0.OnExit(arg_39_0)
	arg_39_0:DisposeFinishTimer()
	manager.windowBar:HideBar()
	arg_39_0:RemoveAllEventListener()
end

function var_0_0.Cacheable(arg_40_0)
	return false
end

function var_0_0.Dispose(arg_41_0)
	SkuldPuzzleBrige.ExitGame()
	var_0_0.super.Dispose(arg_41_0)

	for iter_41_0, iter_41_1 in pairs(arg_41_0.conditionItemList) do
		if iter_41_1 then
			iter_41_1:Dispose()
		end
	end
end

return var_0_0
