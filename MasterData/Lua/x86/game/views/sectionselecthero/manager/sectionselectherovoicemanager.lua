local var_0_0 = singletonClass("SectionSelectHeroVoiceManager")

function var_0_0:Ctor()
	self:InitBaseParams()
	self:InitMutlHeroVoiceParams()
	self:InitHeroLeaderVoiceParams()
end

function var_0_0.InitBaseParams(arg_2_0)
	arg_2_0.sectionProxy_ = nil
	arg_2_0.isPlaying_ = false
	arg_2_0.curHeroIdList_ = {}
	arg_2_0.lastHeroIdList_ = {}
	arg_2_0.addedHeroIdList_ = {}
end

function var_0_0:InitMutlHeroVoiceParams()
	self.heroVoiceDescId_ = nil
	self.curActorIdList_ = {}
	self.playMultiHeroVoiceEndHandler_ = handler(self, self.OnPlayMultiHeroVoiceEnd)
end

function var_0_0:InitHeroLeaderVoiceParams()
	self.lastPlayHeroLeaderTimestamp_ = 0
	self.playHeroLeaderStartHandler_ = handler(self, self.OnPlayHeroLeaderVoiceStart)
	self.playHeroLeaderEndHandler_ = handler(self, self.OnPlayHeroLeaderVoiceEnd)
	self.playHeroApperanceEndHandler_ = handler(self, self.OnPlayHeroApperanceVoiceEnd)
end

function var_0_0.InitHeroApperanceVoiceParams(arg_5_0)
	arg_5_0.needApperanceVoiceHeroId_ = nil
end

function var_0_0:TryToPlayVoice(arg_6_1)
	if self.isPlaying_ then
		return
	end

	self.sectionProxy_ = arg_6_1

	self:UpdateHeroIdList()
	self:UpdateVoiceType()
	self:PlayVoice()
end

function var_0_0:UpdateHeroIdList()
	if self.sectionProxy_.isEnter then
		self.curHeroIdList_ = self.sectionProxy_:GetHeroIDList()
		self.lastHeroIdList_ = self.curHeroIdList_
	else
		self.lastHeroIdList_ = self.curHeroIdList_ or {}
		self.curHeroIdList_ = self.sectionProxy_:GetHeroIDList()
	end

	self:GetAddedHeroIdList()
end

function var_0_0:UpdateVoiceType()
	self.voiceType_ = self:IsCanPlayMultiHeroVoice() and SectionSelectHeroConst.HERO_VOICE_TYPE.MULTI_HERO or self:IsCanPlayHeroLeaderVoice() and SectionSelectHeroConst.HERO_VOICE_TYPE.LEADER or self:IsCanPlayHeroApperanceVoice() and SectionSelectHeroConst.HERO_VOICE_TYPE.APPERANCE or SectionSelectHeroConst.HERO_VOICE_TYPE.NULL

	if self.voiceType_ ~= SectionSelectHeroConst.HERO_VOICE_TYPE.APPERANCE then
		self:ClearHeroApperanceVoiceData()
	end
end

function var_0_0:PlayVoice()
	if self.voiceType_ == SectionSelectHeroConst.HERO_VOICE_TYPE.APPERANCE then
		self:StartPlayHeroApperanceVoice()
	elseif self.voiceType_ == SectionSelectHeroConst.HERO_VOICE_TYPE.LEADER then
		self:StartPlayHeroLeaderVoice()
	elseif self.voiceType_ == SectionSelectHeroConst.HERO_VOICE_TYPE.MULTI_HERO then
		self:StartPlayMultiHeroVoice()
	end
end

function var_0_0:IsCanPlayMultiHeroVoice()
	if #self.addedHeroIdList_ == 0 or self.sectionProxy_.isEnter then
		return false
	end

	self:UpdateHeroVoiceDescId()

	if self.heroVoiceDescId_ then
		return true
	end

	return false
end

