local var_0_0 = class("ChallengeRogueTeamRelicData")

function var_0_0.ExportMethod(arg_1_0)
	return {
		"EventUpdate",
		"EventGetCurrentID",
		"EventGetCurrrentOptionList",
		"GetOptionData",
		"EventGetTriggerType",
		"EventSetTriggerType"
	}
end

function var_0_0.Init(arg_2_0)
	arg_2_0.currentEventID_ = 0
	arg_2_0.currentOptionList_ = {}
	arg_2_0.triggerType_ = 0
end

function var_0_0.EventUpdate(arg_3_0, arg_3_1)
	arg_3_0.currentEventID_ = arg_3_1.event_id

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.opt_list) do
		local var_3_1 = {}

		for iter_3_2, iter_3_3 in ipairs(iter_3_1.item_id_list) do
			table.insert(var_3_1, {
				id = iter_3_3.id,
				rare = iter_3_3.rare
			})
		end

		var_3_0[iter_3_1.opt_id] = {
			isLock = false,
			id = iter_3_1.opt_id,
			itemList = var_3_1,
			stageID = iter_3_1.stage_id or 0,
			jumpRoomID = iter_3_1.jump_battle_room_id or 0
		}
	end

	local var_3_2 = {}

	if arg_3_1.event_id == 0 then
		arg_3_0.currentOptionList_ = var_3_2

		return
	end

	local var_3_3 = RogueTeamEventCfg[arg_3_1.event_id]

	if var_3_3.option_list == "" then
		arg_3_0.currentOptionList_ = var_3_2

		return
	end

	for iter_3_4, iter_3_5 in ipairs(var_3_3.option_list) do
		if var_3_0[iter_3_5] then
			table.insert(var_3_2, var_3_0[iter_3_5])
		else
			table.insert(var_3_2, {
				isLock = true,
				id = iter_3_5
			})
		end
	end

	arg_3_0.currentOptionList_ = var_3_2

	arg_3_0:EventSetTriggerType(arg_3_1.trigger_type)
end

function var_0_0.EventGetCurrentID(arg_4_0)
	return arg_4_0.currentEventID_
end

function var_0_0.EventGetCurrrentOptionList(arg_5_0)
	return arg_5_0.currentOptionList_
end

function var_0_0.GetOptionData(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.currentOptionList_) do
		if iter_6_1.id == arg_6_1 then
			return iter_6_1
		end
	end

	return {
		id = 0
	}
end

function var_0_0.EventSetTriggerType(arg_7_0, arg_7_1)
	arg_7_0.triggerType_ = arg_7_1
end

function var_0_0.EventGetTriggerType(arg_8_0)
	return arg_8_0.triggerType_
end

return var_0_0
