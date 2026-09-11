local HeroFileArchivePage = class("HeroFileArchivePage", ReduxView)

function HeroFileArchivePage:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroFileArchivePage:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroFileArchivePage:InitUI()
	self:BindCfgUI()

	self.curHeroID_ = 0
	self.curRecordID_ = 0
	self.linkTabItems_ = {}
	self.curTabIndex_ = 0
	self.curTabLockState_ = {}
	self.playingVoiceID_ = nil
	self.lockController = self.contentController_:GetController("lock")
	self.jumpToOathController = self.contentController_:GetController("goBtn")
	self.playStateController = self.playStatusController_:GetController("isPlaying")
	self.playBtnStyleController = self.playStatusController_:GetController("category")
	self.contentSizeFitter_ = self.detailTrs_:GetComponent("ContentSizeFitter")
	self.subtitleBubble = MainHomeView_SubtitleBubble.New(self.dialogBoxGo_)
end

function HeroFileArchivePage:AddUIListener()
	self:AddBtnListener(self.playBtn_, nil, function()
		if self.playingVoiceID_ then
			self:StopVoice()
		elseif not self.linkTabItems_[self.curTabIndex_].lock then
			self:PlayVoice((self:GetVoiceID(self.allTabInfo[self.curTabIndex_])))
		end
	end)
	self:AddBtnListener(self.oathJumpBtn_, nil, function()
		JumpTools.OpenPageByJump("/oathDetailsView", {
			selectModeState = "task",
			heroID = self.curHeroID_
		}, ViewConst.SYSTEM_ID.OATH_SYSTEM)
	end)
end

function HeroFileArchivePage:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		3
	})
end

function HeroFileArchivePage:SwitchTab(arg_8_1, arg_8_2)
	if arg_8_1 == self.curTabIndex_ then
		return
	end

	if self.linkTabItems_[self.curTabIndex_] then
		self.linkTabItems_[self.curTabIndex_]:SetSelectState(false)
	end

	self.curTabIndex_ = arg_8_1

	self.linkTabItems_[arg_8_1]:SetSelectState(true)
	self.detailTrs_:SetAnchoredPositionY(0)

	self.contentSizeFitter_.verticalFit = ContentSizeFitter.FitMode.Unconstrained
	self.contentSizeTimer_ = Timer.New(function()
		self.contentSizeFitter_.verticalFit = ContentSizeFitter.FitMode.PreferredSize

		if self.contentSizeTimer_ then
			self.contentSizeTimer_:Stop()

			self.contentSizeTimer_ = nil
		end
	end, 0.2, 1)

	self.contentSizeTimer_:Start()

	if self.playingVoiceID_ then
		self:StopVoice()
	end

	self.titleText_.text = self:GetTitle(arg_8_2)

	if arg_8_2.type == HeroFileArchivePage.TabType.HeartLink then
		self:RefreshHeartLinkContent(arg_8_2)
	else
		self:RefreshOathContent(arg_8_2)
	end

	self:OnReadContent(arg_8_2)
end

function HeroFileArchivePage:OnReadContent(arg_10_1)
	local var_10_0 = self:GetRedPoint(arg_10_1)

	if not arg_10_1.lock and var_10_0 then
		manager.redPoint:setTip(var_10_0, 0)
	end
end

function HeroFileArchivePage:GetCurPlayingVoice()
	return self.playingVoiceID_
end

function HeroFileArchivePage:UpdateVoicePlayStatus()
	if self:GetCurPlayingVoice() then
		self.playStateController:SetSelectedState("true")
	else
		self.playStateController:SetSelectedState("false")
	end
end

function HeroFileArchivePage:RefreshHeartLinkContent(arg_13_1)
	self.playBtnStyleController:SetSelectedState("heartChain")

	self.voiceTitle_.text = GetTipsF("HERO_RECORD_HEART_CHAIN_TIPS1", arg_13_1.value)

	if arg_13_1.lock then
		self.lockController:SetSelectedState("lock")
		self.jumpToOathController:SetSelectedState("off")

		self.lockTipsText_.text = GetTipsF("HERO_HEART_CHAIN_PLOT_UNLOCK_LOVE", arg_13_1.value)
	else
		self.lockController:SetSelectedState("unlock")

		self.detailText_.text = HeroRecordCfg[self.curRecordID_]["heart_chain" .. arg_13_1.value]

		if not ArchiveData:IsHeartRead(self.curRecordID_, arg_13_1.value) then
			HeroAction.ReadHeartLink(self.curRecordID_, arg_13_1.value)
		end
	end
