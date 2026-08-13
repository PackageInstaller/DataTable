class = var_0_10000

local var_0_0 = "Instagram"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseVO"))

var_0_1.TYPE_PLAYER_COMMENT = 1
var_0_1.TYPE_NPC_COMMENT = 2
pg = var_1

local var_0_2 = var_1.activity_ins_language

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id

	if arg_1_0:getConfig("is_active") == 1 then
		arg_1_0:InitByServer(arg_1_1)
	else
		arg_1_0:InitByConfig(arg_1_1)
	end

	arg_1_0.good = arg_1_1.good
	arg_1_0.isLike = arg_1_1.is_good == 1
	arg_1_0.isRead = arg_1_1.is_read == 1

	return
end

function var_0_1.InitByServer(arg_2_0, arg_2_1)
	arg_2_0.text = arg_2_1.text
	arg_2_0.picture = arg_2_1.picture
	arg_2_0.time = arg_2_1.time
	arg_2_0.oaListPic = arg_2_1.oalist_pic
	arg_2_0.optionDiscuss = {}
	arg_2_0.discussList = {}
	arg_2_0.allReply = {}
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_1.npc_reply) do
		var_1_10007 = {}
		ipairs = var_1_10008

		for iter_2_2, iter_2_3 in var_1_10008(iter_2_1.npc_reply) do
			table = var_1_10013

			var_1_10013.insert(var_1_10007, iter_2_3)
		end

		var_1_10008 = arg_2_0.allReply
		var_1_10008[iter_2_1.id] = {
			id = iter_2_1.id,
			time = iter_2_1.time,
			text = iter_2_1.text,
			npc_reply = var_1_10007
		}
	end

	ipairs = var_2

	for iter_2_4, iter_2_5 in var_2(arg_2_1.player_discuss) do
		if iter_2_5.text == "" then
			ipairs = var_1_10007

			for iter_2_6, iter_2_7 in var_1_10007(iter_2_5.text_list) do
				table = iter_2_3

				iter_2_3.insert(arg_2_0.optionDiscuss, 1, {
					id = iter_2_5.id,
					index = iter_2_6,
					text = iter_2_7
				})
			end
		else
			table = var_1_10007
			var_1_10007 = var_1_10007.insert

			local var_2_0 = arg_2_0.discussList

			InstagramPlayerComment = iter_2_6

			var_1_10007(var_2_0, iter_2_6.New(iter_2_5, arg_2_0, 1))
		end
	end

	ipairs = var_2

	for iter_2_8, iter_2_9 in var_2(arg_2_1.npc_discuss) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_2_1 = arg_2_0.discussList

		InstagramNpcComment = iter_2_6

		var_1_10007(var_2_1, iter_2_6.New(iter_2_9, arg_2_0, 1))
	end

	return
end

function var_0_1.InitByConfig(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:getConfig("message_persist")

	assert = var_1_10003

	var_1_10003(var_0_2[var_3_0], var_3_0)

	arg_3_0.text = var_0_2[var_3_0].value
	arg_3_0.picture = arg_3_0:getConfig("picture_persist")
	pg = var_3

	local var_3_1 = var_3.TimeMgr.GetInstance()

	arg_3_0.time = var_3.parseTimeFromConfig(var_3_1, arg_3_0:getConfig("time_persist"))

	local var_3_2 = arg_3_0

	arg_3_0.oaListPic = arg_3_0.getConfig(var_3_2, "oalist_pic_persist")
	arg_3_0.optionDiscuss = {}
	arg_3_0.discussList = {}
	getProxy = var_3
	InstagramProxy = var_3_2

	local var_3_3 = var_3(var_3_2)

	arg_3_0.allReply = var_3.GetAllReply(var_3_3)
	ipairs = var_3

	for iter_3_0, iter_3_1 in var_3(arg_3_1.player_discuss) do
		if iter_3_1.text == "" then
			ipairs = var_8

			for iter_3_2, iter_3_3 in var_8(iter_3_1.text_list) do
				table = var_1_10013

				var_1_10013.insert(arg_3_0.optionDiscuss, 1, {
					id = iter_3_1.id,
					index = iter_3_2,
					text = iter_3_3
				})
			end
		else
			table = var_8

			local var_3_4 = var_8.insert

			var_1_10010 = arg_3_0.discussList
			InstagramPlayerComment = iter_3_2

			var_3_4(var_1_10010, iter_3_2.New(iter_3_1, arg_3_0, 1))
		end
	end

	local var_3_5 = arg_3_0:getConfig("npc_discuss_persist")

	type = var_4

	if var_4(var_3_5) == "table" then
		ipairs = var_4

		for iter_3_4, iter_3_5 in var_4(var_3_5) do
			local var_3_6 = arg_3_0.allReply[iter_3_5]

			table = var_1_10010
			var_1_10010 = var_1_10010.insert

			local var_3_7 = arg_3_0.discussList

			InstagramNpcComment = var_1_10013

			var_1_10010(var_3_7, var_1_10013.New(var_3_6, arg_3_0, 1))
		end
	end

	return
end

function var_0_1.GetLasterUpdateTime(arg_4_0)
	local var_4_0 = {}

	pairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.discussList) do
		local var_4_1 = iter_4_1:GetLasterUpdateTime()

		table = var_1_10008

		var_1_10008.insert(var_4_0, var_4_1)
	end

	table = var_2

	var_2.sort(var_4_0, function(arg_5_0, arg_5_1)
		return arg_5_1 < arg_5_0
	end)

	local var_4_2

	if not var_4_0[1] then
		var_4_2 = 0
	end

	return var_4_2
