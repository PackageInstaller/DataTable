local StoryPlayer2 = class("StoryPlayer2", import("game.extend.ReduxView"))

function StoryPlayer2:Ctor(arg_1_1)
	self.isPlay_ = false
	self.auto_time = 0
	self.time_ = 0
	self.frameCnt_ = 0
	self.duration_ = 0
	self.gameObject_ = nil
	self.stage_ = arg_1_1
	self.stage_.name = "StoryStage"
	self.state_ = ""
	self.auto_ = false
	self.curStory_ = nil
	self.curStoryInstance_ = nil
	self.curTalkId_ = nil
	self.isInRecall_ = false
	self.onSingleLineFinish_ = nil
	self.onSingleLineUpdate_ = nil
	self.onStoryFinished_ = nil
	self.playNext_ = nil
	self.bgs_ = {}
	self.actors_ = {}
	self.spriteActors_ = {}
	self.textGroupItemDic_ = {}
	self.assetDic_ = {}
	self.loadedCueSheet_ = {}
	self.CriAtomExPlaybacks_ = {}
	self.timelineDirector = {}
	self.marker = ""
	self.keyword = {}
	self.keyword.nickname = PlayerData:GetPlayerInfo().nick
	self.talkMaxDuration = 0
	self.typewritterCharCountI18N = 0
	self.musicType = {}
	self.niuquEffectActor = {}
	self.actionList = {}
	self.playingNodeList_ = {}

	StoryPlayNodeFactory.GetInstance():SetStoryPlayer(self)

	self.virtualCameraContainerTrans_ = nil
	self.commonVirtualCamera_ = nil
	self.lockNextGoStatus_ = false

	self:Init()
end

function StoryPlayer2:Init()
	self:InitUI()
	self:InitTimlineBind()
	self:InitUIEvents()
end

function StoryPlayer2:InitTimlineBind()
	if not isNil(self.timelineBindMgr) or not self.timelineBindMgr then
		self.timelineBindMgr = GameObjectTools.GetOrAddComponent(self.timelinebindmgrGo_, typeof(BlendTwoTimelines))
	end
end

function StoryPlayer2:InitUI()
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Story/StoryUI"), manager.ui.uiStory.transform)
	self.transform_ = self.gameObject_.transform

	ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject_)
	self:AdaptScreen()

	self.settingData = SettingData:GetGameSettingData()
	self.iconController_ = ControllerUtil.GetController(self.iconTrs_, "conName")
	self.musicController = self.musicController_:GetController("music")
	self.choices_ = {}

	for iter_4_0 = 1, 4 do
		self.choices_[iter_4_0] = {
			isShow = true,
			go = self["itemGo" .. iter_4_0 .. "_"],
			txt = self["itemText" .. iter_4_0 .. "_"]
		}
	end

	self.choicesID = {}
	self.fswtw_ = self.typeWritterGo_:GetComponent("UITypewriterEffect")

	self.fswbg_:SetActive(false)
	SetActive(self.lastBtn_.gameObject, true)
	SetActive(self.bgmBtn_.gameObject, true)
	SetActive(self.locationGo_, false)
	SetActive(self.dialog_, false)
	SetActive(self.bgmBtn_.gameObject, self.settingData.show_music_name == 1)
	SetActive(self.showGo_, false)

	self.bgmTxt_.text = ""
	self.bgmTxt2_.text = ""

	self.musicController:SetSelectedState("hide")

	if SceneSetting.Current then
		self.sceneSettingEffect_ = SceneSetting.Current

		self.sceneSettingGo_:SetActive(false)
	else
		self.sceneSettingGo_:SetActive(true)
	end

	self.screenFilterGo_:SetActive(false)

	self.screenFilterEffect_ = self.screenFilterGo_:GetComponent("Volume")
	self.typewritter = self.text_.gameObject:GetComponent("UITypewriterEffect")
	self.dialogCg_.alpha = 0
	self.blackMask_.alpha = 0
	self.blackMask_.blocksRaycasts = false

	self:ShowNextGo(false)

	self.autoplayController_ = self.controller_:GetController("autoplay")
	self.hideBtnsController_ = self:ControllerExtend(self.controller_:GetController("hideBtns"))
	self.hideAllUIController_ = self.controller_:GetController("hideAllUI")
	self.callingController_ = self.controller_:GetController("Calling")
	self.timestampController_ = self.controller_:GetController("Timestamp")
	self.timestampColorController_ = self.timestampControllerexcollection_:GetController("BlueRed")

	self.timestampController_:SetSelectedState("hide")

	self.historyItems_ = {}
	self.lastHistoryVoiceIdx_ = nil
	self.curHistoryItem_ = nil
	self.musicType = {}
	self.niuquEffectActor = {}

	SetActive(self.talkGo_, false)
	self.autoplayController_:SetSelectedState("manual")

	self.soundController_ = self.soundControllerEx_:GetController("sound")
	self.OnSoundSettingSwitchHandler_ = handler(self, self.OnSoundSettingSwitch)

	manager.notify:RegistListener(SOUND_SETTING_SWICH, self.OnSoundSettingSwitchHandler_)
	self:RefreshSoundState()

	self.OnVoiceLanguageSwitchHandler_ = handler(self, self.OnVoiceLanguageSwitch)

	manager.notify:RegistListener(STORY_SWITCH_VOICE_LANGUAGE, self.OnVoiceLanguageSwitchHandler_)
	self:InitVirtualCamera()
end

function StoryPlayer2:ControllerExtend(arg_5_1)
	local var_5_0 = self

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

