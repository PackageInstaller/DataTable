local var_0_0 = class("InstagramComment", import("..BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
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

function var_0_0.GetLasterUpdateTime(arg_2_0)
	local var_2_0 = {}

	;(function(arg_3_0)
		if arg_3_0 <= pg.TimeMgr.GetInstance():GetServerTime() then
			table.insert(var_2_0, arg_3_0)
		end

		return
	end)(arg_2_0.time)

	for iter_2_0, iter_2_1 in pairs((arg_2_0:GetAllReplys())) do
		(function(arg_3_0)
			if arg_3_0 <= pg.TimeMgr.GetInstance():GetServerTime() then
				table.insert(var_2_0, arg_3_0)
			end

			return
		end)(iter_2_1.time)
	end

	table.sort({}, function(arg_4_0, arg_4_1)
		return arg_4_1 < arg_4_0
	end)

	local var_2_1 = ({})[1]

	if not ({})[1] then
		var_2_1 = 0
	end

	return var_2_1
end

function var_0_0.GetName(arg_5_0)
	assert(false)

	return
end

function var_0_0.GetPainting(arg_6_0)
	assert(false)

	return
end

function var_0_0.GetType(arg_7_0)
	assert(false)

	return
end

function var_0_0.GetFasterRefreshTime(arg_8_0)
	if arg_8_0:ShouldWaitForShow() then
		table.insert({}, arg_8_0.time)
	end

	for iter_8_0, iter_8_1 in ipairs((arg_8_0:GetAllReplys())) do
		if iter_8_1:ShouldWaitForShow() then
			table.insert({}, iter_8_1.time)
		end
	end

	if #{} > 0 then
		table.sort({}, function(arg_9_0, arg_9_1)
			return arg_9_0 < arg_9_1
		end)

		return ({})[1]
	end

	return
end

function var_0_0.AnyReplyTimeOut(arg_10_0)
	return _.any(arg_10_0:GetAllReplys(), function(arg_11_0)
		return arg_11_0:TimeOutAndTxtIsEmpty()
	end) or arg_10_0:TimeOutAndTxtIsEmpty()
end

function var_0_0.TimeOutAndTxtIsEmpty(arg_12_0)
	local var_12_0 = pg.TimeMgr.GetInstance()

	return var_12_0:GetServerTime() >= arg_12_0.time and arg_12_0.text == ""
end

function var_0_0.ShouldWaitForShow(arg_13_0)
	local var_13_0 = pg.TimeMgr.GetInstance()

	return var_13_0:GetServerTime() < arg_13_0.time or arg_13_0:TimeOutAndTxtIsEmpty()
end

function var_0_0.GetReplyTimeOffset(arg_14_0)
	return arg_14_0.time - pg.TimeMgr.GetInstance():GetServerTime()
end

function var_0_0.GetReplyList(arg_15_0)
	return arg_15_0.replyList
end

function var_0_0.GetAllReplys(arg_16_0)
	local var_16_0 = {}

	;(function(arg_17_0)
		for iter_17_0, iter_17_1 in ipairs(arg_17_0) do
			var_0(iter_17_1.replyList)
			table.insert(var_16_0, iter_17_1)
		end

		return
	end)(arg_16_0.replyList)

	return {}
end

function var_0_0.GetCanDisplayReply(arg_18_0)
	local var_18_0 = 0

	for iter_18_0, iter_18_1 in ipairs((arg_18_0:GetAllReplys())) do
		if not iter_18_1:ShouldWaitForShow() then
			table.insert({}, iter_18_1)

			var_18_0 = var_18_0 + 1
		end
	end

	return {}, var_18_0
end

function var_0_0.GetParentCommentName(arg_19_0)
	return arg_19_0.parentComment:GetName()
end

function var_0_0.HasReply(arg_20_0)
	local var_20_0 = arg_20_0:GetAllReplys()

	return _.any(var_20_0, function(arg_21_0)
		return not arg_21_0:ShouldWaitForShow()
	end) and #var_20_0 > 0
end

function var_0_0.GetContent(arg_22_0)
	local var_22_0 = arg_22_0:GetName()

	if arg_22_0.isRoot then
		return string.format("<color=#000000FF>%s.</color>%s", var_22_0, arg_22_0.text)
	else
		local var_22_1 = arg_22_0:GetParentCommentName()

		return string.format("<color=#000000FF>%s.</color>%s", var_22_0, arg_22_0.text)
	end

	return
end

function var_0_0.GetReplyCnt(arg_23_0)
	local var_23_0 = 0

	for iter_23_0, iter_23_1 in ipairs((arg_23_0:GetAllReplys())) do
		if not iter_23_1:ShouldWaitForShow() then
			var_23_0 = var_23_0 + 1
		end
	end

	return var_23_0
end

function var_0_0.GetTime(arg_24_0)
	return InstagramReplyTimeStamp(arg_24_0.time) .. " reply"
end

function var_0_0.GetIcon(arg_25_0)
	return arg_25_0:GetPainting()
end

function var_0_0.GetReplyBtnTxt(arg_26_0)
	return "reply"
end

return var_0_0
