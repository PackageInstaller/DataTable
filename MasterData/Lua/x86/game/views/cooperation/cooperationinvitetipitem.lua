local CooperationInviteTipItem = class("CooperationInviteTipItem", ReduxView)

function CooperationInviteTipItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CooperationInviteTipItem:Init()
	self:InitUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddUIListener()
end

function CooperationInviteTipItem:InitUI()
	self:BindCfgUI()

	self.isShow = false

	SetActive(self.gameObject_, false)
end

function CooperationInviteTipItem:AddUIListener()
	self:AddBtnListener(nil, self.m_okBtn, function()
		if self.inviteTip then
			CooperationAction.ReceiveInvite(self.inviteTip.invite.uid)
		end

		CooperationData:ClearNewInviteTip()
		self:Hide()
		manager.redPoint:setTip(RedPointConst.COOPERATION_INVIT, 0)
	end)
	self:AddBtnListener(nil, self.m_cancelBtn, function()
		if self.inviteTip then
			CooperationAction.DelectInvite({
				self.inviteTip.invite.uid
			})
		end

		CooperationData:ClearNewInviteTip()
		self:HideInvite()
		manager.redPoint:setTip(RedPointConst.COOPERATION_INVIT, 0)
	end)
end

function CooperationInviteTipItem:Show()
	if not self.isShow then
		self:RegistEventListener(COOPERATION_NEW_INVITE, function()
			self:Check()
		end)

		self.isShow = true
	end

	self:Check()
end

function CooperationInviteTipItem:Hide()
	if self.isShow then
		self:RemoveAllEventListener()

		self.isShow = false
	end

	self:HideInvite()
end

function CooperationInviteTipItem:HideInvite()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	SetActive(self.gameObject_, false)
end

function CooperationInviteTipItem:Check()
	if manager.guide:IsPlaying() then
		self:HideInvite()

		return
	end

	self.inviteTip = CooperationData:GetNewInviteTip()

	local var_11_0 = manager.time:GetServerTime()

	if not self.inviteTip or var_11_0 > self.inviteTip.overdue_time then
		self:HideInvite()

		return
	end

	local var_11_1 = self.inviteTip.invite

	self.m_name.text = self.inviteTip.invite.nick

	self.commonPortrait_:RenderHead(var_11_1.icon)
	self.commonPortrait_:RenderFrame(var_11_1.icon_frame)

	self.m_des.text = self.inviteTip.overdue_time - var_11_0

	SetActive(self.gameObject_, true)

	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:Process()
		end, 1, -1)
	end

	self.timer_:Start()
	self:Process()
end

function CooperationInviteTipItem:Process()
	local var_13_0 = manager.time:GetServerTime()

	if not self.inviteTip or var_13_0 > self.inviteTip.overdue_time then
		self:HideInvite()

		return
	end

	self.m_des.text = string.format(GetTips("ACTIVITY_STRONGHOLD_INVITED"), self.inviteTip.overdue_time - var_13_0)
end

function CooperationInviteTipItem:Dispose()
	self.commonPortrait_:Dispose()

	self.commonPortrait_ = nil

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self:RemoveAllEventListener()

	self.isShow = false

	CooperationInviteTipItem.super.Dispose(self)
end

return CooperationInviteTipItem
