local CombineGameView = class("CombineGameView", ReduxView)
local var_0_1 = CombineGameConst.Type
local var_0_2 = CombineGameConst.TypeText
local var_0_3 = CombineGameConst.VictoryCondition
local var_0_4 = CombineGameConst.BaseInfoConst

function CombineGameView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfGameUI"
end

function CombineGameView:UIParent()
	return manager.ui.uiMain.transform
end

function CombineGameView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CombineGameView:InitUI()
	self:BindCfgUI()

	self.stageController = ControllerUtil.GetController(self.gameObject_.transform, "stage")
end

function CombineGameView:AddUIListener()
	self:AddBtnListener(self.factorBtn_, nil, function()
		JumpTools.GoToSystem("CombineGameWatchFactorView", {
			id = self.levelId,
			factorList = self.factorList
		})
	end)
	self:AddBtnListener(self.heroBtn_, nil, function()
		JumpTools.GoToSystem("CombineGameRoleView", {
			roleId = self.heroId,
			lv = self.gameData.roleLv
		})
	end)
	self:AddBtnListener(self.winMaskBtn_, nil, function()
		SetActive(self.winGo_, false)
		self:Back()
	end)
	self:AddBtnListener(self.failMaskBtn_, nil, function()
		SetActive(self.loseGo_, false)
		self:Back()
	end)
	self:AddBtnListener(self.levelMaskBtn_, nil, function()
		SetActive(self.levelUpGo_, false)
	end)
	self:AddBtnListener(self.informationBgBtn_, nil, function()
		SetActive(self.informationGo_, false)
	end)
	self:AddBtnListener(self.foodBtn_, nil, function()
		self:ShowBaseInfoView(var_0_1.FOOD, self.pos1Go_)
	end)
	self:AddBtnListener(self.industBtn_, nil, function()
		self:ShowBaseInfoView(var_0_1.ROCK, self.pos2Go_)
	end)
	self:AddBtnListener(self.techBtn_, nil, function()
		self:ShowBaseInfoView(var_0_1.TECH, self.pos3Go_)
	end)
	self:AddBtnListener(self.pop6MaskBtn_, nil, function()
		SetActive(self.pop6Go_, false)
	end)
	self:AddBtnListener(self.tipsBtn_, nil, function()
		SetActive(self.tipsPopGo_, true)

		self.tipsTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_GAME_SETTING_1"), self.gameData.speed) .. "\n" .. string.format(GetTips("ACTIVITY_COMBINE_GAME_GAME_SETTING_2"), self.gameData.maxLevel) .. "\n" .. string.format(GetTips("ACTIVITY_COMBINE_GAME_GAME_SETTING_3"), self.gameData.minLevel)
	end)
	self:AddBtnListener(self.tipsMask_, nil, function()
		SetActive(self.tipsPopGo_, false)
	end)
	self:AddBtnListener(self.costMaskBtn_, nil, function()
		SetActive(self.tipsGo_, false)
	end)
	self:AddBtnListener(self.guideMaskBtn_, nil, function()
		SetActive(self.levelUpGo_, false)
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("ACTIVITY_COMBINE_GAME_EXIT_CONFIRM_TIPS"),
			OkCallback = function()
				self:Back()
			end
		})
	end)
	self:AddBtnListener(self.homeBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("ACTIVITY_COMBINE_GAME_EXIT_CONFIRM_TIPS"),
			OkCallback = function()
				OperationRecorder.Record(gameContext:GetLastOpenPage(), "homeBtn")
				gameContext:Go("/home", nil, nil, true)
			end
		})
	end)
end

