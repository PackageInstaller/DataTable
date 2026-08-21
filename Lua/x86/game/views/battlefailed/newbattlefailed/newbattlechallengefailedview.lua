local var_0_0 = import("game.views.pop.PopFramingBaseView")
local var_0_1 = class("NewBattleChallengeFailedView", var_0_0)
local var_0_2 = import("game.tools.BattleInstance")

function var_0_1.UIName(arg_1_0)
	return "Widget/System/BattleResult/BattleFailed/BattleChallengeLoseUI"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_1.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_1.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.styleController = arg_4_0.controllerEx_:GetController("default0")
	arg_4_0.posController = arg_4_0.controllerEx_:GetController("move")
	arg_4_0.btnController = arg_4_0.btnController_:GetController("btn")
	arg_4_0.title1Controller = arg_4_0.controllerEx_:GetController("title1")
	arg_4_0.teamList1 = LuaList.New(handler(arg_4_0, arg_4_0.indexItem1), arg_4_0.uiList1, HeroShortHead)
	arg_4_0.teamList2 = LuaList.New(handler(arg_4_0, arg_4_0.indexItem2), arg_4_0.uiList2, HeroShortHead)
	arg_4_0.teamList3 = LuaList.New(handler(arg_4_0, arg_4_0.indexItem3), arg_4_0.uiList3, HeroShortHead)
	arg_4_0.items = {}
end

