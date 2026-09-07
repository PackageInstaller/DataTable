local GuildLogInfo = class("GuildLogInfo", import("..BaseVO"))

GuildLogInfo.CMD_TYPE_JOIN = 1
GuildLogInfo.CMD_TYPE_SET_DUTY = 2
GuildLogInfo.CMD_TYPE_QUIT = 3
GuildLogInfo.CMD_TYPE_FIRE = 4
GuildLogInfo.CMD_TYPE_GET_SHIP = 5
GuildLogInfo.CMD_TYPE_FACILITY_CONTRIBUTION = 6
GuildLogInfo.CMD_TYPE_FACILITY_CONSUME = 7

function GuildLogInfo:Ctor(arg_1_1)
	self.cmd = arg_1_1.cmd
	self.time = arg_1_1.time
	self.userId = arg_1_1.user_id
	self.name = arg_1_1.name
	self.arg0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.arg0 or {}) do
		table.insert(self.arg0, iter_1_1)
	end

	self.arg1 = arg_1_1.arg1

	return
end

function GuildLogInfo:getConent()
	local var_2_0 = getOfflineTimeStamp(self.time)
	local var_2_1 = pg.TimeMgr.GetInstance():STimeDescC(self.time, "[%m-%d %H:%M]")

	if self.cmd == GuildLogInfo.CMD_TYPE_JOIN then
		return i18n("guild_log_new_guild_join", self.name), var_2_0
	elseif self.cmd == GuildLogInfo.CMD_TYPE_SET_DUTY then
		return i18n("guild_log_duty_change", self.name, GuildMember.dutyId2Name(self.arg1)), var_2_0
	elseif self.cmd == GuildLogInfo.CMD_TYPE_QUIT then
		return i18n("guild_log_quit", self.name), var_2_0
	elseif self.cmd == GuildLogInfo.CMD_TYPE_FIRE then
		return i18n("guild_log_fire", self.name), var_2_0
	elseif self.cmd == GuildLogInfo.CMD_TYPE_GET_SHIP then
		local var_2_2 = Ship.New({
			configId = self.arg1
		})

		return {
			id = 3,
			args = {
				PublicArg.New({
					type = PublicArg.TypePlayerName,
					string = self.name
				}),
				PublicArg.New({
					type = PublicArg.TypeShipId,
					int = self.arg1
				})
			}
		}, var_2_0
	elseif self.cmd == GuildLogInfo.CMD_TYPE_FACILITY_CONTRIBUTION then
		return self.name .. self:getDuty(), var_2_1, i18n("word_contribution"), self.arg0[1] .. Item.New({
			id = id2ItemId(self.arg0[2])
		}):getConfig("name"), (i18n("guild_facility_get_gold", self.arg0[3]))
	elseif self.cmd == GuildLogInfo.CMD_TYPE_FACILITY_CONSUME then
		return self.name .. self:getDuty(), var_2_1, i18n("word_consume"), self.arg0[1] .. i18n("word_guild_res"), (self.arg0[2] or nil) and i18n("guild_facility_upgrade", GuildFacility.New({
			id = self.arg0[2]
		}):getConfig("name"), self.arg0[3])
	end

	return
end

function GuildLogInfo:getDuty()
	return (self.arg1 or nil) and " （" .. GuildMember.dutyId2Name(self.arg1) .. "）"
end

return GuildLogInfo
