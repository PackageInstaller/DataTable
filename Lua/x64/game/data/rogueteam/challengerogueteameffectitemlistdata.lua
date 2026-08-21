local var_0_0 = import(".subClass.ChallengeRogueTeamEffectItemData")
local var_0_1 = class("ChallengeRogueTeamEffectItemListData")

function var_0_1.ExportMethod(arg_1_0)
	return {
		"EffectItemInitData",
		"EffectInitData",
		"EffectItemListUpdate",
		"EffectGetDataList",
		"EffectItemGetDataList",
		"GetBuffItemDataList",
		"UpdateEffectList",
		"GetEffectDataByEffectID",
		"EffectItemClearData"
	}
end

function var_0_1.Init(arg_2_0)
	arg_2_0:EffectItemClearData()
end

function var_0_1.EffectItemClearData(arg_3_0)
	arg_3_0.effectItemTypeList_ = {}
	arg_3_0.effectList_ = {}
end

function var_0_1.EffectItemInitData(arg_4_0, arg_4_1)
	arg_4_0:ClearEffectItem()

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		arg_4_0:EffectItemListUpdate(ChallengeRogueTeamConst.ITEM_OPERATE.ADD, iter_4_1)
	end
end

function var_0_1.EffectInitData(arg_5_0, arg_5_1)
	arg_5_0:ClearEffect()

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		arg_5_0:EffectUpdate(ChallengeRogueTeamConst.ITEM_OPERATE.ADD, iter_5_1)
	end
end

function var_0_1.EffectItemGetDataList(arg_6_0, arg_6_1)
	return arg_6_0.effectItemTypeList_[arg_6_1] and arg_6_0.effectItemTypeList_[arg_6_1]:GetItemList() or {}
end

function var_0_1.EffectGetDataList(arg_7_0)
	return arg_7_0.effectList_
end

function var_0_1.EffectItemListUpdate(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = RogueTeamItemCfg[arg_8_2].type

	if arg_8_0.effectItemTypeList_[var_8_0] == nil then
		arg_8_0.effectItemTypeList_[var_8_0] = var_0_0.New()
	end

	arg_8_0.effectItemTypeList_[var_8_0]:UpdateItemList(arg_8_1, arg_8_2)
end

function var_0_1.UpdateEffectList(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1.effect_list) do
		if iter_9_1.left_time == 0 then
			arg_9_0:EffectUpdate(ChallengeRogueTeamConst.ITEM_OPERATE.DELETE, iter_9_1)
		else
			arg_9_0:EffectUpdate(ChallengeRogueTeamConst.ITEM_OPERATE.ADD, iter_9_1)
		end
	end
end

function var_0_1.EffectUpdate(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {
		itemID = arg_10_2.source_id,
		effectId = arg_10_2.effect_id,
		leftTime = arg_10_2.left_time,
		triggerCd = arg_10_2.trigger_cd,
		effectValue = arg_10_2.calc_value,
		momentTime = arg_10_2.moment_time,
		type = arg_10_2.source_type
	}
	local var_10_1

	if arg_10_2.source_type == ChallengeRogueTeamConst.EFFECT_SOURCE_ITEM_TYPE.ITEM then
		var_10_1 = RogueTeamItemCfg[var_10_0.itemID].type
	elseif ChallengeRogueTeamConst.EFFECT_SOURCE_ITEM_TYPE.SKILL then
		var_10_1 = ChallengeRogueTeamConst.ITEM_TYPE.SKILL

		if arg_10_0.effectItemTypeList_[var_10_1] == nil then
			arg_10_0.effectItemTypeList_[var_10_1] = var_0_0.New()
		end

		arg_10_0.effectItemTypeList_[var_10_1]:UpdateItemList(arg_10_1, arg_10_2.source_id)
	end

	if arg_10_1 == ChallengeRogueTeamConst.ITEM_OPERATE.ADD then
		for iter_10_0, iter_10_1 in pairs(arg_10_0.effectList_) do
			if iter_10_1.effectId == var_10_0.effectId then
				iter_10_1 = var_10_0

				arg_10_0.effectItemTypeList_[var_10_1]:UpdateEffect(var_10_0.itemID, var_10_0.effectId)
				arg_10_0:UpdateEffect(var_10_0)

				return
			end
		end

		table.insert(arg_10_0.effectList_, var_10_0)
		arg_10_0.effectItemTypeList_[var_10_1]:UpdateEffect(var_10_0.itemID, var_10_0.effectId)
	elseif arg_10_1 == ChallengeRogueTeamConst.ITEM_OPERATE.DELETE then
		for iter_10_2 = #arg_10_0.effectList_, 1, -1 do
			if arg_10_0.effectList_[iter_10_2].effectId == var_10_0.effectId then
				table.remove(arg_10_0.effectList_, iter_10_2)
				arg_10_0.effectItemTypeList_[var_10_1]:RemoveEffect(var_10_0.itemID, var_10_0.effectId)

				break
			end
		end
	end
end

function var_0_1.ClearEffectItem(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.effectItemTypeList_) do
		iter_11_1:ClearEffectItem()
	end
end

function var_0_1.UpdateEffect(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.effectList_) do
		if iter_12_1.effectId == arg_12_1.effectId then
			arg_12_0.effectList_[iter_12_0] = arg_12_1

			return
		end
	end
end

function var_0_1.ClearEffect(arg_13_0)
	arg_13_0.effectList_ = {}
end

function var_0_1.GetEffectDataByEffectID(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.effectList_) do
		if iter_14_1.effectId == arg_14_1 then
			return iter_14_1
		end
	end

	return {}
end

function var_0_1.GetBuffItemDataList(arg_15_0)
	local var_15_0 = {}

	if arg_15_0.effectItemTypeList_[ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM] then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0.effectItemTypeList_[ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM]:GetItemList()) do
			local var_15_1 = RogueTeamItemCfg[iter_15_1.id]

			if type(var_15_1.effect_id_list) == "table" and type(var_15_1.show_effect) == "table" then
				for iter_15_2, iter_15_3 in ipairs(var_15_1.effect_id_list) do
					local var_15_2 = ChallengeRogueTeamData:GetEffectDataByEffectID(iter_15_3)
					local var_15_3 = RogueTeamEffectCfg[iter_15_3]

					if var_15_2 and not table.isEmpty(var_15_2) then
						table.insert(var_15_0, iter_15_1)

						break
					end
				end
			end
		end
	end

	if arg_15_0.effectItemTypeList_[ChallengeRogueTeamConst.ITEM_TYPE.RELIC] then
		for iter_15_4, iter_15_5 in ipairs(arg_15_0.effectItemTypeList_[ChallengeRogueTeamConst.ITEM_TYPE.RELIC]:GetItemList()) do
			local var_15_4 = RogueTeamItemCfg[iter_15_5.id]

			if type(var_15_4.effect_id_list) == "table" and type(var_15_4.show_effect) == "table" then
				for iter_15_6, iter_15_7 in ipairs(var_15_4.effect_id_list) do
					local var_15_5 = ChallengeRogueTeamData:GetEffectDataByEffectID(iter_15_7)
					local var_15_6 = RogueTeamEffectCfg[iter_15_7]

					if var_15_5 and not table.isEmpty(var_15_5) then
						table.insert(var_15_0, iter_15_5)

						break
					end
				end
			end
		end
	end

	return var_15_0
end

return var_0_1
