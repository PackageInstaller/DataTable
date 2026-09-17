local var_0_0 = {}
local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local kamila_activity_level_data = require("data.kamila_activity_level_data")
local gamebuff_data = require("data.gamebuff_data")
local network = require("network.network")
local drop_manager = require("controller.drop_manager")
local time_check_manager = require("controller.time_check_manager")
local var_0_8 = require("controller.activity_manager")
local task_data = require("data.task_data")
local returnback_conf_data = require("data.returnback_conf_data")
local drop_data = require("data.drop_data")
local return_jump_data = require("data.return_jump_data")
local activity_entrance_data = require("data.activity_entrance_data")
local backflow_stage_reward_data = require("data.backflow_stage_reward_data")

var_0_0.BUFF_TYPES = {
	BUFF_TYPE_GOLD = 3,
	BUFF_TYPE_SP = 2,
	BUFF_TYPE_ADVENTURE_DROP = 4,
	BUFF_TYPE_EXP = 1,
	BUFF_TYPE_ARENA_DROP = 9,
	BUFF_TYPE_TFT_POINT = 8,
	BUFF_TYPE_SEND_GIFT_FAVOR = 6,
	BUFF_PVE_FIGNT_ATTRIBUTE = 10,
	BUFF_TYPE_SCORE_ARENA_POINT = 7,
	BUFF_TYPE_NEW_AREAN_POINT = 5
}

function var_0_0.get_game_buffs(arg_1_0, arg_1_1)
	network:rpc("get_game_buffs", nil, function(arg_2_0)
		if arg_2_0.result == 1 then
			arg_1_0:setGameBuff(arg_2_0.buffs)

			if arg_1_1 then
				arg_1_1(arg_2_0)
			end
		else
			print("game buff error: -------------------------------> result = ", arg_2_0.result)

			if arg_1_1 then
				arg_1_1(arg_2_0)
			end
		end
	end)
end

function var_0_0.add_game_buff(arg_3_0, arg_3_1, arg_3_2)
	network:rpc("add_game_buff", {
		cost_item = arg_3_1
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			if arg_3_2 then
				arg_3_2(arg_4_0)
			end
		else
			print("error:-------------------------------> the error is: ", arg_4_0.result)
		end
	end)
end

function var_0_0.get_returnback_sign_info(arg_5_0, arg_5_1)
	network:rpc("get_returnback_sign_info", nil, function(arg_6_0)
		print(dump(arg_6_0))

		if not arg_6_0.use_old then
			local activity_sign_data = require("data.activity_sign_data")

			activity_manager:getActivitySignData(176, function(arg_7_0)
				arg_5_0.existsign = true
				arg_5_0.endtime = arg_6_0.endtime
				arg_5_0.cansign = arg_7_0.cansign
				arg_5_0.drop_id = arg_6_0.dropid
				arg_5_0.signVersion = activity_manager:getSignVersion(176)
				arg_5_0.signcount = 0
				arg_5_0.signDropData = {}

				for iter_7_0, iter_7_1 in ipairs(arg_7_0.signstats) do
					if iter_7_1 then
						arg_5_0.signcount = arg_5_0.signcount + 1
					end

					table.insert(arg_5_0.signDropData, {
						image = "1311150",
						id = iter_7_0,
						drop_id = activity_sign_data[(arg_5_0.signVersion > 1 or nil) and string.format("%d-%d-%d", 176, arg_5_0.signVersion, iter_7_0)].dropid
					})
				end

				if arg_5_1 then
					arg_5_1(arg_6_0)
				end

				activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_RETURN_SIGN_UPDATE)
			end)
		end

		if arg_6_0.result == 1 then
			arg_5_0.existsign = arg_6_0.existsign
			arg_5_0.endtime = arg_6_0.endtime
			arg_5_0.signcount = arg_6_0.signcount
			arg_5_0.cansign = arg_6_0.cansign
			arg_5_0.drop_id = arg_6_0.dropid
			arg_5_0.offline_day = arg_6_0.offline_day

			if arg_5_1 then
				arg_5_1(arg_6_0)
			end

			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_RETURN_SIGN_UPDATE)
		else
			print("error:-------------------------------> the error is: ", arg_6_0.result)
		end
	end)
