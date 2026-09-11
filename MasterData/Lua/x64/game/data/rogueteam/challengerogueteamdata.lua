local var_0_0 = singletonClass("ChallengeRogueTeamData")

function var_0_0:Ctor()
	self.dataList_ = {
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

	for iter_1_0, iter_1_1 in ipairs(self.dataList_) do
		for iter_1_2, iter_1_3 in ipairs(iter_1_1:ExportMethod()) do
			if self[iter_1_3] then
				-- block empty
			elseif iter_1_1[iter_1_3] == nil then
				-- block empty
			else
				self[iter_1_3] = function(arg_2_0, ...)
					return iter_1_1[iter_1_3](iter_1_1, ...)
				end
			end
		end
	end
end

function var_0_0:Init()
	for iter_3_0, iter_3_1 in ipairs(self.dataList_) do
		if iter_3_1.Init then
			iter_3_1:Init()
		end
	end

	self.activityID_ = 0
	self.uiDifficultyID_ = 0
	self.selectDifficultyIDs_ = {}
	self.activiteTemplateID_ = 0
	self.plotID_ = 0
	self.cacheTemplateID_ = 0
	self.passMaxDifficultyIDs_ = {}
	self.refreshMapFlag_ = nil
	self.unOperateData_ = nil
	self.shopData_ = nil
	self.obtainDataList_ = {}
	self.overStatisticsList_ = nil
	self.serverTriggerQueue_ = {}
	self.difficultyClearData_ = {}
	self.endingPassData_ = {}
	self.tecTreeItem_ = {}
	self.isFinishGuide_ = false
end

function var_0_0.SetUIDifficultyID(arg_4_0, arg_4_1)
	arg_4_0.uiDifficultyID_ = arg_4_1
end

function var_0_0:GetUIDifficultyID()
	return self.uiDifficultyID_
end

function var_0_0:GetSelectDifficultyID(arg_6_1)
	return self.selectDifficultyIDs_[arg_6_1] or 0
end

function var_0_0:SetSelectDifficultyID(arg_7_1, arg_7_2)
	self.selectDifficultyIDs_[arg_7_1] = arg_7_2

	if arg_7_2 ~= 0 then
		self:HeroSetLockState(true)
	end

	self.lastDifficultyID_ = arg_7_2 ~= 0 and arg_7_2 or self.lastDifficultyID_
end

function var_0_0:GetLastDifficultyID(arg_8_1)
	return self.lastDifficultyID_
end

function var_0_0:SetPassMaxDifficultyID(arg_9_1, arg_9_2)
	self.passMaxDifficultyIDs_[arg_9_1] = arg_9_2
end

function var_0_0:GetPassMaxDifficultyID(arg_10_1, arg_10_2)
	return self.passMaxDifficultyIDs_[arg_10_1] or 0
end

function var_0_0.SetActiveTemplateID(arg_11_0, arg_11_1)
	arg_11_0.activiteTemplateID_ = arg_11_1
end

function var_0_0:GetActiveTemplateID()
	return self.activiteTemplateID_
end

function var_0_0.SetCacheTemplateID(arg_13_0, arg_13_1)
	arg_13_0.cacheTemplateID_ = arg_13_1
end

function var_0_0:GetCacheTemplateID()
	return self.cacheTemplateID_
end

function var_0_0:ExitPlaying()
	self:SetSelectDifficultyID(ChallengeRogueTeamData:GetActiveTemplateID(), 0)
	self:SetRefreshMapFlag()
	self:PathClearData()
	self:ClearUnOperateData()
	self:ClearShopData()
	self:ClearAllObtainData()
	self:ResetHeroData()
	self:AttributeClearData()
	self:EffectItemClearData()
	self:TreasureClear()
	self:ClearServerTriggerQueue()
	self:ClearOverStatisticsData()
	self:SuitSkillClear()
	self:PlotResetData()
	self:UICacheResetData()
	self:ClearOptionalAffix()
end

function var_0_0:InitPathDataFromServer(arg_16_1)
	self:PathInitData(arg_16_1)
	self:UpdateShopData(arg_16_1.shop_info)
	self:UpdateOperateData(arg_16_1.other_info)
	self:TreasureInitData(arg_16_1.treasure_list)
	self:EffectItemInitData(arg_16_1.other_item_list or {})
	self:EffectInitData(arg_16_1.effect_list or {})
	self:SetActiveTemplateID(arg_16_1.template_id)
	self:SetPlotID(arg_16_1.plot_id)
	self:UIClearPlayAnimatorNodeIDList()

	for iter_16_0, iter_16_1 in pairs(self:PathGetFinishPath()) do
		self:UIInsertPlayAnimatorNodeIDList(iter_16_1)
	end

	local var_16_0 = 0

	for iter_16_2, iter_16_3 in ipairs(arg_16_1.affix_list) do
		var_16_0 = var_16_0 + ActivityAffixPoolCfg[iter_16_3].point
	end

	self:SetOptionalAffix(var_16_0, arg_16_1.affix_list)
end

function var_0_0:InitOutSideFromServer(arg_17_1)
	self:SetCacheTemplateID(arg_17_1.template_id)
	self:SetSelectDifficultyID(arg_17_1.template_id, arg_17_1.difficult or 0)
	self:SetPassMaxDifficultyID(arg_17_1.template_id, arg_17_1.max_difficult)
	self:UpdateHistoryDifficultyClearCnt(arg_17_1.template_id, arg_17_1.his_difficult)
	self:UpdateHistoryEndingPassCnt(arg_17_1.template_id, arg_17_1.his_avg)
	self:UpdateIllustrated(arg_17_1.template_id, arg_17_1.collection_list)
	self:UpdateUnlockIllustrated(arg_17_1.template_id, arg_17_1.unlock_collection)
	self:UpdateViewedIllustrated(arg_17_1.template_id, arg_17_1.view_collection)
	self:InitSkillTreeFromServer(arg_17_1.template_id, arg_17_1.tree_list)
	self:SetLastScoreId(arg_17_1.last_id)
	self:InitRedPoint(arg_17_1.template_id)
end

function var_0_0:GetActivityID()
	return self.activityID_
end

function var_0_0:UpdateGlobalAttribute(arg_19_1)
	self:AttributeUpdate(arg_19_1)
	manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_ATTRIBUTE_VALUE_UPDATE)

	for iter_19_0, iter_19_1 in ipairs(arg_19_1.attr_list) do
		self:MergeAttributeTrigger(iter_19_1)
	end