function CombineGameView:UpdateView()
	local var_24_0 = ActivityCombineHeroCfg[self.heroId]

	if ActivityCombineLevelCfg[self.levelId].victory_condition_type == var_0_3.ROLE_LEVEL then
		self.winConditionTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_VICTORY_CONDITION_1"), ActivityCombineLevelCfg[self.levelId].victory_condition[1])
	elseif ActivityCombineLevelCfg[self.levelId].victory_condition_type == var_0_3.TURN then
		self.winConditionTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_VICTORY_CONDITION_2"), ActivityCombineLevelCfg[self.levelId].victory_condition[1])
	elseif ActivityCombineLevelCfg[self.levelId].victory_condition_type == var_0_3.RESOURCE then
		self.winConditionTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_VICTORY_CONDITION_3"), self.gameData.totalRock .. "/" .. ActivityCombineLevelCfg[self.levelId].victory_condition[2], GetTips(var_0_2[ActivityCombineLevelCfg[self.levelId].victory_condition[1]]))
	elseif ActivityCombineLevelCfg[self.levelId].victory_condition_type == var_0_3.BEAST then
		self.winConditionTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_VICTORY_CONDITION_4"), self.tools.beastDestoryCount .. "/" .. ActivityCombineLevelCfg[self.levelId].victory_condition[2], GetTips(var_0_2[ActivityCombineLevelCfg[self.levelId].victory_condition[1]]))
	end

	if self.gameData.nextTechNeed == 0 then
		self.techTxt_.text = self.gameData.tech
		self.expSlider_.value = 1
	else
		self.techTxt_.text = self.gameData.tech .. "/" .. self.gameData.nextTechNeed
		self.expSlider_.value = self.gameData.tech / self.gameData.nextTechNeed
	end

	SetActive(self.nextGo_, self.gameData.nextStageTurn < 999)

	self.roundTxt_.text = self.gameData.nextStageTurn >= 999 and string.format(GetTips("ACTIVITY_COMBINE_GAME_TURN_2"), self.gameData.nowTurn) or string.format(GetTips("ACTIVITY_COMBINE_GAME_TURN"), self.gameData.nowTurn, self.gameData.nextStageTurn)
	self.foodTxt_.text = self.gameData.food .. "(-" .. self.gameData.nextTurnCost[1] .. ")"
	self.industryTxt_.text = self.gameData.rock
	self.heroNameTxt_.text = GetI18NText(var_24_0.name)
	self.heroLevelTxt_.text = "lv" .. self.gameData.roleLv
	self.winTitleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_TASK_NAME")
	self.factorTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR")
end

function CombineGameView:OnEnter()
	self.levelId = self.params_.levelId
	self.heroId = self.params_.heroId
	self.factorList = self.params_.factorList
	self.result = 3
	self.needBury = true
	self.gameData = CombineGameFactory:GetGameData()

	self:PrepareAction()
	self:UpdateView()
end

function CombineGameView:UpdateGameData()
	self.tools.speed = self.gameData.speed
	self.tools.maxLevel = self.gameData.maxLevel
	self.tools.minLevel = self.gameData.minLevel

	self.tools.gailv:Clear()
	self.tools.gailv:Add(0)

	for iter_26_0 = 1, 5 do
		self.tools.gailv:Add(math.max(self.gameData.pool[iter_26_0], 0))
	end
end

function CombineGameView:PrepareAction()
	self.tools = CombineGameWorld.Instance
	self.foodLock = false
	self.techLock = false
	self.rockLock = false
	self.foodList = {}
	self.techList = {}
	self.rockList = {}

	local var_27_0 = ActivityCombineLevelCfg[self.levelId]

	if manager.guide:IsPlaying() and not GuideData:IsFinish(59) then
		self.isTech = var_27_0.type == 1
		self.tools.isTeach = self.isTech
		CombineGameWorld.Instance.canDrag = self.isTech == false
	end

	self:NextStageView()
	self:UpdateStartRole()

	self.tools.nextYearAction = handler(self, self.NextTurnUpdate)
	self.tools.startGameAction = handler(self, self.StartGame)
	self.tools.mapExtensionAction = handler(self, self.MapExtension)

	function self.tools.newResourceAction(arg_28_0, arg_28_1)
		self:ChangeResource(arg_28_0, arg_28_1)
		self:CheckGame()
	end

	function self.tools.buildResourceAction(arg_29_0, arg_29_1)
		self:BuildChangeResource(arg_29_0, arg_29_1)
		self:CheckGame()
	end

	function self.tools.informationAction(arg_30_0, arg_30_1, arg_30_2)
		self:ShowInformationView(arg_30_0, arg_30_1, arg_30_2)
	end

	self.tools:StartGame()
	self:UpdateSkill()

	for iter_27_0, iter_27_1 in ipairs(var_27_0.create_cells_location) do
		self.tools:AddInitList(iter_27_1[1], iter_27_1[2], iter_27_1[3])
	end
