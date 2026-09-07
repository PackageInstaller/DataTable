local GuildMember = class("GuildMember", import("..Friend"))
local var_0_1 = {
	i18n("guild_word_commder"),
	i18n("guild_word_deputy_commder"),
	i18n("guild_word_picked"),
	i18n("guild_word_ordinary")
}

function GuildMember:IsAdministrator()
	return self == GuildConst.DUTY_COMMANDER or self == GuildConst.DUTY_DEPUTY_COMMANDER
end

function GuildMember:isCommander()
	return self == GuildConst.DUTY_COMMANDER
end

function GuildMember:dutyId2Name()
	return var_0_1[self]
end

function GuildMember:Ctor(arg_4_1)
	GuildMember.super.Ctor(self, arg_4_1)

	self.liveness = arg_4_1.liveness or 0
	self.duty = arg_4_1.duty or GuildConst.DUTY_RECRUIT
	self.joinTime = arg_4_1.join_time or 0
	self.assaultFleet = GuildAssaultFleet.New({
		user_id = self.id
	})
	self.externalAssaultFleet = GuildAssaultFleet.New({
		user_id = self.id
	})

	if self.icon == 1 then
		self.icon = 101171
	end

	return
end

function GuildMember:GetLiveness()
	return self.liveness
end

function GuildMember:IsRecruit()
	return self.duty == GuildConst.DUTY_RECRUIT
end

function GuildMember:AddLiveness(arg_7_1)
	print("add member liveness", arg_7_1)

	self.liveness = self.liveness + arg_7_1

	if self:CanUpgradeDuty() then
		self.duty = self.duty - 1
	end

	return
end

function GuildMember:CanUpgradeDuty()
	return self.duty == GuildConst.DUTY_RECRUIT and self.liveness >= pg.guildset.guild_active_become_regular.key_value
end

function GuildMember:UpdateExternalAssaultFleet(arg_9_1)
	self.externalAssaultFleet = arg_9_1

	return
end

function GuildMember:GetExternalAssaultFleet()
	return self.externalAssaultFleet
end

function GuildMember:UpdateAssaultFleet(arg_11_1)
	self.assaultFleet = arg_11_1

	return
end

function GuildMember:GetAssaultFleet()
	return self.assaultFleet
end

function GuildMember:UpdateAssaultFleetShips(arg_13_1, arg_13_2)
	self.assaultFleet:InitShips(arg_13_1, arg_13_2)

	return
end

function GuildMember:UpdateExternalAssaultFleetShips(arg_14_1, arg_14_2)
	self.externalAssaultFleet:InitShips(arg_14_1, arg_14_2)

	return
end

function GuildMember:isNewMember()
	local var_15_0 = pg.TimeMgr.GetInstance()

	if self.joinTime ~= 0 and var_15_0:IsSameDay(var_15_0:GetServerTime(), self.joinTime) then
		return true
	end

	return false
end

function GuildMember:setDuty(arg_16_1)
	self.duty = arg_16_1

	return
end

function GuildMember:GetDuty()
	return self.duty
end

function GuildMember:IsCommander()
	return self.duty == GuildConst.DUTY_COMMANDER
end

function GuildMember:isLongOffLine()
	return pg.TimeMgr.GetInstance():GetServerTime() - self.preOnLineTime > 0
end

function GuildMember:setDamage(arg_20_1)
	self.damage = arg_20_1

	return
end

function GuildMember:getDamage()
	if self.damage then
		return self.damage
	end

	return 0
end

function GuildMember:GetShip()
	return Ship.New({
		configId = self.icon,
		skin_id = self.skinId,
		name = self.name
	})
end

function GuildMember:GetJoinZeroTime()
	return pg.TimeMgr.GetInstance():GetNextTimeByTimeStamp(self.joinTime)
end

return GuildMember
