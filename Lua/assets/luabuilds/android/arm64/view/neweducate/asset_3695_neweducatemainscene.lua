local NewEducateMainScene = class("NewEducateMainScene", import("view.newEducate.base.NewEducateBaseUI"))

function NewEducateMainScene:getUIName()
	return "NewEducateMainUI"
end

function NewEducateMainScene:PlayBGM()
	local var_2_0 = self.contextData.char:GetBgm()

	if var_2_0 then
		pg.BgmMgr.GetInstance():Push(self.__cname, var_2_0)
	end

	return
end

function NewEducateMainScene:init()
	self.rootTF = self._tf:Find("root")
	self.mainAnim = self.rootTF:GetComponent(typeof(Animation))
	self.bgTF = self.rootTF:Find("bg")
	self.paintTF = self.rootTF:Find("painting")
	self.dialogueTF = self.rootTF:Find("main/dialogue")
	self.dialogueContent = self.dialogueTF:Find("content")

	setActive(self.dialogueTF, false)
	setActive(self.dialogueTF:Find("arrows"), false)

	self.topicBtn = self.rootTF:Find("main/topic")

	setActive(self.topicBtn, false)

	self.mindBtn = self.rootTF:Find("main/mind")

	setActive(self.mindBtn, false)

	self.adaptTF = self.rootTF:Find("adapt")
	self.favorTF = self.adaptTF:Find("favor")
	self.normalBtns = self.adaptTF:Find("normal")
	self.scheduleBtn = self.normalBtns:Find("schedule")
	self.mapBtn = self.normalBtns:Find("map")
	self.endingBtn = self.adaptTF:Find("ending")
	self.resetInEndlessBtn = self.adaptTF:Find("reset_endless")
	self.resetBtns = self.adaptTF:Find("reset")
	self.resetBtn = self.resetBtns:Find("reset")
	self.endlessBtn = self.resetBtns:Find("endless")
	self.topPanel = NewEducateTopPanel.New(self.adaptTF, self.event, setmetatable({
		hideBlurBg = true
	}, {
		__index = self.contextData
	}))

	self.topPanel:RegisterView(self)

	self.infoPanel = NewEducateInfoPanel.New(self.adaptTF, self.event, self.contextData)

	self.infoPanel:RegisterView(self)

	self.roundTipPanel = NewEducateRoundTipPanel.New(self.adaptTF, self.event, self.contextData)

	self.roundTipPanel:RegisterView(self)

	self.assessPanel = NewEducateAssessPanel.New(self.adaptTF, self.event, self.contextData)

	self.assessPanel:RegisterView(self)

	self.favorPanel = NewEducateFavorPanel.New(self.adaptTF, self.event, self.contextData)

	self.favorPanel:RegisterView(self)

	self.personalityTipPanel = NewEducatePersonalityTipPanel.New(self.adaptTF, self.event, self.contextData)

	self.personalityTipPanel:RegisterView(self)

	self.nodePanel = NewEducateNodePanel.New(self.adaptTF, self.event, setmetatable({
		view = self
	}, {
		__index = self.contextData
	}))

	self.nodePanel:RegisterView(self)

	return
end

