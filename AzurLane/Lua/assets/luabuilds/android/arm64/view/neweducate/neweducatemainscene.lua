local var_0_0 = class("NewEducateMainScene", import("view.newEducate.base.NewEducateBaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "NewEducateMainUI"
end

function var_0_0.PlayBGM(arg_2_0)
	local var_2_0 = arg_2_0.contextData.char:GetBgm()

	if var_2_0 then
		pg.BgmMgr.GetInstance():Push(arg_2_0.__cname, var_2_0)
	end

	return
end

function var_0_0.init(arg_3_0)
	arg_3_0.rootTF = arg_3_0._tf:Find("root")
	arg_3_0.mainAnim = arg_3_0.rootTF:GetComponent(typeof(Animation))
	arg_3_0.bgTF = arg_3_0.rootTF:Find("bg")
	arg_3_0.paintTF = arg_3_0.rootTF:Find("painting")
	arg_3_0.dialogueTF = arg_3_0.rootTF:Find("main/dialogue")
	arg_3_0.dialogueContent = arg_3_0.dialogueTF:Find("content")

	setActive(arg_3_0.dialogueTF, false)
	setActive(arg_3_0.dialogueTF:Find("arrows"), false)

	arg_3_0.topicBtn = arg_3_0.rootTF:Find("main/topic")

	setActive(arg_3_0.topicBtn, false)

	arg_3_0.mindBtn = arg_3_0.rootTF:Find("main/mind")

	setActive(arg_3_0.mindBtn, false)

	arg_3_0.adaptTF = arg_3_0.rootTF:Find("adapt")
	arg_3_0.favorTF = arg_3_0.adaptTF:Find("favor")
	arg_3_0.normalBtns = arg_3_0.adaptTF:Find("normal")
	arg_3_0.scheduleBtn = arg_3_0.normalBtns:Find("schedule")
	arg_3_0.mapBtn = arg_3_0.normalBtns:Find("map")
	arg_3_0.endingBtn = arg_3_0.adaptTF:Find("ending")
	arg_3_0.resetInEndlessBtn = arg_3_0.adaptTF:Find("reset_endless")
	arg_3_0.resetBtns = arg_3_0.adaptTF:Find("reset")
	arg_3_0.resetBtn = arg_3_0.resetBtns:Find("reset")
	arg_3_0.endlessBtn = arg_3_0.resetBtns:Find("endless")
	arg_3_0.topPanel = NewEducateTopPanel.New(arg_3_0.adaptTF, arg_3_0.event, setmetatable({
		hideBlurBg = true
	}, {
		__index = arg_3_0.contextData
	}))

	arg_3_0.topPanel:RegisterView(arg_3_0)

	arg_3_0.infoPanel = NewEducateInfoPanel.New(arg_3_0.adaptTF, arg_3_0.event, arg_3_0.contextData)

	arg_3_0.infoPanel:RegisterView(arg_3_0)

	arg_3_0.roundTipPanel = NewEducateRoundTipPanel.New(arg_3_0.adaptTF, arg_3_0.event, arg_3_0.contextData)

	arg_3_0.roundTipPanel:RegisterView(arg_3_0)

	arg_3_0.assessPanel = NewEducateAssessPanel.New(arg_3_0.adaptTF, arg_3_0.event, arg_3_0.contextData)

	arg_3_0.assessPanel:RegisterView(arg_3_0)

	arg_3_0.favorPanel = NewEducateFavorPanel.New(arg_3_0.adaptTF, arg_3_0.event, arg_3_0.contextData)

	arg_3_0.favorPanel:RegisterView(arg_3_0)

	arg_3_0.personalityTipPanel = NewEducatePersonalityTipPanel.New(arg_3_0.adaptTF, arg_3_0.event, arg_3_0.contextData)

	arg_3_0.personalityTipPanel:RegisterView(arg_3_0)

	arg_3_0.nodePanel = NewEducateNodePanel.New(arg_3_0.adaptTF, arg_3_0.event, setmetatable({
		view = arg_3_0
	}, {
		__index = arg_3_0.contextData
	}))

	arg_3_0.nodePanel:RegisterView(arg_3_0)

	return
end

function var_0_0.didEnter(arg_4_0)
	LoadImageSpriteAsync("neweducateicon/" .. arg_4_0.contextData.char:getConfig("child2_data_personality_icon")[2], arg_4_0.mindBtn, true)
	onButton(arg_4_0, arg_4_0.paintTF:Find("fitter"), function()
		arg_4_0:ShowDialogue()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.mindBtn, function()
		if arg_4_0.contextData.char:GetFSM():CheckPriorityStystem() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("child2_priority_tip"))

			return
		end

		setActive(arg_4_0.mindBtn, false)
		arg_4_0:emit(NewEducateMainMediator.ON_SELECT_MIND, function()
			arg_4_0:SeriesCheck()

			return
		end)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.favorTF, function()
		if arg_4_0.contextData.char:GetFSM():CheckPriorityStystem() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("child2_priority_tip"))

			return
		end

		arg_4_0.favorPanel:ExecuteAction("Show")

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.scheduleBtn, function()
		if arg_4_0.contextData.char:GetFSM():CheckPriorityStystem() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("child2_priority_tip"))

			return
		end

		arg_4_0:emit(var_0_0.GO_SCENE, SCENE.NEW_EDUCATE_SCHEDULE, {
			scheduleDataTable = arg_4_0.contextData.scheduleDataTable
		})

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.mapBtn, function()
		if arg_4_0.contextData.char:GetFSM():CheckPriorityStystem() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("child2_priority_tip"))

			return
		end

		if not arg_4_0.contextData.char:IsUnlock("out") then
			return
		end

		arg_4_0:emit(var_0_0.GO_SCENE, SCENE.NEW_EDUCATE_MAP)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.endingBtn, function()
		arg_4_0:OnEndingClick()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.resetBtn, function()
		arg_4_0:OnClickResetBtn()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.resetInEndlessBtn, function()
		arg_4_0:OnClickResetInEndlessBtn()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.endlessBtn, function()
		arg_4_0:OnClickEndlessBtn()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.topicBtn, function()
		setActive(arg_4_0.topicBtn, false)

		local var_15_0 = arg_4_0.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.TOPIC):GetTopics()

		if var_15_0[1] then
			arg_4_0:emit(NewEducateMainMediator.ON_SELECT_TOPIC, var_15_0[1])
		end

		return
	end, SFX_PANEL)
	arg_4_0:UpdatePaintingUI()
	arg_4_0:UpdateFavorInfo()
	arg_4_0:UpdateUnlockUI()

	arg_4_0.contextData.scheduleDataTable = arg_4_0.contextData.scheduleDataTable or {}

	seriesAsync({
		function(arg_16_0)
			arg_4_0:CheckNewChar(arg_16_0)

			return
		end
	}, function()
		if arg_4_0.contextData.scheduleDataTable.OnScheduleDone then
			arg_4_0.contextData.scheduleDataTable.OnScheduleDone = nil

			if #arg_4_0.contextData.scheduleDataTable.OnScheduleDone.drops == 0 then
				existCall(arg_4_0.contextData.scheduleDataTable.OnScheduleDone.callback)
			else
				arg_4_0:emit(NewEducateBaseUI.ON_DROP, {
					items = arg_4_0.contextData.scheduleDataTable.OnScheduleDone.drops,
					removeFunc = arg_4_0.contextData.scheduleDataTable.OnScheduleDone.callback
				})
			end
		else
			arg_4_0:SeriesCheck()
		end

		return
	end)

	arg_4_0.newRoundDrops = {}

	return
