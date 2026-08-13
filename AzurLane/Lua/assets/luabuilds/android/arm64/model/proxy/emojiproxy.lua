class = var_0_10000

local var_0_0 = "EmojiProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.NEW_EMOJI_SAVE_TAG = "new_emoji_save_tag_"

function var_0_1.register(arg_1_0)
	arg_1_0._initedTag = false
	arg_1_0._emojiIDList = {}
	arg_1_0._newIDList = {}

	return
end

function var_0_1.getInitedTag(arg_2_0)
	return arg_2_0._initedTag
end

function var_0_1.setInitedTag(arg_3_0)
	arg_3_0._initedTag = true

	return
end

function var_0_1.getNewEmojiIDLIst(arg_4_0)
	Clone = var_1_10001

	return var_1_10001(arg_4_0._newIDList)
end

function var_0_1.addToEmojiIDLIst(arg_5_0, arg_5_1)
	table = var_1_10002

	if var_1_10002.indexof(arg_5_0._emojiIDList, arg_5_1, 1) then
		return
	end

	table = var_2

	var_2.insert(arg_5_0._emojiIDList, arg_5_1)

	return
end

function var_0_1.saveNewEmojiIDList(arg_6_0)
	local var_6_0 = {}

	pairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0._newIDList) do
		table = var_1_10007

		var_1_10007.insert(var_6_0, iter_6_1)
	end

	getProxy = var_2
	PlayerProxy = var_4

	local var_6_1 = var_2(var_4)
	local var_6_2 = var_2.getRawData(var_6_1).id

	PlayerPrefs = var_3

	local var_6_3 = var_3.SetString
	local var_6_4 = var_0_1.NEW_EMOJI_SAVE_TAG .. var_6_2

	table = var_6

	var_6_3(var_6_4, var_6.concat(var_6_0, ":"))

	return
end

function var_0_1.loadNewEmojiIDList(arg_7_0)
	arg_7_0._newIDList = {}
	getProxy = var_1
	PlayerProxy = var_1_10003

	local var_7_0 = var_1(var_1_10003)
	local var_7_1 = var_1.getRawData(var_7_0).id

	string = var_1_10002

	local var_7_2 = var_1_10002.split

	PlayerPrefs = var_1_10004

	local var_7_3

	if not var_1_10004.GetString(var_0_1.NEW_EMOJI_SAVE_TAG .. var_7_1) then
		var_7_3 = ""
	end

	if #var_7_2(var_7_3, ":") > 0 then
		pairs = var_3

		for iter_7_0, iter_7_1 in var_3(var_2) do
			table = var_1_10008
			var_1_10008 = var_1_10008.insert

			local var_7_4 = arg_7_0._newIDList

			tonumber = var_1_10011

			var_1_10008(var_7_4, var_1_10011(iter_7_1))
		end
	end

	return
end

function var_0_1.addNewEmojiID(arg_8_0, arg_8_1)
	table = var_1_10002

	if var_1_10002.indexof(arg_8_0._emojiIDList, arg_8_1, 1) then
		return
	end

	table = var_2

	var_2.insert(arg_8_0._emojiIDList, arg_8_1)

	table = var_2

	var_2.insert(arg_8_0._newIDList, arg_8_1)
	arg_8_0:saveNewEmojiIDList()

	return
end

function var_0_1.removeNewEmojiID(arg_9_0, arg_9_1)
	table = var_1_10002

	if not var_1_10002.indexof(arg_9_0._newIDList, arg_9_1, 1) then
		assert = var_1_10003

		var_1_10003(false, "new emoji list does not exit this emojiID:" .. arg_9_1)
	else
		table = var_1_10003

		var_1_10003.remove(arg_9_0._newIDList, var_2)
	end

	arg_9_0:saveNewEmojiIDList()

	return
end

function var_0_1.fliteNewEmojiDataByType(arg_10_0)
	local var_10_0 = {}

	pairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0._newIDList) do
		pg = var_1_10007

		if not var_10_0[var_1_10007.emoji_template[iter_10_1].type[1]] then
			var_10_0[var_8] = {
				var_1_10007
			}
		else
			table = var_9

			var_9.insert(var_10_0[var_8], var_1_10007)
		end
	end

	return var_10_0
end

function var_0_1.getEmojiDataByType(arg_11_0, arg_11_1)
	local var_11_0 = {}

	pairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(arg_11_0._emojiIDList) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.emoji_template[iter_11_1]
		table = var_1_10009

		if var_1_10009.contains(var_1_10008.type, arg_11_1) then
			table = var_1_10009

			var_1_10009.insert(var_11_0, var_1_10008)
		end
	end

	return var_11_0
end

function var_0_1.getExEmojiDataByType(arg_12_0, arg_12_1)
	local var_12_0 = {}

	pairs = var_1_10003

	for iter_12_0, iter_12_1 in var_1_10003(arg_12_0._emojiIDList) do
		table = var_1_10008

		if not var_1_10008.contains(arg_12_0._newIDList, iter_12_1) then
			pg = var_1_10008
			var_1_10008 = var_1_10008.emoji_template[iter_12_1]
			table = var_1_10009

			if var_1_10009.contains(var_1_10008.type, arg_12_1) then
				table = var_1_10009

				var_1_10009.insert(var_12_0, var_1_10008)
			end
		end
	end

	return var_12_0
end

return var_0_1