function NewEducateMainScene:didEnter()
	LoadImageSpriteAsync("neweducateicon/" .. self.contextData.char:getConfig("child2_data_personality_icon")[2], self.mindBtn, true)
	onButton(self, self.paintTF:Find("fitter"), function()
		self:ShowDialogue()

		return
	end, SFX_PANEL)
	onButton(self, self.mindBtn, function()
		if self.contextData.char:GetFSM():CheckPriorityStystem() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("child2_priority_tip"))

			return
		end

		setActive(self.mindBtn, false)
		self:emit(NewEducateMainMediator.ON_SELECT_MIND, function()
			self:SeriesCheck()

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, self.favorTF, function()
		if self.contextData.char:GetFSM():CheckPriorityStystem() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("child2_priority_tip"))

			return
		end

		self.favorPanel:ExecuteAction("Show")

		return
	end, SFX_PANEL)
	onButton(self, self.scheduleBtn, function()
		if self.contextData.char:GetFSM():CheckPriorityStystem() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("child2_priority_tip"))

			return
		end

		self:emit(NewEducateMainScene.GO_SCENE, SCENE.NEW_EDUCATE_SCHEDULE, {
			scheduleDataTable = self.contextData.scheduleDataTable
		})

		return
	end, SFX_PANEL)
	onButton(self, self.mapBtn, function()
		if self.contextData.char:GetFSM():CheckPriorityStystem() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("child2_priority_tip"))

			return
		end

		if not self.contextData.char:IsUnlock("out") then
			return
		end

		self:emit(NewEducateMainScene.GO_SCENE, SCENE.NEW_EDUCATE_MAP)

		return
	end, SFX_PANEL)
	onButton(self, self.endingBtn, function()
		self:OnEndingClick()

		return
	end, SFX_PANEL)
	onButton(self, self.resetBtn, function()
		self:OnClickResetBtn()

		return
	end, SFX_PANEL)
	onButton(self, self.resetInEndlessBtn, function()
		self:OnClickResetInEndlessBtn()

		return
	end, SFX_PANEL)
	onButton(self, self.endlessBtn, function()
		self:OnClickEndlessBtn()

		return
	end, SFX_PANEL)
	onButton(self, self.topicBtn, function()
		setActive(self.topicBtn, false)

		local var_15_0 = self.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.TOPIC):GetTopics()

		if var_15_0[1] then
			self:emit(NewEducateMainMediator.ON_SELECT_TOPIC, var_15_0[1])
		end

		return
	end, SFX_PANEL)
	self:UpdatePaintingUI()
	self:UpdateFavorInfo()
	self:UpdateUnlockUI()

	self.contextData.scheduleDataTable = self.contextData.scheduleDataTable or {}

	seriesAsync({
		function(arg_16_0)
			self:CheckNewChar(arg_16_0)

			return
		end
	}, function()
		if self.contextData.scheduleDataTable.OnScheduleDone then
			self.contextData.scheduleDataTable.OnScheduleDone = nil

			if #self.contextData.scheduleDataTable.OnScheduleDone.drops == 0 then
				existCall(self.contextData.scheduleDataTable.OnScheduleDone.callback)
			else
				self:emit(NewEducateBaseUI.ON_DROP, {
					items = self.contextData.scheduleDataTable.OnScheduleDone.drops,
					removeFunc = self.contextData.scheduleDataTable.OnScheduleDone.callback
				})
			end
		else
			self:SeriesCheck()
		end

		return
	end)

	self.newRoundDrops = {}

	return
end

function NewEducateMainScene:_loadSubViews()
	self.topPanel:Load()
	self.infoPanel:Load()

	return
end

function NewEducateMainScene:SeriesCheck()
	local var_19_0 = {}

	table.insert(var_19_0, function(arg_20_0)
		self:CheckFavorUpgrade(arg_20_0)

		return
	end)
	seriesAsync(var_19_0, function()
		self:CheckFSM()

		return
	end)

	return
end

function NewEducateMainScene:UpdatePaintingUI()
	setImageSprite(self.bgTF, LoadSprite("bg/" .. self.contextData.char:GetRoundData():getConfig("main_background")), false)

	self.paintingName = self.contextData.char:GetPaintingName()

	setPaintingPrefab(self.paintTF, self.paintingName, "yangcheng")

	self.wordList, self.faceList = self.contextData.char:GetMainDialogueInfo()

	return
end

function NewEducateMainScene:HideDialogueUI()
	self.isShowInfoPanel = self.infoPanel:isShowing() and self.infoPanel:IsShowPanel()

	self.infoPanel:ExecuteAction("HidePanel")
	self.topPanel:ExecuteAction("PlayHide")
	self.mainAnim:Play("anim_educate_mainui_icon_hide")

	return