function var_0_0:UpdateHeroVoiceDescId()
	local var_11_0 = HeroTools.GetSectionHeroTeamVoiceIDList(self.curHeroIdList_)

	if #var_11_0 == 0 then
		self.heroVoiceDescId_ = nil

		return
	end

	local var_11_1 = {}

	if #self.addedHeroIdList_ == 1 then
		for iter_11_0, iter_11_1 in ipairs(var_11_0) do
			if self.addedHeroIdList_[1] == HeroVoiceDescCfg[iter_11_1].chara_id then
				var_11_1[#var_11_1 + 1] = iter_11_1
			end
		end
	else
		var_11_1 = var_11_0
	end

	if #var_11_1 == 0 then
		self.heroVoiceDescId_ = nil
	else
		self.heroVoiceDescId_ = #var_11_1 == 1 and var_11_1[1] or var_11_1[math.random(1, #var_11_1)]
	end
end

function var_0_0:StartPlayMultiHeroVoice()
	self.isPlaying_ = true

	self:UpdateCast()
	self:StartMultiHeroVoicePlayTimer()
	HeroTools.PlaySectionHeroTeamVoice(self.curActorIdList_)
	manager.notify:Invoke(SECTION_MULTI_HERO_VOICE_START, self.heroVoiceDescId_)
end

function var_0_0:UpdateCast()
	self.curActorIdList_ = {}

	if self.heroVoiceDescId_ then
		self.protagonistId_ = HeroVoiceDescCfg[self.heroVoiceDescId_].chara_id
		self.curActorIdList_[#self.curActorIdList_ + 1] = self.protagonistId_

		for iter_13_0, iter_13_1 in ipairs(HeroVoiceDescCfg[self.heroVoiceDescId_].team_hero_id_list) do
			self.curActorIdList_[#self.curActorIdList_ + 1] = iter_13_1
		end
	end
end

function var_0_0:StartMultiHeroVoicePlayTimer()
	self:StopMultiHeroVoicePlayTimer()

	self.multiHeroVoiceplayTimer_ = TimeTools.StartAfterSeconds(HeroTools.GetSectionHeroTeamTalkLength(self.curActorIdList_) / 1000, self.playMultiHeroVoiceEndHandler_, {})
end

function var_0_0:StopMultiHeroVoicePlayTimer()
	if self.multiHeroVoiceplayTimer_ then
		self.multiHeroVoiceplayTimer_:Stop()

		self.multiHeroVoiceplayTimer_ = nil
	end
end

function var_0_0:StopPlayMultiHeroVoice()
	self.isPlaying_ = false

	self:StopMultiHeroVoicePlayTimer()
end

function var_0_0:OnPlayMultiHeroVoiceEnd()
	self.isPlaying_ = false

	self:StopMultiHeroVoicePlayTimer()
	manager.notify:Invoke(SECTION_MULTI_HERO_VOICE_END)
end

function var_0_0:IsCanPlayHeroLeaderVoice()
	if self.curHeroIdList_[1] == 0 then
		return false
	end

	if self.lastPlayHeroLeaderTimestamp_ + HeroConst.SET_LEADER_VOICE_CD > manager.time:GetServerTime() then
		return false
	end

	if self.lastHeroIdList_[1] == self.curHeroIdList_[1] then
		return false
	end

	return true
end

function var_0_0:StartPlayHeroLeaderVoice()
	HeroTools.StopTalk()
	self:StartHeroLeaderDelayTimer()
end

function var_0_0:StartHeroLeaderDelayTimer()
	self.isPlaying_ = true

	self:StopHeroLeaderDelayTimer()

	self.heroLeaderDelayTiemr_ = TimeTools.StartAfterSeconds(HeroConst.TALK_DELAY_TIME, self.playHeroLeaderStartHandler_, {})
end

function var_0_0:StopHeroLeaderDelayTimer()
	if self.heroLeaderDelayTiemr_ then
		self.heroLeaderDelayTiemr_:Stop()

		self.heroLeaderDelayTiemr_ = nil
	end
end

function var_0_0:OnPlayHeroLeaderVoiceStart()
	HeroTools.PlayTalk(self.curHeroIdList_[1], "leader")

	self.lastPlayHeroLeaderTimestamp_ = manager.time:GetServerTime()

	self:StartHeroLeaderPlayTimer()
end

function var_0_0:StartHeroLeaderPlayTimer()
	self:StopHeroLeaderPlayTimer()

	self.heroLeaderPlayTiemr_ = TimeTools.StartAfterSeconds(HeroTools.GetTalkLength(self.curHeroIdList_[1], "leader") / 1000, self.playHeroLeaderEndHandler_, {})
end

function var_0_0:StopHeroLeaderPlayTimer()
	if self.heroLeaderPlayTiemr_ then
		self.heroLeaderPlayTiemr_:Stop()

		self.heroLeaderPlayTiemr_ = nil
	end
end

function var_0_0:OnPlayHeroLeaderVoiceEnd()
	self.isPlaying_ = false

	self:StopHeroLeaderPlayTimer()
end

function var_0_0:StopPlayHeroLeaderVoice()
	self.isPlaying_ = false

	self:StopHeroLeaderDelayTimer()
	self:StopHeroLeaderPlayTimer()
end

function var_0_0.SetNeedApperanceVoiceHeroId(arg_27_0, arg_27_1)
	arg_27_0.needApperanceVoiceHeroId_ = arg_27_1
end

function var_0_0:GetNeedApperanceVoiceHeroId()
	return self.needApperanceVoiceHeroId_
end

function var_0_0:IsCanPlayHeroApperanceVoice()
	return self.needApperanceVoiceHeroId_ ~= nil
end

function var_0_0:ClearHeroApperanceVoiceData()
	self:SetNeedApperanceVoiceHeroId(nil)
end

function var_0_0:TryToPlayHeroApperanceVoice()
	if not self.needApperanceVoiceHeroId_ then
		return false
	end

	self:StartPlayHeroApperanceVoice()

	return true
end

function var_0_0:StartPlayHeroApperanceVoice()
	self.isPlaying_ = true

	HeroTools.PlayTalk(self:GetNeedApperanceVoiceHeroId(), "team")
	self:StartHeroApperanceVoiceTimer()
	self:SetNeedApperanceVoiceHeroId(nil)
end

function var_0_0:StopPlayHeroApperanceVoiceTimer()
	if self.heroApperanceTimer_ then
		self.heroApperanceTimer_:Stop()

		self.heroApperanceTimer_ = nil
	end
end

function var_0_0:StartHeroApperanceVoiceTimer()
	self:StopPlayHeroApperanceVoiceTimer()

	self.heroApperanceTimer_ = TimeTools.StartAfterSeconds(HeroTools.GetTalkLength(self:GetNeedApperanceVoiceHeroId(), "team") / 1000, self.playHeroApperanceEndHandler_, {})
end

function var_0_0:StopPlayHeroApperanceVoice()
	self.isPlaying_ = false

	self:StopPlayHeroApperanceVoiceTimer()
end

function var_0_0:OnPlayHeroApperanceVoiceEnd()
	self.isPlaying_ = false

	self:StopPlayHeroApperanceVoiceTimer()
end

function var_0_0:StopVoice()
	if self.isPlaying_ then
		manager.audio:StopVoiceImmediate()
		self:StopPlayMultiHeroVoice()
		self:StopPlayHeroLeaderVoice()
		self:StopPlayHeroApperanceVoice()
	end
end

function var_0_0:GetAddedHeroIdList()
	self.addedHeroIdList_ = {}

	if #self.lastHeroIdList_ == 0 then
		return
	end

	local var_38_0 = {}

	for iter_38_0, iter_38_1 in ipairs(self.lastHeroIdList_) do
		var_38_0[iter_38_1] = true
	end

	for iter_38_2, iter_38_3 in ipairs(self.curHeroIdList_) do
		if not var_38_0[iter_38_3] then
			self.addedHeroIdList_[#self.addedHeroIdList_ + 1] = iter_38_3
		end
	end
end

function var_0_0.Dispose(arg_39_0)
	arg_39_0.sectionProxy_ = nil
end

return var_0_0
