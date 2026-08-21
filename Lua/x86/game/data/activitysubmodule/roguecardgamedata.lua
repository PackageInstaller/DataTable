local var_0_0 = singletonClass("RogueCardGameData")
local var_0_1 = 0
local var_0_2 = 0
local var_0_3 = {}
local var_0_4 = 0
local var_0_5 = {}
local var_0_6 = {}
local var_0_7 = {}
local var_0_8 = {}
local var_0_9 = {}
local var_0_10 = {}
local var_0_11 = {}
local var_0_12 = {}
local var_0_13 = {}
local var_0_14 = {}
local var_0_15 = {}
local var_0_16 = 0
local var_0_17 = 0
local var_0_18 = 0
local var_0_19 = 0
local var_0_20 = {}
local var_0_21 = {}
local var_0_22 = {}
local var_0_23 = 0
local var_0_24 = 1
local var_0_25 = 0
local var_0_26 = 0
local var_0_27 = {}
local var_0_28 = 1
local var_0_29 = 0
local var_0_30 = {}
local var_0_31 = {}
local var_0_32
local var_0_33
local var_0_34

function var_0_0.Init(arg_1_0)
	var_0_32 = nil
	var_0_33 = nil
	var_0_34 = nil
end

function var_0_0.UpdateData(arg_2_0, arg_2_1)
	var_0_20 = arg_2_1.story
	var_0_1 = var_0_20.thread_id
	var_0_2 = var_0_20.thread_state
	var_0_4 = var_0_20.battle_id
	var_0_3 = cleanProtoTable(var_0_20.finish_thread_list)
	var_0_5 = cleanProtoTable(var_0_20.like_thread_list)
	var_0_6 = cleanProtoTable(var_0_20.post_thread_list)
	var_0_7 = cleanProtoTable(var_0_20.view_thread_list)
	var_0_8 = arg_2_1.gather_card_list

	var_0_0:SeparateList()

	var_0_12 = cleanProtoTable(arg_2_1.gather_enhance_list)
	var_0_13 = cleanProtoTable(arg_2_1.gather_weal_woe_list)
	var_0_22 = arg_2_1.challenge
	var_0_23 = var_0_22.deck
	var_0_24 = var_0_22.diff
	var_0_25 = var_0_22.state
	var_0_26 = var_0_22.battle_id
	var_0_27 = cleanProtoTable(var_0_22.status_list)
	var_0_14 = {}
	var_0_15 = {}
	var_0_30 = {}
	var_0_31 = {}

	var_0_0:UpdateLocalNum()
	var_0_0:UpdatePostInfo()
	var_0_0:UpdatePointRed()
end

function var_0_0.UpdatePostInfo(arg_3_0)
	var_0_21 = {}

	for iter_3_0, iter_3_1 in ipairs(RogueCardPostingCfg.all) do
		local var_3_0 = getData("RogueCardGameForum", "post_info_state" .. iter_3_1)
		local var_3_1 = 0

		if var_3_0 and var_3_0 >= 0 then
			var_3_1 = var_3_0
		else
			var_3_1 = RogueCardGameTools.GetIsFinishPreById(iter_3_1) and 1 or 0
		end

		local var_3_2 = {
			post_id = iter_3_1,
			view_state = RogueCardGameTools.IsViewPost(iter_3_1),
			complete_state = var_3_1
		}

		var_0_21[iter_3_1] = var_3_2
	end
end

function var_0_0.GetPostInfoById(arg_4_0, arg_4_1)
	return var_0_21[arg_4_1]
end

function var_0_0.SetPostStateInfo(arg_5_0, arg_5_1, arg_5_2)
	var_0_21[arg_5_1].complete_state = arg_5_2

	saveData("RogueCardGameForum", "post_info_state" .. arg_5_1, var_0_21[arg_5_1].complete_state)
end

function var_0_0.GetFinishThreadList(arg_6_0)
	return var_0_3
end