end

function NewEducateMainScene:ShowDialogueUI()
	if self.isShowInfoPanel then
		self.infoPanel:ExecuteAction("ShowPanel")
	end

	self.topPanel:ExecuteAction("PlayShow")
	self.mainAnim:Play("anim_educate_mainui_icon_show")

	return
end

function NewEducateMainScene:UpdatePaintingFace(arg_25_1)
	if self.paintTF:Find("fitter").childCount == 0 then
		return
	end

	local var_25_0 = self.paintTF:Find("fitter"):GetChild(0):Find("face")

	if arg_25_1 == 0 then
		if var_25_0 then
			setActive(var_25_0, false)
		end

		self:ShowDialogueUI()

		return
	end

	if pg.child2_node[arg_25_1].type == NewEducateNodePanel.NODE_TYPE.MAIN_TEXT then
		if pg.child2_word[pg.child2_node[arg_25_1].text].main_character_face == 0 then
			if var_25_0 then
				setActive(var_25_0, false)
			end
		else
			local var_25_1 = GetSpriteFromAtlas("paintingface/" .. self.paintingName, pg.child2_word[pg.child2_node[arg_25_1].text].main_character_face)

			if var_25_0 and var_25_1 then
				setImageSprite(var_25_0, var_25_1)
				setActive(var_25_0, true)
			end
		end
	end

	return
end

function NewEducateMainScene:ShowDialogue()
	if LeanTween.isTweening(self.dialogueTF) then
		return
	end

	local var_26_0 = math.random(#self.wordList)

	setText(self.dialogueContent, (string.gsub(pg.child2_word[self.wordList[var_26_0]].word, "$1", self.contextData.char:GetCallName())))

	local var_26_1 = GetSpriteFromAtlas("paintingface/" .. self.paintingName, self.faceList[var_26_0])
	local var_26_2 = self.paintTF:Find("fitter"):GetChild(0):Find("face")

	if var_26_2 and var_26_1 then
		setImageSprite(var_26_2, var_26_1)
		setActive(var_26_2, true)
	end

	self.dialogueTF.localScale = Vector3.zero

	setActive(self.dialogueTF, true)
	LeanTween.scale(self.dialogueTF, Vector3.one, 0.3):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
		LeanTween.scale(self.dialogueTF, Vector3.zero, 0.3):setEase(LeanTweenType.easeInBack):setDelay(3):setOnComplete(System.Action(function()
			setActive(self.dialogueTF, false)

			if var_26_2 then
				setActive(var_26_2, false)
			end

			return
		end))

		return
	end))

	return
end

function NewEducateMainScene:UpdataTopicAndMind()
	local var_29_0 = self.contextData.char:GetFSM()
	local var_29_1 = self.contextData.char:GetRoundData()
	local var_29_2 = var_29_0:GetState(NewEducateFSM.SYSTEM.TOPIC)

	if var_29_1:IsTemp() or var_29_2 and var_29_2:IsFinish() then
		setActive(self.topicBtn, false)
	else
		setActive(self.topicBtn, true)
	end

	local var_29_3 = var_29_1:getConfig("main_event_chat_node_id")

	if var_29_3 ~= "" and #var_29_3 > 0 and not var_29_1:IsTemp() then
		setActive(self.mindBtn, not var_29_0:GetState(NewEducateFSM.SYSTEM.MIND))
	else
		setActive(self.mindBtn, false)
	end

	return
end

