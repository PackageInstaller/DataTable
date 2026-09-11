local ReserveSingleTeamDataTemplate = class("ReserveSingleTeamDataTemplate")

function ReserveSingleTeamDataTemplate:Ctor(arg_1_1, arg_1_2)
	self.team_type = arg_1_1 or ReserveConst.RESERVE_TYPE.DEFAULT
	self.team_index = arg_1_2 or ReserveConst.DEFAULT_TEAM_INDEX
	self.hero_list = {}
	self.last_hero_list = {}
	self.cooperate_unique_skill_id = ReserveConst.DEFAULT_COMBO_SKILL_ID
	self.mimir_info = self:GetMimirDataClass().New()
	self.char_chip_id = 0

	for iter_1_0 = 1, ReserveConst.MAX_HERO_POS_COUNT do
		self.hero_list[iter_1_0] = self:GetHeroPosClass().New(iter_1_0)
	end
end

function ReserveSingleTeamDataTemplate:UpdateServerData(arg_2_1)
	self.team_index = arg_2_1.team_index
	self.hero_list = self.hero_list or {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.hero_list) do
		self.hero_list[iter_2_0]:UpdateServerData(iter_2_1, iter_2_0)
	end

	self.cooperate_unique_skill_id = arg_2_1.cooperate_unique_skill_id

	self.mimir_info:UpdateServerData(arg_2_1.mimir_info)

	self.char_chip_id = arg_2_1.mimir_info.hero_id or arg_2_1.char_chip_id or 0
end

function ReserveSingleTeamDataTemplate:GetTeamIndex()
	return self.team_index
end

function ReserveSingleTeamDataTemplate:SetTeamIndex(arg_4_1)
	self.team_index = arg_4_1 or ReserveConst.DEFAULT_TEAM_INDEX
end

function ReserveSingleTeamDataTemplate:SetTeamType(arg_5_1)
	self.team_type = arg_5_1
end

function ReserveSingleTeamDataTemplate:GetTeamType()
	return self.team_type
end

function ReserveSingleTeamDataTemplate:SetHeroList(arg_7_1, arg_7_2)
	arg_7_1 = arg_7_1 or {}
	arg_7_2 = arg_7_2 or {}

	self:SaveLastHeroList()

	for iter_7_0, iter_7_1 in ipairs(self:GetHeroList()) do
		self:SetHeroPosData(iter_7_0, arg_7_1[iter_7_0], arg_7_2[iter_7_0])
	end

	self:TryUpdateComboSkillID()
end

function ReserveSingleTeamDataTemplate:SaveLastHeroList()
	self.last_hero_list = deepClone(self.hero_list)
end

function ReserveSingleTeamDataTemplate:GetHeroList()
	return self.hero_list
end

function ReserveSingleTeamDataTemplate:GetLastHeroList()
	return self.last_hero_list
end

