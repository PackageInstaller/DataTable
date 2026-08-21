local var_0_0 = singletonClass("CanteenEntrustData")
local var_0_1
local var_0_2 = {}

function var_0_0.InitSimpleCanteenEntrustData(arg_1_0, arg_1_1)
	arg_1_0:Init(arg_1_1.canteens[1].entrust)
end

function var_0_0.InitDetailCanteenEntrustData(arg_2_0, arg_2_1)
	arg_2_0:Init(arg_2_1.canteens[1].entrust)
	arg_2_0:InitTaskTimeLevel()
end

function var_0_0.DisposeDetailData(arg_3_0)
	saveData("Dorm", "taskTimeLevel", var_0_2)
end

function var_0_0.Init(arg_4_0, arg_4_1)
	var_0_1 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		arg_4_0:InitEntrustData(iter_4_1)
	end

	local var_4_0 = #GameSetting.dorm_canteen_task_unlock.value

	for iter_4_2 = 1, var_4_0 do
		if not var_0_1[iter_4_2] then
			local var_4_1 = {
				id = -1,
				pos = iter_4_2
			}

			arg_4_0:InitEntrustData(var_4_1)
		end
	end
end

function var_0_0.InitTaskTimeLevel(arg_5_0)
	var_0_2 = {}

	local var_5_0 = getData("Dorm", "taskTimeLevel")

	if not var_5_0 or type(var_5_0) ~= "table" or tostring(var_5_0) == "userdata: NULL" then
		var_5_0 = {}
		var_5_0 = {
			1,
			1,
			1,
			1
		}
	end

	var_0_2 = var_5_0
end

function var_0_0.InitEntrustData(arg_6_0, arg_6_1)
	if not var_0_1 then
		var_0_1 = {}
	end

	local var_6_0 = {
		pos = arg_6_1.pos,
		id = arg_6_1.id,
		hero_list = {},
		tags = {}
	}

	if var_6_0.id > 0 then
		if arg_6_1.hero_list then
			for iter_6_0, iter_6_1 in ipairs(arg_6_1.hero_list) do
				table.insert(var_6_0.hero_list, iter_6_1)
			end
		end

		for iter_6_2, iter_6_3 in ipairs(arg_6_1.tags) do
			local var_6_1 = {
				type = iter_6_3.type,
				tag = iter_6_3.tag
			}

			table.insert(var_6_0.tags, var_6_1)
		end

		var_6_0.num_max = arg_6_1.num_max
		var_6_0.refresh_times = arg_6_1.refresh_times
		var_6_0.start_time = arg_6_1.start_time

		if arg_6_1.duration == 0 then
			var_6_0.timeLevel = 0
		else
			for iter_6_4, iter_6_5 in ipairs(BackHomeCanteenTaskCfg[arg_6_1.id].time) do
				if iter_6_5[1] == arg_6_1.duration then
					var_6_0.timeLevel = iter_6_4
				end
			end
		end
	end

	var_0_1[arg_6_1.pos] = var_6_0
end

