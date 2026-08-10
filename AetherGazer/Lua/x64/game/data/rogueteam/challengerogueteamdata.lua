local var_0_0 = singletonClass("ChallengeRogueTeamData")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.dataList_ = {
		require("game.data.rogueTeam.ChallengeRogueTeamPathData").New(),
		require("game.data.rogueTeam.ChallengeRogueTeamHeroData").New(),
		require("game.data.rogueTeam.ChallengeRogueTeamTreasureData").New(),
		require("game.data.rogueTeam.ChallengeRogueTeamSkillData").New(),
		require("game.data.rogueTeam.ChallengeRogueTeamEffectItemListData").New(),
		require("game.data.rogueTeam.ChallengeRogueTeamSuitSkillData").New(),
		require("game.data.rogueTeam.ChallengeRogueTeamAttributeValueData").New(),
		require("game.data.rogueTeam.ChallengeRogueTeamEventData").New(),
		require("game.data.rogueTeam.ChallengeRogueTeamUICacheData").New(),
		require("game.data.rogueTeam.ChallengeRogueTeamPlotData").New(),
		require("game.data.rogueTeam.ChallengeRogueTeamTaskData").New(),
		require("game.data.rogueTeam.ChallengeRogueTeamScoreData").New(),
		require("game.data.rogueTeam.ChallengeRogueTeamIllustratedData").New()
	}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.dataList_) do
		for iter_1_2, iter_1_3 in ipairs(iter_1_1:ExportMethod()) do
			if arg_1_0[iter_1_3] then
				-- block empty
			elseif iter_1_1[iter_1_3] == nil then
				-- block empty
			else
				arg_1_0[iter_1_3] = function(arg_2_0, ...)
					return iter_1_1[iter_1_3](iter_1_1, ...)
				end
			end
		end
	end
end

function var_0_0.Init(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.dataList_) do
		if iter_3_1.Init then
			iter_3_1.Init(iter_3_1)
		end
	end

	arg_3_0.activityID_ = 0
	arg_3_0.uiDifficultyID_ = 0
	arg_3_0.selectDifficultyIDs_ = {}
	arg_3_0.activiteTemplateID_ = 0
	arg_3_0.plotID_ = 0
	arg_3_0.cacheTemplateID_ = 0
	arg_3_0.passMaxDifficultyIDs_ = {}
	arg_3_0.refreshMapFlag_ = nil
	arg_3_0.unOperateData_ = nil
	arg_3_0.shopData_ = nil
	arg_3_0.obtainDataList_ = {}
	arg_3_0.overStatisticsList_ = nil
	arg_3_0.serverTriggerQueue_ = {}
	arg_3_0.difficultyClearData_ = {}
	arg_3_0.endingPassData_ = {}
	arg_3_0.tecTreeItem_ = {}
	arg_3_0.isFinishGuide_ = false
end

function var_0_0.SetUIDifficultyID(arg_4_0, arg_4_1)
	arg_4_0.uiDifficultyID_ = arg_4_1
end

function var_0_0.GetUIDifficultyID(arg_5_0)
	return arg_5_0.uiDifficultyID_
end

function var_0_0.GetSelectDifficultyID(arg_6_0, arg_6_1)
	return arg_6_0.selectDifficultyIDs_[arg_6_1] or 0
end

