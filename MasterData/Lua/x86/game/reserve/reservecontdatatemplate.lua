local ReserveContDataTemplate = class("ReserveContDataTemplate")

function ReserveContDataTemplate:Ctor(arg_1_1, arg_1_2)
	self.team_type = arg_1_1 or ReserveConst.RESERVE_TYPE.DEFAULT
	self.cont_id = arg_1_2 or ReserveConst.DETAULT_CONT_ID
	self.teams = {}
	self.team_dic = {}
	self.is_dirty = false
end

function ReserveContDataTemplate:UpdateServerData(arg_2_1)
	self.cont_id = arg_2_1.cont_id

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.teams) do
		self:GetSingleTeamData(iter_2_1.team_index):UpdateServerData(iter_2_1)
	end
end

function ReserveContDataTemplate:SetTeamType(arg_3_1)
	self.team_type = arg_3_1
end

function ReserveContDataTemplate:GetTeamType()
	return self.team_type
end

function ReserveContDataTemplate:GetContID()
	return self.cont_id
end

function ReserveContDataTemplate:SetContID(arg_6_1)
	self.cont_id = arg_6_1
end

function ReserveContDataTemplate:GetIsDirty()
	return self.is_dirty
end

function ReserveContDataTemplate:SetIsDirty(arg_8_1)
	self.is_dirty = arg_8_1
end

function ReserveContDataTemplate:GetHeroList(arg_9_1)
	return self:GetSingleTeamData(arg_9_1):GetHeroList()
end

function ReserveContDataTemplate:SetHeroList(arg_10_1, arg_10_2, arg_10_3)
	self:SetIsDirty(true)
	self:GetSingleTeamData(arg_10_3):SetHeroList(arg_10_1, arg_10_2)
end

function ReserveContDataTemplate:GetAddedHeroIDList(arg_11_1)
	return self:GetSingleTeamData(arg_11_1):GetAddedHeroIDList()
end

function ReserveContDataTemplate:GetComboSkillID(arg_12_1)
	return self:GetSingleTeamData(arg_12_1):GetComboSkillID()
end

function ReserveContDataTemplate:SetComboSkillID(arg_13_1, arg_13_2)
	self:SetIsDirty(true)
	self:GetSingleTeamData(arg_13_2):SetComboSkillID(arg_13_1)
end

function ReserveContDataTemplate:GetMimirID(arg_14_1)
	return self:GetSingleTeamData(arg_14_1):GetMimirID()
end

function ReserveContDataTemplate:SetMimirID(arg_15_1, arg_15_2)
	self:SetIsDirty(true)
	self:GetSingleTeamData(arg_15_2):SetMimirID(arg_15_1)
end

function ReserveContDataTemplate:GetMimirChipList(arg_16_1)
	return self:GetSingleTeamData(arg_16_1):GetMimirChipList()
end

function ReserveContDataTemplate:SetMimirChipList(arg_17_1, arg_17_2)
	self:SetIsDirty(true)
	self:GetSingleTeamData(arg_17_2):SetMimirChipList(arg_17_1)
end

function ReserveContDataTemplate:ResetMimirChipList(arg_18_1)
	self:GetSingleTeamData(arg_18_1):ResetMimirChipList()
end

function ReserveContDataTemplate:GetCharChipBaseID(arg_19_1)
	return self:GetSingleTeamData(arg_19_1):GetCharChipBaseID()
end

function ReserveContDataTemplate:SetCharChipBaseID(arg_20_1, arg_20_2)
	self:SetIsDirty(true)

	return self:GetSingleTeamData(arg_20_2):SetCharChipBaseID(arg_20_1)
end

function ReserveContDataTemplate:GetTeamDataList()
	return self.teams
end

function ReserveContDataTemplate:GetSingleTeamData(arg_22_1)
	arg_22_1 = arg_22_1 or self:GetTeamIndex()

	if not self.team_dic[arg_22_1] then
		self.team_dic[arg_22_1] = self:GetSingleTeamDataTemplateClass().New(self:GetTeamType(), arg_22_1)
		self.teams[#self.teams + 1] = self.team_dic[arg_22_1]
	end

	return self.team_dic[arg_22_1]
end

function ReserveContDataTemplate:SwapTeam(arg_23_1, arg_23_2)
	local var_23_0 = self:GetSingleTeamData(arg_23_1)
	local var_23_1 = self:GetSingleTeamData(arg_23_2)

	var_23_0:SetTeamIndex(arg_23_2)

	self.team_dic[arg_23_2] = var_23_0

	var_23_1:SetTeamIndex(arg_23_1)

	self.team_dic[arg_23_1] = var_23_1
end

function ReserveContDataTemplate:GetTeamIndex()
	return ReserveConst.DEFAULT_TEAM_INDEX
end

function ReserveContDataTemplate:GetTeamCount()
	return #self.teams
end

function ReserveContDataTemplate:CleanCacheData()
	if not self:GetIsDirty() then
		return
	end

	local var_26_0 = ReserveTools.GetReserveTemplateByReserveType(self:GetTeamType(), true):GetContDataTemplateById(self:GetContID())

	for iter_26_0, iter_26_1 in pairs(self.team_dic) do
		iter_26_1:UpdateServerData(var_26_0:GetSingleTeamData(iter_26_0))
	end

	self:SetIsDirty(false)
end

function ReserveContDataTemplate:Clone()
	return deepClone(self)
end

function ReserveContDataTemplate:GetSingleTeamDataTemplateClass()
	return ReserveTools.GetSingleTeamDataClass(self:GetTeamType())
end

function ReserveContDataTemplate:ConvertToSendData()
	local var_29_0 = {
		cont_id = self:GetContID(),
		teams = {}
	}

	for iter_29_0, iter_29_1 in ipairs(self.team_dic) do
		var_29_0.teams[iter_29_0] = iter_29_1:ConvertToSendData()
	end

	return var_29_0
end

function ReserveContDataTemplate:ConverAllTeamToSendData()
	local var_30_0 = {
		cont_id = self:GetContID(),
		teams = {}
	}

	for iter_30_0, iter_30_1 in ipairs(self.teams) do
		var_30_0.teams[iter_30_0] = iter_30_1:ConvertToSendData()
	end

	return var_30_0
end

function ReserveContDataTemplate:Reset()
	for iter_31_0, iter_31_1 in pairs(self.team_dic) do
		iter_31_1:Reset()
	end

	self.teams = {}
	self.team_dic = {}
	self.is_dirty = false
end

return ReserveContDataTemplate