end

function var_0_0.get_returnback_timesign_info(arg_8_0)
	local var_8_0 = returnback_conf_data.activity_sign_id.value
	local var_8_1 = activity_manager:getActivityObj(returnback_conf_data.activity_sign_id.value)
	local activity_sign_data = require("data.activity_sign_data")

	if not var_8_1 then
		return
	end

	var_8_1:getActivitySign(function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		local var_9_0 = {
			signCount = 0,
			canSign = arg_9_2,
			finishTime = os.time(parse_time(returnback_conf_data.activity_sign_finishtime.value_str)),
			timeSignData = {}
		}

		for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
			if iter_9_1 then
				var_9_0.signCount = var_9_0.signCount + 1
			end

			table.insert(var_9_0.timeSignData, {
				image = "1311150",
				id = iter_9_0,
				drop_id = activity_sign_data[var_8_0 .. "-" .. iter_9_0].dropid
			})
		end

		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_RETURN_TIME_SIGN_UPDATE, var_9_0)
	end)
end

function var_0_0:get_returnback_info(arg_10_1)
	self:getBpInfo(function()
		self:get_returnback_sign_info(function()
			if type(arg_10_1) == "function" then
				arg_10_1()
			end
		end)

		if self.finishtime and self:checkIsTimeOut(self.finishtime) then
			self:get_returnback_guideids()
			self:get_recall_bind_info()
		end
	end)
end

function var_0_0.get_returnback_guideids(arg_13_0)
	local var_13_0 = activity_manager:getActivityObj(BACKFLOW_BP_ID)

	if var_13_0 then
		var_13_0:getBPReturnbackGuideList()
	end
end

function var_0_0.get_recall_bind_info(arg_14_0, arg_14_1)
	network:rpc("get_recall_bind_info", {}, function(arg_15_0)
		if arg_15_0.result == 1 then
			arg_14_0.recallCode = arg_15_0.binduid
		end

		if arg_14_1 then
			arg_14_1(arg_15_0)
		end
	end)
end

function var_0_0:get_recall_code()
	return self.recallCode or 0
end

function var_0_0.bind_recall_code(arg_17_0, arg_17_1, arg_17_2)
	network:rpc("bind_recall_code", {
		binduid = arg_17_1
	}, function(arg_18_0)
		if arg_18_0.result == 1 then
			global_gain(arg_18_0)
			arg_17_0:get_recall_bind_info(arg_17_2)
		elseif arg_18_0.result == 2 then
			global_ShowBlockWords("已经绑定召回码")
		else
			global_ShowBlockWords("召回码错误，请重新输入")
		end

		if arg_18_0.result ~= 1 and arg_17_2 then
			arg_17_2(arg_18_0)
		end
	end)
end

function var_0_0.returnback_timesign(arg_19_0, arg_19_1)
	network:rpc("activity_sign", {
		id = returnback_conf_data.activity_sign_id.value,
		signid = arg_19_1
	}, function(arg_20_0)
		if arg_20_0.result == 1 then
			global_gain({
				sp = arg_20_0.sp,
				gold = arg_20_0.gold,
				items = arg_20_0.items
			})
			arg_19_0:get_returnback_timesign_info()
		else
			print("error:-------------------------------> the error is: ", arg_20_0.result)
		end
	end)
end

function var_0_0:returnback_sign(arg_21_1)
	if self.signVersion and self.signVersion > 1 then
		network:rpc("activity_sign", {
			id = 176,
			signid = arg_21_1
		}, function(arg_22_0)
			if arg_22_0.result == 1 then
				global_gain({
					sp = arg_22_0.sp,
					gold = arg_22_0.gold,
					items = arg_22_0.items
				})
				self:get_returnback_info()
			else
				print("error:-------------------------------> the error is: ", arg_22_0.result)
			end
		end)

		return
	end

	network:rpc("returnback_sign", nil, function(arg_23_0)
		if arg_23_0.result == 1 then
			if callback then
				callback()
			end

			global_gain({
				sp = arg_23_0.sp,
				gold = arg_23_0.gold,
				items = arg_23_0.items
			})
			self:get_returnback_info()
		else
			print("error:-------------------------------> the error is: ", arg_23_0.result)
		end
	end)