function var_0_0.SetSelectDifficultyID(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.selectDifficultyIDs_[arg_7_1] = arg_7_2

	if arg_7_2 ~= 0 then
		arg_7_0:HeroSetLockState(true)
	end

	arg_7_0.lastDifficultyID_ = arg_7_2 ~= 0 and arg_7_2 or arg_7_0.lastDifficultyID_
end

function var_0_0.GetLastDifficultyID(arg_8_0, arg_8_1)
	return arg_8_0.lastDifficultyID_
end

function var_0_0.SetPassMaxDifficultyID(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.passMaxDifficultyIDs_[arg_9_1] = arg_9_2
end

function var_0_0.GetPassMaxDifficultyID(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0.passMaxDifficultyIDs_[arg_10_1] or 0
end

function var_0_0.SetActiveTemplateID(arg_11_0, arg_11_1)
	arg_11_0.activiteTemplateID_ = arg_11_1
end

function var_0_0.GetActiveTemplateID(arg_12_0)
	return arg_12_0.activiteTemplateID_
end

function var_0_0.SetCacheTemplateID(arg_13_0, arg_13_1)
	arg_13_0.cacheTemplateID_ = arg_13_1
end

function var_0_0.GetCacheTemplateID(arg_14_0)
	return arg_14_0.cacheTemplateID_
end

function var_0_0.ExitPlaying(arg_15_0)
	arg_15_0:SetSelectDifficultyID(ChallengeRogueTeamData:GetActiveTemplateID(), 0)
	arg_15_0:SetRefreshMapFlag()
	arg_15_0:PathClearData()
	arg_15_0:ClearUnOperateData()
	arg_15_0:ClearShopData()
	arg_15_0:ClearAllObtainData()
	arg_15_0:ResetHeroData()
	arg_15_0:AttributeClearData()
	arg_15_0:EffectItemClearData()
	arg_15_0:TreasureClear()
	arg_15_0:ClearServerTriggerQueue()
	arg_15_0:ClearOverStatisticsData()
	arg_15_0:SuitSkillClear()
	arg_15_0:PlotResetData()
	arg_15_0:UICacheResetData()
	arg_15_0:ClearOptionalAffix()
end

function var_0_0.InitPathDataFromServer(arg_16_0, arg_16_1)
	arg_16_0:PathInitData(arg_16_1)
	arg_16_0:UpdateShopData(arg_16_1.shop_info)
	arg_16_0:UpdateOperateData(arg_16_1.other_info)
	arg_16_0:TreasureInitData(arg_16_1.treasure_list)
	arg_16_0:EffectItemInitData(arg_16_1.other_item_list or {})
	arg_16_0:EffectInitData(arg_16_1.effect_list or {})
	arg_16_0:SetActiveTemplateID(arg_16_1.template_id)
	arg_16_0:SetPlotID(arg_16_1.plot_id)
	arg_16_0:UIClearPlayAnimatorNodeIDList()

	for iter_16_0, iter_16_1 in pairs(arg_16_0:PathGetFinishPath()) do
		arg_16_0:UIInsertPlayAnimatorNodeIDList(iter_16_1)
	end

	local var_16_0 = 0

	for iter_16_2, iter_16_3 in ipairs(arg_16_1.affix_list) do
		var_16_0 = var_16_0 + ActivityAffixPoolCfg[iter_16_3].point
	end

	arg_16_0:SetOptionalAffix(var_16_0, arg_16_1.affix_list)
end

function var_0_0.InitOutSideFromServer(arg_17_0, arg_17_1)
	arg_17_0:SetCacheTemplateID(arg_17_1.template_id)
	arg_17_0:SetSelectDifficultyID(arg_17_1.template_id, arg_17_1.difficult or 0)
	arg_17_0:SetPassMaxDifficultyID(arg_17_1.template_id, arg_17_1.max_difficult)
	arg_17_0:UpdateHistoryDifficultyClearCnt(arg_17_1.template_id, arg_17_1.his_difficult)
	arg_17_0:UpdateHistoryEndingPassCnt(arg_17_1.template_id, arg_17_1.his_avg)
	arg_17_0:UpdateIllustrated(arg_17_1.template_id, arg_17_1.collection_list)
	arg_17_0:UpdateUnlockIllustrated(arg_17_1.template_id, arg_17_1.unlock_collection)
	arg_17_0:UpdateViewedIllustrated(arg_17_1.template_id, arg_17_1.view_collection)
	arg_17_0:InitSkillTreeFromServer(arg_17_1.template_id, arg_17_1.tree_list)
	arg_17_0:SetLastScoreId(arg_17_1.last_id)
	arg_17_0:InitRedPoint(arg_17_1.template_id)
end

function var_0_0.GetActivityID(arg_18_0)
	return arg_18_0.activityID_
end

function var_0_0.UpdateGlobalAttribute(arg_19_0, arg_19_1)
	arg_19_0:AttributeUpdate(arg_19_1)
	manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_ATTRIBUTE_VALUE_UPDATE)

	for iter_19_0, iter_19_1 in ipairs(arg_19_1.attr_list) do
		arg_19_0:MergeAttributeTrigger(iter_19_1)
	end
end

function var_0_0.MergeAttributeTrigger(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.attr_id
	local var_20_1 = arg_20_1.value

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.serverTriggerQueue_) do
		if iter_20_1.triggerType == ChallengeRogueTeamConst.SERVER_TRIGGER_TYPE.ATTRIBUTE and iter_20_1.value.attributeID == var_20_0 then
			iter_20_1.value.attributeValue = var_20_1

			return
		end
	end

	arg_20_0:AddServerTriggerQueue(ChallengeRogueTeamConst.SERVER_TRIGGER_TYPE.ATTRIBUTE, {
		attributeID = var_20_0,
		attributeValue = var_20_1
	})
end

function var_0_0.ClearUnOperateData(arg_21_0)
	arg_21_0.unOperateData_.eventType = 0
end

function var_0_0.ClearShopData(arg_22_0)
	arg_22_0.shopData_ = nil
end

function var_0_0.UpdateNode(arg_23_0, arg_23_1)
	arg_23_0:PathUpdateMapNode(arg_23_1)
end

function var_0_0.SetRefreshMapFlag(arg_24_0, arg_24_1)
	arg_24_0.refreshMapFlag_ = arg_24_1
end

function var_0_0.GetRefreshMapFlag(arg_25_0)
	return arg_25_0.refreshMapFlag_
end

function var_0_0.UpdateOperateData(arg_26_0, arg_26_1)
	if arg_26_1 then
		local var_26_0 = {}
		local var_26_1 = arg_26_1.event_type

		if var_26_1 == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.TREASURE then
			for iter_26_0, iter_26_1 in ipairs(arg_26_1.param_list) do
				var_26_0[iter_26_0] = {
					index = iter_26_1.index,
					id = iter_26_1.param,
					rare = iter_26_1.rare,
					isNew = iter_26_1.is_new == 1
				}
			end
		elseif var_26_1 == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.RELIC then
			for iter_26_2, iter_26_3 in ipairs(arg_26_1.param_list) do
				var_26_0[iter_26_2] = {
					index = iter_26_3.index,
					id = iter_26_3.param,
					isNew = iter_26_3.is_new == 1
				}
			end
		elseif var_26_1 == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.INIT_REWARD then
			for iter_26_4, iter_26_5 in ipairs(arg_26_1.param_list) do
				var_26_0[iter_26_4] = {
					index = iter_26_5.index,
					id = iter_26_5.param,
					isNew = iter_26_5.is_new == 1
				}
			end
		elseif var_26_1 == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.MECHANISM then
			for iter_26_6, iter_26_7 in ipairs(arg_26_1.param_list) do
				var_26_0[iter_26_6] = {
					index = iter_26_7.index,
					id = iter_26_7.param,
					isNew = iter_26_7.is_new == 1
				}
			end
		elseif var_26_1 == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.SHOP then
			var_26_0[ChallengeRogueTeamConst.ITEM_TYPE.TREASURE] = {}
			var_26_0[ChallengeRogueTeamConst.ITEM_TYPE.RELIC] = {}

			for iter_26_8, iter_26_9 in ipairs(arg_26_1.param_list) do
				local var_26_2 = {
					index = iter_26_9.index,
					id = iter_26_9.param,
					buyTimes = iter_26_9.buy_times,
					rare = iter_26_9.rare,
					discount = iter_26_9.discount,
					isNew = iter_26_9.is_new == 1
				}

				table.insert(var_26_0[RogueTeamItemCfg[iter_26_9.param].type], var_26_2)
			end
		elseif var_26_1 == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.BAG_ITEM_REPLACE then
			for iter_26_10, iter_26_11 in ipairs(arg_26_1.param_list) do
				var_26_0 = {
					effectID = iter_26_11.param,
					canSelectCnt = iter_26_11.buy_times
				}
			end
		end

		local var_26_3 = {
			eventType = var_26_1,
			paramList = var_26_0,
			dropType = arg_26_1.drop_type
		}

		arg_26_0.unOperateData_ = var_26_3

		for iter_26_12, iter_26_13 in ipairs(arg_26_0:GetServerTriggerQueue()) do
			if iter_26_13.triggerType == ChallengeRogueTeamConst.SERVER_TRIGGER_TYPE.OPERATE_POP_WINDOW then
				iter_26_13.value = var_26_3

				return
			end
		end

		arg_26_0:AddServerTriggerQueue(ChallengeRogueTeamConst.SERVER_TRIGGER_TYPE.OPERATE_POP_WINDOW, var_26_3)
	end
end

function var_0_0.GetUnOperateData(arg_27_0)
	return arg_27_0.unOperateData_
end

function var_0_0.UpdateShopData(arg_28_0, arg_28_1)
	if arg_28_1 then
		local var_28_0 = {}
		local var_28_1 = arg_28_1.event_type

		if var_28_1 == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.SHOP then
			var_28_0[ChallengeRogueTeamConst.ITEM_TYPE.TREASURE] = {}
			var_28_0[ChallengeRogueTeamConst.ITEM_TYPE.RELIC] = {}

			for iter_28_0, iter_28_1 in ipairs(arg_28_1.param_list) do
				local var_28_2 = {
					index = iter_28_1.index,
					id = iter_28_1.param,
					buyTimes = iter_28_1.buy_times,
					rare = iter_28_1.rare,
					discount = iter_28_1.discount,
					isNew = iter_28_1.is_new == 1
				}

				table.insert(var_28_0[RogueTeamItemCfg[iter_28_1.param].type], var_28_2)
			end

			arg_28_0.shopData_ = {
				eventType = var_28_1,
				paramList = var_28_0,
				refreshTimes = arg_28_1.shop_refresh_times
			}
		end
	end
end

function var_0_0.GetShopData(arg_29_0)
	return arg_29_0.shopData_
end

function var_0_0.UpdateObtainItem(arg_30_0, arg_30_1)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(arg_30_1.update_list) do
		local var_30_1 = var_30_0[#var_30_0]

		if var_30_1 and var_30_1.sourceType == iter_30_1.source_type and var_30_1.sourceItemID == iter_30_1.source_item_id and var_30_1.itemList[1] and var_30_1.itemList[1].operate == iter_30_1.operate and (var_30_1.sourceType == ChallengeRogueTeamConst.ITEM_SOURCE_TYPE.HIDE or var_30_1.sourceType ~= ChallengeRogueTeamConst.ITEM_SOURCE_TYPE.HIDE and #var_30_1.itemList < 4) then
			table.insert(var_30_1.itemList, arg_30_0:ParseObtainData(iter_30_1))
		else
			local var_30_2 = {
				sourceType = iter_30_1.source_type,
				sourceItemID = iter_30_1.source_item_id,
				itemList = {
					(arg_30_0:ParseObtainData(iter_30_1))
				}
			}

			table.insert(var_30_0, var_30_2)
		end
	end

	table.insertto(arg_30_0.obtainDataList_, var_30_0)

	for iter_30_2, iter_30_3 in ipairs(var_30_0) do
		arg_30_0:AddServerTriggerQueue(ChallengeRogueTeamConst.SERVER_TRIGGER_TYPE.REWARD_POP_WINDOW, iter_30_3)
	end
end

function var_0_0.ParseObtainData(arg_31_0, arg_31_1)
	return {
		id = arg_31_1.id,
		operate = arg_31_1.operate,
		rare = arg_31_1.rare,
		sourceRare = arg_31_1.source_rare,
		isNew = arg_31_1.is_new == 1
	}
end

function var_0_0.ClearObtainData(arg_32_0)
	table.remove(arg_32_0.obtainDataList_, 1)
end

function var_0_0.ClearAllObtainData(arg_33_0)
	arg_33_0.obtainDataList_ = {}
end

function var_0_0.GetObtainDataList(arg_34_0)
	return arg_34_0.obtainDataList_
end

function var_0_0.UpdateHeroHP(arg_35_0, arg_35_1)
	local var_35_0 = {}
	local var_35_1 = false
	local var_35_2 = false

	for iter_35_0, iter_35_1 in ipairs(arg_35_1.hero_list) do
		if not ChallengeRogueTeamTools.IsHeroInTeam(iter_35_1.hero_id, iter_35_1.temp_id) then
			var_35_1 = true
		end

		if ChallengeRogueTeamTools.IsAddHeroHP(iter_35_1.hero_id, iter_35_1.temp_id, iter_35_1.hp_ratio) then
			var_35_2 = true
		end

		arg_35_0:HeroAddUnlockHero(iter_35_1.hero_id, iter_35_1.temp_id, iter_35_1.hp_ratio)
		table.insert(var_35_0, {
			heroID = iter_35_1.hero_id,
			tempID = iter_35_1.temp_id,
			hpRatio = iter_35_1.hp_ratio
		})
	end

	local var_35_3 = arg_35_1.modify_type

	if var_35_3 == ChallengeRogueTeamConst.HERO_HP_MODITY_TYPE.RELIC or var_35_3 == ChallengeRogueTeamConst.HERO_HP_MODITY_TYPE.EVENT then
		if var_35_1 then
			arg_35_0:AddServerTriggerQueue(ChallengeRogueTeamConst.SERVER_TRIGGER_TYPE.HERO_UNLOCK)
		else
			arg_35_0:AddServerTriggerQueue(ChallengeRogueTeamConst.SERVER_TRIGGER_TYPE.HERO_HP_MODITY, {
				isAddHp = var_35_2,
				heroHPList = var_35_0
			})
		end
	else
		for iter_35_2, iter_35_3 in ipairs(var_35_0) do
			ChallengeRogueTeamData:UISetTeamHPData(iter_35_3.heroID, iter_35_3.tempID, iter_35_3.hpRatio)
		end
	end
end

function var_0_0.GetServerTriggerQueue(arg_36_0)
	return arg_36_0.serverTriggerQueue_
end

function var_0_0.AddServerTriggerQueue(arg_37_0, arg_37_1, arg_37_2)
	if ChallengeRogueTeamConst.SERVER_TRIGGER_TYPE.MAP_SWITCH == arg_37_1 then
		for iter_37_0 = #arg_37_0.serverTriggerQueue_, 1, -1 do
			if arg_37_0.serverTriggerQueue_[iter_37_0].triggerType == ChallengeRogueTeamConst.SERVER_TRIGGER_TYPE.MAP_NODE_EFFECT then
				table.remove(arg_37_0.serverTriggerQueue_, iter_37_0)
			end
		end

		ChallengeRogueTeamData:UISetNodeEffectID()
	end

	table.insert(arg_37_0.serverTriggerQueue_, {
		triggerType = arg_37_1,
		value = arg_37_2
	})
end

function var_0_0.InsertServerTriggerQueue(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	table.insert(arg_38_0.serverTriggerQueue_, arg_38_2, {
		triggerType = arg_38_1,
		value = arg_38_3
	})
end

function var_0_0.RemoveServerTriggerQueue(arg_39_0)
	table.remove(arg_39_0.serverTriggerQueue_, 1)
end

function var_0_0.ClearServerTriggerQueue(arg_40_0)
	arg_40_0.serverTriggerQueue_ = {}
end

function var_0_0.UpdateOverStatisticsData(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0.overStatisticsList_ = {}
	arg_41_0.overStatisticsUnlockRelic_ = {}

	for iter_41_0, iter_41_1 in ipairs(arg_41_1) do
		arg_41_0.overStatisticsList_[iter_41_1.key] = iter_41_1.value
	end

	for iter_41_2, iter_41_3 in ipairs(arg_41_2) do
		table.insert(arg_41_0.overStatisticsUnlockRelic_, iter_41_3)
	end
end

function var_0_0.GetOverStaticUnlockRelicDataList(arg_42_0)
	return arg_42_0.overStatisticsUnlockRelic_
end

function var_0_0.GetOverStatisticsData(arg_43_0)
	return arg_43_0.overStatisticsList_
end

function var_0_0.ClearOverStatisticsData(arg_44_0)
	arg_44_0.overStatisticsList_ = nil
end

function var_0_0.UpdateTotalTime(arg_45_0, arg_45_1)
	arg_45_0.totalTime_ = arg_45_1
end

function var_0_0.GetTotalTime(arg_46_0)
	return arg_46_0.totalTime_ or 0
end

function var_0_0.UpdateHistoryDifficultyClearCnt(arg_47_0, arg_47_1, arg_47_2)
	arg_47_0.difficultyClearData_[arg_47_1] = arg_47_0.difficultyClearData_[arg_47_1] or {}

	for iter_47_0, iter_47_1 in ipairs(arg_47_2) do
		arg_47_0.difficultyClearData_[arg_47_1][iter_47_1.key] = iter_47_1.value
	end
end

function var_0_0.AddHistoryDifficultyClearCnt(arg_48_0, arg_48_1, arg_48_2)
	arg_48_0.difficultyClearData_[arg_48_1] = arg_48_0.difficultyClearData_[arg_48_1] or {}
	arg_48_0.difficultyClearData_[arg_48_1][arg_48_2] = arg_48_0:GetHistoryDifficultyClearCnt(arg_48_1, arg_48_2) + 1
end

function var_0_0.GetHistoryDifficultyClearCnt(arg_49_0, arg_49_1, arg_49_2)
	arg_49_0.difficultyClearData_[arg_49_1] = arg_49_0.difficultyClearData_[arg_49_1] or {}

	return arg_49_0.difficultyClearData_[arg_49_1][arg_49_2] or 0
end

function var_0_0.UpdateHistoryEndingPassCnt(arg_50_0, arg_50_1, arg_50_2)
	arg_50_0.endingPassData_[arg_50_1] = arg_50_0.endingPassData_[arg_50_1] or {}

	for iter_50_0, iter_50_1 in ipairs(arg_50_2) do
		arg_50_0.endingPassData_[arg_50_1][iter_50_1.key] = iter_50_1.value
	end
end

function var_0_0.AddHistoryEndingPassCnt(arg_51_0, arg_51_1, arg_51_2)
	arg_51_0.endingPassData_[arg_51_1] = arg_51_0.endingPassData_[arg_51_1] or {}
	arg_51_0.endingPassData_[arg_51_1][arg_51_2] = arg_51_0:GetHistoryEndingPassCnt(arg_51_1, arg_51_2) + 1
end

function var_0_0.GetHistoryEndingPassCnt(arg_52_0, arg_52_1, arg_52_2)
	arg_52_0.endingPassData_[arg_52_1] = arg_52_0.endingPassData_[arg_52_1] or {}

	return arg_52_0.endingPassData_[arg_52_1][arg_52_2] or 0
end

function var_0_0.UpdateGuideState(arg_53_0, arg_53_1)
	arg_53_0.isFinishGuide_ = arg_53_1.finish_guide ~= 0
end

function var_0_0.IsFinishGuide(arg_54_0)
	return arg_54_0.isFinishGuide_
end

function var_0_0.SetGuideStatisticsFlag(arg_55_0, arg_55_1)
	arg_55_0.guideStatisticsFlag_ = arg_55_1
end

function var_0_0.GetGuideStatisticsFlag(arg_56_0, arg_56_1)
	return arg_56_0.guideStatisticsFlag_
end

function var_0_0.SetBattleResultData(arg_57_0, arg_57_1)
	arg_57_0.battleResult_ = {
		[ChallengeRogueTeamConst.BATTLE_RESULT_DATA_TYPE.TREASURE_CNT] = arg_57_1.treasure_num,
		[ChallengeRogueTeamConst.BATTLE_RESULT_DATA_TYPE.RELIC_CNT] = arg_57_1.relic_num,
		[ChallengeRogueTeamConst.BATTLE_RESULT_DATA_TYPE.GOLD_CNT] = arg_57_1.coin_num
	}
end

function var_0_0.GetBattleResultData(arg_58_0)
	return arg_58_0.battleResult_
end

function var_0_0.SetOptionalAffix(arg_59_0, arg_59_1, arg_59_2)
	arg_59_0.levelNum_ = arg_59_1
	arg_59_0.optionalAffixList_ = arg_59_2
end

function var_0_0.GetOptionalAffix(arg_60_0)
	return arg_60_0.levelNum_, arg_60_0.optionalAffixList_
end

function var_0_0.ClearOptionalAffix(arg_61_0)
	arg_61_0.levelNum_ = 0
	arg_61_0.optionalAffixList_ = {}
end

function var_0_0.InitRedPoint(arg_62_0, arg_62_1)
	local var_62_0 = RogueTeamSkillTreeCfg.get_id_list_by_template_id[RogueTeamCfg[arg_62_1].tree_temp]
	local var_62_1 = string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_SKILL, arg_62_1)

	for iter_62_0, iter_62_1 in ipairs(var_62_0) do
		local var_62_2 = string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_SKILL, iter_62_1)
		local var_62_3

		var_62_3 = not ChallengeRogueTeamData:IsHasSkill(arg_62_1, iter_62_1) and ChallengeRogueTeamData:CanLevelUpSkill(arg_62_1, iter_62_1)

		manager.redPoint:addGroup(var_62_1, {
			var_62_2
		})
	end

	local var_62_4 = string.format("%s_%s", RedPointConst.ACTIVITY_POINT_REWARD, ChallengeRogueTeamTools.GetPointActivityID(arg_62_1))

	manager.redPoint:addGroup(var_62_4, {
		RedPointConst.CHALLENGE_ROGUE_TEAM_NEW_REWARD
	})
	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_COMMON, ActivityConst.ACTIVITY_ROGUE_4_4), {
		RedPointConst.CHALLENGE_ROGUE_TEAM_NEW_REWARD,
		var_62_1
	})
	arg_62_0:UpdateActivityRedPoint(arg_62_1)
end

function var_0_0.UpdateActivityRedPoint(arg_63_0, arg_63_1)
	arg_63_0:UpdateSkillRedPoint(arg_63_1)

	local var_63_0 = ChallengeRogueTeamTools.GetIsNewScoreReward(arg_63_1)

	manager.redPoint:setTip(RedPointConst.CHALLENGE_ROGUE_TEAM_NEW_REWARD, var_63_0 and 1 or 0)
end

return var_0_0
