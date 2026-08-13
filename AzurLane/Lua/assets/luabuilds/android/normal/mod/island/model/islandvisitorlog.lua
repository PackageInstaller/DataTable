class = var_0_10000

local var_0_0 = var_0_10000("IslandVisitorLog")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1.id then
		var_1_0 = ""
	end

	arg_1_0.id = var_1_0

	local var_1_1

	if not arg_1_1.name then
		var_1_1 = ""
	end

	arg_1_0.name = var_1_1

	local var_1_2

	if not arg_1_1.time then
		var_1_2 = 0
	end

	arg_1_0.time = var_1_2

	local var_1_3

	if not arg_1_1.cmd then
		var_1_3 = 1
	end

	arg_1_0.cmd = var_1_3
	arg_1_0.mapId = arg_1_1.mapId
	arg_1_0.extraInfo = arg_1_1.extraInfo

	return
end

function var_0_0.IsSelf(arg_2_0)
	local var_2_0 = arg_2_0.id

	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_2_1 = var_1_10002(var_1_10003)

	return var_2_0 == var_2.getRawData(var_2_1).id
end

function var_0_0.IsCmdEnterOrExit(arg_3_0)
	local var_3_0 = arg_3_0.cmd

	IslandConst = var_1_10002

	local var_3_2

	if var_3_0 ~= var_1_10002.VISITOR_LOG_CMD_ENTER then
		local var_3_1 = arg_3_0.cmd

		IslandConst = var_2

		if var_3_1 ~= var_2.VISITOR_LOG_CMD_EXIT then
			var_3_2 = false

			goto label_3_0
		end
	end

	var_3_2 = true

	::label_3_0::

	return var_3_2
end

function var_0_0.GetTime(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.TimeMgr.GetInstance()

	return (var_1.STimeDescS(var_4_0, arg_4_0.time, "%m.%d %H:%M"))
end

function var_0_0.GetTimeWithoutHAndM(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.TimeMgr.GetInstance()

	return (var_1.STimeDescS(var_5_0, arg_5_0.time, "- %m.%d -"))
end

function var_0_0.GetName(arg_6_0)
	return arg_6_0.name
end

function var_0_0.GetOpDesc(arg_7_0)
	local var_7_0 = arg_7_0.cmd

	IslandConst = var_1_10002

	if var_7_0 == var_1_10002.VISITOR_LOG_CMD_ENTER then
		i18n = var_7_0

		return var_7_0("island_log_visit")
	else
		local var_7_1 = arg_7_0.cmd

		IslandConst = var_2

		if var_7_1 == var_2.VISITOR_LOG_CMD_EXIT then
			i18n = var_7_1

			return var_7_1("island_log_exit")
		else
			local var_7_2 = arg_7_0.cmd

			IslandConst = var_2

			if var_7_2 == var_2.VISITOR_LOG_CMD_GIFT then
				i18n = var_7_2

				return var_7_2("island_log_gift")
			else
				local var_7_3 = arg_7_0.cmd

				IslandConst = var_2

				if var_7_3 == var_2.VISITOR_LOG_CMD_TRADE then
					i18n = var_7_3

					return var_7_3("island_log_trade")
				end
			end
		end
	end

	return ""
end

function var_0_0._Build(arg_8_0, arg_8_1)
	local var_8_0 = ""
	local var_8_1 = arg_8_0.cmd

	IslandConst = var_1_10004

	local var_8_3

	if var_8_1 == var_1_10004.VISITOR_LOG_CMD_ENTER then
		local var_8_2 = arg_8_1

		var_8_3 = " "

		local var_8_4 = arg_8_0.name

		i18n = var_1_10006
		var_8_0 = var_8_2 .. var_8_3 .. var_8_4 .. var_1_10006("island_log_visit")
	else
		local var_8_5 = arg_8_0.cmd

		IslandConst = var_8_3

		local var_8_7

		if var_8_5 == var_8_3.VISITOR_LOG_CMD_EXIT then
			local var_8_6 = arg_8_1

			var_8_7 = " "

			local var_8_8 = arg_8_0.name

			i18n = var_1_10006
			var_8_0 = var_8_6 .. var_8_7 .. var_8_8 .. var_1_10006("island_log_exit")
		else
			local var_8_9 = arg_8_0.cmd

			IslandConst = var_8_7

			local var_8_11

			if var_8_9 == var_8_7.VISITOR_LOG_CMD_GIFT then
				local var_8_10 = arg_8_1

				var_8_11 = " "

				local var_8_12 = arg_8_0.name

				i18n = var_1_10006
				var_8_0 = var_8_10 .. var_8_11 .. var_8_12 .. var_1_10006("island_log_gift")
			else
				local var_8_13 = arg_8_0.cmd

				IslandConst = var_8_11

				if var_8_13 == var_8_11.VISITOR_LOG_CMD_TRADE then
					pg = var_8_13

					local var_8_14 = var_8_13.island_map[arg_8_0.mapId].name
					local var_8_15 = arg_8_1
					local var_8_16 = " "

					i18n = var_1_10006
					var_8_0 = var_8_15 .. var_8_16 .. var_1_10006("island_trade_msg_pop", arg_8_0.name, var_8_14, arg_8_0.extraInfo)
				end
			end
		end
	end

	return var_8_0
end

function var_0_0.Build(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.TimeMgr.GetInstance()
	local var_9_1 = var_1.STimeDescS(var_9_0, arg_9_0.time, "%Y/%m/%d %H:%M")

	return arg_9_0:_Build(var_9_1)
end

function var_0_0.BuildWhitoutTime(arg_10_0)
	return arg_10_0:_Build("")
end

return var_0_0
