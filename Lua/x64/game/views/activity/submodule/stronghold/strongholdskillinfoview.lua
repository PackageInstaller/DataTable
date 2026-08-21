local var_0_0 = class("StrongholdSkillInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/Stronghold/StrongholdPopupUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, StrongholdSkillInfoItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_mask, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_8_0)
	local var_8_0 = CooperationData:GetRoomData().room_id

	arg_8_0.skillTypes = StrongholdData:GetRoomSkillTypes(var_8_0)
	arg_8_0.skillTypes_key = {
		1,
		2,
		3
	}

	arg_8_0.list:StartScroll(#arg_8_0.skillTypes_key)
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.list:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.skillTypes_key[arg_11_1]
	local var_11_1 = arg_11_0.skillTypes[var_11_0] or 0

	arg_11_2:SetData(var_11_0, var_11_1)
end

return var_0_0
