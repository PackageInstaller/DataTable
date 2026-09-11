require("game.data.SPHeroChallengeDataTemplate")

local var_0_0 = singletonClass("TugGameData")

function var_0_0.Init(arg_1_0)
	arg_1_0.activityID = 0
	arg_1_0.activityData = {}
	arg_1_0.isInitRed = false
end

function var_0_0:InitTugData(arg_2_1)
	self.activityData[arg_2_1.activity_id] = self.activityData[arg_2_1.activity_id] or {}

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.mission_list) do
		var_2_0[iter_2_1.id] = iter_2_1
	end

	self.activityData[arg_2_1.activity_id] = {
		mission_list = arg_2_1.mission_list,
		activity_id = arg_2_1.activity_id,
		pointData = var_2_0
	}

	self:UpdateRedPoint(arg_2_1.activity_id)
end

function var_0_0:UpdateStage(arg_3_1)
	if self.activityData[arg_3_1.activity_id] then
		self.activityData[arg_3_1.activity_id].pointData[arg_3_1.stage_id] = {
			times = 1,
			id = arg_3_1.stage_id
		}
	end

	self:UpdateRedPoint(arg_3_1.activity_id)
end

function var_0_0:GetActivityData(arg_4_1)
	return self.activityData[arg_4_1]
end

function var_0_0:GetStageData(arg_5_1, arg_5_2)
	local var_5_0 = self:GetActivityData(arg_5_1)

	if var_5_0 then
		for iter_5_0, iter_5_1 in pairs(var_5_0.pointData) do
			if iter_5_1.id == arg_5_2 then
				return iter_5_1
			end
		end
	end

	return nil
end

function var_0_0:UpdateRedPoint(arg_6_1)
	if ActivityCfg.get_id_list_by_sub_activity_list[arg_6_1] then
		local var_6_0 = ActivityCfg.get_id_list_by_sub_activity_list[arg_6_1][1] or 0

		if var_6_0 ~= 0 then
			local var_6_1 = {}

			for iter_6_0, iter_6_1 in ipairs(ActivityKaliGameStageCfg.all) do
				local var_6_2 = string.format("%s_%s", RedPointConst.ACTIVITY_KALI_GAME_TUG, iter_6_1)
				local var_6_3 = TugGameData:GetStageData(arg_6_1, iter_6_1)
				local var_6_4 = var_6_3 and var_6_3.times > 0 or false
				local var_6_5 = ActivityData:GetActivityIsOpen(ActivityKaliGameStageCfg[iter_6_1].activity_id)
				local var_6_6 = TugGameData:GetStageData(arg_6_1, ActivityKaliGameStageCfg[iter_6_1].pre_stage)
				local var_6_7 = ActivityKaliGameStageCfg[iter_6_1].pre_stage == 0 and true or var_6_6 and var_6_6.times > 0 or false

				table.insert(var_6_1, var_6_2)
				manager.redPoint:setTip(var_6_2, not var_6_4 and var_6_5 and var_6_7 and 1 or 0)
			end

			local var_6_8 = ActivityTools.GetRedPointKey(arg_6_1) .. arg_6_1

			if not self.isInitRed then
				manager.redPoint:addGroup(var_6_8, var_6_1)
				manager.redPoint:addGroup(ActivityTools.GetRedPointKey(var_6_0) .. var_6_0, {
					var_6_8
				})
			end
		end
	end

	self.isInitRed = true
end

return var_0_0
