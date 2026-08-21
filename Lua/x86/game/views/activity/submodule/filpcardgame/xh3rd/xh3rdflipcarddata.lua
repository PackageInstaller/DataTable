local var_0_0 = singletonClass("XH3rdFlipCardData")

function var_0_0.OnReceiveFlipCardData(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.activity_id
	local var_1_1 = {}
	local var_1_2 = {}
	local var_1_3 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.clue_list) do
		table.insert(var_1_1, {
			clue_id = iter_1_1.clue_id,
			is_viewed = iter_1_1.is_viewed
		})
	end

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.new_unlock_card) do
		table.insert(var_1_2, iter_1_3)
	end

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.unlock_card) do
		table.insert(var_1_3, iter_1_5)
	end

	for iter_1_6, iter_1_7 in ipairs(FlipCardCfg[var_1_0].normal_card) do
		table.insert(var_1_3, iter_1_7)
	end

	var_0_0.data = {
		activity_id = var_1_0,
		clue_list = var_1_1,
		new_card_list = var_1_2,
		unlock_card_list = var_1_3
	}

	XH3rdFlipCardAction.UpdateClueRedPoint()
end

function var_0_0.ClearNewCardList(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(var_0_0.data.new_card_list) do
		if not table.indexof(var_0_0.data.unlock_card_list, iter_2_1) then
			table.insert(var_0_0.data.unlock_card_list, iter_2_1)
		end
	end

	var_0_0.data.new_card_list = {}
end

function var_0_0.GetUnlockCardList(arg_3_0)
	return var_0_0.data.unlock_card_list
end

function var_0_0.GetNewCardList(arg_4_0)
	return var_0_0.data.new_card_list
end

function var_0_0.CheckClueIsGetted(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(var_0_0.data.clue_list) do
		if iter_5_1.clue_id == arg_5_1 then
			return true
		end
	end

	return false
end

function var_0_0.UpdateClueData(arg_6_0, arg_6_1)
	local var_6_0 = true

	for iter_6_0, iter_6_1 in ipairs(var_0_0.data.clue_list) do
		if iter_6_1.clue_id == arg_6_1 then
			iter_6_1.is_viewed = true
			var_6_0 = false

			break
		end
	end

	if var_6_0 then
		table.insert(var_0_0.data.clue_list, {
			is_viewed = false,
			clue_id = arg_6_1
		})
	end

	XH3rdFlipCardAction.UpdateClueRedPoint()
end

function var_0_0.GetActivityID(arg_7_0)
	return arg_7_0.data.activity_id
end

function var_0_0.CheckClueIsViewed(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(var_0_0.data.clue_list) do
		if iter_8_1.clue_id == arg_8_1 then
			return iter_8_1.is_viewed
		end
	end

	return false
end

function var_0_0.GetUnOpenActivtiyTimeText(arg_9_0, arg_9_1)
	local var_9_0

	for iter_9_0, iter_9_1 in ipairs(ActivityCfg[var_0_0.data.activity_id].sub_activity_list) do
		if ActivityCfg[iter_9_1].activity_template == ActivityTemplateConst.ACTIVITY_FLIP_CARD_UNLOCK then
			local var_9_1 = ActivityData:GetActivityData(iter_9_1)

			if manager.time:GetServerTime() < var_9_1.startTime and iter_9_0 == arg_9_1 + 1 then
				return manager.time:GetLostTimeStr2(var_9_1.startTime, true)
			end
		end
	end
end

function var_0_0.GetClueList(arg_10_0, arg_10_1)
	if var_0_0.data and var_0_0.data.activity_id == arg_10_1 then
		return var_0_0.data.clue_list
	end

	return {}
end

return var_0_0
