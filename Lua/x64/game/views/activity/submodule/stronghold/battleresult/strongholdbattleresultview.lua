local var_0_0 = class("StrongholdBattleResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/CooperationBattleResult/CooperationResultUI"
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

	arg_4_0.orderList = LuaList.New(handler(arg_4_0, arg_4_0.IndexOrderItem), arg_4_0.m_orderList, StrongholdBattleResultOrderItem)
	arg_4_0.intensifyList = LuaList.New(handler(arg_4_0, arg_4_0.IndexIntensifyItem), arg_4_0.m_intensifyList, StrongholdBattleResultIntensifyItem)
	arg_4_0.achieveList = LuaList.New(handler(arg_4_0, arg_4_0.IndexAchieveItem), arg_4_0.m_achieveList, StrongholdBattleResultAchieveItem)
	arg_4_0.skillController = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "skill")
	arg_4_0.resultController = ControllerUtil.GetController(arg_4_0.transform_, "result")
	arg_4_0.itemInfoController = ControllerUtil.GetController(arg_4_0.transform_, "itemInfo")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_quitBtn, nil, function()
		BattleInstance.QuitBattle(arg_5_0.stageData)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_statisticsBtn, nil, function()
		JumpTools.OpenPageByJump("strongholdBattleStatistics", {
			stageData = arg_5_0.stageData,
			battleTime = arg_5_0:GetBattleTime()
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_infoMask, nil, function()
		arg_5_0.itemInfoController:SetSelectedIndex(0)
	end)
end

function var_0_0.OnTop(arg_9_0)
	return
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.stageData = arg_10_0.params_.stageData
	arg_10_0.rewardList = arg_10_0.params_.rewardList

	arg_10_0:RefreshUI()

	if arg_10_0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				arg_10_0:CloseFunc()
			end
		})
	end

	arg_10_0.itemInfoController:SetSelectedIndex(0)
end

function var_0_0.OnExit(arg_12_0)
	return
end

function var_0_0.RefreshUI(arg_13_0)
	local var_13_0 = PlayerData:GetPlayerInfo().userID
	local var_13_1 = 1
	local var_13_2, var_13_3 = arg_13_0.stageData:GetIsCooperation()

	if var_13_2 then
		for iter_13_0, iter_13_1 in ipairs(var_13_3) do
			if iter_13_1.playerID == var_13_0 then
				var_13_1 = iter_13_0

				break
			end
		end
	end

	local var_13_4 = arg_13_0.stageData:GetHeroDataByPos(var_13_1).using_skin

	arg_13_0.m_heroIcon.sprite = getSpriteViaConfig("HeroLittleIcon", var_13_4)

	arg_13_0.orderList:StartScroll(3)

	local var_13_5 = arg_13_0.stageData:GetDest()

	arg_13_0.m_difficultyLab.text = ActivityStrongholdCfg[var_13_5].difficulty_des

	if isSuccess(arg_13_0.params_.result) then
		arg_13_0.resultController:SetSelectedIndex(0)
	else
		arg_13_0.resultController:SetSelectedIndex(1)
	end

	arg_13_0.m_timeLab.text = arg_13_0:GetBattleTime()
	arg_13_0.main_activity_id = 0

	local var_13_6 = arg_13_0.stageData:GetActivityID()

	for iter_13_2, iter_13_3 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STRONGHOLD] or {}) do
		local var_13_7 = ActivityCfg[iter_13_3]

		if table.indexof(var_13_7.sub_activity_list, var_13_6) then
			arg_13_0.main_activity_id = iter_13_3

			break
		end
	end

	local var_13_8 = LuaExchangeHelper.GetBattleStatisticsData()

	if var_13_8 then
		local var_13_9 = var_13_8.finishedAchievement
		local var_13_10 = var_13_8.choosedEffectID

		arg_13_0.achieveDataList = {}

		local var_13_11 = {}
		local var_13_12 = var_13_9.Count

		for iter_13_4 = 0, var_13_12 - 1 do
			local var_13_13 = var_13_9[iter_13_4]
			local var_13_14 = ActivityStrongholdAchievementCfg[var_13_13]

			if var_13_14 and var_13_14.type ~= -1 then
				local var_13_15 = var_13_14.type

				if var_13_15 == 0 then
					table.insert(arg_13_0.achieveDataList, var_13_13)
				elseif var_13_11[var_13_15] then
					var_13_11[var_13_15] = math.max(var_13_11[var_13_15], var_13_13)
				else
					var_13_11[var_13_15] = var_13_13
				end
			end
		end

		for iter_13_5, iter_13_6 in pairs(var_13_11) do
			table.insert(arg_13_0.achieveDataList, iter_13_6)
		end

		arg_13_0.achieveList:StartScroll(#arg_13_0.achieveDataList)

		arg_13_0.intensifyDataList = {}

		local var_13_16 = var_13_10.Count

		for iter_13_7 = 0, var_13_16 - 1 do
			local var_13_17 = var_13_8.choosedEffectID[iter_13_7]

			table.insert(arg_13_0.intensifyDataList, var_13_17)
		end

		arg_13_0.intensifyList:StartScroll(#arg_13_0.intensifyDataList)
	else
		arg_13_0.intensifyList:StartScroll(0)
		arg_13_0.achieveList:StartScroll(0)
	end

	local var_13_18, var_13_19 = arg_13_0.stageData:GetType()

	if BattleConst.STAGE_TYPE_NEW.STRONGHOLD ~= var_13_18 then
		var_13_19 = 0
	end

	if var_13_19 and var_13_19 ~= 0 then
		arg_13_0.skillController:SetSelectedIndex(1)

		arg_13_0.m_skillIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdSkill/" .. var_13_19)
	else
		arg_13_0.skillController:SetSelectedIndex(0)
	end
end

function var_0_0.GetBattleTime(arg_14_0)
	local var_14_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime

	return manager.time:DescCdTime2(var_14_0)
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.orderList:Dispose()
	arg_15_0.intensifyList:Dispose()
	arg_15_0.achieveList:Dispose()
	var_0_0.super.Dispose(arg_15_0)
end

function var_0_0.IndexOrderItem(arg_16_0, arg_16_1, arg_16_2)
	arg_16_2:SetData(arg_16_1, arg_16_0.rewardList, arg_16_0.main_activity_id)
end

function var_0_0.IndexIntensifyItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.intensifyDataList[arg_17_1]

	arg_17_2:SetData(var_17_0)
	arg_17_2:RegistCallBack(function(arg_18_0)
		arg_17_0:OnItemClick(arg_18_0)
	end)
end

function var_0_0.IndexAchieveItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.achieveDataList[arg_19_1]

	arg_19_2:SetData(var_19_0)
end

function var_0_0.OnItemClick(arg_20_0, arg_20_1)
	arg_20_0.itemInfoController:SetSelectedIndex(1)

	local var_20_0 = ActivityStrongholdArtifactCfg[arg_20_1]

	arg_20_0.m_infoName.text = var_20_0.name
	arg_20_0.m_infoDes.text = var_20_0.desc

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_0.m_infoDesTrans)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_0.m_infoTrans)
end

return var_0_0
