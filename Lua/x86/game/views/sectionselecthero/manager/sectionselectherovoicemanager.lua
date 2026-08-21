local var_0_0 = singletonClass("SectionSelectHeroVoiceManager")

function var_0_0.Ctor(arg_1_0)
	arg_1_0:InitBaseParams()
	arg_1_0:InitMutlHeroVoiceParams()
	arg_1_0:InitHeroLeaderVoiceParams()
end

function var_0_0.InitBaseParams(arg_2_0)
	arg_2_0.sectionProxy_ = nil
	arg_2_0.isPlaying_ = false
	arg_2_0.curHeroIdList_ = {}
	arg_2_0.lastHeroIdList_ = {}
	arg_2_0.addedHeroIdList_ = {}
end

function var_0_0.InitMutlHeroVoiceParams(arg_3_0)
	arg_3_0.heroVoiceDescId_ = nil
	arg_3_0.curActorIdList_ = {}
	arg_3_0.playMultiHeroVoiceEndHandler_ = handler(arg_3_0, arg_3_0.OnPlayMultiHeroVoiceEnd)
end

function var_0_0.InitHeroLeaderVoiceParams(arg_4_0)
	arg_4_0.lastPlayHeroLeaderTimestamp_ = 0
	arg_4_0.playHeroLeaderStartHandler_ = handler(arg_4_0, arg_4_0.OnPlayHeroLeaderVoiceStart)
	arg_4_0.playHeroLeaderEndHandler_ = handler(arg_4_0, arg_4_0.OnPlayHeroLeaderVoiceEnd)
	arg_4_0.playHeroApperanceEndHandler_ = handler(arg_4_0, arg_4_0.OnPlayHeroApperanceVoiceEnd)
end

function var_0_0.InitHeroApperanceVoiceParams(arg_5_0)
	arg_5_0.needApperanceVoiceHeroId_ = nil
end

function var_0_0.TryToPlayVoice(arg_6_0, arg_6_1)
	if arg_6_0.isPlaying_ then
		return
	end

	arg_6_0.sectionProxy_ = arg_6_1

	arg_6_0:UpdateHeroIdList()
	arg_6_0:UpdateVoiceType()
	arg_6_0:PlayVoice()
end

function var_0_0.UpdateHeroIdList(arg_7_0)
	if arg_7_0.sectionProxy_.isEnter then
		arg_7_0.curHeroIdList_ = arg_7_0.sectionProxy_:GetHeroIDList()
		arg_7_0.lastHeroIdList_ = arg_7_0.curHeroIdList_
	else
		arg_7_0.lastHeroIdList_ = arg_7_0.curHeroIdList_ or {}
		arg_7_0.curHeroIdList_ = arg_7_0.sectionProxy_:GetHeroIDList()
	end

	arg_7_0:GetAddedHeroIdList()
end

function var_0_0.UpdateVoiceType(arg_8_0)
	if arg_8_0:IsCanPlayMultiHeroVoice() then
		arg_8_0.voiceType_ = SectionSelectHeroConst.HERO_VOICE_TYPE.MULTI_HERO
	elseif arg_8_0:IsCanPlayHeroLeaderVoice() then
		arg_8_0.voiceType_ = SectionSelectHeroConst.HERO_VOICE_TYPE.LEADER
	elseif arg_8_0:IsCanPlayHeroApperanceVoice() then
		arg_8_0.voiceType_ = SectionSelectHeroConst.HERO_VOICE_TYPE.APPERANCE
	else
		arg_8_0.voiceType_ = SectionSelectHeroConst.HERO_VOICE_TYPE.NULL
	end

	if arg_8_0.voiceType_ ~= SectionSelectHeroConst.HERO_VOICE_TYPE.APPERANCE then
		arg_8_0:ClearHeroApperanceVoiceData()
	end
end

function var_0_0.PlayVoice(arg_9_0)
	if arg_9_0.voiceType_ == SectionSelectHeroConst.HERO_VOICE_TYPE.APPERANCE then
		arg_9_0:StartPlayHeroApperanceVoice()
	elseif arg_9_0.voiceType_ == SectionSelectHeroConst.HERO_VOICE_TYPE.LEADER then
		arg_9_0:StartPlayHeroLeaderVoice()
	elseif arg_9_0.voiceType_ == SectionSelectHeroConst.HERO_VOICE_TYPE.MULTI_HERO then
		arg_9_0:StartPlayMultiHeroVoice()
	end
end

function var_0_0.IsCanPlayMultiHeroVoice(arg_10_0)
	if #arg_10_0.addedHeroIdList_ == 0 or arg_10_0.sectionProxy_.isEnter then
		return false
	end

	arg_10_0:UpdateHeroVoiceDescId()

	if arg_10_0.heroVoiceDescId_ then
		return true
	end

	return false
end