end

function CombineGameView:UpdateStartRole()
	for iter_31_0, iter_31_1 in ipairs(ActivityCombineHeroCfg[self.heroId].level_unlock) do
		if iter_31_0 <= self.gameData.roleLv then
			CombineGameFactory:NewFactor(iter_31_1)
		end
	end

	self.gameData.nextTechNeed = math.floor(ActivityCombineHeroCfg[self.heroId].level_exp[self.gameData.roleLv] * self.gameData.techRate * (100 + ActivityCombineSettingCfg[self.gameData.age].score) / 100)

	if self.gameData.roleLv == #ActivityCombineHeroCfg[self.heroId].level_exp then
		self.gameData.nextTechNeed = 0
	end
end

function CombineGameView:StartGame()
	self.tools.rock = self.gameData.rock

	self.tools.spriteList:Clear()
	self.tools.spriteList:Add(AtlasManager.GetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. 1))

	for iter_32_0, iter_32_1 in ipairs(GameSetting.activity_combine_game_icon.value) do
		self.tools.spriteList:Add(AtlasManager.GetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. iter_32_1))
	end

	self.tools.skillSprites:Clear()

	for iter_32_2, iter_32_3 in ipairs(ActivityCombineSkillCfg.all) do
		self.tools.skillSprites[ActivityCombineSkillCfg[iter_32_3].id] = AtlasManager.GetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. ActivityCombineSkillCfg[iter_32_3].icon)
	end

	self.heroIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. ActivityCombineHeroCfg[self.heroId].Icon_2)

	self.stageController:SetSelectedState("box1")
	self:SetInitBlock()
	self:UpdateGameData()
end

function CombineGameView:MapExtension()
	self.stageController:SetSelectedState("box2")

	for iter_33_0 = 1, 10 do
		self.tools:NewBlock()
	end
end

function CombineGameView:ShowInformationView(arg_34_1, arg_34_2, arg_34_3)
	SetActive(self.informationGo_, true)

	if arg_34_1 ~= 0 then
		self.informationTxt_.text = GetI18NText(ActivityCombineSkillCfg[arg_34_1].description)
		self.cdTxt_.text = "CD:" .. math.max(ActivityCombineSkillCfg[arg_34_1].cd + self.gameData.effectCD, 0)
	end

	self.informationGo_.transform.position = arg_34_3.position
end

function CombineGameView:SetInitBlock()
	if next(ActivityCombineLevelCfg[self.levelId].init_cells_location) then
		for iter_35_0, iter_35_1 in ipairs(ActivityCombineLevelCfg[self.levelId].init_cells_location) do
			self.tools:NewBlock(iter_35_1[1], iter_35_1[2], iter_35_1[3], iter_35_1[4])
		end
	else
		local var_35_0 = 0

		self.tools.minLevel = self.gameData.minLevel

		self.tools.gailv:Clear()
		self.tools.gailv:Add(0)

		for iter_35_2 = 1, 5 do
			self.tools.gailv:Add(GameSetting.activity_combine_game_init_cells_location.value[iter_35_2])

			var_35_0 = var_35_0 + GameSetting.activity_combine_game_init_cells_location.value[iter_35_2]
		end

		self.tools:NewPoor()

		for iter_35_3 = 1, var_35_0 do
			self.tools:NewBlock()
		end
	end
