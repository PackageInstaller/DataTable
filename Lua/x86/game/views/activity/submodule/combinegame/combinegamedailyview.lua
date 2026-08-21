local var_0_0 = class("CombineGameDailyView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiakfDailyUI"
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

	arg_4_0.getController = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "get")
	arg_4_0.selectController = ControllerUtil.GetController(arg_4_0.roleGo_.transform, "stage")
	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.SetRewardItem), arg_4_0.listGo_, CommonItem)
end

function var_0_0.SetRewardItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.cfg.reward_list

	arg_5_2:RefreshData({
		id = var_5_0[arg_5_1][1],
		number = var_5_0[arg_5_1][2]
	})
	arg_5_2:RegistCallBack(function(arg_6_0)
		ShowPopItem(POP_ITEM, {
			arg_6_0.id,
			arg_6_0.number
		})
	end)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.factorBtn_, nil, function()
		JumpTools.GoToSystem("CombineGameWatchFactorView", {
			id = arg_7_0.id
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.startBtn_, nil, function()
		manager.redPoint:setTip(string.format("%s%s_DAILY", ActivityTools.GetRedPointKey(arg_7_0.activityId), arg_7_0.activityId), 0)
		CombineGameFactory:StartGame(arg_7_0.id, nil, arg_7_0.selectHero)
	end)
	arg_7_0:AddBtnListener(arg_7_0.roleBtn_, nil, function()
		JumpTools.GoToSystem("/CombineGameRoleView", {
			lv = 999
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.hero1Btn_, nil, function()
		arg_7_0.selectHero = 1

		arg_7_0.selectController:SetSelectedState(CombineGameData:CheckHeroLock(arg_7_0.activityId, arg_7_0.heroList[2]) and "stage1" or "stage3")
	end)
	arg_7_0:AddBtnListener(arg_7_0.hero2Btn_, nil, function()
		local var_12_0 = arg_7_0.cfg.can_use_hero
		local var_12_1 = ActivityCombineHeroCfg[var_12_0[2]]

		if CombineGameData:CheckHeroLock(arg_7_0.activityId, arg_7_0.heroList[2]) == false then
			local var_12_2 = manager.time:GetNextFreshTime() + (var_12_1.unlock_condition[1][2] - arg_7_0.id + 2) * 86400

			ShowTips(string.format(GetTips("ACTIVITY_COMBINE_GAME_HERO_UNLOCKED"), manager.time:GetLostTimeStr2(var_12_2)))

			return
		end

		arg_7_0.selectHero = 2

		arg_7_0.selectController:SetSelectedState("stage2")
	end)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.activityId = CombineGameData:GetDataByPara("activityId")

	if not ActivityData:GetActivityIsOpen(arg_13_0.activityId) then
		gameContext:Go("/home", nil, nil, true)
		ShowTips("TIME_OVER")

		return
	end

	arg_13_0.id = CombineGameData:GetDataByPara("nowDay")
	arg_13_0.selectHero = getData("CombineGame", "daily" .. arg_13_0.id) or 1

	arg_13_0:UpdateView()
	arg_13_0:BindRedPoint()
end

function var_0_0.UpdateView(arg_14_0)
	arg_14_0.cfg = ActivityCombineLevelCfg[arg_14_0.id]
	arg_14_0.activityId = CombineGameData:GetDataByPara("activityId")
	arg_14_0.descTxt_.text = GetTips(arg_14_0.cfg.description)
	arg_14_0.titleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_NAME_2")
	arg_14_0.dailyDescTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_CONTENT_2")
	arg_14_0.startTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_BEGIN")
	arg_14_0.factorTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR")
	arg_14_0.selectFactorList = arg_14_0.cfg.default_entry
	arg_14_0.heroList = arg_14_0.cfg.can_use_hero

	local var_14_0 = CombineGameData:GetDataByPara("stageDataTable")[arg_14_0.id]
	local var_14_1 = ActivityCombineHeroCfg[arg_14_0.heroList[1]]
	local var_14_2 = ActivityCombineHeroCfg[arg_14_0.heroList[2]]

	if arg_14_0.selectHero == 2 then
		arg_14_0.selectController:SetSelectedState("stage2")
	else
		arg_14_0.selectController:SetSelectedState(CombineGameData:CheckHeroLock(arg_14_0.activityId, arg_14_0.heroList[2]) and "stage1" or "stage3")
	end

	arg_14_0.getController:SetSelectedState(var_14_0 == true and "true" or "false")
	arg_14_0.list:StartScroll(#arg_14_0.cfg.reward_list)

	local var_14_3 = 1
	local var_14_4 = 1
	local var_14_5 = 0
	local var_14_6 = 0

	for iter_14_0 = 1, 3 do
		SetActive(arg_14_0["upGo" .. iter_14_0 .. "_"], false)
		SetActive(arg_14_0["downGo" .. iter_14_0 .. "_"], false)
	end

	for iter_14_1, iter_14_2 in ipairs(arg_14_0.selectFactorList) do
		local var_14_7 = ActivityCombineFactorCfg[iter_14_2]

		if var_14_7.score < 0 then
			if var_14_3 <= 3 then
				SetActive(arg_14_0["upGo" .. var_14_3 .. "_"], true)

				arg_14_0["upImg" .. var_14_3 .. "_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. var_14_7.icon)
				var_14_3 = var_14_3 + 1
			else
				var_14_5 = var_14_5 + 1
			end
		elseif var_14_7.score > 0 then
			if var_14_4 <= 3 then
				SetActive(arg_14_0["downGo" .. var_14_4 .. "_"], true)

				arg_14_0["downImg" .. var_14_4 .. "_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. var_14_7.icon)
				var_14_4 = var_14_4 + 1
			else
				var_14_6 = var_14_6 + 1
			end
		end
	end

	arg_14_0.hero1Image_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. var_14_1.icon)
	arg_14_0.hero2Image_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. var_14_2.icon)
end

function var_0_0.BindRedPoint(arg_15_0)
	manager.redPoint:bindUIandKey(arg_15_0.startBtn_.transform, string.format("%s%s_DAILY", ActivityTools.GetRedPointKey(arg_15_0.activityId), arg_15_0.activityId), {
		x = 150,
		y = 35
	})
end

function var_0_0.UnbindRedPoint(arg_16_0)
	manager.redPoint:unbindUIandKey(arg_16_0.startBtn_.transform, string.format("%s%s_DAILY", ActivityTools.GetRedPointKey(arg_16_0.activityId), arg_16_0.activityId))
end

function var_0_0.OnCombineGameRefresh(arg_17_0)
	arg_17_0.id = CombineGameData:GetDataByPara("nowDay")

	arg_17_0:UpdateView()
end

function var_0_0.OnExit(arg_18_0)
	saveData("CombineGame", "daily" .. arg_18_0.id, arg_18_0.selectHero)
	arg_18_0:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_19_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.Dispose(arg_20_0)
	if arg_20_0.list then
		arg_20_0.list:Dispose()

		arg_20_0.list = nil
	end

	var_0_0.super.Dispose(arg_20_0)
	Object.Destroy(arg_20_0.gameObject_)
end

return var_0_0
