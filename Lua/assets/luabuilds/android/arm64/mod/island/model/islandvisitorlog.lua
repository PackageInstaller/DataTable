local var_0_0 = class("IslandVisitorLog")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id or ""
	arg_1_0.name = arg_1_1.name or ""
	arg_1_0.time = arg_1_1.time or 0
	arg_1_0.cmd = arg_1_1.cmd or 1
	arg_1_0.mapId = arg_1_1.mapId
	arg_1_0.extraInfo = arg_1_1.extraInfo

	return
end

function var_0_0.IsSelf(arg_2_0)
	local var_2_0 = getProxy(PlayerProxy)

	return arg_2_0.id == var_2_0:getRawData().id
end

function var_0_0.IsCmdEnterOrExit(arg_3_0)
	return arg_3_0.cmd == IslandConst.VISITOR_LOG_CMD_ENTER or arg_3_0.cmd == IslandConst.VISITOR_LOG_CMD_EXIT
end

function var_0_0.GetTime(arg_4_0)
	return (pg.TimeMgr.GetInstance():STimeDescS(arg_4_0.time, "%m.%d %H:%M"))
end

function var_0_0.GetTimeWithoutHAndM(arg_5_0)
	return (pg.TimeMgr.GetInstance():STimeDescS(arg_5_0.time, "- %m.%d -"))
end

function var_0_0.GetName(arg_6_0)
	return arg_6_0.name
end

function var_0_0.GetOpDesc(arg_7_0)
	if arg_7_0.cmd == IslandConst.VISITOR_LOG_CMD_ENTER then
		return i18n("island_log_visit")
	elseif arg_7_0.cmd == IslandConst.VISITOR_LOG_CMD_EXIT then
		return i18n("island_log_exit")
	elseif arg_7_0.cmd == IslandConst.VISITOR_LOG_CMD_GIFT then
		return i18n("island_log_gift")
	elseif arg_7_0.cmd == IslandConst.VISITOR_LOG_CMD_TRADE then
		return i18n("island_log_trade")
	end

	return ""
end

function var_0_0._Build(arg_8_0, arg_8_1)
	local var_8_0 = ""

	if arg_8_0.cmd == IslandConst.VISITOR_LOG_CMD_ENTER then
		var_8_0 = arg_8_1 .. " " .. arg_8_0.name .. i18n("island_log_visit")
	elseif arg_8_0.cmd == IslandConst.VISITOR_LOG_CMD_EXIT then
		var_8_0 = arg_8_1 .. " " .. arg_8_0.name .. i18n("island_log_exit")
	elseif arg_8_0.cmd == IslandConst.VISITOR_LOG_CMD_GIFT then
		var_8_0 = arg_8_1 .. " " .. arg_8_0.name .. i18n("island_log_gift")
	elseif arg_8_0.cmd == IslandConst.VISITOR_LOG_CMD_TRADE then
		var_8_0 = arg_8_1 .. " " .. i18n("island_trade_msg_pop", arg_8_0.name, pg.island_map[arg_8_0.mapId].name, arg_8_0.extraInfo)
	end

	return var_8_0
end

function var_0_0.Build(arg_9_0)
	return arg_9_0:_Build((pg.TimeMgr.GetInstance():STimeDescS(arg_9_0.time, "%Y/%m/%d %H:%M")))
end

function var_0_0.BuildWhitoutTime(arg_10_0)
	return arg_10_0:_Build("")
end

return var_0_0
