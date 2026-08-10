local var_0_0 = {}

manager.net:Bind(68001, function(arg_1_0)
	XH3rdFlipCardData:OnReceiveFlipCardData(arg_1_0)
	manager.notify:Invoke(FLIP_CARD_UPDATE_DATA)
end)

function var_0_0.sendStartFlipCardGameRequest(arg_2_0, arg_2_1)
	local var_2_0 = {
		activity_id = arg_2_1
	}

	manager.net:SendWithLoadingNew(68002, var_2_0, 68003, handler(var_0_0, var_0_0.handleStartFlipCardGameResult))
end

function var_0_0.handleStartFlipCardGameResult(arg_3_0, arg_3_1, arg_3_2)
	if isSuccess(arg_3_1.result) then
		XH3rdFlipCardTool:StartGame()
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_start", "")
	else
		local var_3_0 = XH3rdFlipCardData:GetActivityID()
		local var_3_1 = ItemCfg[FlipCardCfg[var_3_0].cost_id].name

		ShowTips(string.format(GetTips("ACTIVITY_FLIP_CARD_COIN_NOT_ENOUGH"), var_3_1))
	end

	manager.notify:Invoke(FLIP_CARD_START_GAME_RESULT)
end

function var_0_0.sendSettleFlipCardGameRequest(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = {
		activity_id = arg_4_1,
		is_success = arg_4_2,
		use_seconds = arg_4_3,
		pairing_times = arg_4_4
	}

	manager.net:SendWithLoadingNew(68004, var_4_0, 68005, handler(var_0_0, var_0_0.handleSettleFlipCardGameResult))
end

function var_0_0.handleSettleFlipCardGameResult(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2.is_success then
		XH3rdFlipCardAction.UpdateTokenRedPoint()
	end

	manager.notify:Invoke(FLIP_CARD_GAME_RESULT, arg_5_1.clue_id)
end

function var_0_0.sendViewClueRequest(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {
		activity_id = arg_6_1,
		clue_id = arg_6_2
	}

	manager.net:SendWithLoadingNew(68006, var_6_0, 68007, handler(var_0_0, var_0_0.handleViewClueResult))
end

function var_0_0.handleViewClueResult(arg_7_0, arg_7_1, arg_7_2)
	if isSuccess(arg_7_1.result) then
		XH3rdFlipCardData:UpdateClueData(arg_7_2.clue_id)
		manager.notify:Invoke(FLIP_CARD_VIEW_CLUE_RESULT, arg_7_2.clue_id)
	else
		ShowTips(GetTips(arg_7_1.result))
	end
end

function var_0_0.sendViewCardRequest(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {
		activity_id = arg_8_1,
		card_id_list = arg_8_2
	}

	manager.net:SendWithLoadingNew(68008, var_8_0, 68009, handler(var_0_0, var_0_0.handleViewCardResult))
end

function var_0_0.handleViewCardResult(arg_9_0, arg_9_1, arg_9_2)
	if isSuccess(arg_9_1.result) then
		XH3rdFlipCardData:ClearNewCardList()
		manager.notify:Invoke(FLIP_CARD_VIEW_CARD_RESULT)
	else
		ShowTips(GetTips(arg_9_1.result))
	end
end

function var_0_0.InitRedPointKey(arg_10_0, arg_10_1)
	var_0_0.mainActivityId = arg_10_1
	var_0_0.hasEnterGame = false

	if FlipCardCfg[arg_10_1] then
		local var_10_0 = ActivityCfg[arg_10_1].sub_activity_list[#ActivityCfg[arg_10_1].sub_activity_list]
		local var_10_1 = string.format
		local var_10_2 = RedPointConst.ACTIVITY_2_2_FLIP_CARD
		local var_10_3 = var_10_1("%s_%s", var_10_2, arg_10_1)
		local var_10_4 = var_10_1("%s_%s_subTask", var_10_2, arg_10_1)
		local var_10_5 = var_10_1("%s_%s_mainTask", var_10_2, var_10_0)
		local var_10_6 = var_10_1("%s_%s_challenge", var_10_2, arg_10_1)
		local var_10_7 = var_10_1("%s_%s_token", var_10_2, arg_10_1)
		local var_10_8 = var_10_1("%s_%s_clue", var_10_2, arg_10_1)
		local var_10_9 = var_10_1("%s_%s_canGetClue", var_10_2, arg_10_1)

		manager.redPoint:addGroup(var_10_6, {
			var_10_5,
			var_10_7,
			var_10_8,
			var_10_9
		})
		manager.redPoint:addGroup(var_10_3, {
			var_10_4,
			var_10_6
		})

		local var_10_10 = FlipCardCfg[arg_10_1].details
		local var_10_11 = {}

		for iter_10_0, iter_10_1 in pairs(var_10_10) do
			local var_10_12 = string.format("%s_%s_%s_clue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, arg_10_1, iter_10_1)

			var_10_11[#var_10_11 + 1] = var_10_12
		end

		manager.redPoint:addGroup(string.format("%s_%s_clue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, arg_10_1), var_10_11)
		manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function()
			var_0_0.UpdateRedPoint()
		end)
		manager.notify:RegistListener(CURRENCY_UPDATE, function()
			var_0_0.UpdateTokenRedPoint()
		end)
		var_0_0.UpdateSubTaskRedPoint()
		var_0_0.UpdateMainTaskRedPoint()
		var_0_0.UpdateTokenRedPoint()
	end
end

function var_0_0.UpdateRedPoint()
	var_0_0.UpdateSubTaskRedPoint()
	var_0_0.UpdateMainTaskRedPoint()
end

function var_0_0.UpdateSubTaskRedPoint()
	local var_14_0 = var_0_0.mainActivityId
	local var_14_1 = ActivityCfg[var_14_0].sub_activity_list[1]
	local var_14_2 = TaskData2:GetActivityTaskSortList(var_14_1)

	for iter_14_0, iter_14_1 in ipairs(var_14_2) do
		local var_14_3 = AssignmentCfg[iter_14_1.id]

		if iter_14_1.progress >= var_14_3.need and iter_14_1.complete_flag < 1 then
			manager.redPoint:setTip(string.format("%s_%s_subTask", RedPointConst.ACTIVITY_2_2_FLIP_CARD, var_14_0), 1)

			return
		end
	end

	manager.redPoint:setTip(string.format("%s_%s_subTask", RedPointConst.ACTIVITY_2_2_FLIP_CARD, var_14_0), 0)
end

function var_0_0.UpdateClueRedPoint()
	local var_15_0 = var_0_0.mainActivityId

	if FlipCardCfg[var_15_0] then
		manager.redPoint:setTip(string.format("%s_%s_canGetClue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, var_15_0), 0)

		local var_15_1 = #XH3rdFlipCardData.data.clue_list
		local var_15_2 = 1
		local var_15_3 = 0

		if var_15_1 < 2 then
			var_15_2 = 1
			var_15_3 = 2
		elseif var_15_1 < 4 then
			var_15_2 = 2

			if ActivityData:GetActivityIsOpen(ActivityCfg[var_0_0.mainActivityId].sub_activity_list[var_15_2 + 1]) then
				var_15_3 = 4
			end
		end

		local var_15_4 = FlipCardCfg[var_15_0].details

		for iter_15_0, iter_15_1 in ipairs(var_15_4) do
			local var_15_5 = XH3rdFlipCardData:CheckClueIsGetted(iter_15_1)
			local var_15_6 = XH3rdFlipCardData:CheckClueIsViewed(iter_15_1)

			if var_15_5 and not var_15_6 then
				manager.redPoint:setTip(string.format("%s_%s_%s_clue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, var_15_0, iter_15_1), 1)
			else
				manager.redPoint:setTip(string.format("%s_%s_%s_clue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, var_15_0, iter_15_1), 0)
			end

			if not var_15_5 and ActivityData:GetActivityIsOpen(ActivityCfg[var_0_0.mainActivityId].sub_activity_list[var_15_2]) and iter_15_0 <= var_15_3 then
				manager.redPoint:setTip(string.format("%s_%s_canGetClue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, var_15_0), 1)
			end
		end
	end
end

function var_0_0.UpdateMainTaskRedPoint()
	local var_16_0 = var_0_0.mainActivityId
	local var_16_1 = ActivityCfg[var_16_0].sub_activity_list[#ActivityCfg[var_16_0].sub_activity_list]
	local var_16_2 = TaskData2:GetActivityTaskSortList(var_16_1)

	for iter_16_0, iter_16_1 in ipairs(var_16_2) do
		local var_16_3 = AssignmentCfg[iter_16_1.id]

		if iter_16_1.progress >= var_16_3.need and iter_16_1.complete_flag < 1 then
			manager.redPoint:setTip(string.format("%s_%s_mainTask", RedPointConst.ACTIVITY_2_2_FLIP_CARD, var_16_1), 1)

			return
		end
	end

	manager.redPoint:setTip(string.format("%s_%s_mainTask", RedPointConst.ACTIVITY_2_2_FLIP_CARD, var_16_1), 0)
end

function var_0_0.UpdateTokenRedPoint()
	local var_17_0 = var_0_0.mainActivityId
	local var_17_1 = FlipCardCfg[var_17_0].cost_id

	if ItemTools.getItemNum(var_17_1) > 0 and not var_0_0.hasEnterGame then
		manager.redPoint:setTip(string.format("%s_%s_token", RedPointConst.ACTIVITY_2_2_FLIP_CARD, var_17_0), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s_token", RedPointConst.ACTIVITY_2_2_FLIP_CARD, var_17_0), 0)
	end
end

return var_0_0
