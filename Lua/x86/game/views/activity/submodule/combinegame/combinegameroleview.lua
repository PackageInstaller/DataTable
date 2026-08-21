local var_0_0 = class("CombineGameRoleView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfRoleUI"
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

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.SetItem), arg_4_0.listGo_, CombineGameRoleItem)
	arg_4_0.selectController = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "select")
	arg_4_0.roleController = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "role")
	arg_4_0.stageController = ControllerUtil.GetController(arg_4_0.roleGo_.transform, "stage")
	arg_4_0.lockController = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "lock")
end

function var_0_0.SetItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:UpdateShowTable()

	arg_5_2:SetData(var_5_0[arg_5_1], arg_5_0.lv, arg_5_0.selectModel)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.skillBtn_, nil, function()
		arg_6_0.selectModel = 1

		arg_6_0:UpdateView()
	end)
	arg_6_0:AddBtnListener(arg_6_0.inbornBtn_, nil, function()
		arg_6_0.selectModel = 2

		arg_6_0:UpdateView()
	end)
	arg_6_0:AddBtnListener(arg_6_0.role1Btn_, nil, function()
		arg_6_0.roleId = ActivityCombineHeroCfg.all[1]
		arg_6_0.selectModel = 1

		arg_6_0.stageController:SetSelectedState(CombineGameData:CheckHeroLock(arg_6_0.activityId, ActivityCombineHeroCfg.all[2]) and "stage1" or "stage3")
		arg_6_0:UpdateView()
	end)
	arg_6_0:AddBtnListener(arg_6_0.role2Btn_, nil, function()
		arg_6_0.roleId = ActivityCombineHeroCfg.all[2]
		arg_6_0.selectModel = 1

		arg_6_0.stageController:SetSelectedState(CombineGameData:CheckHeroLock(arg_6_0.activityId, ActivityCombineHeroCfg.all[2]) and "stage2" or "stage4")
		arg_6_0:UpdateView()
	end)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.activityId = CombineGameData:GetDataByPara("activityId")

	if not ActivityData:GetActivityIsOpen(arg_12_0.activityId) then
		gameContext:Go("/home", nil, nil, true)
		ShowTips("TIME_OVER")

		return
	end

	arg_12_0.lv = arg_12_0.params_.lv
	arg_12_0.roleId = arg_12_0.params_.roleId
	arg_12_0.selectModel = 1

	SetActive(arg_12_0.selectGo_, true)
	arg_12_0:UpdateView()
	arg_12_0.stageController:SetSelectedState(CombineGameData:CheckHeroLock(arg_12_0.activityId, ActivityCombineHeroCfg.all[2]) and "stage1" or "stage3")
end

function var_0_0.UpdateView(arg_13_0)
	if arg_13_0.roleId == nil then
		arg_13_0.roleId = ActivityCombineHeroCfg.all[1]
	end

	if arg_13_0.timer_ then
		arg_13_0.timer_:Stop()

		arg_13_0.timer_ = nil
	end

	local var_13_0 = ActivityCombineHeroCfg[arg_13_0.roleId]
	local var_13_1 = ActivityCombineHeroCfg[ActivityCombineHeroCfg.all[2]]

	arg_13_0.activityId = CombineGameData:GetDataByPara("activityId")
	arg_13_0.nowDay = CombineGameData:GetDataByPara("nowDay")

	arg_13_0.selectController:SetSelectedState(arg_13_0.selectModel == 1 and "skill" or "inborn")
	arg_13_0.roleController:SetSelectedState(arg_13_0.lv ~= 999 and "hide" or "show")

	arg_13_0.nameTxt_.text = GetI18NText(var_13_0.name)
	arg_13_0.descTxt_.text = GetI18NText(var_13_0.description)
	arg_13_0.skillTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_HERO_SKILL")
	arg_13_0.inbornTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_HERO_FACTOR")
	arg_13_0.lvTxt_.text = arg_13_0.lv == 999 and #var_13_0.level_unlock or arg_13_0.lv
	arg_13_0.role1Img_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. ActivityCombineHeroCfg[ActivityCombineHeroCfg.all[1]].icon)
	arg_13_0.role2Img_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. ActivityCombineHeroCfg[ActivityCombineHeroCfg.all[2]].icon)

	TimeTools.StartAfterSeconds(0.01, function()
		arg_13_0.roleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. ActivityCombineHeroCfg[arg_13_0.roleId].image)
	end, {})
	SetActive(arg_13_0.lvGo_, arg_13_0.lv ~= 999)

	local var_13_2 = manager.time:GetNextFreshTime() + (var_13_1.unlock_condition[1][2] - arg_13_0.nowDay + 2) * 86400

	arg_13_0.lockTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_HERO_UNLOCKED"), manager.time:GetLostTimeStr2(var_13_2))
	arg_13_0.timer_ = Timer.New(function()
		local var_15_0 = manager.time:GetNextFreshTime() + (var_13_1.unlock_condition[1][2] - arg_13_0.nowDay + 2) * 86400

		arg_13_0.lockTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_HERO_UNLOCKED"), manager.time:GetLostTimeStr2(var_15_0))
	end, 1, -1)

	arg_13_0.timer_:Start()

	local var_13_3 = CombineGameData:CheckHeroLock(arg_13_0.activityId, ActivityCombineHeroCfg.all[2]) or arg_13_0.roleId == ActivityCombineHeroCfg.all[1] or arg_13_0.lv ~= 999

	arg_13_0.lockController:SetSelectedState(var_13_3 and "false" or "true")
	arg_13_0.list:StartScroll(#arg_13_0:UpdateShowTable())
end

function var_0_0.UpdateShowTable(arg_16_0)
	local var_16_0 = ActivityCombineHeroCfg[arg_16_0.roleId]
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0.level_unlock) do
		local var_16_2 = ActivityCombineFactorCfg[iter_16_1]

		if arg_16_0.selectModel == 1 and var_16_2.effect_type == 1 then
			table.insert(var_16_1, {
				id = iter_16_1,
				lv = iter_16_0
			})
		elseif arg_16_0.selectModel == 2 and var_16_2.effect_type ~= 1 then
			table.insert(var_16_1, {
				id = iter_16_1,
				lv = iter_16_0
			})
		end
	end

	return var_16_1
end

function var_0_0.OnExit(arg_17_0)
	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end

	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_18_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.Dispose(arg_19_0)
	if arg_19_0.list then
		arg_19_0.list:Dispose()

		arg_19_0.list = nil
	end

	var_0_0.super.Dispose(arg_19_0)
	Object.Destroy(arg_19_0.gameObject_)
end

return var_0_0
