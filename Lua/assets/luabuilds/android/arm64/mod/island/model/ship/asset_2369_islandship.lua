local IslandShip = class("IslandShip", import("model.vo.BaseVO"))

IslandShip.STATE_NORMAL = 0
IslandShip.STATE_DELEGATION = 1
IslandShip.STATE_TECHNOLOGY = 2
IslandShip.STATE_RESTAURANT = 3

function IslandShip:Ctor(arg_1_1)
	self.id = arg_1_1.id or 0
	self.configId = self.id
	self.exp = arg_1_1.exp or 0
	self.level = arg_1_1.lv or 1
	self.breakLevel = arg_1_1.break_lv or 0
	self.energy = arg_1_1.power or 0
	self.recorverTime = arg_1_1.recover_time or 0
	self.unlockExtraAttLimit = (arg_1_1.up_limit_state or 0) == 1
	self.extraAttrs = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.extra_attr_list or {}) do
		self.extraAttrs[IslandShipAttr.GetAtrrName(iter_1_1.id)] = iter_1_1.value
	end

	local var_1_0 = {
		id = self:getConfig("skill_id")
	}

	var_1_0.level = arg_1_1.skill_lv or 0
	var_1_0.isUseToday = (arg_1_1.skill_use_state or 0) == 1
	self.skill = IslandShipSkill.New(var_1_0)
	self.maxEnerey = self:getConfig("power")

	self:InitMaxEnergy()

	self.maxLevel = 1

	self:InitMaxLevel()

	self.attrs = {}

	self:InitAttrs()

	self.maxExtraAttrs = {}

	self:InitMaxExtraAttrs()
	self:InitSkill()

	self.status = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.buff_list or {}) do
		table.insert(self.status, (IslandShipStatus.New(iter_1_3)))
	end

	self:InitEnergyRecoverTime()

	local var_1_1 = arg_1_1.work_place or {}

	self.state = var_1_1.type or 0
	self.stateId = var_1_1.place or 0
	self.cur_skin_id = arg_1_1.cur_skin_id

	return
end

function IslandShip:bindConfigTable()
	return pg.island_chara_template
end

function IslandShip:GetCantFollowTaskIdList()
	return self:getConfig("in_task")
end

function IslandShip:GetLevel()
	return self.level or 1
end

function IslandShip:GetExp()
	return self.exp or 0
end

function IslandShip:AddExp(arg_6_1)
	if self:IsMaxLevel() then
		return
	end

	self.exp = self.exp + arg_6_1

	while self:CanUpgrade() do
		self.exp = self.exp - self:GetTargetExp()
		self.level = self.level + 1

		self:InitAttrs()
	end

	if self:IsMaxLevel() then
		self.exp = 0
	end

	return
end

function IslandShip:CanUpgrade()
	return not self:IsMaxLevel() and self.exp >= self:GetTargetExp()
end

function IslandShip:GetTargetExp()
	if self:IsMaxLevel() then
		return 0
	end

	return pg.island_chara_level[self.level].level_up_exp
end

function IslandShip:IsMaxLevel()
	return self.level >= self.maxLevel
end

function IslandShip:InitMaxLevel()
	self.maxLevel = self:GetBreakLevel() * self:GetBreakPhaseValue()

	return
end

function IslandShip:GetMaxLevel()
	return self.maxLevel
end

function IslandShip:GetEnergy()
	return self.energy
end

function IslandShip:AddEnergy(arg_13_1)
	local var_13_0 = self:GetMaxEnergy()

	self.energy = var_13_0 < self.energy + arg_13_1 and var_13_0 or self.energy + arg_13_1

	return
end

function IslandShip:UpdateEnergy(arg_14_1)
	self.energy = arg_14_1

	return
end

function IslandShip:UpdateEnergyBeginRecoverTime(arg_15_1)
	self.recorverTime = arg_15_1

	return
end

function IslandShip:GetMaxEnergy()
	return self.maxEnerey
end

function IslandShip:InitMaxEnergy(arg_17_1)
	local var_17_0 = self:getConfig("upgrade_power")
	local var_17_1 = 0

	for iter_17_0 = 1, self:GetBreakLevel() do
		var_17_1 = var_17_1 + (var_17_0[iter_17_0] or 0)
	end

	self.maxEnerey = self:getConfig("power") + var_17_1

	if not arg_17_1 then
		return
	end

	if self.maxEnerey - self.maxEnerey > 0 then
		self.energy = self.maxEnerey - (self.maxEnerey - self.energy)
	end

	return
end

function IslandShip:InitEnergyRecoverTime()
	self.recoverSpeed = self:getConfig("power_recover")

	return