function var_0_0.UpdateLocalNum(arg_7_0)
	var_0_16 = GameSetting.rogue_card_account_init_data.value[3]
	var_0_17 = GameSetting.rogue_card_account_init_data.value[2]
	var_0_19 = GameSetting.rogue_card_account_init_data.value[1]
	var_0_18 = 0

	for iter_7_0, iter_7_1 in ipairs(var_0_3) do
		if iter_7_1 ~= 107 then
			local var_7_0 = RogueCardPostingCfg[iter_7_1]

			var_0_19 = var_0_19 + var_7_0.fans

			local var_7_1 = RogueCardPostingCfg.get_id_list_by_pre_id[iter_7_1]

			for iter_7_2, iter_7_3 in ipairs(var_7_1) do
				if RogueCardPostingCfg[iter_7_3].type == 2 then
					local var_7_2 = RogueCardPostingCfg[iter_7_3].likes

					var_0_16 = var_0_16 + var_7_2
				end
			end

			local var_7_3 = RogueCardPostingCfg.get_id_list_by_pre_id[iter_7_1]

			for iter_7_4, iter_7_5 in ipairs(var_7_3) do
				if RogueCardPostingCfg[iter_7_5].type == 2 then
					local var_7_4 = RogueCardPostingCfg[iter_7_5].views

					var_0_17 = var_0_17 + var_7_4
				end
			end

			local var_7_5 = RogueCardPostingCfg.get_id_list_by_pre_id[iter_7_1]

			for iter_7_6, iter_7_7 in ipairs(var_7_5) do
				if RogueCardPostingCfg[iter_7_7].type == 2 then
					local var_7_6 = RogueCardPostingCfg[iter_7_7].comments

					var_0_18 = var_0_18 + #var_7_6

					for iter_7_8, iter_7_9 in ipairs(var_7_6) do
						local var_7_7 = #RogueCardCommentCfg[iter_7_9].comment_sub or 0

						var_0_18 = var_0_18 + var_7_7
					end
				end
			end
		end
	end
end

function var_0_0.SaveStageData(arg_8_0, arg_8_1, arg_8_2)
	var_0_14[arg_8_2] = arg_8_1
end

function var_0_0.SaveRollbackData(arg_9_0, arg_9_1, arg_9_2)
	var_0_15[arg_9_2] = arg_9_1
end

function var_0_0.GetViewThreadList(arg_10_0)
	return var_0_7
end

function var_0_0.GetLikeNum(arg_11_0)
	return var_0_16 or 0
end

function var_0_0.GetViewsNum(arg_12_0)
	return var_0_17 or 0
end

function var_0_0.GetFansNum(arg_13_0)
	return var_0_19 or 0
end

function var_0_0.GetTalksNum(arg_14_0)
	return var_0_18 or 0
end

function var_0_0.GetThreadId(arg_15_0)
	return var_0_1
end

function var_0_0.GetThreadState(arg_16_0)
	return var_0_2
end

function var_0_0.GetSaveData(arg_17_0, arg_17_1)
	if var_0_14[arg_17_1] then
		return var_0_14[arg_17_1]
	end

	return nil
end

function var_0_0.GetRollbackData(arg_18_0, arg_18_1)
	if var_0_15[arg_18_1] then
		return var_0_15[arg_18_1]
	end

	return nil
end

function var_0_0.SetBattleId(arg_19_0, arg_19_1)
	var_0_4 = arg_19_1
end

function var_0_0.GetBattleId(arg_20_0)
	return var_0_4
end

function var_0_0.SetChallengeBattleId(arg_21_0, arg_21_1)
	var_0_26 = arg_21_1
end

function var_0_0.GetChallengeBattleId(arg_22_0)
	return var_0_26
end

function var_0_0.GetDeck(arg_23_0)
	return var_0_23
end

function var_0_0.GetDiff(arg_24_0)
	return var_0_24
end

function var_0_0.GetChallengeState(arg_25_0)
	return var_0_25
end

function var_0_0.GetStatusList(arg_26_0)
	return var_0_27
end

function var_0_0.SeparateList(arg_27_0)
	var_0_10 = {}
	var_0_11 = {}

	for iter_27_0, iter_27_1 in ipairs(var_0_8) do
		local var_27_0 = RogueCardItemCfg[iter_27_1]

		if var_27_0.type == 1 then
			table.insert(var_0_11, iter_27_1)
		elseif var_27_0.type == 2 then
			table.insert(var_0_10, iter_27_1)
		elseif var_27_0.type == 3 then
			table.insert(var_0_9, iter_27_1)
		end
	end
end

function var_0_0.GetWhiteCardList(arg_28_0)
	return var_0_11
end

function var_0_0.GetBlackCardList(arg_29_0)
	return var_0_10
end

function var_0_0.GetJokerCardList(arg_30_0)
	return var_0_9
end

function var_0_0.GetEnhanceList(arg_31_0)
	return var_0_12
end

function var_0_0.GetWealWoeList(arg_32_0)
	return var_0_13
end

function var_0_0.GetGatherCardList(arg_33_0)
	return var_0_8
