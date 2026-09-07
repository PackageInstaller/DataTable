local BgStoryPlayer = class("BgStoryPlayer", import(".DialogueStoryPlayer"))

function BgStoryPlayer:Ctor(arg_1_1)
	BgStoryPlayer.super.Ctor(self, arg_1_1)

	self.subImage = self.bgPanel:Find("sub"):GetComponent(typeof(Image))

	setActive(self.subImage.gameObject, false)

	self.bgRecord = nil

	return
end

function BgStoryPlayer:Reset(arg_2_1, arg_2_2, arg_2_3)
	BgStoryPlayer.super.super.Reset(self, arg_2_1, arg_2_2, arg_2_3)
	setActive(self.bgPanel, true)
	setActive(self.subImage.gameObject, false)
	setActive(self.actorPanel, false)
	self:RecyclePainting({
		"actorLeft",
		"actorMiddle",
		"actorRgiht"
	})

	return
end

function BgStoryPlayer:OnBgUpdate(arg_3_1)
	local var_3_0 = arg_3_1:GetBgName()

	if self.bgRecord ~= var_3_0 then
		self.bgRecord = var_3_0

		self:TweenValueForcanvasGroup(self.bgPanelCg, 0, 1, arg_3_1:GetFadeSpeed(), 0, nil)
	end

	return
end

function BgStoryPlayer:UpdateBg(arg_4_1)
	local var_4_0 = arg_4_1:GetSubBg()

	if var_4_0 then
		setActive(self.subImage.gameObject, true)

		local var_4_1 = self:GetBg(var_4_0)

		if var_4_1 then
			self.subImage.sprite = var_4_1

			originalPrint("story sub bg load : " .. tostring(var_4_0))
		else
			warning("story sub bg load faild : " .. tostring(var_4_0))
		end
	else
		setActive(self.subImage.gameObject, false)
	end

	if not arg_4_1:GetBgName() then
		return
	end

	BgStoryPlayer.super.UpdateBg(self, arg_4_1)

	return
end

function BgStoryPlayer:OnInit(arg_5_1, arg_5_2, arg_5_3)
	if arg_5_1:ShouldBlackScreen() then
		setActive(self.curtain, true)
		self.curtain:SetAsLastSibling()
		arg_5_3()
	else
		BgStoryPlayer.super.OnInit(self, arg_5_1, arg_5_2, arg_5_3)
	end

	return
end

function BgStoryPlayer:OnEnter(arg_6_1, arg_6_2, arg_6_3)
	if arg_6_1:ShouldBlackScreen() then
		self:DelayCall(arg_6_1:ShouldBlackScreen(), function()
			setActive(self.curtain, true)
			self.curtain:SetAsFirstSibling()
			assert(not arg_6_1:ExistOption())
			arg_6_3()
			triggerButton(self._go)

			return
		end)
	else
		local var_6_0 = arg_6_1:GetUnscaleDelay()

		if self.autoNext then
			var_6_0 = var_6_0 - self.script:GetTriggerDelayTime()
		end

		self:UnscaleDelayCall(var_6_0, function()
			BgStoryPlayer.super.OnEnter(self, arg_6_1, arg_6_2, arg_6_3)

			return
		end)
	end

	return
end

function BgStoryPlayer:GetSideTF(arg_9_1)
	local var_9_0
	local var_9_1
	local var_9_2
	local var_9_3

	if DialogueStep.SIDE_LEFT == arg_9_1 then
		var_9_3 = nil
		var_9_2 = self.nameLeftTxt
		var_9_1 = self.nameLeft
		var_9_0 = nil
	elseif DialogueStep.SIDE_RIGHT == arg_9_1 then
		var_9_3 = nil
		var_9_2 = self.nameRightTxt
		var_9_1 = self.nameRight
		var_9_0 = nil
	elseif DialogueStep.SIDE_MIDDLE == arg_9_1 then
		var_9_3 = nil
		var_9_2 = self.nameLeftTxt
		var_9_1 = self.nameLeft
		var_9_0 = nil
	end

	return var_9_0, var_9_1, var_9_2, var_9_3
end

function BgStoryPlayer:Clear(arg_10_1)
	self.bgs = {}
	self.goCG.alpha = 1
	self.callback = nil
	self.autoNext = nil
	self.script = nil
	self.subImage.sprite = nil

	self:OnClear()

	if arg_10_1 then
		arg_10_1()
	end

	pg.DelegateInfo.New(self)

	return
end

function BgStoryPlayer:StoryEnd()
	BgStoryPlayer.super.StoryEnd(self)

	self.bgRecord = nil
	self.bgImage.sprite = nil

	return
end

return BgStoryPlayer
