local var_0_0 = class("CombineGameTeachView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfTeachUI"
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

	arg_4_0.list1 = LuaList.New(handler(arg_4_0, arg_4_0.SetRewardItem1), arg_4_0.list1Go_, CommonItem)
	arg_4_0.list2 = LuaList.New(handler(arg_4_0, arg_4_0.SetRewardItem2), arg_4_0.list2Go_, CommonItem)
	arg_4_0.list3 = LuaList.New(handler(arg_4_0, arg_4_0.SetRewardItem3), arg_4_0.list3Go_, CommonItem)
	arg_4_0.controller1 = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "stage1")
	arg_4_0.controller2 = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "stage2")
	arg_4_0.controller3 = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "stage3")
end

function var_0_0.SetRewardItem1(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = ActivityCombineLevelCfg[arg_5_0.idList[1]]

	arg_5_0:SetRewardItem(arg_5_1, arg_5_2, var_5_0)
end

function var_0_0.SetRewardItem2(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = ActivityCombineLevelCfg[arg_6_0.idList[2]]

	arg_6_0:SetRewardItem(arg_6_1, arg_6_2, var_6_0)
end

function var_0_0.SetRewardItem3(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = ActivityCombineLevelCfg[arg_7_0.idList[3]]

	arg_7_0:SetRewardItem(arg_7_1, arg_7_2, var_7_0)
end

function var_0_0.SetRewardItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_3.reward_list

	arg_8_2:RefreshData({
		id = var_8_0[arg_8_1][1],
		number = var_8_0[arg_8_1][2]
	})
	arg_8_2:RegistCallBack(function(arg_9_0)
		ShowPopItem(POP_ITEM, {
			arg_9_0.id,
			arg_9_0.number
		})
	end)
end

function var_0_0.AddUIListener(arg_10_0)
	for iter_10_0 = 1, 3 do
		arg_10_0:AddBtnListener(arg_10_0["start" .. iter_10_0 .. "Btn_"], nil, function()
			if arg_10_0["controller" .. iter_10_0]:GetSelectedState() == "lock" then
				ShowTips(string.format(GetTips("ACTIVITY_COMBINE_GAME_OPEN_LIMIT_TIPS"), GetI18NText(ActivityCombineLevelCfg[arg_10_0.idList[1]].name)))

				return
			end

			CombineGameFactory:StartGame(arg_10_0.idList[iter_10_0], nil, 1)
			manager.redPoint:setTip(string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(arg_10_0.activityId), arg_10_0.activityId, arg_10_0.idList[iter_10_0]), 0)
		end)
	end
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.activityId = CombineGameData:GetDataByPara("activityId")

	if not ActivityData:GetActivityIsOpen(arg_12_0.activityId) then
		gameContext:Go("/home", nil, nil, true)
		ShowTips("TIME_OVER")

		return
	end

	arg_12_0:UpdateView()
	arg_12_0:BindRedPoint()
end

function var_0_0.UpdateView(arg_13_0)
	arg_13_0.idList = {}
	arg_13_0.activityId = CombineGameData:GetDataByPara("activityId")

	for iter_13_0, iter_13_1 in ipairs(ActivityCombineLevelCfg.all) do
		local var_13_0 = ActivityCombineLevelCfg[iter_13_0]

		if var_13_0.type == CombineGameConst.TypeConst.TEACH or var_13_0.type == CombineGameConst.TypeConst.HERO_TEACH then
			table.insert(arg_13_0.idList, iter_13_0)
		end
	end

	local var_13_1 = CombineGameData:GetDataByPara("stageDataTable")

	for iter_13_2, iter_13_3 in ipairs(arg_13_0.idList) do
		local var_13_2 = ActivityCombineLevelCfg[iter_13_2]

		arg_13_0["list" .. iter_13_2]:StartScroll(#var_13_2.reward_list)

		arg_13_0["title" .. iter_13_2 .. "Txt_"].text = GetI18NText(var_13_2.name)
		arg_13_0["start" .. iter_13_2 .. "Txt_"].text = GetTips("ACTIVITY_COMBINE_GAME_BEGIN")

		arg_13_0["controller" .. iter_13_2]:SetSelectedState("normal")

		if arg_13_0["lock" .. iter_13_2 .. "Txt_"] then
			arg_13_0["lock" .. iter_13_2 .. "Txt_"].text = string.format(GetTips("ACTIVITY_COMBINE_GAME_OPEN_LIMIT_TIPS"), GetI18NText(ActivityCombineLevelCfg[arg_13_0.idList[1]].name))
		end

		if var_13_1[arg_13_0.idList[iter_13_2]] == true then
			arg_13_0["controller" .. iter_13_2]:SetSelectedState("pass")
		elseif iter_13_2 > 1 then
			arg_13_0["controller" .. iter_13_2]:SetSelectedState(var_13_1[arg_13_0.idList[1]] == true and "normal" or "lock")
		else
			arg_13_0["controller" .. iter_13_2]:SetSelectedState("normal")
		end
	end

	arg_13_0.titleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_NAME_1")
	arg_13_0.descTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_CONTENT_1")
end

function var_0_0.OnCombineGameRefresh(arg_14_0)
	arg_14_0:UpdateView()
end

function var_0_0.BindRedPoint(arg_15_0)
	manager.redPoint:bindUIandKey(arg_15_0.start1Btn_.transform, string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(arg_15_0.activityId), arg_15_0.activityId, arg_15_0.idList[1]), {
		x = 105,
		y = 35
	})
	manager.redPoint:bindUIandKey(arg_15_0.start2Btn_.transform, string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(arg_15_0.activityId), arg_15_0.activityId, arg_15_0.idList[2]), {
		x = 105,
		y = 35
	})
	manager.redPoint:bindUIandKey(arg_15_0.start3Btn_.transform, string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(arg_15_0.activityId), arg_15_0.activityId, arg_15_0.idList[3]), {
		x = 105,
		y = 35
	})
end

function var_0_0.UnbindRedPoint(arg_16_0)
	manager.redPoint:unbindUIandKey(arg_16_0.start1Btn_.transform, string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(arg_16_0.activityId), arg_16_0.activityId, arg_16_0.idList[1]))
	manager.redPoint:unbindUIandKey(arg_16_0.start2Btn_.transform, string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(arg_16_0.activityId), arg_16_0.activityId, arg_16_0.idList[2]))
	manager.redPoint:unbindUIandKey(arg_16_0.start3Btn_.transform, string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(arg_16_0.activityId), arg_16_0.activityId, arg_16_0.idList[3]))
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_18_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.Dispose(arg_19_0)
	for iter_19_0 = 1, 3 do
		if arg_19_0["list" .. iter_19_0] then
			arg_19_0["list" .. iter_19_0]:Dispose()

			arg_19_0["list" .. iter_19_0] = nil
		end
	end

	var_0_0.super.Dispose(arg_19_0)
	Object.Destroy(arg_19_0.gameObject_)
end

return var_0_0
