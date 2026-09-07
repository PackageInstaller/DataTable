local ShipIndexConst = class("ShipIndexConst")

ShipIndexConst.SortRarity = bit.lshift(1, 0)
ShipIndexConst.SortLevel = bit.lshift(1, 1)
ShipIndexConst.SortPower = bit.lshift(1, 2)
ShipIndexConst.SortAchivedTime = bit.lshift(1, 3)
ShipIndexConst.SortIntimacy = bit.lshift(1, 4)
ShipIndexConst.SortEnergy = bit.lshift(1, 13)
ShipIndexConst.SortProperty_Cannon = bit.lshift(1, 5)
ShipIndexConst.SortProperty_Air = bit.lshift(1, 6)
ShipIndexConst.SortProperty_Dodge = bit.lshift(1, 7)
ShipIndexConst.SortProperty_AntiAircraft = bit.lshift(1, 8)
ShipIndexConst.SortProperty_Torpedo = bit.lshift(1, 9)
ShipIndexConst.SortProperty_Reload = bit.lshift(1, 10)
ShipIndexConst.SortProperty_Durability = bit.lshift(1, 11)
ShipIndexConst.SortProperty_Antisub = bit.lshift(1, 12)
ShipIndexConst.SortPropertyIndexs = {
	ShipIndexConst.SortProperty_Cannon,
	ShipIndexConst.SortProperty_Air,
	ShipIndexConst.SortProperty_Dodge,
	ShipIndexConst.SortProperty_AntiAircraft,
	ShipIndexConst.SortProperty_Torpedo,
	ShipIndexConst.SortProperty_Reload,
	ShipIndexConst.SortProperty_Durability,
	ShipIndexConst.SortProperty_Antisub
}
ShipIndexConst.RoleProgressBar = {
	ShipIndexConst.SortUnlockable,
	ShipIndexConst.SortGotLock,
	ShipIndexConst.SortNotGet
}
ShipIndexConst.SortPropertyAll = IndexConst.BitAll(ShipIndexConst.SortPropertyIndexs)

table.insert(ShipIndexConst.SortPropertyIndexs, 1, ShipIndexConst.SortPropertyAll)

ShipIndexConst.SortIndexs = {
	ShipIndexConst.SortRarity,
	ShipIndexConst.SortLevel,
	ShipIndexConst.SortPower,
	ShipIndexConst.SortAchivedTime,
	ShipIndexConst.SortIntimacy,
	ShipIndexConst.SortEnergy
}
ShipIndexConst.SortDefault = bit.lshift(1, 0)
ShipIndexConst.SortProgressBar = bit.lshift(1, 1)
ShipIndexConst.SortRoleStory = {
	ShipIndexConst.SortDefault,
	ShipIndexConst.SortProgressBar
}

function ShipIndexConst:getSortFuncAndName(arg_1_1)
	for iter_1_0 = 1, #ShipIndexCfg.sort do
		if bit.band(bit.lshift(1, iter_1_0 - 1), self) > 0 then
			return underscore.map(ShipIndexCfg.sort[iter_1_0].sortFuncs, function(arg_2_0)
				return function(arg_3_0)
					return (arg_1_1 and -1 or 1) * arg_2_0(arg_3_0)
				end
			end), ShipIndexCfg.sort[iter_1_0].name
		end
	end

	return
end

function ShipIndexConst:getSortName()
	for iter_4_0 = 1, #ShipIndexConst.SortRoleStory do
		if bit.band(bit.lshift(1, iter_4_0 - 1), self) > 0 then
			return iter_4_0
		end
	end

	return
end

ShipIndexConst.SortRoleStoryName = {
	"memory_filter_option_1",
	"memory_filter_option_2"
}
ShipIndexConst.SortNames = {
	"word_rarity",
	"word_lv",
	"word_synthesize_power",
	"word_achieved_item",
	"attribute_intimacy",
	"sort_energy"
}
ShipIndexConst.SortPropertyNames = {
	"sort_attribute",
	"word_attr_cannon",
	"word_attr_air",
	"word_attr_dodge",
	"word_attr_antiaircraft",
	"word_attr_torpedo",
	"word_attr_reload",
	"word_attr_durability",
	"word_attr_antisub"
}

function ShipIndexConst.sortByCombatPower()
	return {
		function(arg_6_0)
			return -arg_6_0:getShipCombatPower()
		end,
		function(arg_7_0)
			return arg_7_0.configId
		end
	}
end

