class = var_0_10000

local var_0_0 = "InstagramProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

pg = var_0_0

local var_0_2 = var_0_0.activity_ins_language

pg = var_2

local var_0_3 = var_2.activity_ins_npc_template

function var_0_1.register(arg_1_0)
	arg_1_0.messages = {}
	arg_1_0.officialAccounts = {}
	arg_1_0.isReqNewInstagramData = false
	arg_1_0.isReqOldInstagramData = false
	arg_1_0.allReply = {}

	local function var_1_0(arg_2_0)
		local var_2_0 = arg_2_0.npc_reply_persist

		type = var_2_10002

		if var_2_10002(arg_2_0.npc_reply_persist) == "string" then
			var_2_0 = {}
		end

		local var_2_1 = ""

		pg = var_3

		local var_2_2 = var_3.TimeMgr.GetInstance()
		local var_2_3 = var_3.GetServerTime(var_2_2)

		if var_0_2[arg_2_0.message_persist] then
			var_2_1 = var_0_2[arg_2_0.message_persist].value
			pg = var_4

			local var_2_4 = var_4.TimeMgr.GetInstance()

			var_2_3 = var_4.parseTimeFromConfig(var_2_4, arg_2_0.time_persist)
		end

		return {
			id = arg_2_0.id,
			time = var_2_3,
			text = var_2_1,
			npc_reply = var_2_0
		}
	end

	ipairs = var_1_10002

	for iter_1_0, iter_1_1 in var_1_10002(var_0_3.all) do
		local var_1_1 = var_1_0(var_0_3[iter_1_1])

		arg_1_0.allReply[iter_1_1] = var_1_1
	end

	return
end

function var_0_1.IsReqOldInstagramData(arg_3_0)
	return arg_3_0.isReqOldInstagramData
end

function var_0_1.MarkOldInstagramData(arg_4_0)
	arg_4_0.isReqOldInstagramData = true

	return
end

function var_0_1.IsReqNewInstagramData(arg_5_0)
	return arg_5_0.isReqNewInstagramData
end

function var_0_1.MarkNewInstagramData(arg_6_0)
	arg_6_0.isReqNewInstagramData = true

	arg_6_0:AddInstagramTimer()

	return
end

function var_0_1.AddInstagram(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1
	local var_7_1 = arg_7_1.getConfig(var_7_0, "type")

	InstagramConst = var_7_0

	if var_7_1 == var_7_0.INSTAGRAM_TYPE.OFFICIAL_ACCOUNT then
		arg_7_0:AddOfficialAccounts(arg_7_1)
	else
		arg_7_0.messages[arg_7_1.id] = arg_7_1
	end

	return
end

function var_0_1.GetAllReply(arg_8_0)
	return arg_8_0.allReply
end

function var_0_1.GetMessages(arg_9_0)
	local var_9_0 = {}

	pairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0.messages) do
		table = var_1_10007

		var_1_10007.insert(var_9_0, iter_9_1)
	end

	return var_9_0
end

function var_0_1.ExistMessage(arg_10_0)
	table = var_1_10001

	return var_1_10001.getCount(arg_10_0.messages) > 0
end

function var_0_1.GetData(arg_11_0)
	return arg_11_0.messages
end

function var_0_1.GetMessageById(arg_12_0, arg_12_1)
	return arg_12_0.messages[arg_12_1]
end

