local var_0_0 = class("ChipManagerDataTemplate")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.enabledChipManagerID_ = 0
	arg_1_0.unlockChipManagerIDList_ = {}
	arg_1_0.unlockChipIDList_ = {}
	arg_1_0.isNoRed = false

	arg_1_0:InitData(arg_1_1)

	arg_1_0.useChipmanagerId = 0
	arg_1_0.useChipIdList = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	arg_2_0.enabledChipManagerID_ = arg_2_1.id or 0
	arg_2_0.unlockChipManagerIDList_ = arg_2_1.unlockChipManagerIDList_ or {}
	arg_2_0.unlockChipIDList_ = arg_2_1.unlockChipIDList_ or {}
	arg_2_0.isNoRed = arg_2_1.isNoRed
end

function var_0_0.GetChipManagerIsUnLock(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.unlockChipManagerIDList_) do
		if iter_3_1 == arg_3_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetIsUnlockChip(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.unlockChipIDList_) do
		if iter_4_1 == arg_4_1 then
			return true
		end
	end

	return false
end

function var_0_0.SetUseChipmanagerId(arg_5_0, arg_5_1)
	arg_5_0.useChipmanagerId = arg_5_1
end

function var_0_0.SetUseChipId(arg_6_0, arg_6_1)
	if #arg_6_0.useChipIdList < GameSetting.ai_secondary_chip_equip_num.value[1] and not arg_6_0:GetIsUesChipID(arg_6_1) then
		if not arg_6_0.useChipIdList then
			arg_6_0.useChipIdList = {}
		end

		table.insert(arg_6_0.useChipIdList, arg_6_1)
	end
end

function var_0_0.SetNoUseChipId(arg_7_0, arg_7_1)
	local var_7_0 = table.indexof(arg_7_0.useChipIdList, arg_7_1)

	if arg_7_0.useChipIdList[var_7_0] then
		table.remove(arg_7_0.useChipIdList, var_7_0)
	end
end

function var_0_0.GetIsUesChipID(arg_8_0, arg_8_1)
	return table.indexof(arg_8_0.useChipIdList, arg_8_1)
end

function var_0_0.GetISUseChipmanager(arg_9_0, arg_9_1)
	return arg_9_0.useChipmanagerId == arg_9_1
end

function var_0_0.SetTeamInfo(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.stageType_ = arg_10_1
	arg_10_0.stageID_ = arg_10_2
	arg_10_0.sectionProxy_ = arg_10_3
	arg_10_0.useChipmanagerId = arg_10_3:GetMimirID()
	arg_10_0.useChipIdList = arg_10_3:GetMimirChipList()
end

function var_0_0.SetReservesIndex(arg_11_0, arg_11_1)
	arg_11_0.reservesIndex_ = arg_11_1
end

function var_0_0.SetChipInfoViewPath(arg_12_0, arg_12_1)
	arg_12_0.chipInfoPath = arg_12_1
end

function var_0_0.GetChipInfoViewPath(arg_13_0)
	return arg_13_0.chipInfoPath or "/chipInfo"
end

function var_0_0.SetChipSchemeViewPath(arg_14_0, arg_14_1)
	arg_14_0.chipSchemePath = arg_14_1
end

function var_0_0.GetChipSchemeViewPath(arg_15_0)
	return arg_15_0.chipSchemePath or "/chipScheme"
end

function var_0_0.GetEquipChipList(arg_16_0)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_0.useChipIdList or {}) do
		table.insert(var_16_0, iter_16_1)
	end

	return var_16_0
end

return var_0_0