end

function var_0_0._loadSubViews(arg_18_0)
	arg_18_0.topPanel:Load()
	arg_18_0.infoPanel:Load()

	return
end

function var_0_0.SeriesCheck(arg_19_0)
	table.insert({}, function(arg_20_0)
		arg_19_0:CheckFavorUpgrade(arg_20_0)

		return
	end)
	seriesAsync({}, function()
		arg_19_0:CheckFSM()

		return
	end)

	return
end

function var_0_0.UpdatePaintingUI(arg_22_0)
	setImageSprite(arg_22_0.bgTF, LoadSprite("bg/" .. arg_22_0.contextData.char:GetRoundData():getConfig("main_background")), false)

	arg_22_0.paintingName = arg_22_0.contextData.char:GetPaintingName()

	setPaintingPrefab(arg_22_0.paintTF, arg_22_0.paintingName, "yangcheng")

	arg_22_0.wordList, arg_22_0.faceList = arg_22_0.contextData.char:GetMainDialogueInfo()

	return
end

function var_0_0.HideDialogueUI(arg_23_0)
	arg_23_0.isShowInfoPanel = arg_23_0.infoPanel:isShowing() and arg_23_0.infoPanel:IsShowPanel()

	arg_23_0.infoPanel:ExecuteAction("HidePanel")
	arg_23_0.topPanel:ExecuteAction("PlayHide")
	arg_23_0.mainAnim:Play("anim_educate_mainui_icon_hide")

	return
