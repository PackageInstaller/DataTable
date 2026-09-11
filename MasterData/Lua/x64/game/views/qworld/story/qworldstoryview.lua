local QWorldStoryView = class("QWorldStoryView", import("game.extend.ReduxView"))

function QWorldStoryView:GetUIName()
	return "Widget/System/SandPlay/SandPlay_Story/SandPlay_ChatUI"
end

function QWorldStoryView:Ctor()
	self.gameObject_ = Object.Instantiate(Asset.Load(self:GetUIName()), manager.ui.uiStory.transform)
	self.transform_ = self.gameObject_.transform

	self:AdaptScreen()
	self:Hide()
	self:Init()
end

function QWorldStoryView:BuildContext()
	self.choice = {
		list = {}
	}
	self.choiceCtx = nil
	self.isInEmpty = false
	self.timePerText = 0.2
	self.curText = ""
	self.totalTextTimer = 0
	self.minTtoleranceTime = 0.6
	self.canShow = true
	self.nextAutoState = false
	self.backupAutoPlay = false
end

function QWorldStoryView:Init()
	self:InitUI()
	self:BuildContext()
end

function QWorldStoryView:InitUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject_)
	self.blackPanelObj:SetActive(false)

	self.hideBtnController = self.controller_:GetController("hideBtns")
	self.contentWritter = self.contentTxt_.gameObject:GetComponent("UITypewriterEffect")
	self.autoController = self.controller_:GetController("autoplay")
	self.skipEnableController_ = self.skipControllerEx_:GetController("skip")
	self.autoEnableController_ = self.autoControllerEx_:GetController("auto")

	self:AddListener()
end

function QWorldStoryView:AddListener()
	self:AddBtnListener(self.nextBtn_, nil, function()
		self:OnNextClick()
	end)
	self:AddBtnListener(self.skipBtn_, nil, function()
		self:ChangeAutoState(false)
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("TIP_SKIP_PLOT"),
			OkCallback = function()
				self:OnSkipClick()
			end
		})
	end)
	self:AddBtnListener(self.allBtn_, nil, function()
		if not self.isInEmpty then
			self:OnNextClick()
		else
			self:OnAllBtnClick()
		end
	end)
	self:AddBtnListener(self.hideBtn_, nil, function()
		self:ChangeAutoState(false)
		self:OnHideBtnClick()
	end)
	self:AddBtnListener(self.historyBtn_, nil, function()
		self.backupAutoPlay = QWorldMgr:GetQWorldStoryMgr():GetAutoPlayState()

		self:ChangeAutoState(false)
		JumpTools.OpenPageByJump("qworldStoryHistory")
	end)
	self:AddBtnListener(self.autoBtn_, nil, function()
		self:ChangeAutoState(true)
	end)
	self:AddBtnListener(self.manualBtn_, nil, function()
		self:ChangeAutoState(false)
	end)
	self:RegistEventListener(QWORLD_STORY_HISTORY_OPEN, function(arg_15_0)
		if arg_15_0 then
			self.gameObject_:SetActive(false)
		else
			self.gameObject_:SetActive(true)

			if self.backupAutoPlay then
				self.backupAutoPlay = false

				self:ChangeAutoState(true)
			end
		end
	end)
end

function QWorldStoryView:Show()
	self.gameObject_:SetActive(true)
	CursorTools.LuaSwitchCursor(false)
end

