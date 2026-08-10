local var_0_0 = singletonClass("SurveyData")
local var_0_1 = {}
local var_0_2 = false
local var_0_3 = 0
local var_0_4 = false
local var_0_5
local var_0_6 = {}
local var_0_7 = {
	REGRESSION = 2,
	CHAPTER = 3,
	ALL = 1
}

function var_0_0.InitData(arg_1_0, arg_1_1)
	table.sort(arg_1_1.survey_list, function(arg_2_0, arg_2_1)
		return arg_2_0.id < arg_2_1.id
	end)

	var_0_1 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.survey_list) do
		local var_1_0 = {
			id = iter_1_1.id,
			question_num = iter_1_1.question_num,
			url = iter_1_1.url,
			name = iter_1_1.name,
			type = iter_1_1.type,
			start_time = iter_1_1.start_time,
			stop_time = iter_1_1.stop_time,
			attachment_list = {},
			status = iter_1_1.status,
			chapter = iter_1_1.chapter,
			chapter_type = iter_1_1.chapter_type
		}

		for iter_1_2, iter_1_3 in ipairs(iter_1_1.attachment_list) do
			table.insert(var_1_0.attachment_list, {
				id = iter_1_3.id,
				num = iter_1_3.num
			})
		end

		if iter_1_1.type == var_0_7.CHAPTER then
			var_0_6[iter_1_1.chapter] = iter_1_1.id
		end

		var_0_1[iter_1_1.id] = var_1_0
	end

	print(var_0_1)

	var_0_2 = false
end

function var_0_0.FinishSurvey(arg_3_0, arg_3_1)
	if var_0_1[arg_3_1] then
		var_0_1[arg_3_1].status = 1
	end
end

function var_0_0.GotReward(arg_4_0, arg_4_1)
	var_0_1[arg_4_1].status = 2
end

function var_0_0.GetSurveyList(arg_5_0)
	return var_0_1
end

function var_0_0.ReservationGame(arg_6_0, arg_6_1)
	var_0_4 = arg_6_1
end

function var_0_0.IsReservation(arg_7_0)
	return var_0_4
end

function var_0_0.GetPraise(arg_8_0)
	return var_0_2
end

function var_0_0.GetSourceId(arg_9_0)
	return var_0_3
end

function var_0_0.SetSourceId(arg_10_0, arg_10_1)
	var_0_3 = arg_10_1
end

function var_0_0.SetPraise(arg_11_0, arg_11_1)
	if GameToSDK.IsPCPlatform() then
		var_0_2 = false
	else
		var_0_2 = arg_11_1
	end
end

function var_0_0.CacheFollowTip(arg_12_0, arg_12_1)
	var_0_5 = arg_12_1
end

function var_0_0.GetCacheFollowTip(arg_13_0)
	local var_13_0 = var_0_5

	var_0_5 = nil

	return var_13_0
end

function var_0_0.GetChapterSurveyList(arg_14_0)
	return var_0_6
end

function var_0_0.GetChapterSurveyID(arg_15_0, arg_15_1)
	local var_15_0 = ChapterClientCfg[arg_15_1].chapter_list
	local var_15_1 = var_15_0[#var_15_0]

	return var_0_6[var_15_1]
end

function var_0_0.GetChapterSurveyUrl(arg_16_0, arg_16_1)
	local var_16_0
	local var_16_1 = arg_16_0:GetChapterSurveyID(arg_16_1)

	if var_16_1 and var_16_1 ~= 0 then
		var_16_0 = var_0_1[var_16_1].url
	end

	return var_16_0
end

function var_0_0.GetChapterSurveyIsFinish(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:GetChapterSurveyID(arg_17_1)

	if var_17_0 and var_17_0 ~= 0 then
		return var_0_1[var_17_0].status == 1
	end

	return false
end

return var_0_0
