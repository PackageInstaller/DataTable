local NewBattleChallengeFailedView = class("NewBattleChallengeFailedView", (import("game.views.pop.PopFramingBaseView")))
local BattleInstance = import("game.tools.BattleInstance")

function NewBattleChallengeFailedView:UIName()
	return "Widget/System/BattleResult/BattleFailed/BattleChallengeLoseUI"
end

function NewBattleChallengeFailedView:UIParent()
	return manager.ui.uiPop.transform
end

function NewBattleChallengeFailedView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewBattleChallengeFailedView:InitUI()
	self:BindCfgUI()

	self.styleController = self.controllerEx_:GetController("default0")
	self.posController = self.controllerEx_:GetController("move")
	self.btnController = self.btnController_:GetController("btn")
	self.title1Controller = self.controllerEx_:GetController("title1")
	self.teamList1 = LuaList.New(handler(self, self.indexItem1), self.uiList1, HeroShortHead)
	self.teamList2 = LuaList.New(handler(self, self.indexItem2), self.uiList2, HeroShortHead)
	self.teamList3 = LuaList.New(handler(self, self.indexItem3), self.uiList3, HeroShortHead)
	self.items = {}
end

function NewBattleChallengeFailedView:AddUIListener()
	self:AddBtnListener(self.btnBattleCount_, nil, function()
		self:GoToBattleStatistics()
	end)
	self:AddBtnListener(self.exitBtn_, nil, function()
		self:OnClickBack()
	end)
	self:AddBtnListener(self.restartBtn_, nil, function()
		self:OnClickRestart()
	end)
	self:AddBtnListener(self.btnMask_, nil, function()
		self:Back(false, handler(self, self.OnClickBack))
	end)
	SetActive(self.btnMask_.gameObject, true)
	self.btnController:SetSelectedState("nobtn")
	self:AddBtnListener(self.levelBtn_, nil, function()
		JumpTools.OpenPageByJump("battleChallengeStatistics", {
			index = 1,
			stageData = self.params_.stageData
		})

		local var_10_0 = BattleFieldData:GetServerBattleID() or 0

		SDKTools.SendMessageToSDK("combat_over_lose_recomme", {
			direction_type = 1,
			battle_id_str = var_10_0
		})
	end)
	self:AddBtnListener(self.equipeBtn_, nil, function()
		JumpTools.OpenPageByJump("battleChallengeStatistics", {
			index = 2,
			stageData = self.params_.stageData
		})

		local var_11_0 = BattleFieldData:GetServerBattleID() or 0

		SDKTools.SendMessageToSDK("combat_over_lose_recomme", {
			direction_type = 2,
			battle_id_str = var_11_0
		})
	end)
	self:AddBtnListener(self.transitionBtn_, nil, function()
		JumpTools.OpenPageByJump("battleChallengeStatistics", {
			index = 3,
			stageData = self.params_.stageData
		})

		local var_12_0 = BattleFieldData:GetServerBattleID() or 0

		SDKTools.SendMessageToSDK("combat_over_lose_recomme", {
			direction_type = 3,
			battle_id_str = var_12_0
		})
	end)
end

function NewBattleChallengeFailedView:indexItem1(arg_13_1, arg_13_2)
	self.type_ = self.params_.type or HeroConst.HERO_DATA_TYPE.DEFAULT
	self.heroViewProxy_ = HeroViewDataProxy.New(self.type_)

	local var_13_0 = self.team_list1[arg_13_1]

	arg_13_2.gameObject_.name = tostring(self.team_list1[arg_13_1])

	arg_13_2:SetProxy(self.heroViewProxy_)
	arg_13_2:SetHeroId(self.team_list1[arg_13_1], self.type_)
	arg_13_2:RegisterClickListener(function()
		if self.heroViewProxy_:GetHeroData(var_13_0).unlock == 0 then
			ShowTips(GetTips("ERROR_HERO_NOT_GET"))

			local var_14_0 = BattleFieldData:GetServerBattleID() or 0

			SDKTools.SendMessageToSDK("combat_over_lose_recomme", {
				direction_type = 4,
				battle_id_str = var_14_0,
				hero_id = var_13_0
			})
		end
	end)
end

function NewBattleChallengeFailedView:indexItem2(arg_15_1, arg_15_2)
	self.type_ = self.params_.type or HeroConst.HERO_DATA_TYPE.DEFAULT
	self.heroViewProxy_ = HeroViewDataProxy.New(self.type_)

	local var_15_0 = self.team_list2[arg_15_1]

	arg_15_2.gameObject_.name = tostring(self.team_list2[arg_15_1])

	arg_15_2:SetProxy(self.heroViewProxy_)
	arg_15_2:SetHeroId(self.team_list2[arg_15_1], self.type_)
	arg_15_2:RegisterClickListener(function()
		if self.heroViewProxy_:GetHeroData(var_15_0).unlock == 0 then
			ShowTips(GetTips("ERROR_HERO_NOT_GET"))

			local var_16_0 = BattleFieldData:GetServerBattleID() or 0

			SDKTools.SendMessageToSDK("combat_over_lose_recomme", {
				direction_type = 4,
				battle_id_str = var_16_0,
				hero_id = var_15_0
			})
		end
	end)
