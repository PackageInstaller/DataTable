local VoiceChatPlayer = class("VoiceChatPlayer", import("Mgr.Story.model.animation.StoryAnimtion"))
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4

function VoiceChatPlayer:Ctor(arg_1_1)
	VoiceChatPlayer.super.Ctor(self)

	self._tf = arg_1_1.transform
	self.content = self._tf:Find("front/Text"):GetComponent(typeof(Text))
	self.optionPanel = self._tf:Find("front/options_panel")
	self.optionUIList = UIItemList.New(self.optionPanel:Find("options_c"), self.optionPanel:Find("options_c/option_tpl"))
	self.closeBtn = self._tf:Find("front/btns/close_btn")

	return
end

function VoiceChatPlayer:Play(arg_2_1, arg_2_2, arg_2_3)
	if not arg_2_1 then
		arg_2_3()

		return
	end

	local var_2_0 = arg_2_1:GetStepByIndex(arg_2_2)

	if not var_2_0 then
		arg_2_3()

		return
	end

	self.callback = arg_2_3

	self:Reset(var_2_0)
	seriesAsync({
		function(arg_3_0)
			if not self:EnterPhase(var_0_2) then
				return
			end

			self:PlayVoice(var_2_0)
			self:DispatcherEvent(var_2_0)
			self:ReigsetEvent(var_2_0, arg_3_0)

			return
		end,
		function(arg_4_0)
			if not self:EnterPhase(var_0_3) then
				return
			end

			self:ClearEvent()
			self:ClearChatTimer()
			self:DelayCall(0.2, arg_4_0)

			return
		end,
		function(arg_5_0)
			if not self:EnterPhase(var_0_4) then
				return
			end

			self:StopVoice()
			self:InitOptionIfNeed(arg_2_1, var_2_0, arg_5_0)

			return
		end,
		function(arg_6_0)
			if not self:EnterPhase(var_0_5) then
				return
			end

			self:Clear(var_2_0, arg_6_0)

			return
		end
	}, arg_2_3)

	return
end

function VoiceChatPlayer:EnterPhase(arg_7_1)
	if arg_7_1 - 1 ~= self.phase then
		return false
	end

	self.phase = arg_7_1

	return true
end

function VoiceChatPlayer:Reset(arg_8_1)
	self.phase = var_0_1

	setActive(self.optionPanel, false)
	self:ClearEvent()

	return
end

function VoiceChatPlayer:StopVoice()
	if self.currentVoice then
		self.currentVoice:Stop(true)

		self.currentVoice = nil
	end

	return
end

function VoiceChatPlayer:PlayVoice(arg_10_1)
	self:StopVoice()

	self.content.text = arg_10_1:GetSay()

	local var_10_0 = arg_10_1:GetVoice()

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_10_0, function(arg_11_0)
		if arg_11_0 then
			self.currentVoice = arg_11_0.playback
		end

		local var_11_0 = arg_11_0:GetLength() * 0.001
		local var_11_1 = arg_10_1:GetWaitForClickTime()

		assert(var_11_1 < var_11_0, string.format("chatShowTime must > wait time voice:%s voiceLenth:%f wait:%f", var_10_0, var_11_0, var_11_1))
		self:AddTimeTriggerNextOne(var_11_0)

		return
	end)

	return
end

function VoiceChatPlayer:AddTimeTriggerNextOne(arg_12_1)
	self.chatTimer = self:CreateDelayTimer(arg_12_1, function()
		self:ClearChatTimer()
		triggerButton(self._tf)

		return
	end)

	return
end

function VoiceChatPlayer:ClearChatTimer()
	if self.chatTimer then
		self.chatTimer:Stop()

		self.chatTimer = nil
	end

	return
end

function VoiceChatPlayer:ReigsetEvent(arg_15_1, arg_15_2)
	self:DelayCall(arg_15_1:GetWaitForClickTime(), function()
		onButton(self, self._tf, arg_15_2, SFX_PANEL)

		return
	end)

	return
end

