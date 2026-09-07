local IslandVisitorLog = class("IslandVisitorLog")

function IslandVisitorLog:Ctor(arg_1_1)
	self.id = arg_1_1.id or ""
	self.name = arg_1_1.name or ""
	self.time = arg_1_1.time or 0
	self.cmd = arg_1_1.cmd or 1
	self.mapId = arg_1_1.mapId
	self.extraInfo = arg_1_1.extraInfo

	return
end

function IslandVisitorLog:IsSelf()
	return self.id == getProxy(PlayerProxy):getRawData().id
end

function IslandVisitorLog:IsCmdEnterOrExit()
	return self.cmd == IslandConst.VISITOR_LOG_CMD_ENTER or self.cmd == IslandConst.VISITOR_LOG_CMD_EXIT
end

function IslandVisitorLog:GetTime()
	return (pg.TimeMgr.GetInstance():STimeDescS(self.time, "%m.%d %H:%M"))
end

function IslandVisitorLog:GetTimeWithoutHAndM()
	return (pg.TimeMgr.GetInstance():STimeDescS(self.time, "- %m.%d -"))
end

function IslandVisitorLog:GetName()
	return self.name
end

function IslandVisitorLog:GetOpDesc()
	if self.cmd == IslandConst.VISITOR_LOG_CMD_ENTER then
		return i18n("island_log_visit")
	elseif self.cmd == IslandConst.VISITOR_LOG_CMD_EXIT then
		return i18n("island_log_exit")
	elseif self.cmd == IslandConst.VISITOR_LOG_CMD_GIFT then
		return i18n("island_log_gift")
	elseif self.cmd == IslandConst.VISITOR_LOG_CMD_TRADE then
		return i18n("island_log_trade")
	end

	return ""
end

function IslandVisitorLog:_Build(arg_8_1)
	local var_8_0 = ""

	if self.cmd == IslandConst.VISITOR_LOG_CMD_ENTER then
		var_8_0 = arg_8_1 .. " " .. self.name .. i18n("island_log_visit")
	elseif self.cmd == IslandConst.VISITOR_LOG_CMD_EXIT then
		var_8_0 = arg_8_1 .. " " .. self.name .. i18n("island_log_exit")
	elseif self.cmd == IslandConst.VISITOR_LOG_CMD_GIFT then
		var_8_0 = arg_8_1 .. " " .. self.name .. i18n("island_log_gift")
	elseif self.cmd == IslandConst.VISITOR_LOG_CMD_TRADE then
		var_8_0 = arg_8_1 .. " " .. i18n("island_trade_msg_pop", self.name, pg.island_map[self.mapId].name, self.extraInfo)
	end

	return var_8_0
end

function IslandVisitorLog:Build()
	return self:_Build((pg.TimeMgr.GetInstance():STimeDescS(self.time, "%Y/%m/%d %H:%M")))
end

function IslandVisitorLog:BuildWhitoutTime()
	return self:_Build("")
end

return IslandVisitorLog
