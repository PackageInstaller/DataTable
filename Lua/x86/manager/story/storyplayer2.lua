local var_0_0 = class("StoryPlayer2", import("game.extend.ReduxView"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.isPlay_ = false
	arg_1_0.auto_time = 0
	arg_1_0.time_ = 0
	arg_1_0.frameCnt_ = 0
	arg_1_0.duration_ = 0
	arg_1_0.gameObject_ = nil
	arg_1_0.stage_ = arg_1_1
	arg_1_0.stage_.name = "StoryStage"
	arg_1_0.state_ = ""
	arg_1_0.auto_ = false
	arg_1_0.curStory_ = nil
	arg_1_0.curStoryInstance_ = nil
	arg_1_0.curTalkId_ = nil
	arg_1_0.isInRecall_ = false
	arg_1_0.onSingleLineFinish_ = nil
	arg_1_0.onSingleLineUpdate_ = nil
	arg_1_0.onStoryFinished_ = nil
	arg_1_0.playNext_ = nil
	arg_1_0.bgs_ = {}
	arg_1_0.actors_ = {}
	arg_1_0.spriteActors_ = {}
	arg_1_0.textGroupItemDic_ = {}
	arg_1_0.assetDic_ = {}
	arg_1_0.loadedCueSheet_ = {}
	arg_1_0.CriAtomExPlaybacks_ = {}
	arg_1_0.timelineDirector = {}
	arg_1_0.marker = ""
	arg_1_0.keyword = {}
	arg_1_0.keyword.nickname = PlayerData:GetPlayerInfo().nick
	arg_1_0.talkMaxDuration = 0
	arg_1_0.typewritterCharCountI18N = 0
	arg_1_0.musicType = {}
	arg_1_0.niuquEffectActor = {}
	arg_1_0.actionList = {}
	arg_1_0.playingNodeList_ = {}

	StoryPlayNodeFactory.GetInstance():SetStoryPlayer(arg_1_0)

	arg_1_0.virtualCameraContainerTrans_ = nil
	arg_1_0.commonVirtualCamera_ = nil
	arg_1_0.lockNextGoStatus_ = false

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:InitTimlineBind()
	arg_2_0:InitUIEvents()
end

function var_0_0.InitTimlineBind(arg_3_0)
	if not isNil(arg_3_0.timelineBindMgr) or not arg_3_0.timelineBindMgr then
		arg_3_0.timelineBindMgr = GameObjectTools.GetOrAddComponent(arg_3_0.timelinebindmgrGo_, typeof(BlendTwoTimelines))
	end
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Story/StoryUI"), manager.ui.uiStory.transform)
	arg_4_0.transform_ = arg_4_0.gameObject_.transform

	ComponentBinder.GetInstance():BindCfgUI(arg_4_0, arg_4_0.gameObject_)
	arg_4_0:AdaptScreen()

	arg_4_0.settingData = SettingData:GetGameSettingData()
	arg_4_0.iconController_ = ControllerUtil.GetController(arg_4_0.iconTrs_, "conName")
	arg_4_0.musicController = arg_4_0.musicController_:GetController("music")
	arg_4_0.choices_ = {}

	for iter_4_0 = 1, 4 do
		arg_4_0.choices_[iter_4_0] = {
			isShow = true,
			go = arg_4_0["itemGo" .. iter_4_0 .. "_"],
			txt = arg_4_0["itemText" .. iter_4_0 .. "_"]
		}
	end

	arg_4_0.choicesID = {}
	arg_4_0.fswtw_ = arg_4_0.typeWritterGo_:GetComponent("UITypewriterEffect")

	arg_4_0.fswbg_:SetActive(false)
	SetActive(arg_4_0.lastBtn_.gameObject, true)
	SetActive(arg_4_0.bgmBtn_.gameObject, true)
	SetActive(arg_4_0.locationGo_, false)
	SetActive(arg_4_0.dialog_, false)
	SetActive(arg_4_0.bgmBtn_.gameObject, arg_4_0.settingData.show_music_name == 1)
	SetActive(arg_4_0.showGo_, false)

	arg_4_0.bgmTxt_.text = ""
	arg_4_0.bgmTxt2_.text = ""

	arg_4_0.musicController:SetSelectedState("hide")

	if SceneSetting.Current then
		arg_4_0.sceneSettingEffect_ = SceneSetting.Current

		arg_4_0.sceneSettingGo_:SetActive(false)
	else
		arg_4_0.sceneSettingGo_:SetActive(true)
	end

	arg_4_0.screenFilterGo_:SetActive(false)

	arg_4_0.screenFilterEffect_ = arg_4_0.screenFilterGo_:GetComponent("Volume")
	arg_4_0.typewritter = arg_4_0.text_.gameObject:GetComponent("UITypewriterEffect")
	arg_4_0.dialogCg_.alpha = 0
	arg_4_0.blackMask_.alpha = 0
	arg_4_0.blackMask_.blocksRaycasts = false

	arg_4_0:ShowNextGo(false)

	arg_4_0.autoplayController_ = arg_4_0.controller_:GetController("autoplay")
	arg_4_0.hideBtnsController_ = arg_4_0:ControllerExtend(arg_4_0.controller_:GetController("hideBtns"))
	arg_4_0.hideAllUIController_ = arg_4_0.controller_:GetController("hideAllUI")
	arg_4_0.callingController_ = arg_4_0.controller_:GetController("Calling")
	arg_4_0.timestampController_ = arg_4_0.controller_:GetController("Timestamp")
	arg_4_0.timestampColorController_ = arg_4_0.timestampControllerexcollection_:GetController("BlueRed")

	arg_4_0.timestampController_:SetSelectedState("hide")

	arg_4_0.historyItems_ = {}
	arg_4_0.lastHistoryVoiceIdx_ = nil
	arg_4_0.curHistoryItem_ = nil
	arg_4_0.musicType = {}
	arg_4_0.niuquEffectActor = {}

	SetActive(arg_4_0.talkGo_, false)
	arg_4_0.autoplayController_:SetSelectedState("manual")

	arg_4_0.soundController_ = arg_4_0.soundControllerEx_:GetController("sound")
	arg_4_0.OnSoundSettingSwitchHandler_ = handler(arg_4_0, arg_4_0.OnSoundSettingSwitch)

	manager.notify:RegistListener(SOUND_SETTING_SWICH, arg_4_0.OnSoundSettingSwitchHandler_)
	arg_4_0:RefreshSoundState()

	arg_4_0.OnVoiceLanguageSwitchHandler_ = handler(arg_4_0, arg_4_0.OnVoiceLanguageSwitch)

	manager.notify:RegistListener(STORY_SWITCH_VOICE_LANGUAGE, arg_4_0.OnVoiceLanguageSwitchHandler_)
	arg_4_0:InitVirtualCamera()
end

function var_0_0.ControllerExtend(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0

	if isNil(arg_5_1) then
		return arg_5_1
	end

	local var_5_1 = {}

	tolua.setpeer(arg_5_1, var_5_1)

	var_5_1.__index = var_5_1

	local var_5_2 = arg_5_1.SetSelectedIndex

	function var_5_1.SetSelectedIndex(arg_6_0, arg_6_1)
		if arg_6_1 == 1 and var_5_0 ~= nil then
			if var_5_0.musicController:GetSelectedState() == "show" then
				var_5_0.musicAnimator_:Play("back", 0, 1)
				var_5_0.musicAnimator_:Update(0.001)
			else
				var_5_0.musicAnimator_:Play("open", 0, 1)
				var_5_0.musicAnimator_:Update(0.001)
			end
		end

		if var_5_2 then
			return var_5_2(arg_6_0, arg_6_1)
		end
	end

	return arg_5_1
end

function var_0_0.InitUIEvents(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.allBtn_, nil, function()
		arg_7_0:OnClickBtnAll()
	end)
	arg_7_0:AddBtnListener(arg_7_0.panelBtn_, nil, function()
		arg_7_0:OnClickBtnAll()
	end)
	arg_7_0:AddBtnListener(arg_7_0.hideBtn_, nil, function()
		if arg_7_0.auto_ then
			arg_7_0.auto_ = false

			arg_7_0.autoplayController_:SetSelectedState("manual")
		end

		SetActive(arg_7_0.dialog_, false)
		arg_7_0.hideBtnsController_:SetSelectedState("hide")

		arg_7_0.allBtnState = arg_7_0.allBtn_.enabled
		arg_7_0.fullScreenWordFlag_ = arg_7_0.fswbg_.activeSelf

		SetActive(arg_7_0.fswbg_, false)

		arg_7_0.state_ = "hiding"

		arg_7_0:Hide()

		arg_7_0.isPlay_ = false

		local var_10_0 = PlayerData:GetStoryList()
		local var_10_1
		local var_10_2 = var_10_0[arg_7_0.curStory_.id] and 0 or 1

		SDKTools.SendMessageToSDK("story_oper", {
			oper = StoryOperDefine.HIDE,
			is_first = var_10_2,
			story_id = arg_7_0.curStory_.id
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.autoBtn_, nil, function()
		arg_7_0.auto_ = true

		arg_7_0.autoplayController_:SetSelectedState("auto")

		local var_11_0 = PlayerData:GetStoryList()
		local var_11_1
		local var_11_2 = var_11_0[arg_7_0.curStory_.id] and 0 or 1

		SDKTools.SendMessageToSDK("story_oper", {
			oper = StoryOperDefine.AUTO,
			is_first = var_11_2,
			story_id = string.format(arg_7_0.curStory_.id)
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.manualBtn_, nil, function()
		arg_7_0.auto_ = false

		arg_7_0.autoplayController_:SetSelectedState("manual")
	end)
	arg_7_0:AddBtnListener(arg_7_0.bgmBtn_, nil, function()
		if arg_7_0.musicController:GetSelectedState() == "show" then
			arg_7_0.musicController:SetSelectedState("hide")
			arg_7_0.musicAnimator_:Play("back")
		else
			arg_7_0.musicController:SetSelectedState("show")
			arg_7_0.musicAnimator_:Play("open")
		end

		if arg_7_0.bgmTimer then
			arg_7_0.bgmTimer:Stop()

			arg_7_0.bgmTimer = nil
		end
	end)
	SetActive(arg_7_0.history_, true)
	SetActive(arg_7_0.history_, false)
	arg_7_0:AddBtnListener(arg_7_0.lastBtn_, nil, function()
		if SDKTools.GetIsOverSea() then
			arg_7_0:JumpToEnd()
		end

		arg_7_0:Pause()

		arg_7_0.isPlay_ = false

		SetActive(arg_7_0.history_, true)

		arg_7_0.showGo_.transform.localScale = Vector3.New(0, 0, 0)

		arg_7_0.hideBtnsController_:SetSelectedState("hide")
		manager.ui:SetUISeparateRender(true)

		arg_7_0.historyRect_.verticalNormalizedPosition = 0

		local var_14_0 = PlayerData:GetStoryList()
		local var_14_1
		local var_14_2 = var_14_0[arg_7_0.curStory_.id] and 0 or 1

		SDKTools.SendMessageToSDK("story_oper", {
			oper = StoryOperDefine.REPLAY,
			is_first = var_14_2,
			story_id = string.format(arg_7_0.curStory_.id)
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.historyBtn_, nil, function()
		arg_7_0:Resume()

		arg_7_0.isPlay_ = true

		SetActive(arg_7_0.history_, false)

		arg_7_0.showGo_.transform.localScale = Vector3.New(1, 1, 1)

		arg_7_0.hideBtnsController_:SetSelectedState("show")
		manager.ui:SetUISeparateRender(false)
		arg_7_0:RefreshMusicName()
	end)

	for iter_7_0 = 1, 4 do
		arg_7_0:AddBtnListener(arg_7_0["itemBtn" .. iter_7_0 .. "_"], nil, function()
			manager.story:SetStoryChoice(iter_7_0)
			arg_7_0:PlayNextAct(iter_7_0)
			SetActive(arg_7_0.choicesGo_, false)

			local var_16_0 = PlayerData:GetStoryList()
			local var_16_1
			local var_16_2 = var_16_0[arg_7_0.curStory_.id] and 0 or 1
			local var_16_3 = arg_7_0.choicesID[tonumber(arg_7_0.curChoiseId)] and arg_7_0.choicesID[tonumber(arg_7_0.curChoiseId)][iter_7_0] or ""

			SDKTools.SendMessageToSDK("story_oper", {
				story_id = arg_7_0.curStory_.id,
				is_first = var_16_2,
				oper = StoryOperDefine.OPTION,
				param_id = arg_7_0.curChoiseId,
				params_list = arg_7_0:GetChoiceLog(arg_7_0.curChoiseId),
				params_select = var_16_3
			})
		end)
	end

	arg_7_0:AddBtnListener(arg_7_0.skipBtn_, nil, function()
		local var_17_0, var_17_1 = arg_7_0:CheckCanSkipToEnd()

		if var_17_0 then
			arg_7_0:Skip()
		else
			arg_7_0:JumpToMarker(var_17_1)
		end

		SetActive(arg_7_0.choicesGo_, false)
	end)
	arg_7_0:AddBtnListener(arg_7_0.narrativeSkipBtn_, nil, function()
		arg_7_0.onStoryFinished_(true)
	end)
	arg_7_0:AddBtnListener(arg_7_0.narrativeExitBtn_, nil, function()
		arg_7_0.onStoryFinished_(true)
	end)
	arg_7_0:AddBtnListener(arg_7_0.narrativeContinueBtn_, nil, function()
		arg_7_0.onStoryFinished_(true)
	end)
	arg_7_0:AddBtnListener(arg_7_0.soundBtn_, nil, function()
		arg_7_0:Go("storySoundSetting")
	end)
end

function var_0_0.RefreshMusicName(arg_22_0)
	local var_22_0 = manager.audio:GetBgmPlayer()

	if var_22_0 then
		local var_22_1 = var_22_0.cueName or ""
		local var_22_2 = var_22_0.cueSheet or ""
		local var_22_3 = manager.audio:GetAudioName(var_22_1, var_22_2)

		arg_22_0.bgmTxt_.text = var_22_3
		arg_22_0.bgmTxt2_.text = var_22_3

		arg_22_0.musicChangeAnimator_:Play("music_change_idle", 0, 0)
	end
end

function var_0_0.OnClickBtnAll(arg_23_0)
	if arg_23_0.state_ == "hiding" then
		arg_23_0.state_ = "waiting"
		arg_23_0.isPlay_ = true

		SetActive(arg_23_0.dialog_, true)
		arg_23_0.hideBtnsController_:SetSelectedState("show")

		arg_23_0.allBtn_.enabled = arg_23_0.allBtnState

		SetActive(arg_23_0.fswbg_, arg_23_0.fullScreenWordFlag_ and true)

		if arg_23_0.fullScreenWordFlag_ == true then
			SetActive(arg_23_0.dialog_, false)
		end
	elseif arg_23_0.state_ == "waiting" and not arg_23_0.choicesGo_.activeSelf then
		arg_23_0:StopWaitVoiceLanguageTimer()
		arg_23_0:PlayNextAct(1)
	elseif (arg_23_0.dialogNext_.activeSelf or arg_23_0.typewriterNext_.activeSelf) and not arg_23_0.choicesGo_.activeSelf then
		arg_23_0:JumpToEnd()

		if not arg_23_0.choicesGo_.activeSelf then
			arg_23_0:PlayNextAct(1)
		end
	elseif arg_23_0.state_ == "playing" then
		arg_23_0:JumpToEnd()
	end
end

function var_0_0.JumpToEnd(arg_24_0)
	local var_24_0 = (arg_24_0.duration_ - arg_24_0.time_) / 0.033 + 1

	for iter_24_0 = 1, var_24_0 do
		arg_24_0:Update(0.033)
	end

	if arg_24_0.dialogScrollRect_ then
		arg_24_0.dialogScrollRect_.normalizedPosition = Vector2(0, 0)
	end
end

function var_0_0.JumpToMarker(arg_25_0, arg_25_1)
	while arg_25_1 > arg_25_0.curTalkId_ do
		arg_25_0:JumpToEnd()
		arg_25_0:PlayNextAct(1)
	end

	if arg_25_1 == arg_25_0.curTalkId_ then
		local var_25_0 = (arg_25_0.duration_ - arg_25_0.time_) / 0.033 + 1

		for iter_25_0 = 1, var_25_0 do
			arg_25_0:Update(0.033)

			if arg_25_0.marker ~= "" then
				return
			end
		end
	end

	arg_25_0:Skip()
end

function var_0_0.StopAllVoice(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.CriAtomExPlaybacks_) do
		if iter_26_1 then
			iter_26_1:Stop()
		end
	end

	arg_26_0.CriAtomExPlaybacks_ = {}

	arg_26_0:StopBgmTxt()
end

function var_0_0.StopBgmTxt(arg_27_0)
	if arg_27_0.bgmTimer then
		arg_27_0.bgmTimer:Stop()

		arg_27_0.bgmTimer = nil
	end

	if arg_27_0 == nil or isNil(arg_27_0.bgmTxt_) then
		return
	end

	arg_27_0.musicController:SetSelectedState("hide")
	arg_27_0.musicAnimator_:Play("back", 0, 0)

	arg_27_0.bgmTxt_.text = ""
	arg_27_0.bgmTxt2_.text = ""
end

function var_0_0.PlayOnlyBgm(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0.CriAtomExPlaybacks_) do
		if iter_28_1 and arg_28_0.musicType.music and not arg_28_0.musicType.music[iter_28_0] == 1 then
			iter_28_1:Stop()
			table.remove(arg_28_0.CriAtomExPlaybacks_, iter_28_0)
		end
	end
end

function var_0_0.Skip(arg_29_0, arg_29_1)
	local var_29_0 = false

	if not arg_29_1 then
		arg_29_1 = StoryOperDefine.PASS
	else
		var_29_0 = true
	end

	local var_29_1 = arg_29_0.curStory_.name
	local var_29_2 = arg_29_0.curStory_.desc

	arg_29_0.isPlay_ = false
	arg_29_0.auto_ = false

	arg_29_0.autoplayController_:SetSelectedState("manual")

	if var_29_2 and var_29_2 ~= "" then
		for iter_29_0, iter_29_1 in pairs(arg_29_0.CriAtomExPlaybacks_) do
			if iter_29_1 then
				iter_29_1:Pause()
			end
		end

		manager.audio:ClearBGMFlag()

		local var_29_3 = manager.story:IsStoryPlayed(arg_29_0.curStory_.id)
		local var_29_4

		if arg_29_0.skipView_ == nil then
			if var_29_3 or var_29_0 then
				var_29_4 = "Widget/System/Story/StorySkipUI"

				local var_29_5 = Asset.Load(var_29_4)
				local var_29_6 = Object.Instantiate(var_29_5, manager.ui.uiStory.transform)

				arg_29_0.skipView_ = StoryForceSkipView.New(var_29_6)
			else
				var_29_4 = "Widget/System/Story/StorySkip2UI"

				local var_29_7 = Asset.Load(var_29_4)
				local var_29_8 = Object.Instantiate(var_29_7, manager.ui.uiStory.transform)

				arg_29_0.skipView_ = StorySkip2View.New(var_29_8)
			end
		else
			SetActive(arg_29_0.skipView_.gameObject_, true)
		end

		if not var_29_3 and not var_29_0 then
			manager.ui:SetUISeparateRender(true)
		end

		arg_29_0.skipView_:SetContentTitle(var_29_1, arg_29_0:FormatText(var_29_2))
		arg_29_0.skipView_:SetCallback(handler(arg_29_0, function(arg_30_0, arg_30_1)
			if arg_30_1 then
				arg_29_0.isPlay_ = true

				for iter_30_0, iter_30_1 in pairs(arg_29_0.CriAtomExPlaybacks_) do
					if iter_30_1 then
						iter_30_1:Resume(CriAtomEx.ResumeMode.PausedPlayback)
					end
				end

				if arg_29_0.skipView_ then
					arg_29_0.skipView_:Dispose()

					arg_29_0.skipView_ = nil
				end

				if var_29_4 then
					Asset.Unload(var_29_4)
				end

				return
			end

			local var_30_0 = PlayerData:GetStoryList()
			local var_30_1
			local var_30_2 = var_30_0[arg_29_0.curStory_.id] and 0 or 1

			SDKTools.SendMessageToSDK("story_oper", {
				oper = arg_29_1,
				is_first = var_30_2,
				story_id = string.format(arg_29_0.curStory_.id)
			})

			if BirthdayCfg.get_id_list_by_story_id[arg_29_0.curStory_.id] and var_30_2 == 1 then
				SDKTools.SendMessageToSDK("birthday_viewed", {
					story_skip = 1
				})
			end

			arg_29_0:StopPassVoice()
			arg_29_0.onStoryFinished_(true)
		end))
	else
		local var_29_9 = PlayerData:GetStoryList()
		local var_29_10
		local var_29_11 = var_29_9[arg_29_0.curStory_.id] and 0 or 1

		SDKTools.SendMessageToSDK("story_oper", {
			oper = arg_29_1,
			is_first = var_29_11,
			story_id = string.format(arg_29_0.curStory_.id)
		})

		if BirthdayCfg.get_id_list_by_story_id[arg_29_0.curStory_.id] and var_29_11 == 1 then
			SDKTools.SendMessageToSDK("birthday_viewed", {
				story_skip = 1
			})
		end

		arg_29_0:StopPassVoice()
		arg_29_0.onStoryFinished_(true)
	end
end

function var_0_0.StopPassVoice(arg_31_0)
	manager.audio:PlayBGM("ui_skip", "ui_reset_filter")
	manager.audio:PlayEffect("ui_skip", "ui_reset", "")
	manager.audio:PlayEffect("se_story_activity_1_2_summer1", "se_story_activity_1_2_lowpass_stop", "")
end

function var_0_0.SetGaussion(arg_32_0, arg_32_1)
	arg_32_0:SetGaussionBg(arg_32_1)
	manager.ui:SetUISeparateRender(arg_32_1)
	SetActive(arg_32_0.gaussionBgGo_, arg_32_1)
end

function var_0_0.ShowNextGo(arg_33_0, arg_33_1)
	if arg_33_0.lockNextGoStatus_ then
		return
	end

	SetActive(arg_33_0.dialogNext_, arg_33_1)
	SetActive(arg_33_0.dialogNextBtnGo_, not arg_33_1)

	if arg_33_1 and arg_33_0.dialog_.activeSelf then
		return
	end

	SetActive(arg_33_0.typewriterNext_, arg_33_1)
end

function var_0_0.Update(arg_34_0, arg_34_1)
	if not arg_34_0.isPlay_ then
		if arg_34_0.state_ == "hiding" then
			if Input.anyKey then
				arg_34_0.__isAnyKey = true
			elseif arg_34_0.__isAnyKey then
				arg_34_0.__isAnyKey = false

				if not Input.GetMouseButtonUp(0) then
					arg_34_0:OnClickBtnAll()
				end
			end

			arg_34_0.allBtn_.enabled = true
		end

		return
	end

	if arg_34_0.state_ ~= "pause" then
		arg_34_0.time_ = arg_34_0.time_ + arg_34_1
		arg_34_0.frameCnt_ = arg_34_0.frameCnt_ + 1
	end

	if arg_34_0.onSingleLineUpdate_ then
		arg_34_0.onSingleLineUpdate_(arg_34_1)
	end

	for iter_34_0, iter_34_1 in ipairs(arg_34_0.playingNodeList_) do
		if arg_34_0.time_ >= iter_34_1:GetStartTime() and not iter_34_1.onPlayInvoked_ then
			iter_34_1:Play()
		end

		if not iter_34_1.isResident_ then
			if arg_34_0.time_ >= iter_34_1:GetStartTime() and arg_34_0.time_ < iter_34_1:GetStartTime() + iter_34_1:GetDuration() then
				iter_34_1:Update(arg_34_1)
			end

			if arg_34_0.time_ >= iter_34_1:GetStartTime() + iter_34_1:GetDuration() and iter_34_1:GetStatus() ~= StoryPlayerConst.NODE_STATUS.FINISHED then
				iter_34_1:Finish()
			end
		elseif iter_34_1.onPlayInvoked_ and iter_34_1:GetStatus() == StoryPlayerConst.NODE_STATUS.PLAYING then
			iter_34_1:Update(arg_34_1)
		end
	end

	arg_34_0:ClearFinishNode()

	if arg_34_0.time_ > arg_34_0.duration_ and arg_34_0.onSingleLineFinish_ then
		arg_34_0.onSingleLineFinish_()

		if arg_34_0.duration_ < 2 then
			arg_34_0.auto_time = 2 - arg_34_0.duration_
		end

		if arg_34_0.auto_time <= 0 then
			arg_34_0.auto_time = 1
		end
	end

	if arg_34_0.state_ == "waiting" and arg_34_0.playNext_ and arg_34_0.auto_ then
		if arg_34_0.auto_time <= 0 and not arg_34_0.choicesGo_.activeSelf then
			arg_34_0:StopWaitVoiceLanguageTimer()
			arg_34_0:PlayNextAct(1)

			arg_34_0.auto_time = 0
		else
			arg_34_0.auto_time = arg_34_0.auto_time - arg_34_1
		end
	end
end

function var_0_0.FormatText(arg_35_0, arg_35_1)
	arg_35_1 = GetI18NText(arg_35_1)

	local var_35_0 = string.gsub(arg_35_1, "#{(%w+)}#", function(arg_36_0)
		local var_36_0 = arg_35_0.keyword[arg_36_0]

		if var_36_0 then
			return var_36_0
		else
			return arg_36_0
		end
	end)

	return (arg_35_0:ReplaceSpace(var_35_0))
end

function var_0_0.ReplaceSpace(arg_37_0, arg_37_1)
	return arg_37_1
end

function var_0_0.RecordName(arg_38_0, arg_38_1)
	local var_38_0 = "\n<size=32><color=#2ea9f6>【" .. arg_38_1 .. "】</color></size>\n"

	if SettingData:GetCurrentLanguage() == "kr" then
		local var_38_1 = "\n<size=32><color=#2ea9f6>[" .. arg_38_1 .. "]</color></size>\n"
	end

	local var_38_2 = Object.Instantiate(arg_38_0.historyItemGo_, arg_38_0.historyContentTrans_)
	local var_38_3 = StoryHistoryItem.New(var_38_2)

	table.insert(arg_38_0.historyItems_, var_38_3)

	arg_38_0.curHistoryItem_ = var_38_3

	var_38_3:SetTitle(arg_38_1)
end

function var_0_0.RecordContent(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_1 .. "\n"

	arg_39_0.curHistoryItem_:SetContent(var_39_0)
end

function var_0_0.RecordHistoryTalkVoice(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	arg_40_0.curHistoryItem_:SetVoiceCallback(function(arg_41_0)
		arg_40_0:StopWaitVoiceLanguageTimer()

		if arg_40_0.voicePlaybackTimer_ == nil then
			arg_40_0.voicePlaybackTimer_ = {}
		end

		if arg_40_0.voicePlaybackTimer_[arg_40_2] then
			return
		end

		arg_40_0:AudioAction("play", "voice", arg_40_1, arg_40_2, arg_40_3)

		local var_41_0 = arg_40_0.CriAtomExPlaybacks_[arg_40_2]

		if var_41_0 then
			arg_40_0.playingRecord_ = true

			local var_41_1

			var_41_1 = FrameTimer.New(function()
				if tonumber(tostring(var_41_0.time)) < 0 then
					arg_40_0.playingRecord_ = false

					arg_41_0:StopVoiceAni()
					var_41_1:Stop()

					arg_40_0.voicePlaybackTimer_[arg_40_2] = nil
				else
					arg_41_0:PlayVoiceAni()
				end
			end, 1, -1)

			var_41_1:Start()

			arg_40_0.voicePlaybackTimer_[arg_40_2] = var_41_1
		end
	end)
end

function var_0_0.GetFullAwbName(arg_43_0, arg_43_1)
	if arg_43_1 ~= "" then
		arg_43_1 = string.format("%s.awb", tostring(arg_43_1))
	end

	return arg_43_1
end

function var_0_0.AudioAction(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5)
	if arg_44_1 == "play" then
		if not manager.audio:HasCueSheet(arg_44_3) then
			arg_44_0.loadedCueSheet_[arg_44_3] = true
		end

		if arg_44_2 == "voice" then
			arg_44_0.CriAtomExPlaybacks_[arg_44_4] = manager.audio:PlayVoice(arg_44_3, arg_44_4, arg_44_0:GetFullAwbName(arg_44_5))
		elseif arg_44_2 == "music" then
			arg_44_0.CriAtomExPlaybacks_[arg_44_4] = manager.audio:PlayBGM(arg_44_3, arg_44_4, arg_44_0:GetFullAwbName(arg_44_5))
		elseif arg_44_2 == "effect" then
			arg_44_0.CriAtomExPlaybacks_[arg_44_4] = manager.audio:PlayEffect(arg_44_3, arg_44_4, arg_44_0:GetFullAwbName(arg_44_5))
		end

		if not arg_44_0.musicType[arg_44_2] then
			arg_44_0.musicType[arg_44_2] = {}
		end

		arg_44_0.musicType[arg_44_2][arg_44_4] = 1
	end

	local var_44_0 = arg_44_0.CriAtomExPlaybacks_[arg_44_4]

	if var_44_0 then
		if arg_44_1 == "pause" then
			var_44_0:Pause()
		elseif arg_44_1 == "resume" then
			var_44_0:Resume(CriAtomEx.ResumeMode.AllPlayback)
		elseif arg_44_1 == "stop" then
			var_44_0:Stop()
		elseif arg_44_1 == "forcestop" then
			var_44_0:Stop(true)
		end
	end
end

function var_0_0.ShowWeapon(arg_45_0, arg_45_1, arg_45_2)
	LuaForUtil.ShowWeapon(arg_45_1, arg_45_2)
end

function var_0_0.CheckSpriteTmpPos(arg_46_0, arg_46_1, arg_46_2)
	arg_46_0.spriteActors_[arg_46_1] = arg_46_2

	for iter_46_0, iter_46_1 in pairs(arg_46_0.spriteActors_) do
		if iter_46_0 ~= arg_46_1 and iter_46_1 == arg_46_2 and not isNil(arg_46_0.actors_[iter_46_0]) then
			arg_46_0.actors_[iter_46_0]:SetActive(false)
		end
	end

	if not isNil(arg_46_0.actors_[arg_46_1]) then
		arg_46_0.actors_[arg_46_1]:SetActive(true)
	end
end

function var_0_0.SetSpriteNiuquEffect(arg_47_0, arg_47_1, arg_47_2)
	arg_47_0.niuquAnimator = arg_47_0.niuqueffectGo_:GetComponent(typeof(Animator))
	arg_47_0.niuquEffectActor[arg_47_1] = arg_47_2

	if not isNil(arg_47_0.actors_[arg_47_1]) then
		local var_47_0 = arg_47_0.actors_[arg_47_1]
		local var_47_1 = arg_47_0.actors_[arg_47_1].transform.childCount
		local var_47_2 = GameObjectTools.GetOrAddComponent(var_47_0, typeof(Animator))
		local var_47_3

		for iter_47_0 = 0, var_47_1 - 1 do
			local var_47_4 = var_47_0.transform:GetChild(iter_47_0)

			if var_47_4.name == "common" then
				local var_47_5 = var_47_4
			end

			local var_47_6 = GameObjectTools.GetOrAddComponent(var_47_4.gameObject, typeof(UI_Shader_Wrap.UIImageGlitch))
			local var_47_7 = var_47_4:GetComponent(typeof(Image))

			if var_47_4.name == "common" then
				local var_47_8 = arg_47_0.niuqucommonGo_:GetComponent(typeof(Image)).material

				var_47_7.material = arg_47_2 and var_47_8 or arg_47_0.commoneffectImg_.material
			else
				local var_47_9 = arg_47_0.niuqueffectGo_:GetComponent(typeof(Image)).material

				var_47_7.material = arg_47_2 and var_47_9 or arg_47_0.spliteffectImg_.material
			end

			var_47_6.enabled = arg_47_2
			var_47_6._BlurSize = 0

			if not arg_47_2 then
				var_47_7.color = Color(1, 1, 1)
			else
				var_47_6._AbberationColor1 = Color(0.76, 1, 0.97)
				var_47_6._AbberationColor2 = Color(0.77, 1, 0.91)
				var_47_6.colorPlus = Color(0.58, 0.76, 1)
				var_47_6.colorPlusIntensity = 1.23
				var_47_6.mainPlusStrength = 0.124
				var_47_6._Segment = 20
				var_47_6._AlphaStrength = 1
				var_47_6._ColorIntensity = 2.43
				var_47_6.mainPlusRotation = 90
				var_47_6.mainPlusTex_ST = Vector4(15, 1, 0, 0)
				var_47_7.color = Color(0.73, 0.9, 1)
			end
		end

		var_47_2.runtimeAnimatorController = Asset.Load("AnimatorController/niuqu")
		var_47_2.enabled = arg_47_2
	end
end

function var_0_0.ResetNiuquEffect(arg_48_0)
	for iter_48_0, iter_48_1 in ipairs(arg_48_0.niuquEffectActor) do
		if not isNil(arg_48_0.actors_[iter_48_0]) and iter_48_1 then
			arg_48_0:SetSpriteNiuquEffect(iter_48_0, false)
		end
	end
end

function var_0_0.PlayTimeline(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	if arg_49_0.actors_[arg_49_1] == nil then
		local var_49_0 = Object.Instantiate(Asset.Load("Char/" .. arg_49_1), arg_49_0.stage_.transform)

		var_49_0.name = arg_49_1
		var_49_0.transform.localPosition = Vector3.New(0, 100, 0)
		arg_49_0.actors_[arg_49_1] = var_49_0

		local var_49_1 = var_49_0.transform:Find("Directional Light")

		if var_49_1 then
			SetActive(var_49_1.gameObject, false)
		end

		local var_49_2 = var_49_0:GetComponentInChildren(typeof(CharacterEffect))

		var_49_2.enabled = true

		local var_49_3 = GameObjectTools.GetOrAddComponent(var_49_0, typeof(DynamicBoneHelper))

		if var_49_3 then
			var_49_3:EnableDynamicBone(false)
		end

		arg_49_0:ShowWeapon(var_49_2.transform, false)

		arg_49_0.var_[arg_49_1 .. "Animator"] = var_49_2.gameObject:GetComponent(typeof(UnityEngine.Animator))

		if var_49_1 then
			-- block empty
		end

		arg_49_0.var_[arg_49_1 .. "Animator"].applyRootMotion = true
		arg_49_0.var_[arg_49_1 .. "LipSync"] = var_49_2.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
	end

	local var_49_4 = "ActionTimelineAnimator"

	if arg_49_3 ~= nil then
		var_49_4 = "EmotionTimelineAnimator"
	end

	local var_49_5 = arg_49_0.actors_[arg_49_1]
	local var_49_6 = var_49_4 == "EmotionTimelineAnimator"
	local var_49_7 = Asset.InstantiateWithoutCache(arg_49_2)

	var_49_7.transform:SetParent(var_49_5.transform)

	local var_49_8 = var_49_7.transform:Find("Timeline").gameObject
	local var_49_9 = var_49_8:GetComponent("PlayableDirector")

	if var_49_6 and arg_49_0.var_[arg_49_1 .. var_49_4] and not isNil(arg_49_0.var_[arg_49_1 .. var_49_4]) then
		SetActive(var_49_8.gameObject, false)

		local var_49_10 = arg_49_0.var_[arg_49_1 .. var_49_4]:GetComponent("PlayableDirector")

		arg_49_0.timelineBindMgr.directorA = arg_49_0.var_[arg_49_1 .. var_49_4]:GetComponent("PlayableDirector")
		arg_49_0.timelineBindMgr.directorB = var_49_9:GetComponent("PlayableDirector")
		arg_49_0.timelineBindMgr.tpose_Object = arg_49_0.var_[arg_49_1 .. "Animator"].gameObject

		function arg_49_0.timelineBindMgr.callBack()
			SetActive(var_49_8.gameObject, true)

			var_49_9.time = 0

			var_49_9:Play()
		end

		arg_49_0.timelineBindMgr:GetmationParam()
		arg_49_0.timelineBindMgr:startLerp()
	end

	local var_49_11 = arg_49_0.var_[arg_49_1 .. "Animator"]
	local var_49_12 = arg_49_0.var_[arg_49_1 .. "LipSync"]

	if var_49_9 then
		local var_49_13 = var_49_9.playableAsset
		local var_49_14 = var_49_13.outputTrackCount

		for iter_49_0 = 0, var_49_14 - 1 do
			local var_49_15 = var_49_13:GetOutputTrack(iter_49_0)
			local var_49_16 = var_49_15.name

			if (var_49_16 == "Animator" or var_49_16 == "Animator Track") and var_49_11 then
				animationClip = var_49_15:GetClips()

				var_49_9:SetGenericBinding(var_49_15, var_49_11)

				if arg_49_0.var_[arg_49_1 .. var_49_4] then
					Object.Destroy(arg_49_0.var_[arg_49_1 .. var_49_4], var_49_6 and 0.3 or 0)
				end

				arg_49_0.var_[arg_49_1 .. var_49_4] = var_49_8
			elseif var_49_16 == "LipSync" and var_49_12 then
				var_49_9:SetGenericBinding(var_49_15, var_49_12)
			elseif var_49_16 == "Story Timeline Enable Render Track" then
				var_49_9:SetGenericBinding(var_49_15, var_49_5)
			end
		end

		if not var_49_6 then
			var_49_9.time = 0

			var_49_9:Play()
		end

		var_49_9.stopped = var_49_9.stopped + function(arg_51_0)
			Object.Destroy(arg_51_0.transform.parent.gameObject, 0.1)
		end

		table.insert(arg_49_0.timelineDirector, var_49_9)
	end
end

function var_0_0.PlayCameraTimeline(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = "CameraTimelineAnimator"

	arg_52_0:DestroyCameraTimeline()

	local var_52_1 = Asset.InstantiateWithoutCache(arg_52_1)

	var_52_1.transform:SetParent(arg_52_0.stage_.transform)

	var_52_1.transform.localPosition = Vector3.New(0, 0, 0)
	var_52_1.transform.localRotation = Quaternion.Euler(Vector3.New(0, 0, 0))

	local var_52_2 = var_52_1.transform:Find("Timeline").gameObject

	arg_52_0.var_[var_52_0] = var_52_2

	local var_52_3 = var_52_2:GetComponent("PlayableDirector")

	arg_52_0.cinemachineBrain = manager.ui.mainCameraCom_.gameObject:GetComponent("CinemachineBrain")

	if var_52_3 then
		if not isNil(arg_52_0.cinemachineBrain) then
			arg_52_0.cinemachineBrain.enabled = true
		end

		var_52_3.time = 0

		var_52_3:Play()

		var_52_3.stopped = var_52_3.stopped + function(arg_53_0)
			if not isNil(arg_52_0.cinemachineBrain) then
				arg_52_0.cinemachineBrain.enabled = false
			end

			Object.Destroy(arg_53_0.transform.parent.gameObject, 0.1)

			if arg_52_2 then
				manager.ui.mainCameraCom_.transform.localPosition = Vector3.New(0, 1, -10)
				manager.ui.mainCameraCom_.transform.localRotation = Quaternion.Euler(Vector3.New(0, 0, 0))
			end
		end

		table.insert(arg_52_0.timelineDirector, var_52_3)
	end
end

function var_0_0.DestroyCameraTimeline(arg_54_0)
	local var_54_0 = "CameraTimelineAnimator"

	if arg_54_0.var_[var_54_0] and not isNil(arg_54_0.var_[var_54_0]) then
		Object.Destroy(arg_54_0.var_[var_54_0], 0.1)

		arg_54_0.var_[var_54_0] = nil
	end
end

function var_0_0.CreatePrefabSceneGo(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	local var_55_0 = "___ScenePrefab"

	arg_55_0:DestroyPrefabSceneGo()

	if arg_55_0.bgs_[var_55_0] == nil then
		local var_55_1 = Asset.InstantiateWithoutCache(arg_55_1)

		var_55_1.transform.parent = arg_55_0.stage_.transform
		arg_55_0.bgs_[var_55_0] = var_55_1
	end

	arg_55_0.bgs_[var_55_0].transform.localPosition = arg_55_2
	arg_55_0.bgs_[var_55_0].transform.localRotation = Quaternion.Euler(arg_55_3)

	return arg_55_0.bgs_[var_55_0]
end

function var_0_0.DestroyPrefabSceneGo(arg_56_0)
	local var_56_0 = "___ScenePrefab"

	if not isNil(arg_56_0.bgs_[var_56_0]) then
		Object.Destroy(arg_56_0.bgs_[var_56_0])

		arg_56_0.bgs_[var_56_0] = nil
	end
end

function var_0_0.PlayOverlayAnimation(arg_57_0, arg_57_1, arg_57_2, arg_57_3, arg_57_4, arg_57_5, arg_57_6)
	if arg_57_0.actors_[arg_57_1] == nil then
		return
	end

	local var_57_0 = "ActionTimelineAnimator"

	if arg_57_0.var_[arg_57_1 .. var_57_0] and not isNil(arg_57_0.var_[arg_57_1 .. var_57_0]) then
		local var_57_1 = arg_57_0.var_[arg_57_1 .. var_57_0]:GetComponent("PlayableDirector")

		arg_57_0.actors_[arg_57_1]:GetComponentInChildren(typeof(StoryOverlayAnimationController)):PlayOverlayAnimation(var_57_1, arg_57_2, arg_57_3, arg_57_4, arg_57_5, arg_57_6)
	end
end

function var_0_0.Dispose(arg_58_0)
	for iter_58_0, iter_58_1 in ipairs(arg_58_0.playingNodeList_) do
		if iter_58_1:GetStatus() ~= StoryPlayerConst.NODE_STATUS.FINISHED then
			iter_58_1:Finish()
			StoryPlayNodeFactory.GetInstance():RetureNode(iter_58_1)
		end
	end

	StoryPlayNodeFactory.GetInstance():Dispose()
	manager.notify:RemoveListener(SOUND_SETTING_SWICH, arg_58_0.OnSoundSettingSwitchHandler_)

	arg_58_0.OnSoundSettingSwitchHandler_ = nil

	manager.notify:RemoveListener(STORY_SWITCH_VOICE_LANGUAGE, arg_58_0.OnVoiceLanguageSwitchHandler_)

	arg_58_0.OnVoiceLanguageSwitchHandler_ = nil

	arg_58_0:StopWaitVoiceLanguageTimer()

	if arg_58_0.isInLoopVideo then
		manager.video:Dispose()
	end

	if not isNil(arg_58_0.sceneSettingEffect_) then
		arg_58_0.sceneSettingEffect_.enabled = true
	end

	for iter_58_2, iter_58_3 in pairs(arg_58_0.timelineDirector) do
		if not isNil(iter_58_3) then
			iter_58_3:Stop()
		end
	end

	arg_58_0.timelineDirector = {}

	if arg_58_0.gameObject_ then
		Object.Destroy(arg_58_0.gameObject_)

		arg_58_0.gameObject_ = nil
	end

	for iter_58_4, iter_58_5 in pairs(arg_58_0.bgs_) do
		if iter_58_5 then
			Object.Destroy(iter_58_5)
		end
	end

	for iter_58_6, iter_58_7 in pairs(arg_58_0.actors_) do
		if iter_58_7 then
			Object.Destroy(iter_58_7)
		end
	end

	for iter_58_8, iter_58_9 in pairs(arg_58_0.textGroupItemDic_) do
		iter_58_9:Dispose()
	end

	if arg_58_0.stage_ then
		Object.Destroy(arg_58_0.stage_, 1)

		arg_58_0.stage_ = nil
	end

	for iter_58_10, iter_58_11 in pairs(arg_58_0.CriAtomExPlaybacks_) do
		if iter_58_11 then
			iter_58_11:Stop()
		end
	end

	if arg_58_0.voicePlaybackTimer_ then
		for iter_58_12, iter_58_13 in pairs(arg_58_0.voicePlaybackTimer_) do
			if iter_58_13 then
				arg_58_0.playingRecord_ = false

				iter_58_13:Stop()
			end
		end
	end

	for iter_58_14, iter_58_15 in pairs(arg_58_0.actionList) do
		if iter_58_15.Dispose then
			iter_58_15:Dispose()
		end
	end

	manager.audio:ClearBGMFlag()
	manager.uiTime:OnExitStory(arg_58_0.storyId_)

	for iter_58_16, iter_58_17 in pairs(arg_58_0.var_) do
		if iter_58_17 and type(iter_58_17) == "userdata" and string.find(iter_58_16, "effect") then
			Object.Destroy(iter_58_17)
		end
	end

	if arg_58_0.skipView_ then
		arg_58_0.skipView_:Dispose()

		arg_58_0.skipView_ = nil
	end

	for iter_58_18, iter_58_19 in ipairs(arg_58_0.historyItems_) do
		iter_58_19:Dispose()
	end

	for iter_58_20, iter_58_21 in pairs(arg_58_0.loadedCueSheet_) do
		manager.audio:RemoveCue(iter_58_20)
		Debug.Log("剧情卸载cueSheet:" .. iter_58_20)
	end

	arg_58_0.curHistoryItem_ = nil
	arg_58_0.CriAtomExPlaybacks_ = {}
	arg_58_0.isPlay_ = false
	arg_58_0.auto_ = false
	arg_58_0.time_ = 0
	arg_58_0.duration_ = 0
	arg_58_0.state_ = ""
	arg_58_0.curStory_ = nil
	arg_58_0.isInRecall_ = false
	arg_58_0.onSingleLineFinish_ = nil
	arg_58_0.onSingleLineUpdate_ = nil
	arg_58_0.onStoryFinished_ = nil
	arg_58_0.playNext_ = nil

	if arg_58_0.timelineBindMgr then
		arg_58_0.timelineBindMgr:Dispose()

		arg_58_0.timelineBindMgr = nil
	end

	arg_58_0.bgs_ = {}
	arg_58_0.actors_ = {}
	arg_58_0.var_ = {}
	arg_58_0.spriteActors_ = {}

	AnimatorTools.Stop()
	var_0_0.super.Dispose(arg_58_0)
	arg_58_0:AudioAction("play", "voice", "story_v_empty", "empty", "")

	arg_58_0.loadedCueSheet_ = nil
end

function var_0_0.HideSkipBtn(arg_59_0, arg_59_1)
	SetActive(arg_59_0.skipBtn_.gameObject, not arg_59_1)
end

function var_0_0.Play(arg_60_0, arg_60_1)
	manager.guide.weakView:Hide()
	manager.uiTime:OnEnterStory(arg_60_1)

	arg_60_0.storyId_ = arg_60_1
	arg_60_0.var_ = {}

	local var_60_0 = _G["Story" .. arg_60_1]

	local function var_60_1()
		arg_60_0.curStory_ = StoryCfg[arg_60_1]

		local var_61_0 = arg_60_0.curStory_.start

		arg_60_0.curStoryInstance_ = var_60_0

		var_60_0["Play" .. var_61_0](var_60_0, arg_60_0)

		arg_60_0.isPlay_ = true

		manager.story:ResetStoryChoice()
		print("开始播放 " .. arg_60_1 .. ", " .. var_61_0)
	end

	arg_60_0:CheckNeedDownloadAssets(var_60_0, var_60_1)
end

function var_0_0.CheckNeedDownloadAssets(arg_62_0, arg_62_1, arg_62_2)
	if AssetDownloadManager.CheckResourcesNeedDownload(arg_62_1.assets) or AssetDownloadManager.CheckVoiceNeedDownload(arg_62_1.voices) then
		SetForceShowQuanquan(true)
		AssetDownloadManager.Create()
		AssetDownloadManager.Instance:AddResourceToDownloadQueue(arg_62_1.assets)
		AssetDownloadManager.Instance:AddVoiceToDownloadQueue(arg_62_1.voices)
		AssetDownloadManager.Instance:Run(nil, function()
			AssetDownloadManager.Destroy()
			arg_62_2()
			SetForceShowQuanquan(false)
		end, function()
			AssetDownloadManager.Destroy()
			SetForceShowQuanquan(false)
			arg_62_0.onStoryFinished_(true)
		end)
	else
		arg_62_2()
	end
end

function var_0_0.PlayNextAct(arg_65_0, arg_65_1)
	arg_65_0:ClearFinishNode()

	if arg_65_0.playNext_ then
		arg_65_0.playNext_(arg_65_1)

		if GameToSDK.IsEditorPlatform() then
			print("播放: " .. arg_65_0.curTalkId_)
		end
	end
end

function var_0_0.RecordAudio(arg_66_0, arg_66_1, arg_66_2)
	arg_66_0.CriAtomExPlaybacks_[arg_66_1] = arg_66_2
end

function var_0_0.GetPercentByPara(arg_67_0, arg_67_1, arg_67_2)
	local var_67_0 = 0
	local var_67_1 = string.split(arg_67_1, "\n\n")

	if table.length(var_67_1) <= 1 then
		var_67_1 = string.split(arg_67_1, "\n")
	end

	arg_67_1 = string.gsub(string.gsub(string.gsub(arg_67_1, "\n\n", ""), "\n", ""), " ", "")

	for iter_67_0 = 1, arg_67_2 do
		local var_67_2 = var_67_1[iter_67_0]
		local var_67_3 = string.gsub(string.gsub(string.gsub(var_67_2, "\n\n", ""), "\n", ""), " ", "")

		var_67_0 = var_67_0 + utf8.len(var_67_3)
	end

	return var_67_0 / utf8.len(arg_67_1), var_67_0
end

function var_0_0.CheckCanSkipToEnd(arg_68_0)
	if arg_68_0.curStoryInstance_.skipMarkers then
		for iter_68_0 = 1, #arg_68_0.curStoryInstance_.skipMarkers do
			if arg_68_0.curStoryInstance_.skipMarkers[iter_68_0] > arg_68_0.curTalkId_ then
				return false, arg_68_0.curStoryInstance_.skipMarkers[iter_68_0]
			end
		end
	end

	return true, nil
end

function var_0_0.GetWordFromCfg(arg_69_0, arg_69_1)
	if StoryWordCfg[arg_69_1] ~= nil then
		return StoryWordCfg[arg_69_1]
	else
		local var_69_0 = 1
		local var_69_1

		repeat
			var_69_0 = var_69_0 + 1

			local var_69_2 = string.format("StoryWordCfg%d", var_69_0)

			if _G[var_69_2] and _G[var_69_2][arg_69_1] then
				return _G[var_69_2][arg_69_1]
			end
		until _G[var_69_2] == nil
	end

	error("无法在StoryWordCfg表中找到 " .. arg_69_1)

	return nil
end

function var_0_0.RefreshSoundState(arg_70_0)
	if SettingData:GetSoundSettingData().sound_open == 1 then
		arg_70_0.soundController_:SetSelectedState("on")
	else
		arg_70_0.soundController_:SetSelectedState("off")
	end
end

function var_0_0.OnSoundSettingSwitch(arg_71_0)
	arg_71_0:RefreshSoundState()
end

function var_0_0.OnVoiceLanguageSwitch(arg_72_0, arg_72_1)
	arg_72_0.voiceLanguage_ = arg_72_1

	if arg_72_0.state_ == "waiting" and not arg_72_0.playingRecord_ then
		SettingData:SetStoryVoiceLanguageCache()
		SettingAction.ChangeSoundSetting("voice_language", arg_72_0.voiceLanguage_)
	else
		arg_72_0:AddWaitVoiceLanguageTimer()
	end

	SettingData:SetStoryVoiceLanguageCache()
	SettingAction.ChangeSoundSetting("voice_language", arg_72_1)

	if arg_72_0.curStoryInstance_ then
		arg_72_0:CheckNeedDownloadAssets(arg_72_0.curStoryInstance_, function()
			return
		end)
	end
end

function var_0_0.AddWaitVoiceLanguageTimer(arg_74_0)
	arg_74_0.voiceLanguageTimer_ = FrameTimer.New(function()
		if arg_74_0.state_ == "waiting" and not arg_74_0.playingRecord_ then
			arg_74_0:StopWaitVoiceLanguageTimer()
		end
	end, 1, -1)

	arg_74_0.voiceLanguageTimer_:Start()
end

function var_0_0.StopWaitVoiceLanguageTimer(arg_76_0)
	if arg_76_0.voiceLanguageTimer_ then
		arg_76_0.playingRecord_ = false

		SettingData:SetStoryVoiceLanguageCache()
		SettingAction.ChangeSoundSetting("voice_language", arg_76_0.voiceLanguage_)
		arg_76_0.voiceLanguageTimer_:Stop()

		arg_76_0.voiceLanguageTimer_ = nil
	end
end

function var_0_0.RecordChoiceLog(arg_77_0, arg_77_1, arg_77_2, arg_77_3, arg_77_4)
	arg_77_0.curChoiseId = tonumber(arg_77_1)

	if not arg_77_0.choicesID[tonumber(arg_77_1)] then
		arg_77_0.choicesID[tonumber(arg_77_1)] = {
			arg_77_2,
			arg_77_3,
			arg_77_4
		}
	end
end

function var_0_0.GetChoiceLog(arg_78_0, arg_78_1)
	local var_78_0 = "["

	if arg_78_0.choicesID[tonumber(arg_78_1)] then
		for iter_78_0, iter_78_1 in ipairs(arg_78_0.choicesID[tonumber(arg_78_1)]) do
			if iter_78_0 == 1 then
				var_78_0 = var_78_0 .. iter_78_1
			else
				var_78_0 = var_78_0 .. "," .. iter_78_1
			end
		end

		return var_78_0 .. "]"
	end

	return ""
end

function var_0_0.GetDuration(arg_79_0)
	return arg_79_0.duration_
end

function var_0_0.SetDuration(arg_80_0, arg_80_1)
	arg_80_0.duration_ = arg_80_1
end

function var_0_0.Pause(arg_81_0)
	for iter_81_0, iter_81_1 in ipairs(arg_81_0.playingNodeList_) do
		iter_81_1:Pause()
	end
end

function var_0_0.Resume(arg_82_0)
	for iter_82_0, iter_82_1 in ipairs(arg_82_0.playingNodeList_) do
		iter_82_1:Resume()
	end
end

function var_0_0.Hide(arg_83_0)
	for iter_83_0, iter_83_1 in ipairs(arg_83_0.playingNodeList_) do
		iter_83_1:Hide()
	end
end

function var_0_0.InitPlayNodeList(arg_84_0)
	arg_84_0:ClearFinishNode()

	for iter_84_0, iter_84_1 in ipairs(arg_84_0.nodeConfigList_) do
		arg_84_0.playingNodeList_[#arg_84_0.playingNodeList_ + 1] = StoryPlayNodeFactory.GetInstance():GetNode(iter_84_1)
	end
end

function var_0_0.ClearFinishNode(arg_85_0)
	local var_85_0 = {}

	for iter_85_0, iter_85_1 in ipairs(arg_85_0.playingNodeList_) do
		if iter_85_1:GetStatus() == StoryPlayerConst.NODE_STATUS.FINISHED then
			StoryPlayNodeFactory.GetInstance():RetureNode(iter_85_1)
		else
			var_85_0[#var_85_0 + 1] = iter_85_1
		end
	end

	arg_85_0.playingNodeList_ = var_85_0
end

function var_0_0.ClearAllNode(arg_86_0)
	for iter_86_0, iter_86_1 in pairs(arg_86_0.textGroupItemDic_) do
		iter_86_1:Dispose()
	end

	arg_86_0.textGroupItemDic_ = {}

	SetActive(arg_86_0.textGroupNextGo_, false)
end

function var_0_0.CreatePlayNode(arg_87_0, arg_87_1)
	local var_87_0 = _G[arg_87_1.className].New(arg_87_0)

	var_87_0:SetConfig(arg_87_1)

	return var_87_0
end

function var_0_0.FinishResidentNodeByClassName(arg_88_0, arg_88_1)
	for iter_88_0, iter_88_1 in ipairs(arg_88_0.playingNodeList_) do
		if iter_88_1.config_.className == arg_88_1 and iter_88_1.isResident_ and iter_88_1:GetStatus() ~= StoryPlayerConst.NODE_STATUS.FINISHED then
			iter_88_1:Finish()
			StoryPlayNodeFactory.GetInstance():RetureNode(iter_88_1)
		end
	end
end

function var_0_0.GetActorGo(arg_89_0, arg_89_1, arg_89_2, arg_89_3)
	if arg_89_1 == StoryPlayerConst.ACTOR_TYPE.Sprite then
		return arg_89_0:GetSpriteGo(arg_89_2, arg_89_3)
	elseif arg_89_1 == StoryPlayerConst.ACTOR_TYPE.Background then
		return arg_89_0:GetBackgroundGo(arg_89_2, arg_89_3)
	elseif arg_89_1 == StoryPlayerConst.ACTOR_TYPE.ActorSprite then
		return arg_89_0:GetActorSpriteGo(arg_89_2, arg_89_3)
	elseif arg_89_1 == StoryPlayerConst.ACTOR_TYPE.Tpose then
		return arg_89_0:GetTposeGo(arg_89_2, arg_89_3)
	else
		Debug.LogError("undifined actor type: " .. arg_89_1)
	end
end

function var_0_0.GetSpriteGo(arg_90_0, arg_90_1, arg_90_2)
	if arg_90_0.actors_[arg_90_1] == nil then
		local var_90_0 = Object.Instantiate(arg_90_0.imageGo_, arg_90_0.canvasGo_.transform)

		var_90_0.transform:SetSiblingIndex(1)

		var_90_0.name = arg_90_1

		local var_90_1 = var_90_0:GetComponent(typeof(Image))

		var_90_1.sprite = arg_90_0:GetAsset(StoryPlayerConst.ACTOR_TYPE.Sprite, arg_90_2)

		var_90_1:SetNativeSize()

		var_90_0.transform.localPosition = Vector3.New(0, 100000, 0)
		arg_90_0.actors_[arg_90_1] = var_90_0
	end

	return arg_90_0.actors_[arg_90_1]
end

function var_0_0.GetBackgroundGo(arg_91_0, arg_91_1, arg_91_2)
	if arg_91_0.bgs_[arg_91_1] == nil then
		local var_91_0 = Object.Instantiate(arg_91_0.paintGo_)

		var_91_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas(arg_91_2)
		var_91_0.name = arg_91_1
		var_91_0.transform.parent = arg_91_0.stage_.transform
		var_91_0.transform.localPosition = Vector3.New(0, 100, 0)
		arg_91_0.bgs_[arg_91_1] = var_91_0
	end

	return arg_91_0.bgs_[arg_91_1]
end

function var_0_0.GetActorSpriteGo(arg_92_0, arg_92_1, arg_92_2)
	if arg_92_0.actors_[arg_92_1] == nil then
		local var_92_0 = Asset.Load(arg_92_2)

		if not isNil(var_92_0) then
			local var_92_1 = Object.Instantiate(var_92_0, arg_92_0.canvasGo_.transform)

			var_92_1.transform:SetSiblingIndex(1)

			var_92_1.name = arg_92_1
			var_92_1.transform.localPosition = Vector3.New(0, 100000, 0)
			arg_92_0.actors_[arg_92_1] = var_92_1

			local var_92_2 = var_92_1:GetComponentsInChildren(typeof(Image), true):ToTable()

			if arg_92_0.isInRecall_ then
				for iter_92_0, iter_92_1 in ipairs(var_92_2) do
					iter_92_1.color = arg_92_0.hightColor1 or Color.New(0.82, 0.77, 0.62)
				end
			end
		end
	end

	return arg_92_0.actors_[arg_92_1]
end

function var_0_0.GetTposeGo(arg_93_0, arg_93_1, arg_93_2)
	if arg_93_0.actors_[arg_93_1] == nil then
		local var_93_0 = Asset.Load(arg_93_2)

		if not isNil(var_93_0) then
			local var_93_1 = Object.Instantiate(var_93_0, arg_93_0.stage_.transform)

			var_93_1.name = arg_93_1
			var_93_1.transform.localPosition = Vector3.New(0, 100, 0)
			arg_93_0.actors_[arg_93_1] = var_93_1

			local var_93_2 = var_93_1:GetComponentInChildren(typeof(CharacterEffect))

			var_93_2.enabled = true

			local var_93_3 = GameObjectTools.GetOrAddComponent(var_93_1, typeof(DynamicBoneHelper))

			if var_93_3 then
				var_93_3:EnableDynamicBone(false)
			end

			arg_93_0:ShowWeapon(var_93_2.transform, false)

			arg_93_0.var_[arg_93_1 .. "Animator"] = var_93_2.gameObject:GetComponent(typeof(UnityEngine.Animator))
			arg_93_0.var_[arg_93_1 .. "Animator"].applyRootMotion = true
			arg_93_0.var_[arg_93_1 .. "LipSync"] = var_93_2.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
		end
	end

	return arg_93_0.actors_[arg_93_1]
end

function var_0_0.GetAsset(arg_94_0, arg_94_1, arg_94_2)
	arg_94_0.assetDic_[arg_94_1] = arg_94_0.assetDic_[arg_94_1] or {}

	if arg_94_0.assetDic_[arg_94_1][arg_94_2] == nil then
		arg_94_0.assetDic_[arg_94_1][arg_94_2] = arg_94_0:CreateAssetData(arg_94_1, arg_94_2)
	end

	return arg_94_0.assetDic_[arg_94_1][arg_94_2].asset
end

function var_0_0.CreateAssetData(arg_95_0, arg_95_1, arg_95_2)
	return {
		type = arg_95_1,
		assetPath = arg_95_2,
		asset = arg_95_0:LoadAsset(arg_95_1, arg_95_2)
	}
end

function var_0_0.LoadAsset(arg_96_0, arg_96_1, arg_96_2)
	if arg_96_1 == StoryPlayerConst.ACTOR_TYPE.Sprite or StoryPlayerConst.ACTOR_TYPE.Background then
		return getSpriteWithoutAtlas(arg_96_2)
	end
end

function var_0_0.GetBackgroundVideoController(arg_97_0)
	local var_97_0 = false

	if not isNil(arg_97_0.backgroundVideoViewGo_) then
		Object.Destroy(arg_97_0.backgroundVideoViewGo_)

		arg_97_0.backgroundVideoViewGo_ = nil
	end

	if isNil(arg_97_0.backgroundVideoViewGo_) then
		arg_97_0.backgroundVideoViewGo_ = Object.Instantiate(Asset.Load("Widget/System/Story/StoryBackgroundVideo"), arg_97_0.stage_.transform)
		var_97_0 = true
	end

	SetActive(arg_97_0.backgroundVideoViewGo_, true)

	arg_97_0.criManaMovieController_ = arg_97_0.backgroundVideoViewGo_:GetComponent("CriManaMovieController")

	if isNil(arg_97_0.criManaMovieController_.player) then
		arg_97_0.criManaMovieController_:PlayerManualInitialize()
	end

	return arg_97_0.criManaMovieController_, var_97_0
end

function var_0_0.RetureBackgroundVideoController(arg_98_0)
	SetActive(arg_98_0.backgroundVideoViewGo_, false)
end

function var_0_0.GetTextGroupItem(arg_99_0, arg_99_1)
	if not arg_99_0.textGroupItemDic_[arg_99_1] then
		local var_99_0 = Object.Instantiate(arg_99_0.textGroupTemplateGo_, arg_99_0.textGroupContainerTrans_)

		SetActive(var_99_0, true)

		var_99_0.name = "textGroup_" .. arg_99_1
		arg_99_0.textGroupItemDic_[arg_99_1] = StoryTextGroupItem.New(var_99_0, arg_99_0)
	end

	SetActive(arg_99_0.textGroupNextGo_, true)

	return arg_99_0.textGroupItemDic_[arg_99_1]
end

function var_0_0.DestoryTextGroup(arg_100_0, arg_100_1)
	if arg_100_0.textGroupItemDic_[arg_100_1] then
		arg_100_0.textGroupItemDic_[arg_100_1]:Dispose()

		arg_100_0.textGroupItemDic_[arg_100_1] = nil
	end

	local var_100_0 = false

	for iter_100_0, iter_100_1 in pairs(arg_100_0.textGroupItemDic_) do
		if iter_100_1 ~= nil then
			local var_100_1 = arg_100_0:GetWordFromCfg(iter_100_1.config_.contentID)

			if arg_100_0:FormatText(var_100_1.content) ~= "" then
				var_100_0 = true

				break
			end
		end
	end

	if not var_100_0 then
		SetActive(arg_100_0.textGroupNextGo_, false)
	end
end

function var_0_0.InitVirtualCamera(arg_101_0)
	arg_101_0.virtualCameraContainerTrans_ = GameObject.Find("StoryStage/VirtualCameraContainer").transform
	arg_101_0.commonVirtualCamera_ = arg_101_0.virtualCameraContainerTrans_:Find("CommonVirtualCamera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))

	LuaForUtil.SetCinemachineVirtualCameraFOV(arg_101_0.commonVirtualCamera_, manager.ui.mainCameraCom_.fieldOfView)
end

function var_0_0.GetCurVirtualCamera(arg_102_0)
	return arg_102_0.commonVirtualCamera_
end

return var_0_0
