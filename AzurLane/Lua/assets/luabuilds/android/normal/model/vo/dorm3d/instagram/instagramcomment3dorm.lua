class = var_0_10000

local var_0_0 = var_0_10000("InstagramComment3Dorm")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.shipGroupId = arg_1_1
	arg_1_0.text = arg_1_2 or ""
	arg_1_0.time = arg_1_3 or 0
	arg_1_0.npcReplayList = var_0_0.BuildNpcReplayList(arg_1_4, arg_1_0.time)

	return
end

function var_0_0.GetIcon(arg_2_0)
	ShipGroup = var_1_10001

	local var_2_0 = var_1_10001.getDefaultShipConfig(arg_2_0.shipGroupId).skin_id

	pg = var_1_10003

	return var_1_10003.ship_skin_template[var_2_0].prefab
end

function var_0_0.GetPushTime(arg_3_0)
	InstagramTimeStamp = var_1_10001

	return var_1_10001(arg_3_0.time)
end

function var_0_0.GetText(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.dorm3d_ins_language[arg_4_0.text].value

	HXSet = var_2

	return (var_2.hxLan(var_4_0))
end

function var_0_0.StaticBuild(arg_5_0, arg_5_1)
	pg = var_1_10002

	local var_5_0 = var_1_10002.dorm3d_ins_npc_template[arg_5_0].message
	local var_5_1 = arg_5_1 + var_3.time
	local var_5_2 = {}

	type = var_1_10007

	if var_1_10007(var_3.npc_reply) == "table" then
		var_5_2 = var_3.npc_reply
	end

	InstagramComment3Dorm = var_7

	return var_7.New(var_3.ship_group, var_5_0, var_5_1, var_5_2)
end

function var_0_0.BuildNpcReplayList(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0

	if arg_6_0 then
		type = var_1_10003

		if var_1_10003(arg_6_0) == "string" then
			var_6_0 = {}
		end

		local var_6_1 = {}

		ipairs = var_1_10004

		for iter_6_0, iter_6_1 in var_1_10004(var_6_0) do
			table = var_1_10009

			var_1_10009.insert(var_6_1, var_0_0.StaticBuild(iter_6_1, arg_6_1))
		end

		return var_6_1
	end
end

function var_0_0.ExistAnyReplay(arg_7_0)
	local var_7_0

	if #arg_7_0.npcReplayList > 0 then
		_ = var_1
		var_7_0 = var_1.any(arg_7_0.npcReplayList, function(arg_8_0)
			return arg_8_0:CanShow()
		end)
	else
		var_7_0 = false
	end

	if false then
		var_7_0 = true
	end

	return var_7_0
end

function var_0_0.GetReplyedList(arg_9_0)
	return arg_9_0.npcReplayList
end

function var_0_0.CanShow(arg_10_0)
	if arg_10_0.time > 0 then
		pg = var_1

		local var_10_0 = var_1.TimeMgr.GetInstance()
		local var_10_1

		if not (var_1.GetServerTime(var_10_0) >= arg_10_0.time) then
			var_10_1 = false
		else
			var_10_1 = true
		end

		return var_10_1
	end
end

function var_0_0.ShouldTip(arg_11_0, arg_11_1)
	if not (arg_11_1 < arg_11_0.time) then
		if arg_11_0:ExistAnyReplay() then
			_ = var_11_0

			local var_11_0 = var_11_0.any(arg_11_0.npcReplayList, function(arg_12_0)
				local var_12_0

				if arg_12_0:CanShow() then
					var_12_0 = arg_12_0:ShouldTip(arg_11_1)
				end

				return var_12_0
			end)
		end

		if false then
			var_11_0 = false
		end
	else
		var_11_0 = true
	end

	return var_11_0
end

return var_0_0
