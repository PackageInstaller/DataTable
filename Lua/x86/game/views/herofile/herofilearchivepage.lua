local var_0_0 = class("HeroFileArchivePage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.curHeroID_ = 0
	arg_3_0.curRecordID_ = 0
	arg_3_0.linkTabItems_ = {}
	arg_3_0.curTabIndex_ = 0
	arg_3_0.curTabLockState_ = {}
	arg_3_0.playingVoiceID_ = nil
	arg_3_0.lockController = arg_3_0.contentController_:GetController("lock")
	arg_3_0.jumpToOathController = arg_3_0.contentController_:GetController("goBtn")
	arg_3_0.playStateController = arg_3_0.playStatusController_:GetController("isPlaying")
	arg_3_0.playBtnStyleController = arg_3_0.playStatusController_:GetController("category")
	arg_3_0.contentSizeFitter_ = arg_3_0.detailTrs_:GetComponent("ContentSizeFitter")
	arg_3_0.subtitleBubble = MainHomeView_SubtitleBubble.New(arg_3_0.dialogBoxGo_)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.playBtn_, nil, function()
		if arg_4_0.playingVoiceID_ then
			arg_4_0:StopVoice()
		else
			local var_5_0 = arg_4_0.curTabIndex_

			if not arg_4_0.linkTabItems_[var_5_0].lock then
				local var_5_1 = arg_4_0.allTabInfo[var_5_0]
				local var_5_2 = arg_4_0:GetVoiceID(var_5_1)

				arg_4_0:PlayVoice(var_5_2)
			end
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.oathJumpBtn_, nil, function()
		JumpTools.OpenPageByJump("/oathDetailsView", {
			selectModeState = "task",
			heroID = arg_4_0.curHeroID_
		}, ViewConst.SYSTEM_ID.OATH_SYSTEM)
	end)
end

function var_0_0.CameraEnter(arg_7_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		3
	})
end