end

function var_0_0.ShowDialogueUI(arg_24_0)
	if arg_24_0.isShowInfoPanel then
		arg_24_0.infoPanel:ExecuteAction("ShowPanel")
	end

	arg_24_0.topPanel:ExecuteAction("PlayShow")
	arg_24_0.mainAnim:Play("anim_educate_mainui_icon_show")

	return
end

function var_0_0.UpdatePaintingFace(arg_25_0, arg_25_1)
	if arg_25_0.paintTF:Find("fitter").childCount == 0 then
		return
	end

	local var_25_0 = arg_25_0.paintTF:Find("fitter"):GetChild(0):Find("face")

	if arg_25_1 == 0 then
		if var_25_0 then
			setActive(var_25_0, false)
		end

		arg_25_0:ShowDialogueUI()

		return
	end

	local var_25_1 = pg.child2_node[arg_25_1]

	if pg.child2_node[arg_25_1].type == NewEducateNodePanel.NODE_TYPE.MAIN_TEXT then
		if pg.child2_word[var_25_1.text].main_character_face == 0 then
			if var_25_0 then
				setActive(var_25_0, false)
			end
		else
			local var_25_2 = GetSpriteFromAtlas("paintingface/" .. arg_25_0.paintingName, pg.child2_word[var_25_1.text].main_character_face)

			if var_25_0 and var_25_2 then
				setImageSprite(var_25_0, var_25_2)
				setActive(var_25_0, true)
			end
		end
	end

	return
end

function var_0_0.ShowDialogue(arg_26_0)
	if LeanTween.isTweening(arg_26_0.dialogueTF) then
		return
	end

	local var_26_0 = math.random(#arg_26_0.wordList)

	setText(arg_26_0.dialogueContent, (string.gsub(pg.child2_word[arg_26_0.wordList[var_26_0]].word, "$1", arg_26_0.contextData.char:GetCallName())))

	local var_26_1 = GetSpriteFromAtlas("paintingface/" .. arg_26_0.paintingName, arg_26_0.faceList[var_26_0])
	local var_26_2 = arg_26_0.paintTF:Find("fitter"):GetChild(0):Find("face")

	if var_26_2 and var_26_1 then
		setImageSprite(var_26_2, var_26_1)
		setActive(var_26_2, true)
	end

	arg_26_0.dialogueTF.localScale = Vector3.zero

	setActive(arg_26_0.dialogueTF, true)
	LeanTween.scale(arg_26_0.dialogueTF, Vector3.one, 0.3):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
		LeanTween.scale(arg_26_0.dialogueTF, Vector3.zero, 0.3):setEase(LeanTweenType.easeInBack):setDelay(3):setOnComplete(System.Action(function()
			setActive(arg_26_0.dialogueTF, false)

			if var_26_2 then
				setActive(var_26_2, false)
			end

			return
		end))

		return
	end))

	return
end

function var_0_0.UpdataTopicAndMind(arg_29_0)
	local var_29_0 = arg_29_0.contextData.char:GetFSM()
	local var_29_1 = arg_29_0.contextData.char:GetRoundData()
	local var_29_2 = var_29_0:GetState(NewEducateFSM.SYSTEM.TOPIC)

	if var_29_1:IsTemp() or var_29_2 and var_29_2:IsFinish() then
		setActive(arg_29_0.topicBtn, false)
	else
		setActive(arg_29_0.topicBtn, true)
	end

	local var_29_3 = var_29_1:getConfig("main_event_chat_node_id")

	if var_29_3 ~= "" and #var_29_3 > 0 and not var_29_1:IsTemp() then
		setActive(arg_29_0.mindBtn, not var_29_0:GetState(NewEducateFSM.SYSTEM.MIND))
	else
		setActive(arg_29_0.mindBtn, false)
	end

	return
end

