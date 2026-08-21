local var_0_0 = class("CooperationApplyView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Formation/Cooperation/CooperationInvitePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.friendController_ = arg_4_0.controllerExCollection_:GetController("friend")
	arg_4_0.guildController_ = arg_4_0.controllerExCollection_:GetController("guild")
	arg_4_0.nearController_ = arg_4_0.controllerExCollection_:GetController("near")
	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, CooperationApplyItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(nil, arg_5_0.friendBtn_, function()
		local var_6_0 = not CooperationData:GetInviteVisible(1)

		CooperationData:SetInviteVisible(1, var_6_0)
		arg_5_0.friendController_:SetSelectedIndex(var_6_0 and 0 or 1)
		arg_5_0:RefreshUI()
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.guildBtn_, function()
		local var_7_0 = not CooperationData:GetInviteVisible(2)

		CooperationData:SetInviteVisible(2, var_7_0)
		arg_5_0.guildController_:SetSelectedIndex(var_7_0 and 0 or 1)
		arg_5_0:RefreshUI()
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.nearBtn_, function()
		local var_8_0 = not CooperationData:GetInviteVisible(3)

		CooperationData:SetInviteVisible(3, var_8_0)
		arg_5_0.nearController_:SetSelectedIndex(var_8_0 and 0 or 1)
		arg_5_0:RefreshUI()
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.maskBtn_, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.refreshBtn_, function()
		arg_5_0:RefreshUI()
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.clearBtn_, function()
		CooperationAction.ClearInvite()
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.searchBtn_, function()
		JumpTools.GoToSystem("cooperationSearchRoom")
	end)
end

function var_0_0.OnTop(arg_13_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.room_type = arg_14_0.params_.room_type

	arg_14_0:RefreshInviteVisible()
	arg_14_0:RefreshUI()
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()
end

function var_0_0.RefreshInviteVisible(arg_16_0)
	arg_16_0.friendController_:SetSelectedIndex(CooperationData:GetInviteVisible(1) and 1 or 0)
	arg_16_0.guildController_:SetSelectedIndex(CooperationData:GetInviteVisible(2) and 1 or 0)
	arg_16_0.nearController_:SetSelectedIndex(CooperationData:GetInviteVisible(3) and 1 or 0)
end

function var_0_0.RefreshUI(arg_17_0)
	manager.redPoint:setTip(RedPointConst.COOPERATION_INVIT, 0)

	local var_17_0 = {}

	for iter_17_0 = 1, 3 do
		if CooperationData:GetInviteVisible(iter_17_0) then
			table.insert(var_17_0, iter_17_0)
		end
	end

	arg_17_0.data = CooperationData:GetInviteList(var_17_0)

	arg_17_0.list_:StartScrollWithoutAnimator(#arg_17_0.data)
end

function var_0_0.IndexItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.data[arg_18_1]

	arg_18_2:SetData(var_18_0)
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0.list_:Dispose()
	var_0_0.super.Dispose(arg_19_0)
end

function var_0_0.OnCooperationInviteRefuse(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1[1]

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.data) do
		if iter_20_1.uid == var_20_0 then
			table.remove(arg_20_0.data, iter_20_0)
			arg_20_0.list_:StartScrollByPosition(#arg_20_0.data, arg_20_0.list_:GetScrolledPosition())

			break
		end
	end
end

function var_0_0.OnCooperationInviteClear(arg_21_0)
	arg_21_0:RefreshUI()
end

function var_0_0.OnCooperationInviteReceive(arg_22_0)
	local var_22_0 = {}

	for iter_22_0 = 1, 3 do
		if CooperationData:GetInviteVisible(iter_22_0) then
			table.insert(var_22_0, iter_22_0)
		end
	end

	arg_22_0.data = CooperationData:GetInviteList(var_22_0)

	local var_22_1 = arg_22_0.list_:GetScrolledPosition()

	arg_22_0.list_:StartScrollWithoutAnimator(#arg_22_0.data, var_22_1)
end

return var_0_0