function var_0_0.CalcEntrustLastTime(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.id
	local var_7_1 = arg_7_1.start_time
	local var_7_2 = arg_7_1.timeLevel
	local var_7_3 = var_7_1 + BackHomeCanteenTaskCfg[var_7_0].time[var_7_2][1] * 60 - manager.time:GetServerTime()

	if var_7_3 > 0 then
		arg_7_1.lastTime = var_7_3

		return manager.time:DescCDTime(var_7_3)
	else
		arg_7_1.lastTime = 0

		return 0
	end
end

function var_0_0.GetEntrustLastTime(arg_8_0, arg_8_1)
	local var_8_0 = var_0_1[arg_8_1]

	if var_8_0 and var_0_0:IsEntrustStarted(var_8_0) then
		return var_0_0:CalcEntrustLastTime(var_8_0)
	end
end

function var_0_0.GetEntrustList(arg_9_0)
	return var_0_1
end

function var_0_0.GetEntrustByPos(arg_10_0, arg_10_1)
	return var_0_1[arg_10_1]
end

function var_0_0.CheckHasTimeOverEntrust(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(var_0_1) do
		if iter_11_1.id > 0 and #iter_11_1.hero_list > 0 and var_0_0:CalcEntrustLastTime(iter_11_1) == 0 then
			table.insert(var_11_0, iter_11_0)
		end
	end

	return var_11_0
end

function var_0_0.CheckTimeOverEntrustNum(arg_12_0)
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in pairs(var_0_1) do
		if iter_12_1.id > 0 and #iter_12_1.hero_list > 0 and var_0_0:CalcEntrustLastTime(iter_12_1) == 0 then
			var_12_0 = var_12_0 + 1
		end
	end

	return var_12_0
end

local var_0_3

function var_0_0.GetDispatchCharacterList(arg_13_0)
	if not var_0_3 then
		var_0_3 = {}
	end

	return var_0_3
end

function var_0_0.ClearDispatchCharacterList(arg_14_0)
	var_0_3 = {}
end

local var_0_4

function var_0_0.SetCurDispatchTask(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if not var_0_4 then
		var_0_4 = {}
	end

	var_0_4.id = arg_15_1
	var_0_4.pos = arg_15_2
	var_0_4.timeLevel = arg_15_3
end

function var_0_0.InsertToDispatchCharacterList(arg_16_0, arg_16_1)
	local var_16_0 = BackHomeCanteenTaskCfg[var_0_4.id].need[2]

	if not var_0_3 then
		var_0_3 = {}
	end

	local var_16_1 = DormData:GetHeroArchiveID(arg_16_1)

	for iter_16_0, iter_16_1 in ipairs(var_0_3) do
		if DormData:GetHeroArchiveID(iter_16_1) == var_16_1 then
			var_0_3[iter_16_0] = iter_16_1

			return true, true
		end
	end

	if var_16_0 > #var_0_3 then
		table.insert(var_0_3, arg_16_1)

		return true, false
	end

	return false
end

function var_0_0.SetDispatchCharacterList(arg_17_0, arg_17_1)
	var_0_3 = arg_17_1
end

function var_0_0.RemoveDispatchCharacterList(arg_18_0, arg_18_1)
	if var_0_3 then
		for iter_18_0 = 1, #var_0_3 do
			if var_0_3[iter_18_0] == arg_18_1 then
				table.remove(var_0_3, iter_18_0)

				return
			end
		end

		error("没找到需要去处的选择角色")
	end
end

function var_0_0.CheckDispatchCharacterList(arg_19_0, arg_19_1)
	if var_0_3 then
		for iter_19_0, iter_19_1 in ipairs(var_0_3) do
			if iter_19_1 == arg_19_1 then
				return true
			end
		end

		return false
	end
end

function var_0_0.CheckDispatchCharacterArchiveList(arg_20_0, arg_20_1)
	local var_20_0 = HeroRecordCfg.get_id_list_by_hero_id[arg_20_1][1]

	if var_0_3 then
		for iter_20_0, iter_20_1 in ipairs(var_0_3) do
			if HeroRecordCfg.get_id_list_by_hero_id[iter_20_1][1] == var_20_0 then
				return true
			end
		end

		return false
	end
end

function var_0_0.CheckHasChooseEntrustCharacter(arg_21_0, arg_21_1)
	local var_21_0 = HeroRecordCfg.get_id_list_by_hero_id[arg_21_1][1]

	for iter_21_0, iter_21_1 in pairs(var_0_1) do
		if iter_21_1.hero_list then
			for iter_21_2, iter_21_3 in ipairs(iter_21_1.hero_list) do
				if var_21_0 == HeroRecordCfg.get_id_list_by_hero_id[iter_21_3][1] then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.GetCurDispatchTask(arg_22_0)
	return var_0_4
end

function var_0_0.CalculateEntrustSuccess(arg_23_0)
	if #var_0_3 == 0 then
		return 0
	end

	local var_23_0 = var_0_1[var_0_4.pos].tags
	local var_23_1 = 0

	for iter_23_0, iter_23_1 in ipairs(var_0_3) do
		var_23_1 = var_23_1 + arg_23_0:CalHeroMatchNum(iter_23_1, var_23_0)
	end

	local var_23_2 = BackHomeCanteenTaskCfg[var_0_4.id].base_success
	local var_23_3 = var_23_1 * BackHomeCanteenTaskCfg[var_0_4.id].tag_success

	for iter_23_2, iter_23_3 in ipairs(var_0_3) do
		var_23_3 = var_23_3 + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.EntrustExternSucceedAdd, iter_23_3)
	end

	local var_23_4 = var_23_2 + var_23_3

	if var_23_4 > 100 then
		var_23_4 = 100
	end

	return var_23_4
end

function var_0_0.CalHeroMatchNum(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = 0

	for iter_24_0, iter_24_1 in ipairs(arg_24_2) do
		local var_24_1 = iter_24_1.type

		if var_24_1 == 1 then
			if CharactorParamCfg[arg_24_1].RangeType == iter_24_1.tag then
				var_24_0 = var_24_0 + 1
			end
		elseif var_24_1 == 2 then
			if HeroCfg[arg_24_1].race == iter_24_1.tag then
				var_24_0 = var_24_0 + 1
			end
		elseif var_24_1 == 3 then
			if HeroCfg[arg_24_1].ATK_attribute[1] == iter_24_1.tag then
				var_24_0 = var_24_0 + 1
			end
		elseif var_24_1 == 4 and HeroCfg[arg_24_1].mechanism_type[1] == iter_24_1.tag then
			var_24_0 = var_24_0 + 1
		end
	end

	return var_24_0
end

function var_0_0.ConfirmEntrustList(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1

	if var_25_0 == nil then
		var_25_0 = DormData:GetCurrectSceneID()
	end

	if var_25_0 then
		local var_25_1 = {
			sceneID = var_25_0,
			pos = var_0_4.pos,
			heroList = var_0_3,
			timeLevel = var_0_4.timeLevel
		}

		CanteenAction:SendTaskDispatchInfo(var_25_1)
	end
end

function var_0_0.CancelEntrust(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_2

	if var_26_0 == nil then
		var_26_0 = DormData:GetCurrectSceneID()
	end

	if var_26_0 then
		local var_26_1 = {
			sceneID = var_26_0,
			pos = arg_26_1
		}

		CanteenAction:SendTaskDispatchInfo(var_26_1)
	end
end

function var_0_0.ConfirmEntrustListCallBack(arg_27_0, arg_27_1)
	if arg_27_1.hero_list ~= nil then
		for iter_27_0, iter_27_1 in ipairs(arg_27_1.hero_list) do
			table.insert(var_0_1[arg_27_1.pos].hero_list, iter_27_1)

			local var_27_0 = DormData:GetHeroTemplateInfo(iter_27_1)

			var_27_0:SetCurHeroID(iter_27_1)
			var_27_0:GoToCanteen()
		end

		var_0_1[arg_27_1.pos].start_time = manager.time:GetServerTime()
		var_0_1[arg_27_1.pos].timeLevel = CanteenTools:GetIndexByTaskDuring(var_0_1[arg_27_1.pos].id, arg_27_1.duration)
	else
		for iter_27_2, iter_27_3 in ipairs(var_0_1[arg_27_1.pos].hero_list) do
			local var_27_1 = DormData:GetHeroTemplateInfo(iter_27_3)

			var_27_1:SetCurHeroID(iter_27_3)
			var_27_1:BackToDorm()
		end

		var_0_1[arg_27_1.pos].hero_list = {}
		var_0_1[arg_27_1.pos].start_time = nil
		var_0_1[arg_27_1.pos].timeLevel = 0
	end

	manager.notify:Invoke(CANTEEN_DISPATCH_ENTRUST_SUCCESS, arg_27_1.pos)

	var_0_3 = {}
	var_0_4 = {}
end

function var_0_0.RefreshEntrustData(arg_28_0, arg_28_1, arg_28_2)
	if var_0_1[arg_28_1].refresh_times >= DormConst.DISPATCH_REFRESH_TIME then
		return
	end

	local var_28_0 = arg_28_2

	if var_28_0 == nil then
		var_28_0 = DormData:GetCurrectSceneID()
	end

	CanteenAction:RefreshEntrust(var_28_0, arg_28_1)
end

function var_0_0.EntrustFinish(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0:CalEntrustAward(arg_29_1)

	if arg_29_2 then
		for iter_29_0, iter_29_1 in ipairs(arg_29_2) do
			arg_29_0:InitEntrustData(iter_29_1)
		end
	end

	manager.notify:Invoke(CANTEEN_DISPATCH_REWARD_VIEW)
	DormRedPointTools:ConsumeNotification(RedPointConst.CANTEEN_DISPATCH_FINISHED)
	DormRedPointTools:UpdateCanteenNotify()
end

local var_0_5

function var_0_0.CalEntrustAward(arg_30_0, arg_30_1)
	var_0_5 = {}

	if arg_30_1 then
		for iter_30_0, iter_30_1 in ipairs(arg_30_1) do
			local var_30_0 = {
				id = iter_30_1.entrustID,
				award = iter_30_1.rewardList,
				extra_reward = iter_30_1.extra_reward
			}

			table.insert(var_0_5, var_30_0)
		end
	end
end

function var_0_0.GetEntrustFinishAwardList(arg_31_0)
	return var_0_5
end

function var_0_0.RefreshDailyZero(arg_32_0)
	if var_0_1 then
		for iter_32_0, iter_32_1 in pairs(var_0_1) do
			if iter_32_1.refresh_times then
				iter_32_1.refresh_times = 0
			end
		end
	end
end

function var_0_0.GetUiPosByEntrustPos(arg_33_0, arg_33_1)
	for iter_33_0, iter_33_1 in ipairs(GameDisplayCfg.canteen_task_id_pos.value) do
		if iter_33_1[2] == arg_33_1 then
			return iter_33_1[1]
		end
	end
end

function var_0_0.NoEntrustDispatched()
	for iter_34_0, iter_34_1 in pairs(var_0_1) do
		if var_0_0:IsEntrustStarted(iter_34_1) then
			return false
		end
	end

	return true
end

function var_0_0.NoAnyEntrustDispatched()
	for iter_35_0, iter_35_1 in pairs(var_0_1) do
		if not var_0_0:IsEntrustStarted(iter_35_1) and iter_35_1.id ~= -1 then
			return true
		end
	end

	return false
end

function var_0_0.AnyEntrustFinished()
	for iter_36_0, iter_36_1 in pairs(var_0_1) do
		if var_0_0:IsEntrustStarted(iter_36_1) and var_0_0:CalcEntrustLastTime(iter_36_1) == 0 then
			return true
		end
	end

	return false
end

function var_0_0.EntrustFinishList()
	local var_37_0 = {}

	for iter_37_0, iter_37_1 in pairs(var_0_1) do
		if var_0_0:IsEntrustStarted(iter_37_1) and var_0_0:CalcEntrustLastTime(iter_37_1) == 0 then
			table.insert(var_37_0, iter_37_0)
		end
	end

	return var_37_0
end

function var_0_0.IsEntrustStarted(arg_38_0, arg_38_1)
	return arg_38_1.id ~= -1 and arg_38_1.start_time and arg_38_1.start_time > 0
end

function var_0_0.SetTaskTimeLevel(arg_39_0, arg_39_1, arg_39_2)
	if var_0_2 then
		var_0_2[arg_39_1] = arg_39_2
	end
end

function var_0_0.GetTaskTimeLevel(arg_40_0, arg_40_1)
	if var_0_2 then
		if var_0_2[arg_40_1] and tostring(var_0_2[arg_40_1]) ~= "userdata: NULL" then
			return tonumber(var_0_2[arg_40_1])
		else
			return 1
		end
	else
		return 1
	end
end

return var_0_0