function ShipIndexConst:sortByField()
	return {
		function(arg_9_0)
			return -arg_9_0[self]
		end,
		function(arg_10_0)
			return -arg_10_0:getRarity()
		end,
		function(arg_11_0)
			return arg_11_0.configId
		end
	}
end

function ShipIndexConst:sortByProperty()
	return {
		function(arg_13_0)
			return -arg_13_0:getShipProperties()[self]
		end,
		function(arg_14_0)
			return arg_14_0.configId
		end
	}
end

function ShipIndexConst:sortByCfg()
	return {
		function(arg_16_0)
			return -(self == "rarity" and arg_16_0:getRarity() or arg_16_0:getConfig(self))
		end,
		function(arg_17_0)
			return arg_17_0.configId
		end
	}
end

function ShipIndexConst.sortByIntimacy()
	return {
		function(arg_19_0)
			return -arg_19_0.intimacy
		end,
		function(arg_20_0)
			return arg_20_0.propose and 0 or 1
		end,
		function(arg_21_0)
			return arg_21_0.configId
		end,
		function(arg_22_0)
			return -arg_22_0.level
		end
	}
end

function ShipIndexConst.sortByEnergy()
	return {
		function(arg_24_0)
			return -arg_24_0:getEnergy()
		end,
		function(arg_25_0)
			return arg_25_0.configId
		end
	}
end

ShipIndexConst.TypeFront = bit.lshift(1, 0)
ShipIndexConst.TypeBack = bit.lshift(1, 1)
ShipIndexConst.TypeQuZhu = bit.lshift(1, 2)
ShipIndexConst.TypeQingXun = bit.lshift(1, 3)
ShipIndexConst.TypeZhongXun = bit.lshift(1, 4)
ShipIndexConst.TypeZhanLie = bit.lshift(1, 5)
ShipIndexConst.TypeHangMu = bit.lshift(1, 6)
ShipIndexConst.TypeWeiXiu = bit.lshift(1, 7)
ShipIndexConst.TypeQianTing = bit.lshift(1, 8)
ShipIndexConst.TypeOther = bit.lshift(1, 9)
ShipIndexConst.TypeIndexs = {
	ShipIndexConst.TypeFront,
	ShipIndexConst.TypeBack,
	ShipIndexConst.TypeQuZhu,
	ShipIndexConst.TypeQingXun,
	ShipIndexConst.TypeZhongXun,
	ShipIndexConst.TypeZhanLie,
	ShipIndexConst.TypeHangMu,
	ShipIndexConst.TypeWeiXiu,
	ShipIndexConst.TypeQianTing,
	ShipIndexConst.TypeOther
}
ShipIndexConst.TypeAll = IndexConst.BitAll(ShipIndexConst.TypeIndexs)

table.insert(ShipIndexConst.TypeIndexs, 1, ShipIndexConst.TypeAll)

ShipIndexConst.TypeNames = {
	"index_all",
	"index_fleetfront",
	"index_fleetrear",
	"index_shipType_quZhu",
	"index_shipType_qinXun",
	"index_shipType_zhongXun",
	"index_shipType_zhanLie",
	"index_shipType_hangMu",
	"index_shipType_weiXiu",
	"index_shipType_qianTing",
	"index_other"
}

function ShipIndexConst:filterByType(arg_26_1)
	if not arg_26_1 or arg_26_1 == ShipIndexConst.TypeAll then
		return true
	end

	for iter_26_0 = 2, #ShipIndexCfg.type do
		if bit.band(bit.lshift(1, iter_26_0 - 2), arg_26_1) > 0 then
			if iter_26_0 < 4 then
				if table.contains(ShipIndexCfg.type[iter_26_0].types, self:getShipType()) then
					return true
				end

				if table.contains(ShipIndexCfg.type[iter_26_0].types, self:getTeamType()) then
					return true
				end
			elseif table.contains(ShipIndexCfg.type[iter_26_0].types, self:getShipType()) then
				return true
			end
		end
	end

	return false
end

ShipIndexConst.SortUnlockable = bit.lshift(1, 0)
ShipIndexConst.SortGotLock = bit.lshift(1, 1)
ShipIndexConst.SortNotGet = bit.lshift(1, 2)
ShipIndexConst.RoleProgress = {
	ShipIndexConst.SortUnlockable,
	ShipIndexConst.SortGotLock,
	ShipIndexConst.SortNotGet
}
ShipIndexConst.All = IndexConst.BitAll(ShipIndexConst.RoleProgress)

table.insert(ShipIndexConst.RoleProgress, 1, ShipIndexConst.All)

