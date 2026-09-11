local CooperationInvitationView = class("CooperationInvitationView", ReduxView)

function CooperationInvitationView:UIName()
	return "Widget/System/Formation/Cooperation/CooperationSendInvitePopUI"
end

function CooperationInvitationView:UIParent()
	return manager.ui.uiPop.transform
end

function CooperationInvitationView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CooperationInvitationView:InitUI()
	self:BindCfgUI()

	self.toggles_ = {
		self.friendToggle_,
		self.guildToggle_,
		self.nearToggle_
	}
	self.typeList_ = {
		CooperationConst.INVITE_TYPE.FRIEND,
		CooperationConst.INVITE_TYPE.GUILD,
		CooperationConst.INVITE_TYPE.RECENT
	}
	self.list = LuaList.New(handler(self, self.IndexItem), self.listGo_, CooperationInvitationItem)
end

function CooperationInvitationView:AddUIListener()
	for iter_5_0, iter_5_1 in ipairs(self.toggles_) do
		self:AddToggleListener(iter_5_1, function(arg_6_0)
			if arg_6_0 then
				self:SelectGroup((table.indexof(self.toggles_, iter_5_1)))
			end
		end)
	end

	self:AddBtnListener(nil, self.maskBtn_, function()
		self:Back()
	end)
end

function CooperationInvitationView:SelectGroup(arg_8_1)
	self.curType_ = self.typeList_[arg_8_1]
	self.curPlayerList_ = self.inviteData_[self.curType_] or {}

	table.sort(self.curPlayerList_, function(arg_9_0, arg_9_1)
		local var_9_0 = self:GetPlayerStatus(arg_9_0)
		local var_9_1 = self:GetPlayerStatus(arg_9_1)

		if var_9_0 ~= var_9_1 then
			return var_9_0 < var_9_1
		end

		return arg_9_0.uid < arg_9_1.uid
	end)
	self.list:StartScroll(#self.curPlayerList_)
end

function CooperationInvitationView:GetPlayerStatus(arg_10_1)
	if CooperationData:GetHadInvited(arg_10_1.uid) then
		return 3
	elseif not CooperationTools.IsInvitationValid(self.activityId_, arg_10_1.uid, arg_10_1.activity_data_list) then
		return 2
	end

	return 1
end

function CooperationInvitationView:OnTop()
	manager.windowBar:SwitchBar({})
end

function CooperationInvitationView:OnEnter()
	self.activityId_ = CooperationData:GetRoomData().activity_id

	CooperationData:ClearHadInvited()

	local var_12_0 = GuildData:GetGuildInfo()

	if var_12_0 ~= nil and var_12_0.id ~= nil then
		SetActive(self.guildToggle_.gameObject, true)
		CooperationAction.RequestInviteList(self.typeList_)
	else
		SetActive(self.guildToggle_.gameObject, false)
		CooperationAction.RequestInviteList({
			CooperationConst.INVITE_TYPE.FRIEND,
			CooperationConst.INVITE_TYPE.RECENT
		})
	end
end

function CooperationInvitationView:OnExit()
	manager.windowBar:HideBar()
end

function CooperationInvitationView:OnCooperationInviteListUpdate(arg_14_1)
	self.inviteData_ = arg_14_1

	self:SelectGroup(1)

	self.toggles_[1].isOn = true
end

function CooperationInvitationView:IndexItem(arg_15_1, arg_15_2)
	arg_15_2:SetData(arg_15_1, self.curType_, self.curPlayerList_[arg_15_1])
end

function CooperationInvitationView:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	CooperationInvitationView.super.Dispose(self)
end

function CooperationInvitationView:OnCooperationInviteSuccess()
	for iter_17_0, iter_17_1 in pairs((self.list:GetItemList())) do
		iter_17_1:UpdateState()
	end
end

return CooperationInvitationView