end

function var_0_0.SetSettleResult(arg_34_0, arg_34_1)
	var_0_28 = arg_34_1
end

function var_0_0.GetSettleResult(arg_35_0)
	return var_0_28
end

function var_0_0.SetSaveStageID(arg_36_0, arg_36_1)
	var_0_29 = arg_36_1
end

function var_0_0.GetSaveStageID(arg_37_0)
	return var_0_29
end

function var_0_0.GetLikesThreadList(arg_38_0)
	return var_0_5
end

function var_0_0.AddLikePost(arg_39_0, arg_39_1)
	if not table.indexof(var_0_5, arg_39_1) then
		table.insert(var_0_5, arg_39_1)
	else
		local var_39_0 = table.indexof(var_0_5, arg_39_1)

		table.remove(var_0_5, var_39_0)
	end
end

function var_0_0.SaveSettleData(arg_40_0, arg_40_1)
	var_0_30 = arg_40_1
end

function var_0_0.GetSettleData(arg_41_0)
	return var_0_30
end

function var_0_0.SaveAllData(arg_42_0, arg_42_1)
	var_0_31 = arg_42_1
end

function var_0_0.GetAllData(arg_43_0)
	return var_0_31
end

function var_0_0.InitRedPointGroup(arg_44_0)
	local var_44_0 = RedPointConst.ACTIVITY_ROGUECARD_5_0 .. ActivityConst.ACTIVITY_ROGUECARD_5_0
	local var_44_1 = RedPointConst.ACTIVITY_ROGUECARD_RESIDENT_TASK .. ActivityConst.ACTIVITY_ROGUECARD_5_0
	local var_44_2 = RedPointConst.ACTIVITY_ROGUECARD_LIMIT_TASK .. ActivityConst.ACTIVITY_ROGUECARD_TASK
	local var_44_3 = ActivityCfg[ActivityConst.ACTIVITY_ROGUECARD_TASK]
	local var_44_4 = {}

	for iter_44_0, iter_44_1 in pairs(var_44_3.sub_activity_list) do
		local var_44_5 = RedPointConst.ACTIVITY_ROGUECARD_LIMIT_TASK_TAG .. iter_44_1

		table.insert(var_44_4, var_44_5)
	end

	manager.redPoint:addGroup(var_44_2, var_44_4)

	local var_44_6 = {}

	for iter_44_2, iter_44_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_ROGUECARD_TASK]) do
		local var_44_7 = RedPointConst.ACTIVITY_ROGUECARD_LIMIT_TASK_POINT .. iter_44_3

		table.insert(var_44_6, var_44_7)
	end

	manager.redPoint:addGroup(var_44_2, var_44_6)

	local var_44_8 = RedPointConst.ACTIVITY_ROGUECARD_SKIN_DLC_GIFT .. ActivityConst.ACTIVITY_ROGUECARD_SKIN

	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function()
		arg_44_0:UpdateLimitedTaskRedPoint()
	end)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, function()
		arg_44_0:UpdatePointRed()
	end)
	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, function()
		arg_44_0:UpdatePointRed()
	end)
	manager.redPoint:addGroup(RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED, {
		RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_JOKER,
		RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_WUCHANG,
		RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_WEAL,
		RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_ENHANCE
	})
	manager.redPoint:addGroup(var_44_0, {
		var_44_1,
		var_44_2,
		var_44_8,
		RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED
	})
end

function var_0_0.UpdateTaskRedPoint(arg_48_0)
	arg_48_0:UpdatePointRed()
end

function var_0_0.UpdatePointRed(arg_49_0)
	local var_49_0 = false
	local var_49_1 = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_ROGUECARD_5_0] or {}

	for iter_49_0, iter_49_1 in pairs(var_49_1) do
		local var_49_2 = TaskData2:GetTaskProgress(iter_49_1)
		local var_49_3 = AssignmentCfg[iter_49_1]

		if not TaskData2:GetTaskComplete(iter_49_1) and var_49_2 >= var_49_3.need then
			var_49_0 = true

			break
		end
	end

	local var_49_4 = RedPointConst.ACTIVITY_ROGUECARD_RESIDENT_TASK .. ActivityConst.ACTIVITY_ROGUECARD_5_0

	if var_49_0 then
		manager.redPoint:setTip(var_49_4, 1)
	else
		manager.redPoint:setTip(var_49_4, 0)
	end

	local var_49_5 = ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_ROGUECARD_SKIN)
	local var_49_6 = ActivityConst.ACTIVITY_ROGUECARD_SKIN

	for iter_49_2, iter_49_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[var_49_6]) do
		local var_49_7 = RedPointConst.ACTIVITY_ROGUECARD_SKIN_DLC_GIFT .. var_49_6

		if var_49_5 then
			local var_49_8 = TaskData2:GetTaskProgress(iter_49_3)
			local var_49_9 = AssignmentCfg[iter_49_3]

			if TaskData2:GetTaskComplete(iter_49_3) then
				manager.redPoint:setTip(var_49_7, 0)
			elseif var_49_8 >= var_49_9.need then
				manager.redPoint:setTip(var_49_7, 1)

				break
			else
				manager.redPoint:setTip(var_49_7, 0)
			end
		else
			manager.redPoint:setTip(var_49_7, 0)
		end
	end

	arg_49_0:UpdateLimitedTaskRedPoint()
	arg_49_0:UpdateIllustratedRedPoint()