function NewEducateMainScene:CheckNewChar(arg_30_1)
	if self.contextData.char:GetCallName() == "" then
		setActive(self._tf, false)

		local var_30_0 = self.contextData.char:getConfig("special_memory")
		local var_30_1 = {}

		table.insert(var_30_1, function(arg_31_0)
			NewEducateHelper.PlaySpecialStoryList(var_30_0.pre_name, arg_31_0, true)

			return
		end)
		table.insert(var_30_1, function(arg_32_0)
			self:emit(NewEducateMainScene.GO_SUBLAYER, Context.New({
				mediator = NewEducateSetCallediator,
				viewComponent = NewEducateSetCallLayer,
				data = {
					callback = arg_32_0
				}
			}))

			return
		end)
		table.insert(var_30_1, function(arg_33_0)
			NewEducateHelper.PlaySpecialStoryList(var_30_0.after_name, arg_33_0, true)

			return
		end)

		self.lockBackPressed = true

		seriesAsync(var_30_1, function()
			setActive(self._tf, true)
			self:_loadSubViews()
			arg_30_1()

			self.lockBackPressed = false

			return
		end)
	else
		self:_loadSubViews()
		arg_30_1()
	end

	return
end

function NewEducateMainScene:UpdateFavorInfo()
	setText(self.favorTF:Find("Text"), "Lv" .. self.contextData.char:GetFavorInfo().lv)

	return
end

function NewEducateMainScene:CheckFavorUpgrade(arg_36_1)
	if self.contextData.char:CheckFavor() then
		self:emit(NewEducateMainMediator.ON_UPGRADE_FAVOR, arg_36_1)
	else
		existCall(arg_36_1)
	end

	return
end

function NewEducateMainScene:CheckFSM()
	if self.contextData.char:GetFSM():CheckPriorityStystem() then
		self:emit(NewEducateMainScene.ON_PRIORITY_STATE)
	else
		self:CheckGameFSM()
	end

	return
end

function NewEducateMainScene:CheckGameFSM()
	local var_38_0 = self.contextData.char:GetFSM()
	local var_38_1 = var_38_0:CheckStystem()

	warning("CheckGameFSM", var_38_0:GetSystemNo() .. "->" .. var_38_1)
	self:UpdateStateUI(var_38_1)
	switch(var_38_1, {
		[NewEducateFSM.SYSTEM.EVENT] = function()
			self:EventHandler()

			return
		end,
		[NewEducateFSM.SYSTEM.TALENT] = function()
			self:TalentHandler()

			return
		end,
		[NewEducateFSM.SYSTEM.TOPIC] = function()
			self:TopicHandler()

			return
		end,
		[NewEducateFSM.SYSTEM.MAP] = function()
			self:MapHandler()

			return
		end,
		[NewEducateFSM.SYSTEM.PLAN] = function()
			self:PlanHandler()

			return
		end,
		[NewEducateFSM.SYSTEM.ASSESS] = function()
			self:AssessHandler()

			return
		end,
		[NewEducateFSM.SYSTEM.PHASE] = function()
			self:StageHandler()

			return
		end,
		[NewEducateFSM.SYSTEM.ENDING] = function()
			self:EndingHandler()

			return
		end,
		[NewEducateFSM.SYSTEM.MIND] = function()
			self:MindHandler()

			return
		end,
		[NewEducateFSM.SYSTEM.CHOOSE] = function()
			self:ChooseHandler()

			return
		end,
		[NewEducateFSM.SYSTEM.FAIL] = function()
			self:FailHandler()

			return
		end
	}, function()
		assert(false, "不合法FSM状态")

		return
	end)

	return
end

function NewEducateMainScene:OnReset()
	self:HideDialogueUI()
	self.infoPanel:ExecuteAction("Hide")

	self.contextData.char = getProxy(NewEducateProxy):GetCurChar()

	setActive(self.topicBtn, false)
	setActive(self.mindBtn, false)
	self.infoPanel:ExecuteAction("Flush")
	self.topPanel:ExecuteAction("Flush", NewEducateFSM.SYSTEM.INIT)
	self:UpdatePaintingUI()
	self:UpdateUnlockUI()
	seriesAsync({
		function(arg_52_0)
			self:CheckNewChar(arg_52_0)

			return
		end
	}, function()
		self:ShowDialogueUI()
		self.infoPanel:ExecuteAction("Show")
		self:SeriesCheck()

		return
	end)

	return
