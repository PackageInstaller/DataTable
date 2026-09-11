local var_0_0 = {
	GetMapMaxRowCnt = function()
		return 5
	end,
	GetRotationValueX = function()
		return 8
	end,
	GetMapRadio = function()
		return -660
	end,
	IsActiveNode = function(arg_4_0)
		if ChallengeRogueTeamData:PathGetSelectedNodeID() == arg_4_0 then
			return true
		end

		if ChallengeRogueTeamData:PathGetNodeData(arg_4_0).state ~= ChallengeRogueTeamConst.NODE_STATE.LOCK then
			return true
		end

		return false
	end,
	IsCanClickNode = function(arg_5_0)
		local var_5_0 = ChallengeRogueTeamData:PathGetSelectedNodeID()

		if var_5_0 == arg_5_0 then
			return true
		end

		if var_5_0 == 0 and ChallengeRogueTeamData:PathGetNodeData(arg_5_0).state == ChallengeRogueTeamConst.NODE_STATE.UNCLEAN then
			return true
		end

		return false
	end,
	IsBattleNode = function(arg_6_0)
		if arg_6_0 == ChallengeRogueTeamConst.NODE_TYPE.BATTLE_NORMAL or arg_6_0 == ChallengeRogueTeamConst.NODE_TYPE.BATTLE_ELITE or arg_6_0 == ChallengeRogueTeamConst.NODE_TYPE.BATTLE_BOSS or arg_6_0 == ChallengeRogueTeamConst.NODE_TYPE.BATTLE_LAST_BOSS then
			return true
		else
			return false
		end
	end
}

function var_0_0.IsActiveLine(arg_7_0, arg_7_1)
	if var_0_0.IsPostNode(arg_7_1) then
		return true
	else
		return ChallengeRogueTeamData:PathGetNodeData(arg_7_1).state ~= ChallengeRogueTeamConst.NODE_STATE.LOCK and ChallengeRogueTeamData:PathGetNodeData(arg_7_0).state ~= ChallengeRogueTeamConst.NODE_STATE.LOCK
	end
end

function var_0_0.IsPostNode(arg_8_0)
	return var_0_0.GetCanSelecteNodeCol() < ChallengeRogueTeamData:PathGetNodeData(arg_8_0).col
end

function var_0_0.GetCanSelecteNodeCol()
	local var_9_0 = #ChallengeRogueTeamData:PathGetNodePathList()
	local var_9_1 = ChallengeRogueTeamData:PathGetSelectedNodeID()
	local var_9_2 = #ChallengeRogueTeamData:PathGetFinishPath() + 1

	if var_9_1 ~= 0 then
		local var_9_3 = ChallengeRogueTeamData:PathGetNodeData(var_9_1)

		if not ChallengeRogueTeamTools.HasMapSwitchEffect() and var_9_3 and var_9_3.state == ChallengeRogueTeamConst.NODE_STATE.CLEAR then
			var_9_2 = var_9_2 + 1
		end
	end

	if var_9_0 < var_9_2 then
		return var_9_0
	else
		return var_9_2
	end
end