function var_0_0.CheckNewChar(arg_30_0, arg_30_1)
	if arg_30_0.contextData.char:GetCallName() == "" then
		setActive(arg_30_0._tf, false)

		local var_30_0 = arg_30_0.contextData.char:getConfig("special_memory")

		table.insert({}, function(arg_31_0)
			NewEducateHelper.PlaySpecialStoryList(var_30_0.pre_name, arg_31_0, true)

			return
		end)
		table.insert({}, function(arg_32_0)
			arg_30_0:emit(var_0_0.GO_SUBLAYER, Context.New({
				mediator = NewEducateSetCallediator,
				viewComponent = NewEducateSetCallLayer,
				data = {
					callback = arg_32_0
				}
			}))

			return
		end)
		table.insert({}, function(arg_33_0)
			NewEducateHelper.PlaySpecialStoryList(var_30_0.after_name, arg_33_0, true)

			return
		end)

		arg_30_0.lockBackPressed = true

		seriesAsync({}, function()
			setActive(arg_30_0._tf, true)
			arg_30_0:_loadSubViews()
			arg_30_1()

			arg_30_0.lockBackPressed = false

			return
		end)
	else
		arg_30_0:_loadSubViews()
		arg_30_1()
	end

	return
end

function var_0_0.UpdateFavorInfo(arg_35_0)
	setText(arg_35_0.favorTF:Find("Text"), "Lv" .. arg_35_0.contextData.char:GetFavorInfo().lv)

	return
end

function var_0_0.CheckFavorUpgrade(arg_36_0, arg_36_1)
	if arg_36_0.contextData.char:CheckFavor() then
		arg_36_0:emit(NewEducateMainMediator.ON_UPGRADE_FAVOR, arg_36_1)
	else
		existCall(arg_36_1)
	end

	return
end

function var_0_0.CheckFSM(arg_37_0)
	if arg_37_0.contextData.char:GetFSM():CheckPriorityStystem() then
		arg_37_0:emit(var_0_0.ON_PRIORITY_STATE)
	else
		arg_37_0:CheckGameFSM()
	end

	return
end

function var_0_0.CheckGameFSM(arg_38_0)
	local var_38_0 = arg_38_0.contextData.char:GetFSM()
	local var_38_1 = var_38_0:CheckStystem()

	warning("CheckGameFSM", var_38_0:GetSystemNo() .. "->" .. var_38_1)
	arg_38_0:UpdateStateUI(var_38_1)
	switch(var_38_1, {
		[NewEducateFSM.SYSTEM.EVENT] = function()
			arg_38_0:EventHandler()

			return
		end,
		[NewEducateFSM.SYSTEM.TALENT] = function()
			arg_38_0:TalentHandler()

			return
		end,
		[NewEducateFSM.SYSTEM.TOPIC] = function()
			arg_38_0:TopicHandler()

			return
		end,
		[NewEducateFSM.SYSTEM.MAP] = function()
			arg_38_0:MapHandler()

			return
		end,
		[NewEducateFSM.SYSTEM.PLAN] = function()
			arg_38_0:PlanHandler()

			return
		end,
		[NewEducateFSM.SYSTEM.ASSESS] = function()
			arg_38_0:AssessHandler()

			return
		end,
		[NewEducateFSM.SYSTEM.PHASE] = function()
			arg_38_0:StageHandler()

			return
		end,
		[NewEducateFSM.SYSTEM.ENDING] = function()
			arg_38_0:EndingHandler()

			return
		end,
		[NewEducateFSM.SYSTEM.MIND] = function()
			arg_38_0:MindHandler()

			return
		end,
		[NewEducateFSM.SYSTEM.CHOOSE] = function()
			arg_38_0:ChooseHandler()

			return
		end,
		[NewEducateFSM.SYSTEM.FAIL] = function()
			arg_38_0:FailHandler()

			return
		end
	}, function()
		assert(false, "不合法FSM状态")

		return
	end)

	return
end

function var_0_0.OnReset(arg_51_0)
	arg_51_0:HideDialogueUI()
	arg_51_0.infoPanel:ExecuteAction("Hide")

	arg_51_0.contextData.char = getProxy(NewEducateProxy):GetCurChar()

	setActive(arg_51_0.topicBtn, false)
	setActive(arg_51_0.mindBtn, false)
	arg_51_0.infoPanel:ExecuteAction("Flush")
	arg_51_0.topPanel:ExecuteAction("Flush", NewEducateFSM.SYSTEM.INIT)
	arg_51_0:UpdatePaintingUI()
	arg_51_0:UpdateUnlockUI()
	seriesAsync({
		function(arg_52_0)
			arg_51_0:CheckNewChar(arg_52_0)

			return
		end
	}, function()
		arg_51_0:ShowDialogueUI()
		arg_51_0.infoPanel:ExecuteAction("Show")
		arg_51_0:SeriesCheck()

		return
	end)

	return