end

function var_0_0.getBpInfo(arg_24_0, arg_24_1)
	network:rpc("get_returnback_bp_info", nil, function(arg_25_0)
		arg_24_0.finishtime = arg_25_0.finishtime

		if arg_24_1 then
			arg_24_1(arg_25_0)
		end
	end)
end

function var_0_0.isCommitSurvey(arg_26_0)
	return RoleDefault:getInstance():getIntegerForKey("CommitTime", 0) > time_check_manager:getCurTime()
end

function var_0_0.returnback_paper(arg_27_0, arg_27_1)
	network:rpc("returnback_paper", nil, function(arg_28_0)
		if arg_27_1 then
			arg_27_1(arg_28_0)
		end
	end)
end

function var_0_0.setGameBuff(arg_29_0, arg_29_1)
	arg_29_0.buffs = arg_29_1

	activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_RETURN_BUFF_UPDATE)
end

function var_0_0:get_buffs()
	if self.buffs and next(self.buffs) then
		return self.buffs
	end
end

function var_0_0:get_buff_up()
	if self.buffs and next(self.buffs) then
		local var_31_0 = 0

		for iter_31_0, iter_31_1 in pairs(self.buffs) do
			var_31_0 = var_31_0 + gamebuff_data[iter_31_1.id].rate
		end

		return var_31_0 * 100
	end
end