ShipIndexConst.RoleProgressName = {
	"memory_filter_option_3",
	"memory_filter_option_4",
	"memory_filter_option_5",
	"memory_filter_option_6"
}

function ShipIndexConst:filterRoleProgressBar(arg_27_1)
	if not arg_27_1 or arg_27_1 == ShipIndexConst.ProgressAll then
		return true
	end

	local var_27_0 = getProxy(CollectionProxy):getShipGroup(self.ship_group)

	for iter_27_0 = 2, #RoleIndexCfg.progress do
		if bit.band(bit.lshift(1, iter_27_0 - 2), arg_27_1) > 0 then
			if #RoleIndexCfg.progress[iter_27_0].types == 0 then
				return true
			end

			for iter_27_1, iter_27_2 in ipairs(RoleIndexCfg.progress[iter_27_0].types) do
				if iter_27_2 == 1 then
					if var_27_0 then
						if not pg.NewStoryMgr.GetInstance():IsPlayed(pg.memory_template[self.memories[1]].story) and self.id ~= 501 then
							return true
						end
					end
				elseif iter_27_2 == 2 then
					if pg.NewStoryMgr.GetInstance():IsPlayed(pg.memory_template[self.memories[1]].story) then
						return true
					end
				elseif iter_27_2 == 3 and not var_27_0 then
					return true
				end
			end
		end
	end

	return false
end

local var_0_1 = {
	"CampUS",
	"CampEN",
	"CampJP",
	"CampDE",
	"CampCN",
	"CampITA",
	"CampSN",
	"CampFF",
	"CampMNF",
	"CampNL",
	"CampLDP",
	"CampMETA",
	"CampMot",
	"CampOther"
}

if LOCK_NATION_HNLMS then
	table.removebyvalue(var_0_1, "CampNL")
end

ShipIndexConst.CampIndexs = {}

for iter_0_0, iter_0_1 in ipairs(var_0_1) do
	ShipIndexConst[iter_0_1] = bit.lshift(1, iter_0_0 - 1)

	table.insert(ShipIndexConst.CampIndexs, ShipIndexConst[iter_0_1])
end

ShipIndexConst.CampAll = IndexConst.BitAll(ShipIndexConst.CampIndexs)

table.insert(ShipIndexConst.CampIndexs, 1, ShipIndexConst.CampAll)

ShipIndexConst.CampNames = {
	"word_shipNation_all",
	"word_shipNation_baiYing",
	"word_shipNation_huangJia",
	"word_shipNation_chongYing",
	"word_shipNation_tieXue",
	"word_shipNation_dongHuang",
	"word_shipNation_saDing",
	"word_shipNation_beiLian",
	"word_shipNation_ziyou",
	"word_shipNation_weixi",
	"word_shipNation_yujinwangguo",
	"word_shipNation_jinghuanlianmeng",
	"word_shipNation_meta_index",
	"word_shipNation_mot",
	"word_shipNation_other"
}

if LOCK_NATION_HNLMS then
	table.removebyvalue(ShipIndexConst.CampNames, "word_shipNation_yujinwangguo")
end

function ShipIndexConst:filterByCamp(arg_28_1)
	if not arg_28_1 or arg_28_1 == ShipIndexConst.CampAll then
		return true
	end

	local var_28_0 = underscore.to_array(ShipIndexCfg.camp)

	if LOCK_NATION_HNLMS then
		var_28_0 = underscore.filter(var_28_0, function(arg_29_0)
			return #arg_29_0.types ~= 1 or arg_29_0.types[1] ~= Nation.NL
		end)
	end

	for iter_28_0 = 2, #var_28_0 do
		if bit.band(bit.lshift(1, iter_28_0 - 2), arg_28_1) > 0 then
			for iter_28_1, iter_28_2 in ipairs(var_28_0[iter_28_0].types) do
				if iter_28_2 == Nation.LINK then
					if self:getNation() >= Nation.LINK then
						return true
					end
				elseif iter_28_2 == self:getNation() then
					return true
				end
			end
		end
	end

	return false
end

function ShipIndexConst:RolefilterByCamp(arg_30_1)
	if not arg_30_1 or arg_30_1 == ShipIndexConst.CampAll then
		return true
	end

	local var_30_0 = underscore.to_array(ShipIndexCfg.camp)

	if LOCK_NATION_HNLMS then
		var_30_0 = underscore.filter(var_30_0, function(arg_31_0)
			return #arg_31_0.types ~= 1 or arg_31_0.types[1] ~= Nation.NL
		end)
	end

	for iter_30_0 = 2, #var_30_0 do
		if bit.band(bit.lshift(1, iter_30_0 - 2), arg_30_1) > 0 then
			for iter_30_1, iter_30_2 in ipairs(var_30_0[iter_30_0].types) do
				if iter_30_2 == Nation.LINK then
					if self.nationality >= Nation.LINK then
						return true
					end
				elseif iter_30_2 == self.nationality then
					return true
				end
			end
		end
	end

	return false
