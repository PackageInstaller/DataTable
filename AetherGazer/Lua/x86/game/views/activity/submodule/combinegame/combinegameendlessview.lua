local var_0_0 = class("CombineGameEndlessView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiakfEndlessUI"
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

	arg_4_0.scoreController = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "score")
	arg_4_0.textController = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "text")
	arg_4_0.selectController = ControllerUtil.GetController(arg_4_0.roleGo_.transform, "stage")
	arg_4_0.factorController = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "factor")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.factorBtn_, nil, function()
		JumpTools.GoToSystem("CombineGameSelectFactorView", {
			id = arg_5_0.id,
			selectFactorList = arg_5_0.selectFactorList
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.newFactorBtn_, nil, function()
		JumpTools.GoToSystem("CombineGameSelectFactorView", {
			id = arg_5_0.id,
			selectFactorList = arg_5_0.selectFactorList
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.startBtn_, nil, function()
		JumpTools.GoToSystem("CombineGameSelectFactorView", {
			id = arg_5_0.id,
			selectFactorList = arg_5_0.selectFactorList
		})

		arg_5_0.isBegin = true
	end)
	arg_5_0:AddBtnListener(arg_5_0.roleBtn_, nil, function()
		JumpTools.GoToSystem("/CombineGameRoleView", {
			lv = 999
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.hero1Btn_, nil, function()
		arg_5_0.selectHero = 1

		arg_5_0.selectController:SetSelectedState(CombineGameData:CheckHeroLock(arg_5_0.activityId, arg_5_0.heroList[2]) and "stage1" or "stage3")
	end)
	arg_5_0:AddBtnListener(arg_5_0.hero2Btn_, nil, function()
		local var_11_0 = arg_5_0.cfg.can_use_hero
		local var_11_1 = ActivityCombineHeroCfg[var_11_0[2]]

		if CombineGameData:CheckHeroLock(arg_5_0.activityId, arg_5_0.heroList[2]) == false then
			local var_11_2 = CombineGameData:GetDataByPara("nowDay")
			local var_11_3 = manager.time:GetNextFreshTime() + (var_11_1.unlock_condition[1][2] - var_11_2 + 2) * 86400

			ShowTips(string.format(GetTips("ACTIVITY_COMBINE_GAME_HERO_UNLOCKED"), manager.time:GetLostTimeStr2(var_11_3)))

			return
		end

		arg_5_0.selectHero = 2

		arg_5_0.selectController:SetSelectedState("stage2")
	end)
end

function var_0_0.OnCombineGameRefresh(arg_12_0)
	arg_12_0:UpdateView()
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.activityId = CombineGameData:GetDataByPara("activityId")

	if not ActivityData:GetActivityIsOpen(arg_13_0.activityId) then
		gameContext:Go("/home", nil, nil, true)
		ShowTips("TIME_OVER")

		return
	end

	for iter_13_0, iter_13_1 in ipairs(ActivityCombineLevelCfg.all) do
		if ActivityCombineLevelCfg[iter_13_0].type == CombineGameConst.TypeConst.ENDLESS then
			arg_13_0.id = iter_13_0
		end
	end

	arg_13_0.selectHero = getData("CombineGame", "endless") or 1
	arg_13_0.selectFactorList = {}

	arg_13_0:GetLastFactor()
	arg_13_0:UpdateView()

	if arg_13_0.selectHero == 2 then
		arg_13_0.selectController:SetSelectedState("stage2")
	else
		arg_13_0.selectController:SetSelectedState(CombineGameData:CheckHeroLock(arg_13_0.activityId, arg_13_0.heroList[2]) and "stage1" or "stage3")
	end
end

function var_0_0.GetLastFactor(arg_14_0)
	local var_14_0 = getData("CombineGame", "factor")

	if var_14_0 == nil then
		return
	end

	local var_14_1 = string.split(var_14_0, ":")

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		arg_14_0.selectFactorList[tonumber(iter_14_1)] = true
	end
end

function var_0_0.UpdateView(arg_15_0)
	arg_15_0.cfg = ActivityCombineLevelCfg[arg_15_0.id]
	arg_15_0.activityId = CombineGameData:GetDataByPara("activityId")
	arg_15_0.descTxt_.text = GetI18NText(arg_15_0.cfg.description)

	arg_15_0.textController:SetSelectedState("false")

	arg_15_0.nowDay = CombineGameData:GetDataByPara("nowDay")
	arg_15_0.heroList = arg_15_0.cfg.can_use_hero

	local var_15_0 = ActivityCombineHeroCfg[arg_15_0.heroList[1]]
	local var_15_1 = ActivityCombineHeroCfg[arg_15_0.heroList[2]]
	local var_15_2 = CombineGameData:GetDataByPara("stageDataTable")[arg_15_0.id]
	local var_15_3 = CombineGameData:GetDataByPara("score")

	arg_15_0.scoreController:SetSelectedState(var_15_2 ~= nil and "true" or "false")

	arg_15_0.hero1Image_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. var_15_0.icon)
	arg_15_0.hero2Image_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. var_15_1.icon)
	arg_15_0.maxScoreTxt_.text = var_15_3
	arg_15_0.titleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_NAME_3")
	arg_15_0.titleDescTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_CONTENT_3")
	arg_15_0.selectTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR")
	arg_15_0.editTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR_EDIT")
	arg_15_0.nowDifficultyTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_DIFFICULTY_RATING_NOW")
	arg_15_0.maxDifficultyTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_DIFFICULTY_RATING_MAX")
	arg_15_0.startTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_BEGIN")

	arg_15_0:UpdateFactorAndScoreView()
end

function var_0_0.UpdateFactorAndScoreView(arg_16_0)
	SetActive(arg_16_0.selectGo_, next(arg_16_0.selectFactorList) == nil)

	local var_16_0 = 1
	local var_16_1 = 1
	local var_16_2 = 0
	local var_16_3 = 0
	local var_16_4 = 0

	for iter_16_0 = 1, 4 do
		SetActive(arg_16_0["upGo" .. iter_16_0 .. "_"], false)
		SetActive(arg_16_0["downGo" .. iter_16_0 .. "_"], false)
	end

	for iter_16_1, iter_16_2 in pairs(arg_16_0.selectFactorList) do
		local var_16_5 = ActivityCombineFactorCfg[iter_16_1]

		var_16_4 = var_16_4 + var_16_5.score

		if var_16_5.score < 0 then
			if var_16_0 <= 3 then
				SetActive(arg_16_0["upGo" .. var_16_0 .. "_"], true)

				arg_16_0["upImg" .. var_16_0 .. "_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. var_16_5.icon)
				var_16_0 = var_16_0 + 1
			else
				var_16_2 = var_16_2 + 1

				SetActive(arg_16_0.upGo4_, true)

				arg_16_0.upCountTxt_.text = var_16_2
			end
		elseif var_16_5.score > 0 then
			if var_16_1 <= 3 then
				SetActive(arg_16_0["downGo" .. var_16_1 .. "_"], true)

				arg_16_0["downImg" .. var_16_1 .. "_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. var_16_5.icon)
				var_16_1 = var_16_1 + 1
			else
				var_16_3 = var_16_3 + 1

				SetActive(arg_16_0.downGo4_, true)

				arg_16_0.downCountTxt_.text = var_16_3
			end
		end
	end

	arg_16_0.factorController:SetSelectedState(var_16_1 == var_16_0 and var_16_0 == 1 and "false" or "true")

	arg_16_0.scoreTxt_.text = var_16_4
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0.isBegin = false

	saveData("CombineGame", "endless", arg_17_0.selectHero)
	manager.windowBar:HideBar()
end

function var_0_0.OnSelectFactorSure(arg_18_0, arg_18_1)
	arg_18_0.selectFactorList = arg_18_1

	local var_18_0
	local var_18_1 = 1

	for iter_18_0, iter_18_1 in pairs(arg_18_1) do
		if var_18_1 == 1 then
			var_18_0 = iter_18_0
		else
			var_18_0 = var_18_0 .. ":" .. iter_18_0
		end

		var_18_1 = var_18_1 + 1
	end

	saveData("CombineGame", "factor", var_18_0)
	arg_18_0:UpdateFactorAndScoreView()

	if arg_18_0.isBegin then
		arg_18_0.isBegin = false

		CombineGameFactory:StartGame(arg_18_0.id, arg_18_0.selectFactorList, arg_18_0.selectHero)
	end
end

function var_0_0.OnTop(arg_19_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.Dispose(arg_20_0)
	var_0_0.super.Dispose(arg_20_0)
	Object.Destroy(arg_20_0.gameObject_)
end

return var_0_0
