local CooperationInvitationItem = class("CooperationInvitationItem", ReduxView)

function CooperationInvitationItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CooperationInvitationItem:Init()
	self:InitUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddUIListener()

	self.stateController_ = self.controlerEx_:GetController("state")
	self.onlineController_ = ControllerUtil.GetController(self.transform_, "online")
end

function CooperationInvitationItem:InitUI()
	self:BindCfgUI()
end

function CooperationInvitationItem:AddUIListener()
	self:AddBtnListener(nil, self.invitBtn_, function()
		local var_5_0 = CooperationData:GetRoomData()

		if var_5_0:IsFull() then
			ShowTips("COOPERATION_NO_ALLOW_INVITE_FULL")

			return
		end

		if not CooperationTools.IsInvitationValid(var_5_0.activity_id, self.uid, self.playerData_.activity_data_list) then
			return
		end

		CooperationAction.InvitePlayer(self.uid, self.type)
	end)
end

function CooperationInvitationItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.index_ = arg_6_1
	self.type = arg_6_2
	self.playerData_ = arg_6_3
	self.nameText_.text = arg_6_3.nick

	local var_6_0

	if arg_6_3.icon_frame ~= 0 then
		var_6_0 = arg_6_3.icon_frame or 2001
	end

	self.commonPortrait_:RenderHead(arg_6_3.icon)
	self.commonPortrait_:RenderFrame(var_6_0)

	local var_6_1 = arg_6_3.timestamp or 0

	self.uid = arg_6_3.uid

	if var_6_1 == 0 then
		self.onlineController_:SetSelectedIndex(0)
	else
		self.offlineText_.text = manager.time:GetOnLineText(var_6_1)

		self.onlineController_:SetSelectedIndex(1)
	end

	self:UpdateState()
end

function CooperationInvitationItem:UpdateState()
	if CooperationData:GetHadInvited(self.uid) then
		self.stateController_:SetSelectedIndex(1)
	elseif not CooperationTools.IsInvitationValid(CooperationData:GetRoomData().activity_id, self.uid, self.playerData_.activity_data_list) then
		self.stateController_:SetSelectedIndex(2)
	else
		self.stateController_:SetSelectedIndex(0)
	end
end

function CooperationInvitationItem:Dispose()
	self.commonPortrait_:Dispose()
	CooperationInvitationItem.super.Dispose(self)
end

return CooperationInvitationItem