end

function HeroFileArchivePage:RefreshOathContent(arg_14_1)
	self.voiceTitle_.text = GetTipsF("WEDDING_RECORD_TIPS1", arg_14_1.value)

	self.playBtnStyleController:SetSelectedState("vow")

	if arg_14_1.lock then
		self.lockController:SetSelectedState("lock")
		self.jumpToOathController:SetSelectedState("on")

		self.lockTipsText_.text = nullable(ConditionCfg, nullable(WeddingCfg, self.curHeroID_, string.format("record%d_condition", arg_14_1.value)) or 0, "desc") or ""
	else
		self.lockController:SetSelectedState("unlock")

		self.detailText_.text = nullable(WeddingCfg, self.curHeroID_, "wedding_record" .. arg_14_1.value)
	end
end

function HeroFileArchivePage:Show(arg_15_1, arg_15_2)
	self:UpdateView(arg_15_1, arg_15_2)
	self.subtitleBubble:SetVisible(false)
	SetActive(self.gameObject_, true)
end

function HeroFileArchivePage:Hide()
	for iter_16_0 = 1, #self.linkTabItems_ do
		manager.redPoint:unbindUIandKey(self.linkTabItems_[iter_16_0].transform_)
	end

	self:StopVoice()

	if self.contentSizeTimer_ then
		self.contentSizeTimer_:Stop()

		self.contentSizeTimer_ = nil
	end

	SetActive(self.gameObject_, false)
end

function HeroFileArchivePage:PlayVoice(arg_17_1)
	self:StopVoice()

	self.playingVoiceID_ = arg_17_1

	self:RefreshDialog(arg_17_1)
	self:PlayVoiceByDelayTime(arg_17_1)
	SDKTools.SendMessageToSDK("hero_sound", {
		hero_id = self.curHeroID_,
		sound_id = arg_17_1
	})
end

function HeroFileArchivePage:PlayVoiceByDelayTime(arg_18_1)
	self:StopDelayTimer()

	self.delayPlayTimer_ = Timer.New(function()
		if manager.audio:IsStoppedOfVoice() then
			self:StopDelayTimer()

			local var_19_0 = self:GetHeroIdForPlayVoice(arg_18_1)

			HeroTools.PlayVoice(var_19_0, HeroVoiceCfg[arg_18_1].file, HeroVoiceCfg[arg_18_1].type)

			self.timer_ = TimeTools.StartAfterSeconds(self:GetTalkSeconds(var_19_0, arg_18_1), function()
				self:StopVoice()
			end, {})
		end
	end, 0.033, -1)

	self.delayPlayTimer_:Start()
	self:UpdateVoicePlayStatus()
end

function HeroFileArchivePage:GetHeroIdForPlayVoice(arg_21_1)
	local var_21_0 = nullable(HeroVoiceCfg, arg_21_1, "use_skin_id") or 0

	if var_21_0 ~= 0 then
		return var_21_0
	else
		return self:GetOriginalSkin()
	end
end

function HeroFileArchivePage:GetOriginalSkin()
	if self.formID_ then
		return SkinCfg[self.formID_].hero
	else
		return self.curHeroID_
	end
end

function HeroFileArchivePage:RefreshDialog(arg_23_1)
	self.subtitleBubble:SetVisible(true)
	self.subtitleBubble:SetContent((HeroVoiceDescCfg.Get(self:GetHeroIdForPlayVoice(arg_23_1), arg_23_1)))
end

function HeroFileArchivePage:GetTalkSeconds(arg_24_1, arg_24_2)
	return math.max(HeroTools.GetTalkLength(arg_24_1, HeroVoiceCfg[arg_24_2].file, HeroVoiceCfg[arg_24_2].type), 0.017) / 1000
end

function HeroFileArchivePage:StopDelayTimer()
	if self.delayPlayTimer_ then
		self.delayPlayTimer_:Stop()

		self.delayPlayTimer_ = nil
	end
end

local function var_0_1(arg_26_0, arg_26_1)
	for iter_26_0 = arg_26_0.linktabTrs_.childCount + 1, arg_26_1 do
		local var_26_0 = Object.Instantiate(arg_26_0.linktabitemGo_, arg_26_0.linktabTrs_)
	end

	for iter_26_1 = 1, arg_26_0.linktabTrs_.childCount do
		arg_26_0.linkTabItems_[iter_26_1] = arg_26_0.linkTabItems_[iter_26_1] or HeroFileArchiveTabItem.New(arg_26_0.linktabTrs_:GetChild(iter_26_1 - 1).gameObject, iter_26_1)

		arg_26_0.linkTabItems_[iter_26_1]:SetIsShow(iter_26_1 <= arg_26_1)
	end