function var_0_0.GetCanSelectNodeIDList()
	local var_10_0 = ChallengeRogueTeamData:PathGetFinishPath()
	local var_10_1 = {}

	if #var_10_0 > 0 then
		local var_10_2 = ChallengeRogueTeamData:PathGetNodeData(var_10_0[#var_10_0])

		if var_10_2 then
			var_10_1 = clone(var_10_2.nextIDList)
		end
	else
		for iter_10_0, iter_10_1 in pairs(ChallengeRogueTeamData:PathGetNodePathList()[1]) do
			table.insert(var_10_1, iter_10_1)
		end
	end

	return var_10_1
end

function var_0_0.IsCanReplaceNode(arg_11_0, arg_11_1)
	if ChallengeRogueTeamData:PathGetNodeData(arg_11_0).row == 0 then
		return false
	end

	return table.keyof(arg_11_1, arg_11_0) ~= nil
end

function var_0_0.GetFollowNodeIDList()
	local var_12_0 = ChallengeRogueTeamData:PathGetSelectedNodeID()

	if var_12_0 == 0 then
		local var_12_1 = ChallengeRogueTeamData:PathGetFinishPath()

		if #var_12_1 <= 0 then
			return var_0_0.GetAllNodeIDList()
		end

		var_12_0 = var_12_1[#var_12_1]
	end

	return var_0_0.GetFollowNodeList(var_12_0)
end

function var_0_0.GetFollowNodeList(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(ChallengeRogueTeamData:PathGetNodeData(arg_13_0).nextIDList) do
		if table.keyof(var_13_0, iter_13_1) == nil then
			local var_13_1 = var_0_0.GetFollowNodeList(iter_13_1)

			table.insert(var_13_0, iter_13_1)
			table.mergeinsert(var_13_0, var_13_1)
		end
	end

	return var_13_0
end

function var_0_0.GetAllNodeIDList()
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(ChallengeRogueTeamData:PathGetNodePathList()) do
		for iter_14_2, iter_14_3 in pairs(iter_14_1) do
			table.insert(var_14_0, iter_14_3)
		end
	end

	return var_14_0
end

function var_0_0.GetFloorName()
	return RogueTeamMapFloorCfg[var_0_0.GetMapFloorID()].name
end

function var_0_0.GetFloorPrefabPath()
	return RogueTeamMapFloorCfg[var_0_0.GetMapFloorID()].prefab_name
end

function var_0_0.GetMapFloorID()
	local var_17_0 = ChallengeRogueTeamData:PathGetCurrentFloorNum()

	return RogueTeamMapFloorCfg.get_id_list_by_temp_id_floor_id[RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].map_floor_temp][(not ChallengeRogueTeamData:PathIsNormalMap() or nil) and 102][1]
end

function var_0_0.IsClearMapFloor()
	if ChallengeRogueTeamData:GetRefreshMapFlag() == nil or var_0_0.HasOnClearStateNode() then
		return false
	end

	return true
end

function var_0_0.HasOnClearStateNode()
	if ChallengeRogueTeamData:PathGetSelectedNodeID() ~= 0 then
		return true
	end

	for iter_19_0, iter_19_1 in pairs(ChallengeRogueTeamData:PathGetNodeList()) do
		if iter_19_1.state == ChallengeRogueTeamConst.NODE_STATE.CLEAN then
			return true
		end
	end

	return false
end

function var_0_0.IsGuideFloor()
	return ChallengeRogueTeamData:PathGetCurrentFloorNum() == ChallengeRogueTeamConst.GUIDE_FLOOR_NUM
end

function var_0_0.GetBuffList()
	return ChallengeRogueTeamData:EffectGetDataList()
end

function var_0_0.HasObtainItem(arg_22_0)
	if RogueTeamItemCfg[arg_22_0].type == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE then
		for iter_22_0, iter_22_1 in pairs(ChallengeRogueTeamData:TreasureGetList()) do
			if arg_22_0 == iter_22_1.id then
				return true
			end
		end
	elseif RogueTeamItemCfg[arg_22_0].type == ChallengeRogueTeamConst.ITEM_TYPE.SUIT_SKILL then
		return arg_22_0 == var_0_0.GetItemIDByCampID((ChallengeRogueTeamData:SuitSkillGetID()))
	else
		for iter_22_2, iter_22_3 in ipairs(ChallengeRogueTeamData:EffectItemGetDataList(RogueTeamItemCfg[arg_22_0].type)) do
			if arg_22_0 == iter_22_3.id then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetTaskActivityID(arg_23_0)
	for iter_23_0, iter_23_1 in ipairs(ActivityCfg[RogueTeamCfg[arg_23_0].activity_id].sub_activity_list) do
		if ActivityCfg[iter_23_1].activity_template == ActivityTemplateConst.CHALLENGE_ROGUE_TEAM_TASK then
			return iter_23_1
		end
	end

	return ""
end

function var_0_0.GetPointActivityID(arg_24_0)
	for iter_24_0, iter_24_1 in ipairs(ActivityCfg[RogueTeamCfg[arg_24_0].activity_id].sub_activity_list) do
		if ActivityCfg[iter_24_1].activity_template == ActivityTemplateConst.CHALLENGE_ROGUE_TEAM_SCORE then
			return iter_24_1
		end
	end

	return ""
end

function var_0_0.GetIlluStratedTaskActivityID(arg_25_0)
	for iter_25_0, iter_25_1 in ipairs(ActivityCfg[RogueTeamCfg[arg_25_0].activity_id].sub_activity_list) do
		if ActivityCfg[iter_25_1].activity_template == ActivityTemplateConst.CHALLENGE_ROGUE_TEAM_COLLECTION then
			return iter_25_1
		end
	end

	return ""
end

function var_0_0.GetCollectActivityIDByType(arg_26_0, arg_26_1)
	return ActivityCfg[ActivityCfg[RogueTeamCfg[arg_26_0].activity_id].sub_activity_list[#ActivityCfg[RogueTeamCfg[arg_26_0].activity_id].sub_activity_list]].sub_activity_list[arg_26_1]
end

function var_0_0.GetTreasureCollectionActivityIDByCamp(arg_27_0, arg_27_1)
	return ActivityCfg[ActivityCfg[ActivityCfg[RogueTeamCfg[arg_27_0].activity_id].sub_activity_list[#ActivityCfg[RogueTeamCfg[arg_27_0].activity_id].sub_activity_list]].sub_activity_list[ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.CAMP]].sub_activity_list[arg_27_1]
end

function var_0_0.GetTeamplateIDByActivityID(arg_28_0)
	return RogueTeamCfg.get_id_list_by_activity_id[ActivityCfg.get_id_list_by_sub_activity_list[arg_28_0][1]][1]
end

function var_0_0.GetMaxDifficultyID()
	local var_29_0 = RogueTeamDifficultyCfg.get_id_list_by_template_id[RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].difficulty_temp]

	for iter_29_0 = #var_29_0, 2, -1 do
		if IsConditionAchieved(RogueTeamDifficultyCfg[var_29_0[iter_29_0]].unlock_condition) then
			return var_29_0[iter_29_0]
		end
	end

	return var_29_0[1]
end

function var_0_0.HasNewRewardPopWindow()
	return #ChallengeRogueTeamData:GetObtainDataList() > 0
end

function var_0_0.HasNewPopWindow()
	local var_31_0 = ChallengeRogueTeamData:GetUnOperateData().eventType

	if var_31_0 ~= 0 and var_31_0 ~= nil then
		return var_31_0 ~= ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.SHOP
	else
		return false
	end
end

function var_0_0.HasNewShopPopWindow()
	return ChallengeRogueTeamData:GetShopData() ~= nil
end

function var_0_0.HasNewEventPopWindow()
	return ChallengeRogueTeamData:EventGetCurrentID() ~= 0
end

function var_0_0.GetItemPopText(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = arg_34_2 == ChallengeRogueTeamConst.ITEM_OPERATE.DELETE and GetTips("ROGUE_TEAM_LOST_WF") or GetTips("ROGUE_TEAM_OBTAIN_WF")
	local var_34_1 = arg_34_3 == ChallengeRogueTeamConst.ITEM_TYPE.RELIC and GetTips("ROGUE_TEAM_RELIC_NAME") or GetTips("ROGUE_TEAM_TREASURE_NAME")

	if arg_34_0 == ChallengeRogueTeamConst.ITEM_SOURCE_TYPE.RELIC then
		return string.format(GetTips("ROGUE_TEAM_RELIC_EFFECT_ACTIVE_WF"), var_34_1)
	else
		return string.format("%s%s", var_34_0, var_34_1)
	end
end

function var_0_0:GetSelectItemText()
	if self.dropType == 1 then
		return GetTips("CHALLENGE_ROGUE_TEAM_ADDITIONAL_CHOOSE_TREASURE")
	elseif self.dropType == 2 then
		return GetTips("CHALLENGE_ROGUE_TEAM_ADDITIONAL_CHOOSE_TREASURE_2")
	end

	local var_35_0 = self.eventType

	if self.eventType == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.INIT_REWARD then
		return var_0_0.GetItemTypeText(ChallengeRogueTeamConst.ITEM_TYPE.INIT_REWARD)
	elseif var_35_0 == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.MECHANISM then
		return var_0_0.GetItemTypeText(ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM)
	elseif var_35_0 == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.RELIC then
		return string.format(GetTips("ROGUE_TEAM_SELECT_ONE"), var_0_0.GetItemTypeText(ChallengeRogueTeamConst.ITEM_TYPE.RELIC))
	elseif var_35_0 == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.TREASURE then
		return string.format(GetTips("ROGUE_TEAM_SELECT_ONE"), var_0_0.GetItemTypeText(ChallengeRogueTeamConst.ITEM_TYPE.TREASURE))
	else
		return "未知的类型" .. var_35_0
	end
end

function var_0_0.GetItemTypeText(arg_36_0)
	if arg_36_0 == ChallengeRogueTeamConst.ITEM_TYPE.INIT_REWARD then
		return GetTips("ROGUE_TEAM_OBTAIN_INIT_REWARD")
	elseif arg_36_0 == ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM then
		return GetTips("ROGUE_TEAM_OBTAIN_MECHANISM_REWARD")
	elseif arg_36_0 == ChallengeRogueTeamConst.ITEM_TYPE.RELIC then
		return GetTips("ROGUE_TEAM_RELIC_NAME")
	elseif arg_36_0 == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE then
		return GetTips("ROGUE_TEAM_TREASURE_NAME")
	else
		return "未知的类型" .. arg_36_0
	end
end

function var_0_0.GetItemTypeByEventType(arg_37_0)
	if arg_37_0 == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.INIT_REWARD then
		return ChallengeRogueTeamConst.ITEM_TYPE.INIT_REWARD
	elseif arg_37_0 == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.MECHANISM then
		return ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM
	elseif arg_37_0 == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.RELIC then
		return ChallengeRogueTeamConst.ITEM_TYPE.RELIC
	elseif arg_37_0 == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.TREASURE then
		return ChallengeRogueTeamConst.ITEM_TYPE.TREASURE
	end
end

function var_0_0.NeedPlayTreasureEffectAnimation(arg_38_0)
	if not var_0_0.HasSuitSkillPop() and ChallengeRogueTeamData:SuitSkillGetID() ~= 0 then
		return false
	end

	return ChallengeRogueTeamData:UIGetTreasureCampMaxCnt() ~= var_0_0.GetTreasureCmapMaxCnt()
end

function var_0_0.GetCurTreasureIDList()
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in pairs(ChallengeRogueTeamData:TreasureGetList()) do
		table.insert(var_39_0, iter_39_1.id)
	end

	return var_39_0
end

function var_0_0.GetTreasureCmapMaxCnt()
	local var_40_0 = {}
	local var_40_1 = 0

	for iter_40_0, iter_40_1 in ipairs((ChallengeRogueTeamData:UIGetTreasureIDList())) do
		for iter_40_2, iter_40_3 in ipairs(RogueTeamItemCfg[iter_40_1].camp) do
			var_40_0[iter_40_3] = var_40_0[iter_40_3] or 0
			var_40_0[iter_40_3] = var_40_0[iter_40_3] + 1
			var_40_1 = var_40_1 > var_40_0[iter_40_3] and var_40_1 or var_40_0[iter_40_3]
		end
	end

	return var_40_1
end

function var_0_0.GetTreasureSortedCmapAndCnt(arg_41_0)
	local var_41_0 = {}
	local var_41_1 = {}

	for iter_41_0, iter_41_1 in ipairs((ChallengeRogueTeamData:UIGetTreasureIDList())) do
		for iter_41_2, iter_41_3 in ipairs(RogueTeamItemCfg[iter_41_1].camp) do
			var_41_0[iter_41_3] = var_41_0[iter_41_3] or 0
			var_41_0[iter_41_3] = var_41_0[iter_41_3] + 1
		end
	end

	if #arg_41_0 > 1 then
		table.sort(arg_41_0, function(arg_42_0, arg_42_1)
			local var_42_0 = var_41_0[arg_42_0] or 0
			local var_42_1 = var_41_0[arg_42_1] or 0

			if var_42_0 ~= var_42_1 then
				return var_42_1 < var_42_0
			end

			return arg_42_0 < arg_42_1
		end)
	end

	for iter_41_4, iter_41_5 in ipairs(arg_41_0) do
		if var_41_0[iter_41_5] and var_41_0[iter_41_5] > 0 then
			table.insert(var_41_1, iter_41_5)
		end
	end

	return var_41_1, var_41_0
end

function var_0_0.HasSuitSkillPop()
	for iter_43_0, iter_43_1 in ipairs((ChallengeRogueTeamData:GetObtainDataList())) do
		for iter_43_2, iter_43_3 in ipairs(iter_43_1.itemList) do
			if RogueTeamItemCfg[iter_43_3.id].type == ChallengeRogueTeamConst.ITEM_TYPE.SUIT_SKILL then
				return true
			end
		end
	end

	return false
end

function var_0_0.NeedPlaySuitSkillEffectAnimation()
	local var_44_0 = ChallengeRogueTeamData:GetObtainDataList()

	if ChallengeRogueTeamData:UIGetIsPlaySuitSkillAnimationFlag() == true then
		return false
	end

	if var_44_0[1] then
		for iter_44_0, iter_44_1 in ipairs(var_44_0[1].itemList) do
			if RogueTeamItemCfg[iter_44_1.id].type == ChallengeRogueTeamConst.ITEM_TYPE.SUIT_SKILL then
				return true
			end
		end
	end

	return false
end

function var_0_0.HasMechanismPop()
	for iter_45_0, iter_45_1 in ipairs((ChallengeRogueTeamData:GetObtainDataList())) do
		for iter_45_2, iter_45_3 in ipairs(iter_45_1.itemList) do
			if RogueTeamItemCfg[iter_45_3.id].type == ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM then
				return true
			end
		end
	end

	return false
end

function var_0_0.NeedPlayMechanismEffectAnimation()
	local var_46_0 = ChallengeRogueTeamTools.GetWindowBarText(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.MECHANISM_VALUE)

	if ChallengeRogueTeamData:UIGetMechanismValue() < var_46_0 then
		if var_46_0 >= ChallengeRogueTeamTools.GetMaxMechanismValue() then
			return true
		else
			return not var_0_0.HasFirstMechanismPop()
		end
	end

	return false
end

function var_0_0.HasFirstMechanismPop()
	local var_47_0 = ChallengeRogueTeamData:GetObtainDataList()[1]

	if var_47_0 and RogueTeamItemCfg[var_47_0.itemList.id].type == ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM then
		return true
	end

	return false
end

function var_0_0.NeedPlayFullMechanismEffectAnimation()
	return ChallengeRogueTeamData:UIGetMechanismValue() < ChallengeRogueTeamTools.GetWindowBarText(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.MECHANISM_VALUE) and var_0_0.HasFirstMechanismPop()
end

function var_0_0.NeedPopWorldLineWindow()
	return not var_0_0.HasPlotRelicItem() and ChallengeRogueTeamData:PlotGetWorldLineID() ~= 0
end

function var_0_0.HasPlotRelicItem()
	for iter_50_0, iter_50_1 in ipairs((ChallengeRogueTeamData:GetObtainDataList())) do
		for iter_50_2, iter_50_3 in ipairs(iter_50_1.itemList) do
			if RogueTeamItemCfg[iter_50_3.id].type == ChallengeRogueTeamConst.ITEM_TYPE.RELIC and RogueTeamItemCfg[iter_50_3.id].sub_type == ChallengeRogueTeamConst.RELIC_TYPE.PLOT then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetCurRelicIDList()
	local var_51_0 = {}

	for iter_51_0, iter_51_1 in pairs(ChallengeRogueTeamData:EffectItemGetDataList(ChallengeRogueTeamConst.ITEM_TYPE.RELIC)) do
		table.insert(var_51_0, iter_51_1.id)
	end

	return var_51_0
end

function var_0_0.HasMapSwitchEffect()
	for iter_52_0, iter_52_1 in ipairs((ChallengeRogueTeamData:GetServerTriggerQueue())) do
		if iter_52_1.triggerType == ChallengeRogueTeamConst.SERVER_TRIGGER_TYPE.MAP_SWITCH then
			return true
		end
	end

	return false
end

function var_0_0.HasMapNodeEffect()
	for iter_53_0, iter_53_1 in ipairs((ChallengeRogueTeamData:GetServerTriggerQueue())) do
		if iter_53_1.triggerType == ChallengeRogueTeamConst.SERVER_TRIGGER_TYPE.MAP_NODE_EFFECT then
			return true
		end
	end

	return false
end

function var_0_0.GetWindowBarText(arg_54_0)
	if arg_54_0 == ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_CNT then
		return string.format("%s/%s", ChallengeRogueTeamData:UIGetAttributeValue(arg_54_0), ChallengeRogueTeamData:UIGetAttributeValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_LIMIT_CNT))
	end

	return ChallengeRogueTeamData:UIGetAttributeValue(arg_54_0)
end

function var_0_0.GetMaxMechanismValue(arg_55_0)
	return var_0_0.GetWindowBarText(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.MECHANISM_THRESHOLD_VALUE)
end

function var_0_0.GetAttributeIconPath(arg_56_0)
	if arg_56_0 == ChallengeRogueTeamConst.ATTRIBUTE_ENUM.GOLD then
		return GameSetting.rogue_team_gold_icon_path.value[1]
	elseif arg_56_0 == ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_CNT then
		return GameSetting.rogue_team_revive_icon_pah.value[1]
	end
end

function var_0_0.GetShopMaxItemCnt()
	return RogueTeamAttributeCfg[ChallengeRogueTeamConst.ATTRIBUTE_ENUM.SHOP_SELL_RELIC_MAX_CNT].max + RogueTeamAttributeCfg[ChallengeRogueTeamConst.ATTRIBUTE_ENUM.SHOP_SELL_TREASURE_MAX_CNT].max
end

function var_0_0.GetShopItemDefaultPrice(arg_58_0, arg_58_1)
	return math.ceil((RogueTeamItemCfg[arg_58_0].price[var_0_0.GetItemRare(arg_58_0, arg_58_1)] or RogueTeamItemCfg[arg_58_0].price[1]) * var_0_0.GetWindowBarText(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.SHOP_PRICE_RATE) / 1000)
end

function var_0_0.GetItemRare(arg_59_0, arg_59_1)
	if RogueTeamItemCfg[arg_59_0].type == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE then
		if RogueTeamItemCfg[arg_59_0].sub_type == 1 then
			if arg_59_1 > 3 then
				arg_59_1 = 3
			end

			return arg_59_1
		else
			return 1
		end
	elseif RogueTeamItemCfg[arg_59_0].type == ChallengeRogueTeamConst.ITEM_TYPE.RELIC then
		return 1
	elseif RogueTeamItemCfg[arg_59_0].type == ChallengeRogueTeamConst.ITEM_TYPE.SUIT_SKILL then
		return 1
	end

	return 1
end

function var_0_0.GetItemDesc(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = ""

	var_60_0 = RogueTeamItemCfg[arg_60_0].type == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE and getAffixDesc(var_0_0.GetTreasureAffix(arg_60_0, arg_60_1), arg_60_1) or RogueTeamItemCfg[arg_60_0].type == ChallengeRogueTeamConst.ITEM_TYPE.SUIT_SKILL and getAffixDesc(var_0_0.GetTreasureAffix(arg_60_0, arg_60_1), arg_60_1) or GetI18NText(RogueTeamItemCfg[arg_60_0].desc)
	arg_60_2 = arg_60_2 or Color.New(1, 1, 1)

	return (string.gsub(var_60_0, "#5C5D60", (string.format("#%s", ColorToHex(arg_60_2)))))
end

function var_0_0.GetShopItemList()
	return ChallengeRogueTeamData:GetShopData().paramList
end

function var_0_0.GetShopVoiceID(arg_62_0, arg_62_1, arg_62_2)
	if arg_62_0 == ChallengeRogueTeamConst.SHOP_TEXT_TYPE.WELCOM then
		for iter_62_0 = #RogueTeamShopVoiceCfg.get_id_list_by_type[arg_62_0], 1, -1 do
			if var_0_0.IsUnlockCondition(RogueTeamShopVoiceCfg[RogueTeamShopVoiceCfg.get_id_list_by_type[arg_62_0][iter_62_0]].condition) then
				return RogueTeamShopVoiceCfg.get_id_list_by_type[arg_62_0][iter_62_0]
			end
		end
	else
		local var_62_0 = {}

		for iter_62_1, iter_62_2 in ipairs(RogueTeamShopVoiceCfg.get_id_list_by_type_sub_type[arg_62_0][arg_62_1]) do
			if var_0_0.IsUnlockCondition(RogueTeamShopVoiceCfg[iter_62_2].condition) then
				table.insert(var_62_0, iter_62_2)
			end
		end

		local var_62_1 = math.random(1, #var_62_0)

		while #var_62_0 > 1 and var_62_0[var_62_1] == arg_62_2 do
			var_62_1 = math.random(1, #var_62_0)
		end

		return var_62_0[var_62_1]
	end
end

function var_0_0.GetTreasureAffix(arg_63_0, arg_63_1)
	local var_63_0 = clone(RogueTeamEffectCfg[RogueTeamItemCfg[arg_63_0].effect_id_list[1]].params)

	if arg_63_1 ~= nil then
		arg_63_1 = var_0_0.GetItemRare(arg_63_0, arg_63_1)
		var_63_0[2] = arg_63_1
	end

	return var_63_0
end

function var_0_0.GetRelicAffix(arg_64_0)
	local var_64_0 = {}

	if type(RogueTeamItemCfg[arg_64_0].effect_id_list) == "table" then
		for iter_64_0, iter_64_1 in ipairs(RogueTeamItemCfg[arg_64_0].effect_id_list) do
			local var_64_1 = var_0_0.GetEffectAffix(iter_64_1)

			if #var_64_1 > 0 then
				table.insert(var_64_0, var_64_1)
			end
		end
	end

	return var_64_0
end

function var_0_0.GetSkillTreeAffix(arg_65_0)
	local var_65_0 = {}

	if type(RogueTeamSkillTreeCfg[arg_65_0].effect) == "table" then
		for iter_65_0, iter_65_1 in ipairs(RogueTeamSkillTreeCfg[arg_65_0].effect) do
			local var_65_1 = var_0_0.GetEffectAffix(iter_65_1)

			if #var_65_1 > 0 then
				table.insert(var_65_0, var_65_1)
			end
		end
	end

	return var_65_0
end

function var_0_0.GetEffectAffix(arg_66_0)
	if RogueTeamEffectCfg[arg_66_0].action == ChallengeRogueTeamConst.EFFECT_ACTION.CUSTOM_AFFIX_EFFECT then
		if RogueTeamEffectCfg[arg_66_0].params[1] == 1 then
			local var_66_0 = math.floor(ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.GOLD) / RogueTeamEffectCfg[arg_66_0].params[2])

			var_66_0 = var_66_0 > RogueTeamEffectCfg[arg_66_0].params[4] and RogueTeamEffectCfg[arg_66_0].params[4] or var_66_0

			if var_66_0 < 1 then
				return {}
			end

			return {
				RogueTeamEffectCfg[arg_66_0].params[5],
				var_66_0,
				3
			}
		elseif RogueTeamEffectCfg[arg_66_0].params[1] == 2 then
			local var_66_1 = var_0_0.GetCollectSuitSkillCnt()

			var_66_1 = var_66_1 > RogueTeamEffectCfg[arg_66_0].params[3] and RogueTeamEffectCfg[arg_66_0].params[3] or var_66_1

			if var_66_1 < 1 then
				return {}
			end

			return {
				RogueTeamEffectCfg[arg_66_0].params[4],
				var_66_1,
				3
			}
		elseif RogueTeamEffectCfg[arg_66_0].params[1] == 3 then
			return {}
		end
	elseif RogueTeamEffectCfg[arg_66_0].action == ChallengeRogueTeamConst.EFFECT_ACTION.AFFIX then
		return RogueTeamEffectCfg[arg_66_0].params
	end

	return {}
end

function var_0_0.GetItemEffectDesc(arg_67_0)
	local var_67_0 = RogueTeamItemCfg[arg_67_0]
	local var_67_1 = var_0_0.GetIDHasEffectExtraText(arg_67_0)
	local var_67_2 = RogueTeamEffectCfg[var_67_1]

	if RogueTeamEffectCfg[var_67_1].current_desc == "" then
		return GetI18NText(var_67_0.desc)
	end

	if type(var_67_0.effect_id_list) == "table" then
		if var_67_2.action == ChallengeRogueTeamConst.EFFECT_ACTION.CUSTOM_AFFIX_EFFECT then
			if var_67_2.params[1] == 1 then
				local var_67_3 = math.floor(var_0_0.GetWindowBarText(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.GOLD) / var_67_2.params[2])

				var_67_3 = var_67_3 > var_67_2.params[4] and var_67_2.params[4] or var_67_3

				return var_67_0.desc .. string.format(GetI18NText(var_67_2.current_desc), var_67_3 * var_67_2.params[3])
			elseif var_67_2.params[1] == 2 then
				local var_67_4 = var_0_0.GetCollectSuitSkillCnt()

				var_67_4 = var_67_4 > var_67_2.params[3] and var_67_2.params[3] or var_67_4

				return var_67_0.desc .. string.format(GetI18NText(var_67_2.current_desc), var_67_4 * var_67_2.params[2])
			end
		else
			local var_67_5 = ChallengeRogueTeamData:GetEffectDataByEffectID(var_67_1)

			if var_67_5.effectId then
				return var_67_0.desc .. string.format(GetI18NText(var_67_2.current_desc), var_67_2.value_type == 1 and (var_67_2.gap ~= 0 and var_67_5.momentTime % var_67_2.gap or var_67_5.momentTime) or var_67_2.action == ChallengeRogueTeamConst.EFFECT_ACTION.ADD_MAX_HP and var_67_5.effectValue / 10 or var_67_5.effectValue)
			end
		end
	end

	return GetI18NText(var_67_0.desc)
end

function var_0_0.GetIDHasEffectExtraText(arg_68_0)
	for iter_68_0, iter_68_1 in ipairs(RogueTeamItemCfg[arg_68_0].effect_id_list) do
		if ChallengeRogueTeamData:GetEffectDataByEffectID(iter_68_1).effectId and RogueTeamEffectCfg[iter_68_1].current_desc ~= "" then
			return iter_68_1
		end
	end

	return RogueTeamItemCfg[arg_68_0].effect_id_list[1]
end

function var_0_0.HasTeamEffectMaxLevel()
	for iter_69_0, iter_69_1 in ipairs((ChallengeRogueTeamData:EffectItemGetDataList(ChallengeRogueTeamConst.ITEM_TYPE.RELIC))) do
		if type(RogueTeamItemCfg[iter_69_1.id].effect_id_list) == "table" then
			for iter_69_2, iter_69_3 in ipairs(RogueTeamItemCfg[iter_69_1.id].effect_id_list) do
				if RogueTeamEffectCfg[iter_69_3].action == ChallengeRogueTeamConst.EFFECT_ACTION.CUSTOM_AFFIX_EFFECT and RogueTeamEffectCfg[iter_69_3].params[1] == 3 then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.GetItemIcon(arg_70_0)
	return string.format("%s%s", var_0_0.GetImagePath(RogueTeamItemCfg[arg_70_0].type), RogueTeamItemCfg[arg_70_0].icon)
end

function var_0_0.GetImagePath(arg_71_0)
	if arg_71_0 == ChallengeRogueTeamConst.ITEM_TYPE.INIT_REWARD then
		return "TextureConfig/Activity_Roulike/Roulike_initial/"
	elseif arg_71_0 == ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM then
		return "TextureConfig/Activity_Roulike/Roulike_ThemeEffect/"
	elseif arg_71_0 == ChallengeRogueTeamConst.ITEM_TYPE.RELIC then
		return "TextureConfig/Activity_Roulike/Roulike_Relic/"
	elseif arg_71_0 == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE then
		return "TextureConfig/Activity_Roulike/Roulike_Treasure/"
	elseif arg_71_0 == ChallengeRogueTeamConst.ITEM_TYPE.SUIT_SKILL then
		return "TextureConfig/Activity_Roulike/Roulike_Ultimate/"
	end

	return "TextureConfig/Activity_Roulike/"
end

function var_0_0.GetCampIcon(arg_72_0)
	local var_72_0 = ChallengeRogueTeamData:GetCacheTemplateID()

	return var_0_0.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.CAMP_BIG_ICON_PATH_LIST, var_72_0)[table.keyof(RogueTeamItemCfg.get_id_list_by_item_temp_type[RogueTeamCfg[var_72_0].item_temp][ChallengeRogueTeamConst.ITEM_TYPE.SUIT_SKILL], (var_0_0.GetItemIDByCampID(arg_72_0)))]
end

function var_0_0.GetAllSuitSkillIDList()
	local var_73_0, var_73_1 = ChallengeRogueTeamData:GetAllCampTreasureIDListByTemp(RogueTeamCfg[ChallengeRogueTeamData:GetActiveTemplateID()].item_temp)
	local var_73_2 = {}

	table.insert(var_73_2, 0)

	for iter_73_0, iter_73_1 in ipairs(var_73_1) do
		table.insert(var_73_2, iter_73_1)
	end

	table.sort(var_73_2, function(arg_74_0, arg_74_1)
		return arg_74_0 < arg_74_1
	end)

	return var_73_0, var_73_2
end

function var_0_0.GetItemIDByCampID(arg_75_0)
	for iter_75_0, iter_75_1 in ipairs(RogueTeamItemCfg.get_id_list_by_type[ChallengeRogueTeamConst.ITEM_TYPE.SUIT_SKILL]) do
		if RogueTeamItemCfg[iter_75_1].camp[1] == arg_75_0 then
			return iter_75_1
		end
	end
end

function var_0_0.GetCollectSuitSkillCnt()
	local var_76_0 = {}

	for iter_76_0, iter_76_1 in pairs((ChallengeRogueTeamData:TreasureGetList())) do
		for iter_76_2, iter_76_3 in ipairs(RogueTeamItemCfg[iter_76_1.id].camp) do
			if table.keyof(var_76_0, iter_76_3) == nil then
				table.insert(var_76_0, iter_76_3)
			end
		end
	end

	return #var_76_0
end

function var_0_0.ItemHasPlotEffect(arg_77_0)
	if type(RogueTeamItemCfg[arg_77_0].effect_id_list) == "string" then
		return false
	end

	for iter_77_0, iter_77_1 in ipairs(RogueTeamItemCfg[arg_77_0].effect_id_list) do
		if RogueTeamEffectCfg[iter_77_1].action == ChallengeRogueTeamConst.EFFECT_ACTION.ENDING_PLOT then
			return true
		end
	end

	return false
end

function var_0_0.HasNeedShowRelicBuff(arg_78_0)
	for iter_78_0, iter_78_1 in ipairs(arg_78_0) do
		if type(RogueTeamItemCfg[iter_78_1.id].show_effect) == "table" then
			return true
		end
	end

	return false
end

function var_0_0.ShowBarList()
	manager.rogueTeamWindowBar:SwitchBar({
		ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_CNT,
		ChallengeRogueTeamConst.ATTRIBUTE_ENUM.GOLD
	})
	manager.rogueTeamMechanismBar:ShowBar()
	manager.rogueTeamMapPreviewBtnBar:ShowBar()
	manager.rogueTeamInGameInfoBox:ShowBox()
end

function var_0_0.HideBarList(arg_80_0)
	manager.rogueTeamWindowBar:HideBar()
	manager.rogueTeamMechanismBar:HideBar()
	manager.rogueTeamMapPreviewBtnBar:HideBar()
	manager.rogueTeamInGameInfoBox:HideBox()
end

function var_0_0.RegistWindowBarClick(arg_81_0)
	manager.windowBar:RegistBackCallBack(function()
		if arg_81_0 and not arg_81_0() then
			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("CHALLENGE_ROGUE_EXIT_GAME"),
			OkCallback = function()
				ChallengeRogueTeamAction.OnPlayingState(ChallengeRogueTeamConst.PLAYING_STATE.EXIT, function()
					ChallengeRogueTeamAction.GotoRogueTeamEntrace()
				end)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	manager.windowBar:RegistHomeCallBack(function()
		ChallengeRogueTeamAction.OnPlayingState(ChallengeRogueTeamConst.PLAYING_STATE.EXIT, function()
			gameContext:Go("/home", nil, nil, true)
		end)
	end)
end

function var_0_0.TextFormat(arg_88_0, arg_88_1, arg_88_2)
	return string.format("<color=%s><material=underline c=#%s h=2 event=%s args=%s>%s</material></color>", arg_88_2, arg_88_2, arg_88_0, arg_88_1, GetI18NText(RogueTeamItemCfg[arg_88_0].name))
end

function var_0_0.EventOptionReplaceText(arg_89_0, arg_89_1)
	if type(arg_89_1) ~= "table" then
		return arg_89_0
	end

	for iter_89_0, iter_89_1 in ipairs(arg_89_1) do
		arg_89_0 = string.gsub(arg_89_0, "&&&", ChallengeRogueTeamTools.GetWindowBarText(iter_89_1), 1)
	end

	return arg_89_0
end

function var_0_0.GetRogueTeamEventStageID(arg_90_0)
	local var_90_0

	for iter_90_0, iter_90_1 in ipairs((ChallengeRogueTeamData:EventGetCurrrentOptionList())) do
		if iter_90_1.id == arg_90_0 then
			var_90_0 = iter_90_1

			break
		end
	end

	return var_90_0.stageID
end

function var_0_0.IsUnlockAllCondition(arg_91_0)
	if type(arg_91_0) == "string" then
		return true
	end

	for iter_91_0, iter_91_1 in ipairs(arg_91_0) do
		if not var_0_0.IsUnlockCondition(iter_91_1) then
			return false
		end
	end

	return true
end

function var_0_0.IsUnlockCondition(arg_92_0)
	if arg_92_0 == 0 then
		return true
	end

	if RogueTeamConditionCfg[arg_92_0].type == ChallengeRogueTeamConst.UNLOCK_TYPE.OBTAIN_ITEM then
		for iter_92_0, iter_92_1 in ipairs(RogueTeamConditionCfg[arg_92_0].params) do
			if not var_0_0.HasObtainItem(iter_92_1) then
				return false
			end
		end

		return true
	end

	return false
end

function var_0_0.GetLockText(arg_93_0)
	if type(arg_93_0) == "string" then
		return ""
	end

	for iter_93_0, iter_93_1 in ipairs(arg_93_0) do
		if not var_0_0.IsUnlockCondition(iter_93_1) then
			return RogueTeamConditionCfg[iter_93_1].desc
		end
	end
end

function var_0_0.IsHeroInTeam(arg_94_0, arg_94_1)
	if arg_94_1 ~= 0 then
		if ChallengeRogueTeamData:GetUnlockTrailHeroList()[arg_94_1] then
			return true
		end
	elseif ChallengeRogueTeamData:GetHeroList()[arg_94_0] then
		return true
	end

	return false
end

function var_0_0.IsAddHeroHP(arg_95_0, arg_95_1, arg_95_2)
	if arg_95_1 ~= 0 then
		local var_95_0 = ChallengeRogueTeamData:GetUnlockTrailHeroList()

		if var_95_0[arg_95_1] and arg_95_2 > var_95_0[arg_95_1].hpPercent then
			return true
		end
	else
		local var_95_1 = ChallengeRogueTeamData:GetHeroList()

		if var_95_1[arg_95_0] and arg_95_2 > var_95_1[arg_95_0].hpPercent then
			return true
		end
	end

	return false
end

function var_0_0.GetHeroHp(arg_96_0, arg_96_1)
	if arg_96_1 ~= 0 then
		local var_96_0 = ChallengeRogueTeamData:GetUnlockTrailHeroList()

		if var_96_0[arg_96_1] then
			return var_96_0[arg_96_1].hpPercent
		end
	else
		local var_96_1 = ChallengeRogueTeamData:GetHeroList()

		if var_96_1[heroID] then
			return var_96_1[heroID].hpPercent
		end
	end

	return 0
end

function var_0_0:FilterTreasure()
	local var_97_0 = {}

	for iter_97_0, iter_97_1 in ipairs(ChallengeRogueTeamData:TreasureGetList()) do
		if self[1] <= iter_97_1.rare and iter_97_1.rare <= self[2] then
			table.insert(var_97_0, iter_97_1)
		end
	end

	return var_97_0
end

function var_0_0.TreasureSort(arg_98_0)
	table.sort(arg_98_0, function(arg_99_0, arg_99_1)
		return RogueTeamItemCfg[arg_99_0.id].sub_type == RogueTeamItemCfg[arg_99_1.id].sub_type and (arg_99_0.rare == arg_99_1.rare and arg_99_0.id < arg_99_1.id or arg_99_0.rare > arg_99_1.rare) or RogueTeamItemCfg[arg_99_0.id].sub_type > RogueTeamItemCfg[arg_99_1.id].sub_type
	end)

	return arg_98_0
end

function var_0_0.TreasureGroup(arg_100_0)
	arg_100_0 = var_0_0.TreasureSort(arg_100_0)

	local var_100_0 = {}

	for iter_100_0, iter_100_1 in pairs(arg_100_0) do
		for iter_100_2, iter_100_3 in ipairs(RogueTeamItemCfg[iter_100_1.id].camp) do
			var_100_0[iter_100_3] = var_100_0[iter_100_3] or {}

			table.insert(var_100_0[iter_100_3], iter_100_1)
		end
	end

	var_100_0[0] = arg_100_0

	return var_100_0
end

function var_0_0:FilterRelic()
	local var_101_0 = {}

	for iter_101_0, iter_101_1 in ipairs((ChallengeRogueTeamData:EffectItemGetDataList(ChallengeRogueTeamConst.ITEM_TYPE.RELIC))) do
		if table.keyof(self[1], RogueTeamItemCfg[iter_101_1.id].sub_type) then
			table.insert(var_101_0, iter_101_1)
		end
	end

	return var_101_0
end

function var_0_0.GetRougeTeamSettingValue(arg_102_0, arg_102_1, arg_102_2)
	arg_102_2 = arg_102_2 or 1
	arg_102_1 = arg_102_1 or ChallengeRogueTeamData:GetActiveTemplateID()

	return RogueTeamSetting[RogueTeamSetting.get_id_list_by_temp_id_setting_id[RogueTeamCfg[arg_102_1].setting_temp][arg_102_0][1]].value[arg_102_2]
end

function var_0_0.GetRougeTeamSettingList(arg_103_0, arg_103_1)
	index = index or 1
	arg_103_1 = arg_103_1 or ChallengeRogueTeamData:GetActiveTemplateID()

	return RogueTeamSetting[RogueTeamSetting.get_id_list_by_temp_id_setting_id[RogueTeamCfg[arg_103_1].setting_temp][arg_103_0][1]].value
end

function var_0_0.GetBattleEffectTreeID()
	for iter_104_0, iter_104_1 in ipairs(RogueTeamSkillTreeCfg.get_id_list_by_template_id[RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].tree_temp]) do
		if table.keyof(RogueTeamSkillTreeCfg[iter_104_1].effect, ChallengeRogueTeamConst.TECHNOLOGY_TREE_EFFECT_ID.BATTLE_EFFECT) then
			return iter_104_1
		end
	end
end

function var_0_0.GetShopDiscountMechanismID()
	for iter_105_0, iter_105_1 in ipairs(RogueTeamItemCfg.get_id_list_by_item_temp_type[RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].item_temp][ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM]) do
		for iter_105_2, iter_105_3 in ipairs(RogueTeamItemCfg[iter_105_1].effect_id_list) do
			if RogueTeamEffectCfg[iter_105_3].action == ChallengeRogueTeamConst.EFFECT_ACTION.ATTRIBUTE_VALUE then
				if RogueTeamEffectCfg[iter_105_3].params[1] == 1 and RogueTeamEffectCfg[iter_105_3].params[2] == ChallengeRogueTeamConst.ATTRIBUTE_ENUM.SHOP_DISCOUNT then
					return iter_105_1
				end
			end
		end
	end
end

function var_0_0.GetEventMoreMechanismID()
	for iter_106_0, iter_106_1 in ipairs(RogueTeamItemCfg.get_id_list_by_item_temp_type[RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].item_temp][ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM]) do
		for iter_106_2, iter_106_3 in ipairs(RogueTeamItemCfg[iter_106_1].effect_id_list) do
			if RogueTeamEffectCfg[iter_106_3].action == ChallengeRogueTeamConst.EFFECT_ACTION.ATTRIBUTE_VALUE then
				if RogueTeamEffectCfg[iter_106_3].params[1] == 1 and RogueTeamEffectCfg[iter_106_3].params[2] == ChallengeRogueTeamConst.ATTRIBUTE_ENUM.EVENT_ONECE_MORE then
					return iter_106_1
				end
			end
		end
	end
end

function var_0_0.GetCanRewardTask(arg_107_0)
	local var_107_0 = {}
	local var_107_1 = 0

	for iter_107_0, iter_107_1 in pairs(arg_107_0) do
		if iter_107_1 then
			local var_107_2 = TaskData2:GetTaskComplete(iter_107_1)
			local var_107_3 = TaskData2:GetTaskProgress(iter_107_1) >= AssignmentCfg[iter_107_1].need

			if var_107_3 and not var_107_2 then
				table.insert(var_107_0, iter_107_1)
			end

			if var_107_3 or var_107_2 then
				var_107_1 = math.max(var_107_1, TaskData2:GetTaskProgress(iter_107_1))
			end
		end
	end

	return var_107_0, var_107_1
end

function var_0_0.PlayAudio(arg_108_0)
	local var_108_0 = AudioCfg[RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()][arg_108_0]]

	if var_108_0.cue_sheet ~= "" then
		manager.audio:PlayEffect(var_108_0.cue_sheet, var_108_0.cue_name, var_108_0.awb)
	end
end

function var_0_0.IsDemonBattle(arg_109_0)
	local var_109_0, var_109_1 = ChallengeRogueTeamData:UIGetSelectEventOption()
	local var_109_2 = ChallengeRogueTeamData:GetOptionData(var_109_1)
	local var_109_3 = RogueTeamRoomCfg[var_109_2 and var_109_2.jumpRoomID]

	if not RogueTeamRoomCfg[var_109_2 and var_109_2.jumpRoomID] then
		return false
	else
		return var_109_3.room_type == ChallengeRogueTeamConst.NODE_TYPE.BATTLE_DEMON
	end
end

function var_0_0.GetDemonStageByHeroId(arg_110_0)
	if arg_110_0 then
		local var_110_0, var_110_1 = ChallengeRogueTeamData:UIGetSelectEventOption()
		local var_110_2 = RogueTeamRoomCfg[ChallengeRogueTeamData:GetOptionData(var_110_1).jumpRoomID]

		if var_110_2.room_type == ChallengeRogueTeamConst.NODE_TYPE.BATTLE_DEMON then
			for iter_110_0, iter_110_1 in ipairs(var_110_2.params) do
				if arg_110_0 == iter_110_1[1] then
					return iter_110_1[2]
				end
			end
		end
	end

	return GameSetting.rogue_team_demon_select_stage.value[1]
end

function var_0_0.GetCurrentSurveyLevel(arg_111_0)
	local var_111_0 = ItemTools.getItemNum(RogueTeamCfg[arg_111_0].point_item)
	local var_111_1 = var_0_0.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.PASS_POINT_PER_VALUE, arg_111_0)
	local var_111_2 = ChallengeRogueTeamData:GetScoreIDListByActivityID(ChallengeRogueTeamData:GetScoreActivityIDByTemple(arg_111_0))
	local var_111_3 = math.floor(ActivityPointRewardCfg[var_111_2[#var_111_2]].need / var_111_1)

	return math.min(math.floor(var_111_0 / var_111_1), var_111_3), var_111_0, var_111_1, var_111_2, var_111_3
end

function var_0_0.GetIsNewScoreReward(arg_112_0)
	local var_112_0 = ChallengeRogueTeamData:GetScoreIDListByActivityID((ChallengeRogueTeamData:GetScoreActivityIDByTemple(arg_112_0)))
	local var_112_1 = var_112_0[#var_112_0]
	local var_112_2 = ChallengeRogueTeamData:GetLastScoreId()

	return var_112_2 == 0 or var_112_1 ~= var_112_2, var_112_0[#var_112_0]
end

return var_0_0
