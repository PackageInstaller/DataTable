local var_0_0 = class("InstagramProxy", import(".NetProxy"))
local var_0_1 = pg.activity_ins_language
local var_0_2 = pg.activity_ins_npc_template

function var_0_0.register(arg_1_0)
	arg_1_0.messages = {}
	arg_1_0.officialAccounts = {}
	arg_1_0.isReqNewInstagramData = false
	arg_1_0.isReqOldInstagramData = false
	arg_1_0.allReply = {}

	for iter_1_0, iter_1_1 in ipairs(var_0_2.all) do
		arg_1_0.allReply[iter_1_1] = (function(arg_2_0)
			local var_2_0 = arg_2_0.npc_reply_persist

			if type(arg_2_0.npc_reply_persist) == "string" then
				var_2_0 = {}
			end

			local var_2_1 = ""
			local var_2_2 = pg.TimeMgr.GetInstance():GetServerTime()

			if var_0_1[arg_2_0.message_persist] then
				var_2_1 = var_0_1[arg_2_0.message_persist].value
				var_2_2 = pg.TimeMgr.GetInstance():parseTimeFromConfig(arg_2_0.time_persist)
			end

			return {
				id = arg_2_0.id,
				time = var_2_2,
				text = var_2_1,
				npc_reply = var_2_0
			}
		end)(var_0_2[iter_1_1])
	end

	return
end

function var_0_0.IsReqOldInstagramData(arg_3_0)
	return arg_3_0.isReqOldInstagramData
end

function var_0_0.MarkOldInstagramData(arg_4_0)
	arg_4_0.isReqOldInstagramData = true

	return
end

function var_0_0.IsReqNewInstagramData(arg_5_0)
	return arg_5_0.isReqNewInstagramData
end

function var_0_0.MarkNewInstagramData(arg_6_0)
	arg_6_0.isReqNewInstagramData = true

	arg_6_0:AddInstagramTimer()

	return
end

function var_0_0.AddInstagram(arg_7_0, arg_7_1)
	if arg_7_1:getConfig("type") == InstagramConst.INSTAGRAM_TYPE.OFFICIAL_ACCOUNT then
		arg_7_0:AddOfficialAccounts(arg_7_1)
	else
		arg_7_0.messages[arg_7_1.id] = arg_7_1
	end

	return
end

function var_0_0.GetAllReply(arg_8_0)
	return arg_8_0.allReply
end

function var_0_0.GetMessages(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.messages) do
		table.insert({}, iter_9_1)
	end

	return {}
end

function var_0_0.ExistMessage(arg_10_0)
	return table.getCount(arg_10_0.messages) > 0
end

function var_0_0.GetData(arg_11_0)
	return arg_11_0.messages
end

function var_0_0.GetMessageById(arg_12_0, arg_12_1)
	return arg_12_0.messages[arg_12_1]
end

function var_0_0.UpdateMessage(arg_13_0, arg_13_1)
	if arg_13_1:getConfig("type") == InstagramConst.INSTAGRAM_TYPE.OFFICIAL_ACCOUNT then
		arg_13_0:UpdateOfficialAccounts(arg_13_1)
	elseif not arg_13_0.messages[arg_13_1.id] then
		arg_13_0:AddInstagram(arg_13_1)
	else
		arg_13_0.messages[arg_13_1.id] = arg_13_1
	end

	return
end

function var_0_0.AddOfficialAccounts(arg_14_0, arg_14_1)
	arg_14_0.officialAccounts[arg_14_1.id] = arg_14_1

	return
end

function var_0_0.UpdateOfficialAccounts(arg_15_0, arg_15_1)
	if not arg_15_0.officialAccounts[arg_15_1.id] then
		arg_15_0:AddOfficialAccounts(arg_15_1)
	else
		arg_15_0.officialAccounts[arg_15_1.id] = arg_15_1
	end

	return
end

function var_0_0.GetOfficialAccounts(arg_16_0)
	return arg_16_0.officialAccounts
