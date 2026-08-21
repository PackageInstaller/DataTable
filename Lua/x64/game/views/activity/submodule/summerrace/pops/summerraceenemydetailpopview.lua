local var_0_0 = class("SummerRaceEnemyDetailPopView", ReduxView)

local function var_0_1(arg_1_0)
	if arg_1_0 == nil or arg_1_0.enemyId == nil then
		error("SummerRaceEnemyDetailPopView requires params.enemyId")
	end

	return arg_1_0.enemyId
end

local function var_0_2(arg_2_0)
	local var_2_0 = {}

	for iter_2_0 = 1, #(arg_2_0 or {}) do
		local var_2_1 = arg_2_0[iter_2_0]

		if var_2_1 ~= nil and var_2_1.isEmpty ~= true and var_2_1.itemId ~= nil and tostring(var_2_1.itemId) ~= "" then
			var_2_0[#var_2_0 + 1] = var_2_1
		end
	end

	return var_2_0
end

function var_0_0.UIName(arg_3_0)
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_OutGameUI/pop/Activity_SummerRace_EnemyDetailPopUI"
end

function var_0_0.UIParent(arg_4_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_5_0)
	arg_5_0:BindCfgUI()
	arg_5_0:BindViewRuntime()
	arg_5_0:AddUIListener()
end

function var_0_0.BindViewRuntime(arg_6_0)
	arg_6_0.equipSlotItemList_ = LuaList.New(handler(arg_6_0, arg_6_0.IndexSlotItem), arg_6_0.equipListGo_, SummerRaceEquipSlotItemView)
	arg_6_0.stateController_ = arg_6_0.controllerEx_:GetController("state")
	arg_6_0.slotList_ = {}
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshView()
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.maskBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_9_0:AddBtnListener(arg_9_0.closeBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.IndexSlotItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:SetData(arg_12_0.slotList_[arg_12_1], arg_12_1, handler(arg_12_0, arg_12_0.OnSlotAction))
end

function var_0_0.OnSlotAction(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_3 == "select" and arg_13_2 and arg_13_2.itemId ~= "" then
		SummerRaceAction.OpenEquipInfoPop(arg_13_2.itemId)
	end
end

function var_0_0.RefreshView(arg_14_0)
	local var_14_0 = var_0_1(arg_14_0.params_)
	local var_14_1 = SummerRaceData:GetEnemyDetailModel(var_14_0)

	arg_14_0.slotList_ = var_0_2(var_14_1.slotList)
	arg_14_0.enemyNameText_.text = tostring(var_14_1.enemyName or "")

	arg_14_0.stateController_:SetSelectedState(#arg_14_0.slotList_ > 0 and "show" or "hide")
	arg_14_0.equipSlotItemList_:StartScroll(#arg_14_0.slotList_)
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.equipSlotItemList_ then
		arg_15_0.equipSlotItemList_:Dispose()

		arg_15_0.equipSlotItemList_ = nil
	end

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
