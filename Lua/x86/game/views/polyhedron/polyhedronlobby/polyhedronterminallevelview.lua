local var_0_0 = class("PolyhedronTerminalLevelView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Polyhedron/Terminal/PolyhedronTerminalpupUI"
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

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, PolyhedronTerminalLevelItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_maskBtn, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_8_0)
	local var_8_0 = PolyhedronData:GetTerminalLevel()
	local var_8_1 = PolyhedronData:GetTerminalExp()

	arg_8_0.m_levelLab.text = "" .. var_8_0

	if var_8_0 == #PolyhedronTerminalLevelCfg.all then
		arg_8_0.m_expSlider.value = 1

		local var_8_2 = PolyhedronTerminalLevelCfg[var_8_0].exp - PolyhedronTerminalLevelCfg[var_8_0 - 1].exp

		arg_8_0.m_expLab.text = string.format("<color=#FF9500>%d</color>/%d", var_8_2, var_8_2)
	else
		local var_8_3 = PolyhedronTerminalLevelCfg[var_8_0 + 1].exp - PolyhedronTerminalLevelCfg[var_8_0].exp

		arg_8_0.m_expSlider.value = var_8_1 / var_8_3
		arg_8_0.m_expLab.text = string.format("<color=#FF9500>%d</color>/%d", var_8_1, var_8_3)
	end

	local var_8_4 = #PolyhedronTerminalLevelCfg.all
	local var_8_5 = table.indexof(PolyhedronTerminalLevelCfg.all, var_8_0)

	arg_8_0.list:StartScroll(var_8_4, var_8_5, false)
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = PolyhedronTerminalLevelCfg.all[arg_10_1]

	arg_10_2:SetData(var_10_0)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.list:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
