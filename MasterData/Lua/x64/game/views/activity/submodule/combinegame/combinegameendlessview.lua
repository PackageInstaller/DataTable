local CombineGameEndlessView = class("CombineGameEndlessView", ReduxView)

function CombineGameEndlessView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiakfEndlessUI"
end

function CombineGameEndlessView:UIParent()
	return manager.ui.uiMain.transform
end

function CombineGameEndlessView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CombineGameEndlessView:InitUI()
	self:BindCfgUI()

	self.scoreController = ControllerUtil.GetController(self.gameObject_.transform, "score")
	self.textController = ControllerUtil.GetController(self.gameObject_.transform, "text")
	self.selectController = ControllerUtil.GetController(self.roleGo_.transform, "stage")
	self.factorController = ControllerUtil.GetController(self.gameObject_.transform, "factor")
end

function CombineGameEndlessView:AddUIListener()
	self:AddBtnListener(self.factorBtn_, nil, function()
		JumpTools.GoToSystem("CombineGameSelectFactorView", {
			id = self.id,
			selectFactorList = self.selectFactorList
		})
	end)
	self:AddBtnListener(self.newFactorBtn_, nil, function()
		JumpTools.GoToSystem("CombineGameSelectFactorView", {
			id = self.id,
			selectFactorList = self.selectFactorList
		})
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		JumpTools.GoToSystem("CombineGameSelectFactorView", {
			id = self.id,
			selectFactorList = self.selectFactorList
		})

		self.isBegin = true
	end)
	self:AddBtnListener(self.roleBtn_, nil, function()
		JumpTools.GoToSystem("/CombineGameRoleView", {
			lv = 999
		})
	end)
	self:AddBtnListener(self.hero1Btn_, nil, function()
		self.selectHero = 1

		self.selectController:SetSelectedState(CombineGameData:CheckHeroLock(self.activityId, self.heroList[2]) and "stage1" or "stage3")
	end)
	self:AddBtnListener(self.hero2Btn_, nil, function()
		if CombineGameData:CheckHeroLock(self.activityId, self.heroList[2]) == false then
			ShowTips(string.format(GetTips("ACTIVITY_COMBINE_GAME_HERO_UNLOCKED"), manager.time:GetLostTimeStr2(manager.time:GetNextFreshTime() + (ActivityCombineHeroCfg[self.cfg.can_use_hero[2]].unlock_condition[1][2] - CombineGameData:GetDataByPara("nowDay") + 2) * 86400)))

			return
		end

		self.selectHero = 2

		self.selectController:SetSelectedState("stage2")
	end)
end

function CombineGameEndlessView:OnCombineGameRefresh()
	self:UpdateView()
end

function CombineGameEndlessView:OnEnter()
	self.activityId = CombineGameData:GetDataByPara("activityId")

	if not ActivityData:GetActivityIsOpen(self.activityId) then
		gameContext:Go("/home", nil, nil, true)
		ShowTips("TIME_OVER")

		return
	end

	for iter_13_0, iter_13_1 in ipairs(ActivityCombineLevelCfg.all) do
		if ActivityCombineLevelCfg[iter_13_0].type == CombineGameConst.TypeConst.ENDLESS then
			self.id = iter_13_0
		end
	end

	self.selectHero = getData("CombineGame", "endless") or 1
	self.selectFactorList = {}

	self:GetLastFactor()
	self:UpdateView()

	if self.selectHero == 2 then
		self.selectController:SetSelectedState("stage2")
	else
		self.selectController:SetSelectedState(CombineGameData:CheckHeroLock(self.activityId, self.heroList[2]) and "stage1" or "stage3")
	end
end

function CombineGameEndlessView:GetLastFactor()
	local var_14_0 = getData("CombineGame", "factor")

	if var_14_0 == nil then
		return
	end

	for iter_14_0, iter_14_1 in ipairs((string.split(var_14_0, ":"))) do
		self.selectFactorList[tonumber(iter_14_1)] = true
	end
end

