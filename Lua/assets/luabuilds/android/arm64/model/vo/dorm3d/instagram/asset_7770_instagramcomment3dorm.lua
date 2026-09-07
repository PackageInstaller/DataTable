local InstagramComment3Dorm = class("InstagramComment3Dorm")

function InstagramComment3Dorm:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.shipGroupId = arg_1_1
	self.text = arg_1_2 or ""
	self.time = arg_1_3 or 0
	self.npcReplayList = InstagramComment3Dorm.BuildNpcReplayList(arg_1_4, self.time)

	return
end

function InstagramComment3Dorm:GetIcon()
	return pg.ship_skin_template[ShipGroup.getDefaultShipConfig(self.shipGroupId).skin_id].prefab
end

function InstagramComment3Dorm:GetPushTime()
	return InstagramTimeStamp(self.time)
end

function InstagramComment3Dorm:GetText()
	return (HXSet.hxLan(pg.dorm3d_ins_language[self.text].value))
end

function InstagramComment3Dorm:StaticBuild(arg_5_1)
	return InstagramComment3Dorm.New(pg.dorm3d_ins_npc_template[self].ship_group, pg.dorm3d_ins_npc_template[self].message, arg_5_1 + pg.dorm3d_ins_npc_template[self].time, (type(pg.dorm3d_ins_npc_template[self].npc_reply) == "table" or nil) and pg.dorm3d_ins_npc_template[self].npc_reply)
end

function InstagramComment3Dorm:BuildNpcReplayList(arg_6_1)
	local var_6_0 = self

	if not self or type(self) == "string" then
		var_6_0 = {}
	end

	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		table.insert(var_6_1, InstagramComment3Dorm.StaticBuild(iter_6_1, arg_6_1))
	end

	return var_6_1
end

function InstagramComment3Dorm:ExistAnyReplay()
	return #self.npcReplayList > 0 and _.any(self.npcReplayList, function(arg_8_0)
		return arg_8_0:CanShow()
	end)
end

function InstagramComment3Dorm:GetReplyedList()
	return self.npcReplayList
end

function InstagramComment3Dorm:CanShow()
	local var_10_0

	if self.time > 0 then
		if pg.TimeMgr.GetInstance():GetServerTime() < self.time then
			var_10_0 = false

			goto label_10_0
		end
	end

	::label_10_0::

	return true
end

function InstagramComment3Dorm:ShouldTip(arg_11_1)
	return arg_11_1 < self.time or self:ExistAnyReplay() and _.any(self.npcReplayList, function(arg_12_0)
		return arg_12_0:CanShow() and arg_12_0:ShouldTip(arg_11_1)
	end)
end

return InstagramComment3Dorm
