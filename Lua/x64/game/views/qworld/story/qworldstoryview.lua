local var_0_0 = class("QWorldStoryView", import("game.extend.ReduxView"))

function var_0_0.GetUIName(arg_1_0)
	return "Widget/System/SandPlay/SandPlay_Story/SandPlay_ChatUI"
end

function var_0_0.Ctor(arg_2_0)
	arg_2_0.gameObject_ = Object.Instantiate(Asset.Load(arg_2_0:GetUIName()), manager.ui.uiStory.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:AdaptScreen()
	arg_2_0:Hide()
	arg_2_0:Init()
end

function var_0_0.BuildContext(arg_3_0)
	arg_3_0.choice = {
		list = {}
	}
	arg_3_0.choiceCtx = nil
	arg_3_0.isInEmpty = false
	arg_3_0.timePerText = 0.2
	arg_3_0.curText = ""
	arg_3_0.totalTextTimer = 0
	arg_3_0.minTtoleranceTime = 0.6
	arg_3_0.canShow = true
	arg_3_0.nextAutoState = false
	arg_3_0.backupAutoPlay = false
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:BuildContext()
end

function var_0_0.InitUI(arg_5_0)
	ComponentBinder.GetInstance():BindCfgUI(arg_5_0, arg_5_0.gameObject_)
	arg_5_0.blackPanelObj:SetActive(false)

	arg_5_0.hideBtnController = arg_5_0.controller_:GetController("hideBtns")
	arg_5_0.contentWritter = arg_5_0.contentTxt_.gameObject:GetComponent("UITypewriterEffect")
	arg_5_0.autoController = arg_5_0.controller_:GetController("autoplay")
	arg_5_0.skipEnableController_ = arg_5_0.skipControllerEx_:GetController("skip")
	arg_5_0.autoEnableController_ = arg_5_0.autoControllerEx_:GetController("auto")

	arg_5_0:AddListener()
end

function var_0_0.AddListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.nextBtn_, nil, function()
		arg_6_0:OnNextClick()
	end)
	arg_6_0:AddBtnListener(arg_6_0.skipBtn_, nil, function()
		arg_6_0:ChangeAutoState(false)
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("TIP_SKIP_PLOT"),
			OkCallback = function()
				arg_6_0:OnSkipClick()
			end
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.allBtn_, nil, function()
		if not arg_6_0.isInEmpty then
			arg_6_0:OnNextClick()
		else
			arg_6_0:OnAllBtnClick()
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.hideBtn_, nil, function()
		arg_6_0:ChangeAutoState(false)
		arg_6_0:OnHideBtnClick()
	end)
	arg_6_0:AddBtnListener(arg_6_0.historyBtn_, nil, function()
		arg_6_0.backupAutoPlay = QWorldMgr:GetQWorldStoryMgr():GetAutoPlayState()

		arg_6_0:ChangeAutoState(false)
		JumpTools.OpenPageByJump("qworldStoryHistory")
	end)
	arg_6_0:AddBtnListener(arg_6_0.autoBtn_, nil, function()
		arg_6_0:ChangeAutoState(true)
	end)
	arg_6_0:AddBtnListener(arg_6_0.manualBtn_, nil, function()
		arg_6_0:ChangeAutoState(false)
	end)
	arg_6_0:RegistEventListener(QWORLD_STORY_HISTORY_OPEN, function(arg_15_0)
		if arg_15_0 then
			arg_6_0.gameObject_:SetActive(false)
		else
			arg_6_0.gameObject_:SetActive(true)

			if arg_6_0.backupAutoPlay then
				arg_6_0.backupAutoPlay = false

				arg_6_0:ChangeAutoState(true)
			end
		end
	end)
end

function var_0_0.Show(arg_16_0)
	arg_16_0.gameObject_:SetActive(true)
	CursorTools.LuaSwitchCursor(false)
end