function StoryPlayer2:InitUIEvents()
	self:AddBtnListener(self.allBtn_, nil, function()
		self:OnClickBtnAll()
	end)
	self:AddBtnListener(self.panelBtn_, nil, function()
		self:OnClickBtnAll()
	end)
	self:AddBtnListener(self.hideBtn_, nil, function()
		if self.auto_ then
			self.auto_ = false

			self.autoplayController_:SetSelectedState("manual")
		end

		SetActive(self.dialog_, false)
		self.hideBtnsController_:SetSelectedState("hide")

		self.allBtnState = self.allBtn_.enabled
		self.fullScreenWordFlag_ = self.fswbg_.activeSelf

		SetActive(self.fswbg_, false)

		self.state_ = "hiding"

		self:Hide()

		self.isPlay_ = false

		SDKTools.SendMessageToSDK("story_oper", {
			oper = StoryOperDefine.HIDE,
			is_first = PlayerData:GetStoryList()[self.curStory_.id] and 0 or 1,
			story_id = self.curStory_.id
		})
	end)
	self:AddBtnListener(self.autoBtn_, nil, function()
		self.auto_ = true

		self.autoplayController_:SetSelectedState("auto")
		SDKTools.SendMessageToSDK("story_oper", {
			oper = StoryOperDefine.AUTO,
			is_first = PlayerData:GetStoryList()[self.curStory_.id] and 0 or 1,
			story_id = string.format(self.curStory_.id)
		})
	end)
	self:AddBtnListener(self.manualBtn_, nil, function()
		self.auto_ = false

		self.autoplayController_:SetSelectedState("manual")
	end)
	self:AddBtnListener(self.bgmBtn_, nil, function()
		if self.musicController:GetSelectedState() == "show" then
			self.musicController:SetSelectedState("hide")
			self.musicAnimator_:Play("back")
		else
			self.musicController:SetSelectedState("show")
			self.musicAnimator_:Play("open")
		end

		if self.bgmTimer then
			self.bgmTimer:Stop()

			self.bgmTimer = nil
		end
	end)
	SetActive(self.history_, true)
	SetActive(self.history_, false)
	self:AddBtnListener(self.lastBtn_, nil, function()
		if SDKTools.GetIsOverSea() then
			self:JumpToEnd()
		end

		self:Pause()

		self.isPlay_ = false

		SetActive(self.history_, true)

		self.showGo_.transform.localScale = Vector3.New(0, 0, 0)

		self.hideBtnsController_:SetSelectedState("hide")
		manager.ui:SetUISeparateRender(true)

		self.historyRect_.verticalNormalizedPosition = 0

		SDKTools.SendMessageToSDK("story_oper", {
			oper = StoryOperDefine.REPLAY,
			is_first = PlayerData:GetStoryList()[self.curStory_.id] and 0 or 1,
			story_id = string.format(self.curStory_.id)
		})
	end)
	self:AddBtnListener(self.historyBtn_, nil, function()
		self:Resume()

		self.isPlay_ = true

		SetActive(self.history_, false)

		self.showGo_.transform.localScale = Vector3.New(1, 1, 1)

		self.hideBtnsController_:SetSelectedState("show")
		manager.ui:SetUISeparateRender(false)
		self:RefreshMusicName()
	end)

	for iter_7_0 = 1, 4 do
		self:AddBtnListener(self["itemBtn" .. iter_7_0 .. "_"], nil, function()
			manager.story:SetStoryChoice(iter_7_0)
			self:PlayNextAct(iter_7_0)
			SetActive(self.choicesGo_, false)

			local var_16_1 = self.choicesID[tonumber(self.curChoiseId)] and self.choicesID[tonumber(self.curChoiseId)][iter_7_0] or ""

			SDKTools.SendMessageToSDK("story_oper", {
				story_id = self.curStory_.id,
				is_first = PlayerData:GetStoryList()[self.curStory_.id] and 0 or 1,
				oper = StoryOperDefine.OPTION,
				param_id = self.curChoiseId,
				params_list = self:GetChoiceLog(self.curChoiseId),
				params_select = var_16_1
			})
		end)
	end

	self:AddBtnListener(self.skipBtn_, nil, function()
		local var_17_0, var_17_1 = self:CheckCanSkipToEnd()

		if var_17_0 then
			self:Skip()
		else
			self:JumpToMarker(var_17_1)
		end

		SetActive(self.choicesGo_, false)
	end)
	self:AddBtnListener(self.narrativeSkipBtn_, nil, function()
		self.onStoryFinished_(true)
	end)
	self:AddBtnListener(self.narrativeExitBtn_, nil, function()
		self.onStoryFinished_(true)
	end)
	self:AddBtnListener(self.narrativeContinueBtn_, nil, function()
		self.onStoryFinished_(true)
	end)
	self:AddBtnListener(self.soundBtn_, nil, function()
		self:Go("storySoundSetting")
	end)
end

function StoryPlayer2:RefreshMusicName()
	local var_22_0 = manager.audio:GetBgmPlayer()

	if var_22_0 then
		local var_22_2 = manager.audio:GetAudioName(var_22_0.cueName or "", var_22_0.cueSheet or "")

		self.bgmTxt_.text = var_22_2
		self.bgmTxt2_.text = var_22_2

		self.musicChangeAnimator_:Play("music_change_idle", 0, 0)
	end
end

function StoryPlayer2:OnClickBtnAll()
	if self.state_ == "hiding" then
		self.state_ = "waiting"
		self.isPlay_ = true

		SetActive(self.dialog_, true)
		self.hideBtnsController_:SetSelectedState("show")

		self.allBtn_.enabled = self.allBtnState

		SetActive(self.fswbg_, self.fullScreenWordFlag_ and true)

		if self.fullScreenWordFlag_ == true then
			SetActive(self.dialog_, false)
		end
	elseif self.state_ == "waiting" and not self.choicesGo_.activeSelf then
		self:StopWaitVoiceLanguageTimer()
		self:PlayNextAct(1)
	elseif (self.dialogNext_.activeSelf or self.typewriterNext_.activeSelf) and not self.choicesGo_.activeSelf then
		self:JumpToEnd()

		if not self.choicesGo_.activeSelf then
			self:PlayNextAct(1)
		end
	elseif self.state_ == "playing" then
		self:JumpToEnd()
	end
end

function StoryPlayer2:JumpToEnd()
	for iter_24_0 = 1, (self.duration_ - self.time_) / 0.033 + 1 do
		self:Update(0.033)
	end

	if self.dialogScrollRect_ then
		self.dialogScrollRect_.normalizedPosition = Vector2(0, 0)
	end
end

function StoryPlayer2:JumpToMarker(arg_25_1)
	while arg_25_1 > self.curTalkId_ do
		self:JumpToEnd()
		self:PlayNextAct(1)
	end

	if arg_25_1 == self.curTalkId_ then
		for iter_25_0 = 1, (self.duration_ - self.time_) / 0.033 + 1 do
			self:Update(0.033)

			if self.marker ~= "" then
				return
			end
		end
	end

	self:Skip()
end

function StoryPlayer2:StopAllVoice()
	for iter_26_0, iter_26_1 in pairs(self.CriAtomExPlaybacks_) do
		if iter_26_1 then
			iter_26_1:Stop()
		end
	end

	self.CriAtomExPlaybacks_ = {}

	self:StopBgmTxt()
end

function StoryPlayer2:StopBgmTxt()
	if self.bgmTimer then
		self.bgmTimer:Stop()

		self.bgmTimer = nil
	end

	if self == nil or isNil(self.bgmTxt_) then
		return
	end

	self.musicController:SetSelectedState("hide")
	self.musicAnimator_:Play("back", 0, 0)

	self.bgmTxt_.text = ""
	self.bgmTxt2_.text = ""
end

function StoryPlayer2:PlayOnlyBgm()
	for iter_28_0, iter_28_1 in pairs(self.CriAtomExPlaybacks_) do
		if iter_28_1 and self.musicType.music and not self.musicType.music[iter_28_0] == 1 then
			iter_28_1:Stop()
			table.remove(self.CriAtomExPlaybacks_, iter_28_0)
		end
	end
end

