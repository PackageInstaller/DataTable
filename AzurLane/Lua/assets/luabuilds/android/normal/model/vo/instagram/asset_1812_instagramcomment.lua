class = var_0_10000

local var_0_0 = "InstagramComment"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.time = arg_1_1.time
	arg_1_0.text = arg_1_1.text
	arg_1_0.instagram = arg_1_2
	arg_1_0.parentComment = arg_1_4
	arg_1_0.id = arg_1_1.id
	arg_1_0.level = arg_1_3 or 1
	arg_1_0.isRoot = false

	if not arg_1_0.parentComment then
		arg_1_0.isRoot = true
	end

	arg_1_0.allReply = arg_1_2:GetAllReply()
	arg_1_0.replyList = {}

	return
end

function var_0_1.GetLasterUpdateTime(arg_2_0)
	local var_2_0 = {}

	;(function(arg_3_0)
		pg = var_2_10001

		local var_3_0 = var_2_10001.TimeMgr.GetInstance()

		if arg_3_0 <= var_1.GetServerTime(var_3_0) then
			table = var_3_0

			var_3_0.insert(var_2_0, arg_3_0)
		end

		return
	end)(arg_2_0.time)

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.GetAllReplys(var_2_1)

	pairs = var_2_1

	for iter_2_0, iter_2_1 in var_2_1(var_2_2) do
		var_2(iter_2_1.time)
	end

	table = var_4

	var_4.sort(var_2_0, function(arg_4_0, arg_4_1)
		return arg_4_1 < arg_4_0
	end)

	local var_2_3

	if not var_2_0[1] then
		var_2_3 = 0
	end

	return var_2_3
end

function var_0_1.GetName(arg_5_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetPainting(arg_6_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetType(arg_7_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetFasterRefreshTime(arg_8_0)
	local var_8_0 = {}

	if arg_8_0:ShouldWaitForShow() then
		table = var_2

		var_2.insert(var_8_0, arg_8_0.time)
	end

	local var_8_1 = arg_8_0
	local var_8_2 = arg_8_0.GetAllReplys(var_8_1)

	ipairs = var_8_1

	for iter_8_0, iter_8_1 in var_8_1(var_8_2) do
		if iter_8_1:ShouldWaitForShow() then
			table = var_8

			var_8.insert(var_8_0, iter_8_1.time)
		end
	end

	if #var_8_0 > 0 then
		table = var_3

		var_3.sort(var_8_0, function(arg_9_0, arg_9_1)
			return arg_9_0 < arg_9_1
		end)

		return var_8_0[1]
	end

	return
end

function var_0_1.AnyReplyTimeOut(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.GetAllReplys(var_10_0)

	_ = var_10_0

	local var_10_2

	if not var_10_0.any(var_10_1, function(arg_11_0)
		return arg_11_0:TimeOutAndTxtIsEmpty()
	end) then
		var_10_2 = arg_10_0:TimeOutAndTxtIsEmpty()
	end

	return var_10_2
end

function var_0_1.TimeOutAndTxtIsEmpty(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_12_0) >= arg_12_0.time and arg_12_0.text == ""
end

function var_0_1.ShouldWaitForShow(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_13_0) < arg_13_0.time or arg_13_0:TimeOutAndTxtIsEmpty()
end

function var_0_1.GetReplyTimeOffset(arg_14_0)
	pg = var_1_10001

	local var_14_0 = var_1_10001.TimeMgr.GetInstance()
	local var_14_1 = var_1.GetServerTime(var_14_0)

	return arg_14_0.time - var_14_1
end

function var_0_1.GetReplyList(arg_15_0)
	return arg_15_0.replyList
end

function var_0_1.GetAllReplys(arg_16_0)
	local var_16_0 = {}
	local var_16_1

	;(function(arg_17_0)
		ipairs = var_2_10001

		for iter_17_0, iter_17_1 in var_2_10001(arg_17_0) do
			var_0(iter_17_1.replyList)

			table = var_6

			var_6.insert(var_16_0, iter_17_1)
		end

		return
	end)(arg_16_0.replyList)

	return var_16_0
end

function var_0_1.GetCanDisplayReply(arg_18_0)
	local var_18_0 = {}
	local var_18_1 = 0
	local var_18_2 = arg_18_0
	local var_18_3 = arg_18_0.GetAllReplys(var_18_2)

	ipairs = var_18_2

	for iter_18_0, iter_18_1 in var_18_2(var_18_3) do
		if not iter_18_1:ShouldWaitForShow() then
			table = var_9

			var_9.insert(var_18_0, iter_18_1)

			var_18_1 = var_18_1 + 1
		end
	end

	return var_18_0, var_18_1
end

function var_0_1.GetParentCommentName(arg_19_0)
	local var_19_0 = arg_19_0.parentComment

	return var_1.GetName(var_19_0)
end

function var_0_1.HasReply(arg_20_0)
	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.GetAllReplys(var_20_0)

	_ = var_20_0

	local var_20_2

	if var_20_0.any(var_20_1, function(arg_21_0)
		return not arg_21_0:ShouldWaitForShow()
	end) then
		var_20_2 = #var_20_1 > 0
	end

	return var_20_2
end

function var_0_1.GetContent(arg_22_0)
	local var_22_0 = arg_22_0:GetName()

	if arg_22_0.isRoot then
		string = var_2

		return var_2.format("<color=#000000FF>%s.</color>%s", var_22_0, arg_22_0.text)
	else
		local var_22_1 = arg_22_0
		local var_22_2 = arg_22_0.GetParentCommentName(var_22_1)

		string = var_22_1

		return var_22_1.format("<color=#000000FF>%s.</color>%s", var_22_0, arg_22_0.text)
	end

	return
end

function var_0_1.GetReplyCnt(arg_23_0)
	local var_23_0 = 0
	local var_23_1 = arg_23_0
	local var_23_2 = arg_23_0.GetAllReplys(var_23_1)

	ipairs = var_23_1

	for iter_23_0, iter_23_1 in var_23_1(var_23_2) do
		if not iter_23_1:ShouldWaitForShow() then
			var_23_0 = var_23_0 + 1
		end
	end

	return var_23_0
end

function var_0_1.GetTime(arg_24_0)
	InstagramReplyTimeStamp = var_1_10001

	return var_1_10001(arg_24_0.time) .. " reply"
end

function var_0_1.GetIcon(arg_25_0)
	return arg_25_0:GetPainting()
end

function var_0_1.GetReplyBtnTxt(arg_26_0)
	return "reply"
end

return var_0_1