end

function var_0_0.ShouldShowOfficialAccountsTip(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.officialAccounts) do
		if iter_17_1:ShouldShowTip() then
			return true
		end
	end

	return
end

function var_0_0.ShouldShowTip(arg_18_0)
	return _.any(arg_18_0:GetMessages(), function(arg_19_0)
		return arg_19_0:ShouldShowTip()
	end)
end

function var_0_0.GetNewInstagramIds()
	for iter_20_0, iter_20_1 in ipairs(pg.activity_ins_template.all) do
		if pg.activity_ins_template[iter_20_1].is_active == 1 or pg.activity_ins_template[iter_20_1].type == InstagramConst.INSTAGRAM_TYPE.OFFICIAL_ACCOUNT then
			table.insert({}, iter_20_1)
		end
	end

	return {}
end

function var_0_0.GetOldInstagramIds()
	for iter_21_0, iter_21_1 in ipairs(pg.activity_ins_template.all) do
		if pg.activity_ins_template[iter_21_1].is_active == 0 then
			table.insert({}, iter_21_1)
		end
	end

	return {}
end

function var_0_0.GetNextPushTime(arg_22_0)
	local var_22_0

	for iter_22_0, iter_22_1 in ipairs(pg.activity_ins_template.all) do
		local var_22_2

		if pg.activity_ins_template[iter_22_1].type == InstagramConst.INSTAGRAM_TYPE.OFFICIAL_ACCOUNT then
			if arg_22_0.officialAccounts[iter_22_1] == nil then
				local var_22_1 = pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.activity_ins_template[iter_22_1].time)

				if var_22_0 == nil then
					var_22_0 = var_22_1
					var_22_2 = iter_22_1
				elseif var_22_1 < var_22_0 then
					var_22_0 = var_22_1
					var_22_2 = iter_22_1
				end
			end
		elseif pg.activity_ins_template[iter_22_1].is_active == 1 and arg_22_0:GetMessageById(iter_22_1) == nil then
			local var_22_3 = pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.activity_ins_template[iter_22_1].time)

			if var_22_0 == nil then
				var_22_0 = var_22_3
				var_22_2 = iter_22_1
			elseif var_22_3 < var_22_0 then
				var_22_0 = var_22_3
				var_22_2 = iter_22_1
			end
		end
	end

	return var_22_0, nil
end

function var_0_0.AddInstagramTimer(arg_23_0)
	arg_23_0:RemoveInstagramTimer()

	local var_23_0, var_23_1 = arg_23_0:GetNextPushTime()

	if not var_23_0 then
		return
	end

	local var_23_2 = pg.TimeMgr.GetInstance()
	local var_23_3 = var_23_0 - var_23_2:GetServerTime() + math.Random(1, 3)

	local function var_23_4()
		pg.m02:sendNotification(GAME.ACT_INSTAGRAM_OP, {
			cmd = ActivityConst.INSTAGRAM_OP_ACTIVE,
			arg1 = var_23_1
		})

		return
	end

	if var_23_3 <= 0 then
		(function()
			pg.m02:sendNotification(GAME.ACT_INSTAGRAM_OP, {
				cmd = ActivityConst.INSTAGRAM_OP_ACTIVE,
				arg1 = var_23_1
			})

			return
		end)()

		return
	end

	arg_23_0:RemoveInstagramTimer()

	arg_23_0.timer = Timer.New(function()
		arg_23_0:RemoveInstagramTimer()
		var_23_4()

		return
	end, var_23_3, 1)

	arg_23_0.timer:Start()

	return
end

function var_0_0.RemoveInstagramTimer(arg_26_0)
	if arg_26_0.timer then
		arg_26_0.timer:Stop()

		arg_26_0.timer = nil
	end

	return
end

function var_0_0.remove(arg_27_0)
	arg_27_0.isReqNewInstagramData = false

	arg_27_0:RemoveInstagramTimer()

	return
end

return var_0_0
