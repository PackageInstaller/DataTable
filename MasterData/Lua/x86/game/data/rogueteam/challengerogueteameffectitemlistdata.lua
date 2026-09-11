local ChallengeRogueTeamEffectItemData = import(".subClass.ChallengeRogueTeamEffectItemData")
local ChallengeRogueTeamEffectItemListData = class("ChallengeRogueTeamEffectItemListData")

function ChallengeRogueTeamEffectItemListData:ExportMethod()
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

function ChallengeRogueTeamEffectItemListData:Init()
	self:EffectItemClearData()
end

function ChallengeRogueTeamEffectItemListData:EffectItemClearData()
	self.effectItemTypeList_ = {}
	self.effectList_ = {}
end

function ChallengeRogueTeamEffectItemListData:EffectItemInitData(arg_4_1)
	self:ClearEffectItem()

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		self:EffectItemListUpdate(ChallengeRogueTeamConst.ITEM_OPERATE.ADD, iter_4_1)
	end
end

function ChallengeRogueTeamEffectItemListData:EffectInitData(arg_5_1)
	self:ClearEffect()

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		self:EffectUpdate(ChallengeRogueTeamConst.ITEM_OPERATE.ADD, iter_5_1)
	end
end

function ChallengeRogueTeamEffectItemListData:EffectItemGetDataList(arg_6_1)
	return self.effectItemTypeList_[arg_6_1] and self.effectItemTypeList_[arg_6_1]:GetItemList() or {}
end

function ChallengeRogueTeamEffectItemListData:EffectGetDataList()
	return self.effectList_
end

function ChallengeRogueTeamEffectItemListData:EffectItemListUpdate(arg_8_1, arg_8_2)
	if self.effectItemTypeList_[RogueTeamItemCfg[arg_8_2].type] == nil then
		self.effectItemTypeList_[RogueTeamItemCfg[arg_8_2].type] = ChallengeRogueTeamEffectItemData.New()
	end

	self.effectItemTypeList_[RogueTeamItemCfg[arg_8_2].type]:UpdateItemList(arg_8_1, arg_8_2)
end

function ChallengeRogueTeamEffectItemListData:UpdateEffectList(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1.effect_list) do
		if iter_9_1.left_time == 0 then
			self:EffectUpdate(ChallengeRogueTeamConst.ITEM_OPERATE.DELETE, iter_9_1)
		else
			self:EffectUpdate(ChallengeRogueTeamConst.ITEM_OPERATE.ADD, iter_9_1)
		end
	end
end

function ChallengeRogueTeamEffectItemListData:EffectUpdate(arg_10_1, arg_10_2)
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

		if self.effectItemTypeList_[ChallengeRogueTeamConst.ITEM_TYPE.SKILL] == nil then
			self.effectItemTypeList_[var_10_1] = ChallengeRogueTeamEffectItemData.New()
		end

		self.effectItemTypeList_[var_10_1]:UpdateItemList(arg_10_1, arg_10_2.source_id)
	end

	if arg_10_1 == ChallengeRogueTeamConst.ITEM_OPERATE.ADD then
		for iter_10_0, iter_10_1 in pairs(self.effectList_) do
			if iter_10_1.effectId == var_10_0.effectId then
				iter_10_1 = var_10_0

				self.effectItemTypeList_[var_10_1]:UpdateEffect(var_10_0.itemID, var_10_0.effectId)
				self:UpdateEffect(var_10_0)

				return
			end
		end

		table.insert(self.effectList_, var_10_0)
		self.effectItemTypeList_[var_10_1]:UpdateEffect(var_10_0.itemID, var_10_0.effectId)
	elseif arg_10_1 == ChallengeRogueTeamConst.ITEM_OPERATE.DELETE then
		for iter_10_2 = #self.effectList_, 1, -1 do
			if self.effectList_[iter_10_2].effectId == var_10_0.effectId then
				table.remove(self.effectList_, iter_10_2)
				self.effectItemTypeList_[var_10_1]:RemoveEffect(var_10_0.itemID, var_10_0.effectId)

				break
			end
		end
	end
end

function ChallengeRogueTeamEffectItemListData:ClearEffectItem()
	for iter_11_0, iter_11_1 in pairs(self.effectItemTypeList_) do
		iter_11_1:ClearEffectItem()
	end
end

function ChallengeRogueTeamEffectItemListData:UpdateEffect(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(self.effectList_) do
		if iter_12_1.effectId == arg_12_1.effectId then
			self.effectList_[iter_12_0] = arg_12_1

			return
		end
	end
end

function ChallengeRogueTeamEffectItemListData:ClearEffect()
	self.effectList_ = {}
end

function ChallengeRogueTeamEffectItemListData:GetEffectDataByEffectID(arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(self.effectList_) do
		if iter_14_1.effectId == arg_14_1 then
			return iter_14_1
		end
	end

	return {}
end

function ChallengeRogueTeamEffectItemListData:GetBuffItemDataList()
	local var_15_0 = {}

	if self.effectItemTypeList_[ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM] then
		for iter_15_0, iter_15_1 in ipairs(self.effectItemTypeList_[ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM]:GetItemList()) do
			if type(RogueTeamItemCfg[iter_15_1.id].effect_id_list) == "table" and type(RogueTeamItemCfg[iter_15_1.id].show_effect) == "table" then
				for iter_15_2, iter_15_3 in ipairs(RogueTeamItemCfg[iter_15_1.id].effect_id_list) do
					local var_15_1 = ChallengeRogueTeamData:GetEffectDataByEffectID(iter_15_3)

					if var_15_1 and not table.isEmpty(var_15_1) then
						table.insert(var_15_0, iter_15_1)

						break
					end
				end
			end
		end
	end

	if self.effectItemTypeList_[ChallengeRogueTeamConst.ITEM_TYPE.RELIC] then
		for iter_15_4, iter_15_5 in ipairs(self.effectItemTypeList_[ChallengeRogueTeamConst.ITEM_TYPE.RELIC]:GetItemList()) do
			if type(RogueTeamItemCfg[iter_15_5.id].effect_id_list) == "table" and type(RogueTeamItemCfg[iter_15_5.id].show_effect) == "table" then
				for iter_15_6, iter_15_7 in ipairs(RogueTeamItemCfg[iter_15_5.id].effect_id_list) do
					local var_15_3 = ChallengeRogueTeamData:GetEffectDataByEffectID(iter_15_7)

					if var_15_3 and not table.isEmpty(var_15_3) then
						table.insert(var_15_0, iter_15_5)

						break
					end
				end
			end
		end
	end

	return var_15_0
end

return ChallengeRogueTeamEffectItemListData
