local var_0_0 = class("CanteenPassTablePop", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/canteen/EmptyDreamPassTablePop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.ExitOnCanteenModeChange(arg_4_0)
	arg_4_0.onSelect = nil
	arg_4_0.onCanceled = nil

	arg_4_0:Back()
end

function var_0_0.OnEnter(arg_5_0)
	local var_5_0 = CanteenAIFunction:GetNameSpace(DormEnum.ItemType.PassTable)

	arg_5_0.passtableEntityEid = CanteenAIFunction:GetAllEIDNameSpace(var_5_0)[1]
	arg_5_0.passtableData = CanteenAIFunction:GetEntityData(arg_5_0.passtableEntityEid)
	arg_5_0.foodList = nullable(arg_5_0.passtableData, "foodList")
	arg_5_0.playerEID = arg_5_0.params_.playerEID
	arg_5_0.onSelect = arg_5_0.params_.onSelect
	arg_5_0.onCanceled = arg_5_0.params_.onCanceled

	arg_5_0.foodListScroll_:StartScroll(arg_5_0.foodList and #arg_5_0.foodList or 0)

	arg_5_0.select = false

	local var_5_1 = handler(arg_5_0, arg_5_0.ExitOnCanteenModeChange)

	arg_5_0:RegistEventListener(DORM_RESTAURANT_START_AUTO, var_5_1)
	arg_5_0:RegistEventListener(DORM_RESTAURANT_START_MANUAL, var_5_1)
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()

	arg_6_0.foodListScroll_ = LuaList.New(handler(arg_6_0, arg_6_0.foodItem), arg_6_0.foodlistUilist_, CanteenPassTableFoodItem)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgmaskBtn_, nil, function()
		arg_7_0.select = false

		JumpTools.Back()
	end)
end

function var_0_0.foodItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:RefreshItem(arg_9_0.foodList[arg_9_1])
	arg_9_2:RegistCallBack(function(arg_10_0)
		CanteenAIFunction:SetCharacterTarget(arg_9_0.playerEID, arg_10_0)

		arg_9_0.select = true

		JumpTools.Back()
	end)
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0:RemoveAllEventListener()

	if arg_11_0.select then
		if arg_11_0.onSelect then
			arg_11_0.onSelect()
		end
	elseif arg_11_0.onCanceled then
		arg_11_0.onCanceled()
	end
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.foodListScroll_ then
		arg_12_0.foodListScroll_:Dispose()

		arg_12_0.foodListScroll_ = nil
	end
end

return var_0_0