end

function var_0_0.UpdateStateUI(arg_54_0, arg_54_1)
	arg_54_0:UpdateBtns(arg_54_1)
	arg_54_0.topPanel:ExecuteAction("FlushProgress", arg_54_1)

	return
end

function var_0_0.UpdateBtns(arg_55_0, arg_55_1)
	setActive(arg_55_0.endingBtn, false)
	setActive(arg_55_0.resetBtns, false)
	setActive(arg_55_0.endlessBtn, false)

	local var_55_0 = arg_55_0.contextData.char:GetRoundData()

	setActive(arg_55_0.resetInEndlessBtn, var_55_0:IsEndless())
	setActive(arg_55_0.normalBtns, arg_55_1 ~= NewEducateFSM.SYSTEM.ENDING and not var_55_0:IsEndlessFail())

	local var_55_1 = arg_55_0.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.MAP)

	setActive(arg_55_0.mapBtn:Find("tip"), var_55_1 and var_55_1:IsSpecial())

	return
end

function var_0_0.AddNewRoundDrops(arg_56_0, arg_56_1)
	arg_56_0.newRoundDrops = arg_56_1

	return
end

function var_0_0.ContinuePlayNode(arg_57_0)
	seriesAsync({
		function(arg_58_0)
			arg_57_0:emit(var_0_0.ON_BOX, {
				hideClose = true,
				content = i18n("child2_replay_tip"),
				noText = i18n("child2_replay_clear"),
				yesText = i18n("child2_replay_continue"),
				onYes = arg_58_0,
				onNo = function()
					arg_57_0:emit(NewEducateMainMediator.ON_CLEAR_NODE_CHAIN)

					return
				end
			})

			return
		end
	}, function()
		arg_57_0:OnNodeStart(arg_57_0.contextData.char:GetFSM():GetCurNode())

		return
	end)

	return
end

function var_0_0.EventHandler(arg_61_0)
	if arg_61_0.contextData.char:GetFSM():GetCurNode() ~= 0 then
		arg_61_0:ContinuePlayNode()

		return
	end

	seriesAsync({
		function(arg_62_0)
			arg_61_0.roundTipPanel:ExecuteAction("Show", arg_62_0)

			return
		end,
		function(arg_63_0)
			if #arg_61_0.newRoundDrops > 0 then
				arg_61_0:emit(NewEducateBaseUI.ON_DROP, {
					items = arg_61_0.newRoundDrops,
					removeFunc = arg_63_0
				})
			else
				arg_63_0()
			end

			return
		end
	}, function()
		arg_61_0.newRoundDrops = {}

		arg_61_0:emit(NewEducateMainMediator.ON_TRIGGER_MAIN_EVENT)

		return
	end)

	return
end