end

ShipIndexConst.Rarity1 = bit.lshift(1, 0)
ShipIndexConst.Rarity2 = bit.lshift(1, 1)
ShipIndexConst.Rarity3 = bit.lshift(1, 2)
ShipIndexConst.Rarity4 = bit.lshift(1, 3)
ShipIndexConst.Rarity5 = bit.lshift(1, 4)
ShipIndexConst.RarityIndexs = {
	ShipIndexConst.Rarity1,
	ShipIndexConst.Rarity2,
	ShipIndexConst.Rarity3,
	ShipIndexConst.Rarity4,
	ShipIndexConst.Rarity5
}
ShipIndexConst.RarityAll = IndexConst.BitAll(ShipIndexConst.RarityIndexs)

table.insert(ShipIndexConst.RarityIndexs, 1, ShipIndexConst.RarityAll)

ShipIndexConst.RarityNames = {
	"index_all",
	"index_rare2",
	"index_rare3",
	"index_rare4",
	"index_rare5",
	"index_rare6"
}

function ShipIndexConst:filterByRarity(arg_32_1)
	if not arg_32_1 or arg_32_1 == ShipIndexConst.RarityAll then
		return true
	end

	for iter_32_0 = 2, #ShipIndexCfg.rarity do
		if bit.band(bit.lshift(1, iter_32_0 - 2), arg_32_1) > 0 and table.contains(ShipIndexCfg.rarity[iter_32_0].types, self:getRarity()) then
			return true
		end
	end

	return false
end

ShipIndexConst.MetaRarityIndexs = {
	ShipIndexConst.RarityAll,
	ShipIndexConst.Rarity3,
	ShipIndexConst.Rarity4
}
ShipIndexConst.MetaRarityNames = {
	"index_all",
	"index_rare4",
	"index_rare5"
}
ShipIndexConst.MetaExtraRepair = bit.lshift(1, 0)
ShipIndexConst.MetaExtraTactics = bit.lshift(1, 1)
ShipIndexConst.MetaExtraEnergy = bit.lshift(1, 2)
ShipIndexConst.MetaExtraIndexs = {
	ShipIndexConst.MetaExtraRepair,
	ShipIndexConst.MetaExtraTactics,
	ShipIndexConst.MetaExtraEnergy
}
ShipIndexConst.MetaExtraAll = IndexConst.BitAll(ShipIndexConst.MetaExtraIndexs)

table.insert(ShipIndexConst.MetaExtraIndexs, 1, ShipIndexConst.MetaExtraAll)

ShipIndexConst.MetaExtraNames = {
	"index_no_limit",
	"index_meta_repair",
	"index_meta_tactics",
	"index_meta_energy"
}
ShipIndexConst.ExtraSkin = bit.lshift(1, 0)
ShipIndexConst.ExtraRemould = bit.lshift(1, 1)
ShipIndexConst.Extrastrengthen = bit.lshift(1, 2)
ShipIndexConst.ExtraUpgrade = bit.lshift(1, 3)
ShipIndexConst.ExtraNotMaxLv = bit.lshift(1, 4)
ShipIndexConst.ExtraAwakening = bit.lshift(1, 5)
ShipIndexConst.ExtraAwakening2 = bit.lshift(1, 6)
ShipIndexConst.ExtraSpecial = bit.lshift(1, 7)
ShipIndexConst.ExtraProposeSkin = bit.lshift(1, 8)

if not LOCK_SP_WEAPON then
	ShipIndexConst.ExtraUniqueSpWeapon = bit.lshift(1, 9)
	ShipIndexConst.DRESSED = bit.lshift(1, 10)
	ShipIndexConst.ExtraMarry = bit.lshift(1, 11)
else
	ShipIndexConst.DRESSED = bit.lshift(1, 9)
	ShipIndexConst.ExtraMarry = bit.lshift(1, 10)
end

