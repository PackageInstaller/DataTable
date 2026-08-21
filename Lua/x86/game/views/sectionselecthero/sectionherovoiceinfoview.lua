local var_0_0 = class("SectionHeroVoiceInfoView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Show(true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:InitController()
	arg_3_0:InitCallback()
end

function var_0_0.InitController(arg_4_0)
	arg_4_0.statusController_ = arg_4_0.controllerEx_:GetController("status")
	arg_4_0.expandController_ = arg_4_0.controllerEx_:GetController("expand")
end

function var_0_0.InitCallback(arg_5_0)
	arg_5_0.heroTeamChangeHandler_ = handler(arg_5_0, arg_5_0.OnHeroTeamChange)
	arg_5_0.hideSubtitleHandler_ = handler(arg_5_0, arg_5_0.OnNeedHideSubtitle)
	arg_5_0.playMultiHeroVoiceStartHandler_ = handler(arg_5_0, arg_5_0.OnPlayMultiHeroVoiceStart)
	arg_5_0.playMultiHeroVoiceEndHandler_ = handler(arg_5_0, arg_5_0.OnPlayMultiHeroVoiceEnd)
end

function var_0_0.AddListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.expandBtn_, nil, function()
		arg_6_0:SwitchExpand()
	end)
end

function var_0_0.SetProxy(arg_8_0, arg_8_1)
	arg_8_0.sectionProxy_ = arg_8_1
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:RegistEventListener(SECTION_CHANGE_HERO_TEAM, arg_9_0.heroTeamChangeHandler_)
	arg_9_0:RegistEventListener(SECTION_MULTI_HERO_VOICE_START, arg_9_0.playMultiHeroVoiceStartHandler_)
	arg_9_0:RegistEventListener(SECTION_MULTI_HERO_VOICE_END, arg_9_0.playMultiHeroVoiceEndHandler_)
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:RemoveAllEventListener()
	arg_10_0:StopDelayHideTimer()
	arg_10_0:StopPlay()
end

function var_0_0.Refresh(arg_11_0)
	arg_11_0:ResetStatus()
	arg_11_0:RefreshStatus()
	arg_11_0:RefreshExpandUI()
end

function var_0_0.ResetStatus(arg_12_0)
	arg_12_0.isExpanding_ = false
	arg_12_0.needDisplay_ = false
end

function var_0_0.Show(arg_13_0, arg_13_1)
	SetActive(arg_13_0.gameObject_, arg_13_1)
end

function var_0_0.OnHeroTeamChange(arg_14_0)
	SectionSelectHeroVoiceManager.GetInstance():TryToPlayVoice(arg_14_0.sectionProxy_)
end

function var_0_0.OnPlayMultiHeroVoiceStart(arg_15_0, arg_15_1)
	arg_15_0.heroVoiceDescID_ = arg_15_1
	arg_15_0.needDisplay_ = true

	arg_15_0:RefreshVoiceUI()
end

function var_0_0.OnPlayMultiHeroVoiceEnd(arg_16_0)
	arg_16_0:StartDelayHideTimer()

	arg_16_0.needDisplay_ = false
end

function var_0_0.StartDelayHideTimer(arg_17_0)
	arg_17_0:StopDelayHideTimer()

	local var_17_0 = SectionSelectHeroConst.HERO_TEAM_DISPLAY_EXTRA_DELAY_TIME / 1000

	arg_17_0.hideDelayTimer_ = TimeTools.StartAfterSeconds(var_17_0, arg_17_0.hideSubtitleHandler_, {})
end

function var_0_0.StopDelayHideTimer(arg_18_0)
	if arg_18_0.hideDelayTimer_ then
		arg_18_0.hideDelayTimer_:Stop()

		arg_18_0.hideDelayTimer_ = nil
	end
end

function var_0_0.OnNeedHideSubtitle(arg_19_0)
	arg_19_0.needDisplay_ = false

	arg_19_0:RefreshStatus()
end

function var_0_0.StopPlay(arg_20_0)
	arg_20_0:StopDelayHideTimer()
	SectionSelectHeroVoiceManager.GetInstance():StopVoice()
end

function var_0_0.RefreshVoiceUI(arg_21_0)
	arg_21_0:RefreshStatus()
	arg_21_0:RefreshProtagonistUI()
	arg_21_0:RefreshSubTitle()
	arg_21_0:RefreshExpandUI()
end

function var_0_0.RefreshStatus(arg_22_0)
	arg_22_0.statusController_:SetSelectedState(arg_22_0.needDisplay_ and "playing" or "stop")
end

function var_0_0.RefreshProtagonistUI(arg_23_0)
	local var_23_0 = HeroVoiceDescCfg[arg_23_0.heroVoiceDescID_].chara_id

	arg_23_0.protagonistIcon_.sprite = getSpriteViaConfig("StoryHeadIcon", "story_" .. var_23_0)
	arg_23_0.protagnistName_.text = HeroTools.GetHeroFullName(var_23_0)
end

function var_0_0.RefreshSubTitle(arg_24_0)
	arg_24_0.subTitle_.text = HeroVoiceDescCfg[arg_24_0.heroVoiceDescID_].content
end

function var_0_0.RefreshExpandUI(arg_25_0)
	arg_25_0.expandController_:SetSelectedState(arg_25_0.isExpanding_ and "on" or "off")
end

function var_0_0.SwitchExpand(arg_26_0)
	arg_26_0.isExpanding_ = not arg_26_0.isExpanding_

	arg_26_0:RefreshExpandUI()
end

return var_0_0
