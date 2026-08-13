class = var_0_10000

local var_0_0 = "Instagram3Dorm"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseVO"))

var_0_1.OP_DISCUSS = 2
var_0_1.OP_READ = 3
var_0_1.OP_LIKE = 4
var_0_1.OP_SHARE = 5
var_0_1.OP_EXIT = 6

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_1.id

	local var_1_0

	if not arg_1_1.time then
		var_1_0 = 0
	end

	arg_1_0.time = var_1_0
	defaultValue = var_1_0
	arg_1_0.isRead = var_1_0(arg_1_1.read_flag, 0) == 1
	defaultValue = var_3
	arg_1_0.isGood = var_3(arg_1_1.good_flag, 0) == 1
	defaultValue = var_3
	arg_1_0.isLock = var_3(arg_1_2, true)

	local var_1_1

	if not arg_1_1.exit_time then
		var_1_1 = 0
	end

	arg_1_0.exitTime = var_1_1

	local var_1_2 = {}

	ipairs = var_4

	local var_1_3

	if not arg_1_1.reply_list then
		var_1_3 = {}
	end

	for iter_1_0, iter_1_1 in var_4(var_1_3) do
		if not var_1_2[iter_1_1.key] then
			var_1_2[iter_1_1.key] = {}
		end

		table = var_9

		var_9.insert(var_1_2[iter_1_1.key], {
			index = iter_1_1.value,
			time = iter_1_1.time
		})
	end

	arg_1_0.replyedList = arg_1_0:BuildReplyedList(var_1_2)
	arg_1_0.replyableList = arg_1_0:BuildReplyableList(var_1_2)

	local var_1_4

	if not arg_1_0.isLock or not arg_1_0:BuildUnlockDesc() then
		var_1_4 = ""
	end

	arg_1_0.unlockDesc = var_1_4

	return
end