ShipIndexConst.ExtraIndexs = {
	ShipIndexConst.ExtraSkin,
	ShipIndexConst.ExtraRemould,
	ShipIndexConst.Extrastrengthen,
	ShipIndexConst.ExtraUpgrade,
	ShipIndexConst.ExtraNotMaxLv,
	ShipIndexConst.ExtraAwakening,
	ShipIndexConst.ExtraAwakening2,
	ShipIndexConst.ExtraSpecial,
	ShipIndexConst.ExtraProposeSkin
}

if not LOCK_SP_WEAPON then
	table.insert(ShipIndexConst.ExtraIndexs, ShipIndexConst.ExtraUniqueSpWeapon)
end

table.insert(ShipIndexConst.ExtraIndexs, ShipIndexConst.DRESSED)
table.insert(ShipIndexConst.ExtraIndexs, ShipIndexConst.ExtraMarry)

ShipIndexConst.ExtraAll = IndexConst.BitAll(ShipIndexConst.ExtraIndexs)

table.insert(ShipIndexConst.ExtraIndexs, 1, ShipIndexConst.ExtraAll)

ShipIndexConst.ExtraNames = {
	"index_no_limit",
	"index_skin",
	"index_reform_cw",
	"index_strengthen",
	"index_upgrade",
	"index_not_lvmax",
	"index_awakening",
	"index_awakening2",
	"index_special",
	"index_propose_skin"
}

if not LOCK_SP_WEAPON then
	ShipIndexConst.ExtraNames[11] = "index_spweapon"
end

table.insert(ShipIndexConst.ExtraNames, "index_dressed")
table.insert(ShipIndexConst.ExtraNames, "index_marry")

function ShipIndexConst:filterByExtra(arg_33_1)
	if not arg_33_1 or arg_33_1 == ShipIndexConst.ExtraAll then
		return true
	end

	if arg_33_1 == ShipIndexConst.ExtraSkin then
		return self:hasAvailiableSkin()
	elseif arg_33_1 == ShipIndexConst.ExtraRemould then
		return self:isRemouldable() and not self:isAllRemouldFinish()
	elseif arg_33_1 == ShipIndexConst.Extrastrengthen then
		return not self:isMetaShip() and not self:isIntensifyMax()
	elseif arg_33_1 == ShipIndexConst.ExtraUpgrade then
		return self:canUpgrade()
	elseif arg_33_1 == ShipIndexConst.ExtraNotMaxLv then
		return self:notMaxLevelForFilter()
	elseif arg_33_1 == ShipIndexConst.ExtraAwakening then
		return self:isAwakening()
	elseif arg_33_1 == ShipIndexConst.ExtraAwakening2 then
		return self:isAwakening2()
	elseif arg_33_1 == ShipIndexConst.ExtraSpecial then
		return self:isSpecialFilter()
	elseif arg_33_1 == ShipIndexConst.ExtraProposeSkin then
		return self:hasProposeSkin()
	elseif arg_33_1 == ShipIndexConst.ExtraUniqueSpWeapon then
		return self:HasUniqueSpWeapon()
	elseif arg_33_1 == ShipIndexConst.DRESSED then
		return not self:IsDefaultSkin() and self:getRemouldSkinId() ~= self:getSkinId()
	elseif arg_33_1 == ShipIndexConst.ExtraMarry then
		return self.propose
	end

	return false
end

ShipIndexConst.CollExtraSpecial = bit.lshift(1, 0)
ShipIndexConst.CollExtraNotObtained = bit.lshift(1, 1)
ShipIndexConst.CollExtraIndexs = {
	ShipIndexConst.CollExtraSpecial,
	ShipIndexConst.CollExtraNotObtained
}
ShipIndexConst.CollExtraAll = IndexConst.BitAll(ShipIndexConst.CollExtraIndexs)

table.insert(ShipIndexConst.CollExtraIndexs, 1, ShipIndexConst.CollExtraAll)

ShipIndexConst.CollExtraNames = {
	"index_no_limit",
	"index_special",
	"index_not_obtained"
}

function ShipIndexConst:filterByCollExtra(arg_34_1)
	if not arg_34_1 or arg_34_1 == ShipIndexConst.CollExtraAll then
		return true
	end

	if arg_34_1 == ShipIndexConst.CollExtraSpecial then
		return self:isSpecialFilter()
	end

	if arg_34_1 == ShipIndexConst.CollExtraNotObtained then
		local var_34_0 = self:getGroupId()

		if ShipGroup.getState(var_34_0, getProxy(CollectionProxy):getShipGroup(var_34_0), (self:isRemoulded())) ~= ShipGroup.STATE_UNLOCK then
			return true
		end
	end

	return false
end

return ShipIndexConst