function var_0_0.TalentHandler(arg_65_0)
	local var_65_0 = arg_65_0.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.TALENT)

	seriesAsync({
		function(arg_66_0)
			if not var_65_0 then
				arg_65_0:emit(NewEducateMainMediator.ON_REQ_TALENTS, arg_66_0)
			else
				arg_66_0()
			end

			return
		end,
		function(arg_67_0)
			if arg_65_0.contextData.char:GetRoundData():IsTalentRound() then
				arg_65_0:emit(var_0_0.GO_SUBLAYER, Context.New({
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
		arg_65_0:SeriesCheck()

		return
	end)

	return
end

function var_0_0.ReqParallelData(arg_69_0)
	local var_69_0 = arg_69_0.contextData.char:GetFSM()

	seriesAsync({
		function(arg_70_0)
			if not arg_69_0.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.TOPIC) then
				arg_69_0:emit(NewEducateMainMediator.ON_REQ_TOPICS, arg_70_0)
			else
				arg_70_0()
			end

			return
		end,
		function(arg_71_0)
			if not arg_69_0.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.MAP) then
				arg_69_0:emit(NewEducateMainMediator.ON_REQ_MAP)
			else
				arg_71_0()
			end

			return
		end
	}, function()
		arg_69_0:UpdataTopicAndMind()
		NewEducateGuideSequence.CheckGuide(arg_69_0.__cname)

		return
	end)

	return
end

function var_0_0.TopicHandler(arg_73_0)
	if arg_73_0.contextData.char:GetFSM():GetCurNode() ~= 0 then
		arg_73_0:ContinuePlayNode()

		return
	end

	arg_73_0:ReqParallelData()

	return
end

function var_0_0.MindHandler(arg_74_0)
	if arg_74_0.contextData.char:GetFSM():GetCurNode() ~= 0 then
		arg_74_0:ContinuePlayNode()

		return
	end

	arg_74_0:ReqParallelData()

	return
end

function var_0_0.MapHandler(arg_75_0)
	if arg_75_0.contextData.char:GetFSM():GetCurNode() ~= 0 then
		arg_75_0:emit(var_0_0.ON_BOX, {
			hideClose = true,
			content = i18n("child2_replay_tip"),
			noText = i18n("child2_replay_clear"),
			yesText = i18n("child2_replay_continue"),
			onYes = function()
				arg_75_0:emit(var_0_0.GO_SCENE, SCENE.NEW_EDUCATE_MAP)

				return
			end,
			onNo = function()
				arg_75_0:emit(NewEducateMainMediator.ON_CLEAR_NODE_CHAIN)

				return
			end
		})

		return
	end

	arg_75_0:ReqParallelData()

	return
end

function var_0_0.PlanHandler(arg_78_0)
	if arg_78_0.contextData.char:GetFSM():GetCurNode() ~= 0 then
		arg_78_0:ContinuePlayNode()

		return
	end

	arg_78_0:emit(NewEducateMainMediator.ON_NEXT_PLAN, true)

	return
end

function var_0_0.AssessHandler(arg_79_0)
	if arg_79_0.contextData.char:GetFSM():GetCurNode() ~= 0 then
		arg_79_0:ContinuePlayNode()

		return
	end

	local var_79_0 = arg_79_0.contextData.char:GetAssessPreStory()
	local var_79_1 = arg_79_0.contextData.char:GetAssessRankIdx()

	seriesAsync({
		function(arg_80_0)
			local var_80_0 = arg_79_0.contextData.char:GetFSM()

			if var_80_0:GetSystemNo() ~= NewEducateFSM.SYSTEM.ASSESS then
				arg_79_0:emit(NewEducateMainMediator.ON_ENTER_ASSESS, arg_80_0)
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
				arg_79_0.assessPanel:ExecuteAction("Show", arg_82_0)
			else
				arg_79_0.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.ASSESS):MarkFinish()
				arg_82_0()
			end

			return
		end
	}, function(arg_83_0)
		arg_79_0:SeriesCheck()

		return
	end)

	return
end

function var_0_0.StageHandler(arg_84_0)
	if arg_84_0.assessPanel:isShowing() then
		arg_84_0.assessPanel:ExecuteAction("Hide")
	end

	local var_84_0 = arg_84_0.contextData.char:GetFSM()

	if var_84_0:GetCurNode() ~= 0 then
		arg_84_0:ContinuePlayNode()

		return
	end

	arg_84_0:emit(NewEducateMainMediator.ON_STAGE_CHANGE)

	return
end

function var_0_0.EndingHandler(arg_85_0)
	if arg_85_0.assessPanel:isShowing() then
		arg_85_0.assessPanel:ExecuteAction("Hide")
	end

	local var_85_0 = arg_85_0.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.ENDING)
	local var_85_1 = var_85_0 and var_85_0:IsFinish()

	setActive(arg_85_0.resetBtns, var_85_1)
	setActive(arg_85_0.resetBtn, var_85_1)

	local var_85_2 = var_85_1 and arg_85_0.contextData.char:GetRoundData():ExistEndless()

	setActive(arg_85_0.endlessBtn, var_85_2)
	setActive(arg_85_0.endingBtn, not var_85_1)

	if var_85_1 then
		local var_85_3 = arg_85_0.contextData.char:getConfig("special_memory").after_ending

		if not pg.NewStoryMgr.GetInstance():IsPlayed(var_85_3) then
			NewEducateHelper.PlaySpecialStory(var_85_3, function()
				if getProxy(EducateProxy):GetSelectInfo().gameCnt == 1 and CultivatingPlantTools.IsPopActivity(arg_85_0.contextData.char.id) then
					arg_85_0:emit(var_0_0.GO_SUBLAYER, Context.New({
						mediator = CultivatingPlantMediator,
						viewComponent = CultivatingPlantScene,
						data = {
							id = arg_85_0.contextData.char.id
						}
					}))
				end

				return
			end)
		end
	else
		local var_85_4 = arg_85_0.contextData.char:getConfig("special_memory").pre_ending

		if var_85_4 ~= "" then
			NewEducateHelper.PlaySpecialStory(var_85_4, function()
				return
			end)
		end
	end

	return