end

function CombineGameView:UpdateSkill()
	for iter_36_0, iter_36_1 in ipairs(self.gameData.skillList) do
		self.tools:UpdateSkill(iter_36_0 - 1, iter_36_1, math.max(ActivityCombineSkillCfg[iter_36_1].cost + self.gameData.skillCost, 0), math.max(ActivityCombineSkillCfg[iter_36_1].cd + self.gameData.effectCD, 0))
	end
end

function CombineGameView:PlayAnimation(arg_37_1, arg_37_2)
	local function var_37_0(arg_38_0)
		TimeTools.StartAfterSeconds(0.5, function()
			self[arg_38_0 .. "Lock"] = false

			if self[arg_38_0 .. "List"][1] then
				self[arg_38_0 .. "AddAni_"]:Play("token_text", -1, 0)

				self[arg_38_0 .. "AddTxt_"].text = self[arg_38_0 .. "List"][1]

				table.remove(self[arg_38_0 .. "List"], 1)

				self[arg_38_0 .. "Lock"] = true

				var_37_0(arg_38_0)
			end
		end, {})
	end

	table.insert(self[arg_37_1 .. "List"], (arg_37_2 >= 0 and "+" or "") .. arg_37_2)

	if self[arg_37_1 .. "Lock"] == false then
		self[arg_37_1 .. "Lock"] = true
		self[arg_37_1 .. "AddTxt_"].text = self[arg_37_1 .. "List"][1]

		self[arg_37_1 .. "AddAni_"]:Play("token_text", -1, 0)
		table.remove(self[arg_37_1 .. "List"], 1)
		var_37_0(arg_37_1)
	end
end

function CombineGameView:BuildChangeResource(arg_40_1, arg_40_2)
	local var_40_0 = 0

	for iter_40_0 = 1, arg_40_2 do
		var_40_0 = var_40_0 + CombineGameFactory.ChangeResource(var_0_1.TECH, arg_40_1)
	end

	if var_40_0 == 0 then
		return
	end

	self.gameData.tech = self.gameData.tech + var_40_0
	self.techTxt_.text = self.gameData.nextTechNeed == 0 and self.gameData.tech or self.gameData.tech .. "/" .. self.gameData.nextTechNeed
	self.expSlider_.value = self.gameData.tech / self.gameData.nextTechNeed
	self.gameData.totalTech = self.gameData.totalTech + (var_40_0 > 0 and var_40_0 or 0)

	self:PlayAnimation("tech", var_40_0)
end

function CombineGameView:ChangeResource(arg_41_1, arg_41_2)
	arg_41_2 = CombineGameFactory.ChangeResource(arg_41_1, arg_41_2)

	if arg_41_2 == 0 then
		return
	end

	if arg_41_1 == var_0_1.FOOD then
		self.gameData.food = self.gameData.food + arg_41_2
		self.foodTxt_.text = self.gameData.food .. "(-" .. self.gameData.nextTurnCost[1] .. ")"
		self.gameData.totalFood = self.gameData.totalFood + (arg_41_2 > 0 and arg_41_2 or 0)

		self:PlayAnimation("food", arg_41_2)
	elseif arg_41_1 == var_0_1.TECH then
		self.gameData.tech = self.gameData.tech + arg_41_2
		self.techTxt_.text = self.gameData.nextTechNeed == 0 and self.gameData.tech or self.gameData.tech .. "/" .. self.gameData.nextTechNeed
		self.expSlider_.value = self.gameData.tech / self.gameData.nextTechNeed
		self.gameData.totalTech = self.gameData.totalTech + (arg_41_2 > 0 and arg_41_2 or 0)

		self:PlayAnimation("tech", arg_41_2)
	elseif arg_41_1 == var_0_1.ROCK then
		self.gameData.rock = self.gameData.rock + arg_41_2
		self.industryTxt_.text = self.gameData.rock
		self.tools.rock = self.gameData.rock
		self.gameData.totalRock = self.gameData.totalRock + (arg_41_2 > 0 and arg_41_2 or 0)

		self:PlayAnimation("rock", arg_41_2)
	end
