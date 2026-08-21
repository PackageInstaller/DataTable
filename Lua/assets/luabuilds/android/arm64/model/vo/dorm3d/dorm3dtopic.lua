local var_0_0 = class("Dorm3dTopic", import("..BaseVO"))
local var_0_1 = pg.dorm3d_ins_chat_language

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.topicConfig = arg_1_1
	arg_1_0.topicId = arg_1_1.id
	arg_1_0.characterId = arg_1_1.ship_group
	arg_1_0.name = arg_1_1.name
	arg_1_0.unlockDesc = arg_1_1.unlock_desc
	arg_1_0.content = arg_1_1.content

	arg_1_0:SetWordList()

	arg_1_0.operationTime = nil
	arg_1_0.readFlag = 1
	arg_1_0.replyList = nil

	if arg_1_2 then
		arg_1_0.active = true
		arg_1_0.operationTime = arg_1_2.time
		arg_1_0.readFlag = arg_1_2.read_flag
		arg_1_0.replyList = arg_1_2.reply_list

		arg_1_0:SetDisplayWordList()
	else
		arg_1_0.active = false
	end

	return
end

function var_0_0.SetWordList(arg_2_0)
	arg_2_0.wordList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.content) do
		table.insert(arg_2_0.wordList, var_0_1[iter_2_1])
	end

	return
end

function var_0_0.SetDisplayWordList(arg_3_0)
	arg_3_0.displayWordList = {}
	arg_3_0.replyValues = {}

	if arg_3_0.replyList ~= nil and #arg_3_0.replyList > 0 then
		table.sort(arg_3_0.replyList, function(arg_4_0, arg_4_1)
			return arg_4_0.key < arg_4_1.key
		end)

		local var_3_0 = arg_3_0.replyList[#arg_3_0.replyList].key

		for iter_3_0, iter_3_1 in ipairs(arg_3_0.replyList) do
			table.insert(arg_3_0.replyValues, iter_3_1.value)
		end

		local var_3_1 = 999

		for iter_3_2, iter_3_3 in ipairs(arg_3_0.wordList) do
			if iter_3_3.flag == 0 or _.contains(arg_3_0.replyValues, iter_3_3.flag) then
				table.insert(arg_3_0.displayWordList, iter_3_3)
			end

			if iter_3_3.id == var_3_0 then
				var_3_1 = iter_3_2
			end

			if (iter_3_3.flag == 0 or _.contains(arg_3_0.replyValues, iter_3_3.flag)) and iter_3_3.option ~= "" and var_3_1 < iter_3_2 then
				break
			end
		end
	else
		for iter_3_4, iter_3_5 in ipairs(arg_3_0.wordList) do
			table.insert(arg_3_0.displayWordList, iter_3_5)

			if iter_3_5.option ~= "" then
				break
			end
		end
	end

	return
end

function var_0_0.GetDisplayWordList(arg_5_0)
	return arg_5_0.displayWordList
end

function var_0_0.Activate(arg_6_0, arg_6_1)
	arg_6_0.active = true
	arg_6_0.operationTime = arg_6_1
	arg_6_0.readFlag = 0

	arg_6_0:SetDisplayWordList()

	arg_6_0.replyList = {}

	return
end

function var_0_0.RedPacketGotFlag(arg_7_0, arg_7_1)
	if #arg_7_0.replyValues > 0 and _.contains(arg_7_0.replyValues, arg_7_1) then
		return true
	end

	return false
end

function var_0_0.isWaiting(arg_8_0)
	return arg_8_0.displayWordList[#arg_8_0.displayWordList].option ~= ""
end

function var_0_0.IsCompleted(arg_9_0)
	if not arg_9_0:isWaiting() and arg_9_0.readFlag == 1 then
		return true
	end

	return false
end

return var_0_0