end

function NewEducateMainScene:UpdateStateUI(arg_54_1)
	self:UpdateBtns(arg_54_1)
	self.topPanel:ExecuteAction("FlushProgress", arg_54_1)

	return
end

function NewEducateMainScene:UpdateBtns(arg_55_1)
	setActive(self.endingBtn, false)
	setActive(self.resetBtns, false)
	setActive(self.endlessBtn, false)

	local var_55_0 = self.contextData.char:GetRoundData()

	setActive(self.resetInEndlessBtn, var_55_0:IsEndless())
	setActive(self.normalBtns, arg_55_1 ~= NewEducateFSM.SYSTEM.ENDING and not var_55_0:IsEndlessFail())

	local var_55_1 = self.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.MAP)

	setActive(self.mapBtn:Find("tip"), var_55_1 and var_55_1:IsSpecial())

	return
end

function NewEducateMainScene:AddNewRoundDrops(arg_56_1)
	self.newRoundDrops = arg_56_1

	return
end

function NewEducateMainScene:ContinuePlayNode()
	seriesAsync({
		function(arg_58_0)
			self:emit(NewEducateMainScene.ON_BOX, {
				hideClose = true,
				content = i18n("child2_replay_tip"),
				noText = i18n("child2_replay_clear"),
				yesText = i18n("child2_replay_continue"),
				onYes = arg_58_0,
				onNo = function()
					self:emit(NewEducateMainMediator.ON_CLEAR_NODE_CHAIN)

					return
				end
			})

			return
		end
	}, function()
		self:OnNodeStart(self.contextData.char:GetFSM():GetCurNode())

		return
	end)

	return
end

function NewEducateMainScene:EventHandler()
	if self.contextData.char:GetFSM():GetCurNode() ~= 0 then
		self:ContinuePlayNode()

		return
	end

	seriesAsync({
		function(arg_62_0)
			self.roundTipPanel:ExecuteAction("Show", arg_62_0)

			return
		end,
		function(arg_63_0)
			if #self.newRoundDrops > 0 then
				self:emit(NewEducateBaseUI.ON_DROP, {
					items = self.newRoundDrops,
					removeFunc = arg_63_0
				})
			else
				arg_63_0()
			end

			return
		end
	}, function()
		self.newRoundDrops = {}

		self:emit(NewEducateMainMediator.ON_TRIGGER_MAIN_EVENT)

		return
	end)

	return
end

function NewEducateMainScene:TalentHandler()
	local var_65_0 = self.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.TALENT)

	seriesAsync({
		function(arg_66_0)
			if not var_65_0 then
				self:emit(NewEducateMainMediator.ON_REQ_TALENTS, arg_66_0)
			else
				arg_66_0()
			end

			return
		end,
		function(arg_67_0)
			if self.contextData.char:GetRoundData():IsTalentRound() then
				self:emit(NewEducateMainScene.GO_SUBLAYER, Context.New({
					mediator = NewEducateTalentMediator,
					viewComponent = NewEducateTalentLayer,
					data = {
						onExit = arg_67_0
					}
				}))
			else
				arg_67_0()
			end

			return
		end
	}, function()
		self:SeriesCheck()

		return
	end)

	return
end

function NewEducateMainScene:ReqParallelData()
	local var_69_0 = self.contextData.char:GetFSM()

	seriesAsync({
		function(arg_70_0)
			if not self.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.TOPIC) then
				self:emit(NewEducateMainMediator.ON_REQ_TOPICS, arg_70_0)
			else
				arg_70_0()
			end

			return
		end,
		function(arg_71_0)
			if not self.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.MAP) then
				self:emit(NewEducateMainMediator.ON_REQ_MAP)
			else
				arg_71_0()
			end

			return
		end
	}, function()
		self:UpdataTopicAndMind()
		NewEducateGuideSequence.CheckGuide(self.__cname)

		return
	end)

	return