end

function var_0_0.UpdateLimitedTaskRedPoint(arg_50_0)
	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_ROGUECARD_TASK) then
		local var_50_0 = ActivityCfg[ActivityConst.ACTIVITY_ROGUECARD_TASK].sub_activity_list

		for iter_50_0, iter_50_1 in pairs(var_50_0) do
			local var_50_1 = ActivityData:GetActivityIsOpen(iter_50_1)

			for iter_50_2, iter_50_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[iter_50_1]) do
				local var_50_2 = RedPointConst.ACTIVITY_ROGUECARD_LIMIT_TASK_TAG .. iter_50_1

				if var_50_1 then
					local var_50_3 = TaskData2:GetTaskProgress(iter_50_3)
					local var_50_4 = AssignmentCfg[iter_50_3]

					if TaskData2:GetTaskComplete(iter_50_3) then
						manager.redPoint:setTip(var_50_2, 0)
					elseif var_50_3 >= var_50_4.need then
						manager.redPoint:setTip(var_50_2, 1)

						break
					else
						manager.redPoint:setTip(var_50_2, 0)
					end
				else
					manager.redPoint:setTip(var_50_2, 0)
				end
			end
		end

		for iter_50_4, iter_50_5 in pairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_ROGUECARD_TASK]) do
			local var_50_5 = 0
			local var_50_6 = TaskData2:GetTaskProgress(iter_50_5)
			local var_50_7 = AssignmentCfg[iter_50_5]

			if not TaskData2:GetTaskComplete(iter_50_5) and var_50_6 >= var_50_7.need then
				var_50_5 = 1
			end

			manager.redPoint:setTip(RedPointConst.ACTIVITY_ROGUECARD_LIMIT_TASK_POINT .. iter_50_5, var_50_5)
		end
	end
end

function var_0_0.UpdateIllustratedRedPoint(arg_51_0)
	arg_51_0:UpdateIllustratedRedPoint_JockerWuchang()
	arg_51_0:UpdateIllustratedRedPoint_Weal()
	arg_51_0:UpdateIllustratedRedPoint_Enhance()
end

function var_0_0.UpdateIllustratedRedPoint_JockerWuchang(arg_52_0)
	if var_0_32 == nil then
		var_0_32 = getData("ROGUE_CARD_GAME", "READ_CARD") or {}
	end

	local var_52_0 = false
	local var_52_1 = false

	for iter_52_0, iter_52_1 in ipairs(var_0_8) do
		if not table.indexof(var_0_32, iter_52_1) then
			local var_52_2 = RogueCardItemCfg[iter_52_1]

			if var_52_2.type == 1 or var_52_2.type == 2 then
				var_52_1 = true
			elseif var_52_2.type == 3 then
				var_52_0 = true
			end
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_WUCHANG, var_52_1 and 1 or 0)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_JOKER, var_52_0 and 1 or 0)
end

function var_0_0.UpdateIllustratedRedPoint_Weal(arg_53_0)
	if var_0_33 == nil then
		var_0_33 = getData("ROGUE_CARD_GAME", "READ_WEAL") or {}
	end

	for iter_53_0, iter_53_1 in ipairs(var_0_13) do
		if not table.indexof(var_0_33, iter_53_1) then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_WEAL, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_WEAL, 0)
end

function var_0_0.UpdateIllustratedRedPoint_Enhance(arg_54_0)
	if var_0_34 == nil then
		var_0_34 = getData("ROGUE_CARD_GAME", "READ_ENHANCE") or {}
	end

	for iter_54_0, iter_54_1 in ipairs(var_0_12) do
		if not table.indexof(var_0_34, iter_54_1) then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_ENHANCE, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_ENHANCE, 0)
