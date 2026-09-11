local ReserveHeroPosTemplate = class("ReserveHeroPosTemplate")

function ReserveHeroPosTemplate:Ctor(arg_1_1)
	self.pos = arg_1_1
	self.hero_type = 1
	self.trial_id = 0
	self.hero_id = 0
end

function ReserveHeroPosTemplate:UpdateServerData(arg_2_1, arg_2_2)
	self.pos = arg_2_2
	self.hero_type = arg_2_1.hero_type or 1

	if self.hero_type == 1 then
		self.trial_id = 0
		self.hero_id = arg_2_1.hero_id
	elseif self.hero_type == 2 then
		self.trial_id = arg_2_1.hero_id
		self.hero_id = HeroStandardSystemCfg[arg_2_1.hero_id].hero_id
	end
end

function ReserveHeroPosTemplate:GetHeroID()
	return self.hero_id
end

function ReserveHeroPosTemplate:SetHeroID(arg_4_1)
	self.hero_id = arg_4_1 or 0
end

function ReserveHeroPosTemplate:GetTrialID()
	return self.trial_id
end

function ReserveHeroPosTemplate:SetTrialID(arg_6_1)
	self.trial_id = arg_6_1 or 0
	self.hero_type = self.trial_id ~= 0 and 2 or 1
end

function ReserveHeroPosTemplate:GetHeroType()
	return self.hero_type
end

function ReserveHeroPosTemplate:ConvertToSendData()
	local var_8_0 = {}

	var_8_0.hero_id = self.hero_type == 1 and self.hero_id or self.trial_id
	var_8_0.hero_type = self.hero_type

	return var_8_0
end

function ReserveHeroPosTemplate:Reset()
	self.hero_type = 1
	self.trial_id = 0
	self.hero_id = 0
end

return ReserveHeroPosTemplate
