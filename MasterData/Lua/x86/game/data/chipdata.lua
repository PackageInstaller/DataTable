local var_0_0 = singletonClass("ChipData")

function var_0_0:Init()
	self.enabledChipManagerID_ = 0
	self.unlockChipManagerIDList_ = {}
	self.chipManagerList_ = {}

	for iter_1_0, iter_1_1 in ipairs(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_MANAGER]) do
		self.chipManagerList_[iter_1_1] = {}
	end

	self.unlockChipIDList_ = {}
	self.chipList_ = {}

	for iter_1_2, iter_1_3 in ipairs(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_CHIP]) do
		self.chipList_[iter_1_3] = {}
	end

	self.schemeList_ = {}
	self.unlockHeroChip_ = {}
	self.enabledheroChipList_ = {}

	for iter_1_4, iter_1_5 in pairs(ChipCfg.get_id_list_by_spec_char) do
		self.enabledheroChipList_[iter_1_4] = {
			0,
			0,
			0,
			0
		}
	end

	self.heroChipList_ = {}

	for iter_1_6, iter_1_7 in ipairs(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_HERO_CHIP]) do
		if self.heroChipList_[ChipCfg[iter_1_7].spec_char] then
			table.insert(self.heroChipList_[ChipCfg[iter_1_7].spec_char], iter_1_7)
		else
			self.heroChipList_[ChipCfg[iter_1_7].spec_char] = {}

			table.insert(self.heroChipList_[ChipCfg[iter_1_7].spec_char], iter_1_7)
		end
	end

	self.curEnabledChipManagerID_ = nil
	self.curChipManagerList_ = {}
	self.unlockCharChipIDList_ = {}
end

function var_0_0:InitData(arg_2_1)
	if arg_2_1.chip == nil then
		print("后端发送的芯片数据是空的")
	end

	self.enabledChipManagerID_ = arg_2_1.chip or 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.unlock_kernel_chip) do
		table.insert(self.unlockChipManagerIDList_, iter_2_1)
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.unlock_secondary_chip) do
		table.insert(self.unlockChipIDList_, iter_2_3)
	end

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.unlock_hero_chip) do
		table.insert(self.unlockHeroChip_, iter_2_5)
	end

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.proposals) do
		local var_2_0 = {}

		for iter_2_8, iter_2_9 in ipairs(iter_2_7.secondary) do
			table.insert(var_2_0, iter_2_9)
		end

		self.schemeList_[iter_2_7.id] = {
			id = iter_2_7.id,
			name = iter_2_7.name,
			chipList = var_2_0
		}
	end

	for iter_2_10, iter_2_11 in ipairs(arg_2_1.hero_chip_state) do
		for iter_2_12, iter_2_13 in ipairs(iter_2_11.secondary) do
			if iter_2_13 > 0 then
				self.enabledheroChipList_[iter_2_11.hero_id][ChipCfg[iter_2_13].role_type_id] = iter_2_13
			end
		end
	end

	for iter_2_14, iter_2_15 in ipairs(arg_2_1.unlock_reviser_chip) do
		table.insert(self.unlockCharChipIDList_, iter_2_15)
	end
end

function var_0_0.SetEnabledChipManagerID(arg_3_0, arg_3_1)
	if arg_3_1 == nil then
		print(debug.traceback("设置芯片数据时为空", 2))
	end

	arg_3_0.enabledChipManagerID_ = arg_3_1 or 0
end

function var_0_0:GetEnabledChipManagerID()
	return self.enabledChipManagerID_
end

function var_0_0:SetEnabledChipID(arg_5_1, arg_5_2)
	if table.keyof(self.chipManagerList_[arg_5_1], arg_5_2) then
		print(string.format("已经装备了芯片：", arg_5_2))

		return
	end

	if GameSetting.ai_secondary_chip_equip_num.value[1] <= #self.chipManagerList_[arg_5_1] then
		return
	end

	table.insert(self.chipManagerList_[arg_5_1], arg_5_2)
end

function var_0_0:RemoveChipID(arg_6_1, arg_6_2)
	local var_6_0 = table.keyof(self.chipManagerList_[arg_6_1], arg_6_2)

	if var_6_0 then
		table.remove(self.chipManagerList_[arg_6_1], var_6_0)
	end
end

function var_0_0:ResetChipManager(arg_7_1)
	self.chipManagerList_[arg_7_1] = {}
end

function var_0_0:GetChipManagerList()
	return self.chipManagerList_
end

function var_0_0:UnlockChipManager(arg_9_1)
	table.insert(self.unlockChipManagerIDList_, arg_9_1)
end

function var_0_0:GetUnlockChipManagerIDList()
	return self.unlockChipManagerIDList_
end