function StoryPlayer2:Skip(arg_29_1)
	local var_29_0 = false

	if not arg_29_1 then
		arg_29_1 = StoryOperDefine.PASS
	else
		var_29_0 = true
	end

	local var_29_1 = self.curStory_.name
	local var_29_2 = self.curStory_.desc

	self.isPlay_ = false
	self.auto_ = false

	self.autoplayController_:SetSelectedState("manual")

	if var_29_2 and var_29_2 ~= "" then
		for iter_29_0, iter_29_1 in pairs(self.CriAtomExPlaybacks_) do
			if iter_29_1 then
				iter_29_1:Pause()
			end
		end

		manager.audio:ClearBGMFlag()

		local var_29_3 = manager.story:IsStoryPlayed(self.curStory_.id)
		local var_29_4

		if self.skipView_ == nil then
			if var_29_3 or var_29_0 then
				var_29_4 = "Widget/System/Story/StorySkipUI"
				self.skipView_ = StoryForceSkipView.New((Object.Instantiate(Asset.Load("Widget/System/Story/StorySkipUI"), manager.ui.uiStory.transform)))
			else
				var_29_4 = "Widget/System/Story/StorySkip2UI"
				self.skipView_ = StorySkip2View.New((Object.Instantiate(Asset.Load("Widget/System/Story/StorySkip2UI"), manager.ui.uiStory.transform)))
			end
		else
			SetActive(self.skipView_.gameObject_, true)
		end

		if not var_29_3 and not var_29_0 then
			manager.ui:SetUISeparateRender(true)
		end

		self.skipView_:SetContentTitle(var_29_1, self:FormatText(var_29_2))
		self.skipView_:SetCallback(handler(self, function(arg_30_0, arg_30_1)
			if arg_30_1 then
				self.isPlay_ = true

				for iter_30_0, iter_30_1 in pairs(self.CriAtomExPlaybacks_) do
					if iter_30_1 then
						iter_30_1:Resume(CriAtomEx.ResumeMode.PausedPlayback)
					end
				end

				if self.skipView_ then
					self.skipView_:Dispose()

					self.skipView_ = nil
				end

				if var_29_4 then
					Asset.Unload(var_29_4)
				end

				return
			end

			local var_30_0 = PlayerData:GetStoryList()[self.curStory_.id] and 0 or 1

			SDKTools.SendMessageToSDK("story_oper", {
				oper = arg_29_1,
				is_first = PlayerData:GetStoryList()[self.curStory_.id] and 0 or 1,
				story_id = string.format(self.curStory_.id)
			})

			if BirthdayCfg.get_id_list_by_story_id[self.curStory_.id] and var_30_0 == 1 then
				SDKTools.SendMessageToSDK("birthday_viewed", {
					story_skip = 1
				})
			end

			self:StopPassVoice()
			self.onStoryFinished_(true)
		end))
	else
		local var_29_5 = PlayerData:GetStoryList()[self.curStory_.id] and 0 or 1

		SDKTools.SendMessageToSDK("story_oper", {
			oper = arg_29_1,
			is_first = PlayerData:GetStoryList()[self.curStory_.id] and 0 or 1,
			story_id = string.format(self.curStory_.id)
		})

		if BirthdayCfg.get_id_list_by_story_id[self.curStory_.id] and var_29_5 == 1 then
			SDKTools.SendMessageToSDK("birthday_viewed", {
				story_skip = 1
			})
		end

		self:StopPassVoice()
		self.onStoryFinished_(true)
	end
end

function StoryPlayer2:StopPassVoice()
	manager.audio:PlayBGM("ui_skip", "ui_reset_filter")
	manager.audio:PlayEffect("ui_skip", "ui_reset", "")
	manager.audio:PlayEffect("se_story_activity_1_2_summer1", "se_story_activity_1_2_lowpass_stop", "")
end

function StoryPlayer2:SetGaussion(arg_32_1)
	self:SetGaussionBg(arg_32_1)
	manager.ui:SetUISeparateRender(arg_32_1)
	SetActive(self.gaussionBgGo_, arg_32_1)
end

function StoryPlayer2:ShowNextGo(arg_33_1)
	if self.lockNextGoStatus_ then
		return
	end

	SetActive(self.dialogNext_, arg_33_1)
	SetActive(self.dialogNextBtnGo_, not arg_33_1)

	if arg_33_1 and self.dialog_.activeSelf then
		return
	end

	SetActive(self.typewriterNext_, arg_33_1)
end

function StoryPlayer2:Update(arg_34_1)
	if not self.isPlay_ then
		if self.state_ == "hiding" then
			if Input.anyKey then
				self.__isAnyKey = true
			elseif self.__isAnyKey then
				self.__isAnyKey = false

				if not Input.GetMouseButtonUp(0) then
					self:OnClickBtnAll()
				end
			end

			self.allBtn_.enabled = true
		end

		return
	end

	if self.state_ ~= "pause" then
		self.time_ = self.time_ + arg_34_1
		self.frameCnt_ = self.frameCnt_ + 1
	end

	if self.onSingleLineUpdate_ then
		self.onSingleLineUpdate_(arg_34_1)
	end

	for iter_34_0, iter_34_1 in ipairs(self.playingNodeList_) do
		if self.time_ >= iter_34_1:GetStartTime() and not iter_34_1.onPlayInvoked_ then
			iter_34_1:Play()
		end

		if not iter_34_1.isResident_ then
			if self.time_ >= iter_34_1:GetStartTime() and self.time_ < iter_34_1:GetStartTime() + iter_34_1:GetDuration() then
				iter_34_1:Update(arg_34_1)
			end

			if self.time_ >= iter_34_1:GetStartTime() + iter_34_1:GetDuration() and iter_34_1:GetStatus() ~= StoryPlayerConst.NODE_STATUS.FINISHED then
				iter_34_1:Finish()
			end
		elseif iter_34_1.onPlayInvoked_ and iter_34_1:GetStatus() == StoryPlayerConst.NODE_STATUS.PLAYING then
			iter_34_1:Update(arg_34_1)
		end
	end

	self:ClearFinishNode()

	if self.time_ > self.duration_ and self.onSingleLineFinish_ then
		self.onSingleLineFinish_()

		if self.duration_ < 2 then
			self.auto_time = 2 - self.duration_
		end

		if self.auto_time <= 0 then
			self.auto_time = 1
		end
	end

	if self.state_ == "waiting" and self.playNext_ and self.auto_ then
		if self.auto_time <= 0 and not self.choicesGo_.activeSelf then
			self:StopWaitVoiceLanguageTimer()
			self:PlayNextAct(1)

			self.auto_time = 0
		else
			self.auto_time = self.auto_time - arg_34_1
		end
	end
end

function StoryPlayer2:FormatText(arg_35_1)
	arg_35_1 = GetI18NText(arg_35_1)

	return (self:ReplaceSpace((string.gsub(arg_35_1, "#{(%w+)}#", function(arg_36_0)
		if self.keyword[arg_36_0] then
			return self.keyword[arg_36_0]
		else
			return arg_36_0
		end
	end))))
