local var_0_0 = class("HeroFileVoicePage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.curHeroID_ = 0
	arg_3_0.playingVoiceID_ = 0
	arg_3_0.openItem = 0
	arg_3_0.itemList_ = {}
	arg_3_0.subtitleBubble = MainHomeView_SubtitleBubble.New(arg_3_0.dialogBoxGo_)
end

function var_0_0.CameraEnter(arg_4_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		3
	})
end

function var_0_0.Show(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0:UpdateView(arg_5_1, arg_5_2, arg_5_4)
	arg_5_0.subtitleBubble:SetVisible(false)
	SetActive(arg_5_0.gameObject_, true)
end

function var_0_0.Hide(arg_6_0)
	arg_6_0:StopVoice()
	SetActive(arg_6_0.gameObject_, false)
end

function var_0_0.PlayVoice(arg_7_0, arg_7_1)
	arg_7_0:StopVoice()

	arg_7_0.playingVoiceID_ = arg_7_1

	arg_7_0:RefreshDialog(arg_7_1)
	arg_7_0:PlayVoiceByDelayTime(arg_7_1)
	arg_7_0:StartItemPlay()
	arg_7_0:SendPlayVoiceMessage(arg_7_1)
end

function var_0_0.GetOriginalSkin(arg_8_0)
	if arg_8_0.formID_ then
		return SkinCfg[arg_8_0.formID_].hero
	else
		return arg_8_0.curHeroID_
	end
end

function var_0_0.RefreshDialog(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:GetHeroIdForPlayVoice(arg_9_1)
	local var_9_1 = HeroVoiceDescCfg.Get(var_9_0, arg_9_1)

	arg_9_0.subtitleBubble:SetVisible(true)
	arg_9_0.subtitleBubble:SetContent(var_9_1)
	arg_9_0.dialogAni_:Play("talkBubble", 0, 0)
	arg_9_0.dialogAni_:Update(Time.deltaTime)
end

function var_0_0.PlayVoiceByDelayTime(arg_10_0, arg_10_1)
	arg_10_0:StopDelayTimer()

	arg_10_0.delayPlayTimer_ = Timer.New(function()
		if manager.audio:IsStoppedOfVoice() then
			arg_10_0:StopDelayTimer()

			local var_11_0 = HeroVoiceCfg[arg_10_1]
			local var_11_1 = arg_10_0:GetHeroIdForPlayVoice(arg_10_1)

			HeroTools.PlayVoice(var_11_1, var_11_0.file, var_11_0.type)

			local var_11_2 = arg_10_0:GetTalkSeconds(var_11_1, arg_10_1)

			arg_10_0.timer_ = TimeTools.StartAfterSeconds(var_11_2, function()
				arg_10_0:StopVoice()
			end, {})
		end
	end, 0.033, -1)

	arg_10_0.delayPlayTimer_:Start()
end

function var_0_0.GetHeroIdForPlayVoice(arg_13_0, arg_13_1)
	local var_13_0 = nullable(HeroVoiceCfg, arg_13_1, "use_skin_id") or 0

	if var_13_0 ~= 0 then
		return var_13_0
	else
		return arg_13_0:GetOriginalSkin()
	end
end

function var_0_0.GetTalkSeconds(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = HeroTools.GetTalkLength(arg_14_1, HeroVoiceCfg[arg_14_2].file, HeroVoiceCfg[arg_14_2].type)

	return math.max(var_14_0, 0.017) / 1000
end

function var_0_0.StartItemPlay(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.itemList_) do
		if iter_15_1 then
			iter_15_1:StartPlay(arg_15_0.playingVoiceID_)
		end
	end
end

function var_0_0.StopVoice(arg_16_0)
	arg_16_0.subtitleBubble:SetVisible(false)
	arg_16_0:StopDelayTimer()
	manager.audio:StopVoiceImmediate()

	if arg_16_0.timer_ then
		arg_16_0.timer_:Stop()

		arg_16_0.timer_ = nil
	end

	if arg_16_0.playingVoiceID_ ~= 0 then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0.itemList_) do
			if iter_16_1 then
				iter_16_1:StopPlay()
			end
		end

		arg_16_0.playingVoiceID_ = 0
	end
end

function var_0_0.StopDelayTimer(arg_17_0)
	if arg_17_0.delayPlayTimer_ then
		arg_17_0.delayPlayTimer_:Stop()

		arg_17_0.delayPlayTimer_ = nil
	end
end

function var_0_0.ForceUpdate(arg_18_0)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_0.content_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_0.content_)
end

function var_0_0.UpdateView(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_0.content_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_0.content_)

	arg_19_0.curHeroID_ = arg_19_2

	arg_19_0.subtitleBubble:SetBgStyleByHero(arg_19_2)

	if arg_19_3 then
		arg_19_0.formID_ = arg_19_3
	else
		arg_19_0.formID_ = nil
	end

	arg_19_0:InitItemList()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_0.content_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_0.content_)
end

local var_0_1 = 8

function var_0_0.InitItemList(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(HeroVoiceTagCfg.all) do
		local var_20_0 = arg_20_0.itemList_[iter_20_0]

		if var_20_0 == nil then
			local var_20_1 = Object.Instantiate(arg_20_0.contentItem_, arg_20_0.content_)

			var_20_0 = HeroFileVoiceContentItem.New(var_20_1)
			arg_20_0.itemList_[iter_20_0] = var_20_0
		end

		var_20_0:SetData(arg_20_0.curHeroID_, iter_20_1, arg_20_0.formID_, function(arg_21_0)
			PlayerAction.CheckHeroVoice(arg_20_0.curHeroID_, function()
				if arg_20_0.playingVoiceID_ == arg_21_0 then
					arg_20_0:StopVoice()
				else
					arg_20_0:PlayVoice(arg_21_0)
				end
			end)
		end, function()
			arg_20_0:ForceUpdate()
		end)
		var_20_0:ChangeShow(false)
		var_20_0:SetBgState(iter_20_1 == var_0_1 and "oath" or "normal")
		var_20_0:StartPlay(arg_20_0.playingVoiceID_)
		var_20_0:SetIsShow(not var_20_0:IsEmpty())
	end
end

function var_0_0.Dispose(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.itemList_) do
		iter_24_1:Dispose()
	end

	arg_24_0.itemList_ = {}

	arg_24_0.subtitleBubble:Dispose()
	var_0_0.super.Dispose(arg_24_0)
end

function var_0_0.SendPlayVoiceMessage(arg_25_0, arg_25_1)
	SDKTools.SendMessageToSDK("hero_sound", {
		hero_id = arg_25_0.curHeroID_,
		sound_id = arg_25_1
	})
end

return var_0_0
