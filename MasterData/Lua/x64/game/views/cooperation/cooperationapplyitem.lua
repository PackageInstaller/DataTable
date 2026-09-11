local CooperationApplyItem = class("CooperationApplyItem", ReduxView)

function CooperationApplyItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CooperationApplyItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CooperationApplyItem:InitUI()
	self:BindCfgUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.stateController_ = self.controlerEx_:GetController("state")
	self.onlineController_ = ControllerUtil.GetController(self.transform_, "online")
end

function CooperationApplyItem:AddUIListener()
	self:AddBtnListener(nil, self.agreeBtn_, function()
		CooperationAction.ReceiveInvite(self.uid)
	end)
	self:AddBtnListener(nil, self.refuseBtn_, function()
		CooperationAction.DelectInvite({
			self.uid
		})
	end)
end

function CooperationApplyItem:SetData(arg_7_1)
	self.data = arg_7_1
	self.dest = arg_7_1.dest
	self.uid = arg_7_1.uid
	self.room_id = arg_7_1.room_id
	self.nameText_.text = GetI18NText(arg_7_1.nick)

	self.commonPortrait_:RenderHead(arg_7_1.icon)
	self.commonPortrait_:RenderFrame(arg_7_1.icon_frame)

	self.chatText_.text = CooperationTools.GetCooperationRoomName(arg_7_1.battle_type, arg_7_1.dest, arg_7_1.activity_id)

	local var_7_0 = arg_7_1.timestamp or 0

	if var_7_0 == 0 then
		self.onlineController_:SetSelectedIndex(0)
	else
		self.offlineText_.text = manager.time:GetOnLineText(var_7_0)

		self.onlineController_:SetSelectedIndex(1)
	end

	self:UpdateState()
end

function CooperationApplyItem:GetOnLineText(arg_8_1)
	if arg_8_1 == 0 then
		return GetTips("ONLINE")
	end

	local var_8_0 = manager.time:GetServerTime() - arg_8_1

	if var_8_0 < 60 then
		return GetTips("FRIEND_ONLINE_TIME_ONE_MINUTE")
	elseif var_8_0 < 300 then
		return GetTips("FRIEND_ONLINE_TIME_FIVE_MINUTE")
	elseif var_8_0 < 3600 then
		return GetTips("FRIEND_ONLINE_TIME_WITHIN_AN_HOUR")
	elseif var_8_0 < 86400 then
		return GetTips("FRIEND_ONLINE_TIME_IN_ONE_DAY")
	elseif var_8_0 < 2592000 then
		return string.format(GetTips("FRIEND_ONLINE_TIME_ONE_DAY_AGO"), math.floor(var_8_0 / 86400))
	else
		return string.format(GetTips("FRIEND_ONLINE_TIME_ONE_DAY_AGO"), 30)
	end
end

function CooperationApplyItem:UpdateState()
	self.stateController_:SetSelectedIndex(self.data.refuse and 1 or 0)
end

function CooperationApplyItem:Dispose()
	self.commonPortrait_:Dispose()
	CooperationApplyItem.super.Dispose(self)
end

return CooperationApplyItem