end

function CombineGameView:CheckGame()
	self.tools:RefreshSkillStage()
	SetActive(self.foodPopGo_, self.gameData.food <= 10)

	if self.gameData.tech >= self.gameData.nextTechNeed and self.gameData.nextTechNeed ~= 0 then
		self:RoleLevelUpView()
		self:UpdateGameData()
		self:UpdateView()
	end

	if self.gameData.food < 0 then
		self:GameFail()

		return
	end

	if self:CheckVictory() then
		self:GameWin()

		return
	end
end

function CombineGameView:NextTurnUpdate()
	self:ChangeResource(var_0_1.FOOD, -self.gameData.nextTurnCost[var_0_1.FOOD])
	self:ChangeResource(var_0_1.ROCK, -self.gameData.nextTurnCost[var_0_1.ROCK])
	self:ChangeResource(var_0_1.TECH, -self.gameData.nextTurnCost[var_0_1.TECH])

	self.gameData.nowTurn = self.gameData.nowTurn + 1

	self:CheckGame()

	self.roundTxt_.text = self.gameData.nextStageTurn >= 999 and string.format(GetTips("ACTIVITY_COMBINE_GAME_TURN_2"), self.gameData.nowTurn) or string.format(GetTips("ACTIVITY_COMBINE_GAME_TURN"), self.gameData.nowTurn, self.gameData.nextStageTurn)

	if self.gameData.nowTurn > self.gameData.nextStageTurn then
		self:NextStageView()
		self:UpdateGameData()
		self:UpdateView()
	end

	self.tools.speed = self.gameData.speed
	self.tools.maxLevel = self.gameData.maxLevel
	self.tools.minLevel = self.gameData.minLevel
end

function CombineGameView:CheckVictory()
	local var_44_0 = ActivityCombineLevelCfg[self.levelId]

	if ActivityCombineLevelCfg[self.levelId].victory_condition_type == var_0_3.ROLE_LEVEL then
		return self.gameData.roleLv >= var_44_0.victory_condition[1]
	elseif var_44_0.victory_condition_type == var_0_3.TURN then
		return self.gameData.nowTurn >= var_44_0.victory_condition[1]
	elseif var_44_0.victory_condition_type == var_0_3.RESOURCE then
		local var_44_1

		if var_44_0.victory_condition[1] == var_0_1.FOOD then
			var_44_1 = self.gameData.totalFood
		elseif var_44_0.victory_condition[1] == var_0_1.ROCK then
			var_44_1 = self.gameData.totalRock
		elseif var_44_0.victory_condition[1] == var_0_1.TECH then
			var_44_1 = self.gameData.totalTech
		end

		self.winConditionTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_VICTORY_CONDITION_3"), var_44_1 .. "/" .. var_44_0.victory_condition[2], GetTips(var_0_2[var_44_0.victory_condition[1]]))

		return var_44_1 >= var_44_0.victory_condition[2]
	elseif var_44_0.victory_condition_type == var_0_3.BEAST then
		self.winConditionTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_VICTORY_CONDITION_4"), self.tools.beastDestoryCount .. "/" .. var_44_0.victory_condition[2], GetTips(var_0_2[var_44_0.victory_condition[1]]))

		return self.tools.beastDestoryCount >= var_44_0.victory_condition[2]
	end

	return false
end

function CombineGameView:GameWin()
	self.winTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_VICTORY")
	self.result = 1

	SetActive(self.winGo_, true)
	CombineGameFactory:EndGame(self.levelId, self.factorList, true)

	if self.result == 1 and (CombineGameData:GetDataByPara("stageDataTable")[self.levelId] ~= true or ActivityCombineLevelCfg[self.levelId].type == CombineGameConst.TypeConst.ENDLESS) then
		CombineGameAction.GameWin(self.levelId, (self:CalculateScore()))
	end
