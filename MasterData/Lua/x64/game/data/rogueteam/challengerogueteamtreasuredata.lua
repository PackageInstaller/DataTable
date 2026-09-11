local ChallengeRogueTreasureData = class("ChallengeRogueTreasureData")

function ChallengeRogueTreasureData:ExportMethod()
	return {
		"TreasureInitData",
		"TreasureGetList",
		"TreasureListUpdate",
		"TreasureClear",
		"TreasureGetListByCampList",
		"GetTreasureIDListByTempAndCampList",
		"GetAllCampTreasureIDListByTemp",
		"GetCampUltimateByCamp",
		"GetAllCampTreasureIDByCamp"
	}
end

function ChallengeRogueTreasureData:Init()
	self.treasureList_ = {}
	self.allTreasureIDList_ = {}
	self.allCampIDList_ = {}
end

function ChallengeRogueTreasureData:TreasureInitData(arg_3_1)
	self:TreasureClear()

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		self:TreasureListUpdate(ChallengeRogueTeamConst.ITEM_OPERATE.ADD, iter_3_1)
	end
end

function ChallengeRogueTreasureData:TreasureUpdate(arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(self.treasureList_) do
		if iter_4_1.id == arg_4_1 then
			self.treasureList_[iter_4_0].rare = arg_4_2

			return
		end
	end

	table.insert(self.treasureList_, {
		id = arg_4_1,
		rare = arg_4_2
	})
end

function ChallengeRogueTreasureData:TreasureRemove(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(self.treasureList_) do
		if iter_5_1.id == arg_5_1 then
			table.remove(self.treasureList_, iter_5_0)

			break
		end
	end
end

function ChallengeRogueTreasureData:TreasureListUpdate(arg_6_1, arg_6_2)
	if arg_6_1 == ChallengeRogueTeamConst.ITEM_OPERATE.ADD then
		self:TreasureUpdate(arg_6_2.id, arg_6_2.rare)
	elseif arg_6_1 == ChallengeRogueTeamConst.ITEM_OPERATE.DELETE then
		self:TreasureRemove(arg_6_2.id)
	end
end

function ChallengeRogueTreasureData:TreasureClear()
	for iter_7_0 = #self.treasureList_, 1, -1 do
		self.treasureList_[iter_7_0] = nil
	end
end

function ChallengeRogueTreasureData:TreasureGetList()
	return self.treasureList_
end

function ChallengeRogueTreasureData:TreasureGetListByCampList(arg_9_1)
	if arg_9_1[1] == 0 then
		return self:TreasureGetList()
	end

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(self.treasureList_) do
		if #arg_9_1 == 1 then
			if table.indexof(RogueTeamItemCfg[iter_9_1.id].camp, arg_9_1[1]) then
				table.insert(var_9_0, iter_9_1)
			end
		elseif #arg_9_1 > 1 then
			local var_9_1 = true

			for iter_9_2, iter_9_3 in ipairs(arg_9_1) do
				if not table.indexof(RogueTeamItemCfg[iter_9_1.id].camp, iter_9_3) then
					var_9_1 = false
				end
			end

			if var_9_1 then
				table.insert(var_9_0, iter_9_1)
			end
		end
	end

	return var_9_0
end

function ChallengeRogueTreasureData:GetTreasureIDListByTempAndCampList(arg_10_1, arg_10_2)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(RogueTeamItemCfg.get_id_list_by_type[ChallengeRogueTeamConst.ITEM_TYPE.TREASURE]) do
		if RogueTeamItemCfg[iter_10_1].item_temp == arg_10_1 and RogueTeamItemCfg[iter_10_1].camp and not table.isEmpty(RogueTeamItemCfg[iter_10_1].camp) then
			for iter_10_2, iter_10_3 in ipairs(arg_10_2) do
				if not table.indexof(var_10_0, iter_10_1) then
					table.insert(var_10_0, iter_10_1)
				end
			end
		end
	end

	return var_10_0
end

function ChallengeRogueTreasureData:GetAllCampTreasureIDListByTemp(arg_11_1)
	self.allTreasureIDList_ = self.allTreasureIDList_ or {}
	self.allCampIDList_ = self.allCampIDList_ or {}

	if self.allTreasureIDList_[arg_11_1] and self.allCampIDList_[arg_11_1] then
		return deepClone(self.allTreasureIDList_[arg_11_1]), deepClone(self.allCampIDList_[arg_11_1])
	end

	local var_11_0 = {}
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in ipairs(RogueTeamItemCfg.get_id_list_by_type[ChallengeRogueTeamConst.ITEM_TYPE.TREASURE]) do
		if RogueTeamItemCfg[iter_11_1].item_temp == arg_11_1 then
			table.insert(var_11_0, iter_11_1)

			if RogueTeamItemCfg[iter_11_1].camp and not table.isEmpty(RogueTeamItemCfg[iter_11_1].camp) then
				for iter_11_2, iter_11_3 in ipairs(RogueTeamItemCfg[iter_11_1].camp) do
					if not table.indexof(var_11_1, iter_11_3) then
						table.insert(var_11_1, iter_11_3)
					end
				end
			end
		end
	end

	table.sort(var_11_1, function(arg_12_0, arg_12_1)
		return arg_12_0 < arg_12_1
	end)

	self.allCampIDList_[arg_11_1] = var_11_1
	self.allTreasureIDList_[arg_11_1] = var_11_0

	return var_11_0, var_11_1
end

function ChallengeRogueTreasureData:GetCampUltimateByCamp(arg_13_1, arg_13_2)
	for iter_13_0, iter_13_1 in ipairs(RogueTeamItemCfg.get_id_list_by_item_temp[arg_13_1] or {}) do
		if RogueTeamItemCfg[iter_13_1].type == ChallengeRogueTeamConst.ITEM_TYPE.SUIT_SKILL and RogueTeamItemCfg[iter_13_1].camp and RogueTeamItemCfg[iter_13_1].camp[1] == arg_13_2 then
			return iter_13_1
		end
	end
end

function ChallengeRogueTreasureData:GetAllCampTreasureIDByCamp(arg_14_1, arg_14_2)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs((self:GetAllCampTreasureIDListByTemp(arg_14_1))) do
		if RogueTeamItemCfg[iter_14_1].camp and not table.isEmpty(RogueTeamItemCfg[iter_14_1].camp) then
			for iter_14_2, iter_14_3 in ipairs(RogueTeamItemCfg[iter_14_1].camp) do
				if iter_14_3 == arg_14_2 and RogueTeamItemCfg[iter_14_1].type == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE and not table.indexof(var_14_0, iter_14_1) then
					table.insert(var_14_0, iter_14_1)
				end
			end
		end
	end

	return var_14_0
end

return ChallengeRogueTreasureData
