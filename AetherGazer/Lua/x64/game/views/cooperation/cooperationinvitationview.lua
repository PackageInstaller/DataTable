local var_0_0 = class("CooperationInvitationView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Formation/Cooperation/CooperationSendInvitePopUI"
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

	arg_4_0.toggles_ = {
		arg_4_0.friendToggle_,
		arg_4_0.guildToggle_,
		arg_4_0.nearToggle_
	}
	arg_4_0.typeList_ = {
		CooperationConst.INVITE_TYPE.FRIEND,
		CooperationConst.INVITE_TYPE.GUILD,
		CooperationConst.INVITE_TYPE.RECENT
	}
	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, CooperationInvitationItem)
end

function var_0_0.AddUIListener(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.toggles_) do
		arg_5_0:AddToggleListener(iter_5_1, function(arg_6_0)
			if arg_6_0 then
				local var_6_0 = table.indexof(arg_5_0.toggles_, iter_5_1)

				arg_5_0:SelectGroup(var_6_0)
			end
		end)
	end

	arg_5_0:AddBtnListener(nil, arg_5_0.maskBtn_, function()
		arg_5_0:Back()
	end)
end

function var_0_0.SelectGroup(arg_8_0, arg_8_1)
	arg_8_0.curType_ = arg_8_0.typeList_[arg_8_1]
	arg_8_0.curPlayerList_ = arg_8_0.inviteData_[arg_8_0.curType_] or {}

	table.sort(arg_8_0.curPlayerList_, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_8_0:GetPlayerStatus(arg_9_0)
		local var_9_1 = arg_8_0:GetPlayerStatus(arg_9_1)

		if var_9_0 ~= var_9_1 then
			return var_9_0 < var_9_1
		end

		return arg_9_0.uid < arg_9_1.uid
	end)
	arg_8_0.list:StartScroll(#arg_8_0.curPlayerList_)
end

function var_0_0.GetPlayerStatus(arg_10_0, arg_10_1)
	if CooperationData:GetHadInvited(arg_10_1.uid) then
		return 3
	elseif not CooperationTools.IsInvitationValid(arg_10_0.activityId_, arg_10_1.uid, arg_10_1.activity_data_list) then
		return 2
	end

	return 1
end

function var_0_0.OnTop(arg_11_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.activityId_ = CooperationData:GetRoomData().activity_id

	CooperationData:ClearHadInvited()

	local var_12_0 = GuildData:GetGuildInfo()

	if var_12_0 ~= nil and var_12_0.id ~= nil then
		SetActive(arg_12_0.guildToggle_.gameObject, true)
		CooperationAction.RequestInviteList(arg_12_0.typeList_)
	else
		SetActive(arg_12_0.guildToggle_.gameObject, false)
		CooperationAction.RequestInviteList({
			CooperationConst.INVITE_TYPE.FRIEND,
			CooperationConst.INVITE_TYPE.RECENT
		})
	end
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnCooperationInviteListUpdate(arg_14_0, arg_14_1)
	arg_14_0.inviteData_ = arg_14_1

	arg_14_0:SelectGroup(1)

	arg_14_0.toggles_[1].isOn = true
end

function var_0_0.IndexItem(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2:SetData(arg_15_1, arg_15_0.curType_, arg_15_0.curPlayerList_[arg_15_1])
end

function var_0_0.Dispose(arg_16_0)
	if arg_16_0.list then
		arg_16_0.list:Dispose()

		arg_16_0.list = nil
	end

	var_0_0.super.Dispose(arg_16_0)
end

function var_0_0.OnCooperationInviteSuccess(arg_17_0)
	local var_17_0 = arg_17_0.list:GetItemList()

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		iter_17_1:UpdateState()
	end
end

return var_0_0