function var_0_1.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnBattleCount_, nil, function()
		arg_5_0:GoToBattleStatistics()
	end)
	arg_5_0:AddBtnListener(arg_5_0.exitBtn_, nil, function()
		arg_5_0:OnClickBack()
	end)
	arg_5_0:AddBtnListener(arg_5_0.restartBtn_, nil, function()
		arg_5_0:OnClickRestart()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnMask_, nil, function()
		arg_5_0:Back(false, handler(arg_5_0, arg_5_0.OnClickBack))
	end)
	SetActive(arg_5_0.btnMask_.gameObject, true)
	arg_5_0.btnController:SetSelectedState("nobtn")
	arg_5_0:AddBtnListener(arg_5_0.levelBtn_, nil, function()
		JumpTools.OpenPageByJump("battleChallengeStatistics", {
			index = 1,
			stageData = arg_5_0.params_.stageData
		})

		local var_10_0 = BattleFieldData:GetServerBattleID() or 0

		SDKTools.SendMessageToSDK("combat_over_lose_recomme", {
			direction_type = 1,
			battle_id_str = var_10_0
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.equipeBtn_, nil, function()
		JumpTools.OpenPageByJump("battleChallengeStatistics", {
			index = 2,
			stageData = arg_5_0.params_.stageData
		})

		local var_11_0 = BattleFieldData:GetServerBattleID() or 0

		SDKTools.SendMessageToSDK("combat_over_lose_recomme", {
			direction_type = 2,
			battle_id_str = var_11_0
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.transitionBtn_, nil, function()
		JumpTools.OpenPageByJump("battleChallengeStatistics", {
			index = 3,
			stageData = arg_5_0.params_.stageData
		})

		local var_12_0 = BattleFieldData:GetServerBattleID() or 0

		SDKTools.SendMessageToSDK("combat_over_lose_recomme", {
			direction_type = 3,
			battle_id_str = var_12_0
		})
	end)
end

function var_0_1.indexItem1(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.type_ = arg_13_0.params_.type or HeroConst.HERO_DATA_TYPE.DEFAULT
	arg_13_0.heroViewProxy_ = HeroViewDataProxy.New(arg_13_0.type_)

	local var_13_0 = arg_13_0.team_list1[arg_13_1]

	arg_13_2.gameObject_.name = tostring(var_13_0)

	arg_13_2:SetProxy(arg_13_0.heroViewProxy_)
	arg_13_2:SetHeroId(var_13_0, arg_13_0.type_)
	arg_13_2:RegisterClickListener(function()
		if arg_13_0.heroViewProxy_:GetHeroData(var_13_0).unlock == 0 then
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

function var_0_1.indexItem2(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.type_ = arg_15_0.params_.type or HeroConst.HERO_DATA_TYPE.DEFAULT
	arg_15_0.heroViewProxy_ = HeroViewDataProxy.New(arg_15_0.type_)

	local var_15_0 = arg_15_0.team_list2[arg_15_1]

	arg_15_2.gameObject_.name = tostring(var_15_0)

	arg_15_2:SetProxy(arg_15_0.heroViewProxy_)
	arg_15_2:SetHeroId(var_15_0, arg_15_0.type_)
	arg_15_2:RegisterClickListener(function()
		if arg_15_0.heroViewProxy_:GetHeroData(var_15_0).unlock == 0 then
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

function var_0_1.indexItem3(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.type_ = arg_17_0.params_.type or HeroConst.HERO_DATA_TYPE.DEFAULT
	arg_17_0.heroViewProxy_ = HeroViewDataProxy.New(arg_17_0.type_)

	local var_17_0 = arg_17_0.team_list3[arg_17_1]

	arg_17_2.gameObject_.name = tostring(var_17_0)

	arg_17_2:SetProxy(arg_17_0.heroViewProxy_)
	arg_17_2:SetHeroId(var_17_0, arg_17_0.type_)
	arg_17_2:RegisterClickListener(function()
		if arg_17_0.heroViewProxy_:GetHeroData(var_17_0).unlock == 0 then
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

function var_0_1.GoToBattleStatistics(arg_19_0)
	JumpTools.OpenPageByJump("battleStatistics", {
		stageData = arg_19_0.params_.stageData,
		battleTime = arg_19_0:GetBattleTime()
	})
end

function var_0_1.GetBattleTime(arg_20_0)
	local var_20_0 = (LuaExchangeHelper.GetBattleStatisticsData() or LuaExchangeHelper.GetBattleStatisticsDataBeforeBattleEnd()).dataForLua.battleTime

	return manager.time:DescCdTime2(var_20_0)
end

function var_0_1.OnEnter(arg_21_0)
	arg_21_0.stageData_ = arg_21_0.params_.stageData
	arg_21_0.stageID_ = arg_21_0.stageData_:GetStageId()
	arg_21_0.stageType_ = arg_21_0.stageData_:GetType()

	var_0_2.hideBattlePanel()
	arg_21_0:RebuildUI()
end

function var_0_1.OnExit(arg_22_0)
	return
end

function var_0_1.RebuildUI(arg_23_0)
	arg_23_0:ChangeStyle()

	arg_23_0.battleTimeText_.text = table.concat({
		GetTips("BATTLE_TOTAL_TIME"),
		": ",
		arg_23_0:GetBattleTime() or "00"
	})
	arg_23_0.titleTxt_.text = BattleStageTools.GetStageName(arg_23_0.stageType_, arg_23_0.stageID_)

	local var_23_0 = BattleStageTools.GetStageCfg(arg_23_0.stageType_, arg_23_0.stageID_)
	local var_23_1 = arg_23_0:GetRecommendTeam()

	arg_23_0:RefreshRecommendType(var_23_1)
	SetActive(arg_23_0.uiList1.gameObject, false)
	SetActive(arg_23_0.uiList2.gameObject, false)
	SetActive(arg_23_0.uiList3.gameObject, false)

	if not var_23_1 or table.isEmpty(var_23_1) then
		arg_23_0.title1Controller:SetSelectedState("false")
	else
		arg_23_0.title1Controller:SetSelectedState("true")
		arg_23_0:RefreshTeam(var_23_1, 1)
	end

	arg_23_0:RefreshRecommendBtn()

	if var_23_0.is_hide_failed_tips and var_23_0.is_hide_failed_tips >= 1 then
		arg_23_0.posController:SetSelectedState("true")
		SetActive(arg_23_0.tipsTitleObj_, false)
		SetActive(arg_23_0.bottomLineObj_, false)
	else
		arg_23_0.posController:SetSelectedState("false")
		SetActive(arg_23_0.tipsTitleObj_, true)
		SetActive(arg_23_0.bottomLineObj_, true)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_0.infoTrans_)
end

function var_0_1.GetRecommendTeam(arg_24_0)
	return BattleStageTools.GetStageCfg(arg_24_0.stageType_, arg_24_0.stageID_).recommend_team
end

function var_0_1.RefreshRecommendBtn(arg_25_0)
	arg_25_0.userData = PlayerData:GetPlayerInfo()

	arg_25_0:RefreshLv()

	if arg_25_0.userData.userLevel >= 60 then
		arg_25_0:RefreshEquip()
		arg_25_0:RefreshTransition()
		SetActive(arg_25_0.transitionBtn_.gameObject, true)
	elseif arg_25_0.userData.userLevel >= 20 and arg_25_0.userData.userLevel < 60 then
		arg_25_0:RefreshEquip()
		SetActive(arg_25_0.transitionBtn_.gameObject, false)
		SetActive(arg_25_0.equipeBtn_.gameObject, true)
	elseif arg_25_0.userData.userLevel < 20 then
		SetActive(arg_25_0.equipeBtn_.gameObject, false)
	end
end

function var_0_1.RefreshLv(arg_26_0)
	local var_26_0 = RecommendTools.GetHeroLvSchedule(arg_26_0.stageData_.heroList_, arg_26_0.userData.userLevel)
	local var_26_1 = RecommendTools.GetWeaponLvSchedule(arg_26_0.stageData_.heroList_, arg_26_0.userData.userLevel)
	local var_26_2 = RecommendTools.GetSkillLvSchedule(arg_26_0.stageData_.heroList_, arg_26_0.userData.userLevel)
	local var_26_3 = var_26_0 + var_26_1 + var_26_2

	arg_26_0.num1.text = string.format("%.1f%%", math.min(var_26_3 * 100, 100))
	arg_26_0.slider1.fillAmount = var_26_3
end

function var_0_1.RefreshEquip(arg_27_0)
	local var_27_0 = RecommendTools.GetEquipStrengthSchedule(arg_27_0.stageData_.heroList_, arg_27_0.userData.userLevel)
	local var_27_1 = RecommendTools.GetEquipReBuildSchedule(arg_27_0.stageData_.heroList_)
	local var_27_2 = RecommendTools.GetEquipEnchantSchedule(arg_27_0.stageData_.heroList_, arg_27_0.userData.userLevel)
	local var_27_3 = var_27_0 + var_27_1 + var_27_2

	arg_27_0.num2.text = string.format("%.1f%%", math.min(var_27_3 * 100, 100))
	arg_27_0.slider2.fillAmount = var_27_3
end

function var_0_1.RefreshTransition(arg_28_0)
	local var_28_0 = RecommendTools.GetTransitionSkillSchedule(arg_28_0.stageData_.heroList_)

	arg_28_0.num3.text = string.format("%.1f%%", math.min(var_28_0 * 100, 100))
	arg_28_0.slider3.fillAmount = var_28_0
end

function var_0_1.RefreshTeam(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_1 and not table.isEmpty(arg_29_1) then
		for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
			if arg_29_2 == iter_29_0 then
				local var_29_0 = RecommendTeamAttributeCfg[iter_29_1].team_id

				for iter_29_2, iter_29_3 in ipairs(var_29_0) do
					SetActive(arg_29_0["uiList" .. iter_29_2].gameObject, true)

					local var_29_1 = RecommandTeamCfg[iter_29_3]

					arg_29_0["team_list" .. iter_29_2] = var_29_1.hero_id

					arg_29_0["teamList" .. iter_29_2]:StartScroll(#arg_29_0["team_list" .. iter_29_2])
				end
			end
		end
	end
end

function var_0_1.ChangeStyle(arg_30_0)
	if arg_30_0.params_.isHalfWay_ then
		arg_30_0.styleController:SetSelectedState("end")
	else
		arg_30_0.styleController:SetSelectedState("lose")
	end
end

function var_0_1.OnClickBack(arg_31_0)
	arg_31_0:QuitUI()
end

function var_0_1.QuitUI(arg_32_0)
	local var_32_0 = PlayerData:GetlevelUpInfos()

	if #var_32_0 > 0 then
		PlayerAction.LevelUpFinish()
		arg_32_0:Go("levelUp", {
			levelUpInfoList = var_32_0,
			callback = function()
				FrameTimer.New(function()
					var_0_2.QuitBattle(arg_32_0.params_.stageData, true, true)
				end, 1, 1):Start()
			end
		})
	else
		var_0_2.QuitBattle(arg_32_0.params_.stageData, true, true)
	end
end

function var_0_1.OnClickRestart(arg_35_0)
	LuaExchangeHelper.GameOver(2)
	BattleController.GetInstance():LaunchBattle(arg_35_0.params_.stageData)
	LuaForCursor.SwitchCursor(false)
end

function var_0_1.RefreshRecommendType(arg_36_0, arg_36_1)
	if arg_36_1 and not table.isEmpty(arg_36_1) then
		local var_36_0 = {}

		for iter_36_0, iter_36_1 in ipairs(arg_36_1) do
			local var_36_1 = RecommendTeamAttributeCfg[iter_36_1].recommend_attribute

			table.insert(var_36_0, var_36_1)
		end

		if #var_36_0 > 0 then
			arg_36_0.recommendAttriList = var_36_0

			local var_36_2 = #var_36_0

			for iter_36_2 = 1, var_36_2 do
				if not arg_36_0.items[iter_36_2] then
					local var_36_3 = Object.Instantiate(arg_36_0.item_, arg_36_0.itemParent_)

					arg_36_0.items[iter_36_2] = BattleFailedChallengeItem.New(var_36_3)
				end

				arg_36_0.items[iter_36_2]:OnRenderItem(HeroTools.GetSkillAttributeIcon(arg_36_0.recommendAttriList[iter_36_2]), iter_36_2)
				arg_36_0.items[iter_36_2]:RegistCallBack(function(arg_37_0)
					local var_37_0 = arg_36_0:GetRecommendTeam()

					for iter_37_0, iter_37_1 in ipairs(arg_36_0.items) do
						if iter_37_0 ~= arg_37_0 then
							arg_36_0:RefreshTeam(var_37_0, arg_37_0)
						end

						iter_37_1:RefreshState(arg_37_0)
					end
				end)
			end

			for iter_36_3 = var_36_2 + 1, #arg_36_0.items do
				arg_36_0.items[iter_36_3]:Show(false)
			end
		end
	end
end

function var_0_1.Dispose(arg_38_0)
	arg_38_0.teamList1:Dispose()
	arg_38_0.teamList2:Dispose()
	arg_38_0.teamList3:Dispose()

	if arg_38_0.items then
		for iter_38_0, iter_38_1 in ipairs(arg_38_0.items) do
			iter_38_1:Dispose()
		end

		arg_38_0.items = nil
	end

	var_0_1.super.Dispose(arg_38_0)
end

return var_0_1