function var_0_0.UpdateHeroVoiceDescId(arg_11_0)
	local var_11_0 = HeroTools.GetSectionHeroTeamVoiceIDList(arg_11_0.curHeroIdList_)

	if #var_11_0 == 0 then
		arg_11_0.heroVoiceDescId_ = nil

		return
	end

	local var_11_1 = {}

	if #arg_11_0.addedHeroIdList_ == 1 then
		local var_11_2 = arg_11_0.addedHeroIdList_[1]

		for iter_11_0, iter_11_1 in ipairs(var_11_0) do
			if var_11_2 == HeroVoiceDescCfg[iter_11_1].chara_id then
				var_11_1[#var_11_1 + 1] = iter_11_1
			end
		end
	else
		var_11_1 = var_11_0
	end

	if #var_11_1 == 0 then
		arg_11_0.heroVoiceDescId_ = nil
	elseif #var_11_1 == 1 then
		arg_11_0.heroVoiceDescId_ = var_11_1[1]
	else
		arg_11_0.heroVoiceDescId_ = var_11_1[math.random(1, #var_11_1)]
	end
end

function var_0_0.StartPlayMultiHeroVoice(arg_12_0)
	arg_12_0.isPlaying_ = true

	arg_12_0:UpdateCast()
	arg_12_0:StartMultiHeroVoicePlayTimer()
	HeroTools.PlaySectionHeroTeamVoice(arg_12_0.curActorIdList_)
	manager.notify:Invoke(SECTION_MULTI_HERO_VOICE_START, arg_12_0.heroVoiceDescId_)
end

function var_0_0.UpdateCast(arg_13_0)
	arg_13_0.curActorIdList_ = {}

	if arg_13_0.heroVoiceDescId_ then
		local var_13_0 = HeroVoiceDescCfg[arg_13_0.heroVoiceDescId_]

		arg_13_0.protagonistId_ = var_13_0.chara_id
		arg_13_0.curActorIdList_[#arg_13_0.curActorIdList_ + 1] = arg_13_0.protagonistId_

		for iter_13_0, iter_13_1 in ipairs(var_13_0.team_hero_id_list) do
			arg_13_0.curActorIdList_[#arg_13_0.curActorIdList_ + 1] = iter_13_1
		end
	end
end

function var_0_0.StartMultiHeroVoicePlayTimer(arg_14_0)
	arg_14_0:StopMultiHeroVoicePlayTimer()

	local var_14_0 = HeroTools.GetSectionHeroTeamTalkLength(arg_14_0.curActorIdList_) / 1000

	arg_14_0.multiHeroVoiceplayTimer_ = TimeTools.StartAfterSeconds(var_14_0, arg_14_0.playMultiHeroVoiceEndHandler_, {})
end

function var_0_0.StopMultiHeroVoicePlayTimer(arg_15_0)
	if arg_15_0.multiHeroVoiceplayTimer_ then
		arg_15_0.multiHeroVoiceplayTimer_:Stop()

		arg_15_0.multiHeroVoiceplayTimer_ = nil
	end
end

function var_0_0.StopPlayMultiHeroVoice(arg_16_0)
	arg_16_0.isPlaying_ = false

	arg_16_0:StopMultiHeroVoicePlayTimer()
end

function var_0_0.OnPlayMultiHeroVoiceEnd(arg_17_0)
	arg_17_0.isPlaying_ = false

	arg_17_0:StopMultiHeroVoicePlayTimer()
	manager.notify:Invoke(SECTION_MULTI_HERO_VOICE_END)
end

function var_0_0.IsCanPlayHeroLeaderVoice(arg_18_0)
	if arg_18_0.curHeroIdList_[1] == 0 then
		return false
	end

	if arg_18_0.lastPlayHeroLeaderTimestamp_ + HeroConst.SET_LEADER_VOICE_CD > manager.time:GetServerTime() then
		return false
	end

	if arg_18_0.lastHeroIdList_[1] == arg_18_0.curHeroIdList_[1] then
		return false
	end

	return true
end

function var_0_0.StartPlayHeroLeaderVoice(arg_19_0)
	HeroTools.StopTalk()
	arg_19_0:StartHeroLeaderDelayTimer()
end

function var_0_0.StartHeroLeaderDelayTimer(arg_20_0)
	arg_20_0.isPlaying_ = true

	arg_20_0:StopHeroLeaderDelayTimer()

	arg_20_0.heroLeaderDelayTiemr_ = TimeTools.StartAfterSeconds(HeroConst.TALK_DELAY_TIME, arg_20_0.playHeroLeaderStartHandler_, {})
end

function var_0_0.StopHeroLeaderDelayTimer(arg_21_0)
	if arg_21_0.heroLeaderDelayTiemr_ then
		arg_21_0.heroLeaderDelayTiemr_:Stop()

		arg_21_0.heroLeaderDelayTiemr_ = nil
	end
end

function var_0_0.OnPlayHeroLeaderVoiceStart(arg_22_0)
	HeroTools.PlayTalk(arg_22_0.curHeroIdList_[1], "leader")

	arg_22_0.lastPlayHeroLeaderTimestamp_ = manager.time:GetServerTime()

	arg_22_0:StartHeroLeaderPlayTimer()
end

function var_0_0.StartHeroLeaderPlayTimer(arg_23_0)
	arg_23_0:StopHeroLeaderPlayTimer()

	local var_23_0 = HeroTools.GetTalkLength(arg_23_0.curHeroIdList_[1], "leader") / 1000

	arg_23_0.heroLeaderPlayTiemr_ = TimeTools.StartAfterSeconds(var_23_0, arg_23_0.playHeroLeaderEndHandler_, {})
end

function var_0_0.StopHeroLeaderPlayTimer(arg_24_0)
	if arg_24_0.heroLeaderPlayTiemr_ then
		arg_24_0.heroLeaderPlayTiemr_:Stop()

		arg_24_0.heroLeaderPlayTiemr_ = nil
	end
end

function var_0_0.OnPlayHeroLeaderVoiceEnd(arg_25_0)
	arg_25_0.isPlaying_ = false

	arg_25_0:StopHeroLeaderPlayTimer()
end

function var_0_0.StopPlayHeroLeaderVoice(arg_26_0)
	arg_26_0.isPlaying_ = false

	arg_26_0:StopHeroLeaderDelayTimer()
	arg_26_0:StopHeroLeaderPlayTimer()
end

function var_0_0.SetNeedApperanceVoiceHeroId(arg_27_0, arg_27_1)
	arg_27_0.needApperanceVoiceHeroId_ = arg_27_1
end

function var_0_0.GetNeedApperanceVoiceHeroId(arg_28_0)
	return arg_28_0.needApperanceVoiceHeroId_
end

function var_0_0.IsCanPlayHeroApperanceVoice(arg_29_0)
	return arg_29_0.needApperanceVoiceHeroId_ ~= nil
end

function var_0_0.ClearHeroApperanceVoiceData(arg_30_0)
	arg_30_0:SetNeedApperanceVoiceHeroId(nil)
end

function var_0_0.TryToPlayHeroApperanceVoice(arg_31_0)
	if not arg_31_0.needApperanceVoiceHeroId_ then
		return false
	end

	arg_31_0:StartPlayHeroApperanceVoice()

	return true
end

function var_0_0.StartPlayHeroApperanceVoice(arg_32_0)
	arg_32_0.isPlaying_ = true

	HeroTools.PlayTalk(arg_32_0:GetNeedApperanceVoiceHeroId(), "team")
	arg_32_0:StartHeroApperanceVoiceTimer()
	arg_32_0:SetNeedApperanceVoiceHeroId(nil)
end

function var_0_0.StopPlayHeroApperanceVoiceTimer(arg_33_0)
	if arg_33_0.heroApperanceTimer_ then
		arg_33_0.heroApperanceTimer_:Stop()

		arg_33_0.heroApperanceTimer_ = nil
	end
end

function var_0_0.StartHeroApperanceVoiceTimer(arg_34_0)
	arg_34_0:StopPlayHeroApperanceVoiceTimer()

	local var_34_0 = HeroTools.GetTalkLength(arg_34_0:GetNeedApperanceVoiceHeroId(), "team") / 1000

	arg_34_0.heroApperanceTimer_ = TimeTools.StartAfterSeconds(var_34_0, arg_34_0.playHeroApperanceEndHandler_, {})
end

function var_0_0.StopPlayHeroApperanceVoice(arg_35_0)
	arg_35_0.isPlaying_ = false

	arg_35_0:StopPlayHeroApperanceVoiceTimer()
end

function var_0_0.OnPlayHeroApperanceVoiceEnd(arg_36_0)
	arg_36_0.isPlaying_ = false

	arg_36_0:StopPlayHeroApperanceVoiceTimer()
end

function var_0_0.StopVoice(arg_37_0)
	if arg_37_0.isPlaying_ then
		manager.audio:StopVoiceImmediate()
		arg_37_0:StopPlayMultiHeroVoice()
		arg_37_0:StopPlayHeroLeaderVoice()
		arg_37_0:StopPlayHeroApperanceVoice()
	end
end

function var_0_0.GetAddedHeroIdList(arg_38_0)
	arg_38_0.addedHeroIdList_ = {}

	if #arg_38_0.lastHeroIdList_ == 0 then
		return
	end

	local var_38_0 = {}

	for iter_38_0, iter_38_1 in ipairs(arg_38_0.lastHeroIdList_) do
		var_38_0[iter_38_1] = true
	end

	for iter_38_2, iter_38_3 in ipairs(arg_38_0.curHeroIdList_) do
		if not var_38_0[iter_38_3] then
			arg_38_0.addedHeroIdList_[#arg_38_0.addedHeroIdList_ + 1] = iter_38_3
		end
	end
end

function var_0_0.Dispose(arg_39_0)
	arg_39_0.sectionProxy_ = nil
end

return var_0_0
