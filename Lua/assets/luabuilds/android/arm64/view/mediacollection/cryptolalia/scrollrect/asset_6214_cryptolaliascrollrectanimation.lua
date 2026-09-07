local CryptolaliaScrollRectAnimation = class("CryptolaliaScrollRectAnimation")

function CryptolaliaScrollRectAnimation:Ctor(arg_1_1)
	self._tf = arg_1_1
	self.isInit = false

	return
end

function CryptolaliaScrollRectAnimation:Init()
	self.animation = self._tf:GetComponent(typeof(Animation))
	self.dftAniEvent = self._tf:GetComponent(typeof(DftAniEvent))

	self.dftAniEvent:SetTriggerEvent(function()
		if self.onTrigger then
			self.onTrigger()
		end

		self.onTrigger = nil

		return
	end)
	self.dftAniEvent:SetEndEvent(function()
		if self.callback then
			self.callback()
		end

		return
	end)

	self.subAnim = self._tf:Find("Main/anim")
	self.subAnimation = self.subAnim:GetComponent(typeof(Animation))
	self.subDftAniEvent = self.subAnim:GetComponent(typeof(DftAniEvent))

	self.subDftAniEvent:SetStartEvent(function()
		self.playing = true

		return
	end)
	self.subDftAniEvent:SetEndEvent(function()
		self.playing = false

		if self.onLastUpdate then
			self.onLastUpdate()

			self.onLastUpdate = nil
		end

		return
	end)

	self.playing = false
	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	self.isInit = true

	return
end

function CryptolaliaScrollRectAnimation:Update()
	if self.playing and self.onUpdate then
		self.onUpdate((self:Evaluate()))
	elseif not self.playing and self.onUpdate then
		self.onUpdate = nil
	end

	return
end

function CryptolaliaScrollRectAnimation:Play(arg_8_1)
	if not self.isInit then
		self:Init()
	end

	self:Stop()
	self.animation:Play("anim_Cryptolalia_change")
	self.subAnimation:Play(arg_8_1 <= 0 and "anim_Cryptolalia_listup" or "anim_Cryptolalia_listdown")

	return CryptolaliaScrollRectAnimation
end

function CryptolaliaScrollRectAnimation:OnUpdate(arg_9_1)
	self.onUpdate = arg_9_1

	return CryptolaliaScrollRectAnimation
end

function CryptolaliaScrollRectAnimation:OnLastUpdate(arg_10_1)
	self.onLastUpdate = arg_10_1

	return CryptolaliaScrollRectAnimation
end

function CryptolaliaScrollRectAnimation:OnTrigger(arg_11_1)
	self.onTrigger = arg_11_1

	return CryptolaliaScrollRectAnimation
end

function CryptolaliaScrollRectAnimation:OnComplete(arg_12_1)
	self.callback = arg_12_1

	return CryptolaliaScrollRectAnimation
end

function CryptolaliaScrollRectAnimation:Evaluate()
	return self.subAnim.localPosition
end

function CryptolaliaScrollRectAnimation:Stop()
	self.playing = false

	self.animation:Stop()
	self.subAnimation:Stop()

	return
end

function CryptolaliaScrollRectAnimation:Dispose()
	self.dftAniEvent:SetTriggerEvent(nil)
	self.dftAniEvent:SetEndEvent(nil)
	self.subDftAniEvent:SetStartEvent(nil)
	self.subDftAniEvent:SetEndEvent(nil)

	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	return
end

return CryptolaliaScrollRectAnimation
