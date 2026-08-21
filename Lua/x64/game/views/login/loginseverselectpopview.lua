local var_0_0 = class("LoginSeverSelectPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/LoginInterface/LoginInterfaceServerPopUI"
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

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, LoginSeverSelectPopItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_backBtn, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnTop(arg_7_0)
	return
end

function var_0_0.OnEnter(arg_8_0)
	local var_8_0 = RegionServerMgr.instance:GetRegionServerInfoList()
	local var_8_1 = var_8_0.Count

	arg_8_0.server_data_list = {}

	for iter_8_0 = 0, var_8_1 - 1 do
		local var_8_2 = var_8_0[iter_8_0]
		local var_8_3 = {
			serverName = var_8_2.serverName,
			maintain = var_8_2.maintain,
			newServerFlag = var_8_2.newServerFlag,
			serverId = var_8_2.serverId
		}
		local var_8_4 = var_8_2.gameUserInfoList

		if var_8_4.Count > 0 then
			local var_8_5 = var_8_4[0]

			var_8_3.player = {
				nickName = var_8_5.nickName,
				currentLevel = var_8_5.currentLevel,
				uid = var_8_5.uid,
				lastLoginTime = var_8_5.lastLoginTime
			}
		end

		table.insert(arg_8_0.server_data_list, var_8_3)
	end

	arg_8_0.list:StartScroll(#arg_8_0.server_data_list)
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.server_data_list[arg_10_1]

	arg_10_2:SetData(var_10_0)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.list:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