end

function var_0_1.AnyCommentUnread(arg_6_0)
	_ = var_1_10001

	return var_1_10001.any(arg_6_0.discussList, function(arg_7_0)
		return arg_7_0:AnyReplyTimeOut()
	end)
end

function var_0_1.GetAllReply(arg_8_0)
	return arg_8_0.allReply
end

function var_0_1.IsReaded(arg_9_0)
	return arg_9_0.isRead
end

function var_0_1.bindConfigTable(arg_10_0)
	pg = var_1_10001

	return var_1_10001.activity_ins_template
end

function var_0_1.GetIcon(arg_11_0)
	return arg_11_0:getConfig("sculpture")
end

function var_0_1.GetName(arg_12_0)
	return arg_12_0:getConfig("name")
end

function var_0_1.GetSortIndex(arg_13_0)
	if var_1[arg_13_0:bindConfigTable().all[1]].order then
		return arg_13_0:getConfig("order")
	else
		return 0
	end

	return
end

function var_0_1.GetImage(arg_14_0)
	return arg_14_0.picture
end

function var_0_1.GetContent(arg_15_0)
	HXSet = var_1_10001

	return var_1_10001.hxLan(arg_15_0.text)
end

function var_0_1.GetLikeCnt(arg_16_0)
	if arg_16_0.good > 999 then
		return "999+"
	else
		return arg_16_0.good
	end

	return
end

function var_0_1.IsLiking(arg_17_0)
	return arg_17_0.isLike
end

function var_0_1.UpdateIsLike(arg_18_0)
	arg_18_0.isLike = 1

	return
end

function var_0_1.GetPushTime(arg_19_0)
	InstagramTimeStamp = var_1_10001

	return var_1_10001(arg_19_0.time)
end

function var_0_1.GetCanDisplayComments(arg_20_0)
	local var_20_0 = {}
	local var_20_1 = 0

	ipairs = var_1_10003

	for iter_20_0, iter_20_1 in var_1_10003(arg_20_0.discussList) do
		if not iter_20_1:ShouldWaitForShow() then
			table = var_8

			var_8.insert(var_20_0, iter_20_1)

			var_20_1 = var_20_1 + 1
		end
	end

	return var_20_0, var_20_1
end

function var_0_1.GetFastestRefreshTime(arg_21_0)
	local var_21_0 = {}

	ipairs = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10002(arg_21_0.discussList) do
		if iter_21_1:GetFasterRefreshTime() then
			table = var_1_10008

			var_1_10008.insert(var_21_0, var_7)
		end
	end

	if #var_21_0 > 0 then
		table = var_2

		var_2.sort(var_21_0, function(arg_22_0, arg_22_1)
			return arg_22_0 < arg_22_1
		end)

		return var_21_0[1]
	end

	return
end

function var_0_1.GetOptionComment(arg_23_0)
	return arg_23_0.optionDiscuss
end

function var_0_1.CanOpenComment(arg_24_0)
	return #arg_24_0.optionDiscuss > 0
end

function var_0_1.ShouldShowTip(arg_25_0)
	return not arg_25_0:IsReaded() or arg_25_0:AnyCommentUnread()
end

return var_0_1