function VoiceChatPlayer:ClearEvent()
	removeOnButton(self._tf)

	return
end

function VoiceChatPlayer:InitOptionIfNeed(arg_18_1, arg_18_2, arg_18_3)
	setActive(self.optionPanel, arg_18_2:ExistOption())

	if not arg_18_2:ExistOption() then
		arg_18_3()

		return
	end

	setActive(self.closeBtn, false)

	local var_18_0 = arg_18_2:GetOptions()

	self.optionUIList:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			local var_19_0 = var_18_0[arg_19_1 + 1]

			arg_19_2:Find("content/Text"):GetComponent(typeof(Text)).text = var_18_0[arg_19_1 + 1][1]

			onButton(self, arg_19_2, function()
				if optionBlockOther then
					return
				end

				local var_20_0 = arg_19_2:Find("selectAni")

				setActive(var_20_0, true)
				var_20_0:GetComponent(typeof(Animation)):Play("anim_selectAni_loop")

				self.optionBlockOther = true

				var_20_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
					self.optionBlockOther = false

					setActive(var_20_0, false)
					arg_18_1:SetBranchCode(var_19_0[2])
					arg_18_3(var_19_0[2])
					setActive(self.closeBtn, true)

					return
				end)

				return
			end)
		end

		return
	end)
	self.optionUIList:align(#var_18_0)

	return
end

function VoiceChatPlayer:DispatcherEvent(arg_22_1)
	if not arg_22_1:ExistDispatcher() then
		return
	end

	local var_22_0 = arg_22_1:GetDispatcher()

	pg.NewStoryMgr.GetInstance():ClearStoryEvent()
	pg.m02:sendNotification(var_22_0.name, {
		data = var_22_0.data,
		callbackData = var_22_0.callbackData
	})

	if arg_22_1:ShouldHideUI() then
		setActive(self._tf, false)
	end

	if arg_22_1:IsRecallDispatcher() then
		self:CheckDispatcher(arg_22_1)
	end

	return var_22_0.nextOne
end

function VoiceChatPlayer:CheckDispatcher(arg_23_1)
	local var_23_0 = arg_23_1:GetDispatcherRecallName()

	self:ClearCheckDispatcher()

	self.checkTimer = Timer.New(function()
		if pg.NewStoryMgr.GetInstance():CheckStoryEvent(var_23_0) then
			local var_24_0 = pg.NewStoryMgr.GetInstance():GetStoryEventArg(var_23_0)

			if var_24_0 then
				existCall(var_24_0.notifiCallback)
			end

			if var_24_0 and var_24_0.optionIndex then
				self.skipOption = true
			end

			if arg_23_1:ShouldHideUI() then
				setActive(self._tf, true)
			end

			self:ClearCheckDispatcher()
		end

		return
	end, 1, -1)

	self.checkTimer:Start()
	self.checkTimer.func()

	return
end

function VoiceChatPlayer:ClearCheckDispatcher()
	if self.checkTimer then
		self.checkTimer:Stop()

		self.checkTimer = nil
	end

	return
end

function VoiceChatPlayer:Clear(arg_26_1, arg_26_2)
	self:ClearAnimation()
	self:StopVoice()
	self:ClearChatTimer()
	self:ClearCheckDispatcher()
	setActive(self.optionPanel, false)

	self.callback = nil

	existCall(arg_26_2)

	return
end

function VoiceChatPlayer:OnPause()
	return
end

function VoiceChatPlayer:OnResume()
	return
end

function VoiceChatPlayer:OnStop()
	self:Reset()
	self:ClearAnimation()
	self:StopVoice()

	if self.callback then
		self.callback()

		self.callback = nil
	end

	return
end

function VoiceChatPlayer:OnStart(arg_30_1)
	pg.DelegateInfo.New(self)

	return
end

function VoiceChatPlayer:OnEnd(arg_31_1)
	pg.DelegateInfo.Dispose(self)
	self:ClearChatTimer()
	self:ClearCheckDispatcher()

	return
end

return VoiceChatPlayer