function var_0_0.RenderContent(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = SandplayStoryTalkCfg[tonumber(arg_17_1)]
	local var_17_1 = var_17_0.cue_sheet
	local var_17_2 = 0

	if var_17_1 and var_17_1 ~= "" then
		var_17_2 = manager.audio:GetVoiceLength(var_17_0.cue_sheet, var_17_0.cue_name, true) / 1000
	end

	arg_17_0:StartContetnRender(var_17_0.dialogue_text, var_17_2)

	arg_17_0.nameTxt_.text = SandplayStoryTalkCfg[tonumber(arg_17_1)].speaker_name
end

function var_0_0.StartContetnRender(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.nextAutoState = false
	arg_18_0.contentTxt_.text = arg_18_1
	arg_18_0.contentWritter.percent = 0

	arg_18_0.contentWritter:SetDirty()

	arg_18_0.curText = arg_18_1
	arg_18_0.totalTextCount = utf8len(arg_18_1)
	arg_18_0.totalTextTimer = arg_18_0.totalTextCount * (1 / SandplaySettingCfg.story_word_display.value[1])
	arg_18_0.autoTextTimer = 1 / SandplaySettingCfg.story_word_duration.value[1] * arg_18_0.totalTextCount
	arg_18_0.autoTextTimer = math.max(arg_18_0.autoTextTimer, SandplaySettingCfg.story_word_duration.value[2])

	local var_18_0 = arg_18_2 or 0

	arg_18_0.autoTextTimer = math.max(arg_18_0.autoTextTimer, var_18_0)

	arg_18_0:StopContentRender()

	arg_18_0.startContentTimestamp = Time.time
	arg_18_0.isInTextTween = true
	arg_18_0.choiceRootActive = false

	arg_18_0:ChangeCanClickStatus()

	arg_18_0.contentTimer = FrameTimer.New(function()
		local var_19_0 = Time.time - arg_18_0.startContentTimestamp
		local var_19_1 = var_19_0 / arg_18_0.totalTextTimer

		if var_19_1 > 1 then
			var_19_1 = 1
		end

		arg_18_0.contentWritter.percent = var_19_1

		arg_18_0.contentWritter:SetDirty()

		if var_19_0 >= arg_18_0.totalTextTimer then
			if arg_18_0.choiceCtx and not arg_18_0.choiceRootActive then
				arg_18_0.choiceRootActive = true

				arg_18_0.choiceRoot_:SetActive(true)
			elseif not arg_18_0.choiceCtx and var_19_0 >= arg_18_0.autoTextTimer then
				arg_18_0:StopContentRender()

				arg_18_0.nextAutoState = true
			end

			if arg_18_0.isInTextTween then
				arg_18_0.isInTextTween = false

				arg_18_0:ChangeCanClickStatus()
			end
		end
	end, 1, -1)

	arg_18_0.contentTimer:Start()
end

function var_0_0.StopContentRender(arg_20_0)
	if arg_20_0.contentTimer then
		arg_20_0.contentTimer:Stop()

		arg_20_0.contentTimer = nil
		arg_20_0.isInTextTween = false

		arg_20_0:ChangeCanClickStatus()
	end
end

function var_0_0.OpenChoice(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.nextAutoState = false
	arg_21_0.choiceCtx = arg_21_1

	local var_21_0 = {
		task = {},
		tag = {},
		talkBranch = {}
	}
	local var_21_1 = {}

	if arg_21_2 then
		var_21_1 = QWorldMgr:GetQWorldStoryMgr():CollectFunctionChoice()
	end

	local var_21_2 = arg_21_1.Length
	local var_21_3 = #var_21_1
	local var_21_4 = #arg_21_0.choice.list

	if var_21_4 > var_21_2 + var_21_3 then
		for iter_21_0 = var_21_2 + var_21_3, var_21_4 do
			arg_21_0.choice.list[iter_21_0]:Reset()
			arg_21_0.choice.list[iter_21_0]:Hide()
		end
	end

	for iter_21_1 = 1, var_21_3 do
		if not arg_21_0.choice.list[iter_21_1] then
			local var_21_5 = GameObject.Instantiate(arg_21_0.choiceItem_, arg_21_0.choiceContent_)

			arg_21_0.choice.list[iter_21_1] = QWorldStoryChoiceItem.New(var_21_5)
		end

		arg_21_0.choice.list[iter_21_1]:Reset()
		arg_21_0.choice.list[iter_21_1]:RenderFuncChoice(var_21_1[iter_21_1])
		arg_21_0.choice.list[iter_21_1]:Show()

		if var_21_1[iter_21_1].type == QWorldConst.TagType.Quest then
			table.insert(var_21_0.task, var_21_1[iter_21_1].id)
		else
			table.insert(var_21_0.tag, var_21_1[iter_21_1].id)
		end
	end

	local var_21_6 = var_21_3 + 1

	if var_21_3 == 0 then
		var_21_6 = 1
	end

	for iter_21_2 = var_21_6, var_21_2 + var_21_3 do
		local var_21_7 = iter_21_2 - var_21_6 + 1

		if not arg_21_0.choice.list[iter_21_2] then
			local var_21_8 = GameObject.Instantiate(arg_21_0.choiceItem_, arg_21_0.choiceContent_)

			arg_21_0.choice.list[iter_21_2] = QWorldStoryChoiceItem.New(var_21_8)
		end

		arg_21_0.choice.list[iter_21_2]:Reset()
		arg_21_0.choice.list[iter_21_2]:RenderView(arg_21_0.choiceCtx[var_21_7 - 1].id)
		arg_21_0.choice.list[iter_21_2]:RegistCallback(function()
			arg_21_0.choiceCtx[var_21_7 - 1]:Invoke()
		end)
		arg_21_0.choice.list[iter_21_2]:Show()
		table.insert(var_21_0.talkBranch, arg_21_0.choiceCtx[var_21_7 - 1].id)
	end

	local var_21_9 = table.toString(var_21_0)

	for iter_21_3 = 1, var_21_2 + var_21_3 do
		if arg_21_0.choice.list[iter_21_3] then
			arg_21_0.choice.list[iter_21_3]:SetSdkChoice(var_21_9)
		end
	end

	arg_21_0:SetRightBtnEnabled(false)
end

function var_0_0.CloseChoice(arg_23_0)
	if not isNil(arg_23_0.choiceRoot_) then
		arg_23_0.choiceCtx = nil

		arg_23_0.choiceRoot_:SetActive(false)
		arg_23_0:SetRightBtnEnabled(true)
	end
end

function var_0_0.SetCanShow(arg_24_0, arg_24_1)
	arg_24_0.canShow = arg_24_1
end

function var_0_0.ChangeCanClickStatus(arg_25_0)
	if arg_25_0.needCallback and not arg_25_0.isInTextTween then
		arg_25_0.nextObj_:SetActive(true)
		arg_25_0.waitObj_:SetActive(false)
	else
		arg_25_0.nextObj_:SetActive(false)
		arg_25_0.waitObj_:SetActive(true)
	end
end

function var_0_0.SetNeedClickCallback(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0.needCallback = arg_26_2

	arg_26_0:ChangeCanClickStatus()
end

function var_0_0.SetSkipCallback(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0.skipBtn_.interactable = arg_27_1

	arg_27_0.skipEnableController_:SetSelectedState(arg_27_1 and "normal" or "lock")
	SetHIDButtonEnabled(arg_27_0.skipBtn_.gameObject, arg_27_1)

	arg_27_0.skipCallback = arg_27_2
end

function var_0_0.OnNextClick(arg_28_0)
	if arg_28_0.needCallback and Time.time - arg_28_0.startContentTimestamp > arg_28_0.minTtoleranceTime then
		if arg_28_0.isInTextTween then
			arg_28_0:StopContentRender()

			arg_28_0.contentWritter.percent = 1

			arg_28_0.contentWritter:SetDirty()

			if arg_28_0.choiceCtx then
				arg_28_0.choiceRoot_:SetActive(true)
			end
		else
			arg_28_0.needCallback:Invoke()
		end
	end
end

function var_0_0.OnSkipClick(arg_29_0)
	if arg_29_0.skipCallback then
		arg_29_0.skipCallback:Invoke()
	end
end

function var_0_0.OnAllBtnClick(arg_30_0)
	if arg_30_0.canShow then
		arg_30_0.isInEmpty = false

		arg_30_0.hideBtnController:SetSelectedState("show")
	end
end

function var_0_0.OnHideBtnClick(arg_31_0)
	if not arg_31_0.isInEmpty then
		arg_31_0.isInEmpty = true

		arg_31_0.hideBtnController:SetSelectedState("hide")
	end
end

function var_0_0.Hide(arg_32_0)
	arg_32_0:CloseChoice()
	arg_32_0.gameObject_:SetActive(false)
end

function var_0_0.ChangeAutoState(arg_33_0, arg_33_1)
	arg_33_0.autoController:SetSelectedState(arg_33_1 and "auto" or "manual")
	QWorldMgr:GetQWorldStoryMgr():ChangeAutoPlayState(arg_33_1)
end

function var_0_0.GetCanAutoNext(arg_34_0)
	return arg_34_0.nextAutoState
end

function var_0_0.ClearCanAutoFlag(arg_35_0)
	arg_35_0.nextAutoState = false
end

function var_0_0.SetRightBtnEnabled(arg_36_0, arg_36_1)
	arg_36_0.autoBtn_.interactable = arg_36_1

	arg_36_0.autoEnableController_:SetSelectedState(arg_36_1 and "normal" or "lock")
	SetHIDButtonEnabled(arg_36_0.autoBtn_.gameObject, arg_36_1)

	arg_36_0.manualBtn_.interactable = arg_36_1

	SetHIDButtonEnabled(arg_36_0.manualBtn_.gameObject, arg_36_1)
end

function var_0_0.BlackFadeEffect(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4, arg_37_5)
	local var_37_0 = arg_37_0.curBlackFadeCtx

	if var_37_0 then
		if var_37_0.centerCallback and not var_37_0.centerPass then
			var_37_0.centerCallback()
		end

		if var_37_0.callback and not var_37_0.doenPass then
			var_37_0.callback()
		end
	end

	arg_37_0.curBlackFadeCtx = {
		doenPass = false,
		centerPass = false,
		centerTime = arg_37_1,
		enterTime = arg_37_2,
		exitTime = arg_37_3,
		callback = arg_37_4,
		centerCallback = arg_37_5
	}

	arg_37_0:StopBlackFadeTimer()

	arg_37_0.startTimestamp = Time.time

	arg_37_0.blackPanelObj:SetActive(true)

	arg_37_0.blackFadeTimer = FrameTimer.New(function()
		local var_38_0 = Time.time - arg_37_0.startTimestamp
		local var_38_1 = var_38_0 / arg_37_0.curBlackFadeCtx.enterTime

		if var_38_1 > 1 then
			var_38_1 = 1
		end

		arg_37_0.blackPanelCanvas.alpha = var_38_1

		if var_38_0 >= arg_37_0.curBlackFadeCtx.enterTime then
			arg_37_0:StopBlackFadeTimer()
			arg_37_0:CenterFade()

			if arg_37_5 then
				arg_37_0.curBlackFadeCtx.centerPass = true

				arg_37_5()
			end
		end
	end, 1, -1)

	arg_37_0.blackFadeTimer:Start()
end

function var_0_0.CenterFade(arg_39_0)
	arg_39_0:StopBlackFadeTimer()

	arg_39_0.startTimestamp = Time.time
	arg_39_0.blackFadeTimer = FrameTimer.New(function()
		local var_40_0 = Time.time - arg_39_0.startTimestamp

		if var_40_0 / arg_39_0.curBlackFadeCtx.centerTime > 1 then
			local var_40_1 = 1
		end

		arg_39_0.blackPanelCanvas.alpha = 1

		if var_40_0 >= arg_39_0.curBlackFadeCtx.centerTime then
			arg_39_0:StopBlackFadeTimer()
			arg_39_0:ExitFade()
		end
	end, 1, -1)

	arg_39_0.blackFadeTimer:Start()
end

function var_0_0.ExitFade(arg_41_0)
	arg_41_0:StopBlackFadeTimer()

	arg_41_0.startTimestamp = Time.time
	arg_41_0.blackFadeTimer = FrameTimer.New(function()
		local var_42_0 = Time.time - arg_41_0.startTimestamp
		local var_42_1 = var_42_0 / arg_41_0.curBlackFadeCtx.exitTime

		if var_42_1 > 1 then
			var_42_1 = 1
		end

		arg_41_0.blackPanelCanvas.alpha = 1 - var_42_1

		if var_42_0 >= arg_41_0.curBlackFadeCtx.exitTime then
			arg_41_0:StopBlackFadeTimer()
			arg_41_0.blackPanelObj:SetActive(false)

			local var_42_2 = arg_41_0.curBlackFadeCtx.callback

			arg_41_0.curBlackFadeCtx.doenPass = true
			arg_41_0.curBlackFadeCtx = nil

			if var_42_2 then
				var_42_2()
			end
		end
	end, 1, -1)

	arg_41_0.blackFadeTimer:Start()
end

function var_0_0.StopBlackFadeTimer(arg_43_0)
	if arg_43_0.blackFadeTimer then
		arg_43_0.blackFadeTimer:Stop()

		arg_43_0.blackFadeTimer = nil
	end
end

function var_0_0.Dispose(arg_44_0)
	arg_44_0:StopContentRender()
	arg_44_0:StopBlackFadeTimer()
	GameObject.Destroy(arg_44_0.gameObject_)
	Asset.Unload(arg_44_0:GetUIName())
	var_0_0.super.Dispose(arg_44_0)
end

return var_0_0
