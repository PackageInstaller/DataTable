local var_0_0 = class("InstagramComment3Dorm")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.shipGroupId = arg_1_1
	arg_1_0.text = arg_1_2 or ""
	arg_1_0.time = arg_1_3 or 0
	arg_1_0.npcReplayList = var_0_0.BuildNpcReplayList(arg_1_4, arg_1_0.time)

	return
end

function var_0_0.GetIcon(arg_2_0)
	return pg.ship_skin_template[ShipGroup.getDefaultShipConfig(arg_2_0.shipGroupId).skin_id].prefab
end

function var_0_0.GetPushTime(arg_3_0)
	return InstagramTimeStamp(arg_3_0.time)
end

function var_0_0.GetText(arg_4_0)
	return (HXSet.hxLan(pg.dorm3d_ins_language[arg_4_0.text].value))
end

function var_0_0.StaticBuild(arg_5_0, arg_5_1)
	local var_5_0 = {}

	if type(pg.dorm3d_ins_npc_template[arg_5_0].npc_reply) == "table" then
		var_5_0 = pg.dorm3d_ins_npc_template[arg_5_0].npc_reply
	end

	return InstagramComment3Dorm.New(pg.dorm3d_ins_npc_template[arg_5_0].ship_group, pg.dorm3d_ins_npc_template[arg_5_0].message, arg_5_1 + pg.dorm3d_ins_npc_template[arg_5_0].time, var_5_0)
end

function var_0_0.BuildNpcReplayList(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0

	if not arg_6_0 or type(arg_6_0) == "string" then
		var_6_0 = {}
	end

	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		table.insert(var_6_1, var_0_0.StaticBuild(iter_6_1, arg_6_1))
	end

	return var_6_1
end

function var_0_0.ExistAnyReplay(arg_7_0)
	return #arg_7_0.npcReplayList > 0 and _.any(arg_7_0.npcReplayList, function(arg_8_0)
		return arg_8_0:CanShow()
	end)
end

function var_0_0.GetReplyedList(arg_9_0)
	return arg_9_0.npcReplayList
end

function var_0_0.CanShow(arg_10_0)
	if arg_10_0.time > 0 then
		local var_10_0 = pg.TimeMgr.GetInstance():GetServerTime() >= arg_10_0.time

		return var_10_0
	end
end

function var_0_0.ShouldTip(arg_11_0, arg_11_1)
	return arg_11_1 < arg_11_0.time or arg_11_0:ExistAnyReplay() and _.any(arg_11_0.npcReplayList, function(arg_12_0)
		return arg_12_0:CanShow() and arg_12_0:ShouldTip(arg_11_1)
	end)
end

return var_0_0
