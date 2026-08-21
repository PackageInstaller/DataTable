local var_0_0 = class("CombineGameView", ReduxView)
local var_0_1 = CombineGameConst.Type
local var_0_2 = CombineGameConst.TypeText
local var_0_3 = CombineGameConst.VictoryCondition
local var_0_4 = CombineGameConst.BaseInfoConst

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfGameUI"
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

	arg_4_0.stageController = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "stage")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.factorBtn_, nil, function()
		JumpTools.GoToSystem("CombineGameWatchFactorView", {
			id = arg_5_0.levelId,
			factorList = arg_5_0.factorList
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.heroBtn_, nil, function()
		JumpTools.GoToSystem("CombineGameRoleView", {
			roleId = arg_5_0.heroId,
			lv = arg_5_0.gameData.roleLv
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.winMaskBtn_, nil, function()
		SetActive(arg_5_0.winGo_, false)
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.failMaskBtn_, nil, function()
		SetActive(arg_5_0.loseGo_, false)
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.levelMaskBtn_, nil, function()
		SetActive(arg_5_0.levelUpGo_, false)
	end)
	arg_5_0:AddBtnListener(arg_5_0.informationBgBtn_, nil, function()
		SetActive(arg_5_0.informationGo_, false)
	end)
	arg_5_0:AddBtnListener(arg_5_0.foodBtn_, nil, function()
		arg_5_0:ShowBaseInfoView(var_0_1.FOOD, arg_5_0.pos1Go_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.industBtn_, nil, function()
		arg_5_0:ShowBaseInfoView(var_0_1.ROCK, arg_5_0.pos2Go_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.techBtn_, nil, function()
		arg_5_0:ShowBaseInfoView(var_0_1.TECH, arg_5_0.pos3Go_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.pop6MaskBtn_, nil, function()
		SetActive(arg_5_0.pop6Go_, false)
	end)
	arg_5_0:AddBtnListener(arg_5_0.tipsBtn_, nil, function()
		SetActive(arg_5_0.tipsPopGo_, true)

		arg_5_0.tipsTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_GAME_SETTING_1"), arg_5_0.gameData.speed) .. "\n" .. string.format(GetTips("ACTIVITY_COMBINE_GAME_GAME_SETTING_2"), arg_5_0.gameData.maxLevel) .. "\n" .. string.format(GetTips("ACTIVITY_COMBINE_GAME_GAME_SETTING_3"), arg_5_0.gameData.minLevel)
	end)
	arg_5_0:AddBtnListener(arg_5_0.tipsMask_, nil, function()
		SetActive(arg_5_0.tipsPopGo_, false)
	end)
	arg_5_0:AddBtnListener(arg_5_0.costMaskBtn_, nil, function()
		SetActive(arg_5_0.tipsGo_, false)
	end)
	arg_5_0:AddBtnListener(arg_5_0.guideMaskBtn_, nil, function()
		SetActive(arg_5_0.levelUpGo_, false)
	end)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("ACTIVITY_COMBINE_GAME_EXIT_CONFIRM_TIPS"),
			OkCallback = function()
				arg_5_0:Back()
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.homeBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("ACTIVITY_COMBINE_GAME_EXIT_CONFIRM_TIPS"),
			OkCallback = function()
				OperationRecorder.Record(gameContext:GetLastOpenPage(), "homeBtn")
				gameContext:Go("/home", nil, nil, true)
			end
		})
	end)
end

function var_0_0.UpdateView(arg_24_0)
	local var_24_0 = ActivityCombineHeroCfg[arg_24_0.heroId]
	local var_24_1 = ActivityCombineLevelCfg[arg_24_0.levelId]

	if var_24_1.victory_condition_type == var_0_3.ROLE_LEVEL then
		arg_24_0.winConditionTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_VICTORY_CONDITION_1"), var_24_1.victory_condition[1])
	elseif var_24_1.victory_condition_type == var_0_3.TURN then
		arg_24_0.winConditionTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_VICTORY_CONDITION_2"), var_24_1.victory_condition[1])
	elseif var_24_1.victory_condition_type == var_0_3.RESOURCE then
		arg_24_0.winConditionTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_VICTORY_CONDITION_3"), arg_24_0.gameData.totalRock .. "/" .. var_24_1.victory_condition[2], GetTips(var_0_2[var_24_1.victory_condition[1]]))
	elseif var_24_1.victory_condition_type == var_0_3.BEAST then
		arg_24_0.winConditionTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_VICTORY_CONDITION_4"), arg_24_0.tools.beastDestoryCount .. "/" .. var_24_1.victory_condition[2], GetTips(var_0_2[var_24_1.victory_condition[1]]))
	end

	if arg_24_0.gameData.nextTechNeed == 0 then
		arg_24_0.techTxt_.text = arg_24_0.gameData.tech
		arg_24_0.expSlider_.value = 1
	else
		arg_24_0.techTxt_.text = arg_24_0.gameData.tech .. "/" .. arg_24_0.gameData.nextTechNeed
		arg_24_0.expSlider_.value = arg_24_0.gameData.tech / arg_24_0.gameData.nextTechNeed
	end

	SetActive(arg_24_0.nextGo_, arg_24_0.gameData.nextStageTurn < 999)

	if arg_24_0.gameData.nextStageTurn >= 999 then
		arg_24_0.roundTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_TURN_2"), arg_24_0.gameData.nowTurn)
	else
		arg_24_0.roundTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_TURN"), arg_24_0.gameData.nowTurn, arg_24_0.gameData.nextStageTurn)
	end

	arg_24_0.foodTxt_.text = arg_24_0.gameData.food .. "(-" .. arg_24_0.gameData.nextTurnCost[1] .. ")"
	arg_24_0.industryTxt_.text = arg_24_0.gameData.rock
	arg_24_0.heroNameTxt_.text = GetI18NText(var_24_0.name)
	arg_24_0.heroLevelTxt_.text = "lv" .. arg_24_0.gameData.roleLv
	arg_24_0.winTitleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_TASK_NAME")
	arg_24_0.factorTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR")
end

function var_0_0.OnEnter(arg_25_0)
	arg_25_0.levelId = arg_25_0.params_.levelId
	arg_25_0.heroId = arg_25_0.params_.heroId
	arg_25_0.factorList = arg_25_0.params_.factorList
	arg_25_0.result = 3
	arg_25_0.needBury = true
	arg_25_0.gameData = CombineGameFactory:GetGameData()

	arg_25_0:PrepareAction()
	arg_25_0:UpdateView()
end

function var_0_0.UpdateGameData(arg_26_0)
	arg_26_0.tools.speed = arg_26_0.gameData.speed
	arg_26_0.tools.maxLevel = arg_26_0.gameData.maxLevel
	arg_26_0.tools.minLevel = arg_26_0.gameData.minLevel

	arg_26_0.tools.gailv:Clear()
	arg_26_0.tools.gailv:Add(0)

	for iter_26_0 = 1, 5 do
		arg_26_0.tools.gailv:Add(math.max(arg_26_0.gameData.pool[iter_26_0], 0))
	end
end

function var_0_0.PrepareAction(arg_27_0)
	arg_27_0.tools = CombineGameWorld.Instance
	arg_27_0.foodLock = false
	arg_27_0.techLock = false
	arg_27_0.rockLock = false
	arg_27_0.foodList = {}
	arg_27_0.techList = {}
	arg_27_0.rockList = {}

	local var_27_0 = ActivityCombineLevelCfg[arg_27_0.levelId]

	if manager.guide:IsPlaying() and not GuideData:IsFinish(59) then
		arg_27_0.isTech = var_27_0.type == 1
		arg_27_0.tools.isTeach = arg_27_0.isTech
		CombineGameWorld.Instance.canDrag = arg_27_0.isTech == false
	end

	arg_27_0:NextStageView()
	arg_27_0:UpdateStartRole()

	arg_27_0.tools.nextYearAction = handler(arg_27_0, arg_27_0.NextTurnUpdate)
	arg_27_0.tools.startGameAction = handler(arg_27_0, arg_27_0.StartGame)
	arg_27_0.tools.mapExtensionAction = handler(arg_27_0, arg_27_0.MapExtension)

	function arg_27_0.tools.newResourceAction(arg_28_0, arg_28_1)
		arg_27_0:ChangeResource(arg_28_0, arg_28_1)
		arg_27_0:CheckGame()
	end

	function arg_27_0.tools.buildResourceAction(arg_29_0, arg_29_1)
		arg_27_0:BuildChangeResource(arg_29_0, arg_29_1)
		arg_27_0:CheckGame()
	end

	function arg_27_0.tools.informationAction(arg_30_0, arg_30_1, arg_30_2)
		arg_27_0:ShowInformationView(arg_30_0, arg_30_1, arg_30_2)
	end

	arg_27_0.tools:StartGame()
	arg_27_0:UpdateSkill()

	for iter_27_0, iter_27_1 in ipairs(var_27_0.create_cells_location) do
		arg_27_0.tools:AddInitList(iter_27_1[1], iter_27_1[2], iter_27_1[3])
	end
end

function var_0_0.UpdateStartRole(arg_31_0)
	local var_31_0 = ActivityCombineHeroCfg[arg_31_0.heroId]

	for iter_31_0, iter_31_1 in ipairs(var_31_0.level_unlock) do
		if iter_31_0 <= arg_31_0.gameData.roleLv then
			CombineGameFactory:NewFactor(iter_31_1)
		end
	end

	local var_31_1 = var_31_0.level_exp[arg_31_0.gameData.roleLv]
	local var_31_2 = ActivityCombineSettingCfg[arg_31_0.gameData.age].score

	arg_31_0.gameData.nextTechNeed = math.floor(var_31_1 * arg_31_0.gameData.techRate * (100 + var_31_2) / 100)

	if arg_31_0.gameData.roleLv == #var_31_0.level_exp then
		arg_31_0.gameData.nextTechNeed = 0
	end
end

function var_0_0.StartGame(arg_32_0)
	arg_32_0.tools.rock = arg_32_0.gameData.rock

	arg_32_0.tools.spriteList:Clear()
	arg_32_0.tools.spriteList:Add(AtlasManager.GetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. 1))

	for iter_32_0, iter_32_1 in ipairs(GameSetting.activity_combine_game_icon.value) do
		arg_32_0.tools.spriteList:Add(AtlasManager.GetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. iter_32_1))
	end

	arg_32_0.tools.skillSprites:Clear()

	for iter_32_2, iter_32_3 in ipairs(ActivityCombineSkillCfg.all) do
		local var_32_0 = ActivityCombineSkillCfg[iter_32_3]

		arg_32_0.tools.skillSprites[var_32_0.id] = AtlasManager.GetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. var_32_0.icon)
	end

	arg_32_0.heroIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. ActivityCombineHeroCfg[arg_32_0.heroId].Icon_2)

	arg_32_0.stageController:SetSelectedState("box1")
	arg_32_0:SetInitBlock()
	arg_32_0:UpdateGameData()
