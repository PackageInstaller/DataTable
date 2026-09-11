local HeroFileVoicePage = class("HeroFileVoicePage", ReduxView)

function HeroFileVoicePage:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroFileVoicePage:Init()
	self:InitUI()
end

function HeroFileVoicePage:InitUI()
	self:BindCfgUI()

	self.curHeroID_ = 0
	self.playingVoiceID_ = 0
	self.openItem = 0
	self.itemList_ = {}
	self.subtitleBubble = MainHomeView_SubtitleBubble.New(self.dialogBoxGo_)
end

function HeroFileVoicePage:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		3
	})
end

function HeroFileVoicePage:Show(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self:UpdateView(arg_5_1, arg_5_2, arg_5_4)
	self.subtitleBubble:SetVisible(false)
	SetActive(self.gameObject_, true)
end

function HeroFileVoicePage:Hide()
	self:StopVoice()
	SetActive(self.gameObject_, false)
end

function HeroFileVoicePage:PlayVoice(arg_7_1)
	self:StopVoice()

	self.playingVoiceID_ = arg_7_1

	self:RefreshDialog(arg_7_1)
	self:PlayVoiceByDelayTime(arg_7_1)
	self:StartItemPlay()
	self:SendPlayVoiceMessage(arg_7_1)
end

function HeroFileVoicePage:GetOriginalSkin()
	if self.formID_ then
		return SkinCfg[self.formID_].hero
	else
		return self.curHeroID_
	end
end

function HeroFileVoicePage:RefreshDialog(arg_9_1)
	self.subtitleBubble:SetVisible(true)
	self.subtitleBubble:SetContent((HeroVoiceDescCfg.Get(self:GetHeroIdForPlayVoice(arg_9_1), arg_9_1)))
	self.dialogAni_:Play("talkBubble", 0, 0)
	self.dialogAni_:Update(Time.deltaTime)
end

function HeroFileVoicePage:PlayVoiceByDelayTime(arg_10_1)
	self:StopDelayTimer()

	self.delayPlayTimer_ = Timer.New(function()
		if manager.audio:IsStoppedOfVoice() then
			self:StopDelayTimer()

			local var_11_0 = self:GetHeroIdForPlayVoice(arg_10_1)

			HeroTools.PlayVoice(var_11_0, HeroVoiceCfg[arg_10_1].file, HeroVoiceCfg[arg_10_1].type)

			self.timer_ = TimeTools.StartAfterSeconds(self:GetTalkSeconds(var_11_0, arg_10_1), function()
				self:StopVoice()
			end, {})
		end
	end, 0.033, -1)

	self.delayPlayTimer_:Start()
end

function HeroFileVoicePage:GetHeroIdForPlayVoice(arg_13_1)
	local var_13_0 = nullable(HeroVoiceCfg, arg_13_1, "use_skin_id") or 0

	if var_13_0 ~= 0 then
		return var_13_0
	else
		return self:GetOriginalSkin()
	end
end

function HeroFileVoicePage:GetTalkSeconds(arg_14_1, arg_14_2)
	return math.max(HeroTools.GetTalkLength(arg_14_1, HeroVoiceCfg[arg_14_2].file, HeroVoiceCfg[arg_14_2].type), 0.017) / 1000
end

function HeroFileVoicePage:StartItemPlay()
	for iter_15_0, iter_15_1 in ipairs(self.itemList_) do
		if iter_15_1 then
			iter_15_1:StartPlay(self.playingVoiceID_)
		end
	end
end

function HeroFileVoicePage:StopVoice()
	self.subtitleBubble:SetVisible(false)
	self:StopDelayTimer()
	manager.audio:StopVoiceImmediate()

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	if self.playingVoiceID_ ~= 0 then
		for iter_16_0, iter_16_1 in ipairs(self.itemList_) do
			if iter_16_1 then
				iter_16_1:StopPlay()
			end
		end

		self.playingVoiceID_ = 0
	end
end

function HeroFileVoicePage:StopDelayTimer()
	if self.delayPlayTimer_ then
		self.delayPlayTimer_:Stop()

		self.delayPlayTimer_ = nil
	end
end

function HeroFileVoicePage:ForceUpdate()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.content_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.content_)
end

function HeroFileVoicePage:UpdateView(arg_19_1, arg_19_2, arg_19_3)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.content_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.content_)

	self.curHeroID_ = arg_19_2

	self.subtitleBubble:SetBgStyleByHero(arg_19_2)

	self.formID_ = arg_19_3 and arg_19_3 or nil

	self:InitItemList()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.content_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.content_)
end

local var_0_1 = 8

function HeroFileVoicePage:InitItemList()
	for iter_20_0, iter_20_1 in ipairs(HeroVoiceTagCfg.all) do
		local var_20_0 = self.itemList_[iter_20_0]

		if self.itemList_[iter_20_0] == nil then
			var_20_0 = HeroFileVoiceContentItem.New((Object.Instantiate(self.contentItem_, self.content_)))
			self.itemList_[iter_20_0] = var_20_0
		end

		var_20_0:SetData(self.curHeroID_, iter_20_1, self.formID_, function(arg_21_0)
			PlayerAction.CheckHeroVoice(self.curHeroID_, function()
				if self.playingVoiceID_ == arg_21_0 then
					self:StopVoice()
				else
					self:PlayVoice(arg_21_0)
				end
			end)
		end, function()
			self:ForceUpdate()
		end)
		var_20_0:ChangeShow(false)
		var_20_0:SetBgState(iter_20_1 == var_0_1 and "oath" or "normal")
		var_20_0:StartPlay(self.playingVoiceID_)
		var_20_0:SetIsShow(not var_20_0:IsEmpty())
	end
end

function HeroFileVoicePage:Dispose()
	for iter_24_0, iter_24_1 in pairs(self.itemList_) do
		iter_24_1:Dispose()
	end

	self.itemList_ = {}

	self.subtitleBubble:Dispose()
	HeroFileVoicePage.super.Dispose(self)
end

function HeroFileVoicePage:SendPlayVoiceMessage(arg_25_1)
	SDKTools.SendMessageToSDK("hero_sound", {
		hero_id = self.curHeroID_,
		sound_id = arg_25_1
	})
end

return HeroFileVoicePage