function var_0_0:is_have_catchup_buff(arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(self.buffs or {}) do
		if gamebuff_data[iter_32_1.id].type == arg_32_1 and self:checkIsTimeOut(iter_32_1.time) then
			return true, gamebuff_data[iter_32_1.id]
		end
	end

	return false
end

function var_0_0:get_money_or_science_up(arg_33_1)
	local var_33_0 = 1

	if self.buffs and next(self.buffs) then
		for iter_33_0, iter_33_1 in pairs(self.buffs) do
			if gamebuff_data[iter_33_1.id].type == arg_33_1 and self:checkIsTimeOut(iter_33_1.time) then
				var_33_0 = var_33_0 + gamebuff_data[iter_33_1.id].rate
			end
		end
	end

	return var_33_0 > 1, var_33_0
end

function var_0_0:have_buff(arg_34_1)
	if not self.buffs then
		return false
	end

	for iter_34_0, iter_34_1 in pairs(self.buffs) do
		if iter_34_1.id == arg_34_1 and self:checkIsTimeOut(iter_34_1.time) then
			return true
		end
	end

	return false
end

function var_0_0.checkIsTimeOut(arg_35_0, arg_35_1)
	if arg_35_1 - time_check_manager:getCurTime() > 0 then
		return true
	else
		return false
	end
end

function var_0_0:get_exist_sign()
	if self.existsign then
		return self.existsign
	end
end

function var_0_0:get_sign_count()
	if self.signcount then
		return self.signcount
	end
end

function var_0_0:get_can_sign()
	return self.cansign
end

function var_0_0:get_end_time()
	if self.endtime then
		return self.endtime
	end
end

function var_0_0:get_sign_version()
	return self.signVersion
end

function var_0_0:get_return_sign_data()
	if self.signVersion and self.signVersion >= 1 then
		return self.signDropData
	end

	return (require("data.returnback_sign_data"))
end

function var_0_0:get_mail_drop()
	if self.drop_id then
		return self.drop_id
	end
end

function var_0_0.get_jumpid(arg_43_0)
	local var_43_0

	for iter_43_0, iter_43_1 in pairs(return_jump_data) do
		if iter_43_1.returnlayer_jumpid then
			var_43_0 = iter_43_1.returnlayer_jumpid
		end
	end

	for iter_43_2, iter_43_3 in pairs(activity_entrance_data) do
		if iter_43_3.id == var_43_0 then
			return iter_43_3
		end
	end
end

function var_0_0.get_jump_image(arg_44_0)
	for iter_44_0, iter_44_1 in pairs(return_jump_data) do
		if iter_44_1.returnlayer_image then
			return iter_44_1.returnlayer_image
		end
	end
end

function var_0_0.getDropData(arg_45_0, arg_45_1)
	local var_45_0 = {
		gold = 0,
		diamond = 0,
		items = {}
	}
	local var_45_1 = drop_data[arg_45_1] or {}

	if var_45_1.gold then
		var_45_0.gold = var_45_0.gold + var_45_1.gold
	end

	if var_45_1.diamond then
		var_45_0.diamond = var_45_0.diamond + var_45_1.diamond
	end

	local var_45_2 = 1

	if var_45_1["drop_id" .. 1] then
		local var_45_3 = 1

		while var_45_1["drop_id" .. var_45_3] do
			var_45_0.items[var_45_2] = {
				itemid = var_45_1["drop_id" .. var_45_3],
				num = var_45_1["drop_num" .. var_45_3]
			}
			var_45_3 = var_45_3 + 1
			var_45_2 = var_45_2 + 1
		end
	end

	if var_45_1["dropmodel_id" .. 1] then
		local var_45_4 = 1

		while var_45_1["dropmodel_id" .. var_45_4] do
			if drop_data[var_45_1["dropmodel_id" .. var_45_4]].gold then
				var_45_0.gold = var_45_0.gold + drop_data[var_45_1["dropmodel_id" .. var_45_4]].gold
			end

			if drop_data[var_45_1["dropmodel_id" .. var_45_4]].diamond then
				var_45_0.diamond = var_45_0.diamond + drop_data[var_45_1["dropmodel_id" .. var_45_4]].diamond
			end

			if drop_data[var_45_1["dropmodel_id" .. var_45_4]]["drop_id" .. 1] then
				local var_45_5 = 1

				while drop_data[var_45_1["dropmodel_id" .. var_45_4]]["drop_id" .. var_45_5] do
					var_45_0.items[var_45_2] = {
						itemid = drop_data[var_45_1["dropmodel_id" .. var_45_4]]["drop_id" .. var_45_5],
						num = drop_data[var_45_1["dropmodel_id" .. var_45_4]]["drop_num" .. var_45_5]
					}
					var_45_5 = var_45_5 + 1
					var_45_2 = var_45_2 + 1
				end
			end

			if drop_data[var_45_1["dropmodel_id" .. var_45_4]]["rd_drop_id" .. 1] then
				local var_45_6 = 1

				while drop_data[var_45_1["dropmodel_id" .. var_45_4]]["rd_drop_id" .. var_45_6] do
					var_45_0.items[var_45_2] = {
						itemid = drop_data[var_45_1["dropmodel_id" .. var_45_4]]["rd_drop_id" .. var_45_6],
						num = drop_data[var_45_1["dropmodel_id" .. var_45_4]]["rd_drop_num" .. var_45_6]
					}
					var_45_6 = var_45_6 + 1
					var_45_2 = var_45_2 + 1
				end
			end

			var_45_4 = var_45_4 + 1
		end
	end

	if var_45_1["rd_drop_id" .. 1] then
		local var_45_7 = 1

		while var_45_1["rd_drop_id" .. var_45_7] do
			var_45_0.items[var_45_2] = {
				itemid = var_45_1["rd_drop_id" .. var_45_7],
				num = var_45_1["rd_drop_num" .. var_45_7]
			}
			var_45_7 = var_45_7 + 1
			var_45_2 = var_45_2 + 1
		end
	end

	if var_45_1["rd_dropmodel_id" .. 1] then
		local var_45_8 = 1

		while var_45_1["rd_dropmodel_id" .. var_45_8] do
			if drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]].gold then
				var_45_0.gold = var_45_0.gold + drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]].gold
			end

			if drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]].diamond then
				var_45_0.diamond = var_45_0.diamond + drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]].diamond
			end

			if drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]]["drop_id" .. 1] then
				local var_45_9 = 1

				while drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]]["drop_id" .. var_45_9] do
					var_45_0.items[var_45_2] = {
						itemid = drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]]["drop_id" .. var_45_9],
						num = drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]]["drop_num" .. var_45_9]
					}
					var_45_9 = var_45_9 + 1
					var_45_2 = var_45_2 + 1
				end
			end

			if drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]]["rd_drop_id" .. 1] then
				local var_45_10 = 1

				while drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]]["rd_drop_id" .. var_45_10] do
					var_45_0.items[var_45_2] = {
						itemid = drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]]["rd_drop_id" .. var_45_10],
						num = drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]]["rd_drop_num" .. var_45_10]
					}
					var_45_10 = var_45_10 + 1
					var_45_2 = var_45_2 + 1
				end
			end

			var_45_8 = var_45_8 + 1
		end
	end

	local var_45_11 = var_45_0.items
	local var_45_12 = {}

	if var_45_0.items and #var_45_11 > 0 then
		for iter_45_0, iter_45_1 in ipairs(var_45_11) do
			if iter_45_1.num and iter_45_1.num > 0 then
				table.insert(var_45_12, {
					num = iter_45_1.num,
					itemid = iter_45_1.itemid
				})
			end
		end
	end

	if var_45_0.gold and var_45_0.gold > 0 then
		table.insert(var_45_12, {
			itemid = "gold",
			num = var_45_0.gold
		})
	end

	if var_45_0.diamond and var_45_0.diamond > 0 then
		table.insert(var_45_12, {
			itemid = "diamond",
			num = var_45_0.diamond
		})
	end

	return var_45_12
