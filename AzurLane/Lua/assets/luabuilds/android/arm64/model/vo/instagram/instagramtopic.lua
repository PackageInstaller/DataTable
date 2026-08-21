local var_0_0 = class("InstagramTopic", import("..BaseVO"))
local var_0_1 = pg.activity_ins_chat_language

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.topicConfig = arg_1_1
	arg_1_0.topicId = arg_1_1.id
	arg_1_0.characterId = arg_1_1.ship_group
	arg_1_0.name = arg_1_1.name
	arg_1_0.unlockDesc = arg_1_1.unlock_desc
	arg_1_0.triggerType = arg_1_1.trigger_type
	arg_1_0.triggerParam = arg_1_1.trigger_param
	arg_1_0.content = arg_1_1.content

	arg_1_0:SetWordList()

	arg_1_0.operationTime = nil
	arg_1_0.readFlag = 1
	arg_1_0.replyList = nil

	if arg_1_2 then
		arg_1_0.active = true
		arg_1_0.operationTime = arg_1_2.op_time
		arg_1_0.readFlag = arg_1_2.read_flag
		arg_1_0.replyList = arg_1_2.reply_list

		arg_1_0:SetDisplayWordList()
	else
		arg_1_0.active = false
	end

	arg_1_0.isII = arg_1_1.group_ii ~= 0

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

function var_0_0.GetDisplayWordList(arg_4_0)
	return arg_4_0.displayWordList
end

function var_0_0.GetLatestCharacterWord(arg_5_0)
	local var_5_0
	local var_5_1 = ""

	for iter_5_0 = #arg_5_0.displayWordList, 1, -1 do
		if arg_5_0.displayWordList[iter_5_0].ship_group ~= 0 or arg_5_0:IsCompleted() then
			var_5_0 = arg_5_0.displayWordList[iter_5_0]

			break
		end
	end

	if var_5_0.type == 1 then
		var_5_1 = var_5_0.param
	elseif var_5_0.type == 2 then
		var_5_1 = "<color=#ff6666>" .. i18n("juuschat_chattip1") .. "</color>"
	elseif var_5_0.type == 3 then
		var_5_1 = "<color=#ff6666>" .. i18n("juuschat_chattip2") .. "</color>" .. pg.activity_ins_redpackage[tonumber(var_5_0.param)].desc
	elseif var_5_0.type == 4 then
		var_5_1 = string.gsub(pg.emoji_template[tonumber(var_5_0.param)].desc, "#%w+>", "#28af6e>")
	elseif var_5_0.type == 5 then
		local var_5_2 = var_5_0.param

		for iter_5_1 in string.gmatch(var_5_0.param, "'%d+'") do
			var_5_2 = string.gsub(var_5_2, iter_5_1, "<color=#46d6ff>" .. pg.activity_ins_ship_group_template[tonumber((string.sub(iter_5_1, 2, #iter_5_1 - 1)))].name .. "</color>")
		end

		var_5_1 = var_5_2
	end

	if arg_5_0:isWaiting() and var_5_0.type ~= 2 and var_5_0.type ~= 3 then
		var_5_1 = "<color=#ff6666>" .. i18n("juuschat_chattip3") .. "</color>" .. var_5_1
	end

	return var_5_1
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