end

HeroFileArchivePage.TabType = {
	Oath = 2,
	HeartLink = 1
}

function HeroFileArchivePage:UpdateView(arg_27_1, arg_27_2)
	self.subtitleBubble:SetBgStyleByHero(arg_27_2)

	self.curHeroID_ = arg_27_2
	self.curRecordID_ = arg_27_1

	local var_27_0 = {}

	for iter_27_0 = 1, HeroConst.HERO_HEARTLINK_STORY_MAX_COUNT do
		table.insert(var_27_0, {
			type = HeroFileArchivePage.TabType.HeartLink,
			value = iter_27_0,
			lock = not IsConditionAchieved(GameSetting.heart_chain_unlock_condition.value[iter_27_0], {
				heroId = arg_27_1
			})
		})
	end

	if OathTools.IsOath(arg_27_2) then
		if WeddingCfg[arg_27_2] then
			for iter_27_1 = 1, HeroConst.HERO_OATH_STORY_MAX_COUNT do
				local var_27_1 = nullable(WeddingCfg[arg_27_2], string.format("record%d_condition", iter_27_1)) or 0

				table.insert(var_27_0, {
					type = HeroFileArchivePage.TabType.Oath,
					value = iter_27_1,
					lock = not IsConditionAchieved(var_27_1)
				})
			end
		end
	end

	var_0_1(self, #var_27_0)

	local function var_27_2(arg_28_0, arg_28_1)
		self:SwitchTab(arg_28_1, var_27_0[arg_28_1])
	end

	for iter_27_2, iter_27_3 in ipairs(var_27_0) do
		local var_27_3 = self.linkTabItems_[iter_27_2]

		self.linkTabItems_[iter_27_2]:SetLockState(iter_27_3.lock)
		var_27_3:SetSelectState(false)
		var_27_3:SetOnClick(var_27_2)
		var_27_3:SetBgState(iter_27_3.type == HeroFileArchivePage.TabType.HeartLink and "normal" or "oath")
		var_27_3:SetTitle(self:GetTitle(iter_27_3))
		self:BindRedPoint(var_27_3, iter_27_3)
	end

	self.allTabInfo = var_27_0
	self.curTabIndex_ = 0

	self:SwitchTab(1, var_27_0[1])
end

function HeroFileArchivePage:GetTitle(arg_29_1)
	if arg_29_1.type == HeroFileArchivePage.TabType.HeartLink then
		return GetTipsF("HERO_RECORD_HEART_CHAIN", arg_29_1.value)
	else
		return GetTips(string.format("WEDDING_CONTENT_RECORD%d_TITLE", arg_29_1.value))
	end
end

function HeroFileArchivePage:GetVoiceID(arg_30_1)
	if arg_30_1.type == HeroFileArchivePage.TabType.HeartLink then
		return HeroVoiceCfg.get_id_list_by_file["trust" .. arg_30_1.value][1]
	else
		return nullable(WeddingCfg, self.curHeroID_, "wedding_record_voice" .. arg_30_1.value)
	end
end

function HeroFileArchivePage:GetRedPoint(arg_31_1)
	if arg_31_1.type == HeroFileArchivePage.TabType.HeartLink then
		return RedPointConst.HERO_HEARTLINK_ID .. self.curRecordID_ .. "_" .. arg_31_1.value
	else
		return nil
	end
end

function HeroFileArchivePage:BindRedPoint(arg_32_1, arg_32_2)
	local var_32_0 = self:GetRedPoint(arg_32_2)

	if var_32_0 then
		manager.redPoint:bindUIandKey(arg_32_1.transform_, var_32_0)
	else
		manager.redPoint:unbindUIandKey(arg_32_1.transform_)
	end
end

function HeroFileArchivePage:StopVoice()
	self.playingVoiceID_ = nil

	self:StopDelayTimer()
	self:UpdateVoicePlayStatus()
	self.subtitleBubble:SetVisible(false)
	manager.audio:StopVoiceImmediate()

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function HeroFileArchivePage:Dispose()
	for iter_34_0 = 1, #self.linkTabItems_ do
		self.linkTabItems_[iter_34_0]:Dispose()
	end

	self.subtitleBubble:Dispose()
	HeroFileArchivePage.super.Dispose(self)
end

return HeroFileArchivePage
