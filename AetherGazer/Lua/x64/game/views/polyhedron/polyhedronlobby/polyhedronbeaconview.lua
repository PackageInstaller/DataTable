local var_0_0 = class("PolyhedronBeaconView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Polyhedron/Beacon/PolyhedronBeaconUI"
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

	arg_4_0.beaconList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexBeaconItem), arg_4_0.m_list, PolyhedronBeaconItem)
	arg_4_0.nextController = ControllerUtil.GetController(arg_4_0.transform_, "next")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_backBtn, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_okBtn, nil, function()
		local var_7_0 = PolyhedronData:GetCacheSelectHero()
		local var_7_1 = PolyhedronData:GetCacheSelectDifficulty()
		local var_7_2 = arg_5_0.selectBeaconList

		PolyhedronAction.QueryStartPolyhedron({
			var_7_0
		}, var_7_2, var_7_1)
	end)
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_9_0)
	manager.ui:SetMainCamera("hero")

	arg_9_0.selectBeaconList = PolyhedronData:GetCacheBeaconList()
	arg_9_0.maxBeaconSelect = 3
	arg_9_0.maxBeaconSelect = PolyhedronData:GetBeaconMaxBeaconSelect()
	arg_9_0.beaconData = PolyhedronData:GetUnlockBeaconList()

	table.sort(arg_9_0.beaconData, function(arg_10_0, arg_10_1)
		return arg_10_0 < arg_10_1
	end)

	local var_9_0 = #arg_9_0.beaconData

	arg_9_0.beaconList_:StartScroll(var_9_0)

	arg_9_0.m_numLab.text = #arg_9_0.selectBeaconList .. "/" .. arg_9_0.maxBeaconSelect
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
	PolyhedronData:SetCacheBeaconList(arg_11_0.selectBeaconList)
end

function var_0_0.IndexBeaconItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.beaconData[arg_12_1]
	local var_12_1 = not not table.indexof(arg_12_0.selectBeaconList, var_12_0)

	arg_12_2:SetData(var_12_0)
	arg_12_2:SetChoice(var_12_1)

	local var_12_2 = not var_12_1 and #arg_12_0.selectBeaconList >= arg_12_0.maxBeaconSelect

	arg_12_2:SetMask(var_12_2)
	arg_12_2:RegistCallBack(handler(arg_12_0, arg_12_0.OnBeaconItemClick))
end

function var_0_0.OnBeaconItemClick(arg_13_0, arg_13_1, arg_13_2)
	if table.indexof(arg_13_0.selectBeaconList, arg_13_1) then
		arg_13_0:UnSelectBeacon(arg_13_1)
	else
		if arg_13_0.maxBeaconSelect == 0 then
			ShowTips("POLYHEDRON_SELECT_BEACON_EMPTY")

			return
		end

		if #arg_13_0.selectBeaconList >= arg_13_0.maxBeaconSelect then
			ShowTips("POLYHEDRON_SELECT_BEACON_MAX")

			return
		end

		local var_13_0 = PolyhedronBeaconCfg[arg_13_1]
		local var_13_1 = {}
		local var_13_2 = PolyhedronData:GetTerminalGift() or {}

		for iter_13_0, iter_13_1 in ipairs(var_13_0.require_terminal_list or {}) do
			if table.indexof(var_13_2, iter_13_1) then
				table.insert(var_13_1, iter_13_1)
			end
		end

		if #var_13_1 > 0 then
			local var_13_3 = ""

			for iter_13_2, iter_13_3 in ipairs(var_13_1) do
				local var_13_4 = PolyhedronTerminalCfg[iter_13_3]

				if iter_13_2 == 1 then
					var_13_3 = var_13_4.name
				else
					var_13_3 = var_13_3 .. "," .. var_13_4.name
				end
			end

			ShowMessageBox({
				content = string.format(GetTips("ERROR_MATRIX_NOT_EFFECTIVE"), var_13_0.name, var_13_3),
				OkCallback = function()
					arg_13_0:SelectBeacon(arg_13_1)
				end
			})

			return
		end

		arg_13_0:SelectBeacon(arg_13_1)
	end
end

function var_0_0.SelectBeacon(arg_15_0, arg_15_1)
	table.insert(arg_15_0.selectBeaconList, arg_15_1)

	local var_15_0 = #arg_15_0.selectBeaconList

	arg_15_0.m_numLab.text = var_15_0 .. "/" .. arg_15_0.maxBeaconSelect

	arg_15_0.beaconList_:Refresh()
end

function var_0_0.UnSelectBeacon(arg_16_0, arg_16_1)
	local var_16_0 = table.indexof(arg_16_0.selectBeaconList, arg_16_1)

	table.remove(arg_16_0.selectBeaconList, var_16_0)

	local var_16_1 = #arg_16_0.selectBeaconList

	arg_16_0.m_numLab.text = var_16_1 .. "/" .. arg_16_0.maxBeaconSelect

	arg_16_0.beaconList_:Refresh()
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0.beaconList_:Dispose()
	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
