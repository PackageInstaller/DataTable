local var_0_0 = {}
local var_0_1 = {}

manager.net:Bind(65501, function(arg_1_0)
	ActivitySummerSwimsuitPreheatData.InitData(arg_1_0)
	Timer.New(function()
		ActivitySummerSwimsuitPreheatAction.InitRedPoint(arg_1_0)
	end, 1, 0):Start()
	manager.notify:CallUpdateFunc("OnActivitySummerSwimsuitPreheatInit")
end)

function var_0_0.SendStageClear(arg_3_0, arg_3_1, arg_3_2)
	manager.net:SendWithLoadingNew(65502, {
		activity_id = arg_3_0,
		stage_id = arg_3_1
	}, 65503, function(arg_4_0, arg_4_1)
		var_0_0.OnSendStageClear(arg_4_0, arg_4_1, arg_3_2)
	end)
end

function var_0_0:OnSendStageClear(arg_5_1, arg_5_2)
	if not isSuccess(self.result) then
		ShowTips(self.result)

		return
	end

	ActivitySummerSwimsuitPreheatData.AddClearedStage(arg_5_1.activity_id, arg_5_1.stage_id)
	arg_5_2(arg_5_1.activity_id, arg_5_1.stage_id)
end

function var_0_0.GetStageReward(arg_6_0, arg_6_1, arg_6_2)
	manager.net:SendWithLoadingNew(65508, {
		activity_id = arg_6_0,
		stage_id = arg_6_1
	}, 65509, function(arg_7_0, arg_7_1)
		var_0_0.OnGetStageReward(arg_7_0, arg_7_1, arg_6_2)
	end)
end

function var_0_0:OnGetStageReward(arg_8_1, arg_8_2)
	if not isSuccess(self.result) then
		ShowTips(self.result)

		return
	end

	ActivitySummerSwimsuitPreheatData.GetStageReward(arg_8_1.activity_id, arg_8_1.stage_id)
	arg_8_2(arg_8_1.activity_id, arg_8_1.stage_id, self.item_list)
end

function var_0_0._ManualUpdateDay(arg_9_0)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(ActivityCfg[arg_9_0].sub_activity_list) do
		if ActivityData:GetActivityIsOpen(iter_9_1) then
			var_9_0 = var_9_0 + 1
		end
	end

	if ActivitySummerSwimsuitPreheatData.GetDay(arg_9_0) < var_9_0 then
		ActivitySummerSwimsuitPreheatData._SetDay(arg_9_0, var_9_0)
	end
end

local var_0_2 = false

function var_0_0:InitRedPoint()
	var_0_1[self.activity_id] = {}

	var_0_0.UpdateRedPoint(self.activity_id)

	if not var_0_2 then
		manager.notify:RegistListener(ACTIVITY_UPDATE, function(arg_11_0)
			Timer.New(function()
				local var_12_0 = ActivityTools.GetActivityType(arg_11_0)

				if var_12_0 == ActivityTemplateConst.ACTIVITY_SUMMER_SWIMSUIT_PREHEAT then
					var_0_0.UpdateRedPoint(arg_11_0)
					manager.notify:CallUpdateFunc("OnActivitySummerSwimsuitPreheatInit")
				end

				if var_12_0 == ActivityTemplateConst.ACTIVITY_SUMMER_SWIMSUIT_PREHEAT_STAGE then
					local var_12_1 = ActivityTools.GetMainActivityId(arg_11_0)

					var_0_0._ManualUpdateDay(var_12_1)
					var_0_0.UpdateRedPoint(var_12_1)
					manager.notify:CallUpdateFunc("OnActivitySummerSwimsuitPreheatInit")
				end
			end, 2.5, 0):Start()
		end)

		var_0_2 = true
	end
end

function var_0_0.UpdateRedPoint(arg_13_0)
	local var_13_0 = ActivityTools.GetRedPointKey(arg_13_0) .. arg_13_0
	local var_13_1 = string.format("%s_%s", RedPointConst.ACTIVITY_SUMMER_SWIMSUIT_PREHEAT, var_13_0)
	local var_13_2 = string.format("%s_%s", RedPointConst.ACTIVITY_SUMMER_SWIMSUIT_PREHEAT_STAGE, var_13_0)

	manager.redPoint:addGroup(var_13_0, {
		var_13_1
	})
	manager.redPoint:addGroup(var_13_1, {
		var_13_2
	})

	local var_13_3 = not not ActivityData:GetActivityData(arg_13_0):IsOverdue()
	local var_13_4 = ActivitySummerSwimsuitPreheatTools.GetCfgIdList(arg_13_0)

	if var_13_4 == nil then
		return
	end

	var_0_1[arg_13_0] = var_0_1[arg_13_0] or {}

	local var_13_5 = {}

	for iter_13_0, iter_13_1 in ipairs(var_13_4) do
		local var_13_6 = string.format("%s_%d_%s", RedPointConst.ACTIVITY_SUMMER_SWIMSUIT_PREHEAT_STAGE, ActivitySummerSwimsuitPreheatCfg[iter_13_1].id, var_13_0)
		local var_13_7 = string.format("%s_%d_%s", RedPointConst.ACTIVITY_SUMMER_SWIMSUIT_PREHEAT_REWARD, ActivitySummerSwimsuitPreheatCfg[iter_13_1].id, var_13_0)
		local var_13_8 = ActivityData:GetActivityIsOpen(ActivitySummerSwimsuitPreheatCfg[iter_13_1].activity_id)
		local var_13_9 = ActivitySummerSwimsuitPreheatData.IsStageClear(arg_13_0, ActivitySummerSwimsuitPreheatCfg[iter_13_1].id)
		local var_13_10 = ActivitySummerSwimsuitPreheatData.IsGotStageReward(arg_13_0, ActivitySummerSwimsuitPreheatCfg[iter_13_1].id)

		if var_0_1[arg_13_0][var_13_6] or var_13_3 then
			manager.redPoint:setTip(var_13_6, 0)
		else
			manager.redPoint:setTip(var_13_6, var_13_8 and not var_13_9 and 1 or 0)
		end

		if var_13_3 then
			manager.redPoint:setTip(var_13_7, 0)
		else
			manager.redPoint:setTip(var_13_7, var_13_8 and var_13_9 and not var_13_10 and 1 or 0)
		end

		table.insert(var_13_5, var_13_6)
		table.insert(var_13_5, var_13_7)
	end

	manager.redPoint:addGroup(var_13_2, var_13_5)
end

function var_0_0.BanRedPoint(arg_14_0, arg_14_1)
	if var_0_1[arg_14_0] then
		var_0_1[arg_14_0][arg_14_1] = true

		var_0_0.UpdateRedPoint(arg_14_0)
	end
end

return var_0_0