function var_0_0:GetChipList()
	return self.chipList_
end

function var_0_0:UnlockChip(arg_12_1)
	table.insert(self.unlockChipIDList_, arg_12_1)
end

function var_0_0:GetUnlockCharChipIDList()
	return self.unlockCharChipIDList_
end

function var_0_0:IsUnlockCharChip(arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(self.unlockCharChipIDList_) do
		if iter_14_1 == arg_14_1 then
			return true
		end
	end

	return false
end

function var_0_0:UnlockCharChip(arg_15_1)
	table.insert(self.unlockCharChipIDList_, arg_15_1)
end

function var_0_0:GetUnlockChipIDList()
	return self.unlockChipIDList_
end

function var_0_0:GetIsUnlockChip(arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(self.unlockChipIDList_) do
		if iter_17_1 == arg_17_1 then
			return true
		end
	end

	return false
end

function var_0_0:GetSchemeList()
	return self.schemeList_
end

function var_0_0:RenameChipScheme(arg_19_1, arg_19_2)
	self.schemeList_[arg_19_1].name = arg_19_2
end

function var_0_0:DeleteChipScheme(arg_20_1)
	self.schemeList_[arg_20_1] = nil
end

function var_0_0:SaveChipScheme(arg_21_1)
	self.schemeList_[arg_21_1.id] = arg_21_1
end

function var_0_0:GetHeroIsHaveChip(arg_22_1)
	return not not self.heroChipList_[arg_22_1]
end

function var_0_0:GetHeroChipsByHeroId(arg_23_1)
	return self.heroChipList_[arg_23_1]
end

function var_0_0:GetCurHeroChip(arg_24_1)
	return self.enabledheroChipList_[arg_24_1]
end

function var_0_0:GetUnlockHeroChipIDList()
	return self.unlockHeroChip_
end

function var_0_0:GetIsUnlockHeroChip(arg_26_1)
	for iter_26_0, iter_26_1 in pairs(self.unlockHeroChip_) do
		if iter_26_1 == arg_26_1 then
			return true
		end
	end

	return false
end

function var_0_0:GetHeroChipIsEnableByChipId(arg_27_1)
	return self.enabledheroChipList_[ChipCfg[arg_27_1].spec_char][ChipCfg[arg_27_1].role_type_id] == arg_27_1, self.enabledheroChipList_[ChipCfg[arg_27_1].spec_char][ChipCfg[arg_27_1].role_type_id]
end

function var_0_0:UnlockHeroChip(arg_28_1)
	table.insert(self.unlockHeroChip_, arg_28_1)
end

function var_0_0:EnableHeroChip(arg_29_1, arg_29_2, arg_29_3)
	self.enabledheroChipList_[arg_29_1][arg_29_3] = arg_29_2
end

function var_0_0:GetEnableAllChipList(arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = arg_30_3 or {}

	if arg_30_2 then
		for iter_30_0, iter_30_1 in ipairs(arg_30_2) do
			if self.enabledheroChipList_[iter_30_1] then
				for iter_30_2, iter_30_3 in pairs(self.enabledheroChipList_[iter_30_1]) do
					if iter_30_3 > 0 then
						table.insert(var_30_0, iter_30_3)
					end
				end
			end
		end
	else
		print("未传入出战英雄列表,专属芯片未传入战斗！！！！！！！！！！！！！！！")
	end

	return var_30_0
end

function var_0_0:GetEnableHeroChipIdByHeroId(arg_31_1)
	return self.enabledheroChipList_[arg_31_1]
end

function var_0_0:GetCurEnabledChipManagerID()
	return (self.curEnabledChipManagerID_ or nil) and (self.curEnabledChipManagerID_ or self:GetEnabledChipManagerID())
end

function var_0_0.SetCurEnabledChipManagerID(arg_33_0, arg_33_1)
	arg_33_0.curEnabledChipManagerID_ = arg_33_1
end

function var_0_0:GetCurChipManagerList(arg_34_1)
	return (self.curChipManagerList_[arg_34_1] or nil) and (self.curChipManagerList_[arg_34_1] or self:GetChipManagerList()[arg_34_1])
end

function var_0_0:SetCurChipManagerList(arg_35_1, arg_35_2)
	self.curChipManagerList_[arg_35_1] = deepClone(arg_35_2)
end

function var_0_0:InsertCurChipManagerList(arg_36_1, arg_36_2)
	ChipTools.InsertChip(self:GetCurChipManagerList(arg_36_1), arg_36_2)
end

function var_0_0:RemoveCurChipManagerList(arg_37_1, arg_37_2)
	ChipTools.RemoveChip(self:GetCurChipManagerList(arg_37_1), arg_37_2)
end

return var_0_0
