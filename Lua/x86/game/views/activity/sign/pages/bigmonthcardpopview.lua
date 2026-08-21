local var_0_0 = class("BigMonthCardPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/ActivitySign/BigMonthCard/BigMonthcardPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, BigMonthCardPopItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = BigMonthCardData:GetRecord()
	local var_5_1 = arg_5_0.list_[arg_5_1]
	local var_5_2 = clone(ItemTemplateData)

	var_5_2.id = var_5_1[1]
	var_5_2.number = var_5_1[2]

	function var_5_2.clickFun()
		ShowPopItem(POP_ITEM, {
			var_5_1[1]
		})
	end

	arg_5_2:RefreshData(var_5_2)

	local var_5_3 = var_5_1[3]
	local var_5_4 = ""

	if var_5_0[arg_5_1] then
		var_5_4 = var_5_3 - var_5_0[arg_5_1] .. "/" .. var_5_3
	else
		var_5_4 = var_5_3 .. "/" .. var_5_3
	end

	arg_5_2:SetText(var_5_4)
end

function var_0_0.AddUIListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.list_ = GameSetting.big_monthly_card_reward_daily.value

	arg_10_0.scrollHelper_:StartScroll(#arg_10_0.list_)
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()

	if arg_12_0.scrollHelper_ then
		arg_12_0.scrollHelper_:Dispose()

		arg_12_0.scrollHelper_ = nil
	end

	arg_12_0.super.Dispose(arg_12_0)
end

return var_0_0