function var_0_0.SwitchTab(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == arg_8_0.curTabIndex_ then
		return
	end

	if arg_8_0.linkTabItems_[arg_8_0.curTabIndex_] then
		arg_8_0.linkTabItems_[arg_8_0.curTabIndex_]:SetSelectState(false)
	end

	arg_8_0.curTabIndex_ = arg_8_1

	arg_8_0.linkTabItems_[arg_8_1]:SetSelectState(true)
	arg_8_0.detailTrs_:SetAnchoredPositionY(0)

	arg_8_0.contentSizeFitter_.verticalFit = ContentSizeFitter.FitMode.Unconstrained
	arg_8_0.contentSizeTimer_ = Timer.New(function()
		arg_8_0.contentSizeFitter_.verticalFit = ContentSizeFitter.FitMode.PreferredSize

		if arg_8_0.contentSizeTimer_ then
			arg_8_0.contentSizeTimer_:Stop()

			arg_8_0.contentSizeTimer_ = nil
		end
	end, 0.2, 1)

	arg_8_0.contentSizeTimer_:Start()

	if arg_8_0.playingVoiceID_ then
		arg_8_0:StopVoice()
	end

	arg_8_0.titleText_.text = arg_8_0:GetTitle(arg_8_2)

	if arg_8_2.type == var_0_0.TabType.HeartLink then
		arg_8_0:RefreshHeartLinkContent(arg_8_2)
	else
		arg_8_0:RefreshOathContent(arg_8_2)
	end

	arg_8_0:OnReadContent(arg_8_2)
end

function var_0_0.OnReadContent(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.lock
	local var_10_1 = arg_10_0:GetRedPoint(arg_10_1)

	if not var_10_0 and var_10_1 then
		manager.redPoint:setTip(var_10_1, 0)
	end
end

function var_0_0.GetCurPlayingVoice(arg_11_0)
	return arg_11_0.playingVoiceID_
end

function var_0_0.UpdateVoicePlayStatus(arg_12_0)
	if arg_12_0:GetCurPlayingVoice() then
		arg_12_0.playStateController:SetSelectedState("true")
	else
		arg_12_0.playStateController:SetSelectedState("false")
	end
end

function var_0_0.RefreshHeartLinkContent(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.lock
	local var_13_1 = arg_13_1.value

	arg_13_0.playBtnStyleController:SetSelectedState("heartChain")

	arg_13_0.voiceTitle_.text = GetTipsF("HERO_RECORD_HEART_CHAIN_TIPS1", var_13_1)

	if var_13_0 then
		arg_13_0.lockController:SetSelectedState("lock")
		arg_13_0.jumpToOathController:SetSelectedState("off")

		arg_13_0.lockTipsText_.text = GetTipsF("HERO_HEART_CHAIN_PLOT_UNLOCK_LOVE", var_13_1)
	else
		arg_13_0.lockController:SetSelectedState("unlock")

		local var_13_2 = HeroRecordCfg[arg_13_0.curRecordID_]

		arg_13_0.detailText_.text = var_13_2["heart_chain" .. var_13_1]

		if not ArchiveData:IsHeartRead(arg_13_0.curRecordID_, var_13_1) then
			HeroAction.ReadHeartLink(arg_13_0.curRecordID_, var_13_1)
		end
	end
end

function var_0_0.RefreshOathContent(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.lock
	local var_14_1 = arg_14_1.value
	local var_14_2 = arg_14_0.curHeroID_
	local var_14_3 = arg_14_0.curRecordID_

	arg_14_0.voiceTitle_.text = GetTipsF("WEDDING_RECORD_TIPS1", var_14_1)

	arg_14_0.playBtnStyleController:SetSelectedState("vow")

	if var_14_0 then
		arg_14_0.lockController:SetSelectedState("lock")
		arg_14_0.jumpToOathController:SetSelectedState("on")

		local var_14_4 = nullable(WeddingCfg, var_14_2, string.format("record%d_condition", var_14_1)) or 0

		arg_14_0.lockTipsText_.text = nullable(ConditionCfg, var_14_4, "desc") or ""
	else
		arg_14_0.lockController:SetSelectedState("unlock")

		arg_14_0.detailText_.text = nullable(WeddingCfg, var_14_2, "wedding_record" .. var_14_1)
	end
end

function var_0_0.Show(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:UpdateView(arg_15_1, arg_15_2)
	arg_15_0.subtitleBubble:SetVisible(false)
	SetActive(arg_15_0.gameObject_, true)
end

function var_0_0.Hide(arg_16_0)
	for iter_16_0 = 1, #arg_16_0.linkTabItems_ do
		manager.redPoint:unbindUIandKey(arg_16_0.linkTabItems_[iter_16_0].transform_)
	end

	arg_16_0:StopVoice()

	if arg_16_0.contentSizeTimer_ then
		arg_16_0.contentSizeTimer_:Stop()

		arg_16_0.contentSizeTimer_ = nil
	end

	SetActive(arg_16_0.gameObject_, false)
end

function var_0_0.PlayVoice(arg_17_0, arg_17_1)
	arg_17_0:StopVoice()

	arg_17_0.playingVoiceID_ = arg_17_1

	arg_17_0:RefreshDialog(arg_17_1)
	arg_17_0:PlayVoiceByDelayTime(arg_17_1)
	SDKTools.SendMessageToSDK("hero_sound", {
		hero_id = arg_17_0.curHeroID_,
		sound_id = arg_17_1
	})
end

function var_0_0.PlayVoiceByDelayTime(arg_18_0, arg_18_1)
	arg_18_0:StopDelayTimer()

	arg_18_0.delayPlayTimer_ = Timer.New(function()
		if manager.audio:IsStoppedOfVoice() then
			arg_18_0:StopDelayTimer()

			local var_19_0 = HeroVoiceCfg[arg_18_1]
			local var_19_1 = arg_18_0:GetHeroIdForPlayVoice(arg_18_1)

			HeroTools.PlayVoice(var_19_1, var_19_0.file, var_19_0.type)

			local var_19_2 = arg_18_0:GetTalkSeconds(var_19_1, arg_18_1)

			arg_18_0.timer_ = TimeTools.StartAfterSeconds(var_19_2, function()
				arg_18_0:StopVoice()
			end, {})
		end
	end, 0.033, -1)

	arg_18_0.delayPlayTimer_:Start()
	arg_18_0:UpdateVoicePlayStatus()
end

function var_0_0.GetHeroIdForPlayVoice(arg_21_0, arg_21_1)
	local var_21_0 = nullable(HeroVoiceCfg, arg_21_1, "use_skin_id") or 0

	if var_21_0 ~= 0 then
		return var_21_0
	else
		return arg_21_0:GetOriginalSkin()
	end
end

function var_0_0.GetOriginalSkin(arg_22_0)
	if arg_22_0.formID_ then
		return SkinCfg[arg_22_0.formID_].hero
	else
		return arg_22_0.curHeroID_
	end
end

function var_0_0.RefreshDialog(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:GetHeroIdForPlayVoice(arg_23_1)
	local var_23_1 = HeroVoiceDescCfg.Get(var_23_0, arg_23_1)

	arg_23_0.subtitleBubble:SetVisible(true)
	arg_23_0.subtitleBubble:SetContent(var_23_1)
end

function var_0_0.GetTalkSeconds(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = HeroVoiceCfg[arg_24_2]
	local var_24_1 = HeroTools.GetTalkLength(arg_24_1, var_24_0.file, var_24_0.type)

	return math.max(var_24_1, 0.017) / 1000
end

function var_0_0.StopDelayTimer(arg_25_0)
	if arg_25_0.delayPlayTimer_ then
		arg_25_0.delayPlayTimer_:Stop()

		arg_25_0.delayPlayTimer_ = nil
	end
end

local function var_0_1(arg_26_0, arg_26_1)
	for iter_26_0 = arg_26_0.linktabTrs_.childCount + 1, arg_26_1 do
		local var_26_0 = Object.Instantiate(arg_26_0.linktabitemGo_, arg_26_0.linktabTrs_)
	end

	local var_26_1 = arg_26_0.linktabTrs_.childCount

	for iter_26_1 = 1, var_26_1 do
		local var_26_2 = arg_26_0.linktabTrs_:GetChild(iter_26_1 - 1).gameObject

		arg_26_0.linkTabItems_[iter_26_1] = arg_26_0.linkTabItems_[iter_26_1] or HeroFileArchiveTabItem.New(var_26_2, iter_26_1)

		arg_26_0.linkTabItems_[iter_26_1]:SetIsShow(iter_26_1 <= arg_26_1)
	end
end

var_0_0.TabType = {
	Oath = 2,
	HeartLink = 1
}

function var_0_0.UpdateView(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0.subtitleBubble:SetBgStyleByHero(arg_27_2)

	arg_27_0.curHeroID_ = arg_27_2
	arg_27_0.curRecordID_ = arg_27_1

	local var_27_0 = {}

	for iter_27_0 = 1, HeroConst.HERO_HEARTLINK_STORY_MAX_COUNT do
		local var_27_1 = GameSetting.heart_chain_unlock_condition.value[iter_27_0]
		local var_27_2 = not IsConditionAchieved(var_27_1, {
			heroId = arg_27_1
		})

		table.insert(var_27_0, {
			type = var_0_0.TabType.HeartLink,
			value = iter_27_0,
			lock = var_27_2
		})
	end

	if OathTools.IsOath(arg_27_2) then
		local var_27_3 = WeddingCfg[arg_27_2]

		if var_27_3 then
			for iter_27_1 = 1, HeroConst.HERO_OATH_STORY_MAX_COUNT do
				local var_27_4 = nullable(var_27_3, string.format("record%d_condition", iter_27_1)) or 0
				local var_27_5 = not IsConditionAchieved(var_27_4)

				table.insert(var_27_0, {
					type = var_0_0.TabType.Oath,
					value = iter_27_1,
					lock = var_27_5
				})
			end
		end
	end

	var_0_1(arg_27_0, #var_27_0)

	local function var_27_6(arg_28_0, arg_28_1)
		local var_28_0 = var_27_0[arg_28_1]

		arg_27_0:SwitchTab(arg_28_1, var_28_0)
	end

	for iter_27_2, iter_27_3 in ipairs(var_27_0) do
		local var_27_7 = arg_27_0.linkTabItems_[iter_27_2]

		var_27_7:SetLockState(iter_27_3.lock)
		var_27_7:SetSelectState(false)
		var_27_7:SetOnClick(var_27_6)
		var_27_7:SetBgState(iter_27_3.type == var_0_0.TabType.HeartLink and "normal" or "oath")
		var_27_7:SetTitle(arg_27_0:GetTitle(iter_27_3))
		arg_27_0:BindRedPoint(var_27_7, iter_27_3)
	end

	arg_27_0.allTabInfo = var_27_0
	arg_27_0.curTabIndex_ = 0

	arg_27_0:SwitchTab(1, var_27_0[1])
end

function var_0_0.GetTitle(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1.type
	local var_29_1 = arg_29_1.value

	if arg_29_1.type == var_0_0.TabType.HeartLink then
		return GetTipsF("HERO_RECORD_HEART_CHAIN", var_29_1)
	else
		return GetTips(string.format("WEDDING_CONTENT_RECORD%d_TITLE", var_29_1))
	end
end

function var_0_0.GetVoiceID(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1.type
	local var_30_1 = arg_30_1.value

	if arg_30_1.type == var_0_0.TabType.HeartLink then
		return HeroVoiceCfg.get_id_list_by_file["trust" .. var_30_1][1]
	else
		return nullable(WeddingCfg, arg_30_0.curHeroID_, "wedding_record_voice" .. var_30_1)
	end
end

function var_0_0.GetRedPoint(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_1.type
	local var_31_1 = arg_31_1.value

	if arg_31_1.type == var_0_0.TabType.HeartLink then
		return RedPointConst.HERO_HEARTLINK_ID .. arg_31_0.curRecordID_ .. "_" .. var_31_1
	else
		return nil
	end
end

function var_0_0.BindRedPoint(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0:GetRedPoint(arg_32_2)

	if var_32_0 then
		manager.redPoint:bindUIandKey(arg_32_1.transform_, var_32_0)
	else
		manager.redPoint:unbindUIandKey(arg_32_1.transform_)
	end
end

function var_0_0.StopVoice(arg_33_0)
	arg_33_0.playingVoiceID_ = nil

	arg_33_0:StopDelayTimer()
	arg_33_0:UpdateVoicePlayStatus()
	arg_33_0.subtitleBubble:SetVisible(false)
	manager.audio:StopVoiceImmediate()

	if arg_33_0.timer_ then
		arg_33_0.timer_:Stop()

		arg_33_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_34_0)
	for iter_34_0 = 1, #arg_34_0.linkTabItems_ do
		arg_34_0.linkTabItems_[iter_34_0]:Dispose()
	end

	arg_34_0.subtitleBubble:Dispose()
	var_0_0.super.Dispose(arg_34_0)
end

return var_0_0