function QWorldStoryView:RenderContent(arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = SandplayStoryTalkCfg[tonumber(arg_17_1)]

	self:StartContetnRender(var_17_0.dialogue_text, (var_17_0.cue_sheet and var_17_0.cue_sheet ~= "" or nil) and manager.audio:GetVoiceLength(var_17_0.cue_sheet, var_17_0.cue_name, true) / 1000)

	self.nameTxt_.text = SandplayStoryTalkCfg[tonumber(arg_17_1)].speaker_name
end

function QWorldStoryView:StartContetnRender(arg_18_1, arg_18_2)
	self.nextAutoState = false
	self.contentTxt_.text = arg_18_1
	self.contentWritter.percent = 0

	self.contentWritter:SetDirty()

	self.curText = arg_18_1
	self.totalTextCount = utf8len(arg_18_1)
	self.totalTextTimer = self.totalTextCount * (1 / SandplaySettingCfg.story_word_display.value[1])
	self.autoTextTimer = 1 / SandplaySettingCfg.story_word_duration.value[1] * self.totalTextCount
	self.autoTextTimer = math.max(self.autoTextTimer, SandplaySettingCfg.story_word_duration.value[2])
	self.autoTextTimer = math.max(self.autoTextTimer, arg_18_2 or 0)

	self:StopContentRender()

	self.startContentTimestamp = Time.time
	self.isInTextTween = true
	self.choiceRootActive = false

	self:ChangeCanClickStatus()

	self.contentTimer = FrameTimer.New(function()
		if (Time.time - self.startContentTimestamp) / self.totalTextTimer > 1 then
			self.contentWritter.percent = 1
		end

		self.contentWritter:SetDirty()

		if Time.time - self.startContentTimestamp >= self.totalTextTimer then
			if self.choiceCtx and not self.choiceRootActive then
				self.choiceRootActive = true

				self.choiceRoot_:SetActive(true)
			elseif not self.choiceCtx and Time.time - self.startContentTimestamp >= self.autoTextTimer then
				self:StopContentRender()

				self.nextAutoState = true
			end

			if self.isInTextTween then
				self.isInTextTween = false

				self:ChangeCanClickStatus()
			end
		end
	end, 1, -1)

	self.contentTimer:Start()
end

function QWorldStoryView:StopContentRender()
	if self.contentTimer then
		self.contentTimer:Stop()

		self.contentTimer = nil
		self.isInTextTween = false

		self:ChangeCanClickStatus()
	end
end

function QWorldStoryView:OpenChoice(arg_21_1, arg_21_2)
	self.nextAutoState = false
	self.choiceCtx = arg_21_1

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

	if #self.choice.list > arg_21_1.Length + #var_21_1 then
		for iter_21_0 = var_21_2 + #var_21_1, #self.choice.list do
			self.choice.list[iter_21_0]:Reset()
			self.choice.list[iter_21_0]:Hide()
		end
	end

	for iter_21_1 = 1, #var_21_1 do
		self.choice.list[iter_21_1] = self.choice.list[iter_21_1] or QWorldStoryChoiceItem.New((GameObject.Instantiate(self.choiceItem_, self.choiceContent_)))

		self.choice.list[iter_21_1]:Reset()
		self.choice.list[iter_21_1]:RenderFuncChoice(var_21_1[iter_21_1])
		self.choice.list[iter_21_1]:Show()

		if var_21_1[iter_21_1].type == QWorldConst.TagType.Quest then
			table.insert(var_21_0.task, var_21_1[iter_21_1].id)
		else
			table.insert(var_21_0.tag, var_21_1[iter_21_1].id)
		end
	end

	local var_21_3 = #var_21_1 + 1

	if #var_21_1 == 0 then
		var_21_3 = 1
	end

	for iter_21_2 = var_21_3, var_21_2 + #var_21_1 do
		local var_21_4 = iter_21_2 - var_21_3 + 1

		self.choice.list[iter_21_2] = self.choice.list[iter_21_2] or QWorldStoryChoiceItem.New((GameObject.Instantiate(self.choiceItem_, self.choiceContent_)))

		self.choice.list[iter_21_2]:Reset()
		self.choice.list[iter_21_2]:RenderView(self.choiceCtx[iter_21_2 - var_21_3 + 1 - 1].id)
		self.choice.list[iter_21_2]:RegistCallback(function()
			self.choiceCtx[var_21_4 - 1]:Invoke()
		end)
		self.choice.list[iter_21_2]:Show()
		table.insert(var_21_0.talkBranch, self.choiceCtx[iter_21_2 - var_21_3 + 1 - 1].id)
	end

	local var_21_5 = table.toString(var_21_0)

	for iter_21_3 = 1, var_21_2 + #var_21_1 do
		if self.choice.list[iter_21_3] then
			self.choice.list[iter_21_3]:SetSdkChoice(var_21_5)
		end
	end

	self:SetRightBtnEnabled(false)
end

function QWorldStoryView:CloseChoice()
	if not isNil(self.choiceRoot_) then
		self.choiceCtx = nil

		self.choiceRoot_:SetActive(false)
		self:SetRightBtnEnabled(true)
	end
end

function QWorldStoryView:SetCanShow(arg_24_1)
	self.canShow = arg_24_1
end

function QWorldStoryView:ChangeCanClickStatus()
	if self.needCallback and not self.isInTextTween then
		self.nextObj_:SetActive(true)
		self.waitObj_:SetActive(false)
	else
		self.nextObj_:SetActive(false)
		self.waitObj_:SetActive(true)
	end
end

function QWorldStoryView:SetNeedClickCallback(arg_26_1, arg_26_2)
	self.needCallback = arg_26_2

	self:ChangeCanClickStatus()
end

function QWorldStoryView:SetSkipCallback(arg_27_1, arg_27_2)
	self.skipBtn_.interactable = arg_27_1

	self.skipEnableController_:SetSelectedState(arg_27_1 and "normal" or "lock")
	SetHIDButtonEnabled(self.skipBtn_.gameObject, arg_27_1)

	self.skipCallback = arg_27_2
end

function QWorldStoryView:OnNextClick()
	if self.needCallback and Time.time - self.startContentTimestamp > self.minTtoleranceTime then
		if self.isInTextTween then
			self:StopContentRender()

			self.contentWritter.percent = 1

			self.contentWritter:SetDirty()

			if self.choiceCtx then
				self.choiceRoot_:SetActive(true)
			end
		else
			self.needCallback:Invoke()
		end
	end
end

function QWorldStoryView:OnSkipClick()
	if self.skipCallback then
		self.skipCallback:Invoke()
	end
end

function QWorldStoryView:OnAllBtnClick()
	if self.canShow then
		self.isInEmpty = false

		self.hideBtnController:SetSelectedState("show")
	end
end

function QWorldStoryView:OnHideBtnClick()
	if not self.isInEmpty then
		self.isInEmpty = true

		self.hideBtnController:SetSelectedState("hide")
	end
end

function QWorldStoryView:Hide()
	self:CloseChoice()
	self.gameObject_:SetActive(false)
end

function QWorldStoryView:ChangeAutoState(arg_33_1)
	self.autoController:SetSelectedState(arg_33_1 and "auto" or "manual")
	QWorldMgr:GetQWorldStoryMgr():ChangeAutoPlayState(arg_33_1)
end

function QWorldStoryView:GetCanAutoNext()
	return self.nextAutoState
end

function QWorldStoryView:ClearCanAutoFlag()
	self.nextAutoState = false
end

function QWorldStoryView:SetRightBtnEnabled(arg_36_1)
	self.autoBtn_.interactable = arg_36_1

	self.autoEnableController_:SetSelectedState(arg_36_1 and "normal" or "lock")
	SetHIDButtonEnabled(self.autoBtn_.gameObject, arg_36_1)

	self.manualBtn_.interactable = arg_36_1

	SetHIDButtonEnabled(self.manualBtn_.gameObject, arg_36_1)
end

function QWorldStoryView:BlackFadeEffect(arg_37_1, arg_37_2, arg_37_3, arg_37_4, arg_37_5)
	if self.curBlackFadeCtx then
		if self.curBlackFadeCtx.centerCallback and not self.curBlackFadeCtx.centerPass then
			self.curBlackFadeCtx.centerCallback()
		end

		if self.curBlackFadeCtx.callback and not self.curBlackFadeCtx.doenPass then
			self.curBlackFadeCtx.callback()
		end
	end

	self.curBlackFadeCtx = {
		doenPass = false,
		centerPass = false,
		centerTime = arg_37_1,
		enterTime = arg_37_2,
		exitTime = arg_37_3,
		callback = arg_37_4,
		centerCallback = arg_37_5
	}

	self:StopBlackFadeTimer()

	self.startTimestamp = Time.time

	self.blackPanelObj:SetActive(true)

	self.blackFadeTimer = FrameTimer.New(function()
		if (Time.time - self.startTimestamp) / self.curBlackFadeCtx.enterTime > 1 then
			self.blackPanelCanvas.alpha = 1
		end

		if Time.time - self.startTimestamp >= self.curBlackFadeCtx.enterTime then
			self:StopBlackFadeTimer()
			self:CenterFade()

			if arg_37_5 then
				self.curBlackFadeCtx.centerPass = true

				arg_37_5()
			end
		end
	end, 1, -1)

	self.blackFadeTimer:Start()
end

function QWorldStoryView:CenterFade()
	self:StopBlackFadeTimer()

	self.startTimestamp = Time.time
	self.blackFadeTimer = FrameTimer.New(function()
		if (Time.time - self.startTimestamp) / self.curBlackFadeCtx.centerTime > 1 then
			-- block empty
		end

		self.blackPanelCanvas.alpha = 1

		if Time.time - self.startTimestamp >= self.curBlackFadeCtx.centerTime then
			self:StopBlackFadeTimer()
			self:ExitFade()
		end
	end, 1, -1)

	self.blackFadeTimer:Start()
end

function QWorldStoryView:ExitFade()
	self:StopBlackFadeTimer()

	self.startTimestamp = Time.time
	self.blackFadeTimer = FrameTimer.New(function()
		self.blackPanelCanvas.alpha = 1 - (((Time.time - self.startTimestamp) / self.curBlackFadeCtx.exitTime > 1 or nil) and 1)

		if Time.time - self.startTimestamp >= self.curBlackFadeCtx.exitTime then
			self:StopBlackFadeTimer()
			self.blackPanelObj:SetActive(false)

			self.curBlackFadeCtx.doenPass = true
			self.curBlackFadeCtx = nil

			if self.curBlackFadeCtx.callback then
				self.curBlackFadeCtx.callback()
			end
		end
	end, 1, -1)

	self.blackFadeTimer:Start()
end

function QWorldStoryView:StopBlackFadeTimer()
	if self.blackFadeTimer then
		self.blackFadeTimer:Stop()

		self.blackFadeTimer = nil
	end
end

function QWorldStoryView:Dispose()
	self:StopContentRender()
	self:StopBlackFadeTimer()
	GameObject.Destroy(self.gameObject_)
	Asset.Unload(self:GetUIName())
	QWorldStoryView.super.Dispose(self)
end

return QWorldStoryView