end

function var_0_0.OnEndingClick(arg_88_0)
	local var_88_0 = arg_88_0.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.ENDING)

	seriesAsync({
		function(arg_89_0)
			if not var_88_0 then
				arg_88_0:emit(NewEducateMainMediator.ON_REQ_ENDINGS, arg_89_0)
			else
				arg_89_0()
			end

			return
		end
	}, function()
		local var_90_0 = arg_88_0.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.ENDING):GetEndings()

		if #var_90_0 == 1 then
			arg_88_0:emit(NewEducateMainMediator.ON_SELECT_ENDING, var_90_0[1])
		else
			arg_88_0:emit(var_0_0.GO_SUBLAYER, Context.New({
				mediator = NewEducateSelEndingMediator,
				viewComponent = NewEducateSelEndingLayer,
				data = {
					onExit = function()
						arg_88_0:SeriesCheck()

						return
					end
				}
			}))
		end

		return
	end)

	return
end

function var_0_0.ChooseHandler(arg_92_0)
	seriesAsync({
		function(arg_93_0)
			arg_92_0:emit(NewEducateMainMediator.ON_REQ_CHOOSE, arg_93_0)

			return
		end
	}, function()
		arg_92_0:SeriesCheck()

		return
	end)

	return
end

function var_0_0.FailHandler(arg_95_0)
	if arg_95_0.assessPanel:isShowing() then
		arg_95_0.assessPanel:ExecuteAction("Hide")
	end

	setActive(arg_95_0.resetBtns, true)
	setActive(arg_95_0.resetBtn, true)
	setActive(arg_95_0.endlessBtn, false)
	setActive(arg_95_0.resetInEndlessBtn, false)

	return
end

function var_0_0.OnSelDone(arg_96_0, arg_96_1)
	NewEducateHelper.PlaySpecialStory(pg.child2_ending[arg_96_1].performance, function()
		arg_96_0:SeriesCheck()

		return
	end, true)

	return
end

function var_0_0.OnClickResetBtn(arg_98_0)
	seriesAsync({
		function(arg_99_0)
			arg_98_0:emit(var_0_0.ON_BOX, {
				content = i18n("child2_reset_sure_tip"),
				onYes = arg_99_0
			})

			return
		end,
		function(arg_100_0)
			arg_98_0:emit(NewEducateMainMediator.ON_RESET, arg_100_0)

			return
		end
	}, function()
		arg_98_0:OnReset()

		return
	end)

	return
end

