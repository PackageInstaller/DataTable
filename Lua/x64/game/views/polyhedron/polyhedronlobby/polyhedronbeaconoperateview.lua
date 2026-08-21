local var_0_0 = class("PolyhedronBeaconOperateView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Polyhedron/Beacon/PolyhedronBeaconOperateUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, PolyhedronBeaconOperateItem)
end

function var_0_0.OnTop(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:Refresh()
end

function var_0_0.Refresh(arg_7_0)
	arg_7_0.data = PolyhedronBeaconCfg.all

	table.sort(arg_7_0.data, function(arg_8_0, arg_8_1)
		local var_8_0 = PolyhedronData:GetBeaconIsLock(arg_8_0)
		local var_8_1 = PolyhedronData:GetBeaconIsLock(arg_8_1)

		if var_8_0 == var_8_1 then
			local var_8_2 = PolyhedronTools.GetBeaconIsUnlockCondition(arg_8_0)

			if var_8_2 == PolyhedronTools.GetBeaconIsUnlockCondition(arg_8_1) then
				return arg_8_0 < arg_8_1
			else
				return var_8_2
			end
		else
			return var_8_1
		end
	end)
	arg_7_0.list_:StartScroll(#arg_7_0.data)
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.data[arg_10_1]

	arg_10_2:SetData(var_10_0)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.list_:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.OnPolyhedronBeaconUnlock(arg_12_0)
	local var_12_0 = arg_12_0.list_:GetItemList()

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		iter_12_1:Refresh()
	end
end

return var_0_0