function var_0_1.BuildUnlockDesc(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.dorm3d_ins_unlock.get_id_list_by_type

	Dorm3dInsProxy = var_1_10002

	local var_2_1

	if not var_2_0[var_1_10002.UNLOCK_TYPE_INS] then
		var_2_1 = {}
	end

	_ = var_2

	if not var_2.detect(var_2_1, function(arg_3_0)
		pg = var_2_10001

		return var_2_10001.dorm3d_ins_unlock[arg_3_0].content == arg_2_0.configId
	end) then
		return ""
	end

	pg = var_3

	local var_2_2 = var_3.dorm3d_ins_unlock[var_2].text

	HXSet = var_4

	return (var_4.hxLan(var_2_2))
end

function var_0_1.GetUnLockConditionDesc(arg_4_0)
	return arg_4_0.unlockDesc
end

function var_0_1.IsLock(arg_5_0)
	return arg_5_0.isLock
end

function var_0_1.Unlock(arg_6_0, arg_6_1)
	arg_6_0.isLock = false
	arg_6_0.time = arg_6_1

	return
end

function var_0_1.GetReplyedList(arg_7_0)
	return arg_7_0.replyedList
end

function var_0_1.ExistAnyReplyable(arg_8_0)
	return #arg_8_0.replyableList > 0
end

function var_0_1.GetReplyableList(arg_9_0)
	return arg_9_0.replyableList
end

function var_0_1.MarkReply(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.replyableList
	local var_10_1

	for iter_10_0 = #var_10_0, 1, -1 do
		if var_10_0[iter_10_0].id == arg_10_1 then
			table = var_9

			var_9.remove(var_10_0, iter_10_0)
		end
	end

	pg = var_5

	local var_10_2 = var_5.TimeMgr.GetInstance()
	local var_10_3 = var_5.GetServerTime(var_10_2)
	local var_10_4 = arg_10_0
	local var_10_5 = arg_10_0.BuildPlayerComment(var_10_4, arg_10_1, arg_10_2, var_10_3)

	table = var_10_4

	var_10_4.insert(arg_10_0.replyedList, var_10_5)

	return
end

function var_0_1.BuildPlayerComment(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	pg = var_1_10004

	local var_11_0 = var_1_10004.dorm3d_ins_player_template[arg_11_1].message[arg_11_2]
	local var_11_1 = var_5.npc_reply[arg_11_2]

	InstagramPlayerComment3Dorm = var_1_10008

	return var_1_10008.New(arg_11_1, arg_11_2, 10000, var_11_0, arg_11_3, {
		var_11_1
	})
end

function var_0_1.BuildReplyedList(arg_12_0, arg_12_1)
	local var_12_0 = {}

	pg = var_1_10003

	local var_12_1 = var_1_10003.dorm3d_ins_player_template

	pairs = var_1_10004

	for iter_12_0, iter_12_1 in var_1_10004(arg_12_1) do
		ipairs = var_1_10009

		for iter_12_2, iter_12_3 in var_1_10009(iter_12_1) do
			local var_12_2 = arg_12_0
			local var_12_3 = arg_12_0.BuildPlayerComment(var_12_2, iter_12_0, iter_12_3.index, iter_12_3.time)

			table = var_12_2

			var_12_2.insert(var_12_0, var_12_3)
		end
	end

	local var_12_4 = arg_12_0
	local var_12_5 = arg_12_0.getConfig(var_12_4, "npc_discuss")

	InstagramComment3Dorm = var_12_4

	local var_12_6 = var_12_4.BuildNpcReplayList(var_12_5, arg_12_0.time)

	ipairs = var_6

	for iter_12_4, iter_12_5 in var_6(var_12_6) do
		table = var_1_10011

		var_1_10011.insert(var_12_0, iter_12_5)
	end

	return var_12_0
end

function var_0_1.BuildReplyableList(arg_13_0, arg_13_1)
	local var_13_0 = {}

	pg = var_1_10003

	local var_13_1 = var_1_10003.dorm3d_ins_player_template

	pairs = var_1_10004

	for iter_13_0, iter_13_1 in var_1_10004(arg_13_0:getConfig("discuss")) do
		if not arg_13_1[iter_13_1] then
			local var_13_2 = var_13_1[iter_13_1]

			ipairs = var_1_10010

			for iter_13_2, iter_13_3 in var_1_10010(var_13_2.message) do
				pg = var_1_10015

				local var_13_3 = var_1_10015.TimeMgr.GetInstance()

				var_1_10015 = var_1_10015.GetServerTime(var_13_3)

				local var_13_4 = arg_13_0
				local var_13_5 = arg_13_0.BuildPlayerComment(var_13_4, iter_13_1, iter_13_2, var_1_10015)

				table = var_13_4

				var_13_4.insert(var_13_0, var_13_5)
			end
		end
	end

	return var_13_0
end

function var_0_1.bindConfigTable(arg_14_0)
	pg = var_1_10001

	return var_1_10001.dorm3d_ins_template
end

function var_0_1.GetBackground(arg_15_0)
	return arg_15_0:getConfig("background")
end

function var_0_1.IsRead(arg_16_0)
	return arg_16_0.isRead
end

function var_0_1.IsGood(arg_17_0)
	return arg_17_0.isGood
end

function var_0_1.GetText(arg_18_0)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.getConfig(var_18_0, "message")

	pg = var_18_0

	local var_18_2 = var_18_0.dorm3d_ins_language[var_18_1].value

	HXSet = var_3

	return (var_3.hxLan(var_18_2))
end

function var_0_1.GetPicture(arg_19_0)
	return arg_19_0:getConfig("picture")
end

function var_0_1.GetName(arg_20_0)
	return arg_20_0:getConfig("name")
end

function var_0_1.GetIcon(arg_21_0)
	return arg_21_0:getConfig("sculpture")
end

function var_0_1.GetPushTime(arg_22_0)
	InstagramTimeStamp = var_1_10001

	return var_1_10001(arg_22_0.time)
end

function var_0_1.LockState(arg_23_0)
	return arg_23_0.isLock and 0 or 1
end

function var_0_1.MarkRead(arg_24_0)
	arg_24_0.isRead = true

	return
end

function var_0_1.MarkLike(arg_25_0)
	arg_25_0.isGood = true

	return
end

function var_0_1.CanShow(arg_26_0)
	return true
end

function var_0_1.SetExitTime(arg_27_0, arg_27_1)
	arg_27_0.exitTime = arg_27_1

	return
end

function var_0_1.ShouldTip(arg_28_0)
	if arg_28_0:IsLock() or not arg_28_0:CanShow() then
		return false
	end

	if not arg_28_0:IsRead() then
		return true
	end

	_ = var_1

	if var_1.any(arg_28_0.replyedList, function(arg_29_0)
		local var_29_0

		if arg_29_0:CanShow() then
			var_29_0 = arg_29_0:ShouldTip(arg_28_0.exitTime)
		end

		return var_29_0
	end) then
		return true
	end

	return false
end

return var_0_1
