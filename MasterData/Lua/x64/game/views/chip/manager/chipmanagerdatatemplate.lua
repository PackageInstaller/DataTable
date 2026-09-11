local ChipManagerDataTemplate = class("ChipManagerDataTemplate")

function ChipManagerDataTemplate:Ctor(arg_1_1)
	self.enabledChipManagerID_ = 0
	self.unlockChipManagerIDList_ = {}
	self.unlockChipIDList_ = {}
	self.isNoRed = false

	self:InitData(arg_1_1)

	self.useChipmanagerId = 0
	self.useChipIdList = {}
end

function ChipManagerDataTemplate:InitData(arg_2_1)
	self.enabledChipManagerID_ = arg_2_1.id or 0
	self.unlockChipManagerIDList_ = arg_2_1.unlockChipManagerIDList_ or {}
	self.unlockChipIDList_ = arg_2_1.unlockChipIDList_ or {}
	self.isNoRed = arg_2_1.isNoRed
end

function ChipManagerDataTemplate:GetChipManagerIsUnLock(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(self.unlockChipManagerIDList_) do
		if iter_3_1 == arg_3_1 then
			return true
		end
	end

	return false
end

function ChipManagerDataTemplate:GetIsUnlockChip(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(self.unlockChipIDList_) do
		if iter_4_1 == arg_4_1 then
			return true
		end
	end

	return false
end

function ChipManagerDataTemplate:SetUseChipmanagerId(arg_5_1)
	self.useChipmanagerId = arg_5_1
end

function ChipManagerDataTemplate:SetUseChipId(arg_6_1)
	if #self.useChipIdList < GameSetting.ai_secondary_chip_equip_num.value[1] and not self:GetIsUesChipID(arg_6_1) then
		self.useChipIdList = self.useChipIdList or {}

		table.insert(self.useChipIdList, arg_6_1)
	end
end

function ChipManagerDataTemplate:SetNoUseChipId(arg_7_1)
	local var_7_0 = table.indexof(self.useChipIdList, arg_7_1)

	if self.useChipIdList[var_7_0] then
		table.remove(self.useChipIdList, var_7_0)
	end
end

function ChipManagerDataTemplate:GetIsUesChipID(arg_8_1)
	return table.indexof(self.useChipIdList, arg_8_1)
end

function ChipManagerDataTemplate:GetISUseChipmanager(arg_9_1)
	return self.useChipmanagerId == arg_9_1
end

function ChipManagerDataTemplate:SetTeamInfo(arg_10_1, arg_10_2, arg_10_3)
	self.stageType_ = arg_10_1
	self.stageID_ = arg_10_2
	self.sectionProxy_ = arg_10_3
	self.useChipmanagerId = arg_10_3:GetMimirID()
	self.useChipIdList = arg_10_3:GetMimirChipList()
end

function ChipManagerDataTemplate:SetReservesIndex(arg_11_1)
	self.reservesIndex_ = arg_11_1
end

function ChipManagerDataTemplate:SetChipInfoViewPath(arg_12_1)
	self.chipInfoPath = arg_12_1
end

function ChipManagerDataTemplate:GetChipInfoViewPath()
	return self.chipInfoPath or "/chipInfo"
end

function ChipManagerDataTemplate:SetChipSchemeViewPath(arg_14_1)
	self.chipSchemePath = arg_14_1
end

function ChipManagerDataTemplate:GetChipSchemeViewPath()
	return self.chipSchemePath or "/chipScheme"
end

function ChipManagerDataTemplate:GetEquipChipList()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(self.useChipIdList or {}) do
		table.insert(var_16_0, iter_16_1)
	end

	return var_16_0
end

return ChipManagerDataTemplate
