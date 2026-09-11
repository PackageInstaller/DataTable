local var_0_0 = {}
local var_0_1 = false

function var_0_0.Init()
	ActivityPushBoxData:Init()

	if var_0_1 then
		return
	end

	manager.net:Bind(11083, function(arg_2_0)
		ActivityPushBoxData:SetCakeData(arg_2_0)
		ActivityPushBoxAction.RefreshRedPoint(arg_2_0.activity_id)
	end)
	manager.net:Bind(11091, function(arg_3_0)
		ActivityPushBoxData:SetActivityData(arg_3_0)
		ActivityPushBoxAction.RefreshRedPoint(arg_3_0.activity_id)
		ActivityPushBoxData:ReBuild(arg_3_0.activity_id)
		manager.notify:Invoke(ACTIVITY_ICON_CHANGE)
		manager.notify:CallUpdateFunc(ACTIVITY_PUSH_BOX_MAP_REFRESH)
	end)
	manager.notify:RegistListener(MATERIAL_MODIFY, function(arg_4_0)
		for iter_4_0, iter_4_1 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_PUSH_BOX]) do
			if ActivityData:GetActivityData(iter_4_1):IsActivitying() then
				ActivityPushBoxAction.RefreshMaterialRedPoint(iter_4_1)
			end
		end
	end)

	var_0_1 = true
end

function var_0_0.InitRedPointKey(arg_5_0)
	manager.redPoint:addGroup(RedPointConst.ACTIVITY_PUSH_BOX .. "_" .. arg_5_0, {
		RedPointConst.ACTIVITY_TASK .. "_" .. ActivityConst.ACTIVITY_2_10_PUSH_BOX_TASK,
		RedPointConst.ACTIVITY_PUSH_BOX_FATIGUE .. "_" .. arg_5_0,
		RedPointConst.ACTIVITY_PUSH_BOX_MATERIAL .. "_" .. arg_5_0
	})
end

manager.notify:RegistListener(ACTIVITY_UPDATE, function(arg_6_0)
	if ActivityCelebrationOrderCfg.get_id_list_by_activity_id[arg_6_0] then
		if ActivityData:GetActivityData(arg_6_0):IsActivitying() then
			if ActivityCelebrationOrderCfg[ActivityCelebrationOrderCfg.get_id_list_by_activity_id[arg_6_0][1]].type == 2 then
				ActivityPushBoxData:ReBuild(ActivityCelebrationOrderCfg[ActivityCelebrationOrderCfg.get_id_list_by_activity_id[arg_6_0][1]].main_activity)
				manager.notify:CallUpdateFunc(ACTIVITY_PUSH_BOX_MAP_REFRESH)
			end
		end
	end
end)

function var_0_0.StartMaking(arg_7_0, arg_7_1)
	manager.net:SendWithLoadingNew(11084, {
		activity_id = arg_7_0,
		cake_id = ActivityCelebrationCakeCfg.get_id_list_by_activity_id[arg_7_0][arg_7_1]
	}, 11085, var_0_0.OnStartMaking)
end

function var_0_0:OnStartMaking(arg_8_1)
	if isSuccess(self.result) then
		for iter_8_0, iter_8_1 in ipairs(ActivityCelebrationCakeCfg[arg_8_1.cake_id].cost_list) do
			MaterialData:ModifyNum(iter_8_1[1], -1 * iter_8_1[2])
		end

		local var_8_0 = {}

		for iter_8_2, iter_8_3 in ipairs(self.rewards or {}) do
			table.insert(var_8_0, {
				id = iter_8_3.id,
				num = iter_8_3.num
			})
		end

		ActivityPushBoxData:SetCakeData({
			sign = 1,
			activity_id = arg_8_1.activity_id,
			cake_id = arg_8_1.cake_id
		})
		getRewardData(var_8_0)
		ActivityPushBoxAction.RefreshMaterialRedPoint(arg_8_1.activity_id)
		manager.notify:CallUpdateFunc(ACTIVITY_PUSH_BOX_MAKE_CAKE, var_8_0)
	else
		ShowTips(self.result)
	end
end

