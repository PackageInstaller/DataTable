local var_0_0 = class("SpringPreheatPrayBubbleView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.selectController_ = ControllerUtil.GetController(arg_2_0.transform_, "select")
	arg_2_0.lockController_ = ControllerUtil.GetController(arg_2_0.transform_, "locked")
	arg_2_0.itemUiList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.listGo_, SpringPreheatPrayRewardItem)
end

function var_0_0.OnEnter(arg_3_0)
	arg_3_0:RefreshUI()
end

function var_0_0.OnExit(arg_4_0)
	return
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.itemUiList_:Dispose()
	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.AddListeners(arg_6_0)
	if arg_6_0.bgBtn_ then
		arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
			arg_6_0:OnClick(true, arg_6_0.day_)
		end)
	end
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.itemUiList_:StartScroll(#arg_8_0.itemIdList_)
	arg_8_0:SwitchController(arg_8_0:GetDayState())
	arg_8_0:RefreshDayText()
end

function var_0_0.RefreshDayText(arg_9_0, arg_9_1)
	arg_9_0.dayText_.text = arg_9_1 or GetTips(string.format("SPRING_PREHEAT_DAY_%d", arg_9_0.day_))
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.itemIdList_[arg_10_1]

	arg_10_2:SetClickHandler(function(arg_11_0)
		arg_10_0:OnClick(false, arg_10_0.day_, arg_11_0, var_10_0)
	end)
	arg_10_2:SwitchToGoSelect()
	arg_10_2:SetData(var_10_0)
end

function var_0_0.OnClick(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_0.onClickHandler_ then
		arg_12_0.onClickHandler_(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	end
end

function var_0_0.SetClickHandler(arg_13_0, arg_13_1)
	if arg_13_1 then
		arg_13_0.onClickHandler_ = arg_13_1
	end
end

function var_0_0.RefreshItemUiList(arg_14_0)
	arg_14_0.itemUiList_:Refresh()
end

function var_0_0.UpdateItemIdList(arg_15_0, arg_15_1)
	if arg_15_1 then
		arg_15_0.itemIdList_ = arg_15_1
	else
		arg_15_0.itemIdList_ = arg_15_0:GetPraySelectionList()
	end
end

function var_0_0.SwitchController(arg_16_0, arg_16_1)
	if not arg_16_0.selectController_ or not arg_16_0.lockController_ then
		return
	end

	if arg_16_1 == 1 then
		arg_16_0.selectController_:SetSelectedState("notready")
		arg_16_0.lockController_:SetSelectedState("true")
	elseif arg_16_1 == 2 then
		arg_16_0.selectController_:SetSelectedState("notready")
		arg_16_0.lockController_:SetSelectedState("false")
	elseif arg_16_1 == 3 then
		arg_16_0.selectController_:SetSelectedState("selecting")
	elseif arg_16_1 == 4 then
		arg_16_0.selectController_:SetSelectedState("selected")
	end
end

function var_0_0.SetData(arg_17_0, arg_17_1)
	arg_17_0.day_ = arg_17_1

	arg_17_0:UpdateItemIdList()
end

function var_0_0.GetDayText(arg_18_0)
	return arg_18_0.dayText_.text
end

function var_0_0.GetDayState(arg_19_0)
	return (SpringPreheatData:GetDayState(arg_19_0.day_))
end

function var_0_0.GetPraySelectionList(arg_20_0)
	return SpringPreheatData:GetPraySelectionList(arg_20_0.day_)
end

return var_0_0