function var_0_1.UpdateMessage(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1
	local var_13_1 = arg_13_1.getConfig(var_13_0, "type")

	InstagramConst = var_13_0

	if var_13_1 == var_13_0.INSTAGRAM_TYPE.OFFICIAL_ACCOUNT then
		arg_13_0:UpdateOfficialAccounts(arg_13_1)
	elseif not arg_13_0.messages[arg_13_1.id] then
		arg_13_0:AddInstagram(arg_13_1)
	else
		arg_13_0.messages[arg_13_1.id] = arg_13_1
	end

	return
end

function var_0_1.AddOfficialAccounts(arg_14_0, arg_14_1)
	arg_14_0.officialAccounts[arg_14_1.id] = arg_14_1

	return
end

function var_0_1.UpdateOfficialAccounts(arg_15_0, arg_15_1)
	if not arg_15_0.officialAccounts[arg_15_1.id] then
		arg_15_0:AddOfficialAccounts(arg_15_1)
	else
		arg_15_0.officialAccounts[arg_15_1.id] = arg_15_1
	end

	return
end

function var_0_1.GetOfficialAccounts(arg_16_0)
	return arg_16_0.officialAccounts
end

function var_0_1.ShouldShowOfficialAccountsTip(arg_17_0)
	pairs = var_1_10001

	for iter_17_0, iter_17_1 in var_1_10001(arg_17_0.officialAccounts) do
		if iter_17_1:ShouldShowTip() then
			return true
		end
	end

	return
end

function var_0_1.ShouldShowTip(arg_18_0)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.GetMessages(var_18_0)

	_ = var_18_0

	return var_18_0.any(var_18_1, function(arg_19_0)
		return arg_19_0:ShouldShowTip()
	end)
end

function var_0_1.GetNewInstagramIds()
	local var_20_0 = {}

	ipairs = var_1_10001
	pg = var_1_10002

	for iter_20_0, iter_20_1 in var_1_10001(var_1_10002.activity_ins_template.all) do
		pg = var_1_10006

		if var_1_10006.activity_ins_template[iter_20_1].is_active ~= 1 then
			pg = var_1_10006
			var_1_10006 = var_1_10006.activity_ins_template[iter_20_1].type
			InstagramConst = var_1_10007

			if var_1_10006 == var_1_10007.INSTAGRAM_TYPE.OFFICIAL_ACCOUNT then
				table = var_1_10006

				var_1_10006.insert(var_20_0, iter_20_1)
			end
		end
	end

	return var_20_0
end

function var_0_1.GetOldInstagramIds()
	local var_21_0 = {}

	ipairs = var_1_10001
	pg = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10001(var_1_10002.activity_ins_template.all) do
		pg = var_1_10006

		if var_1_10006.activity_ins_template[iter_21_1].is_active == 0 then
			table = var_1_10006

			var_1_10006.insert(var_21_0, iter_21_1)
		end
	end

	return var_21_0
end

function var_0_1.GetNextPushTime(arg_22_0)
	pg = var_1_10001

	local var_22_0 = var_1_10001.activity_ins_template.all
	local var_22_1
	local var_22_2

	ipairs = var_1_10004

	for iter_22_0, iter_22_1 in var_1_10004(var_22_0) do
		pg = var_1_10009

		local var_22_3 = var_1_10009.activity_ins_template[iter_22_1].type

		InstagramConst = var_1_10011

		if var_22_3 == var_1_10011.INSTAGRAM_TYPE.OFFICIAL_ACCOUNT then
			if arg_22_0.officialAccounts[iter_22_1] == nil then
				pg = var_10
				var_1_10011 = var_10.TimeMgr.GetInstance()

				local var_22_4 = var_10.parseTimeFromConfig(var_1_10011, var_1_10009.time)

				if var_22_1 == nil then
					var_22_1 = var_22_4
					var_22_2 = iter_22_1
				elseif var_22_4 < var_22_1 then
					var_22_1 = var_22_4
					var_22_2 = iter_22_1
				end
			end
		elseif var_1_10009.is_active == 1 then
			var_1_10011 = arg_22_0

			if arg_22_0.GetMessageById(var_1_10011, iter_22_1) == nil then
				pg = var_10
				var_1_10011 = var_10.TimeMgr.GetInstance()

				local var_22_5 = var_10.parseTimeFromConfig(var_1_10011, var_1_10009.time)

				if var_22_1 == nil then
					var_22_1 = var_22_5
					var_22_2 = iter_22_1
				elseif var_22_5 < var_22_1 then
					var_22_1 = var_22_5
					var_22_2 = iter_22_1
				end
			end
		end
	end

	return var_22_1, var_22_2
end

function var_0_1.AddInstagramTimer(arg_23_0)
	arg_23_0:RemoveInstagramTimer()

	local var_23_0, var_23_1 = arg_23_0:GetNextPushTime()

	if not var_23_0 then
		return
	end

	pg = var_1_10003

	local var_23_2 = var_1_10003.TimeMgr.GetInstance()
	local var_23_3 = var_23_0 - var_3.GetServerTime(var_23_2)

	math = var_23_2

	local var_23_4 = var_23_3 + var_23_2.Random(1, 3)

	local function var_23_5()
		pg = var_2_10000

		local var_24_0 = var_2_10000.m02
		local var_24_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_24_2 = var_2_10002.ACT_INSTAGRAM_OP
		local var_24_3 = {}

		ActivityConst = var_2_10004
		var_24_3.cmd = var_2_10004.INSTAGRAM_OP_ACTIVE
		var_24_3.arg1 = var_23_1

		var_24_1(var_24_0, var_24_2, var_24_3)

		return
	end

	if var_23_4 <= 0 then
		var_23_5()

		return
	end

	arg_23_0:RemoveInstagramTimer()

	Timer = var_5
	arg_23_0.timer = var_5.New(function()
		local var_25_0 = arg_23_0

		var_0.RemoveInstagramTimer(var_25_0)
		var_23_5()

		return
	end, var_23_4, 1)

	local var_23_6 = arg_23_0.timer

	var_5.Start(var_23_6)

	return
end

function var_0_1.RemoveInstagramTimer(arg_26_0)
	if arg_26_0.timer then
		local var_26_0 = arg_26_0.timer

		var_1.Stop(var_26_0)

		arg_26_0.timer = nil
	end

	return
end

function var_0_1.remove(arg_27_0)
	arg_27_0.isReqNewInstagramData = false

	arg_27_0:RemoveInstagramTimer()

	return
end

return var_0_1