end

function var_0_0:isShowReturnBp()
	return activity_manager:getActivityObj(BACKFLOW_BP_ID) ~= nil and self.finishtime ~= 0 and self.finishtime >= time_check_manager:getCurTime()
end

function var_0_0:isShowReturnBpRedDot()
	if not self.finishtime then
		return false
	end

	local var_47_0 = false

	var_47_0 = (activity_manager:getAlertStatus(BACKFLOW_BP_ID, (activity_manager:getActivityBPTaskUseModule(BACKFLOW_BP_ID))) or activity_manager:getAlertStatus(BACKFLOW_BP_ID, "bp_proceed") or activity_manager:getAlertStatus(BACKFLOW_BP_ID, "bond") or activity_manager:getAlertStatus(BACKFLOW_BP_ID, "community") or activity_manager:getAlertStatus(BACKFLOW_BP_ID, "towerfight") or var_0_8:getAlertStatus(BACKFLOW_BP_ID, "recall") or var_0_8:getAlertStatus(BACKFLOW_BP_ID, "returnback_reward")) and true

	return (self.cansign or nil) and true
end

function var_0_0:isReturnSignFinish(...)
	if self.finishtime == 0 then
		return true
	end

	return false
end

function var_0_0.isReturnTimeSignFinish(arg_49_0, ...)
	return activity_manager:getActivityObj(returnback_conf_data.activity_sign_id.value)
end

function var_0_0:getFinishtime(...)
	return self.finishtime
end

function var_0_0:get_buff_end_time()
	local var_51_0 = self:get_buffs()

	if not var_51_0 then
		return 0
	end

	return var_51_0[1].time or 0
end

function var_0_0.get_returnback_daily_Reward(arg_52_0, arg_52_1)
	require("network.network"):rpc("get_activity_pop_drop", {
		id = 800050
	}, function(arg_53_0)
		print(dump(arg_53_0))

		if arg_53_0.result == 1 then
			global_gain(arg_53_0)

			if arg_52_1 then
				arg_52_1()
			end
		elseif arg_53_0.result == 2 then
			global_ShowBlockWords("今日已领取")
		elseif arg_53_0.result == 3 then
			global_ShowBlockWords("已过期")
		end
	end)
end

