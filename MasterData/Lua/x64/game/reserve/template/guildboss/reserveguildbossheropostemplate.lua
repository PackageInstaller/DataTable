local ReserveGuildBossHeroPosTemplate = class("ReserveGuildBossHeroPosTemplate", (import("game.reserve.ReserveHeroPosTemplate")))

function ReserveGuildBossHeroPosTemplate:Ctor(arg_1_1)
	self.pos = arg_1_1
	self.hero_type = 1
	self.trial_id = 0
	self.hero_id = 0
	self.owner_id = BattleTeamData.NO_OWNER
end

function ReserveGuildBossHeroPosTemplate:SetOwnerID(arg_2_1)
	self.owner_id = arg_2_1
	self.hero_type = 3
end

function ReserveGuildBossHeroPosTemplate:UpdateServerData(arg_3_1, arg_3_2)
	self.pos = arg_3_2
	self.hero_type = arg_3_1.hero_type or 1
	self.trial_id = 0
	self.hero_id = arg_3_1.hero_id or 0
	self.owner_id = arg_3_1.owner_id or BattleTeamData.NO_OWNER
end

function ReserveGuildBossHeroPosTemplate:UpdateClientData(arg_4_1, arg_4_2)
	self.pos = arg_4_2
	self.hero_type = arg_4_1.hero_type or 1
	self.trial_id = arg_4_1.trial_id
	self.hero_id = arg_4_1.hero_id
	self.owner_id = arg_4_1.owner_id or BattleTeamData.NO_OWNER
end

function ReserveGuildBossHeroPosTemplate:GetOwnerID()
	return self.owner_id
end

function ReserveGuildBossHeroPosTemplate:ConvertToSendData()
	local var_6_0 = {
		hero_type = self.hero_type
	}

	var_6_0.hero_id = self.hero_type == 1 and self.hero_id or self.trial_id
	var_6_0.owner_id = self.owner_id

	return var_6_0
end

return ReserveGuildBossHeroPosTemplate