end

function NewEducateMainScene:TopicHandler()
	if self.contextData.char:GetFSM():GetCurNode() ~= 0 then
		self:ContinuePlayNode()

		return
	end

	self:ReqParallelData()

	return
end

function NewEducateMainScene:MindHandler()
	if self.contextData.char:GetFSM():GetCurNode() ~= 0 then
		self:ContinuePlayNode()

		return
	end

	self:ReqParallelData()

	return
end

function NewEducateMainScene:MapHandler()
	if self.contextData.char:GetFSM():GetCurNode() ~= 0 then
		self:emit(NewEducateMainScene.ON_BOX, {
			hideClose = true,
			content = i18n("child2_replay_tip"),
			noText = i18n("child2_replay_clear"),
			yesText = i18n("child2_replay_continue"),
			onYes = function()
				self:emit(NewEducateMainScene.GO_SCENE, SCENE.NEW_EDUCATE_MAP)

				return
			end,
			onNo = function()
				self:emit(NewEducateMainMediator.ON_CLEAR_NODE_CHAIN)

				return
			end
		})

		return
	end

	self:ReqParallelData()

	return
end

function NewEducateMainScene:PlanHandler()
	if self.contextData.char:GetFSM():GetCurNode() ~= 0 then
		self:ContinuePlayNode()

		return
	end

	self:emit(NewEducateMainMediator.ON_NEXT_PLAN, true)

	return
end

function NewEducateMainScene:AssessHandler()
	if self.contextData.char:GetFSM():GetCurNode() ~= 0 then
		self:ContinuePlayNode()

		return
	end

	local var_79_0 = self.contextData.char:GetAssessPreStory()
	local var_79_1 = self.contextData.char:GetAssessRankIdx()

	seriesAsync({
		function(arg_80_0)
			if self.contextData.char:GetFSM():GetSystemNo() ~= NewEducateFSM.SYSTEM.ASSESS then
				self:emit(NewEducateMainMediator.ON_ENTER_ASSESS, arg_80_0)
			else
				arg_80_0()
			end

			return
		end,
		function(arg_81_0)
			if var_79_0 and var_79_0 ~= "" then
				NewEducateHelper.PlaySpecialStory(var_79_0, arg_81_0, true)
			else
				arg_81_0()
			end

			return
		end,
		function(arg_82_0)
			if var_79_1 ~= 0 then
				self.assessPanel:ExecuteAction("Show", arg_82_0)
			else
				self.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.ASSESS):MarkFinish()
				arg_82_0()
			end

			return
		end
	}, function(arg_83_0)
		self:SeriesCheck()

		return
	end)

	return
end

function NewEducateMainScene:StageHandler()
	if self.assessPanel:isShowing() then
		self.assessPanel:ExecuteAction("Hide")
	end

	if self.contextData.char:GetFSM():GetCurNode() ~= 0 then
		self:ContinuePlayNode()

		return
	end

	self:emit(NewEducateMainMediator.ON_STAGE_CHANGE)

	return
end

function NewEducateMainScene:EndingHandler()
	if self.assessPanel:isShowing() then
		self.assessPanel:ExecuteAction("Hide")
	end

	local var_85_0 = self.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.ENDING)
	local var_85_1 = var_85_0 and var_85_0:IsFinish()

	setActive(self.resetBtns, var_85_1)
	setActive(self.resetBtn, var_85_1)
	setActive(self.endlessBtn, var_85_1 and self.contextData.char:GetRoundData():ExistEndless())
	setActive(self.endingBtn, not var_85_1)

	if var_85_1 then
		local var_85_2 = self.contextData.char:getConfig("special_memory").after_ending

		if not pg.NewStoryMgr.GetInstance():IsPlayed(var_85_2) then
			NewEducateHelper.PlaySpecialStory(var_85_2, function()
				if getProxy(EducateProxy):GetSelectInfo().gameCnt == 1 and CultivatingPlantTools.IsPopActivity(self.contextData.char.id) then
					self:emit(NewEducateMainScene.GO_SUBLAYER, Context.New({
						mediator = CultivatingPlantMediator,
						viewComponent = CultivatingPlantScene,
						data = {
							id = self.contextData.char.id
						}
					}))
				end

				return
			end)
		end
	else
		local var_85_3 = self.contextData.char:getConfig("special_memory").pre_ending

		if var_85_3 ~= "" then
			NewEducateHelper.PlaySpecialStory(var_85_3, function()
				return
			end)
		end
	end

	return
