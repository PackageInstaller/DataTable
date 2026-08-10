local var_0_0 = singletonClass("ValentineGameData")
local var_0_1 = {}
local var_0_2 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
	arg_1_0.gotRewardStoryIDList_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id

	if not var_0_1[var_2_0] then
		var_0_1[var_2_0] = {}
		var_0_1[var_2_0].id = var_2_0
		var_0_1[var_2_0].isOpen = arg_2_1.clear_state == 0
	end

	var_0_1[var_2_0].isClear = arg_2_1.clear_state ~= 0
	var_0_1[var_2_0].isReward = arg_2_1.reward_state ~= 0
	var_0_1[var_2_0].point = arg_2_1.point or 0
	var_0_1[var_2_0].answerQuestionID = cleanProtoTable(arg_2_1.qa_list)
	var_0_1[var_2_0].selectQuestionID = cleanProtoTable(arg_2_1.choose_list)
end

function var_0_0.GetData(arg_3_0, arg_3_1)
	return var_0_1[arg_3_1]
end

function var_0_0.SetNotNewOpen(arg_4_0, arg_4_1)
	if var_0_1[arg_4_1] then
		var_0_1[arg_4_1].isOpen = false

		ValentineGameAction:RefreshRedPoint(arg_4_1)
	end
end

function var_0_0.SetClear(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if var_0_1[arg_5_1] then
		var_0_1[arg_5_1].isClear = true

		if arg_5_2 and not table.indexof(var_0_1[arg_5_1].selectQuestionID, arg_5_2) then
			table.insert(var_0_1[arg_5_1].selectQuestionID, arg_5_2)
		end

		if arg_5_3 and not table.indexof(var_0_1[arg_5_1].answerQuestionID, arg_5_3) then
			table.insert(var_0_1[arg_5_1].answerQuestionID, arg_5_3)
		end

		ValentineGameAction:RefreshRedPoint(arg_5_1)
	end
end

function var_0_0.SetReward(arg_6_0, arg_6_1)
	if var_0_1[arg_6_1] then
		var_0_1[arg_6_1].isReward = true

		ValentineGameAction:RefreshRedPoint(arg_6_1)
	end
end

function var_0_0.SetPoint(arg_7_0, arg_7_1, arg_7_2)
	var_0_1[arg_7_1].point = arg_7_2

	arg_7_0:SetClear(arg_7_1)
end

function var_0_0.SetLastLevel(arg_8_0, arg_8_1, arg_8_2)
	var_0_2[arg_8_1] = arg_8_2
end

function var_0_0.GetLastLevel(arg_9_0, arg_9_1)
	return var_0_2[arg_9_1] or 0
end

function var_0_0.SaveLastSelect(arg_10_0, arg_10_1, arg_10_2)
	var_0_2[arg_10_1] = arg_10_2
end

function var_0_0.ClearReadedQID(arg_11_0, arg_11_1)
	if var_0_1[arg_11_1] then
		var_0_1[arg_11_1].answerQuestionID = {}
	end
end

local var_0_3 = 0

function var_0_0.CacheChooseQID(arg_12_0, arg_12_1)
	var_0_3 = arg_12_1
end

local var_0_4 = 0

function var_0_0.CacheRandomQID(arg_13_0, arg_13_1)
	var_0_4 = arg_13_1
end

function var_0_0.GetQID(arg_14_0)
	return var_0_3, var_0_4
end

function var_0_0.SetV3ServerData(arg_15_0, arg_15_1)
	arg_15_0.gotRewardStoryIDList_ = cleanProtoTable(arg_15_1.got_story_reward)
end

function var_0_0.GetStoryIDIsGetReward(arg_16_0, arg_16_1)
	if table.indexof(arg_16_0.gotRewardStoryIDList_, arg_16_1) then
		return true
	else
		return false
	end
end

function var_0_0.StoryIDGetReward(arg_17_0, arg_17_1)
	table.insert(arg_17_0.gotRewardStoryIDList_, arg_17_1)
end

return var_0_0
