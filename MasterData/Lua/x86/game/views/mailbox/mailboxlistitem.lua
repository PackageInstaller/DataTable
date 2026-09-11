local MailBoxListItem = class("MailBoxListItem", ReduxView)

function MailBoxListItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MailBoxListItem:Init()
	self:InitUI()
	self:AddUIListener()
	self:AddEventListener()
end

function MailBoxListItem:InitUI()
	self:BindCfgUI()

	self.starController_ = self.conExCollection_:GetController("star")
	self.readController_ = self.conExCollection_:GetController("read")
	self.rewardController_ = self.conExCollection_:GetController("reward")
	self.selectController_ = self.conExCollection_:GetController("select")
	self.typeController_ = self.conExCollection_:GetController("type")
end

function MailBoxListItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.onClickHandler_ ~= nil then
			self:onClickHandler_()
		end
	end)
end

function MailBoxListItem:AddEventListener()
	self:RegistEventListener(MAIL_INFO_UPDATE, handler(self, self.OnMailInfoUpdate))
	self:RegistEventListener(MAIL_STAR_UPDATE, handler(self, self.OnMailStarUpdate))
end

function MailBoxListItem:OnMailInfoUpdate(arg_7_1)
	if arg_7_1.id == self.data_.id then
		self:UpdateView()
	end
end

function MailBoxListItem:OnMailStarUpdate(arg_8_1)
	if arg_8_1.id == self.data_.id then
		self:UpdateStar()
	end
end

function MailBoxListItem:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function MailBoxListItem:SetMailData(arg_10_1, arg_10_2)
	self.data_ = arg_10_1
	self.mailType = arg_10_2
end

function MailBoxListItem:SetClickHandler(arg_11_1)
	self.onClickHandler_ = arg_11_1
end

function MailBoxListItem:UpdateView()
	if (self.mailType == MailData.mailType.normal and MailData.GetMail(self.data_.id) or MailData.GetCollectMail(self.data_.id)) == nil then
		return
	end

	self.nameText_.text = utf8.sub(MailData.GetMailTitle(self.data_.id, self.mailType), 1, GameSetting.admin_mail_title_max_len.value[1] + 1)

	local var_12_1 = self.data_.attach_flag and self.data_.attach_flag > 0

	self.rewardController_:SetSelectedState(var_12_1 and "true" or "false")

	if self.data_.attach_flag == 2 then
		self.rewardController_:SetSelectedState("false")
	else
		self.rewardController_:SetSelectedState(var_12_1 and "true" or "false")
	end

	self:UpdateRead()
	self:UpdateStar()
	self:UpdateCountdown()
	self.selectController_:SetSelectedState(self.selected_ and "true" or "false")
	self.typeController_:SetSelectedState(self.mailType == MailData.mailType.normal and "normal" or "collect")
end

function MailBoxListItem:UpdateStar()
	if self.data_.star_state == 1 then
		self.starController_:SetSelectedState("true")
	else
		self.starController_:SetSelectedState("false")
	end
end

function MailBoxListItem:UpdateRead()
	if self.mailType == MailData.mailType.collect then
		self.readController_:SetSelectedState("false")
	elseif self.selected_ then
		self.readController_:SetSelectedState("false")
	elseif MailData.HaveMailRead(self.data_.id) then
		self.readController_:SetSelectedState("true")
	else
		self.readController_:SetSelectedState("false")
	end
end

function MailBoxListItem:SetSelected(arg_15_1)
	self.selected_ = arg_15_1
end

function MailBoxListItem:UpdateCountdown()
	if not self.data_.timeout_timestamp then
		return
	end

	self.tipsText_.text = string.format(GetTips("TIME_DISPLAY_5"), (MailTools.GetLostTimeStr(self.data_.timeout_timestamp)))
end

function MailBoxListItem:GetData()
	return self.data_
end

function MailBoxListItem:OnEnter()
	return
end

function MailBoxListItem:OnExit()
	return
end

function MailBoxListItem:Dispose()
	self:RemoveAllListeners()
	self:RemoveAllEventListener()
	MailBoxListItem.super.Dispose(self)
end

return MailBoxListItem
