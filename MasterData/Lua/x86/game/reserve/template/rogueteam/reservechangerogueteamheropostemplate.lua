local ReserveChangeRogueTeamHeroPosTemplate = class("ReserveChangeRogueTeamHeroPosTemplate", (import("game.reserve.ReserveHeroPosTemplate")))

function ReserveChangeRogueTeamHeroPosTemplate:Ctor(arg_1_1)
	self.pos = arg_1_1
	self.hero_type = 1
	self.trial_id = 0
	self.hero_id = 0
	self.owner_id = BattleTeamData.NO_OWNER
end

function ReserveChangeRogueTeamHeroPosTemplate:SetOwnerID(arg_2_1)
	self.owner_id = arg_2_1
	self.hero_type = 3
end

function ReserveChangeRogueTeamHeroPosTemplate:UpdateServerData(arg_3_1, arg_3_2)
	self.pos = arg_3_2
	self.hero_type = arg_3_1.hero_type or 1

	if arg_3_1.hero_type == 2 then
		self.trial_id = arg_3_1.hero_id
		self.hero_id = HeroStandardSystemCfg[arg_3_1.hero_id].hero_id
	else
		self.hero_id = arg_3_1.hero_id or 0
	end

	self.owner_id = arg_3_1.owner_id or BattleTeamData.NO_OWNER
end

function ReserveChangeRogueTeamHeroPosTemplate:GetOwnerID()
	return self.owner_id
end

function ReserveChangeRogueTeamHeroPosTemplate:ConvertToSendData()
	local var_5_0 = {
		hero_type = self.hero_type
	}

	var_5_0.hero_id = self.hero_type == 1 and self.hero_id or self.trial_id
	var_5_0.owner_id = self.owner_id

	return var_5_0
end

return ReserveChangeRogueTeamHeroPosTemplate