function var_0_0.OnClickResetInEndlessBtn(arg_102_0)
	seriesAsync({
		function(arg_103_0)
			arg_102_0:emit(var_0_0.GO_SUBLAYER, Context.New({
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
			arg_102_0:emit(NewEducateMainMediator.ON_RESET, arg_104_0)

			return
		end
	}, function()
		arg_102_0:OnReset()

		return
	end)

	return
end

function var_0_0.OnClickEndlessBtn(arg_106_0)
	seriesAsync({
		function(arg_107_0)
			arg_106_0:emit(var_0_0.ON_BOX, {
				content = i18n("child2_endless_sure_tip"),
				onYes = arg_107_0
			})

			return
		end,
		function(arg_108_0)
			arg_106_0:emit(NewEducateMainMediator.ON_START_ENDLESS, arg_108_0)

			return
		end
	}, function()
		arg_106_0:CheckFSM()

		return
	end)

	return
end

function var_0_0.OnResUpdate(arg_110_0)
	arg_110_0.topPanel:ExecuteAction("FlushRes")
	arg_110_0:CheckFavorUpgrade()

	return
end

function var_0_0.OnAttrUpdate(arg_111_0)
	arg_111_0.infoPanel:ExecuteAction("FlushAttrs")
	arg_111_0.topPanel:ExecuteAction("FlushProgress")

	return
end

function var_0_0.OnPersonalityUpdate(arg_112_0, arg_112_1, arg_112_2)
	arg_112_0.personalityTipPanel:ExecuteAction("FlushPersonality", arg_112_1, arg_112_2)

	if arg_112_0.contextData.char:GetPersonalityTag() ~= arg_112_2 then
		arg_112_0:UpdatePaintingUI()
		arg_112_0:PlayBGM()
	end

	return
end

function var_0_0.OnTalentUpdate(arg_113_0)
	arg_113_0.infoPanel:ExecuteAction("FlushTalents")

	return
end

function var_0_0.OnStatusUpdate(arg_114_0)
	arg_114_0.infoPanel:ExecuteAction("FlushStatus")

	return
end

function var_0_0.OnTarotUpdate(arg_115_0)
	arg_115_0.infoPanel:ExecuteAction("FlushTarot")

	return
end

function var_0_0.UpdateUnlockUI(arg_116_0)
	setActive(arg_116_0.mapBtn:Find("lock"), not arg_116_0.contextData.char:IsUnlock("out"))

	return
end

function var_0_0.OnNextRound(arg_117_0)
	arg_117_0.topPanel:ExecuteAction("Flush")
	arg_117_0.infoPanel:ExecuteAction("Flush")
	arg_117_0:UpdatePaintingUI()
	arg_117_0:UpdateUnlockUI()

	return
end

function var_0_0.OnNodeStart(arg_118_0, arg_118_1)
	if arg_118_1 == 0 then
		return
	end

	assert(pg.child2_node[arg_118_1], "child2_node缺少id:" .. arg_118_1)
	arg_118_0.nodePanel:ExecuteAction("StartNode", arg_118_1)

	if pg.child2_node[arg_118_1].type == NewEducateNodePanel.NODE_TYPE.MAIN_TEXT then
		arg_118_0:HideDialogueUI()
		arg_118_0:UpdatePaintingFace(arg_118_1)
	end

	return
end

function var_0_0.OnNextNode(arg_119_0, arg_119_1)
	arg_119_0.nodePanel:ExecuteAction("ProceedNode", arg_119_1.node, arg_119_1.drop, arg_119_1.noNextCb)

	if arg_119_0.contextData.char:GetFSM():GetSystemNo() ~= NewEducateFSM.SYSTEM.PLAN then
		arg_119_0:UpdatePaintingFace(arg_119_1.node)
	end

	return
end

function var_0_0.UpdateCallName(arg_120_0)
	arg_120_0.nodePanel:ExecuteAction("UpdateCallName")

	return
end

function var_0_0.onBackPressed(arg_121_0)
	if arg_121_0.lockBackPressed then
		return
	end

	if arg_121_0.assessPanel:isShowing() then
		return
	end

	if arg_121_0.nodePanel:isShowing() then
		return
	end

	if arg_121_0.roundTipPanel:isShowing() then
		return
	end

	arg_121_0.super.onBackPressed(arg_121_0)

	return
end

function var_0_0.willExit(arg_122_0)
	arg_122_0.contextData.isMainEnter = nil

	if arg_122_0.topPanel then
		arg_122_0.topPanel:Destroy()

		arg_122_0.topPanel = nil
	end

	if arg_122_0.infoPanel then
		arg_122_0.infoPanel:Destroy()

		arg_122_0.infoPanel = nil
	end

	if arg_122_0.roundTipPanel then
		arg_122_0.roundTipPanel:Destroy()

		arg_122_0.roundTipPanel = nil
	end

	if arg_122_0.assessPanel then
		arg_122_0.assessPanel:Destroy()

		arg_122_0.assessPanel = nil
	end

	if arg_122_0.favorPanel then
		arg_122_0.favorPanel:Destroy()

		arg_122_0.favorPanel = nil
	end

	if arg_122_0.personalityTipPanel then
		arg_122_0.personalityTipPanel:Destroy()

		arg_122_0.personalityTipPanel = nil
	end

	if arg_122_0.nodePanel then
		arg_122_0.nodePanel:Destroy()

		arg_122_0.nodePanel = nil
	end

	if LeanTween.isTweening(arg_122_0.dialogueTF) then
		LeanTween.cancel(arg_122_0.dialogueTF)
	end

	return
end

return var_0_0
