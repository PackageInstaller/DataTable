local MomoTalkBubbleTalkItem = class("MomoTalkBubbleTalkItem", (import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkBubbleBaseItem")))
local var_0_1 = "TalkBubble"
local var_0_2 = "New State"
local var_0_3

function MomoTalkBubbleTalkItem:Init()
	MomoTalkBubbleTalkItem.super.Init(self)

	if self.mainControllerEx_ then
		self.voiceWordsController_ = self.mainControllerEx_:GetController("showVoiceWords")
	end

	self.isTalkBubblePlaying_ = false
end

function MomoTalkBubbleTalkItem:AddListeners()
	if self.buttonContent_ then
		self:AddBtnListener(self.buttonContent_, nil, function()
			self:PlayVoice()
		end)
	end

	if self.voiceWordsBtn_ then
		self:AddBtnListener(self.voiceWordsBtn_, nil, function()
			self:ToggleVoiceWords()
		end)
	end
end

function MomoTalkBubbleTalkItem:OnReset(arg_5_1, arg_5_2)
	local var_5_0 = arg_5_2 and arg_5_2.state == "delay"

	if self.text_ then
		self.text_.text = var_5_0 and "..." or self:GetVoiceDurationText(arg_5_1)
	end

	if self.voiceWordsText_ then
		self.voiceWordsText_.text = var_5_0 and "..." or MomoTalkTools.GetItemDisplayContent(arg_5_2, arg_5_1)
	end

	if self.voiceWordsController_ then
		self.voiceWordsController_:SetSelectedState("hide")
	end

	self:StopVoicePlaybackState()
end

function MomoTalkBubbleTalkItem:ResolveVoiceParams(arg_6_1)
	local var_6_0 = arg_6_1 and arg_6_1.voice_params

	if type(arg_6_1 and arg_6_1.voice_params) == "table" and #var_6_0 >= 3 then
		return var_6_0
	end

	if not arg_6_1 or arg_6_1.type ~= MomoTalkConst.MSG_TYPE.AUDIO or arg_6_1.spokesmen == nil or arg_6_1.spokesmen <= 0 or arg_6_1.url == nil or arg_6_1.url == "" then
		return nil
	end

	local var_6_1 = tonumber(arg_6_1.spokesmen)
	local var_6_2

	if not var_6_1 or var_6_1 <= 0 then
		do return nil end

		var_6_2 = {
			(string.format("vo_sys_%d", var_6_1))
		}
	end

	var_6_2[2] = arg_6_1.url
	var_6_2[3] = string.format("vo_sys_%d.awb", var_6_1)

	return var_6_2
end

function MomoTalkBubbleTalkItem:GetVoiceDurationText(arg_7_1)
	local var_7_0 = self:ResolveVoiceParams(arg_7_1)

	if not var_7_0 then
		return ""
	end

	return tostring(math.ceil(manager.audio:GetVoiceLength(var_7_0[1], var_7_0[2], var_7_0[3] or "") / 1000)) .. "s"
end

function MomoTalkBubbleTalkItem:PlayBubbleAnimation(arg_8_1)
	if self.speakAni_ and arg_8_1 ~= "" then
		self.speakAni_:Play(arg_8_1)
		self.speakAni_:Update(0)
	end
end

function MomoTalkBubbleTalkItem:PlayBubbleIdleAnimation()
	self:PlayBubbleAnimation(var_0_2)
end

function MomoTalkBubbleTalkItem:StopBubbleStateTimer()
	if self.bubbleStateTimer_ then
		self.bubbleStateTimer_:Stop()

		self.bubbleStateTimer_ = nil
	end
end

function MomoTalkBubbleTalkItem:StopVoicePlaybackState(arg_11_1)
	self:StopBubbleStateTimer()

	if arg_11_1 then
		manager.audio:StopVoice()
	end

	self.isTalkBubblePlaying_ = false

	self:PlayBubbleIdleAnimation()

	if var_0_3 == self then
		var_0_3 = nil
	end
end

function MomoTalkBubbleTalkItem:StartBubbleStateTimer(arg_12_1)
	self:StopBubbleStateTimer()

	arg_12_1 = math.max(arg_12_1 or 0, 0)

	if arg_12_1 <= 0 then
		self:StopVoicePlaybackState()

		return
	end

	self.bubbleStateTimer_ = Timer.New(function()
		self.bubbleStateTimer_ = nil

		self:StopVoicePlaybackState()
	end, arg_12_1, 1)

	self.bubbleStateTimer_:Start()
end

function MomoTalkBubbleTalkItem:PlayVoice()
	local var_14_0 = self:ResolveVoiceParams(self.cfg_)

	if var_14_0 then
		if var_0_3 and var_0_3 ~= self then
			var_0_3:StopVoicePlaybackState(true)
		elseif self.isTalkBubblePlaying_ then
			return
		end

		local var_14_1 = manager.audio:GetVoiceLength(var_14_0[1], var_14_0[2], var_14_0[3] or "")

		HeroTools.StopTalk()
		manager.notify:Invoke(INTERRUPT_HOME_POSTER_TALK)

		var_0_3 = self
		self.isTalkBubblePlaying_ = true

		self:PlayBubbleAnimation(var_0_1)
		self:StartBubbleStateTimer(var_14_1 / 1000)
		manager.audio:PlayVoice(var_14_0[1], var_14_0[2], var_14_0[3])
	end
end

function MomoTalkBubbleTalkItem:ToggleVoiceWords()
	if self.voiceWordsController_ then
		self.voiceWordsController_:SetSelectedState(self.voiceWordsController_:GetSelectedState() == "show" and "hide" or "show")
		self:RebuildLayout()
		self:NotifyLayoutChanged()
		self:DelayNotifyLayoutChanged()
	end
end

function MomoTalkBubbleTalkItem:NotifyLayoutChanged()
	if self.layoutChangedHandler_ then
		self.layoutChangedHandler_(self.layoutChangedSlot_)
	end
end

function MomoTalkBubbleTalkItem:DelayNotifyLayoutChanged()
	self:StopLayoutTimer()

	self.layoutTimer_ = FrameTimer.New(function()
		self.layoutTimer_ = nil

		self:NotifyLayoutChanged()
	end, 1, 1)

	self.layoutTimer_:Start()
end

function MomoTalkBubbleTalkItem:StopLayoutTimer()
	if self.layoutTimer_ then
		self.layoutTimer_:Stop()

		self.layoutTimer_ = nil
	end
end

function MomoTalkBubbleTalkItem:Dispose()
	self:StopLayoutTimer()
	self:StopVoicePlaybackState(var_0_3 == self)
	MomoTalkBubbleTalkItem.super.Dispose(self)
end

return MomoTalkBubbleTalkItem