function ReserveSingleTeamDataTemplate:GetAddedHeroIDList()
	local var_11_0 = {}
	local var_11_1 = self:GetLastHeroList()

	if #var_11_1 == 0 then
		return var_11_0
	end

	local var_11_2 = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		var_11_2[iter_11_1:GetHeroID()] = true
	end

	for iter_11_2, iter_11_3 in ipairs(self:GetHeroList()) do
		if not var_11_2[iter_11_3:GetHeroID()] then
			var_11_0[#var_11_0 + 1] = iter_11_3:GetHeroID()
		end
	end

	return var_11_0
end

function ReserveSingleTeamDataTemplate:GetHeroPosData(arg_12_1)
	self.hero_list[arg_12_1] = self.hero_list[arg_12_1] or self:GetHeroPosClass().New(arg_12_1)

	return self.hero_list[arg_12_1]
end

function ReserveSingleTeamDataTemplate:SetHeroPosData(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = self:GetHeroPosData(arg_13_1)

	var_13_0:SetHeroID(arg_13_2)
	var_13_0:SetTrialID(arg_13_3)
end

function ReserveSingleTeamDataTemplate:TryUpdateComboSkillID()
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs((self:GetLastHeroList())) do
		var_14_0[iter_14_1:GetHeroID()] = true
	end

	local var_14_1 = true

	for iter_14_2, iter_14_3 in ipairs((self:GetHeroList())) do
		if not var_14_0[iter_14_3:GetHeroID()] then
			var_14_1 = false
		end
	end

	if not var_14_1 then
		self:UpdateComboSkillID()
	end
end

function ReserveSingleTeamDataTemplate:GetComboSkillID()
	return self.cooperate_unique_skill_id
end

function ReserveSingleTeamDataTemplate:SetComboSkillID(arg_16_1)
	arg_16_1 = arg_16_1 or ReserveConst.DEFAULT_COMBO_SKILL_ID
	self.cooperate_unique_skill_id = arg_16_1
end

function ReserveSingleTeamDataTemplate:UpdateComboSkillID()
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(self:GetHeroList()) do
		var_17_0[iter_17_0] = iter_17_1:GetHeroID()
	end

	self:SetComboSkillID(ComboSkillTools.GetRecommendSkillID(var_17_0, true))
end

function ReserveSingleTeamDataTemplate:GetMimirInfo()
	return self.mimir_info
end

function ReserveSingleTeamDataTemplate:GetMimirID()
	return self.mimir_info.mimir_id
end

function ReserveSingleTeamDataTemplate:SetMimirID(arg_20_1)
	arg_20_1 = arg_20_1 or 0
	self.mimir_info.mimir_id = arg_20_1

	if arg_20_1 ~= 0 then
		self:SetCharChipBaseID(0)
	end
end

function ReserveSingleTeamDataTemplate:GetMimirChipList()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(self.mimir_info.chip_list) do
		if ChipCfg[iter_21_1] and (ChipCfg[iter_21_1].type_id == ChipConst.TYPE_MANAGER or ChipCfg[iter_21_1].type_id == ChipConst.TYPE_CHIP) then
			table.insert(var_21_0, iter_21_1)
		end
	end

	return var_21_0
end

function ReserveSingleTeamDataTemplate:SetMimirChipList(arg_22_1)
	arg_22_1 = not arg_22_1 and {} or clone(arg_22_1)
	self.mimir_info.chip_list = arg_22_1
end

function ReserveSingleTeamDataTemplate:ResetMimirChipList()
	self.mimir_info.chip_list = {}
end

function ReserveSingleTeamDataTemplate:GetHeroPosClass()
	return ReserveTools.GetHeroPosDataClass(self:GetTeamType())
end

function ReserveSingleTeamDataTemplate:GetMimirDataClass()
	return ReserveTools.GetMimirDataClass(self:GetTeamType())
end

function ReserveSingleTeamDataTemplate:GetCharChipBaseID()
	return self.char_chip_id or 0
end

function ReserveSingleTeamDataTemplate:SetCharChipBaseID(arg_27_1)
	self.char_chip_id = arg_27_1 or 0

	if arg_27_1 ~= 0 then
		self:SetMimirID(0)
	end
end

function ReserveSingleTeamDataTemplate:Clone()
	return deepClone(self)
end

function ReserveSingleTeamDataTemplate:ConvertToSendData()
	local var_29_0 = {
		team_index = self:GetTeamIndex(),
		hero_list = {}
	}

	for iter_29_0, iter_29_1 in ipairs(self:GetHeroList()) do
		var_29_0.hero_list[iter_29_0] = iter_29_1:ConvertToSendData()
	end

	var_29_0.cooperate_unique_skill_id = self:GetComboSkillID()
	var_29_0.mimir_info = self:GetMimirInfo():ConvertToSendData()
	var_29_0.mimir_info.hero_id = self:GetCharChipBaseID()
	var_29_0.mimir_info.hero_chip_list = ChipTools.GetCharChipExtraIDListUnlock(self:GetCharChipBaseID())

	return var_29_0
end

function ReserveSingleTeamDataTemplate:Reset()
	for iter_30_0, iter_30_1 in ipairs(self.hero_list) do
		iter_30_1:Reset()
	end

	self.cooperate_unique_skill_id = ReserveConst.DEFAULT_COMBO_SKILL_ID

	self.mimir_info:Reset()
end

return ReserveSingleTeamDataTemplate