end

function StoryPlayer2:ReplaceSpace(arg_37_1)
	return arg_37_1
end

function StoryPlayer2:RecordName(arg_38_1)
	if SettingData:GetCurrentLanguage() == "kr" then
		-- block empty
	end

	local var_38_2 = StoryHistoryItem.New((Object.Instantiate(self.historyItemGo_, self.historyContentTrans_)))

	table.insert(self.historyItems_, var_38_2)

	self.curHistoryItem_ = var_38_2

	var_38_2:SetTitle(arg_38_1)
end

function StoryPlayer2:RecordContent(arg_39_1)
	self.curHistoryItem_:SetContent(arg_39_1 .. "\n")
end

function StoryPlayer2:RecordHistoryTalkVoice(arg_40_1, arg_40_2, arg_40_3)
	self.curHistoryItem_:SetVoiceCallback(function(arg_41_0)
		self:StopWaitVoiceLanguageTimer()

		if self.voicePlaybackTimer_ == nil then
			self.voicePlaybackTimer_ = {}
		end

		if self.voicePlaybackTimer_[arg_40_2] then
			return
		end

		self:AudioAction("play", "voice", arg_40_1, arg_40_2, arg_40_3)

		local var_41_0 = self.CriAtomExPlaybacks_[arg_40_2]

		if self.CriAtomExPlaybacks_[arg_40_2] then
			self.playingRecord_ = true

			local var_41_1

			var_41_1 = FrameTimer.New(function()
				if tonumber(tostring(var_41_0.time)) < 0 then
					self.playingRecord_ = false

					arg_41_0:StopVoiceAni()
					var_41_1:Stop()

					self.voicePlaybackTimer_[arg_40_2] = nil
				else
					arg_41_0:PlayVoiceAni()
				end
			end, 1, -1)

			;(nil):Start()

			self.voicePlaybackTimer_[arg_40_2] = var_41_1
		end
	end)
end

function StoryPlayer2:GetFullAwbName(arg_43_1)
	if arg_43_1 ~= "" then
		arg_43_1 = string.format("%s.awb", tostring(arg_43_1))
	end

	return arg_43_1
end

function StoryPlayer2:AudioAction(arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5)
	if arg_44_1 == "play" then
		if not manager.audio:HasCueSheet(arg_44_3) then
			self.loadedCueSheet_[arg_44_3] = true
		end

		if arg_44_2 == "voice" then
			self.CriAtomExPlaybacks_[arg_44_4] = manager.audio:PlayVoice(arg_44_3, arg_44_4, self:GetFullAwbName(arg_44_5))
		elseif arg_44_2 == "music" then
			self.CriAtomExPlaybacks_[arg_44_4] = manager.audio:PlayBGM(arg_44_3, arg_44_4, self:GetFullAwbName(arg_44_5))
		elseif arg_44_2 == "effect" then
			self.CriAtomExPlaybacks_[arg_44_4] = manager.audio:PlayEffect(arg_44_3, arg_44_4, self:GetFullAwbName(arg_44_5))
		end

		self.musicType[arg_44_2] = self.musicType[arg_44_2] or {}
		self.musicType[arg_44_2][arg_44_4] = 1
	end

	local var_44_0 = self.CriAtomExPlaybacks_[arg_44_4]

	if self.CriAtomExPlaybacks_[arg_44_4] then
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

function StoryPlayer2:ShowWeapon(arg_45_1, arg_45_2)
	LuaForUtil.ShowWeapon(arg_45_1, arg_45_2)
end

function StoryPlayer2:CheckSpriteTmpPos(arg_46_1, arg_46_2)
	self.spriteActors_[arg_46_1] = arg_46_2

	for iter_46_0, iter_46_1 in pairs(self.spriteActors_) do
		if iter_46_0 ~= arg_46_1 and iter_46_1 == arg_46_2 and not isNil(self.actors_[iter_46_0]) then
			self.actors_[iter_46_0]:SetActive(false)
		end
	end

	if not isNil(self.actors_[arg_46_1]) then
		self.actors_[arg_46_1]:SetActive(true)
	end
end

function StoryPlayer2:SetSpriteNiuquEffect(arg_47_1, arg_47_2)
	self.niuquAnimator = self.niuqueffectGo_:GetComponent(typeof(Animator))
	self.niuquEffectActor[arg_47_1] = arg_47_2

	if not isNil(self.actors_[arg_47_1]) then
		local var_47_0 = GameObjectTools.GetOrAddComponent(self.actors_[arg_47_1], typeof(Animator))

		for iter_47_0 = 0, self.actors_[arg_47_1].transform.childCount - 1 do
			local var_47_2 = self.actors_[arg_47_1].transform:GetChild(iter_47_0)

			if var_47_2.name == "common" then
				-- block empty
			end

			local var_47_4 = GameObjectTools.GetOrAddComponent(var_47_2.gameObject, typeof(UI_Shader_Wrap.UIImageGlitch))
			local var_47_5 = var_47_2:GetComponent(typeof(Image))

			var_47_5.material = var_47_2.name == "common" and (arg_47_2 and self.niuqucommonGo_:GetComponent(typeof(Image)).material or self.commoneffectImg_.material) or arg_47_2 and self.niuqueffectGo_:GetComponent(typeof(Image)).material or self.spliteffectImg_.material
			var_47_4.enabled = arg_47_2
			var_47_4._BlurSize = 0

			if not arg_47_2 then
				var_47_5.color = Color(1, 1, 1)
			else
				var_47_4._AbberationColor1 = Color(0.76, 1, 0.97)
				var_47_4._AbberationColor2 = Color(0.77, 1, 0.91)
				var_47_4.colorPlus = Color(0.58, 0.76, 1)
				var_47_4.colorPlusIntensity = 1.23
				var_47_4.mainPlusStrength = 0.124
				var_47_4._Segment = 20
				var_47_4._AlphaStrength = 1
				var_47_4._ColorIntensity = 2.43
				var_47_4.mainPlusRotation = 90
				var_47_4.mainPlusTex_ST = Vector4(15, 1, 0, 0)
				var_47_5.color = Color(0.73, 0.9, 1)
			end
		end

		var_47_0.runtimeAnimatorController = Asset.Load("AnimatorController/niuqu")
		var_47_0.enabled = arg_47_2
	end
end

function StoryPlayer2:ResetNiuquEffect()
	for iter_48_0, iter_48_1 in ipairs(self.niuquEffectActor) do
		if not isNil(self.actors_[iter_48_0]) and iter_48_1 then
			self:SetSpriteNiuquEffect(iter_48_0, false)
		end
	end
end

