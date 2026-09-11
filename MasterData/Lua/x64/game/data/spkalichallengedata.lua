require("game.data.SPHeroChallengeDataTemplate")

local var_0_0 = singletonClass("SPKaliChallengeData")

function var_0_0.Init(arg_1_0)
	arg_1_0.activityID = 0
	arg_1_0.dataDic = {}
	arg_1_0.isInitRed = false
	arg_1_0.isInitRed = false
end

function var_0_0:InitData(arg_2_1)
	self.dataDic[arg_2_1.activity_id] = self.dataDic[arg_2_1.activity_id] or {}

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.mission_list) do
		var_2_0[iter_2_1.id] = iter_2_1
	end

	self.dataDic[arg_2_1.activity_id] = {
		showAffix = arg_2_1.today_affix_list,
		collection = arg_2_1.collection,
		mission_list = arg_2_1.mission_list,
		lucky = arg_2_1.lucky,
		pointData = var_2_0,
		free = arg_2_1.free
	}
	self.activityID = arg_2_1.activity_id

	self:UpdateRedPoint(arg_2_1.activity_id)
end

function var_0_0:UpdateKaliAffix(arg_3_1)
	if self.dataDic[arg_3_1.activity_id] then
		self.dataDic[arg_3_1.activity_id].showAffix = {}
		self.dataDic[arg_3_1.activity_id].showAffix = arg_3_1.affix_list
		self.dataDic[arg_3_1.activity_id].lucky = arg_3_1.lucky
		self.dataDic[arg_3_1.activity_id].free = arg_3_1.free

		local var_3_0 = SPKaliChallengeData:GetNowAffixEffect(arg_3_1.activity_id)

		if var_3_0 and not table.indexof(self.dataDic[arg_3_1.activity_id].collection, var_3_0) then
			saveData("SPKALI", "COLLECT_AFFIX", 1)
			manager.redPoint:setTip(RedPointConst.ACTIVITY_KALI_AFFIX, 1)
			table.insert(self.dataDic[arg_3_1.activity_id].collection, var_3_0)
		end
	end
end

function var_0_0.GetShowPointList(arg_4_0, arg_4_1)
	return BattleCoreKaliCfg.all or {}
end

function var_0_0:UpdateStageData(arg_5_1, arg_5_2)
	if self.dataDic[ActivityCfg.get_id_list_by_sub_activity_list[arg_5_1.activityID_][1]] then
		self.dataDic[ActivityCfg.get_id_list_by_sub_activity_list[arg_5_1.activityID_][1]].pointData[arg_5_1.id] = {
			times = 1,
			id = arg_5_1.id
		}
	end

	self:UpdateRedPoint(ActivityCfg.get_id_list_by_sub_activity_list[arg_5_1.activityID_][1])
end