end

function var_0_0:MergeAttributeTrigger(arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(self.serverTriggerQueue_) do
		if iter_20_1.triggerType == ChallengeRogueTeamConst.SERVER_TRIGGER_TYPE.ATTRIBUTE and iter_20_1.value.attributeID == arg_20_1.attr_id then
			iter_20_1.value.attributeValue = arg_20_1.value

			return
		end
	end

	self:AddServerTriggerQueue(ChallengeRogueTeamConst.SERVER_TRIGGER_TYPE.ATTRIBUTE, {
		attributeID = arg_20_1.attr_id,
		attributeValue = arg_20_1.value
	})
end

function var_0_0:ClearUnOperateData()
	self.unOperateData_.eventType = 0
end

function var_0_0.ClearShopData(arg_22_0)
	arg_22_0.shopData_ = nil
end

function var_0_0:UpdateNode(arg_23_1)
	self:PathUpdateMapNode(arg_23_1)
end

function var_0_0.SetRefreshMapFlag(arg_24_0, arg_24_1)
	arg_24_0.refreshMapFlag_ = arg_24_1
end

function var_0_0:GetRefreshMapFlag()
	return self.refreshMapFlag_
end

function var_0_0:UpdateOperateData(arg_26_1)
	if arg_26_1 then
		local var_26_0 = {}
		local var_26_1 = arg_26_1.event_type

		if arg_26_1.event_type == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.TREASURE then
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
				table.insert(var_26_0[RogueTeamItemCfg[iter_26_9.param].type], {
					index = iter_26_9.index,
					id = iter_26_9.param,
					buyTimes = iter_26_9.buy_times,
					rare = iter_26_9.rare,
					discount = iter_26_9.discount,
					isNew = iter_26_9.is_new == 1
				})
			end
		elseif var_26_1 == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.BAG_ITEM_REPLACE then
			for iter_26_10, iter_26_11 in ipairs(arg_26_1.param_list) do
				var_26_0 = {
					effectID = iter_26_11.param,
					canSelectCnt = iter_26_11.buy_times
				}
			end
		end

		local var_26_2 = {
			eventType = var_26_1,
			paramList = var_26_0,
			dropType = arg_26_1.drop_type
		}

		self.unOperateData_ = var_26_2

		for iter_26_12, iter_26_13 in ipairs(self:GetServerTriggerQueue()) do
			if iter_26_13.triggerType == ChallengeRogueTeamConst.SERVER_TRIGGER_TYPE.OPERATE_POP_WINDOW then
				iter_26_13.value = var_26_2

				return
			end
		end

		self:AddServerTriggerQueue(ChallengeRogueTeamConst.SERVER_TRIGGER_TYPE.OPERATE_POP_WINDOW, var_26_2)
	end
end

function var_0_0:GetUnOperateData()
	return self.unOperateData_
end

function var_0_0.UpdateShopData(arg_28_0, arg_28_1)
	if arg_28_1 then
		local var_28_0 = {}

		if arg_28_1.event_type == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.SHOP then
			var_28_0[ChallengeRogueTeamConst.ITEM_TYPE.TREASURE] = {}
			var_28_0[ChallengeRogueTeamConst.ITEM_TYPE.RELIC] = {}

			for iter_28_0, iter_28_1 in ipairs(arg_28_1.param_list) do
				table.insert(var_28_0[RogueTeamItemCfg[iter_28_1.param].type], {
					index = iter_28_1.index,
					id = iter_28_1.param,
					buyTimes = iter_28_1.buy_times,
					rare = iter_28_1.rare,
					discount = iter_28_1.discount,
					isNew = iter_28_1.is_new == 1
				})
			end

			arg_28_0.shopData_ = {
				eventType = arg_28_1.event_type,
				paramList = var_28_0,
				refreshTimes = arg_28_1.shop_refresh_times
			}
		end
	end
end

function var_0_0:GetShopData()
	return self.shopData_
end

function var_0_0:UpdateObtainItem(arg_30_1)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(arg_30_1.update_list) do
		if var_30_0[#var_30_0] and var_30_0[#var_30_0].sourceType == iter_30_1.source_type and var_30_0[#var_30_0].sourceItemID == iter_30_1.source_item_id and var_30_0[#var_30_0].itemList[1] and var_30_0[#var_30_0].itemList[1].operate == iter_30_1.operate and (var_30_0[#var_30_0].sourceType == ChallengeRogueTeamConst.ITEM_SOURCE_TYPE.HIDE or var_30_0[#var_30_0].sourceType ~= ChallengeRogueTeamConst.ITEM_SOURCE_TYPE.HIDE and #var_30_0[#var_30_0].itemList < 4) then
			table.insert(var_30_0[#var_30_0].itemList, self:ParseObtainData(iter_30_1))
		else
			table.insert(var_30_0, {
				sourceType = iter_30_1.source_type,
				sourceItemID = iter_30_1.source_item_id,
				itemList = {
					(self:ParseObtainData(iter_30_1))
				}
			})
		end
	end

	table.insertto(self.obtainDataList_, var_30_0)

	for iter_30_2, iter_30_3 in ipairs(var_30_0) do
		self:AddServerTriggerQueue(ChallengeRogueTeamConst.SERVER_TRIGGER_TYPE.REWARD_POP_WINDOW, iter_30_3)
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

function var_0_0:ClearObtainData()
	table.remove(self.obtainDataList_, 1)
end

function var_0_0.ClearAllObtainData(arg_33_0)
	arg_33_0.obtainDataList_ = {}
end

function var_0_0:GetObtainDataList()
	return self.obtainDataList_
end

function var_0_0:UpdateHeroHP(arg_35_1)
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

		self:HeroAddUnlockHero(iter_35_1.hero_id, iter_35_1.temp_id, iter_35_1.hp_ratio)
		table.insert(var_35_0, {
			heroID = iter_35_1.hero_id,
			tempID = iter_35_1.temp_id,
			hpRatio = iter_35_1.hp_ratio
		})
	end

	if arg_35_1.modify_type == ChallengeRogueTeamConst.HERO_HP_MODITY_TYPE.RELIC or arg_35_1.modify_type == ChallengeRogueTeamConst.HERO_HP_MODITY_TYPE.EVENT then
		if var_35_1 then
			self:AddServerTriggerQueue(ChallengeRogueTeamConst.SERVER_TRIGGER_TYPE.HERO_UNLOCK)
		else
			self:AddServerTriggerQueue(ChallengeRogueTeamConst.SERVER_TRIGGER_TYPE.HERO_HP_MODITY, {
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

function var_0_0:GetServerTriggerQueue()
	return self.serverTriggerQueue_
end

function var_0_0:AddServerTriggerQueue(arg_37_1, arg_37_2)
	if ChallengeRogueTeamConst.SERVER_TRIGGER_TYPE.MAP_SWITCH == arg_37_1 then
		for iter_37_0 = #self.serverTriggerQueue_, 1, -1 do
			if self.serverTriggerQueue_[iter_37_0].triggerType == ChallengeRogueTeamConst.SERVER_TRIGGER_TYPE.MAP_NODE_EFFECT then
				table.remove(self.serverTriggerQueue_, iter_37_0)
			end
		end

		ChallengeRogueTeamData:UISetNodeEffectID()
	end

	table.insert(self.serverTriggerQueue_, {
		triggerType = arg_37_1,
		value = arg_37_2
	})
end

function var_0_0:InsertServerTriggerQueue(arg_38_1, arg_38_2, arg_38_3)
	table.insert(self.serverTriggerQueue_, arg_38_2, {
		triggerType = arg_38_1,
		value = arg_38_3
	})
end

function var_0_0:RemoveServerTriggerQueue()
	table.remove(self.serverTriggerQueue_, 1)
end

function var_0_0.ClearServerTriggerQueue(arg_40_0)
	arg_40_0.serverTriggerQueue_ = {}
end

function var_0_0:UpdateOverStatisticsData(arg_41_1, arg_41_2)
	self.overStatisticsList_ = {}
	self.overStatisticsUnlockRelic_ = {}

	for iter_41_0, iter_41_1 in ipairs(arg_41_1) do
		self.overStatisticsList_[iter_41_1.key] = iter_41_1.value
	end

	for iter_41_2, iter_41_3 in ipairs(arg_41_2) do
		table.insert(self.overStatisticsUnlockRelic_, iter_41_3)
	end
end

function var_0_0:GetOverStaticUnlockRelicDataList()
	return self.overStatisticsUnlockRelic_
end

function var_0_0:GetOverStatisticsData()
	return self.overStatisticsList_
end

function var_0_0.ClearOverStatisticsData(arg_44_0)
	arg_44_0.overStatisticsList_ = nil
end

function var_0_0.UpdateTotalTime(arg_45_0, arg_45_1)
	arg_45_0.totalTime_ = arg_45_1
end

function var_0_0:GetTotalTime()
	return self.totalTime_ or 0
end

function var_0_0:UpdateHistoryDifficultyClearCnt(arg_47_1, arg_47_2)
	self.difficultyClearData_[arg_47_1] = self.difficultyClearData_[arg_47_1] or {}

	for iter_47_0, iter_47_1 in ipairs(arg_47_2) do
		self.difficultyClearData_[arg_47_1][iter_47_1.key] = iter_47_1.value
	end
end

function var_0_0:AddHistoryDifficultyClearCnt(arg_48_1, arg_48_2)
	self.difficultyClearData_[arg_48_1] = self.difficultyClearData_[arg_48_1] or {}
	self.difficultyClearData_[arg_48_1][arg_48_2] = self:GetHistoryDifficultyClearCnt(arg_48_1, arg_48_2) + 1
end

function var_0_0:GetHistoryDifficultyClearCnt(arg_49_1, arg_49_2)
	self.difficultyClearData_[arg_49_1] = self.difficultyClearData_[arg_49_1] or {}

	return self.difficultyClearData_[arg_49_1][arg_49_2] or 0
end

function var_0_0:UpdateHistoryEndingPassCnt(arg_50_1, arg_50_2)
	self.endingPassData_[arg_50_1] = self.endingPassData_[arg_50_1] or {}

	for iter_50_0, iter_50_1 in ipairs(arg_50_2) do
		self.endingPassData_[arg_50_1][iter_50_1.key] = iter_50_1.value
	end
end

function var_0_0:AddHistoryEndingPassCnt(arg_51_1, arg_51_2)
	self.endingPassData_[arg_51_1] = self.endingPassData_[arg_51_1] or {}
	self.endingPassData_[arg_51_1][arg_51_2] = self:GetHistoryEndingPassCnt(arg_51_1, arg_51_2) + 1
end

function var_0_0:GetHistoryEndingPassCnt(arg_52_1, arg_52_2)
	self.endingPassData_[arg_52_1] = self.endingPassData_[arg_52_1] or {}

	return self.endingPassData_[arg_52_1][arg_52_2] or 0
end

function var_0_0.UpdateGuideState(arg_53_0, arg_53_1)
	arg_53_0.isFinishGuide_ = arg_53_1.finish_guide ~= 0
end

function var_0_0:IsFinishGuide()
	return self.isFinishGuide_
end

function var_0_0.SetGuideStatisticsFlag(arg_55_0, arg_55_1)
	arg_55_0.guideStatisticsFlag_ = arg_55_1
end

function var_0_0:GetGuideStatisticsFlag(arg_56_1)
	return self.guideStatisticsFlag_
end

function var_0_0.SetBattleResultData(arg_57_0, arg_57_1)
	arg_57_0.battleResult_ = {
		[ChallengeRogueTeamConst.BATTLE_RESULT_DATA_TYPE.TREASURE_CNT] = arg_57_1.treasure_num,
		[ChallengeRogueTeamConst.BATTLE_RESULT_DATA_TYPE.RELIC_CNT] = arg_57_1.relic_num,
		[ChallengeRogueTeamConst.BATTLE_RESULT_DATA_TYPE.GOLD_CNT] = arg_57_1.coin_num
	}
end

function var_0_0:GetBattleResultData()
	return self.battleResult_
end

function var_0_0.SetOptionalAffix(arg_59_0, arg_59_1, arg_59_2)
	arg_59_0.levelNum_ = arg_59_1
	arg_59_0.optionalAffixList_ = arg_59_2
end

function var_0_0:GetOptionalAffix()
	return self.levelNum_, self.optionalAffixList_
end

function var_0_0.ClearOptionalAffix(arg_61_0)
	arg_61_0.levelNum_ = 0
	arg_61_0.optionalAffixList_ = {}
end

function var_0_0:InitRedPoint(arg_62_1)
	local var_62_0 = string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_SKILL, arg_62_1)

	for iter_62_0, iter_62_1 in ipairs(RogueTeamSkillTreeCfg.get_id_list_by_template_id[RogueTeamCfg[arg_62_1].tree_temp]) do
		local var_62_1 = string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_SKILL, iter_62_1)
		local var_62_2 = not ChallengeRogueTeamData:IsHasSkill(arg_62_1, iter_62_1) and ChallengeRogueTeamData:CanLevelUpSkill(arg_62_1, iter_62_1)

		manager.redPoint:addGroup(var_62_0, {
			var_62_1
		})
	end

	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_POINT_REWARD, ChallengeRogueTeamTools.GetPointActivityID(arg_62_1)), {
		RedPointConst.CHALLENGE_ROGUE_TEAM_NEW_REWARD
	})
	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_COMMON, ActivityConst.ACTIVITY_ROGUE_4_4), {
		RedPointConst.CHALLENGE_ROGUE_TEAM_NEW_REWARD,
		var_62_0
	})
	self:UpdateActivityRedPoint(arg_62_1)
end

function var_0_0:UpdateActivityRedPoint(arg_63_1)
	self:UpdateSkillRedPoint(arg_63_1)
	manager.redPoint:setTip(RedPointConst.CHALLENGE_ROGUE_TEAM_NEW_REWARD, ChallengeRogueTeamTools.GetIsNewScoreReward(arg_63_1) and 1 or 0)
end

return var_0_0
