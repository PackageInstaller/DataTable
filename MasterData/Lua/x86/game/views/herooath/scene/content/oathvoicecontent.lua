local OathVoiceContent = class("OathVoiceContent", ReduxView)

function OathVoiceContent:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
end

local var_0_1 = {
	awb = "vo_sys_%d.awb",
	name = "v_s_%d_%s",
	sheet = "vo_sys_%d"
}

function OathVoiceContent:OnTalk(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = OathToLuaBridge:GetUseOathCharacterID()

	if HeroTools.FindMatchSkinVoiceCfg(skinID, arg_2_2) then
		HeroTools.PlayTalkBySkinID(var_2_0, arg_2_2, nil, arg_2_1)
	else
		LuaForUtil.PlayVoiceWithCriLipsync(arg_2_1, string.format(var_0_1.sheet, var_2_0), string.format(var_0_1.name, var_2_0, arg_2_2), (string.format(var_0_1.awb, var_2_0)))
		manager.notify:Invoke(HERO_SOUND_PLAY, skinID, arg_2_2, 1)
	end

	local var_2_1 = manager.audio:GetVoiceLength(string.format("vo_sys_%d", var_2_0), string.format("v_s_%d_%s", var_2_0, arg_2_2), string.format("vo_sys_%d.awb", var_2_0))
	local var_2_2 = -1

	for iter_2_0, iter_2_1 in pairs(HeroVoiceCfg.get_id_list_by_file[arg_2_2] or {}) do
		if HeroVoiceCfg[iter_2_1] and HeroVoiceCfg[iter_2_1].use_skin_id == var_2_0 then
			var_2_2 = iter_2_1
		end
	end

	self:ShowVoiceContent(var_2_0, var_2_2, var_2_1, arg_2_3, arg_2_4)
end

function OathVoiceContent:ShowVoiceContent(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = false

	if arg_3_2 and arg_3_2 > 0 then
		local var_3_1 = HeroVoiceDescCfg.Get(tonumber(arg_3_1), arg_3_2)

		if var_3_1 then
			var_3_0 = true
			self.voiceText_.text = var_3_1
		end
	end

	if var_3_0 then
		if arg_3_4 > 0 then
			if self.talkBubbleShowTimer_ then
				self.talkBubbleShowTimer_:Stop()

				self.talkBubbleShowTimer_ = nil
			end

			self.talkBubbleShowTimer_ = TimeTools.StartAfterSeconds(arg_3_4 / 1000, function()
				if var_3_0 and not isNil(self.gameObject_) then
					SetActive(self.gameObject_, true)
				end

				if self.talkBubbleShowTimer_ then
					self.talkBubbleShowTimer_:Stop()

					self.talkBubbleShowTimer_ = nil
				end
			end, {})
		else
			SetActive(self.gameObject_, true)
		end
	end

	if self.talkBubbleHiderTimer_ then
		self.talkBubbleHiderTimer_:Stop()

		self.talkBubbleHiderTimer_ = nil
	end

	self.talkBubbleHiderTimer_ = TimeTools.StartAfterSeconds(arg_3_3 / 1000, function()
		if var_3_0 and not isNil(self.gameObject_) then
			SetActive(self.gameObject_, false)
		end

		if self.talkBubbleHiderTimer_ then
			self.talkBubbleHiderTimer_:Stop()

			self.talkBubbleHiderTimer_ = nil
		end

		if arg_3_5 then
			LuaExchangeHelper.ActionInvoke(arg_3_5)
		end
	end, {})
end

function OathVoiceContent:HideVoiceContent()
	if not isNil(self.gameObject_) then
		SetActive(self.gameObject_, false)
	end

	if self.talkBubbleShowTimer_ then
		self.talkBubbleShowTimer_:Stop()

		self.talkBubbleShowTimer_ = nil
	end

	if self.talkBubbleHiderTimer_ then
		self.talkBubbleHiderTimer_:Stop()

		self.talkBubbleHiderTimer_ = nil
	end
end

function OathVoiceContent:Dispose()
	if self.talkBubbleHiderTimer_ then
		self.talkBubbleHiderTimer_:Stop()

		self.talkBubbleHiderTimer_ = nil
	end

	if self.talkBubbleShowTimer_ then
		self.talkBubbleShowTimer_:Stop()

		self.talkBubbleShowTimer_ = nil
	end

	OathVoiceContent.super.Dispose(self)
end

return OathVoiceContent
