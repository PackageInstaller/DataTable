local var_0_0 = class("GuildLogInfo", import("..BaseVO"))

var_0_0.CMD_TYPE_JOIN = 1
var_0_0.CMD_TYPE_SET_DUTY = 2
var_0_0.CMD_TYPE_QUIT = 3
var_0_0.CMD_TYPE_FIRE = 4
var_0_0.CMD_TYPE_GET_SHIP = 5
var_0_0.CMD_TYPE_FACILITY_CONTRIBUTION = 6
var_0_0.CMD_TYPE_FACILITY_CONSUME = 7

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.cmd = arg_1_1.cmd
	arg_1_0.time = arg_1_1.time
	arg_1_0.userId = arg_1_1.user_id
	arg_1_0.name = arg_1_1.name
	arg_1_0.arg0 = {}

	local var_1_0 = arg_1_1.arg0 or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		table.insert(arg_1_0.arg0, iter_1_1)
	end

	arg_1_0.arg1 = arg_1_1.arg1

	return
end

function var_0_0.getConent(arg_2_0)
	local var_2_0 = getOfflineTimeStamp(arg_2_0.time)
	local var_2_1 = pg.TimeMgr.GetInstance():STimeDescC(arg_2_0.time, "[%m-%d %H:%M]")

	if arg_2_0.cmd == var_0_0.CMD_TYPE_JOIN then
		return i18n("guild_log_new_guild_join", arg_2_0.name), var_2_0
	elseif arg_2_0.cmd == var_0_0.CMD_TYPE_SET_DUTY then
		return i18n("guild_log_duty_change", arg_2_0.name, GuildMember.dutyId2Name(arg_2_0.arg1)), var_2_0
	elseif arg_2_0.cmd == var_0_0.CMD_TYPE_QUIT then
		return i18n("guild_log_quit", arg_2_0.name), var_2_0
	elseif arg_2_0.cmd == var_0_0.CMD_TYPE_FIRE then
		return i18n("guild_log_fire", arg_2_0.name), var_2_0
	elseif arg_2_0.cmd == var_0_0.CMD_TYPE_GET_SHIP then
		local var_2_2 = Ship.New({
			configId = arg_2_0.arg1
		})

		return {
			id = 3,
			args = {
				PublicArg.New({
					type = PublicArg.TypePlayerName,
					string = arg_2_0.name
				}),
				PublicArg.New({
					type = PublicArg.TypeShipId,
					int = arg_2_0.arg1
				})
			}
		}, var_2_0
	elseif arg_2_0.cmd == var_0_0.CMD_TYPE_FACILITY_CONTRIBUTION then
		return arg_2_0.name .. arg_2_0:getDuty(), var_2_1, i18n("word_contribution"), arg_2_0.arg0[1] .. Item.New({
			id = id2ItemId(arg_2_0.arg0[2])
		}):getConfig("name"), (i18n("guild_facility_get_gold", arg_2_0.arg0[3]))
	elseif arg_2_0.cmd == var_0_0.CMD_TYPE_FACILITY_CONSUME then
		local var_2_3 = ""

		if arg_2_0.arg0[2] then
			var_2_3 = i18n("guild_facility_upgrade", GuildFacility.New({
				id = arg_2_0.arg0[2]
			}):getConfig("name"), arg_2_0.arg0[3])
		end

		return arg_2_0.name .. arg_2_0:getDuty(), var_2_1, i18n("word_consume"), arg_2_0.arg0[1] .. i18n("word_guild_res"), var_2_3
	end

	return
end

function var_0_0.getDuty(arg_3_0)
	local var_3_0 = ""

	if arg_3_0.arg1 then
		var_3_0 = " （" .. GuildMember.dutyId2Name(arg_3_0.arg1) .. "）"
	end

	return var_3_0
end

return var_0_0
