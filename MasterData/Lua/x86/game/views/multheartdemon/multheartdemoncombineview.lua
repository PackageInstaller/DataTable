local MultHeartDemonCombineView = class("MultHeartDemonCombineView", ReduxView)

function MultHeartDemonCombineView:UIName()
	return "Widget/System/Activity_Resident/Acitvity_SoloHeartDemon/SoloHeartDemon_VSUI"
end

function MultHeartDemonCombineView:UIParent()
	return manager.ui.uiMain.transform
end

function MultHeartDemonCombineView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MultHeartDemonCombineView:InitUI()
	self:BindCfgUI()

	self.controller = self.controller_:GetController("defen")
	self.difficultController = self.controller_:GetController("difficult")
	self.itemList = {}
	self.leftBtnList_ = {}

	for iter_4_0 = 1, 6 do
		self.leftBtnList_[iter_4_0] = MultHeartDemonCombatItem.New(self["item" .. iter_4_0 .. "Go_"])
	end
end

function MultHeartDemonCombineView:GetPlayerAndAIIndex()
	local var_5_0 = 1
	local var_5_1 = 1

	for iter_5_0 = 1, 3 do
		if self.heroList[iter_5_0] == nil or self.heroList[iter_5_0] == 0 or self.data.heroHPList and self.data.heroHPList[self.heroList[iter_5_0]] == 0 then
			var_5_0 = var_5_0 + 1
		end

		if self.data.heroHPList and self.data.heroHPList[self.cfg.heart_damon_id[iter_5_0]] == 0 then
			var_5_1 = var_5_1 + 1
		end
	end

	return var_5_0, var_5_1
end

function MultHeartDemonCombineView:IsInChallengeTime()
	return ActivityData:GetActivityIsOpen(self.activityId) and ActivityData:GetActivityRefreshTime(self.activityId) > manager.time:GetServerTime()
end

function MultHeartDemonCombineView:AddUIListener()
	local var_7_0 = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)

	local function var_7_1()
		if not self:IsInChallengeTime() then
			ShowTips("MULTI_HEART_DEMON_REFRESH_TIPS")

			return
		end

		if not self.heroList[1] or not self.heroList[2] or not self.heroList[3] then
			ShowTips("MULTI_HEART_DEMON_HERO_NOT_ENOUGH")

			return
		end

		local var_8_0, var_8_1 = self:GetPlayerAndAIIndex()

		if var_8_0 == 4 then
			return
		end

		local var_8_2 = self.cfg.stage_id[self.difficult][2][var_8_1]
		local var_8_3 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.MULT_HEART_DEMON, self.cfg.stage_id[self.difficult][2][var_8_1], {
			activityID = self.activityId,
			heroID = self.heroList[var_8_0],
			difficult = self.difficult
		})
		local var_8_4

		if self.isLock == false then
			local var_8_5 = {}

			for iter_8_0, iter_8_1 in ipairs(var_8_3.data.heroIdList) do
				local var_8_6
				local var_8_7

				if HeroStandardSystemCfg[iter_8_1] then
					var_8_6 = MultHeartDemonData:GetDataByPara("trialProxy")
					var_8_7 = HeroStandardSystemCfg[iter_8_1].hero_id
				end

				local var_8_8

				do
					var_8_6 = var_7_0
					var_8_7 = iter_8_1
					var_8_8 = {
						hero_id = iter_8_1
					}
				end

				var_8_8.hero_max_hp = var_8_6:GetHeroAllAttribute(var_8_7)[HeroConst.HERO_ATTRIBUTE.STA]
				var_8_5[iter_8_0] = var_8_8
			end

			var_8_4 = MultHeartDemonAction.SaveTeam({
				activity_id = self.activityId,
				hero_id_list = self.heroList,
				difficulty = self.difficult,
				hero_max_hp = var_8_5
			})
		else
			var_8_4 = deferred.new(function(arg_9_0)
				arg_9_0:resolve({
					result = TipsCfg.get_id_list_by_define.SUCCESS
				})
			end)
		end

		var_8_4:next(function(arg_10_0)
			if isSuccess(arg_10_0.result) then
				BattleController.GetInstance():LaunchBattle(var_8_3, nil, function()
					MultHeartDemonAction.SendDataToServer({
						stage_id = var_8_2,
						boss_hp_rate = BattleMultiHeartDemonCfg[var_8_2].attribute_factor[3]
					})
				end)
			end
		end)
	end

	self:AddBtnListener(self.infoBtn_, nil, function()
		JumpTools.GoToSystem("/multHeartDemonReport", {
			activityId = self.activityId,
			difficult = self.difficult,
			data = self.data
		})
	end)
	self:AddBtnListener(self.giveUpBtn_, nil, function()
		if self:IsInChallengeTime() then
			ShowMessageBox({
				isTop = true,
				content = GetTips("MULTI_HEART_DEMON_GIVE_UP_CONFIRM_TIPS"),
				OkCallback = function()
					MultHeartDemonAction.Reset({
						difficulty = self.difficult,
						activity_id = self.activityId
					})
				end
			})
		else
			ShowTips("MULTI_HEART_DEMON_REFRESH_TIPS")
		end
	end)
	self:AddBtnListener(self.overBtn_, nil, function()
		if self:IsInChallengeTime() then
			MultHeartDemonAction.ResetPromise({
				difficulty = self.difficult,
				activity_id = self.activityId
			}):next(function(arg_16_0)
				if arg_16_0 then
					self.Back()
				end
			end)
		else
			ShowTips("MULTI_HEART_DEMON_REFRESH_TIPS")
		end
	end)
	self:AddBtnListener(self.fightBtn_, nil, var_7_1)
	self:AddBtnListener(self.fight2Btn_, nil, var_7_1)
