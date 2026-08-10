local var_0_0 = class("CombineGameWatchFactorView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfGlossaryUI"
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

	arg_4_0.list1 = LuaList.New(handler(arg_4_0, arg_4_0.SetItem1), arg_4_0.list1Go_, CombineGameFactorItem)
	arg_4_0.list2 = LuaList.New(handler(arg_4_0, arg_4_0.SetItem2), arg_4_0.list2Go_, CombineGameFactorItem)
end

function var_0_0.SetItem1(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.upList[arg_5_1]

	arg_5_0:SetItem(arg_5_1, arg_5_2, var_5_0)
end

function var_0_0.SetItem2(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.downList[arg_6_1]

	arg_6_0:SetItem(arg_6_1, arg_6_2, var_6_0)
end

function var_0_0.SetItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_2:SetData(arg_7_1, arg_7_3)
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.maskBtn_, nil, function()
		arg_8_0:Back()
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.activityId = CombineGameData:GetDataByPara("activityId")

	if not ActivityData:GetActivityIsOpen(arg_10_0.activityId) then
		gameContext:Go("/home", nil, nil, true)
		ShowTips("TIME_OVER")

		return
	end

	arg_10_0.id = arg_10_0.params_.id
	arg_10_0.factorList = arg_10_0.params_.factorList

	arg_10_0:UpdateView()
end

function var_0_0.UpdateView(arg_11_0)
	arg_11_0.upList = {}
	arg_11_0.downList = {}

	arg_11_0[arg_11_0.factorList == nil and "UpdateLevelView" or "UpdateFactorView"](arg_11_0)

	arg_11_0.titleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR")
	arg_11_0.upTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR_FRONT")
	arg_11_0.downTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR_NEGATIVE")

	arg_11_0.list1:StartScroll(#arg_11_0.upList)
	arg_11_0.list2:StartScroll(#arg_11_0.downList)
end

function var_0_0.UpdateLevelView(arg_12_0)
	local var_12_0 = ActivityCombineLevelCfg[arg_12_0.id]
	local var_12_1 = var_12_0[CombineGameConst.TypeConst.ENDLESS == var_12_0.type and "select_entry" or "default_entry"]

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_2 = ActivityCombineFactorCfg[iter_12_1]

		if var_12_2.score < 0 then
			table.insert(arg_12_0.upList, iter_12_1)
		elseif var_12_2.score > 0 then
			table.insert(arg_12_0.downList, iter_12_1)
		end
	end
end

function var_0_0.UpdateFactorView(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.factorList) do
		local var_13_0 = ActivityCombineFactorCfg[iter_13_0]

		if var_13_0.score < 0 then
			table.insert(arg_13_0.upList, iter_13_0)
		elseif var_13_0.score > 0 then
			table.insert(arg_13_0.downList, iter_13_0)
		end
	end
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0.params_.id = nil
	arg_14_0.params_.factorList = nil

	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.Dispose(arg_16_0)
	if arg_16_0.list1 then
		arg_16_0.list1:Dispose()

		arg_16_0.list1 = nil
	end

	if arg_16_0.list2 then
		arg_16_0.list2:Dispose()

		arg_16_0.list2 = nil
	end

	var_0_0.super.Dispose(arg_16_0)
	Object.Destroy(arg_16_0.gameObject_)
end

return var_0_0
