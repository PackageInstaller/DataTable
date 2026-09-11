local var_0_0 = singletonClass("MailData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = {}

function var_0_0.Init()
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}
	var_0_4 = {}
	var_0_5 = {}
end

function var_0_0:LetterInit()
	for iter_2_0, iter_2_1 in ipairs(self.letter_list) do
		local var_2_0 = MailSpecialLetterCfg[iter_2_1.id]

		var_0_1[iter_2_1.id] = {
			id = iter_2_1.id,
			isViewed = iter_2_1.is_viewed,
			title = MailSpecialLetterCfg[iter_2_1.id].letter_title,
			desc = MailSpecialLetterCfg[iter_2_1.id].letter_desc,
			send_time = MailSpecialLetterCfg[iter_2_1.id].letter_send_time_1,
			sender = MailSpecialLetterCfg[iter_2_1.id].letter_sender,
			belongs = MailSpecialLetterCfg[iter_2_1.id].letter_belongs,
			sender_face = MailSpecialLetterCfg[iter_2_1.id].letter_sender_face
		}

		if var_0_1[iter_2_1.id] == nil then
			table.insert(var_0_2, iter_2_1.id)
		end

		var_0_5[var_2_0.letter_belongs] = {
			id = var_2_0.letter_belongs,
			sender = var_2_0.letter_sender,
			sender_face = var_2_0.letter_sender_face
		}
	end
end

function var_0_0.SortLetters()
	for iter_3_0, iter_3_1 in pairs(var_0_1) do
		if var_0_3[iter_3_1.belongs] == nil then
			var_0_3[iter_3_1.belongs] = {}

			table.insert(var_0_4, iter_3_1.belongs)
		end

		if not table.keyof(var_0_3[iter_3_1.belongs], iter_3_0) then
			table.insert(var_0_3[iter_3_1.belongs], iter_3_0)
		end
	end

	for iter_3_2, iter_3_3 in pairs(var_0_3) do
		table.sort(iter_3_3, function(arg_4_0, arg_4_1)
			if var_0_1[arg_4_0].send_time > var_0_1[arg_4_1].send_time then
				return true
			elseif var_0_1[arg_4_0].send_time < var_0_1[arg_4_1].send_time then
				return false
			end

			return arg_4_1 < arg_4_0
		end)
	end

	table.sort(var_0_4, function(arg_5_0, arg_5_1)
		local var_5_0 = string.split(var_0_1[var_0_3[arg_5_0][1]].send_time, ",")
		local var_5_1 = string.split(var_0_1[var_0_3[arg_5_1][1]].send_time, ",")
		local var_5_2 = os.time({
			year = var_5_0[1],
			month = var_5_0[2],
			day = var_5_0[3]
		})
		local var_5_3 = os.time({
			year = var_5_1[1],
			month = var_5_1[2],
			day = var_5_1[3]
		})

		if var_5_3 < var_5_2 then
			return true
		elseif var_5_2 < var_5_3 then
			return false
		end

		return arg_5_1 < arg_5_0
	end)
end

function var_0_0.CacheReadFlag(arg_6_0)
	if var_0_1[arg_6_0] then
		var_0_1[arg_6_0].isViewed = true

		manager.notify:Invoke(LETTER_READ_UPDATE, arg_6_0)
	end
end

function var_0_0.HaveUnreadLetter(arg_7_0)
	local var_7_0 = false

	for iter_7_0, iter_7_1 in pairs(var_0_3[arg_7_0]) do
		if var_0_1[iter_7_1].isViewed == false then
			var_7_0 = true

			break
		end
	end

	return var_7_0
end

function var_0_0.GetLetters()
	return var_0_1
end

function var_0_0.GetLetterSort()
	return var_0_2
end

function var_0_0.GetLetter(arg_10_0)
	return var_0_1[arg_10_0]
end

function var_0_0.GetLettersFromSender(arg_11_0)
	return var_0_3[arg_11_0]
end

function var_0_0.GetSenderNums()
	return #var_0_4
end

function var_0_0.GetSenderSort()
	return var_0_4
end

function var_0_0.GetSender(arg_14_0)
	return var_0_5[arg_14_0]
end

function var_0_0.GetFilterSendSort()
	local var_15_0 = {}

	if CommonFilterData:IsAll(Filter_Root_Define.Mail_Filter_List.filter_id) then
		return var_0_4
	end

	for iter_15_0, iter_15_1 in ipairs(var_0_4) do
		if CommonFilterData:SpecificHasFlag(Filter_Root_Define.Mail_Filter_List.filter_id, Filter_Group_Define.RACE.groupID, {
			Filter_Tags_Define["Race" .. HeroCfg[iter_15_1].race]
		}) then
			table.insert(var_15_0, iter_15_1)
		end
	end

	return var_15_0
end

return var_0_0
