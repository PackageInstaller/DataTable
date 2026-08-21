local var_0_0 = class("MatrixTerminalLevelView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Matrix/Terminal/MatrixTerminalLevelUI"
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

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, MatrixTerminalLevelItem)
	arg_4_0.desController_ = ControllerUtil.GetController(arg_4_0.transform_, "des")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_maskBtn, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.curLevel = MatrixData:GetTerminalLevel()
	arg_7_0.selectLevel = arg_7_0.curLevel
	arg_7_0.data = arg_7_0:ReverseTable(MatrixTerminalLevelCfg.all)

	local var_7_0 = table.indexof(arg_7_0.data, arg_7_0.curLevel)

	arg_7_0.list_:StartScroll(#arg_7_0.data)
	arg_7_0.list_:ScrollToIndex(var_7_0, true, false)
	arg_7_0:RefreshInfo()
end

function var_0_0.IndexItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.data[arg_8_1]

	arg_8_2:Refresh(var_8_0, arg_8_0.curLevel)
	arg_8_2:SetChoice(arg_8_0.selectLevel)
	arg_8_2:RegistCallBack(handler(arg_8_0, arg_8_0.OnItemClick))
end

function var_0_0.OnItemClick(arg_9_0, arg_9_1)
	arg_9_0.selectLevel = arg_9_1

	local var_9_0 = arg_9_0.list_:GetItemList()

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		iter_9_1:SetChoice(arg_9_0.selectLevel)
	end

	arg_9_0:RefreshInfo()
end

function var_0_0.RefreshInfo(arg_10_0)
	arg_10_0.m_levelLab.text = "" .. arg_10_0.selectLevel

	local var_10_0 = MatrixTerminalLevelCfg[arg_10_0.selectLevel]
	local var_10_1 = arg_10_0.selectLevel - 1
	local var_10_2 = MatrixTerminalLevelCfg[var_10_1] and MatrixTerminalLevelCfg[var_10_1].point or 0
	local var_10_3 = var_10_0.point - var_10_2

	arg_10_0.m_giftLab.text = "+" .. var_10_3

	if var_10_0.desc and var_10_0.desc ~= "" then
		arg_10_0.desController_:SetSelectedIndex(1)

		arg_10_0.m_desLab.text = GetI18NText(var_10_0.desc)
	else
		arg_10_0.desController_:SetSelectedIndex(0)
	end
end

function var_0_0.ReverseTable(arg_11_0, arg_11_1)
	local var_11_0 = {}

	for iter_11_0 = 1, #arg_11_1 do
		var_11_0[iter_11_0] = arg_11_1[#arg_11_1 + 1 - iter_11_0]
	end

	return var_11_0
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.list_:Dispose()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
