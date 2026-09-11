local IlluHeroActionItem = class("IlluHeroActionItem", ReduxView)

function IlluHeroActionItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function IlluHeroActionItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.playController_ = self.mainControllerEx_:GetController("play")
end

function IlluHeroActionItem:SetData(arg_3_1, arg_3_2, arg_3_3)
	self.id_ = arg_3_2
	self.text_.text = string.format(GetTips("BACKHOME_HERO_ILLU_INTERACT"), arg_3_1)
	self.onClick_ = arg_3_3
end

function IlluHeroActionItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		self.onClick_(self.id_)
	end)
end

function IlluHeroActionItem:SetPlay(arg_6_1)
	self.playController_:SetSelectedState(arg_6_1 and "on" or "off")

	if arg_6_1 then
		self:OnPreviewStart()
	else
		self:OnPreviewEnd()
	end
end

function IlluHeroActionItem:StopTimer()
	self.curDuration = 0

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function IlluHeroActionItem:OnPreviewStart()
	self:StopTimer()

	local var_8_0 = DormCharacterInteractBehaviour.GetSequence(nil, nil, DormInteractSequence[self.id_].name)

	self.progress_.fillAmount = 0
	self.curDuration = var_8_0.duration
	self.timer_ = FrameTimer.New(function()
		self.curDuration = self.curDuration - Time.deltaTime
		self.progress_.fillAmount = 1 - self.curDuration / var_8_0.duration

		if self.curDuration <= 0 then
			self:SetPlay(false)
		end
	end, 1, -1)

	self.timer_:Start()
end

function IlluHeroActionItem:OnPreviewEnd()
	self:StopTimer()

	self.curDuration = 0
	self.progress_.fillAmount = 0
end

function IlluHeroActionItem:Dispose()
	self:StopTimer()

	self.curDuration = 0

	IlluHeroActionItem.super.Dispose(self)
end

return IlluHeroActionItem