end

function NewBattleChallengeFailedView:indexItem3(arg_17_1, arg_17_2)
	self.type_ = self.params_.type or HeroConst.HERO_DATA_TYPE.DEFAULT
	self.heroViewProxy_ = HeroViewDataProxy.New(self.type_)

	local var_17_0 = self.team_list3[arg_17_1]

	arg_17_2.gameObject_.name = tostring(self.team_list3[arg_17_1])

	arg_17_2:SetProxy(self.heroViewProxy_)
	arg_17_2:SetHeroId(self.team_list3[arg_17_1], self.type_)
	arg_17_2:RegisterClickListener(function()
		if self.heroViewProxy_:GetHeroData(var_17_0).unlock == 0 then
			ShowTips(GetTips("ERROR_HERO_NOT_GET"))

			local var_18_0 = BattleFieldData:GetServerBattleID() or 0

			SDKTools.SendMessageToSDK("combat_over_lose_recomme", {
				direction_type = 4,
				battle_id_str = var_18_0,
				hero_id = var_17_0
			})
		end
	end)
end

function NewBattleChallengeFailedView:GoToBattleStatistics()
	JumpTools.OpenPageByJump("battleStatistics", {
		stageData = self.params_.stageData,
		battleTime = self:GetBattleTime()
	})
end

function NewBattleChallengeFailedView:GetBattleTime()
	return manager.time:DescCdTime2((LuaExchangeHelper.GetBattleStatisticsData() or LuaExchangeHelper.GetBattleStatisticsDataBeforeBattleEnd()).dataForLua.battleTime)
end

function NewBattleChallengeFailedView:OnEnter()
	self.stageData_ = self.params_.stageData
	self.stageID_ = self.stageData_:GetStageId()
	self.stageType_ = self.stageData_:GetType()

	BattleInstance.hideBattlePanel()
	self:RebuildUI()
end

function NewBattleChallengeFailedView:OnExit()
	return
end

function NewBattleChallengeFailedView:RebuildUI()
	self:ChangeStyle()

	local var_23_0 = {
		GetTips("BATTLE_TOTAL_TIME"),
		": "
	}

	var_23_0[3] = self:GetBattleTime() or "00"
	self.battleTimeText_.text = table.concat(var_23_0)
	self.titleTxt_.text = BattleStageTools.GetStageName(self.stageType_, self.stageID_)

	local var_23_1 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_)
	local var_23_2 = self:GetRecommendTeam()

	self:RefreshRecommendType(var_23_2)
	SetActive(self.uiList1.gameObject, false)
	SetActive(self.uiList2.gameObject, false)
	SetActive(self.uiList3.gameObject, false)

	if not var_23_2 or table.isEmpty(var_23_2) then
		self.title1Controller:SetSelectedState("false")
	else
		self.title1Controller:SetSelectedState("true")
		self:RefreshTeam(var_23_2, 1)
	end

	self:RefreshRecommendBtn()

	if var_23_1.is_hide_failed_tips and var_23_1.is_hide_failed_tips >= 1 then
		self.posController:SetSelectedState("true")
		SetActive(self.tipsTitleObj_, false)
		SetActive(self.bottomLineObj_, false)
	else
		self.posController:SetSelectedState("false")
		SetActive(self.tipsTitleObj_, true)
		SetActive(self.bottomLineObj_, true)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.infoTrans_)
end

function NewBattleChallengeFailedView:GetRecommendTeam()
	return BattleStageTools.GetStageCfg(self.stageType_, self.stageID_).recommend_team
end

function NewBattleChallengeFailedView:RefreshRecommendBtn()
	self.userData = PlayerData:GetPlayerInfo()

	self:RefreshLv()

	if self.userData.userLevel >= 60 then
		self:RefreshEquip()
		self:RefreshTransition()
		SetActive(self.transitionBtn_.gameObject, true)
	elseif self.userData.userLevel >= 20 and self.userData.userLevel < 60 then
		self:RefreshEquip()
		SetActive(self.transitionBtn_.gameObject, false)
		SetActive(self.equipeBtn_.gameObject, true)
	elseif self.userData.userLevel < 20 then
		SetActive(self.equipeBtn_.gameObject, false)
	end
end