function StoryPlayer2:PlayTimeline(arg_49_1, arg_49_2, arg_49_3)
	if self.actors_[arg_49_1] == nil then
		local var_49_0 = Object.Instantiate(Asset.Load("Char/" .. arg_49_1), self.stage_.transform)

		var_49_0.name = arg_49_1
		var_49_0.transform.localPosition = Vector3.New(0, 100, 0)
		self.actors_[arg_49_1] = var_49_0

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

		self:ShowWeapon(var_49_2.transform, false)

		self.var_[arg_49_1 .. "Animator"] = var_49_2.gameObject:GetComponent(typeof(UnityEngine.Animator))

		if var_49_1 then
			-- block empty
		end

		self.var_[arg_49_1 .. "Animator"].applyRootMotion = true
		self.var_[arg_49_1 .. "LipSync"] = var_49_2.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
	end

	local var_49_4 = "ActionTimelineAnimator"

	if arg_49_3 ~= nil then
		var_49_4 = "EmotionTimelineAnimator"
	end

	local var_49_5 = self.actors_[arg_49_1]
	local var_49_6 = var_49_4 == "EmotionTimelineAnimator"
	local var_49_7 = Asset.InstantiateWithoutCache(arg_49_2)

	var_49_7.transform:SetParent(self.actors_[arg_49_1].transform)

	local var_49_8 = var_49_7.transform:Find("Timeline").gameObject
	local var_49_9 = var_49_8:GetComponent("PlayableDirector")

	if var_49_6 and self.var_[arg_49_1 .. var_49_4] and not isNil(self.var_[arg_49_1 .. var_49_4]) then
		SetActive(var_49_8.gameObject, false)

		local var_49_10 = self.var_[arg_49_1 .. var_49_4]:GetComponent("PlayableDirector")

		self.timelineBindMgr.directorA = self.var_[arg_49_1 .. var_49_4]:GetComponent("PlayableDirector")
		self.timelineBindMgr.directorB = var_49_9:GetComponent("PlayableDirector")
		self.timelineBindMgr.tpose_Object = self.var_[arg_49_1 .. "Animator"].gameObject

		function self.timelineBindMgr.callBack()
			SetActive(var_49_8.gameObject, true)

			var_49_9.time = 0

			var_49_9:Play()
		end

		self.timelineBindMgr:GetmationParam()
		self.timelineBindMgr:startLerp()
	end

	local var_49_11 = self.var_[arg_49_1 .. "Animator"]
	local var_49_12 = self.var_[arg_49_1 .. "LipSync"]

	if var_49_9 then
		for iter_49_0 = 0, var_49_9.playableAsset.outputTrackCount - 1 do
			local var_49_13 = var_49_9.playableAsset:GetOutputTrack(iter_49_0)
			local var_49_14 = var_49_13.name

			if (var_49_13.name == "Animator" or var_49_14 == "Animator Track") and var_49_11 then
				animationClip = var_49_13:GetClips()

				var_49_9:SetGenericBinding(var_49_13, var_49_11)

				if self.var_[arg_49_1 .. var_49_4] then
					Object.Destroy(self.var_[arg_49_1 .. var_49_4], var_49_6 and 0.3 or 0)
				end

				self.var_[arg_49_1 .. var_49_4] = var_49_8
			elseif var_49_14 == "LipSync" and var_49_12 then
				var_49_9:SetGenericBinding(var_49_13, var_49_12)
			elseif var_49_14 == "Story Timeline Enable Render Track" then
				var_49_9:SetGenericBinding(var_49_13, var_49_5)
			end
		end

		if not var_49_6 then
			var_49_9.time = 0

			var_49_9:Play()
		end

		var_49_9.stopped = var_49_9.stopped + function(arg_51_0)
			Object.Destroy(arg_51_0.transform.parent.gameObject, 0.1)
		end

		table.insert(self.timelineDirector, var_49_9)
	end
end

function StoryPlayer2:PlayCameraTimeline(arg_52_1, arg_52_2)
	self:DestroyCameraTimeline()

	local var_52_0 = Asset.InstantiateWithoutCache(arg_52_1)

	var_52_0.transform:SetParent(self.stage_.transform)

	var_52_0.transform.localPosition = Vector3.New(0, 0, 0)
	var_52_0.transform.localRotation = Quaternion.Euler(Vector3.New(0, 0, 0))

	local var_52_1 = var_52_0.transform:Find("Timeline").gameObject

	self.var_.CameraTimelineAnimator = var_52_1

	local var_52_2 = var_52_1:GetComponent("PlayableDirector")

	self.cinemachineBrain = manager.ui.mainCameraCom_.gameObject:GetComponent("CinemachineBrain")

	if var_52_2 then
		if not isNil(self.cinemachineBrain) then
			self.cinemachineBrain.enabled = true
		end

		var_52_2.time = 0

		var_52_2:Play()

		var_52_2.stopped = var_52_2.stopped + function(arg_53_0)
			if not isNil(self.cinemachineBrain) then
				self.cinemachineBrain.enabled = false
			end

			Object.Destroy(arg_53_0.transform.parent.gameObject, 0.1)

			if arg_52_2 then
				manager.ui.mainCameraCom_.transform.localPosition = Vector3.New(0, 1, -10)
				manager.ui.mainCameraCom_.transform.localRotation = Quaternion.Euler(Vector3.New(0, 0, 0))
			end
		end

		table.insert(self.timelineDirector, var_52_2)
	end
end

function StoryPlayer2:DestroyCameraTimeline()
	if self.var_.CameraTimelineAnimator and not isNil(self.var_.CameraTimelineAnimator) then
		Object.Destroy(self.var_.CameraTimelineAnimator, 0.1)

		self.var_.CameraTimelineAnimator = nil
	end
end

function StoryPlayer2:CreatePrefabSceneGo(arg_55_1, arg_55_2, arg_55_3)
	self:DestroyPrefabSceneGo()

	if self.bgs_.___ScenePrefab == nil then
		local var_55_0 = Asset.InstantiateWithoutCache(arg_55_1)

		var_55_0.transform.parent = self.stage_.transform
		self.bgs_.___ScenePrefab = var_55_0
	end

	self.bgs_.___ScenePrefab.transform.localPosition = arg_55_2
	self.bgs_.___ScenePrefab.transform.localRotation = Quaternion.Euler(arg_55_3)

	return self.bgs_.___ScenePrefab
end

function StoryPlayer2:DestroyPrefabSceneGo()
	if not isNil(self.bgs_.___ScenePrefab) then
		Object.Destroy(self.bgs_.___ScenePrefab)

		self.bgs_.___ScenePrefab = nil
	end
end