end

function NewEducateMainScene:OnEndingClick()
	local var_88_0 = self.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.ENDING)

	seriesAsync({
		function(arg_89_0)
			if not var_88_0 then
				self:emit(NewEducateMainMediator.ON_REQ_ENDINGS, arg_89_0)
			else
				arg_89_0()
			end

			return
		end
	}, function()
		local var_90_0 = self.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.ENDING):GetEndings()

		if #var_90_0 == 1 then
			self:emit(NewEducateMainMediator.ON_SELECT_ENDING, var_90_0[1])
		else
			self:emit(NewEducateMainScene.GO_SUBLAYER, Context.New({
				mediator = NewEducateSelEndingMediator,
				viewComponent = NewEducateSelEndingLayer,
				data = {
					onExit = function()
						self:SeriesCheck()

						return
					end
				}
			}))
		end

		return
	end)

	return
end

function NewEducateMainScene:ChooseHandler()
	seriesAsync({
		function(arg_93_0)
			self:emit(NewEducateMainMediator.ON_REQ_CHOOSE, arg_93_0)

			return
		end
	}, function()
		self:SeriesCheck()

		return
	end)

	return
end

function NewEducateMainScene:FailHandler()
	if self.assessPanel:isShowing() then
		self.assessPanel:ExecuteAction("Hide")
	end

	setActive(self.resetBtns, true)
	setActive(self.resetBtn, true)
	setActive(self.endlessBtn, false)
	setActive(self.resetInEndlessBtn, false)

	return
end

function NewEducateMainScene:OnSelDone(arg_96_1)
	NewEducateHelper.PlaySpecialStory(pg.child2_ending[arg_96_1].performance, function()
		self:SeriesCheck()

		return
	end, true)

	return
end

function NewEducateMainScene:OnClickResetBtn()
	seriesAsync({
		function(arg_99_0)
			self:emit(NewEducateMainScene.ON_BOX, {
				content = i18n("child2_reset_sure_tip"),
				onYes = arg_99_0
			})

			return
		end,
		function(arg_100_0)
			self:emit(NewEducateMainMediator.ON_RESET, arg_100_0)

			return
		end
	}, function()
		self:OnReset()

		return
	end)

	return
end

function NewEducateMainScene:OnClickResetInEndlessBtn()
	seriesAsync({
		function(arg_103_0)
			self:emit(NewEducateMainScene.GO_SUBLAYER, Context.New({
				viewComponent = NewEducateMsgBoxLayer,
				mediator = NewEducateMsgBoxMediator,
				data = {
					type = NewEducateMsgBoxLayer.TYPE.RESET,
					onYes = arg_103_0
				}
			}))

			return
		end,
		function(arg_104_0)
			self:emit(NewEducateMainMediator.ON_RESET, arg_104_0)

			return
		end
	}, function()
		self:OnReset()

		return
	end)

	return
end

function NewEducateMainScene:OnClickEndlessBtn()
	seriesAsync({
		function(arg_107_0)
			self:emit(NewEducateMainScene.ON_BOX, {
				content = i18n("child2_endless_sure_tip"),
				onYes = arg_107_0
			})

			return
		end,
		function(arg_108_0)
			self:emit(NewEducateMainMediator.ON_START_ENDLESS, arg_108_0)

			return
		end
	}, function()
		self:CheckFSM()

		return
	end)

	return
end