function NewBattleChallengeFailedView:RefreshLv()
	local var_26_0 = RecommendTools.GetHeroLvSchedule(self.stageData_.heroList_, self.userData.userLevel) + RecommendTools.GetWeaponLvSchedule(self.stageData_.heroList_, self.userData.userLevel) + RecommendTools.GetSkillLvSchedule(self.stageData_.heroList_, self.userData.userLevel)

	self.num1.text = string.format("%.1f%%", math.min(var_26_0 * 100, 100))
	self.slider1.fillAmount = var_26_0
end

function NewBattleChallengeFailedView:RefreshEquip()
	local var_27_0 = RecommendTools.GetEquipStrengthSchedule(self.stageData_.heroList_, self.userData.userLevel) + RecommendTools.GetEquipReBuildSchedule(self.stageData_.heroList_) + RecommendTools.GetEquipEnchantSchedule(self.stageData_.heroList_, self.userData.userLevel)

	self.num2.text = string.format("%.1f%%", math.min(var_27_0 * 100, 100))
	self.slider2.fillAmount = var_27_0
end

function NewBattleChallengeFailedView:RefreshTransition()
	local var_28_0 = RecommendTools.GetTransitionSkillSchedule(self.stageData_.heroList_)

	self.num3.text = string.format("%.1f%%", math.min(var_28_0 * 100, 100))
	self.slider3.fillAmount = var_28_0
end

function NewBattleChallengeFailedView:RefreshTeam(arg_29_1, arg_29_2)
	if arg_29_1 and not table.isEmpty(arg_29_1) then
		for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
			if arg_29_2 == iter_29_0 then
				for iter_29_2, iter_29_3 in ipairs(RecommendTeamAttributeCfg[iter_29_1].team_id) do
					SetActive(self["uiList" .. iter_29_2].gameObject, true)

					self["team_list" .. iter_29_2] = RecommandTeamCfg[iter_29_3].hero_id

					self["teamList" .. iter_29_2]:StartScroll(#self["team_list" .. iter_29_2])
				end
			end
		end
	end
end

function NewBattleChallengeFailedView:ChangeStyle()
	if self.params_.isHalfWay_ then
		self.styleController:SetSelectedState("end")
	else
		self.styleController:SetSelectedState("lose")
	end
end

function NewBattleChallengeFailedView:OnClickBack()
	self:QuitUI()
end

function NewBattleChallengeFailedView:QuitUI()
	local var_32_0 = PlayerData:GetlevelUpInfos()

	if #var_32_0 > 0 then
		PlayerAction.LevelUpFinish()
		self:Go("levelUp", {
			levelUpInfoList = var_32_0,
			callback = function()
				FrameTimer.New(function()
					BattleInstance.QuitBattle(self.params_.stageData, true, true)
				end, 1, 1):Start()
			end
		})
	else
		BattleInstance.QuitBattle(self.params_.stageData, true, true)
	end
end

function NewBattleChallengeFailedView:OnClickRestart()
	LuaExchangeHelper.GameOver(2)
	BattleController.GetInstance():LaunchBattle(self.params_.stageData)
	LuaForCursor.SwitchCursor(false)
end

function NewBattleChallengeFailedView:RefreshRecommendType(arg_36_1)
	if arg_36_1 and not table.isEmpty(arg_36_1) then
		local var_36_0 = {}

		for iter_36_0, iter_36_1 in ipairs(arg_36_1) do
			table.insert(var_36_0, RecommendTeamAttributeCfg[iter_36_1].recommend_attribute)
		end

		if #var_36_0 > 0 then
			self.recommendAttriList = var_36_0

			for iter_36_2 = 1, #var_36_0 do
				self.items[iter_36_2] = self.items[iter_36_2] or BattleFailedChallengeItem.New((Object.Instantiate(self.item_, self.itemParent_)))

				self.items[iter_36_2]:OnRenderItem(HeroTools.GetSkillAttributeIcon(self.recommendAttriList[iter_36_2]), iter_36_2)
				self.items[iter_36_2]:RegistCallBack(function(arg_37_0)
					local var_37_0 = self:GetRecommendTeam()

					for iter_37_0, iter_37_1 in ipairs(self.items) do
						if iter_37_0 ~= arg_37_0 then
							self:RefreshTeam(var_37_0, arg_37_0)
						end

						iter_37_1:RefreshState(arg_37_0)
					end
				end)
			end

			for iter_36_3 = #var_36_0 + 1, #self.items do
				self.items[iter_36_3]:Show(false)
			end
		end
	end
end

function NewBattleChallengeFailedView:Dispose()
	self.teamList1:Dispose()
	self.teamList2:Dispose()
	self.teamList3:Dispose()

	if self.items then
		for iter_38_0, iter_38_1 in ipairs(self.items) do
			iter_38_1:Dispose()
		end

		self.items = nil
	end

	NewBattleChallengeFailedView.super.Dispose(self)
end

return NewBattleChallengeFailedView