function StoryPlayer2:PlayOverlayAnimation(arg_57_1, arg_57_2, arg_57_3, arg_57_4, arg_57_5, arg_57_6)
	if self.actors_[arg_57_1] == nil then
		return
	end

	local var_57_0 = "ActionTimelineAnimator"

	if self.var_[arg_57_1 .. "ActionTimelineAnimator"] and not isNil(self.var_[arg_57_1 .. var_57_0]) then
		self.actors_[arg_57_1]:GetComponentInChildren(typeof(StoryOverlayAnimationController)):PlayOverlayAnimation(self.var_[arg_57_1 .. var_57_0]:GetComponent("PlayableDirector"), arg_57_2, arg_57_3, arg_57_4, arg_57_5, arg_57_6)
	end
end

function StoryPlayer2:Dispose()
	for iter_58_0, iter_58_1 in ipairs(self.playingNodeList_) do
		if iter_58_1:GetStatus() ~= StoryPlayerConst.NODE_STATUS.FINISHED then
			iter_58_1:Finish()
			StoryPlayNodeFactory.GetInstance():RetureNode(iter_58_1)
		end
	end

	StoryPlayNodeFactory.GetInstance():Dispose()
	manager.notify:RemoveListener(SOUND_SETTING_SWICH, self.OnSoundSettingSwitchHandler_)

	self.OnSoundSettingSwitchHandler_ = nil

	manager.notify:RemoveListener(STORY_SWITCH_VOICE_LANGUAGE, self.OnVoiceLanguageSwitchHandler_)

	self.OnVoiceLanguageSwitchHandler_ = nil

	self:StopWaitVoiceLanguageTimer()

	if self.isInLoopVideo then
		manager.video:Dispose()
	end

	if not isNil(self.sceneSettingEffect_) then
		self.sceneSettingEffect_.enabled = true
	end

	for iter_58_2, iter_58_3 in pairs(self.timelineDirector) do
		if not isNil(iter_58_3) then
			iter_58_3:Stop()
		end
	end

	self.timelineDirector = {}

	if self.gameObject_ then
		Object.Destroy(self.gameObject_)

		self.gameObject_ = nil
	end

	for iter_58_4, iter_58_5 in pairs(self.bgs_) do
		if iter_58_5 then
			Object.Destroy(iter_58_5)
		end
	end

	for iter_58_6, iter_58_7 in pairs(self.actors_) do
		if iter_58_7 then
			Object.Destroy(iter_58_7)
		end
	end

	for iter_58_8, iter_58_9 in pairs(self.textGroupItemDic_) do
		iter_58_9:Dispose()
	end

	if self.stage_ then
		Object.Destroy(self.stage_, 1)

		self.stage_ = nil
	end

	for iter_58_10, iter_58_11 in pairs(self.CriAtomExPlaybacks_) do
		if iter_58_11 then
			iter_58_11:Stop()
		end
	end

	if self.voicePlaybackTimer_ then
		for iter_58_12, iter_58_13 in pairs(self.voicePlaybackTimer_) do
			if iter_58_13 then
				self.playingRecord_ = false

				iter_58_13:Stop()
			end
		end
	end

	for iter_58_14, iter_58_15 in pairs(self.actionList) do
		if iter_58_15.Dispose then
			iter_58_15:Dispose()
		end
	end

	manager.audio:ClearBGMFlag()
	manager.uiTime:OnExitStory(self.storyId_)

	for iter_58_16, iter_58_17 in pairs(self.var_) do
		if iter_58_17 and type(iter_58_17) == "userdata" and string.find(iter_58_16, "effect") then
			Object.Destroy(iter_58_17)
		end
	end

	if self.skipView_ then
		self.skipView_:Dispose()

		self.skipView_ = nil
	end

	for iter_58_18, iter_58_19 in ipairs(self.historyItems_) do
		iter_58_19:Dispose()
	end

	for iter_58_20, iter_58_21 in pairs(self.loadedCueSheet_) do
		manager.audio:RemoveCue(iter_58_20)
		Debug.Log("剧情卸载cueSheet:" .. iter_58_20)
	end

	self.curHistoryItem_ = nil
	self.CriAtomExPlaybacks_ = {}
	self.isPlay_ = false
	self.auto_ = false
	self.time_ = 0
	self.duration_ = 0
	self.state_ = ""
	self.curStory_ = nil
	self.isInRecall_ = false
	self.onSingleLineFinish_ = nil
	self.onSingleLineUpdate_ = nil
	self.onStoryFinished_ = nil
	self.playNext_ = nil

	if self.timelineBindMgr then
		self.timelineBindMgr:Dispose()

		self.timelineBindMgr = nil
	end

	self.bgs_ = {}
	self.actors_ = {}
	self.var_ = {}
	self.spriteActors_ = {}

	AnimatorTools.Stop()
	StoryPlayer2.super.Dispose(self)
	self:AudioAction("play", "voice", "story_v_empty", "empty", "")

	self.loadedCueSheet_ = nil
end

function StoryPlayer2:HideSkipBtn(arg_59_1)
	SetActive(self.skipBtn_.gameObject, not arg_59_1)
end

function StoryPlayer2:Play(arg_60_1)
	manager.guide.weakView:Hide()
	manager.uiTime:OnEnterStory(arg_60_1)

	self.storyId_ = arg_60_1
	self.var_ = {}

	local var_60_0 = _G["Story" .. arg_60_1]

	self:CheckNeedDownloadAssets(_G["Story" .. arg_60_1], function()
		self.curStory_ = StoryCfg[arg_60_1]
		self.curStoryInstance_ = var_60_0

		var_60_0["Play" .. self.curStory_.start](var_60_0, self)

		self.isPlay_ = true

		manager.story:ResetStoryChoice()
		print("开始播放 " .. arg_60_1 .. ", " .. self.curStory_.start)
	end)
end

function StoryPlayer2:CheckNeedDownloadAssets(arg_62_1, arg_62_2)
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
			self.onStoryFinished_(true)
		end)
	else
		arg_62_2()
	end
end

function StoryPlayer2:PlayNextAct(arg_65_1)
	self:ClearFinishNode()

	if self.playNext_ then
		self.playNext_(arg_65_1)

		if GameToSDK.IsEditorPlatform() then
			print("播放: " .. self.curTalkId_)
		end
	end
end

function StoryPlayer2:RecordAudio(arg_66_1, arg_66_2)
	self.CriAtomExPlaybacks_[arg_66_1] = arg_66_2
end

function StoryPlayer2:GetPercentByPara(arg_67_1, arg_67_2)
	local var_67_0 = 0
	local var_67_1 = string.split(arg_67_1, "\n\n")

	if table.length(var_67_1) <= 1 then
		var_67_1 = string.split(arg_67_1, "\n")
	end

	arg_67_1 = string.gsub(string.gsub(string.gsub(arg_67_1, "\n\n", ""), "\n", ""), " ", "")

	for iter_67_0 = 1, arg_67_2 do
		var_67_0 = var_67_0 + utf8.len((string.gsub(string.gsub(string.gsub(var_67_1[iter_67_0], "\n\n", ""), "\n", ""), " ", "")))
	end

	return var_67_0 / utf8.len(arg_67_1), var_67_0
