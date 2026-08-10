local var_0_0 = class("MartixTerminalGroupItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController_ = ControllerUtil.GetController(arg_2_0.transform_, "state")
	arg_2_0.countController_ = ControllerUtil.GetController(arg_2_0.transform_, "count")
	arg_2_0.rowController_ = ControllerUtil.GetController(arg_2_0.transform_, "row")
	arg_2_0.items = {}

	for iter_2_0 = 1, 3 do
		table.insert(arg_2_0.items, MatrixTerminalTalentItem.New(arg_2_0["m_item" .. iter_2_0]))
	end
end

function var_0_0.Refresh(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = arg_3_2.type
	local var_3_1 = arg_3_2.list
	local var_3_2 = arg_3_2.row
	local var_3_3 = math.min(#var_3_1, 3)

	if var_3_0 == 1 then
		arg_3_0.stateController_:SetSelectedIndex(0)
		arg_3_0.rowController_:SetSelectedIndex(0)
	else
		arg_3_0.stateController_:SetSelectedIndex(1)
		arg_3_0.rowController_:SetSelectedIndex(var_3_2 and 1 or 0)
	end

	arg_3_0.countController_:SetSelectedIndex(var_3_3)

	for iter_3_0, iter_3_1 in pairs(var_3_1) do
		if arg_3_0.items[iter_3_0] then
			arg_3_0.items[iter_3_0]:Refresh(iter_3_1, arg_3_3, arg_3_4, arg_3_5)
		end
	end

	arg_3_0:SetItemScrollMask(false)
end

function var_0_0.SetChoice(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.items) do
		iter_4_1:SetChoice(arg_4_1)
	end
end

function var_0_0.RefreshData(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.items) do
		iter_5_1:RefreshData(arg_5_1, arg_5_2)
	end
end

function var_0_0.RegistCallBack(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.items) do
		iter_6_1:RegistCallBack(arg_6_1)
	end
end

function var_0_0.SetItemScrollMask(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.items) do
		iter_7_1:SetScrollEnable(arg_7_1)
	end
end

function var_0_0.Dispose(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.items) do
		iter_8_1:Dispose()
	end

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