end

function var_0_0.MapExtension(arg_33_0)
	arg_33_0.stageController:SetSelectedState("box2")

	for iter_33_0 = 1, 10 do
		arg_33_0.tools:NewBlock()
	end
end

function var_0_0.ShowInformationView(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	SetActive(arg_34_0.informationGo_, true)

	if arg_34_1 ~= 0 then
		local var_34_0 = ActivityCombineSkillCfg[arg_34_1]

		arg_34_0.informationTxt_.text = GetI18NText(var_34_0.description)
		arg_34_0.cdTxt_.text = "CD:" .. math.max(var_34_0.cd + arg_34_0.gameData.effectCD, 0)
	end

	arg_34_0.informationGo_.transform.position = arg_34_3.position
end

function var_0_0.SetInitBlock(arg_35_0)
	local var_35_0 = GameSetting.activity_combine_game_init_cells_location.value
	local var_35_1 = ActivityCombineLevelCfg[arg_35_0.levelId]

	if next(var_35_1.init_cells_location) then
		for iter_35_0, iter_35_1 in ipairs(var_35_1.init_cells_location) do
			arg_35_0.tools:NewBlock(iter_35_1[1], iter_35_1[2], iter_35_1[3], iter_35_1[4])
		end
	else
		local var_35_2 = 0

		arg_35_0.tools.minLevel = arg_35_0.gameData.minLevel

		arg_35_0.tools.gailv:Clear()
		arg_35_0.tools.gailv:Add(0)

		for iter_35_2 = 1, 5 do
			arg_35_0.tools.gailv:Add(var_35_0[iter_35_2])

			var_35_2 = var_35_2 + var_35_0[iter_35_2]
		end

		arg_35_0.tools:NewPoor()

		for iter_35_3 = 1, var_35_2 do
			arg_35_0.tools:NewBlock()
		end
	end
end

function var_0_0.UpdateSkill(arg_36_0)
	for iter_36_0, iter_36_1 in ipairs(arg_36_0.gameData.skillList) do
		local var_36_0 = ActivityCombineSkillCfg[iter_36_1]

		arg_36_0.tools:UpdateSkill(iter_36_0 - 1, iter_36_1, math.max(var_36_0.cost + arg_36_0.gameData.skillCost, 0), math.max(var_36_0.cd + arg_36_0.gameData.effectCD, 0))
	end
end

function var_0_0.PlayAnimation(arg_37_0, arg_37_1, arg_37_2)
	local function var_37_0(arg_38_0)
		TimeTools.StartAfterSeconds(0.5, function()
			arg_37_0[arg_38_0 .. "Lock"] = false

			if arg_37_0[arg_38_0 .. "List"][1] then
				arg_37_0[arg_38_0 .. "AddAni_"]:Play("token_text", -1, 0)

				arg_37_0[arg_38_0 .. "AddTxt_"].text = arg_37_0[arg_38_0 .. "List"][1]

				table.remove(arg_37_0[arg_38_0 .. "List"], 1)

				arg_37_0[arg_38_0 .. "Lock"] = true

				var_37_0(arg_38_0)
			end
		end, {})
	end

	table.insert(arg_37_0[arg_37_1 .. "List"], (arg_37_2 >= 0 and "+" or "") .. arg_37_2)

	if arg_37_0[arg_37_1 .. "Lock"] == false then
		arg_37_0[arg_37_1 .. "Lock"] = true
		arg_37_0[arg_37_1 .. "AddTxt_"].text = arg_37_0[arg_37_1 .. "List"][1]

		arg_37_0[arg_37_1 .. "AddAni_"]:Play("token_text", -1, 0)
		table.remove(arg_37_0[arg_37_1 .. "List"], 1)
		var_37_0(arg_37_1)
	end
end

function var_0_0.BuildChangeResource(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = 0

	for iter_40_0 = 1, arg_40_2 do
		var_40_0 = var_40_0 + CombineGameFactory.ChangeResource(var_0_1.TECH, arg_40_1)
	end

	if var_40_0 == 0 then
		return
	end

	arg_40_0.gameData.tech = arg_40_0.gameData.tech + var_40_0

	if arg_40_0.gameData.nextTechNeed == 0 then
		arg_40_0.techTxt_.text = arg_40_0.gameData.tech
	else
		arg_40_0.techTxt_.text = arg_40_0.gameData.tech .. "/" .. arg_40_0.gameData.nextTechNeed
	end

	arg_40_0.expSlider_.value = arg_40_0.gameData.tech / arg_40_0.gameData.nextTechNeed
	arg_40_0.gameData.totalTech = arg_40_0.gameData.totalTech + (var_40_0 > 0 and var_40_0 or 0)

	arg_40_0:PlayAnimation("tech", var_40_0)
end

function var_0_0.ChangeResource(arg_41_0, arg_41_1, arg_41_2)
	arg_41_2 = CombineGameFactory.ChangeResource(arg_41_1, arg_41_2)

	if arg_41_2 == 0 then
		return
	end

	if arg_41_1 == var_0_1.FOOD then
		arg_41_0.gameData.food = arg_41_0.gameData.food + arg_41_2
		arg_41_0.foodTxt_.text = arg_41_0.gameData.food .. "(-" .. arg_41_0.gameData.nextTurnCost[1] .. ")"
		arg_41_0.gameData.totalFood = arg_41_0.gameData.totalFood + (arg_41_2 > 0 and arg_41_2 or 0)

		arg_41_0:PlayAnimation("food", arg_41_2)
	elseif arg_41_1 == var_0_1.TECH then
		arg_41_0.gameData.tech = arg_41_0.gameData.tech + arg_41_2

		if arg_41_0.gameData.nextTechNeed == 0 then
			arg_41_0.techTxt_.text = arg_41_0.gameData.tech
		else
			arg_41_0.techTxt_.text = arg_41_0.gameData.tech .. "/" .. arg_41_0.gameData.nextTechNeed
		end

		arg_41_0.expSlider_.value = arg_41_0.gameData.tech / arg_41_0.gameData.nextTechNeed
		arg_41_0.gameData.totalTech = arg_41_0.gameData.totalTech + (arg_41_2 > 0 and arg_41_2 or 0)

		arg_41_0:PlayAnimation("tech", arg_41_2)
	elseif arg_41_1 == var_0_1.ROCK then
		arg_41_0.gameData.rock = arg_41_0.gameData.rock + arg_41_2
		arg_41_0.industryTxt_.text = arg_41_0.gameData.rock
		arg_41_0.tools.rock = arg_41_0.gameData.rock
		arg_41_0.gameData.totalRock = arg_41_0.gameData.totalRock + (arg_41_2 > 0 and arg_41_2 or 0)

		arg_41_0:PlayAnimation("rock", arg_41_2)
	end
end

function var_0_0.CheckGame(arg_42_0)
	arg_42_0.tools:RefreshSkillStage()
	SetActive(arg_42_0.foodPopGo_, arg_42_0.gameData.food <= 10)

	if arg_42_0.gameData.tech >= arg_42_0.gameData.nextTechNeed and arg_42_0.gameData.nextTechNeed ~= 0 then
		arg_42_0:RoleLevelUpView()
		arg_42_0:UpdateGameData()
		arg_42_0:UpdateView()
	end

	if arg_42_0.gameData.food < 0 then
		arg_42_0:GameFail()

		return
	end

	if arg_42_0:CheckVictory() then
		arg_42_0:GameWin()

		return
	end
end

function var_0_0.NextTurnUpdate(arg_43_0)
	arg_43_0:ChangeResource(var_0_1.FOOD, -arg_43_0.gameData.nextTurnCost[var_0_1.FOOD])
	arg_43_0:ChangeResource(var_0_1.ROCK, -arg_43_0.gameData.nextTurnCost[var_0_1.ROCK])
	arg_43_0:ChangeResource(var_0_1.TECH, -arg_43_0.gameData.nextTurnCost[var_0_1.TECH])

	arg_43_0.gameData.nowTurn = arg_43_0.gameData.nowTurn + 1

	arg_43_0:CheckGame()

	if arg_43_0.gameData.nextStageTurn >= 999 then
		arg_43_0.roundTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_TURN_2"), arg_43_0.gameData.nowTurn)
	else
		arg_43_0.roundTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_TURN"), arg_43_0.gameData.nowTurn, arg_43_0.gameData.nextStageTurn)
	end

	if arg_43_0.gameData.nowTurn > arg_43_0.gameData.nextStageTurn then
		arg_43_0:NextStageView()
		arg_43_0:UpdateGameData()
		arg_43_0:UpdateView()
	end

	arg_43_0.tools.speed = arg_43_0.gameData.speed
	arg_43_0.tools.maxLevel = arg_43_0.gameData.maxLevel
	arg_43_0.tools.minLevel = arg_43_0.gameData.minLevel
end

function var_0_0.CheckVictory(arg_44_0)
	local var_44_0 = ActivityCombineLevelCfg[arg_44_0.levelId]

	if var_44_0.victory_condition_type == var_0_3.ROLE_LEVEL then
		return arg_44_0.gameData.roleLv >= var_44_0.victory_condition[1]
	elseif var_44_0.victory_condition_type == var_0_3.TURN then
		return arg_44_0.gameData.nowTurn >= var_44_0.victory_condition[1]
	elseif var_44_0.victory_condition_type == var_0_3.RESOURCE then
		local var_44_1

		if var_44_0.victory_condition[1] == var_0_1.FOOD then
			var_44_1 = arg_44_0.gameData.totalFood
		elseif var_44_0.victory_condition[1] == var_0_1.ROCK then
			var_44_1 = arg_44_0.gameData.totalRock
		elseif var_44_0.victory_condition[1] == var_0_1.TECH then
			var_44_1 = arg_44_0.gameData.totalTech
		end

		arg_44_0.winConditionTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_VICTORY_CONDITION_3"), var_44_1 .. "/" .. var_44_0.victory_condition[2], GetTips(var_0_2[var_44_0.victory_condition[1]]))

		return var_44_1 >= var_44_0.victory_condition[2]
	elseif var_44_0.victory_condition_type == var_0_3.BEAST then
		arg_44_0.winConditionTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_VICTORY_CONDITION_4"), arg_44_0.tools.beastDestoryCount .. "/" .. var_44_0.victory_condition[2], GetTips(var_0_2[var_44_0.victory_condition[1]]))

		return arg_44_0.tools.beastDestoryCount >= var_44_0.victory_condition[2]
	end

	return false
end

function var_0_0.GameWin(arg_45_0)
	arg_45_0.winTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_VICTORY")
	arg_45_0.result = 1

	SetActive(arg_45_0.winGo_, true)
	CombineGameFactory:EndGame(arg_45_0.levelId, arg_45_0.factorList, true)

	local var_45_0 = arg_45_0:CalculateScore()
	local var_45_1 = CombineGameData:GetDataByPara("stageDataTable")[arg_45_0.levelId]
	local var_45_2 = ActivityCombineLevelCfg[arg_45_0.levelId]

	if arg_45_0.result == 1 and (var_45_1 ~= true or var_45_2.type == CombineGameConst.TypeConst.ENDLESS) then
		CombineGameAction.GameWin(arg_45_0.levelId, var_45_0)
	end
end

function var_0_0.GameFail(arg_46_0)
	arg_46_0.loseTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_DEFEAT")
	arg_46_0.result = 2

	SetActive(arg_46_0.loseGo_, true)
	CombineGameFactory:EndGame(arg_46_0.levelId, arg_46_0.factorList, false)
end

function var_0_0.NextStageView(arg_47_0)
	arg_47_0.gameData.age = arg_47_0.gameData.age + 1

	local var_47_0 = ActivityCombineSettingCfg[arg_47_0.gameData.age]

	if var_47_0 == nil then
		arg_47_0.gameData.nextStageTurn = 999

		return
	end

	arg_47_0.gameData.nextStageTurn = var_47_0.rounds * arg_47_0.gameData.turnRate
	arg_47_0.gameData.nextTurnCost[1] = math.max(arg_47_0.gameData.nextTurnCost[1] + var_47_0.food_cost, 0)

	for iter_47_0, iter_47_1 in ipairs(var_47_0.cells_list) do
		arg_47_0.gameData.pool[iter_47_0] = arg_47_0.gameData.pool[iter_47_0] + iter_47_1
	end

	if arg_47_0.gameData.stageFoodChange[arg_47_0.gameData.age] then
		arg_47_0.gameData.resourceChange[var_0_1.FOOD] = arg_47_0.gameData.resourceChange[var_0_1.FOOD] + arg_47_0.gameData.stageFoodChange[arg_47_0.gameData.age]
	end

	arg_47_0.tools.mapExtension = var_47_0.map_bigger == 1

	if arg_47_0.gameData.age ~= 1 then
		arg_47_0.nextStageTipsTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_CONSUME_INCREASE"), var_47_0.food_cost)
		arg_47_0.stageDescTxt_.text = GetI18NText(var_47_0.desc)

		SetActive(arg_47_0.nextStageTipsTxt_.transform.parent.gameObject, var_47_0.food_cost ~= 0)
		TimeTools.StartAfterSeconds(1, function()
			SetActive(arg_47_0.tipsGo_, true)
		end, {})
	end
end

function var_0_0.RoleLevelUpView(arg_49_0)
	local var_49_0 = ActivityCombineHeroCfg[arg_49_0.heroId]

	if arg_49_0.gameData.roleLv == #var_49_0.level_unlock then
		return
	end

	arg_49_0.oldLvTxt_.text = string.format(GetTips("DORM_LEVEL_TIPS"), arg_49_0.gameData.roleLv)
	arg_49_0.gameData.roleLv = math.min(arg_49_0.gameData.roleLv + 1, #var_49_0.level_unlock)
	arg_49_0.newLvTxt_.text = string.format(GetTips("DORM_LEVEL_TIPS"), arg_49_0.gameData.roleLv)
	arg_49_0.levelUpTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_HERO_LEVEL_UP"), arg_49_0.gameData.roleLv)
	arg_49_0.gameData.tech = arg_49_0.gameData.tech - arg_49_0.gameData.nextTechNeed

	local var_49_1 = ActivityCombineSettingCfg[arg_49_0.gameData.age]

	if var_49_1 == nil then
		print("daawasdfasfdaw" .. arg_49_0.gameData.age)

		var_49_1 = ActivityCombineSettingCfg[arg_49_0.gameData.age - 1]
	end

	local var_49_2 = var_49_1.score

	if arg_49_0.gameData.roleLv == #var_49_0.level_unlock then
		arg_49_0.gameData.nextTechNeed = 0
	else
		arg_49_0.gameData.nextTechNeed = math.floor(var_49_0.level_exp[arg_49_0.gameData.roleLv] * arg_49_0.gameData.techRate * (100 + var_49_2) / 100)
	end

	local var_49_3 = ActivityCombineFactorCfg[var_49_0.level_unlock[arg_49_0.gameData.roleLv]]

	if var_49_3.effect_type == 1 then
		local var_49_4 = ActivityCombineSkillCfg[var_49_3.effect[1]]

		arg_49_0.skillDescTxt_.text = GetI18NText(var_49_4.description)
		arg_49_0.skillImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. var_49_4.icon)
	else
		arg_49_0.skillDescTxt_.text = GetI18NText(var_49_3.description)
		arg_49_0.skillImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. var_49_3.icon)
	end

	if arg_49_0.gameData.nextTechNeed == 0 then
		arg_49_0.expSlider_.value = 1
	else
		arg_49_0.expSlider_.value = arg_49_0.gameData.tech / arg_49_0.gameData.nextTechNeed
	end

	if manager.guide:IsPlaying() then
		TimeTools.StartAfterSeconds(0.07, function()
			SetActive(arg_49_0.levelUpGo_, true)
		end, {})
	else
		TimeTools.StartAfterSeconds(1, function()
			SetActive(arg_49_0.levelUpGo_, true)
		end, {})
	end

	CombineGameFactory:NewFactor(var_49_0.level_unlock[arg_49_0.gameData.roleLv], true)

	if arg_49_0.gameData.needRefreshSkill then
		arg_49_0.gameData.needRefreshSkill = false

		arg_49_0:UpdateGameData()
		arg_49_0:UpdateSkill()
	elseif arg_49_0.gameData.needRefreshBlock then
		arg_49_0.gameData.needRefreshBlock = false

		arg_49_0:UpdateGameData()
		arg_49_0.tools:RefreshAllBlock()
	end

	arg_49_0.tools:RefreshSkillStage()
end

function var_0_0.ShowBaseInfoView(arg_52_0, arg_52_1, arg_52_2)
	SetActive(arg_52_0.pop6Go_, true)

	arg_52_0.pop6Go_.transform.position = arg_52_2.transform.position
	arg_52_0.pop6DescTxt_.text = GetTips(var_0_4[arg_52_1])
end

function var_0_0.CalculateScore(arg_53_0)
	local var_53_0 = 0

	for iter_53_0, iter_53_1 in pairs(arg_53_0.factorList or {}) do
		var_53_0 = var_53_0 + ActivityCombineFactorCfg[iter_53_0].score
	end

	return var_53_0
end

function var_0_0.BuryPoint(arg_54_0)
	if arg_54_0.needBury == false then
		return
	end

	if arg_54_0.needBury == true then
		arg_54_0.needBury = false
	end

	local var_54_0 = arg_54_0.tools:DetailBuryPointNeedData()
	local var_54_1 = {}

	for iter_54_0 = 1, var_54_0.Count do
		if var_54_1[var_54_0[iter_54_0 - 1]] == nil then
			var_54_1[var_54_0[iter_54_0 - 1]] = 1
		else
			var_54_1[var_54_0[iter_54_0 - 1]] = var_54_1[var_54_0[iter_54_0 - 1]] + 1
		end
	end

	local var_54_2 = {}

	for iter_54_1, iter_54_2 in pairs(var_54_1) do
		table.insert(var_54_2, iter_54_1 .. "," .. iter_54_2)
	end

	local var_54_3 = {}
	local var_54_4 = arg_54_0.tools.skillUseCount
	local var_54_5

	for iter_54_3, iter_54_4 in ipairs(ActivityCombineSkillCfg.all) do
		if var_54_4:TryGetValue(iter_54_4, var_54_5) then
			var_54_3[iter_54_4] = var_54_4[iter_54_4]
		end
	end

	local var_54_6 = {}

	for iter_54_5, iter_54_6 in pairs(var_54_3) do
		table.insert(var_54_6, iter_54_5 .. "," .. iter_54_6)
	end

	local var_54_7 = arg_54_0:CalculateScore()
	local var_54_8 = ActivityCombineLevelCfg[arg_54_0.levelId]

	SDKTools.SendMessageToSDK("match_threepuzzle_over", {
		hero_id = arg_54_0.heroId,
		level_id = arg_54_0.gameData.roleLv,
		stage_id = arg_54_0.levelId,
		battle_times = arg_54_0.gameData.nowTurn,
		point_list = table.toString(var_54_2),
		skill_list = table.toString(var_54_6),
		result = arg_54_0.result,
		score = var_54_8.type == 3 and var_54_7 or nil
	})
end

function var_0_0.OnExit(arg_55_0)
	arg_55_0:BuryPoint()
	arg_55_0.tools:ResetGame()
	arg_55_0.tools:EndDrag()

	arg_55_0.foodAddTxt_.text = ""
	arg_55_0.rockAddTxt_.text = ""
	arg_55_0.techAddTxt_.text = ""

	SetActive(arg_55_0.tipsGo_, false)
	SetActive(arg_55_0.winGo_, false)
	SetActive(arg_55_0.loseGo_, false)
	SetActive(arg_55_0.levelUpGo_, false)
	SetActive(arg_55_0.informationGo_, false)
	SetActive(arg_55_0.pop6Go_, false)
	SetActive(arg_55_0.foodPopGo_, false)
	SetActive(arg_55_0.tipsPopGo_, false)
end

function var_0_0.Dispose(arg_56_0)
	arg_56_0:BuryPoint()
	var_0_0.super.Dispose(arg_56_0)
	Object.Destroy(arg_56_0.gameObject_)
end

return var_0_0
