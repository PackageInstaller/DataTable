local var_0_0 = class("LoginInnerServerView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/LoginInterface/LoginInterfaceInnerServerUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

local var_0_1 = {
	"ALL",
	"内网公共",
	"程序",
	"策划",
	"美术",
	"QA",
	"未分组"
}

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, LoginInnerServerItem)

	for iter_4_0, iter_4_1 in pairs(var_0_1) do
		arg_4_0.m_dropDown.options:Add(UnityEngine.UI.Dropdown.OptionData.New(iter_4_1))
	end

	arg_4_0.m_dropDown:RefreshShownValue()

	arg_4_0.m_dropDown.value = 1
	arg_4_0.m_customport.text = "8102"
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_backBtn, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddToggleListener(arg_5_0.m_dropDown, function(arg_7_0)
		arg_5_0:RefreshList()
	end)
	arg_5_0.m_searchInput.onValueChanged:AddListener(function()
		local var_8_0 = arg_5_0.m_searchInput.text

		if var_8_0 == "" then
			arg_5_0:RefreshList()
		else
			arg_5_0:RefreshSearchList(var_8_0)
		end
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_customBtn, function()
		GATEWAY_ADDR = arg_5_0.m_customIp.text
		GATEWAY_PORT = arg_5_0.m_customport.text

		CheckVersion(function()
			manager.net.gateWayConnection_.netStatus = "none"

			LoginAction.GateWayLogin(PlayerPrefs.GetString("AccountID"), PlayerPrefs.GetString("UserPwd"))
		end)
	end)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.origin_list = arg_11_0.params_.list

	arg_11_0:RefreshList()
end

function var_0_0.RefreshList(arg_12_0)
	local var_12_0 = var_0_1[arg_12_0.m_dropDown.value + 1]

	if var_12_0 == "ALL" then
		arg_12_0.server_list = {}

		for iter_12_0, iter_12_1 in pairs(arg_12_0.origin_list) do
			table.insert(arg_12_0.server_list, iter_12_1)
		end
	else
		arg_12_0.server_list = {}

		for iter_12_2, iter_12_3 in pairs(arg_12_0.origin_list) do
			if iter_12_3.group == var_12_0 then
				table.insert(arg_12_0.server_list, iter_12_3)
			end
		end
	end

	arg_12_0.list:StartScroll(#arg_12_0.server_list)
end

function var_0_0.RefreshSearchList(arg_13_0, arg_13_1)
	arg_13_0.server_list = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_0.origin_list) do
		if string.find(iter_13_1.name, arg_13_1) then
			table.insert(arg_13_0.server_list, iter_13_1)
		end
	end

	arg_13_0.list:StartScroll(#arg_13_0.server_list)
end

function var_0_0.IndexItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.server_list[arg_14_1]

	arg_14_2:SetData(var_14_0)
end

function var_0_0.OnExit(arg_15_0)
	return
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.list:Dispose()
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
