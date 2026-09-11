local SectionHeroVoiceInfoView = class("SectionHeroVoiceInfoView", ReduxView)

function SectionHeroVoiceInfoView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Show(true)
	self:Init()
end

function SectionHeroVoiceInfoView:Init()
	self:InitUI()
	self:AddListener()
end

function SectionHeroVoiceInfoView:InitUI()
	self:BindCfgUI()
	self:InitController()
	self:InitCallback()
end

function SectionHeroVoiceInfoView:InitController()
	self.statusController_ = self.controllerEx_:GetController("status")
	self.expandController_ = self.controllerEx_:GetController("expand")
end

function SectionHeroVoiceInfoView:InitCallback()
	self.heroTeamChangeHandler_ = handler(self, self.OnHeroTeamChange)
	self.hideSubtitleHandler_ = handler(self, self.OnNeedHideSubtitle)
	self.playMultiHeroVoiceStartHandler_ = handler(self, self.OnPlayMultiHeroVoiceStart)
	self.playMultiHeroVoiceEndHandler_ = handler(self, self.OnPlayMultiHeroVoiceEnd)
end

function SectionHeroVoiceInfoView:AddListener()
	self:AddBtnListener(self.expandBtn_, nil, function()
		self:SwitchExpand()
	end)
end

function SectionHeroVoiceInfoView:SetProxy(arg_8_1)
	self.sectionProxy_ = arg_8_1
end

function SectionHeroVoiceInfoView:OnEnter()
	self:RegistEventListener(SECTION_CHANGE_HERO_TEAM, self.heroTeamChangeHandler_)
	self:RegistEventListener(SECTION_MULTI_HERO_VOICE_START, self.playMultiHeroVoiceStartHandler_)
	self:RegistEventListener(SECTION_MULTI_HERO_VOICE_END, self.playMultiHeroVoiceEndHandler_)
end

function SectionHeroVoiceInfoView:OnExit()
	self:RemoveAllEventListener()
	self:StopDelayHideTimer()
	self:StopPlay()
end

function SectionHeroVoiceInfoView:Refresh()
	self:ResetStatus()
	self:RefreshStatus()
	self:RefreshExpandUI()
end

function SectionHeroVoiceInfoView:ResetStatus()
	self.isExpanding_ = false
	self.needDisplay_ = false
end

function SectionHeroVoiceInfoView:Show(arg_13_1)
	SetActive(self.gameObject_, arg_13_1)
end

function SectionHeroVoiceInfoView:OnHeroTeamChange()
	SectionSelectHeroVoiceManager.GetInstance():TryToPlayVoice(self.sectionProxy_)
end

function SectionHeroVoiceInfoView:OnPlayMultiHeroVoiceStart(arg_15_1)
	self.heroVoiceDescID_ = arg_15_1
	self.needDisplay_ = true

	self:RefreshVoiceUI()
end

function SectionHeroVoiceInfoView:OnPlayMultiHeroVoiceEnd()
	self:StartDelayHideTimer()

	self.needDisplay_ = false
end

function SectionHeroVoiceInfoView:StartDelayHideTimer()
	self:StopDelayHideTimer()

	self.hideDelayTimer_ = TimeTools.StartAfterSeconds(SectionSelectHeroConst.HERO_TEAM_DISPLAY_EXTRA_DELAY_TIME / 1000, self.hideSubtitleHandler_, {})
end

function SectionHeroVoiceInfoView:StopDelayHideTimer()
	if self.hideDelayTimer_ then
		self.hideDelayTimer_:Stop()

		self.hideDelayTimer_ = nil
	end
end

function SectionHeroVoiceInfoView:OnNeedHideSubtitle()
	self.needDisplay_ = false

	self:RefreshStatus()
end

function SectionHeroVoiceInfoView:StopPlay()
	self:StopDelayHideTimer()
	SectionSelectHeroVoiceManager.GetInstance():StopVoice()
end

function SectionHeroVoiceInfoView:RefreshVoiceUI()
	self:RefreshStatus()
	self:RefreshProtagonistUI()
	self:RefreshSubTitle()
	self:RefreshExpandUI()
end

function SectionHeroVoiceInfoView:RefreshStatus()
	self.statusController_:SetSelectedState(self.needDisplay_ and "playing" or "stop")
end

function SectionHeroVoiceInfoView:RefreshProtagonistUI()
	self.protagonistIcon_.sprite = getSpriteViaConfig("StoryHeadIcon", "story_" .. HeroVoiceDescCfg[self.heroVoiceDescID_].chara_id)
	self.protagnistName_.text = HeroTools.GetHeroFullName(HeroVoiceDescCfg[self.heroVoiceDescID_].chara_id)
end

function SectionHeroVoiceInfoView:RefreshSubTitle()
	self.subTitle_.text = HeroVoiceDescCfg[self.heroVoiceDescID_].content
end

function SectionHeroVoiceInfoView:RefreshExpandUI()
	self.expandController_:SetSelectedState(self.isExpanding_ and "on" or "off")
end

function SectionHeroVoiceInfoView:SwitchExpand()
	self.isExpanding_ = not self.isExpanding_

	self:RefreshExpandUI()
end

return SectionHeroVoiceInfoView