end

function var_0_0.ClearIllustratedRedPoint_Jocker(arg_55_0)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_JOKER, 0)

	var_0_32 = var_0_32 or {}

	for iter_55_0, iter_55_1 in ipairs(var_0_8) do
		if not table.indexof(var_0_32, iter_55_1) and RogueCardItemCfg[iter_55_1].type == 3 then
			table.insert(var_0_32, iter_55_1)
		end
	end

	saveData("ROGUE_CARD_GAME", "READ_CARD", var_0_32)
end

function var_0_0.ClearIllustratedRedPoint_Wuchang(arg_56_0)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_WUCHANG, 0)

	var_0_32 = var_0_32 or {}

	for iter_56_0, iter_56_1 in ipairs(var_0_8) do
		if not table.indexof(var_0_32, iter_56_1) then
			local var_56_0 = RogueCardItemCfg[iter_56_1]

			if var_56_0.type == 1 or var_56_0.type == 2 then
				table.insert(var_0_32, iter_56_1)
			end
		end
	end

	saveData("ROGUE_CARD_GAME", "READ_CARD", var_0_32)
end

function var_0_0.SetIllustratedRedPoint_JockerWuchang(arg_57_0, arg_57_1)
	if not table.indexof(var_0_32, arg_57_1) then
		table.insert(var_0_32, arg_57_1)
	end

	saveData("ROGUE_CARD_GAME", "READ_CARD", var_0_32)
	arg_57_0:UpdateIllustratedRedPoint_JockerWuchang()
end

function var_0_0.ClearIllustratedRedPoint_Weal(arg_58_0)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_WEAL, 0)

	var_0_33 = clone(var_0_13 or {})

	saveData("ROGUE_CARD_GAME", "READ_WEAL", var_0_33)
end

function var_0_0.SetIllustratedRedPoint_Weal(arg_59_0, arg_59_1)
	if not table.indexof(var_0_33, arg_59_1) then
		table.insert(var_0_33, arg_59_1)
	end

	saveData("ROGUE_CARD_GAME", "READ_ENHANCE", var_0_33)
	arg_59_0:UpdateIllustratedRedPoint_Weal()
end

function var_0_0.ClearIllustratedRedPoint_Enhance(arg_60_0)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_ENHANCE, 0)

	var_0_34 = clone(var_0_12 or {})

	saveData("ROGUE_CARD_GAME", "READ_ENHANCE", var_0_34)
end

function var_0_0.SetIllustratedRedPoint_Enhance(arg_61_0, arg_61_1)
	if not table.indexof(var_0_34, arg_61_1) then
		table.insert(var_0_34, arg_61_1)
	end

	saveData("ROGUE_CARD_GAME", "READ_ENHANCE", var_0_34)
	arg_61_0:UpdateIllustratedRedPoint_Enhance()
end

function var_0_0.GetIllustratedRedPoint_JockerWuchang(arg_62_0, arg_62_1)
	return not table.indexof(var_0_32 or {}, arg_62_1)
end

function var_0_0.GetIllustratedRedPoint_JockerWuchang_Group(arg_63_0, arg_63_1)
	for iter_63_0, iter_63_1 in ipairs(arg_63_1) do
		if not table.indexof(var_0_32 or {}, iter_63_1) and RogueCardGameTools.IsUnlockWcCard(iter_63_1) then
			return true
		end
	end

	return false
end

function var_0_0.GetIllustratedRedPoint_Weal(arg_64_0, arg_64_1)
	return not table.indexof(var_0_33 or {}, arg_64_1)
end

function var_0_0.GetIllustratedRedPoint_Weal_Group(arg_65_0, arg_65_1)
	for iter_65_0, iter_65_1 in ipairs(arg_65_1) do
		if not table.indexof(var_0_33 or {}, iter_65_1) then
			return true
		end
	end

	return false
end

function var_0_0.GetIllustratedRedPoint_Enhance(arg_66_0, arg_66_1)
	return not table.indexof(var_0_34 or {}, arg_66_1)
end

function var_0_0.GetIllustratedRedPoint_Enhance_Group(arg_67_0, arg_67_1)
	for iter_67_0, iter_67_1 in ipairs(arg_67_1) do
		if not table.indexof(var_0_34 or {}, iter_67_1) and RogueCardGameTools.IsUnlockCardBuff(iter_67_1) then
			return true
		end
	end

	return false
end

return var_0_0
