class = var_0_10000

local var_0_0 = "InstagramTopic"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseVO"))

pg = var_0_10001

local var_0_2 = var_0_10001.activity_ins_chat_language

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
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

function var_0_1.SetWordList(arg_2_0)
	arg_2_0.wordList = {}
	ipairs = var_1

	for iter_2_0, iter_2_1 in var_1(arg_2_0.content) do
		table = var_1_10006

		var_1_10006.insert(arg_2_0.wordList, var_0_2[iter_2_1])
	end

	return
end

function var_0_1.SetDisplayWordList(arg_3_0)
	arg_3_0.displayWordList = {}
	arg_3_0.replyValues = {}

	if arg_3_0.replyList ~= nil and #arg_3_0.replyList > 0 then
		local var_3_0 = arg_3_0.replyList[#arg_3_0.replyList].key

		ipairs = var_1_10003

		for iter_3_0, iter_3_1 in var_1_10003(arg_3_0.replyList) do
			table = var_1_10008

			var_1_10008.insert(arg_3_0.replyValues, iter_3_1.value)
		end

		local var_3_1 = 999

		ipairs = var_4

		for iter_3_2, iter_3_3 in var_4(arg_3_0.wordList) do
			if iter_3_3.flag ~= 0 then
				_ = var_9

				if var_9.contains(arg_3_0.replyValues, iter_3_3.flag) then
					table = var_9

					var_9.insert(arg_3_0.displayWordList, iter_3_3)
				end

				if iter_3_3.id == var_3_0 then
					var_3_1 = iter_3_2
				end

				if iter_3_3.flag ~= 0 then
					_ = var_9

					if var_9.contains(arg_3_0.replyValues, iter_3_3.flag) then
						if iter_3_3.option ~= "" and var_3_1 < iter_3_2 then
							break
						end
					end
				end
			end
		end
	else
		ipairs = var_1

		for iter_3_4, iter_3_5 in var_1(arg_3_0.wordList) do
			table = iter_3_0

			iter_3_0.insert(arg_3_0.displayWordList, iter_3_5)

			if iter_3_5.option ~= "" then
				break
			end
		end
	end

	return
end

function var_0_1.GetDisplayWordList(arg_4_0)
	return arg_4_0.displayWordList
end

function var_0_1.GetLatestCharacterWord(arg_5_0)
	local var_5_0
	local var_5_1 = ""

	for iter_5_0 = #arg_5_0.displayWordList, 1, -1 do
		if arg_5_0.displayWordList[iter_5_0].ship_group == 0 then
			var_1_10009 = arg_5_0

			if arg_5_0.IsCompleted(var_1_10009) then
				var_5_0 = arg_5_0.displayWordList[iter_5_0]

				break
			end
		end
	end

	local var_5_4

	if var_5_0.type == 1 then
		var_5_1 = var_5_0.param
	elseif var_5_0.type == 2 then
		local var_5_2 = "<color=#ff6666>"

		i18n = var_5_4
		var_5_1 = var_5_2 .. var_5_4("juuschat_chattip1") .. "</color>"
	elseif var_5_0.type == 3 then
		local var_5_3 = "<color=#ff6666>"

		i18n = var_5_4
		var_5_4 = var_5_4("juuschat_chattip2")

		local var_5_5 = "</color>"

		pg = var_6

		local var_5_6 = var_6.activity_ins_redpackage

		tonumber = var_1_10007
		var_5_1 = var_5_3 .. var_5_4 .. var_5_5 .. var_5_6[var_1_10007(var_5_0.param)].desc
	elseif var_5_0.type == 4 then
		pg = var_3

		local var_5_7 = var_3.emoji_template

		tonumber = var_5_4

		local var_5_8 = var_5_7[var_5_4(var_5_0.param)].desc

		string = var_5_4
		var_5_1 = var_5_4.gsub(var_5_8, "#%w+>", "#28af6e>")
	elseif var_5_0.type == 5 then
		local var_5_9 = var_5_0.param

		string = var_5_4

		for iter_5_1 in var_5_4.gmatch(var_5_0.param, "'%d+'") do
			string = var_1_10008
			var_1_10008 = var_1_10008.sub(iter_5_1, 2, #iter_5_1 - 1)
			string = var_1_10009
			var_1_10009 = var_1_10009.gsub

			local var_5_10 = var_5_9
			local var_5_11 = iter_5_1
			local var_5_12 = "<color=#46d6ff>"

			pg = var_1_10014
			var_1_10014 = var_1_10014.activity_ins_ship_group_template
			tonumber = var_1_10015
			var_5_9 = var_1_10009(var_5_10, var_5_11, var_5_12 .. var_1_10014[var_1_10015(var_1_10008)].name .. "</color>")
		end

		var_5_1 = var_5_9
	end

	if arg_5_0:isWaiting() and var_5_0.type ~= 2 and var_5_0.type ~= 3 then
		local var_5_13 = "<color=#ff6666>"

		i18n = var_5_4
		var_5_1 = var_5_13 .. var_5_4("juuschat_chattip3") .. "</color>" .. var_5_1
	end

	return var_5_1
end

function var_0_1.Activate(arg_6_0, arg_6_1)
	arg_6_0.active = true
	arg_6_0.operationTime = arg_6_1
	arg_6_0.readFlag = 0

	arg_6_0:SetDisplayWordList()

	arg_6_0.replyList = {}

	return
end

function var_0_1.RedPacketGotFlag(arg_7_0, arg_7_1)
	if #arg_7_0.replyValues > 0 then
		_ = var_2

		if var_2.contains(arg_7_0.replyValues, arg_7_1) then
			return true
		end
	end

	return false
end

function var_0_1.isWaiting(arg_8_0)
	return arg_8_0.displayWordList[#arg_8_0.displayWordList].option ~= ""
end

function var_0_1.IsCompleted(arg_9_0)
	if not arg_9_0:isWaiting() and arg_9_0.readFlag == 1 then
		return true
	end

	return false
end

return var_0_1