end

function StoryPlayer2:CheckCanSkipToEnd()
	if self.curStoryInstance_.skipMarkers then
		for iter_68_0 = 1, #self.curStoryInstance_.skipMarkers do
			if self.curStoryInstance_.skipMarkers[iter_68_0] > self.curTalkId_ then
				return false, self.curStoryInstance_.skipMarkers[iter_68_0]
			end
		end
	end

	return true, nil
end

function StoryPlayer2:GetWordFromCfg(arg_69_1)
	if StoryWordCfg[arg_69_1] ~= nil then
		return StoryWordCfg[arg_69_1]
	else
		local var_69_0 = 1

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

function StoryPlayer2:RefreshSoundState()
	if SettingData:GetSoundSettingData().sound_open == 1 then
		self.soundController_:SetSelectedState("on")
	else
		self.soundController_:SetSelectedState("off")
	end
end

function StoryPlayer2:OnSoundSettingSwitch()
	self:RefreshSoundState()
end

function StoryPlayer2:OnVoiceLanguageSwitch(arg_72_1)
	self.voiceLanguage_ = arg_72_1

	if self.state_ == "waiting" and not self.playingRecord_ then
		SettingData:SetStoryVoiceLanguageCache()
		SettingAction.ChangeSoundSetting("voice_language", self.voiceLanguage_)
	else
		self:AddWaitVoiceLanguageTimer()
	end

	SettingData:SetStoryVoiceLanguageCache()
	SettingAction.ChangeSoundSetting("voice_language", arg_72_1)

	if self.curStoryInstance_ then
		self:CheckNeedDownloadAssets(self.curStoryInstance_, function()
			return
		end)
	end
end

function StoryPlayer2:AddWaitVoiceLanguageTimer()
	self.voiceLanguageTimer_ = FrameTimer.New(function()
		if self.state_ == "waiting" and not self.playingRecord_ then
			self:StopWaitVoiceLanguageTimer()
		end
	end, 1, -1)

	self.voiceLanguageTimer_:Start()
end

function StoryPlayer2:StopWaitVoiceLanguageTimer()
	if self.voiceLanguageTimer_ then
		self.playingRecord_ = false

		SettingData:SetStoryVoiceLanguageCache()
		SettingAction.ChangeSoundSetting("voice_language", self.voiceLanguage_)
		self.voiceLanguageTimer_:Stop()

		self.voiceLanguageTimer_ = nil
	end
end

function StoryPlayer2:RecordChoiceLog(arg_77_1, arg_77_2, arg_77_3, arg_77_4)
	self.curChoiseId = tonumber(arg_77_1)
	self.choicesID[tonumber(arg_77_1)] = self.choicesID[tonumber(arg_77_1)] or {
		arg_77_2,
		arg_77_3,
		arg_77_4
	}
end

function StoryPlayer2:GetChoiceLog(arg_78_1)
	local var_78_0 = "["

	if self.choicesID[tonumber(arg_78_1)] then
		for iter_78_0, iter_78_1 in ipairs(self.choicesID[tonumber(arg_78_1)]) do
			var_78_0 = iter_78_0 == 1 and var_78_0 .. iter_78_1 or var_78_0 .. "," .. iter_78_1
		end

		return var_78_0 .. "]"
	end

	return ""
end

function StoryPlayer2:GetDuration()
	return self.duration_
end

function StoryPlayer2:SetDuration(arg_80_1)
	self.duration_ = arg_80_1
end

function StoryPlayer2:Pause()
	for iter_81_0, iter_81_1 in ipairs(self.playingNodeList_) do
		iter_81_1:Pause()
	end
end

function StoryPlayer2:Resume()
	for iter_82_0, iter_82_1 in ipairs(self.playingNodeList_) do
		iter_82_1:Resume()
	end
end

function StoryPlayer2:Hide()
	for iter_83_0, iter_83_1 in ipairs(self.playingNodeList_) do
		iter_83_1:Hide()
	end
end