end

function IslandShip:GetSkillAddRecoverSpeed()
	local var_19_0 = 0

	if self.skill then
		for iter_19_0, iter_19_1 in ipairs((self.skill:GetUnlockShipEffectIds())) do
			if pg.island_buff_template[iter_19_1].buff_type == IslandBuffType.SHIP_POWER_RECOVER then
				var_19_0 = var_19_0 + pg.island_buff_template[iter_19_1].type_use[1]
			end
		end
	end

	return var_19_0
end

function IslandShip:GetCurrentEnergy()
	if self:GetState() ~= IslandShip.STATE_NORMAL then
		return math.min(self.maxEnerey, self.energy)
	end

	local var_20_0 = pg.TimeMgr.GetInstance()
	local var_20_1 = var_20_0:GetServerTime()
	local var_20_2 = math.floor(self.energy + (var_20_1 - self.recorverTime) / self.recoverSpeed)

	if var_20_0 > 0 then
		var_20_2 = var_20_2 + math.floor(math.floor((var_20_1 - self.recorverTime) / self.recoverSpeed) * self:GetSkillAddRecoverSpeed() * 0.01)
	end

	local var_20_3 = self:GetVaildStatusByType(IslandBuffType.SHIP_POWER_RECOVER)

	if #var_20_3 == 0 then
		return math.min(self.maxEnerey, var_20_2)
	end

	return math.min(self.maxEnerey, var_20_2 + math.floor((function(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
		local var_21_0 = math.max(arg_21_0, arg_21_2)
		local var_21_1 = math.min(arg_21_1, arg_21_3)

		if var_21_0 < var_21_1 then
			return var_21_1 - var_21_0
		else
			return 0
		end

		return
	end)(self.recorverTime, var_20_1, var_20_3:GetStartTime(), var_20_3:GetEndTime()) / self.recoverSpeed * (var_20_3:GetBuffEffect()[1] * 0.01)))
end

function IslandShip:GetCurrentEnergyDecimal()
	local var_22_0 = pg.TimeMgr.GetInstance():GetServerTime()
	local var_22_1 = self.energy + (var_22_0 - self.recorverTime) / self.recoverSpeed
	local var_22_2 = self:GetVaildStatusByType(IslandBuffType.SHIP_POWER_RECOVER)
	local var_22_3 = self:GetSkillAddRecoverSpeed()

	if var_22_3 > 0 then
		var_22_1 = var_22_1 + (var_22_0 - self.recorverTime) / self.recoverSpeed * var_22_3 * 0.01
	end

	if #var_22_2 == 0 then
		return math.min(self.maxEnerey, var_22_1)
	end

	return math.min(self.maxEnerey, var_22_1 + (function(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
		local var_23_0 = math.max(arg_23_0, arg_23_2)
		local var_23_1 = math.min(arg_23_1, arg_23_3)

		if var_23_0 < var_23_1 then
			return var_23_1 - var_23_0
		else
			return 0
		end

		return
	end)(self.recorverTime, var_22_0, var_22_2:GetStartTime(), var_22_2:GetEndTime()) / self.recoverSpeed * (var_22_2:GetBuffEffect()[1] * 0.01))
end

function IslandShip:GetEnergyMaxTime()
	local var_24_0 = pg.TimeMgr.GetInstance()
	local var_24_1 = var_24_0:GetServerTime()
	local var_24_2 = self.maxEnerey - self:GetCurrentEnergyDecimal()
	local var_24_3 = self:GetVaildStatusByType(IslandBuffType.SHIP_POWER_RECOVER)
	local var_24_4 = self.recoverSpeed / (1 + self:GetSkillAddRecoverSpeed() * 0.01)

	if #var_24_0 == 0 then
		return var_24_1 + math.floor(var_24_2 * var_24_4)
	end

	if var_24_1 <= var_24_3:GetEndTime() then
		local var_24_5 = var_24_4 / (1 + var_24_3:GetBuffEffect()[1] * 0.01)
		local var_24_6 = var_24_5 * (var_24_3:GetEndTime() - var_24_1)

		if var_24_2 <= var_24_6 then
			return var_24_1 + math.floor(var_24_2 / var_24_5)
		end

		return var_24_1 + math.floor((var_24_2 - var_24_6) / var_24_4) + math.floor(var_24_2 / var_24_5)
	end

	return var_24_1 + math.floor(var_24_2 * var_24_4)
end

function IslandShip:AnySkillCanUpgrade()
	return self:CanUpgradeSkill()
end

function IslandShip:HasStatus()
	return table.getCount(self:GetVaildStatus()) > 0
end

function IslandShip:GetPower()
	local var_27_0 = 0

	for iter_27_0, iter_27_1 in pairs(self:GetAttrs()) do
		var_27_0 = var_27_0 + iter_27_1
	end

	return self:GetLevel() * 1000000 + var_27_0
end

function IslandShip:GetName()
	return self:getConfig("name")
end

function IslandShip:GetEnName()
	return pg.island_unit_character[self:GetModelUnit()].english_name
end

function IslandShip:StaticGetName()
	return pg.island_chara_template[self].name
end

function IslandShip:GetPrefab()
	return IslandShip.StaticGetPrefab(self.configId)
end

function IslandShip:GetModelUnit()
	local var_32_0 = self:getConfig("unit_id")

	if self.cur_skin_id and self.cur_skin_id ~= 0 then
		var_32_0 = pg.island_skin_template[self.cur_skin_id].model

		local var_32_1 = getProxy(IslandProxy)

		if var_32_1 ~= 0 then
			var_32_0 = pg.island_skin_colordiff_template[var_32_1:GetIsland():GetCharacterAgency():GetCurrentSkinColorByShipId(self.id, self.cur_skin_id)].model
		end
	end

	return var_32_0
end

function IslandShip:GetCurrentSkinId()
	return self.cur_skin_id or 0
end

function IslandShip:GetModel()
	local var_34_0 = pg.island_unit_character[self:GetModelUnit()]

	return {
		model = var_34_0.model,
		animator = var_34_0.animator,
		personal_ani = var_34_0.personal_ani
	}
end

function IslandShip:GetModelBySkinAndColorId(arg_35_1, arg_35_2)
	local var_35_0 = self:getConfig("unit_id")

	if arg_35_1 and arg_35_1 ~= 0 then
		var_35_0 = pg.island_skin_template[arg_35_1].model

		if arg_35_2 ~= 0 then
			var_35_0 = pg.island_skin_colordiff_template[arg_35_2].model
		end
	end

	return var_35_0
end

function IslandShip:ChangeSkinId(arg_36_1)
	if self.cur_skin_id ~= arg_36_1 then
		self.cur_skin_id = arg_36_1
	end

	return
end

function IslandShip:GetCurSkinId()
	return self.cur_skin_id or 0
end

function IslandShip:GetNewShipWord()
	return ""
end

function IslandShip:GetShipGroup()
	return self.configId
end

function IslandShip:StaticGetPrefab()
	return pg.island_unit_character[pg.island_chara_template[self].unit_id].IslandShipIcon
end

function IslandShip:UpdateState(arg_41_1, arg_41_2)
	self.state = arg_41_1
	self.stateId = arg_41_2

	return
end

function IslandShip:GetState()
	if pg.TimeMgr.GetInstance():GetServerTime() >= self.recorverTime then
		return IslandShip.STATE_NORMAL
	end

	return self.state
end

function IslandShip:GetStateId()
	return self.stateId
end

function IslandShip:GetStatePlaceName()
	return switch(self.state, {
		[IslandShip.STATE_DELEGATION] = function()
			return pg.island_production_place[self.stateId].name
		end,
		[IslandShip.STATE_TECHNOLOGY] = function()
			return pg.island_production_place[self.stateId].name
		end,
		[IslandShip.STATE_RESTAURANT] = function()
			return pg.island_manage_restaurant[self.stateId].name
		end
	}, function()
		return ""
	end)
end

function IslandShip:IsDelegable()
	local var_49_0 = self:GetState() == IslandShip.STATE_NORMAL and not getProxy(IslandProxy):GetIsland():GetFollowerAgency():Following(self.id) or false

	return (false or nil) and true
end

function IslandShip:GetBreakLevel()
	return self.breakLevel
end

function IslandShip:GetBreakMaxLevel()
	return self:getConfig("upgrade_level")[2] + 1
end

function IslandShip:GetBreakPhaseValue()
	return self:getConfig("upgrade_level")[1]
end

function IslandShip:IsMaxBreakLevel()
	return self:GetBreakMaxLevel() <= self:GetBreakLevel()
end

function IslandShip:CanBreakOut()
	if self:IsMaxBreakLevel() then
		return false
	end

	return self.level % self:GetBreakPhaseValue() == 0
end

function IslandShip:UpgradeBreakOut()
	self.breakLevel = self.breakLevel + 1

	self:InitMaxLevel()

	local var_55_0 = self:GetMaxEnergy()

	self:InitMaxEnergy(true)

	local var_55_1 = self:GetMaxEnergy()

	if var_55_0 < var_55_1 then
		self.energy = var_55_1 - (var_55_0 - self:GetEnergy())
	end

	self:InitSkill()

	return
end

function IslandShip:GetBreakoutMatrials()
	local var_56_0 = {}

	for iter_56_0, iter_56_1 in ipairs(self:getConfig("upgrade_material")[self:GetBreakLevel()] or {}) do
		table.insert(var_56_0, {
			type = DROP_TYPE_ISLAND_ITEM,
			id = iter_56_1[1],
			count = iter_56_1[2]
		})
	end

	return var_56_0
end

function IslandShip:InitAttrs()
	local var_57_0 = self:GetBreakPhaseValue()
	local var_57_1 = math.floor(self.level / var_57_0)

	for iter_57_0, iter_57_1 in ipairs((self:getConfig("base_att"))) do
		self.attrs[IslandShipAttr.GetAtrrName(iter_57_1[1])] = iter_57_1[2]
	end

	for iter_57_2, iter_57_3 in ipairs((self:getConfig("growth_att"))) do
		local var_57_2 = IslandShipAttr.GetAtrrName(iter_57_3[1])
		local var_57_3 = 0

		for iter_57_4 = 1, var_57_1 do
			var_57_3 = var_57_3 + iter_57_3[2][iter_57_4] * var_57_0
		end

		if var_57_1 < #iter_57_3[2] then
			var_57_3 = var_57_3 + iter_57_3[2][var_57_1 + 1] * (self.level % var_57_0)
		end

		self.attrs[var_57_2] = self.attrs[var_57_2] + var_57_3
	end

	for iter_57_5, iter_57_6 in pairs(self.extraAttrs) do
		self.attrs[iter_57_5] = self.attrs[iter_57_5] + iter_57_6
	end

	for iter_57_7, iter_57_8 in pairs(self.attrs) do
		self.attrs[iter_57_7] = math.floor(iter_57_8)
	end

	return
end

function IslandShip:GetGrowthAtt()
	local var_58_0 = {}

	for iter_58_0, iter_58_1 in ipairs((self:getConfig("growth_att"))) do
		var_58_0[IslandShipAttr.GetAtrrName(iter_58_1[1])] = iter_58_1[2][self:GetBreakLevel()] or 0
	end

	return var_58_0
end

function IslandShip:GetAttrs()
	return self.attrs
end

function IslandShip:GetAttr(arg_60_1)
	return self.attrs[arg_60_1] or 0
end

function IslandShip:GetAttrGradeCnt(arg_61_1)
	local var_61_0 = 0

	for iter_61_0, iter_61_1 in pairs(self.attrs) do
		if arg_61_1 >= self:GetAttrGrade(iter_61_0) then
			var_61_0 = var_61_0 + 1
		end
	end

	return var_61_0
end

function IslandShip:GetAttrGradeByValue(arg_62_1)
	local var_62_0 = pg.island_chara_att.all[#pg.island_chara_att.all]

	for iter_62_0, iter_62_1 in ipairs(pg.island_chara_att.all) do
		if pg.island_chara_att[iter_62_1].range[1] <= arg_62_1 and arg_62_1 <= pg.island_chara_att[iter_62_1].range[2] then
			var_62_0 = iter_62_1

			break
		end
	end

	return var_62_0
end

function IslandShip:GetAttrGrade(arg_63_1)
	return self:GetAttrGradeByValue((self:GetAttr(arg_63_1)))
end

function IslandShip:GetAttrGradeName(arg_64_1)
	return pg.island_chara_att[self:GetAttrGrade(arg_64_1)].name
end

function IslandShip:GetAttrGradeEffect(arg_65_1)
	return pg.island_chara_att[self:GetAttrGrade(arg_65_1)].effect
end

function IslandShip:SetUnlockExtraAttLimit()
	self.unlockExtraAttLimit = true

	self:InitMaxExtraAttrs()

	return
end

function IslandShip:IsUnlockExtraAttLimit()
	return self.unlockExtraAttLimit
end

function IslandShip:InitMaxExtraAttrs()
	for iter_68_0, iter_68_1 in ipairs(self:getConfig("extra_max")) do
		self.maxExtraAttrs[IslandShipAttr.GetAtrrName(iter_68_1[1])] = self.unlockExtraAttLimit and iter_68_1[2][2] or iter_68_1[2][1]
	end

	return
end

function IslandShip:GetExtraAttrLimit(arg_69_1)
	return self.maxExtraAttrs[arg_69_1] or 0
end

function IslandShip:GetExtraAttrValue(arg_70_1)
	return self.extraAttrs[arg_70_1] or 0
end

function IslandShip:ExistPotency()
	for iter_71_0, iter_71_1 in pairs(IslandShipAttr.ATTRS) do
		if self:GetExtraAttrLimit(iter_71_1) > self:GetExtraAttrValue(iter_71_1) then
			return true
		end
	end

	return false
end

function IslandShip:AddExtraAttr(arg_72_1, arg_72_2)
	self.extraAttrs[arg_72_1] = math.min(self:GetExtraAttrValue(arg_72_1) + arg_72_2, (self:GetExtraAttrLimit(arg_72_1)))

	self:InitAttrs()

	return
end

function IslandShip:GetUpgradeExtraAttrConsume(arg_73_1)
	local var_73_0 = table.indexof(IslandShipAttr.ATTRS, arg_73_1)
	local var_73_1

	if var_73_0 <= 0 then
		do return {} end

		var_73_1 = {}
	end

	for iter_73_0, iter_73_1 in ipairs(self:getConfig("att_item")[var_73_0] or {}) do
		table.insert(var_73_1, {
			count = 1,
			type = DROP_TYPE_ISLAND_ITEM,
			id = iter_73_1
		})
	end

	return var_73_1
end

function IslandShip:GetExtraAttrLimitUnlockConsume()
	return {
		{
			id = 100000,
			count = 1,
			type = DROP_TYPE_ISLAND_ITEM
		}
	}
end

function IslandShip:InitSkill()
	if self:getConfig("skill_unlock") <= self:GetBreakLevel() then
		self.skill:Unlock()
	end

	return
end

function IslandShip:GetSkillUnlockLevel()
	return self:getConfig("skill_unlock")
end

function IslandShip:GetSkill()
	return self.skill
end

function IslandShip:CanUpgradeSkill()
	if not self.skill:IsUnlock() then
		return false
	end

	if self.skill:IsMaxLevel() then
		do return false end

		local var_78_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
	end

	return _.all(self.skill:GetUpgradeMaterial(), function(arg_79_0)
		return var_78_0:GetOwnCount(arg_79_0.id) >= arg_79_0.count
	end)
end

function IslandShip:HasGreetingSkill()
	local var_80_0 = self:GetSkill()

	return var_80_0 and var_80_0:IsUnlock() and var_80_0:IsGreetingType()
end

function IslandShip:ApplySkill(arg_81_1)
	self:GetSkill():Apply(self, arg_81_1)

	return
end

function IslandShip:GetVaildStatusByGroup(arg_82_1)
	return _.select(self.status, function(arg_83_0)
		return not arg_83_0:IsExpiration() and arg_83_0:GetGroup() == arg_82_1
	end)
end

function IslandShip:GetVaildStatus()
	return _.select(self.status, function(arg_85_0)
		return not arg_85_0:IsExpiration()
	end)
end

function IslandShip:GetVaildStatusByType(arg_86_1)
	return _.select(self.status, function(arg_87_0)
		return not arg_87_0:IsExpiration() and arg_87_0:GetBuffType() == arg_86_1
	end)
end

function IslandShip:GetDisplayStatus()
	return _.select(self.status, function(arg_89_0)
		return not arg_89_0:IsExpiration() and arg_89_0:CanDisplay()
	end)
end

function IslandShip:GetFavoriteGift()
	return self:getConfig("gift_id")
end

function IslandShip:IsFavoriteGift(arg_91_1)
	return _.any(self:GetFavoriteGift(), function(arg_92_0)
		return arg_92_0 == arg_91_1
	end)
end

function IslandShip:AddStatus(arg_93_1)
	local var_93_0 = _.detect(self.status, function(arg_94_0)
		return arg_94_0.id == arg_93_1.id
	end)

	if var_93_0 then
		table.removebyvalue(self.status, var_93_0)
	end

	local var_93_1 = self:GetVaildStatus()
	local var_93_2 = arg_93_1:GetDuelTypeList()
	local var_93_3 = _.detect(var_93_1, function(arg_95_0)
		return table.contains(var_93_2, arg_95_0:GetGroup())
	end)

	if var_93_3 then
		table.removebyvalue(self.status, var_93_3)
	end

	local var_93_4 = arg_93_1:GetDuelIdList()
	local var_93_5 = _.detect(var_93_1, function(arg_96_0)
		return table.contains(var_93_4, arg_96_0.id)
	end)

	if var_93_5 then
		table.removebyvalue(self.status, var_93_5)
	end

	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandShipAddBuff(self.id, arg_93_1.id))
	table.insert(self.status, arg_93_1)

	return
end

return IslandShip