end

function MultHeartDemonCombineView:UpdateView()
	if self.params_.isMain then
		self.params_.isMain = false
		self.animator_.enabled = true
	else
		self.animator_.enabled = false
	end

	local var_17_0 = self.isLock and MultHeartDemonData:CheckDifficultyCanEnter(self.difficult)

	self:RefreshHeroList()

	self.titleTxt_.text = GetTips(self.difficult == 1 and "MULTI_HEART_DEMON_STAGE_EASY_NAME" or "MULTI_HEART_DEMON_STAGE_HARD_NAME")

	self:UpdateScore()
	SetActive(self.giveUpBtn_, false)

	if self.isLock then
		SetActive(self.giveUpBtn_, true)
	end

	SetActive(self.infoBtn_.gameObject, self.isLock == true)
	SetActive(self.overBtn_.gameObject, var_17_0)

	self.rawImage1_.color = self.difficult == 1 and Color(0.266, 0.403, 0.607) or Color(0.509, 0.38, 1)
	self.rawImage3_.color = self.difficult == 1 and Color(0.266, 0.403, 0.607) or Color(0.509, 0.38, 1)
	self.rawImage2_.color = self.difficult == 1 and Color(0.266, 0.403, 0.607) or Color(0.509, 0.38, 1)

	SetActive(self.fightBtn_.gameObject, self.difficult == 1)
	SetActive(self.fight2Btn_.gameObject, self.difficult == 2)

	self.fight1Txt_.text = GetTips(self.isLock and "POLYHEDRON_LOBBY_BUTTON_CONTINUE" or "ACTIVITY_HERO_ENHANCE_BUTTON_BEGIN")
	self.fight2Txt_.text = GetTips(self.isLock and "POLYHEDRON_LOBBY_BUTTON_CONTINUE" or "ACTIVITY_HERO_ENHANCE_BUTTON_BEGIN")

	self.difficultController:SetSelectedState(self.difficult == 1 and "normal" or "hard")

	if var_17_0 then
		SetActive(self.giveUpBtn_, false)
		SetActive(self.fightBtn_.gameObject, false)
		SetActive(self.fight2Btn_.gameObject, false)
	end
end

local function var_0_1(arg_18_0, arg_18_1)
	if arg_18_0 == nil then
		return 0
	end

	local var_18_0 = 0

	for iter_18_0, iter_18_1 in pairs(arg_18_0) do
		var_18_0 = var_18_0 + (nullable(arg_18_1, iter_18_1) or 100)
	end

	return GameSetting.multi_heart_demon_hpscore.value[1] * var_18_0 / 100
end