end

function CombineGameView:GameFail()
	self.loseTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_DEFEAT")
	self.result = 2

	SetActive(self.loseGo_, true)
	CombineGameFactory:EndGame(self.levelId, self.factorList, false)
end

function CombineGameView:NextStageView()
	self.gameData.age = self.gameData.age + 1

	local var_47_0 = ActivityCombineSettingCfg[self.gameData.age]

	if ActivityCombineSettingCfg[self.gameData.age] == nil then
		self.gameData.nextStageTurn = 999

		return
	end

	self.gameData.nextStageTurn = var_47_0.rounds * self.gameData.turnRate
	self.gameData.nextTurnCost[1] = math.max(self.gameData.nextTurnCost[1] + var_47_0.food_cost, 0)

	for iter_47_0, iter_47_1 in ipairs(var_47_0.cells_list) do
		self.gameData.pool[iter_47_0] = self.gameData.pool[iter_47_0] + iter_47_1
	end

	if self.gameData.stageFoodChange[self.gameData.age] then
		self.gameData.resourceChange[var_0_1.FOOD] = self.gameData.resourceChange[var_0_1.FOOD] + self.gameData.stageFoodChange[self.gameData.age]
	end

	self.tools.mapExtension = var_47_0.map_bigger == 1

	if self.gameData.age ~= 1 then
		self.nextStageTipsTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_CONSUME_INCREASE"), var_47_0.food_cost)
		self.stageDescTxt_.text = GetI18NText(var_47_0.desc)

		SetActive(self.nextStageTipsTxt_.transform.parent.gameObject, var_47_0.food_cost ~= 0)
		TimeTools.StartAfterSeconds(1, function()
			SetActive(self.tipsGo_, true)
		end, {})
	end
end

function CombineGameView:RoleLevelUpView()
	local var_49_0 = ActivityCombineHeroCfg[self.heroId]

	if self.gameData.roleLv == #ActivityCombineHeroCfg[self.heroId].level_unlock then
		return
	end

	self.oldLvTxt_.text = string.format(GetTips("DORM_LEVEL_TIPS"), self.gameData.roleLv)
	self.gameData.roleLv = math.min(self.gameData.roleLv + 1, #var_49_0.level_unlock)
	self.newLvTxt_.text = string.format(GetTips("DORM_LEVEL_TIPS"), self.gameData.roleLv)
	self.levelUpTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_HERO_LEVEL_UP"), self.gameData.roleLv)
	self.gameData.tech = self.gameData.tech - self.gameData.nextTechNeed

	local var_49_1 = ActivityCombineSettingCfg[self.gameData.age]

	if ActivityCombineSettingCfg[self.gameData.age] == nil then
		print("daawasdfasfdaw" .. self.gameData.age)

		var_49_1 = ActivityCombineSettingCfg[self.gameData.age - 1]
	end

	self.gameData.nextTechNeed = self.gameData.roleLv == #var_49_0.level_unlock and 0 or math.floor(var_49_0.level_exp[self.gameData.roleLv] * self.gameData.techRate * (100 + var_49_1.score) / 100)

	local var_49_2 = ActivityCombineFactorCfg[var_49_0.level_unlock[self.gameData.roleLv]]

	if ActivityCombineFactorCfg[var_49_0.level_unlock[self.gameData.roleLv]].effect_type == 1 then
		self.skillDescTxt_.text = GetI18NText(ActivityCombineSkillCfg[var_49_2.effect[1]].description)
		self.skillImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. ActivityCombineSkillCfg[var_49_2.effect[1]].icon)
	else
		self.skillDescTxt_.text = GetI18NText(var_49_2.description)
		self.skillImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. var_49_2.icon)
	end

	self.expSlider_.value = self.gameData.nextTechNeed == 0 and 1 or self.gameData.tech / self.gameData.nextTechNeed

	if manager.guide:IsPlaying() then
		TimeTools.StartAfterSeconds(0.07, function()
			SetActive(self.levelUpGo_, true)
		end, {})
	else
		TimeTools.StartAfterSeconds(1, function()
			SetActive(self.levelUpGo_, true)
		end, {})
	end

	CombineGameFactory:NewFactor(var_49_0.level_unlock[self.gameData.roleLv], true)

	if self.gameData.needRefreshSkill then
		self.gameData.needRefreshSkill = false

		self:UpdateGameData()
		self:UpdateSkill()
	elseif self.gameData.needRefreshBlock then
		self.gameData.needRefreshBlock = false

		self:UpdateGameData()
		self.tools:RefreshAllBlock()
	end

	self.tools:RefreshSkillStage()
