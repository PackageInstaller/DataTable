local var_0_0 = class("SummerRaceTankDetailPopView", ReduxView)

local function var_0_1(arg_1_0)
	if arg_1_0 == nil or arg_1_0.buildData == nil then
		error("SummerRaceTankDetailPopView requires params.buildData")
	end

	return arg_1_0.buildData
end

function var_0_0.UIName(arg_2_0)
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_OutGameUI/pop/Activity_SummerRace_TankDetailPopUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:BindViewRuntime()
	arg_4_0:AddUIListener()
end

function var_0_0.BindViewRuntime(arg_5_0)
	arg_5_0.equipSlotItemList_ = LuaList.New(handler(arg_5_0, arg_5_0.IndexSlotItem), arg_5_0.equipListGo_, SummerRaceEquipSlotItemView)
	arg_5_0.stateController_ = arg_5_0.controllerEx_:GetController("state")
	arg_5_0.slotList_ = {}
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:RefreshView()
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.maskBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_8_0:AddBtnListener(arg_8_0.closeBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.IndexSlotItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:SetData(arg_11_0.slotList_[arg_11_1], arg_11_1, handler(arg_11_0, arg_11_0.OnSlotAction))
end

function var_0_0.OnSlotAction(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3 == "select" and arg_12_2 and arg_12_2.itemId ~= "" then
		SummerRaceAction.OpenEquipInfoPop(arg_12_2.itemId)
	end
end

function var_0_0.RefreshView(arg_13_0)
	local var_13_0 = var_0_1(arg_13_0.params_)
	local var_13_1 = SummerRaceData:GetTankSnapshotModel(var_13_0)

	arg_13_0.slotList_ = var_13_1.slotList or {}
	arg_13_0.tankNameText_.text = tostring(var_13_1.tankName or "")
	arg_13_0.costText_.text = tostring(var_13_1.cost or "")

	arg_13_0.stateController_:SetSelectedState(#arg_13_0.slotList_ > 0 and "show" or "hide")
	arg_13_0.equipSlotItemList_:StartScroll(#arg_13_0.slotList_)
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.equipSlotItemList_ then
		arg_14_0.equipSlotItemList_:Dispose()

		arg_14_0.equipSlotItemList_ = nil
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