function NewEducateMainScene:OnResUpdate()
	self.topPanel:ExecuteAction("FlushRes")
	self:CheckFavorUpgrade()

	return
end

function NewEducateMainScene:OnAttrUpdate()
	self.infoPanel:ExecuteAction("FlushAttrs")
	self.topPanel:ExecuteAction("FlushProgress")

	return
end

function NewEducateMainScene:OnPersonalityUpdate(arg_112_1, arg_112_2)
	self.personalityTipPanel:ExecuteAction("FlushPersonality", arg_112_1, arg_112_2)

	if self.contextData.char:GetPersonalityTag() ~= arg_112_2 then
		self:UpdatePaintingUI()
		self:PlayBGM()
	end

	return
end

function NewEducateMainScene:OnTalentUpdate()
	self.infoPanel:ExecuteAction("FlushTalents")

	return
end

function NewEducateMainScene:OnStatusUpdate()
	self.infoPanel:ExecuteAction("FlushStatus")

	return
end

function NewEducateMainScene:OnTarotUpdate()
	self.infoPanel:ExecuteAction("FlushTarot")

	return
end

function NewEducateMainScene:UpdateUnlockUI()
	setActive(self.mapBtn:Find("lock"), not self.contextData.char:IsUnlock("out"))

	return
end

function NewEducateMainScene:OnNextRound()
	self.topPanel:ExecuteAction("Flush")
	self.infoPanel:ExecuteAction("Flush")
	self:UpdatePaintingUI()
	self:UpdateUnlockUI()

	return
end

function NewEducateMainScene:OnNodeStart(arg_118_1)
	if arg_118_1 == 0 then
		return
	end

	assert(pg.child2_node[arg_118_1], "child2_node缺少id:" .. arg_118_1)
	self.nodePanel:ExecuteAction("StartNode", arg_118_1)

	if pg.child2_node[arg_118_1].type == NewEducateNodePanel.NODE_TYPE.MAIN_TEXT then
		self:HideDialogueUI()
		self:UpdatePaintingFace(arg_118_1)
	end

	return
end

function NewEducateMainScene:OnNextNode(arg_119_1)
	self.nodePanel:ExecuteAction("ProceedNode", arg_119_1.node, arg_119_1.drop, arg_119_1.noNextCb)

	if self.contextData.char:GetFSM():GetSystemNo() ~= NewEducateFSM.SYSTEM.PLAN then
		self:UpdatePaintingFace(arg_119_1.node)
	end

	return
end

function NewEducateMainScene:UpdateCallName()
	self.nodePanel:ExecuteAction("UpdateCallName")

	return
end

function NewEducateMainScene:onBackPressed()
	if self.lockBackPressed then
		return
	end

	if self.assessPanel:isShowing() then
		return
	end

	if self.nodePanel:isShowing() then
		return
	end

	if self.roundTipPanel:isShowing() then
		return
	end

	self.super.onBackPressed(self)

	return
end

function NewEducateMainScene:willExit()
	self.contextData.isMainEnter = nil

	if self.topPanel then
		self.topPanel:Destroy()

		self.topPanel = nil
	end

	if self.infoPanel then
		self.infoPanel:Destroy()

		self.infoPanel = nil
	end

	if self.roundTipPanel then
		self.roundTipPanel:Destroy()

		self.roundTipPanel = nil
	end

	if self.assessPanel then
		self.assessPanel:Destroy()

		self.assessPanel = nil
	end

	if self.favorPanel then
		self.favorPanel:Destroy()

		self.favorPanel = nil
	end

	if self.personalityTipPanel then
		self.personalityTipPanel:Destroy()

		self.personalityTipPanel = nil
	end

	if self.nodePanel then
		self.nodePanel:Destroy()

		self.nodePanel = nil
	end

	if LeanTween.isTweening(self.dialogueTF) then
		LeanTween.cancel(self.dialogueTF)
	end

	return
end

return NewEducateMainScene