function var_0_0:GetShowTreasureList(arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(ActivitykaliaffixCfg.all or {}) do
		table.insert(var_6_0, {
			id = iter_6_1,
			isLock = not table.indexof((self.dataDic[arg_6_1] or nil) and (self.dataDic[arg_6_1].collection or {}), iter_6_1)
		})
	end

	table.sort(var_6_0, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0.isLock and 0 or 1
		local var_7_1 = arg_7_1.isLock and 0 or 1

		if (arg_7_0.isLock and 0 or 1) == (arg_7_1.isLock and 0 or 1) then
			return arg_7_0.id < arg_7_1.id
		else
			return var_7_1 < var_7_0
		end
	end)

	return var_6_0
end

function var_0_0:GetKaliAffix(arg_8_1)
	if self.dataDic[arg_8_1] and self.dataDic[arg_8_1].showAffix then
		return self.dataDic[arg_8_1].showAffix
	end

	return {}
end

function var_0_0:GetSPChallengeData(arg_9_1)
	return self.dataDic[arg_9_1]
end

function var_0_0:GetStageData(arg_10_1, arg_10_2)
	local var_10_0 = self:GetSPChallengeData(arg_10_1)

	if var_10_0 then
		for iter_10_0, iter_10_1 in pairs(var_10_0.pointData) do
			if iter_10_1.id == arg_10_2 then
				return iter_10_1
			end
		end
	end

	return nil
end

function var_0_0:GetNowAffixEffect(arg_11_1)
	local var_11_0 = self:GetKaliAffix(arg_11_1)

	table.sort(var_11_0, function(arg_12_0, arg_12_1)
		return arg_12_1 < arg_12_0
	end)

	for iter_11_0, iter_11_1 in pairs(ActivitykaliaffixCfg.all) do
		table.sort(ActivitykaliaffixCfg[iter_11_1].combine, function(arg_13_0, arg_13_1)
			return arg_13_1 < arg_13_0
		end)

		local var_11_2 = true

		for iter_11_2, iter_11_3 in pairs(ActivitykaliaffixCfg[iter_11_1].combine) do
			var_11_2 = var_11_2 and var_11_0[iter_11_2] == iter_11_3
		end

		if var_11_2 then
			return iter_11_1
		end
	end

	return nil
end

function var_0_0:UpdateRedPoint(arg_14_1)
	if ActivityCfg.get_id_list_by_sub_activity_list[arg_14_1] then
		local var_14_0 = ActivityCfg.get_id_list_by_sub_activity_list[arg_14_1][1] or 0

		if var_14_0 ~= 0 then
			local var_14_1 = {}

			for iter_14_0, iter_14_1 in ipairs(BattleCoreKaliCfg.all) do
				local var_14_2 = string.format("%s_%s", RedPointConst.ACTIVITY_KALI_GAME_CHANLLENGE, iter_14_1)
				local var_14_4 = SPKaliChallengeData:GetStageData(arg_14_1, iter_14_1)
				local var_14_5 = SPKaliChallengeData:GetStageData(arg_14_1, ActivityKaliStageCfg[ActivityKaliStageCfg.get_id_list_by_stage_id[iter_14_1][1]].pre_stage)
				local var_14_6 = ActivityKaliStageCfg[ActivityKaliStageCfg.get_id_list_by_stage_id[iter_14_1][1]].pre_stage == 0 and true or var_14_5 and var_14_5.times > 0 or false
				local var_14_7 = var_14_4 and var_14_4.times > 0 or false
				local var_14_8 = ActivityData:GetActivityIsOpen(ActivityKaliStageCfg[ActivityKaliStageCfg.get_id_list_by_stage_id[iter_14_1][1]].activity_id)

				table.insert(var_14_1, var_14_2)
				manager.redPoint:setTip(var_14_2, not var_14_7 and var_14_8 and var_14_6 and 1 or 0)
			end

			local var_14_9 = ActivityTools.GetRedPointKey(arg_14_1) .. arg_14_1
			local var_14_10 = ActivityTools.GetRedPointKey(var_14_0) .. var_14_0
			local var_14_11 = self:GetSPChallengeData(arg_14_1)

			manager.redPoint:setTip(RedPointConst.ACTIVITY_KALI_FREE_ROLL, var_14_11 and var_14_11.free == 1 and not ShopTools.CheckShopSoldOut(ShopConst.SHOP_ID.SP_KALI_CHALLENGE_1) and 1 or 0)

			if not self.isInitRed then
				manager.redPoint:addGroup(var_14_9, {
					RedPointConst.ACTIVITY_KALI_FREE_ROLL
				})
				manager.redPoint:addGroup(var_14_10, {
					var_14_9
				})
			end

			if getData("SPKALI", "COLLECT_AFFIX") == 1 then
				manager.redPoint:setTip(RedPointConst.ACTIVITY_KALI_AFFIX, 1)
			else
				manager.redPoint:setTip(RedPointConst.ACTIVITY_KALI_AFFIX, 0)
			end
		end
	end

	self.isInitRed = true
end

function var_0_0.SaveChanlengePointPos(arg_15_0, arg_15_1)
	arg_15_0.pos1 = arg_15_1
end

function var_0_0.SaveTugPointPos(arg_16_0, arg_16_1)
	arg_16_0.pos2 = arg_16_1
end

return var_0_0
