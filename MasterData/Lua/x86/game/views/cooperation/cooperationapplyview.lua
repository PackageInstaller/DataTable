local CooperationApplyView = class("CooperationApplyView", ReduxView)

function CooperationApplyView:UIName()
	return "Widget/System/Formation/Cooperation/CooperationInvitePopUI"
end

function CooperationApplyView:UIParent()
	return manager.ui.uiPop.transform
end

function CooperationApplyView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CooperationApplyView:InitUI()
	self:BindCfgUI()

	self.friendController_ = self.controllerExCollection_:GetController("friend")
	self.guildController_ = self.controllerExCollection_:GetController("guild")
	self.nearController_ = self.controllerExCollection_:GetController("near")
	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, CooperationApplyItem)
end

function CooperationApplyView:AddUIListener()
	self:AddBtnListener(nil, self.friendBtn_, function()
		local var_6_0 = not CooperationData:GetInviteVisible(1)

		CooperationData:SetInviteVisible(1, var_6_0)
		self.friendController_:SetSelectedIndex(var_6_0 and 0 or 1)
		self:RefreshUI()
	end)
	self:AddBtnListener(nil, self.guildBtn_, function()
		local var_7_0 = not CooperationData:GetInviteVisible(2)

		CooperationData:SetInviteVisible(2, var_7_0)
		self.guildController_:SetSelectedIndex(var_7_0 and 0 or 1)
		self:RefreshUI()
	end)
	self:AddBtnListener(nil, self.nearBtn_, function()
		local var_8_0 = not CooperationData:GetInviteVisible(3)

		CooperationData:SetInviteVisible(3, var_8_0)
		self.nearController_:SetSelectedIndex(var_8_0 and 0 or 1)
		self:RefreshUI()
	end)
	self:AddBtnListener(nil, self.maskBtn_, function()
		self:Back()
	end)
	self:AddBtnListener(nil, self.refreshBtn_, function()
		self:RefreshUI()
	end)
	self:AddBtnListener(nil, self.clearBtn_, function()
		CooperationAction.ClearInvite()
	end)
	self:AddBtnListener(nil, self.searchBtn_, function()
		JumpTools.GoToSystem("cooperationSearchRoom")
	end)
end

function CooperationApplyView:OnTop()
	manager.windowBar:SwitchBar({})
end

function CooperationApplyView:OnEnter()
	self.room_type = self.params_.room_type

	self:RefreshInviteVisible()
	self:RefreshUI()
end

function CooperationApplyView:OnExit()
	manager.windowBar:HideBar()
end

function CooperationApplyView:RefreshInviteVisible()
	self.friendController_:SetSelectedIndex(CooperationData:GetInviteVisible(1) and 1 or 0)
	self.guildController_:SetSelectedIndex(CooperationData:GetInviteVisible(2) and 1 or 0)
	self.nearController_:SetSelectedIndex(CooperationData:GetInviteVisible(3) and 1 or 0)
end

function CooperationApplyView:RefreshUI()
	manager.redPoint:setTip(RedPointConst.COOPERATION_INVIT, 0)

	local var_17_0 = {}

	for iter_17_0 = 1, 3 do
		if CooperationData:GetInviteVisible(iter_17_0) then
			table.insert(var_17_0, iter_17_0)
		end
	end

	self.data = CooperationData:GetInviteList(var_17_0)

	self.list_:StartScrollWithoutAnimator(#self.data)
end

function CooperationApplyView:IndexItem(arg_18_1, arg_18_2)
	arg_18_2:SetData(self.data[arg_18_1])
end

function CooperationApplyView:Dispose()
	self.list_:Dispose()
	CooperationApplyView.super.Dispose(self)
end

function CooperationApplyView:OnCooperationInviteRefuse(arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(self.data) do
		if iter_20_1.uid == arg_20_1[1] then
			table.remove(self.data, iter_20_0)
			self.list_:StartScrollByPosition(#self.data, self.list_:GetScrolledPosition())

			break
		end
	end
end

function CooperationApplyView:OnCooperationInviteClear()
	self:RefreshUI()
end

function CooperationApplyView:OnCooperationInviteReceive()
	local var_22_0 = {}

	for iter_22_0 = 1, 3 do
		if CooperationData:GetInviteVisible(iter_22_0) then
			table.insert(var_22_0, iter_22_0)
		end
	end

	self.data = CooperationData:GetInviteList(var_22_0)

	self.list_:StartScrollWithoutAnimator(#self.data, (self.list_:GetScrolledPosition()))
end

return CooperationApplyView