end

function CombineGameView:ShowBaseInfoView(arg_52_1, arg_52_2)
	SetActive(self.pop6Go_, true)

	self.pop6Go_.transform.position = arg_52_2.transform.position
	self.pop6DescTxt_.text = GetTips(var_0_4[arg_52_1])
end

function CombineGameView:CalculateScore()
	local var_53_0 = 0

	for iter_53_0, iter_53_1 in pairs(self.factorList or {}) do
		var_53_0 = var_53_0 + ActivityCombineFactorCfg[iter_53_0].score
	end

	return var_53_0
end

function CombineGameView:BuryPoint()
	if self.needBury == false then
		return
	end

	if self.needBury == true then
		self.needBury = false
	end

	local var_54_0 = self.tools:DetailBuryPointNeedData()
	local var_54_1 = {}

	for iter_54_0 = 1, var_54_0.Count do
		var_54_1[var_54_0[iter_54_0 - 1]] = var_54_1[var_54_0[iter_54_0 - 1]] == nil and 1 or var_54_1[var_54_0[iter_54_0 - 1]] + 1
	end

	local var_54_2 = {}

	for iter_54_1, iter_54_2 in pairs(var_54_1) do
		table.insert(var_54_2, iter_54_1 .. "," .. iter_54_2)
	end

	local var_54_3 = {}

	for iter_54_3, iter_54_4 in ipairs(ActivityCombineSkillCfg.all) do
		if self.tools.skillUseCount:TryGetValue(iter_54_4, nil) then
			var_54_3[iter_54_4] = self.tools.skillUseCount[iter_54_4]
		end
	end

	local var_54_4 = {}

	for iter_54_5, iter_54_6 in pairs(var_54_3) do
		table.insert(var_54_4, iter_54_5 .. "," .. iter_54_6)
	end

	local var_54_5 = self:CalculateScore()

	SDKTools.SendMessageToSDK("match_threepuzzle_over", {
		hero_id = self.heroId,
		level_id = self.gameData.roleLv,
		stage_id = self.levelId,
		battle_times = self.gameData.nowTurn,
		point_list = table.toString(var_54_2),
		skill_list = table.toString(var_54_4),
		result = self.result,
		score = ActivityCombineLevelCfg[self.levelId].type == 3 and var_54_5 or nil
	})
end

function CombineGameView:OnExit()
	self:BuryPoint()
	self.tools:ResetGame()
	self.tools:EndDrag()

	self.foodAddTxt_.text = ""
	self.rockAddTxt_.text = ""
	self.techAddTxt_.text = ""

	SetActive(self.tipsGo_, false)
	SetActive(self.winGo_, false)
	SetActive(self.loseGo_, false)
	SetActive(self.levelUpGo_, false)
	SetActive(self.informationGo_, false)
	SetActive(self.pop6Go_, false)
	SetActive(self.foodPopGo_, false)
	SetActive(self.tipsPopGo_, false)
end

function CombineGameView:Dispose()
	self:BuryPoint()
	CombineGameView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return CombineGameView