function StoryPlayer2:InitPlayNodeList()
	self:ClearFinishNode()

	for iter_84_0, iter_84_1 in ipairs(self.nodeConfigList_) do
		self.playingNodeList_[#self.playingNodeList_ + 1] = StoryPlayNodeFactory.GetInstance():GetNode(iter_84_1)
	end
end

function StoryPlayer2:ClearFinishNode()
	local var_85_0 = {}

	for iter_85_0, iter_85_1 in ipairs(self.playingNodeList_) do
		if iter_85_1:GetStatus() == StoryPlayerConst.NODE_STATUS.FINISHED then
			StoryPlayNodeFactory.GetInstance():RetureNode(iter_85_1)
		else
			var_85_0[#var_85_0 + 1] = iter_85_1
		end
	end

	self.playingNodeList_ = var_85_0
end

function StoryPlayer2:ClearAllNode()
	for iter_86_0, iter_86_1 in pairs(self.textGroupItemDic_) do
		iter_86_1:Dispose()
	end

	self.textGroupItemDic_ = {}

	SetActive(self.textGroupNextGo_, false)
end

function StoryPlayer2:CreatePlayNode(arg_87_1)
	local var_87_0 = _G[arg_87_1.className].New(self)

	var_87_0:SetConfig(arg_87_1)

	return var_87_0
end

function StoryPlayer2:FinishResidentNodeByClassName(arg_88_1)
	for iter_88_0, iter_88_1 in ipairs(self.playingNodeList_) do
		if iter_88_1.config_.className == arg_88_1 and iter_88_1.isResident_ and iter_88_1:GetStatus() ~= StoryPlayerConst.NODE_STATUS.FINISHED then
			iter_88_1:Finish()
			StoryPlayNodeFactory.GetInstance():RetureNode(iter_88_1)
		end
	end
end

function StoryPlayer2:GetActorGo(arg_89_1, arg_89_2, arg_89_3)
	if arg_89_1 == StoryPlayerConst.ACTOR_TYPE.Sprite then
		return self:GetSpriteGo(arg_89_2, arg_89_3)
	elseif arg_89_1 == StoryPlayerConst.ACTOR_TYPE.Background then
		return self:GetBackgroundGo(arg_89_2, arg_89_3)
	elseif arg_89_1 == StoryPlayerConst.ACTOR_TYPE.ActorSprite then
		return self:GetActorSpriteGo(arg_89_2, arg_89_3)
	elseif arg_89_1 == StoryPlayerConst.ACTOR_TYPE.Tpose then
		return self:GetTposeGo(arg_89_2, arg_89_3)
	else
		Debug.LogError("undifined actor type: " .. arg_89_1)
	end
end

function StoryPlayer2:GetSpriteGo(arg_90_1, arg_90_2)
	if self.actors_[arg_90_1] == nil then
		local var_90_0 = Object.Instantiate(self.imageGo_, self.canvasGo_.transform)

		var_90_0.transform:SetSiblingIndex(1)

		var_90_0.name = arg_90_1

		local var_90_1 = var_90_0:GetComponent(typeof(Image))

		var_90_1.sprite = self:GetAsset(StoryPlayerConst.ACTOR_TYPE.Sprite, arg_90_2)

		var_90_1:SetNativeSize()

		var_90_0.transform.localPosition = Vector3.New(0, 100000, 0)
		self.actors_[arg_90_1] = var_90_0
	end

	return self.actors_[arg_90_1]
end

function StoryPlayer2:GetBackgroundGo(arg_91_1, arg_91_2)
	if self.bgs_[arg_91_1] == nil then
		local var_91_0 = Object.Instantiate(self.paintGo_)

		var_91_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas(arg_91_2)
		var_91_0.name = arg_91_1
		var_91_0.transform.parent = self.stage_.transform
		var_91_0.transform.localPosition = Vector3.New(0, 100, 0)
		self.bgs_[arg_91_1] = var_91_0
	end

	return self.bgs_[arg_91_1]
end

function StoryPlayer2:GetActorSpriteGo(arg_92_1, arg_92_2)
	if self.actors_[arg_92_1] == nil then
		local var_92_0 = Asset.Load(arg_92_2)

		if not isNil(var_92_0) then
			local var_92_1 = Object.Instantiate(var_92_0, self.canvasGo_.transform)

			var_92_1.transform:SetSiblingIndex(1)

			var_92_1.name = arg_92_1
			var_92_1.transform.localPosition = Vector3.New(0, 100000, 0)
			self.actors_[arg_92_1] = var_92_1

			if self.isInRecall_ then
				for iter_92_0, iter_92_1 in ipairs((var_92_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
					iter_92_1.color = self.hightColor1 or Color.New(0.82, 0.77, 0.62)
				end
			end
		end
	end

	return self.actors_[arg_92_1]
end

function StoryPlayer2:GetTposeGo(arg_93_1, arg_93_2)
	if self.actors_[arg_93_1] == nil then
		local var_93_0 = Asset.Load(arg_93_2)

		if not isNil(var_93_0) then
			local var_93_1 = Object.Instantiate(var_93_0, self.stage_.transform)

			var_93_1.name = arg_93_1
			var_93_1.transform.localPosition = Vector3.New(0, 100, 0)
			self.actors_[arg_93_1] = var_93_1

			local var_93_2 = var_93_1:GetComponentInChildren(typeof(CharacterEffect))

			var_93_2.enabled = true

			local var_93_3 = GameObjectTools.GetOrAddComponent(var_93_1, typeof(DynamicBoneHelper))

			if var_93_3 then
				var_93_3:EnableDynamicBone(false)
			end

			self:ShowWeapon(var_93_2.transform, false)

			self.var_[arg_93_1 .. "Animator"] = var_93_2.gameObject:GetComponent(typeof(UnityEngine.Animator))
			self.var_[arg_93_1 .. "Animator"].applyRootMotion = true
			self.var_[arg_93_1 .. "LipSync"] = var_93_2.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
		end
	end

	return self.actors_[arg_93_1]
end

function StoryPlayer2:GetAsset(arg_94_1, arg_94_2)
	self.assetDic_[arg_94_1] = self.assetDic_[arg_94_1] or {}

	if self.assetDic_[arg_94_1][arg_94_2] == nil then
		self.assetDic_[arg_94_1][arg_94_2] = self:CreateAssetData(arg_94_1, arg_94_2)
	end

	return self.assetDic_[arg_94_1][arg_94_2].asset
end

function StoryPlayer2:CreateAssetData(arg_95_1, arg_95_2)
	return {
		type = arg_95_1,
		assetPath = arg_95_2,
		asset = self:LoadAsset(arg_95_1, arg_95_2)
	}
end

function StoryPlayer2:LoadAsset(arg_96_1, arg_96_2)
	if arg_96_1 == StoryPlayerConst.ACTOR_TYPE.Sprite or StoryPlayerConst.ACTOR_TYPE.Background then
		return getSpriteWithoutAtlas(arg_96_2)
	end
end

function StoryPlayer2:GetBackgroundVideoController()
	local var_97_0 = false

	if not isNil(self.backgroundVideoViewGo_) then
		Object.Destroy(self.backgroundVideoViewGo_)

		self.backgroundVideoViewGo_ = nil
	end

	if isNil(self.backgroundVideoViewGo_) then
		self.backgroundVideoViewGo_ = Object.Instantiate(Asset.Load("Widget/System/Story/StoryBackgroundVideo"), self.stage_.transform)
		var_97_0 = true
	end

	SetActive(self.backgroundVideoViewGo_, true)

	self.criManaMovieController_ = self.backgroundVideoViewGo_:GetComponent("CriManaMovieController")

	if isNil(self.criManaMovieController_.player) then
		self.criManaMovieController_:PlayerManualInitialize()
	end

	return self.criManaMovieController_, var_97_0
end

function StoryPlayer2:RetureBackgroundVideoController()
	SetActive(self.backgroundVideoViewGo_, false)
end

function StoryPlayer2:GetTextGroupItem(arg_99_1)
	if not self.textGroupItemDic_[arg_99_1] then
		local var_99_0 = Object.Instantiate(self.textGroupTemplateGo_, self.textGroupContainerTrans_)

		SetActive(var_99_0, true)

		var_99_0.name = "textGroup_" .. arg_99_1
		self.textGroupItemDic_[arg_99_1] = StoryTextGroupItem.New(var_99_0, self)
	end

	SetActive(self.textGroupNextGo_, true)

	return self.textGroupItemDic_[arg_99_1]
end

function StoryPlayer2:DestoryTextGroup(arg_100_1)
	if self.textGroupItemDic_[arg_100_1] then
		self.textGroupItemDic_[arg_100_1]:Dispose()

		self.textGroupItemDic_[arg_100_1] = nil
	end

	local var_100_0 = false

	for iter_100_0, iter_100_1 in pairs(self.textGroupItemDic_) do
		if iter_100_1 ~= nil and self:FormatText(self:GetWordFromCfg(iter_100_1.config_.contentID).content) ~= "" then
			var_100_0 = true

			break
		end
	end

	if not var_100_0 then
		SetActive(self.textGroupNextGo_, false)
	end
end

function StoryPlayer2:InitVirtualCamera()
	self.virtualCameraContainerTrans_ = GameObject.Find("StoryStage/VirtualCameraContainer").transform
	self.commonVirtualCamera_ = self.virtualCameraContainerTrans_:Find("CommonVirtualCamera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))

	LuaForUtil.SetCinemachineVirtualCameraFOV(self.commonVirtualCamera_, manager.ui.mainCameraCom_.fieldOfView)
end

function StoryPlayer2:GetCurVirtualCamera()
	return self.commonVirtualCamera_
end

return StoryPlayer2