function var_0_0.get_returnback_reward_task(arg_54_0)
	var_0_8:getActivityTaskList(BACKFLOW_BP_ID, nil, function(arg_55_0, arg_55_1)
		if arg_55_0 ~= 1 then
			return
		end

		arg_54_0.taskList = {}

		for iter_55_0, iter_55_1 in pairs(arg_55_1.list) do
			iter_55_1.name = task_data[iter_55_1.taskid].name
			iter_55_1.task_des = task_data[iter_55_1.taskid].task_des
			iter_55_1.image = task_data[iter_55_1.taskid].image
			iter_55_1.drop = task_data[iter_55_1.taskid].drop
			iter_55_1.jump = task_data[iter_55_1.taskid].jump
			iter_55_1.order = task_data[iter_55_1.taskid].order

			if iter_55_1.status == 1 then
				iter_55_1.percent = -1
			end

			table.insert(arg_54_0.taskList, iter_55_1)
		end

		table.sort(arg_54_0.taskList, function(arg_56_0, arg_56_1)
			if arg_56_0.percent == arg_56_1.percent then
				return arg_56_0.order < arg_56_1.order
			else
				return arg_56_0.percent > arg_56_1.percent
			end
		end)
		var_0_8:fireEvent(var_0_8.activityEventId.RETRUN_BACK_REWARD_TASK_UPDATE)
		var_0_8:updateActivityAlert("returnback_reward", BACKFLOW_BP_ID, arg_54_0:isHasCanCompleteTask())
	end, false, nil, "returnback_reward")
end

function var_0_0:getRewardTaskListData()
	local var_57_0 = {}

	for iter_57_0, iter_57_1 in pairs(self.taskList) do
		var_57_0[iter_57_1.taskid] = iter_57_1.status
	end

	local var_57_1 = {}

	for iter_57_2, iter_57_3 in pairs(self.taskList) do
		local var_57_2 = tonumber(task_data[iter_57_3.taskid].pre)
		local var_57_3 = tonumber(task_data[iter_57_3.taskid].continue_task)

		if var_57_2 and var_57_0[var_57_2] >= 1 then
			table.insert(var_57_1, iter_57_3)
		elseif var_57_3 and iter_57_3.status < 1 then
			table.insert(var_57_1, iter_57_3)
		end
	end

	return var_57_1
end

function var_0_0:isHasCanCompleteTask()
	if not self.taskList or #self.taskList == 0 then
		return false
	end

	return self.taskList[1].status == 0 and self.taskList[1].percent == 100
end