function var_0_0.ResetEvent(arg_9_0)
	manager.net:SendWithLoadingNew(11086, {
		activity_id = arg_9_0
	}, 11087, var_0_0.OnResetEvent)
end

function var_0_0:OnResetEvent(arg_10_1)
	if isSuccess(self.result) then
		-- block empty
	else
		ShowTips(self.result)
	end
end

function var_0_0.FinishPushBox(arg_11_0, arg_11_1)
	manager.net:SendWithLoadingNew(11088, {
		activity_id = arg_11_0,
		order_id = arg_11_1
	}, 11089, var_0_0.OnFinishPushBox)
end

function var_0_0:OnFinishPushBox(arg_12_1)
	if isSuccess(self.result) then
		local var_12_0 = {}

		for iter_12_0, iter_12_1 in ipairs(self.rewards or {}) do
			table.insert(var_12_0, {
				iter_12_1.id,
				iter_12_1.num
			})
		end

		local var_12_1 = {}

		for iter_12_2, iter_12_3 in ipairs(var_12_0) do
			var_12_1[iter_12_2] = ItemConst.LIMIT_TIME_ITEM[ItemCfg[iter_12_3[1]].sub_type] and {
				ItemCfg[iter_12_3[1]].param[1],
				iter_12_3[2],
				0,
				_G.gameTimer:GetNextWeekFreshTime() + ItemCfg[iter_12_3[1]].time[2][1] * 604800 + (ItemCfg[iter_12_3[1]].time[2][2][1] - 1) * 24 * 3600 + (ItemCfg[iter_12_3[1]].time[2][2][2] - 5) * 3600
			} or iter_12_3
		end

		PushBoxTool:SendSdk(arg_12_1.activity_id, ActivityCelebrationOrderCfg[arg_12_1.order_id].param, 1)
		ActivityPushBoxData:FinishPushBox(arg_12_1.activity_id, arg_12_1.order_id)
		JumpTools.OpenPageByJump("pushBoxResult", {
			activityID = arg_12_1.activity_id,
			rewardList = var_12_1
		})
	else
		ShowTips(self.result)
	end
end

function var_0_0.RefreshRedPoint(arg_13_0)
	ActivityPushBoxAction.RefreshFatigueRedPoint(arg_13_0)
	ActivityPushBoxAction.RefreshMaterialRedPoint(arg_13_0)
end

function var_0_0.RefreshFatigueRedPoint(arg_14_0)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(TaskTools:GetActivityTaskList(ActivityConst.ACTIVITY_2_10_PUSH_BOX_TASK) or {}) do
		if iter_14_1.complete_flag == 0 then
			table.insert(var_14_0, iter_14_0)
		end
	end

	local var_14_2

	if #var_14_0 <= 0 and ActivityPushBoxData:GetCurIndex(arg_14_0) >= #(ActivityCelebrationCakeCfg.get_id_list_by_activity_id[arg_14_0] or {}) then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_BOX_FATIGUE .. "_" .. arg_14_0, 0)

		do return end

		var_14_2 = RedPointConst.ACTIVITY_PUSH_BOX_FATIGUE .. "_" .. arg_14_0
	end

	manager.redPoint:setTip(var_14_2, PushBoxTool:GetFatigueMax(arg_14_0) <= ActivityPushBoxData:GetFatigue(arg_14_0) and 1 or 0)
end

function var_0_0.RefreshMaterialRedPoint(arg_15_0)
	local var_15_0 = ActivityPushBoxData:GetCurIndex(arg_15_0)

	if var_15_0 >= #ActivityCelebrationCakeCfg.get_id_list_by_activity_id[arg_15_0] then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_BOX_MATERIAL .. "_" .. arg_15_0, 0)

		return
	end

	for iter_15_0, iter_15_1 in ipairs(ActivityCelebrationCakeCfg[ActivityCelebrationCakeCfg.get_id_list_by_activity_id[arg_15_0][var_15_0 + 1]].cost_list) do
		if iter_15_1[2] > ItemTools.getItemNum(iter_15_1[1]) then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_BOX_MATERIAL .. "_" .. arg_15_0, 0)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_BOX_MATERIAL .. "_" .. arg_15_0, 1)
end

return var_0_0
