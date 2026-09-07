local MainWordView4Mellow = class("MainWordView4Mellow", import("...theme_classic.view.MainWordView"))

function MainWordView4Mellow:Ctor(arg_1_1, arg_1_2)
	MainWordView4Mellow.super.Ctor(self, arg_1_1, arg_1_2)

	self.animationPlayer = arg_1_1:GetComponent(typeof(Animation))
	self.dftAniEvent = arg_1_1:GetComponent(typeof(DftAniEvent))
	self.cg = arg_1_1:GetComponent(typeof(CanvasGroup))

	return
end

function MainWordView4Mellow:StartAnimation(arg_2_1, arg_2_2)
	if self.stopChatFlag == true then
		return
	end

	if not getProxy(SettingsProxy):ShouldShipMainSceneWord() then
		self.chatTf.localScale = Vector3.zero

		return
	end

	self.cg.alpha = 1

	self.dftAniEvent:SetStartEvent(nil)
	self.dftAniEvent:SetStartEvent(function()
		self.dftAniEvent:SetStartEvent(nil)

		self.chatTf.localScale = Vector3.one

		return
	end)
	self:AddTimer(function()
		if not self.animationPlayer then
			return
		end

		self.animationPlayer:Stop()
		self:PlayHideAnimation(arg_2_1)

		return
	end, arg_2_1 + arg_2_2)
	self.animationPlayer:Play("anim_newmain_chat_show")

	return
end

function MainWordView4Mellow:StopAnimation()
	if self.animationPlayer then
		self.animationPlayer:Stop()
	end

	self:RemoveTimer()

	self.chatTf.localScale = Vector3.zero

	return
end

function MainWordView4Mellow:PlayHideAnimation(arg_6_1)
	if self.exited then
		return
	end

	if not getProxy(SettingsProxy):ShouldShipMainSceneWord() then
		self.chatTf.localScale = Vector3.zero

		return
	end

	self:AddTimer(function()
		if not self.animationPlayer then
			return
		end

		self.animationPlayer:Stop()

		self.chatTf.localScale = Vector3.zero

		return
	end, arg_6_1)
	self.animationPlayer:Play("anim_newmain_chat_hide")

	return
end

function MainWordView4Mellow:AddTimer(arg_8_1, arg_8_2)
	self:RemoveTimer()

	self.timer = Timer.New(arg_8_1, arg_8_2, 1)

	self.timer:Start()

	return
end

function MainWordView4Mellow:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function MainWordView4Mellow:Dispose()
	MainWordView4Mellow.super.Dispose(self)
	self:RemoveTimer()
	self.dftAniEvent:SetStartEvent(nil)
	self.dftAniEvent:SetEndEvent(nil)

	return
end

return MainWordView4Mellow