function CombineGameEndlessView:UpdateView()
	self.cfg = ActivityCombineLevelCfg[self.id]
	self.activityId = CombineGameData:GetDataByPara("activityId")
	self.descTxt_.text = GetI18NText(self.cfg.description)

	self.textController:SetSelectedState("false")

	self.nowDay = CombineGameData:GetDataByPara("nowDay")
	self.heroList = self.cfg.can_use_hero

	local var_15_0 = ActivityCombineHeroCfg[self.heroList[1]]
	local var_15_1 = ActivityCombineHeroCfg[self.heroList[2]]
	local var_15_2 = CombineGameData:GetDataByPara("score")

	self.scoreController:SetSelectedState(CombineGameData:GetDataByPara("stageDataTable")[self.id] ~= nil and "true" or "false")

	self.hero1Image_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. var_15_0.icon)
	self.hero2Image_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. var_15_1.icon)
	self.maxScoreTxt_.text = var_15_2
	self.titleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_NAME_3")
	self.titleDescTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_CONTENT_3")
	self.selectTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR")
	self.editTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR_EDIT")
	self.nowDifficultyTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_DIFFICULTY_RATING_NOW")
	self.maxDifficultyTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_DIFFICULTY_RATING_MAX")
	self.startTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_BEGIN")

	self:UpdateFactorAndScoreView()
end

function CombineGameEndlessView:UpdateFactorAndScoreView()
	SetActive(self.selectGo_, next(self.selectFactorList) == nil)

	local var_16_0 = 1
	local var_16_1 = 1
	local var_16_2 = 0
	local var_16_3 = 0
	local var_16_4 = 0

	for iter_16_0 = 1, 4 do
		SetActive(self["upGo" .. iter_16_0 .. "_"], false)
		SetActive(self["downGo" .. iter_16_0 .. "_"], false)
	end

	for iter_16_1, iter_16_2 in pairs(self.selectFactorList) do
		var_16_4 = var_16_4 + ActivityCombineFactorCfg[iter_16_1].score

		if ActivityCombineFactorCfg[iter_16_1].score < 0 then
			if var_16_0 <= 3 then
				SetActive(self["upGo" .. var_16_0 .. "_"], true)

				self["upImg" .. var_16_0 .. "_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. ActivityCombineFactorCfg[iter_16_1].icon)
				var_16_0 = var_16_0 + 1
			else
				var_16_2 = var_16_2 + 1

				SetActive(self.upGo4_, true)

				self.upCountTxt_.text = var_16_2
			end
		elseif ActivityCombineFactorCfg[iter_16_1].score > 0 then
			if var_16_1 <= 3 then
				SetActive(self["downGo" .. var_16_1 .. "_"], true)

				self["downImg" .. var_16_1 .. "_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. ActivityCombineFactorCfg[iter_16_1].icon)
				var_16_1 = var_16_1 + 1
			else
				var_16_3 = var_16_3 + 1

				SetActive(self.downGo4_, true)

				self.downCountTxt_.text = var_16_3
			end
		end
	end

	self.factorController:SetSelectedState(var_16_1 == var_16_0 and var_16_0 == 1 and "false" or "true")

	self.scoreTxt_.text = var_16_4
end

function CombineGameEndlessView:OnExit()
	self.isBegin = false

	saveData("CombineGame", "endless", self.selectHero)
	manager.windowBar:HideBar()
end

function CombineGameEndlessView:OnSelectFactorSure(arg_18_1)
	self.selectFactorList = arg_18_1

	local var_18_0
	local var_18_1 = 1

	for iter_18_0, iter_18_1 in pairs(arg_18_1) do
		var_18_0 = var_18_1 == 1 and iter_18_0 or var_18_0 .. ":" .. iter_18_0
		var_18_1 = var_18_1 + 1
	end

	saveData("CombineGame", "factor", var_18_0)
	self:UpdateFactorAndScoreView()

	if self.isBegin then
		self.isBegin = false

		CombineGameFactory:StartGame(self.id, self.selectFactorList, self.selectHero)
	end
end

function CombineGameEndlessView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function CombineGameEndlessView:Dispose()
	CombineGameEndlessView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return CombineGameEndlessView
