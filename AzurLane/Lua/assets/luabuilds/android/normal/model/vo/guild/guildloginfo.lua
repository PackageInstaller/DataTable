class = var_0_10000

local var_0_0 = "GuildLogInfo"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseVO"))

var_0_1.CMD_TYPE_JOIN = 1
var_0_1.CMD_TYPE_SET_DUTY = 2
var_0_1.CMD_TYPE_QUIT = 3
var_0_1.CMD_TYPE_FIRE = 4
var_0_1.CMD_TYPE_GET_SHIP = 5
var_0_1.CMD_TYPE_FACILITY_CONTRIBUTION = 6
var_0_1.CMD_TYPE_FACILITY_CONSUME = 7

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.cmd = arg_1_1.cmd
	arg_1_0.time = arg_1_1.time
	arg_1_0.userId = arg_1_1.user_id
	arg_1_0.name = arg_1_1.name
	arg_1_0.arg0 = {}
	ipairs = var_2

	local var_1_0

	if not arg_1_1.arg0 then
		var_1_0 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_0) do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.arg0, iter_1_1)
	end

	arg_1_0.arg1 = arg_1_1.arg1

	return
end

function var_0_1.getConent(arg_2_0)
	getOfflineTimeStamp = var_1_10001

	local var_2_0 = var_1_10001(arg_2_0.time)

	pg = var_2

	local var_2_1 = var_2.TimeMgr.GetInstance()
	local var_2_2 = var_2.STimeDescC(var_2_1, arg_2_0.time, "[%m-%d %H:%M]")

	if arg_2_0.cmd == var_0_1.CMD_TYPE_JOIN then
		i18n = var_3

		return var_3("guild_log_new_guild_join", arg_2_0.name), var_2_0
	else
		local var_2_4

		if arg_2_0.cmd == var_0_1.CMD_TYPE_SET_DUTY then
			i18n = var_3

			local var_2_3 = "guild_log_duty_change"

			var_2_4 = arg_2_0.name
			GuildMember = var_1_10006

			return var_3(var_2_3, var_2_4, var_1_10006.dutyId2Name(arg_2_0.arg1)), var_2_0
		elseif arg_2_0.cmd == var_0_1.CMD_TYPE_QUIT then
			i18n = var_3

			return var_3("guild_log_quit", arg_2_0.name), var_2_0
		elseif arg_2_0.cmd == var_0_1.CMD_TYPE_FIRE then
			i18n = var_3

			return var_3("guild_log_fire", arg_2_0.name), var_2_0
		elseif arg_2_0.cmd == var_0_1.CMD_TYPE_GET_SHIP then
			Ship = var_3

			local var_2_5 = var_3.New({
				configId = arg_2_0.arg1
			})
			local var_2_6 = {}

			PublicArg = var_2_4
			var_2_4 = var_2_4.New
			var_1_10006 = {}
			PublicArg = var_1_10007
			var_1_10006.type = var_1_10007.TypePlayerName
			var_1_10006.string = arg_2_0.name
			var_2_6[1] = var_2_4(var_1_10006)
			PublicArg = var_2_4
			var_2_4 = var_2_4.New
			var_1_10006 = {}
			PublicArg = var_7
			var_1_10006.type = var_7.TypeShipId
			var_1_10006.int = arg_2_0.arg1
			var_2_6[2] = var_2_4(var_1_10006)

			return {
				id = 3,
				args = var_2_6
			}, var_2_0
		elseif arg_2_0.cmd == var_0_1.CMD_TYPE_FACILITY_CONTRIBUTION then
			i18n = var_3

			local var_2_7 = var_3("word_contribution")

			Item = var_4

			local var_2_8 = var_4.New

			var_2_4 = {}
			id2ItemId = var_1_10006
			var_2_4.id = var_1_10006(arg_2_0.arg0[2])

			local var_2_9 = var_2_8(var_2_4)

			var_2_4 = arg_2_0.arg0[1] .. var_2_9:getConfig("name")
			i18n = var_6

			local var_2_10 = var_6("guild_facility_get_gold", arg_2_0.arg0[3])

			return arg_2_0.name .. arg_2_0:getDuty(), var_2_2, var_2_7, var_2_4, var_2_10
		elseif arg_2_0.cmd == var_0_1.CMD_TYPE_FACILITY_CONSUME then
			i18n = var_3

			local var_2_11 = var_3("word_consume")
			local var_2_12 = arg_2_0.arg0[1]

			i18n = var_2_4

			local var_2_13 = var_2_12 .. var_2_4("word_guild_res")
			local var_2_14 = ""

			if arg_2_0.arg0[2] then
				GuildFacility = var_6

				local var_2_15 = var_6.New({
					id = arg_2_0.arg0[2]
				})
				local var_2_16 = var_6.getConfig(var_2_15, "name")

				i18n = var_2_15
				var_2_14 = var_2_15("guild_facility_upgrade", var_2_16, arg_2_0.arg0[3])
			end

			return arg_2_0.name .. arg_2_0:getDuty(), var_2_2, var_2_11, var_2_13, var_2_14
		end
	end

	return
end

function var_0_1.getDuty(arg_3_0)
	local var_3_0 = ""

	if arg_3_0.arg1 then
		local var_3_1 = " （"

		GuildMember = var_1_10003
		var_3_0 = var_3_1 .. var_1_10003.dutyId2Name(arg_3_0.arg1) .. "）"
	end

	return var_3_0
end

return var_0_1
