local MomoTalkCharactorListItem = class("MomoTalkCharactorListItem", ReduxView)

function MomoTalkCharactorListItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function MomoTalkCharactorListItem:InitUI()
	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = self.controllerEx_:GetController("select")

	self:InitNoticeColor()
end

function MomoTalkCharactorListItem:AddListeners()
	self:AddBtnListener(self.itemBtn_, nil, function()
		if self.isSelected_ then
			self:SetSelected(false)
			manager.notify:Invoke(MOMOTALK_BACK_TO_LIST)

			return
		end

		self:SetSelected(true)
		manager.notify:Invoke(MOMOTALK_OPEN_CHAT, self.senderID_, self.sessionID_)
	end)
end

function MomoTalkCharactorListItem:SetData(arg_5_1, arg_5_2)
	self.senderID_ = arg_5_1.sender_id

	local var_5_0 = MomoTalkTools.GetDisplaySession(arg_5_1.chat_Data, self.senderID_)

	if var_5_0 then
		self.sessionID_ = var_5_0.id or 0
	end

	self.isSelected_ = self.senderID_ == arg_5_2

	self:RefreshUI(arg_5_1, var_5_0)
end

function MomoTalkCharactorListItem:RefreshUI(arg_6_1, arg_6_2)
	if self.headIcon_ and ChatHeroCfg[arg_6_1.sender_id] then
		self.headIcon_.sprite = MomoTalkTools.GetHeroIcon(ChatHeroCfg[arg_6_1.sender_id].icon)
	end

	if self.nameText_ and ChatHeroCfg[arg_6_1.sender_id] then
		self.nameText_.text = GetI18NText(ChatHeroCfg[arg_6_1.sender_id].name)
	end

	if self.descText_ then
		self.descText_.text = self:GetSessionLastPreview(arg_6_2)
	end

	self:SetSelected(self.isSelected_)

	local var_6_0, var_6_1 = self:GetUnreadCounts(arg_6_1.chat_Data)

	if self.redDotGo_ then
		SetActive(self.redDotGo_, var_6_0 > 0 or var_6_1 > 0)
		self:RefreshUnreadCount(var_6_0 > 0 and var_6_0 or var_6_1, var_6_0 == 0 and var_6_1 > 0)
	end
end

function MomoTalkCharactorListItem:GetUnreadCounts(arg_7_1)
	local var_7_0 = 0
	local var_7_1 = 0

	for iter_7_0, iter_7_1 in pairs(arg_7_1 or {}) do
		if MomoTalkData:IsActiveUnreadSession(iter_7_1, iter_7_0) then
			var_7_0 = var_7_0 + 1
		elseif MomoTalkData:IsNoRemindSession(iter_7_1, iter_7_0) then
			var_7_1 = var_7_1 + 1
		end
	end

	return var_7_0, var_7_1
end

function MomoTalkCharactorListItem:GetSessionLastPreview(arg_8_1)
	local var_8_0 = MomoTalkTools.GetSessionPreviewContent(arg_8_1)

	if var_8_0 and var_8_0 ~= "" then
		return var_8_0
	end

	return ""
end

function MomoTalkCharactorListItem:GetSessionDisplayList(arg_9_1)
	if not arg_9_1.save_list then
		arg_9_1 = clone(arg_9_1)
		arg_9_1.save_list = {}
	end

	return MomoTalkTools.GetListDataByMessAge(arg_9_1) or {}
end

function MomoTalkCharactorListItem:GetLastShownItem(arg_10_1, arg_10_2)
	return arg_10_1[MomoTalkTools.GetShownCountBySessionProgress(arg_10_1, arg_10_2)]
end

function MomoTalkCharactorListItem:InitNoticeColor()
	if self.redDotGo_ then
		self.redDotImg_ = self.redDotGo_:GetComponent(typeof(Image))

		if self.redDotImg_ then
			self.redDotDefaultColor_ = self.redDotImg_.color
		end
	end

	if self.unReadNumText_ then
		self.unReadNumDefaultColor_ = self.unReadNumText_.color
	end

	self.noRemindColor_ = Color.New(0.55, 0.55, 0.55, 1)
end

function MomoTalkCharactorListItem:RefreshUnreadCount(arg_12_1, arg_12_2)
	if arg_12_2 then
		local var_12_0 = self.noRemindColor_ or nil

		if self.redDotImg_ then
			self.redDotImg_.color = var_12_0 or self.redDotDefaultColor_
		end

		if self.unReadNumText_ then
			self.unReadNumText_.color = var_12_0 or self.unReadNumDefaultColor_
			self.unReadNumText_.text = arg_12_1 > 0 and tostring(arg_12_1) or ""
		end
	end
end

function MomoTalkCharactorListItem:SetSelected(arg_13_1)
	self.isSelected_ = arg_13_1

	if self.selectController_ then
		self.selectController_:SetSelectedState(arg_13_1 and "state1" or "state0")
	end
end

function MomoTalkCharactorListItem:Show(arg_14_1)
	SetActive(self.gameObject_, arg_14_1)
end

function MomoTalkCharactorListItem:Dispose()
	self:RemoveAllListeners()
	MomoTalkCharactorListItem.super.Dispose(self)
end

return MomoTalkCharactorListItem