function var_0_0:getRewardTaskDropData(arg_59_1)
	local var_59_0 = task_data[arg_59_1]
	local var_59_1 = drop_manager:getAllDrops(task_data[arg_59_1].drop)
	local var_59_2 = backflow_stage_reward_data[self.offline_day] or backflow_stage_reward_data[30]
	local var_59_3 = 0

	if var_59_2 or self.offline_day > 100 then
		var_59_2 = var_59_2 or backflow_stage_reward_data[#backflow_stage_reward_data]

		local var_59_4 = var_59_2["task_" .. arg_59_1]

		if var_59_2["task_" .. arg_59_1] then
			local var_59_5 = {}

			for iter_59_0, iter_59_1 in pairs((drop_manager:getAllDrops(var_59_4))) do
				var_59_5[iter_59_1.dropid] = {
					dropid = iter_59_1.dropid,
					dropNum = iter_59_1.dropNum
				}
			end

			for iter_59_2, iter_59_3 in pairs(var_59_1) do
				if var_59_5[iter_59_3.dropid] then
					var_59_1[iter_59_2].dropNum = var_59_1[iter_59_2].dropNum + var_59_5[iter_59_3.dropid].dropNum
					var_59_5[iter_59_3.dropid] = nil
				end
			end

			if next(var_59_5) then
				for iter_59_4, iter_59_5 in pairs(var_59_5) do
					table.insert(var_59_1, iter_59_5)
				end
			end

			if drop_data[var_59_4].diamond then
				var_59_3 = var_59_3 + drop_data[var_59_4].diamond
			end
		end
	end

	if drop_data[var_59_0.drop].diamond then
		var_59_3 = var_59_3 + drop_data[var_59_0.drop].diamond
	end

	if var_59_3 > 0 then
		table.insert(var_59_1, {
			dropid = "diamond",
			dropNum = var_59_3
		})
	end

	return var_59_1
end

function var_0_0.getTaskReward(arg_60_0, arg_60_1)
	var_0_8:getTaskReward(BACKFLOW_BP_ID, arg_60_1, function(arg_61_0, arg_61_1)
		if arg_61_0 ~= 1 then
			global_ShowBlockWords(L_BATTLE_PASS.FAIL)

			return
		end

		global_gain(arg_61_1)
		arg_60_0:get_returnback_reward_task()
	end)
end

function var_0_0:getOfflineDay()
	if self.offline_day then
		return self.offline_day
	end
end

local var_0_16 = 1769002050

function var_0_0.get_returnback_sevenday_task(arg_63_0, arg_63_1, arg_63_2)
	local function var_63_0(arg_64_0)
		local var_64_0 = time_check_manager:getCurTime()
		local var_64_1

		if not playermodel.lastreturnbacktime or var_64_0 < playermodel.lastreturnbacktime or playermodel.lastreturnbacktime == 0 then
			do return true end

			var_64_1 = {}
		end

		var_64_1.year = os.date("*t", playermodel.lastreturnbacktime).year
		var_64_1.month = os.date("*t", playermodel.lastreturnbacktime).month
		var_64_1.day = os.date("*t", playermodel.lastreturnbacktime).day

		if arg_64_0 > math.floor((os.time({
			year = os.date("*t", var_64_0).year,
			month = os.date("*t", var_64_0).month,
			day = os.date("*t", var_64_0).day
		}) - os.time(var_64_1)) / 24 * 3600) + 1 then
			return true
		end

		return false
	end

	var_0_8:getActivityTaskList(BACKFLOW_BP_ID, nil, function(arg_65_0, arg_65_1)
		if arg_65_0 ~= 1 then
			return
		end

		local var_65_0 = {}
		local var_65_1

		for iter_65_0, iter_65_1 in pairs(arg_65_1.list) do
			if task_data[iter_65_1.taskid] and task_data[iter_65_1.taskid].sevenday_stage == arg_63_1 then
				iter_65_1.name = task_data[iter_65_1.taskid].name
				iter_65_1.task_des = task_data[iter_65_1.taskid].task_des
				iter_65_1.image = task_data[iter_65_1.taskid].image
				iter_65_1.drop = task_data[iter_65_1.taskid].drop
				iter_65_1.jump = task_data[iter_65_1.taskid].jump
				iter_65_1.order = task_data[iter_65_1.taskid].order
				iter_65_1.isLock = var_63_0(arg_63_1)

				if iter_65_1.status == 1 then
					iter_65_1.percent = -1
				end

				if task_data[iter_65_1.taskid].id ~= var_0_16 then
					table.insert(var_65_0, iter_65_1)
				end
			end

			if task_data[iter_65_1.taskid].id == var_0_16 then
				var_65_1 = iter_65_1
			end
		end

		table.sort(var_65_0, function(arg_66_0, arg_66_1)
			if arg_66_0.percent == arg_66_1.percent then
				return arg_66_0.order < arg_66_1.order
			else
				return arg_66_0.percent > arg_66_1.percent
			end
		end)
		var_0_8:fireEvent(var_0_8.activityEventId.ACTIVITY_TASK_LIST_UPDATE, {
			list = var_65_0,
			totaltask = var_65_1
		})
	end, false, nil, "return_sevenday")
end

function var_0_0.get_returnback_sevenday_task_reward(arg_67_0, arg_67_1, arg_67_2)
	hx_print("activity_return_manager:get_returnback_sevenday_task_reward")
	print(arg_67_1)
	var_0_8:getTaskReward(BACKFLOW_BP_ID, arg_67_1, arg_67_2)
end

function var_0_0.is_return_sevendaytask_ongoing(arg_68_0)
	if not var_0_8:getActivityObj(176) then
		return false
	end

	local returnback_conf_data

	if not playermodel.lastreturnbacktime or playermodel.lastreturnbacktime == 0 then
		do return false end

		returnback_conf_data = require("data.returnback_conf_data")
	end

	return time_check_manager:getCurTime() - playermodel.lastreturnbacktime < ((returnback_conf_data.sevenday_timeout or nil) and (returnback_conf_data.sevenday_timeout.value or 14)) * 24 * 3600
end

return var_0_0
