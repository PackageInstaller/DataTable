local IslandTicket = class("IslandTicket", import("model.vo.BaseVO"))

IslandTicket.TYPES = {
	ONE_HOUR = 3,
	TEN_MINUTE = 2,
	ONE_MINUTE = 1
}
IslandTicket.TYPE2BG = {
	[IslandTicket.TYPES.ONE_MINUTE] = "bg_blue",
	[IslandTicket.TYPES.TEN_MINUTE] = "bg_purple",
	[IslandTicket.TYPES.ONE_HOUR] = "bg_gold"
}
IslandTicket.TYPE2FRAME = {
	[IslandTicket.TYPES.ONE_MINUTE] = "rarity_blue",
	[IslandTicket.TYPES.TEN_MINUTE] = "rarity_purple",
	[IslandTicket.TYPES.ONE_HOUR] = "rarity_orange"
}

function IslandTicket:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.id = arg_1_1
	self.configId = self.id
	self.count = arg_1_3
	self.endTime = arg_1_2

	return
end

function IslandTicket:bindConfigTable()
	return pg.island_speedup_ticket
end

function IslandTicket:GetType()
	return self:getConfig("type")
end

function IslandTicket:GetTime()
	return self:getConfig("speedup_time")
end

function IslandTicket:GetBgName()
	return IslandTicket.TYPE2BG[self:GetType()]
end

function IslandTicket:GetFrameName()
	return IslandTicket.TYPE2FRAME[self:GetType()]
end

function IslandTicket:GetIconName()
	return "island/" .. self:getConfig("icon")
end

function IslandTicket:GetCount()
	return self.count
end

function IslandTicket:AddCount(arg_9_1)
	self.count = self.count + arg_9_1

	return
end

function IslandTicket:ReduceCount(arg_10_1)
	self.count = self.count - arg_10_1

	return
end

function IslandTicket:IsEmpty()
	return self.count <= 0
end

function IslandTicket:IsForever()
	return self.endTime == 0
end

function IslandTicket:GetEndTime()
	return self.endTime
end

function IslandTicket:GetRemainTime()
	return self.endTime - pg.TimeMgr.GetInstance():GetServerTime()
end

function IslandTicket:IsExpired()
	if self:IsForever() then
		return false
	end

	return self:GetRemainTime() < 0
end

function IslandTicket:WillExpire()
	if self:IsForever() then
		return false
	end

	local var_16_0 = self:GetRemainTime()

	return var_16_0 > 0 and var_16_0 < 0
end

function IslandTicket:GetEndTimeById(arg_17_1)
	if pg.island_speedup_ticket[self].expiration_type == 2 then
		if pg.island_speedup_ticket[self].expiration_time == "always" then
			return 0
		end

		return pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.island_speedup_ticket[self].expiration_time)
	elseif pg.island_speedup_ticket[self].expiration_type == 1 then
		local var_17_0

		if not arg_17_1 then
			::label_17_0::

			var_17_0 = pg.TimeMgr.GetInstance():GetTimeToNextTime() - 0
		end

		return var_17_0 + 0 * pg.island_speedup_ticket[self].duration - 1
	end

	return 0
end

return IslandTicket
