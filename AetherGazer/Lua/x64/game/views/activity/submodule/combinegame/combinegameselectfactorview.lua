local var_0_0 = class("CombineGameSelectFactorView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfGlossaryyUI"
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
	arg_7_2:SetData(arg_7_1, arg_7_3, handler(arg_7_0, arg_7_0.ClickCallBack), arg_7_0.selectFactorList[arg_7_3] or false)
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.maskBtn_, nil, function()
		arg_8_0:Back()
	end)
	arg_8_0:AddBtnListener(arg_8_0.okBtn_, nil, function()
		manager.notify:CallUpdateFunc(COMBINE_GAME_SELECT_FACTOR_SURE, arg_8_0.selectFactorList)
		arg_8_0:Back()
	end)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.activityId = CombineGameData:GetDataByPara("activityId")

	if not ActivityData:GetActivityIsOpen(arg_11_0.activityId) then
		gameContext:Go("/home", nil, nil, true)
		ShowTips("TIME_OVER")

		return
	end

	arg_11_0.id = arg_11_0.params_.id
	arg_11_0.selectFactorList = clone(arg_11_0.params_.selectFactorList or {})

	arg_11_0:UpdateView()
end

function var_0_0.ClickCallBack(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_0.selectFactorList[arg_12_2] then
		arg_12_0.selectFactorList[arg_12_2] = nil
	else
		arg_12_0.selectFactorList[arg_12_2] = true
	end

	arg_12_3:SetSelectedState(arg_12_0.selectFactorList[arg_12_2] and "true" or "false")
	arg_12_0:UpdateScore()
end

function var_0_0.UpdateView(arg_13_0)
	local var_13_0 = ActivityCombineLevelCfg[arg_13_0.id]

	arg_13_0.upList = {}
	arg_13_0.downList = {}

	for iter_13_0, iter_13_1 in ipairs(var_13_0.select_entry) do
		local var_13_1 = ActivityCombineFactorCfg[iter_13_1]

		if var_13_1.score < 0 then
			table.insert(arg_13_0.upList, iter_13_1)
		elseif var_13_1.score > 0 then
			table.insert(arg_13_0.downList, iter_13_1)
		end
	end

	arg_13_0.titleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR")
	arg_13_0.upTitleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR_FRONT")
	arg_13_0.downTitleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR_NEGATIVE")
	arg_13_0.hardScoreTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_DIFFICULTY_RATING_NOW")

	arg_13_0.list1:StartScroll(#arg_13_0.upList)
	arg_13_0.list2:StartScroll(#arg_13_0.downList)
	arg_13_0:UpdateScore()
end

function var_0_0.UpdateScore(arg_14_0)
	local var_14_0 = 0
	local var_14_1 = 0
	local var_14_2 = 0

	for iter_14_0, iter_14_1 in pairs(arg_14_0.selectFactorList) do
		local var_14_3 = ActivityCombineFactorCfg[iter_14_0]

		if var_14_3.score < 0 then
			var_14_1 = var_14_1 + 1
		elseif var_14_3.score > 0 then
			var_14_2 = var_14_2 + 1
		end

		var_14_0 = var_14_0 + var_14_3.score
	end

	arg_14_0.upTxt_.text = var_14_1 .. "/" .. #arg_14_0.upList
	arg_14_0.downTxt_.text = var_14_2 .. "/" .. #arg_14_0.downList
	arg_14_0.scoreTxt_.text = var_14_0
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0.selectFactorList = {}

	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.list1 then
		arg_17_0.list1:Dispose()

		arg_17_0.list1 = nil
	end

	if arg_17_0.list2 then
		arg_17_0.list2:Dispose()

		arg_17_0.list2 = nil
	end

	var_0_0.super.Dispose(arg_17_0)
	Object.Destroy(arg_17_0.gameObject_)
end

return var_0_0