function MultHeartDemonCombineView:UpdateScore()
	local var_19_0 = 0

	if self.isLock then
		self.controller:SetSelectedState("state1")

		for iter_19_0, iter_19_1 in pairs(self.data.stageData or {}) do
			var_19_0 = var_19_0 + iter_19_1.maxScore
		end

		if MultHeartDemonData:CheckDifficultyCanEnter(self.difficult) then
			local var_19_1 = var_0_1(self.data.heroIdList, self.data.heroHPList)

			self.maxScoreTxt_.text = GetTipsF("MULTI_HEART_DEMON_TOTAL_SCORE_2", var_19_0 + var_19_1, var_19_0, var_19_1)
		else
			self.maxScoreTxt_.text = var_19_0
		end
	else
		self.controller:SetSelectedState("state0")

		self.allTxt_.text = nullable(MultHeartDemonData:GetDataByPara("maxScore"), self.difficult) or 0
	end
end

function MultHeartDemonCombineView:OnEnter()
	self:UpdateData()
	self:UpdateView()
	self:CheckIsOver()
end

function MultHeartDemonCombineView:CheckIsOver()
	if self.params_.isOver then
		self.params_.isOver = nil

		if MultHeartDemonData:CheckDifficultyCanEnter(self.difficult) then
			SetActive(self.overBtn_.gameObject, true)
			TimeTools.StartAfterSeconds(1, function()
				JumpTools.OpenPageByJump("MultHeartDemonOver")
			end, {})
		end
	end
end

function MultHeartDemonCombineView:UpdateData()
	self.activityId = MultHeartDemonData:GetDataByPara("activityId")
	self.isLock = MultHeartDemonData:GetDataByPara("isLock") or false
	self.difficult = self.params_.difficult
	self.cfg = MultHeartDemonCfg[MultHeartDemonCfg.get_id_list_by_activity_id[self.activityId][1]]
	self.data = MultHeartDemonData:GetDataByPara("difficultyData")

	if self.data then
		self.data = self.data[self.difficult] or {}
	end

	self.heroList = self.data.heroIdList or {}
end

function MultHeartDemonCombineView:OnMultDemonHeartSaveTeam()
	self:UpdateData()
	self:UpdateView()
end

function MultHeartDemonCombineView:OnMultDemonHeartUpdate()
	self:UpdateData()
	self:UpdateView()
end

function MultHeartDemonCombineView:OnExit()
	manager.windowBar:HideBar()
end

function MultHeartDemonCombineView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("MULTI_HEART_DEMON_GAMEPLAY_DESC")
end

function MultHeartDemonCombineView:RefreshHeroList()
	local var_28_0, var_28_1 = self:GetPlayerAndAIIndex()

	for iter_28_0, iter_28_1 in pairs(self.leftBtnList_) do
		iter_28_1:SetData(self.data, iter_28_0, self.heroList, self.cfg, self.difficult, self.activityId, var_28_0, var_28_1, self.cfg.stage_id[self.difficult][2][var_28_1], handler(self, self.ClickFunction), handler(self, self.ClickSwapFunction))
	end
end

function MultHeartDemonCombineView:ClickFunction(arg_29_1)
	if arg_29_1 == self.swapIndex then
		self.swapIndex = nil

		self:RefreshHeroList()
	else
		self.swapIndex = arg_29_1

		local var_29_0 = self.leftBtnList_[arg_29_1]:IsEmptySlot()

		for iter_29_0 = 1, 3 do
			self.leftBtnList_[iter_29_0]:SetSwapEnabled(iter_29_0 ~= self.swapIndex and not (var_29_0 and self.leftBtnList_[iter_29_0]:IsEmptySlot()))
			self.leftBtnList_[iter_29_0]:SetHighlighted(iter_29_0 == self.swapIndex)
		end
	end
end

function MultHeartDemonCombineView:ClickSwapFunction(arg_30_1)
	if self.swapIndex == nil or self.swapIndex == arg_30_1 then
		return
	end

	self.heroList[self.swapIndex] = self.heroList[arg_30_1]
	self.heroList[arg_30_1] = self.heroList[self.swapIndex]

	local var_30_0 = MultHeartDemonData:GetDataByPara("heroTempData")[self.difficult]

	var_30_0[self.swapIndex] = var_30_0[arg_30_1]
	var_30_0[arg_30_1] = var_30_0[self.swapIndex]
	self.swapIndex = nil

	self:RefreshHeroList()
end

function MultHeartDemonCombineView:Dispose()
	for iter_31_0, iter_31_1 in pairs(self.leftBtnList_) do
		iter_31_1:Dispose()
	end

	self.leftBtnList_ = nil

	MultHeartDemonCombineView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return MultHeartDemonCombineView
