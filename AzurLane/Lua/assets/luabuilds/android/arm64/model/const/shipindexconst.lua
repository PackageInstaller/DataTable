local var_0_0 = class("ShipIndexConst")

var_0_0.SortRarity = bit.lshift(1, 0)
var_0_0.SortLevel = bit.lshift(1, 1)
var_0_0.SortPower = bit.lshift(1, 2)
var_0_0.SortAchivedTime = bit.lshift(1, 3)
var_0_0.SortIntimacy = bit.lshift(1, 4)
var_0_0.SortEnergy = bit.lshift(1, 13)
var_0_0.SortProperty_Cannon = bit.lshift(1, 5)
var_0_0.SortProperty_Air = bit.lshift(1, 6)
var_0_0.SortProperty_Dodge = bit.lshift(1, 7)
var_0_0.SortProperty_AntiAircraft = bit.lshift(1, 8)
var_0_0.SortProperty_Torpedo = bit.lshift(1, 9)
var_0_0.SortProperty_Reload = bit.lshift(1, 10)
var_0_0.SortProperty_Durability = bit.lshift(1, 11)
var_0_0.SortProperty_Antisub = bit.lshift(1, 12)
var_0_0.SortPropertyIndexs = {
	var_0_0.SortProperty_Cannon,
	var_0_0.SortProperty_Air,
	var_0_0.SortProperty_Dodge,
	var_0_0.SortProperty_AntiAircraft,
	var_0_0.SortProperty_Torpedo,
	var_0_0.SortProperty_Reload,
	var_0_0.SortProperty_Durability,
	var_0_0.SortProperty_Antisub
}
var_0_0.RoleProgressBar = {
	var_0_0.SortUnlockable,
	var_0_0.SortGotLock,
	var_0_0.SortNotGet
}
var_0_0.SortPropertyAll = IndexConst.BitAll(var_0_0.SortPropertyIndexs)

table.insert(var_0_0.SortPropertyIndexs, 1, var_0_0.SortPropertyAll)

var_0_0.SortIndexs = {
	var_0_0.SortRarity,
	var_0_0.SortLevel,
	var_0_0.SortPower,
	var_0_0.SortAchivedTime,
	var_0_0.SortIntimacy,
	var_0_0.SortEnergy
}
var_0_0.SortDefault = bit.lshift(1, 0)
var_0_0.SortProgressBar = bit.lshift(1, 1)
var_0_0.SortRoleStory = {
	var_0_0.SortDefault,
	var_0_0.SortProgressBar
}

function var_0_0.getSortFuncAndName(arg_1_0, arg_1_1)
	for iter_1_0 = 1, #ShipIndexCfg.sort do
		if bit.band(bit.lshift(1, iter_1_0 - 1), arg_1_0) > 0 then
			return underscore.map(ShipIndexCfg.sort[iter_1_0].sortFuncs, function(arg_2_0)
				return function(arg_3_0)
					return (arg_1_1 and -1 or 1) * arg_2_0(arg_3_0)
				end
			end), ShipIndexCfg.sort[iter_1_0].name
		end
	end

	return
end

function var_0_0.getSortName(arg_4_0)
	for iter_4_0 = 1, #ShipIndexConst.SortRoleStory do
		if bit.band(bit.lshift(1, iter_4_0 - 1), arg_4_0) > 0 then
			return iter_4_0
		end
	end

	return
end

var_0_0.SortRoleStoryName = {
	"memory_filter_option_1",
	"memory_filter_option_2"
}
var_0_0.SortNames = {
	"word_rarity",
	"word_lv",
	"word_synthesize_power",
	"word_achieved_item",
	"attribute_intimacy",
	"sort_energy"
}
var_0_0.SortPropertyNames = {
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

function var_0_0.sortByCombatPower()
	return {
		function(arg_6_0)
			return -arg_6_0:getShipCombatPower()
		end,
		function(arg_7_0)
			return arg_7_0.configId
		end
	}
end

function var_0_0.sortByField(arg_8_0)
	return {
		function(arg_9_0)
			return -arg_9_0[arg_8_0]
		end,
		function(arg_10_0)
			return -arg_10_0:getRarity()
		end,
		function(arg_11_0)
			return arg_11_0.configId
		end
	}
end

function var_0_0.sortByProperty(arg_12_0)
	return {
		function(arg_13_0)
			return -arg_13_0:getShipProperties()[arg_12_0]
		end,
		function(arg_14_0)
			return arg_14_0.configId
		end
	}
end

function var_0_0.sortByCfg(arg_15_0)
	return {
		function(arg_16_0)
			local var_16_0 = arg_15_0 == "rarity" and arg_16_0:getRarity() or arg_16_0:getConfig(arg_15_0)

			return -var_16_0
		end,
		function(arg_17_0)
			return arg_17_0.configId
		end
	}
end

function var_0_0.sortByIntimacy()
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

function var_0_0.sortByEnergy()
	return {
		function(arg_24_0)
			return -arg_24_0:getEnergy()
		end,
		function(arg_25_0)
			return arg_25_0.configId
		end
	}
end

var_0_0.TypeFront = bit.lshift(1, 0)
var_0_0.TypeBack = bit.lshift(1, 1)
var_0_0.TypeQuZhu = bit.lshift(1, 2)
var_0_0.TypeQingXun = bit.lshift(1, 3)
var_0_0.TypeZhongXun = bit.lshift(1, 4)
var_0_0.TypeZhanLie = bit.lshift(1, 5)
var_0_0.TypeHangMu = bit.lshift(1, 6)
var_0_0.TypeWeiXiu = bit.lshift(1, 7)
var_0_0.TypeQianTing = bit.lshift(1, 8)
var_0_0.TypeOther = bit.lshift(1, 9)
var_0_0.TypeIndexs = {
	var_0_0.TypeFront,
	var_0_0.TypeBack,
	var_0_0.TypeQuZhu,
	var_0_0.TypeQingXun,
	var_0_0.TypeZhongXun,
	var_0_0.TypeZhanLie,
	var_0_0.TypeHangMu,
	var_0_0.TypeWeiXiu,
	var_0_0.TypeQianTing,
	var_0_0.TypeOther
}
var_0_0.TypeAll = IndexConst.BitAll(var_0_0.TypeIndexs)

table.insert(var_0_0.TypeIndexs, 1, var_0_0.TypeAll)

var_0_0.TypeNames = {
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

function var_0_0.filterByType(arg_26_0, arg_26_1)
	if not arg_26_1 or arg_26_1 == var_0_0.TypeAll then
		return true
	end

	for iter_26_0 = 2, #ShipIndexCfg.type do
		if bit.band(bit.lshift(1, iter_26_0 - 2), arg_26_1) > 0 then
			if iter_26_0 < 4 then
				if table.contains(ShipIndexCfg.type[iter_26_0].types, arg_26_0:getShipType()) then
					return true
				end

				if table.contains(ShipIndexCfg.type[iter_26_0].types, arg_26_0:getTeamType()) then
					return true
				end
			elseif table.contains(ShipIndexCfg.type[iter_26_0].types, arg_26_0:getShipType()) then
				return true
			end
		end
	end

	return false
end

var_0_0.SortUnlockable = bit.lshift(1, 0)
var_0_0.SortGotLock = bit.lshift(1, 1)
var_0_0.SortNotGet = bit.lshift(1, 2)
var_0_0.RoleProgress = {
	var_0_0.SortUnlockable,
	var_0_0.SortGotLock,
	var_0_0.SortNotGet
}
var_0_0.All = IndexConst.BitAll(var_0_0.RoleProgress)

table.insert(var_0_0.RoleProgress, 1, var_0_0.All)

var_0_0.RoleProgressName = {
	"memory_filter_option_3",
	"memory_filter_option_4",
	"memory_filter_option_5",
	"memory_filter_option_6"
}

function var_0_0.filterRoleProgressBar(arg_27_0, arg_27_1)
	if not arg_27_1 or arg_27_1 == var_0_0.ProgressAll then
		return true
	end

	local var_27_0 = getProxy(CollectionProxy):getShipGroup(arg_27_0.ship_group)

	for iter_27_0 = 2, #RoleIndexCfg.progress do
		if bit.band(bit.lshift(1, iter_27_0 - 2), arg_27_1) > 0 then
			if #RoleIndexCfg.progress[iter_27_0].types == 0 then
				return true
			end

			for iter_27_1, iter_27_2 in ipairs(RoleIndexCfg.progress[iter_27_0].types) do
				if iter_27_2 == 1 then
					if var_27_0 then
						local var_27_1 = pg.NewStoryMgr.GetInstance()

						if not var_27_1:IsPlayed(pg.memory_template[arg_27_0.memories[1]].story) and arg_27_0.id ~= 501 then
							return true
						end
					end
				elseif iter_27_2 == 2 then
					local var_27_2 = pg.NewStoryMgr.GetInstance()

					if var_27_2:IsPlayed(pg.memory_template[arg_27_0.memories[1]].story) then
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

if LOCK_NATION_HNLMS then
	table.removebyvalue({
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
	}, "CampNL")
end

var_0_0.CampIndexs = {}

for iter_0_0, iter_0_1 in ipairs({
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
}) do
	var_0_0[iter_0_1] = bit.lshift(1, iter_0_0 - 1)

	table.insert(var_0_0.CampIndexs, var_0_0[iter_0_1])
end

var_0_0.CampAll = IndexConst.BitAll(var_0_0.CampIndexs)

table.insert(var_0_0.CampIndexs, 1, var_0_0.CampAll)

var_0_0.CampNames = {
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
	table.removebyvalue(var_0_0.CampNames, "word_shipNation_yujinwangguo")
end

function var_0_0.filterByCamp(arg_28_0, arg_28_1)
	if not arg_28_1 or arg_28_1 == var_0_0.CampAll then
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
					if arg_28_0:getNation() >= Nation.LINK then
						return true
					end
				elseif iter_28_2 == arg_28_0:getNation() then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.RolefilterByCamp(arg_30_0, arg_30_1)
	if not arg_30_1 or arg_30_1 == var_0_0.CampAll then
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
					if arg_30_0.nationality >= Nation.LINK then
						return true
					end
				elseif iter_30_2 == arg_30_0.nationality then
					return true
				end
			end
		end
	end

	return false
end

var_0_0.Rarity1 = bit.lshift(1, 0)
var_0_0.Rarity2 = bit.lshift(1, 1)
var_0_0.Rarity3 = bit.lshift(1, 2)
var_0_0.Rarity4 = bit.lshift(1, 3)
var_0_0.Rarity5 = bit.lshift(1, 4)
var_0_0.RarityIndexs = {
	var_0_0.Rarity1,
	var_0_0.Rarity2,
	var_0_0.Rarity3,
	var_0_0.Rarity4,
	var_0_0.Rarity5
}
var_0_0.RarityAll = IndexConst.BitAll(var_0_0.RarityIndexs)

table.insert(var_0_0.RarityIndexs, 1, var_0_0.RarityAll)

var_0_0.RarityNames = {
	"index_all",
	"index_rare2",
	"index_rare3",
	"index_rare4",
	"index_rare5",
	"index_rare6"
}

function var_0_0.filterByRarity(arg_32_0, arg_32_1)
	if not arg_32_1 or arg_32_1 == var_0_0.RarityAll then
		return true
	end

	for iter_32_0 = 2, #ShipIndexCfg.rarity do
		if bit.band(bit.lshift(1, iter_32_0 - 2), arg_32_1) > 0 and table.contains(ShipIndexCfg.rarity[iter_32_0].types, arg_32_0:getRarity()) then
			return true
		end
	end

	return false
end

var_0_0.MetaRarityIndexs = {
	var_0_0.RarityAll,
	var_0_0.Rarity3,
	var_0_0.Rarity4
}
var_0_0.MetaRarityNames = {
	"index_all",
	"index_rare4",
	"index_rare5"
}
var_0_0.MetaExtraRepair = bit.lshift(1, 0)
var_0_0.MetaExtraTactics = bit.lshift(1, 1)
var_0_0.MetaExtraEnergy = bit.lshift(1, 2)
var_0_0.MetaExtraIndexs = {
	var_0_0.MetaExtraRepair,
	var_0_0.MetaExtraTactics,
	var_0_0.MetaExtraEnergy
}
var_0_0.MetaExtraAll = IndexConst.BitAll(var_0_0.MetaExtraIndexs)

table.insert(var_0_0.MetaExtraIndexs, 1, var_0_0.MetaExtraAll)

var_0_0.MetaExtraNames = {
	"index_no_limit",
	"index_meta_repair",
	"index_meta_tactics",
	"index_meta_energy"
}
var_0_0.ExtraSkin = bit.lshift(1, 0)
var_0_0.ExtraRemould = bit.lshift(1, 1)
var_0_0.Extrastrengthen = bit.lshift(1, 2)
var_0_0.ExtraUpgrade = bit.lshift(1, 3)
var_0_0.ExtraNotMaxLv = bit.lshift(1, 4)
var_0_0.ExtraAwakening = bit.lshift(1, 5)
var_0_0.ExtraAwakening2 = bit.lshift(1, 6)
var_0_0.ExtraSpecial = bit.lshift(1, 7)
var_0_0.ExtraProposeSkin = bit.lshift(1, 8)

if not LOCK_SP_WEAPON then
	var_0_0.ExtraUniqueSpWeapon = bit.lshift(1, 9)
	var_0_0.DRESSED = bit.lshift(1, 10)
	var_0_0.ExtraMarry = bit.lshift(1, 11)
else
	var_0_0.DRESSED = bit.lshift(1, 9)
	var_0_0.ExtraMarry = bit.lshift(1, 10)
end

var_0_0.ExtraIndexs = {
	var_0_0.ExtraSkin,
	var_0_0.ExtraRemould,
	var_0_0.Extrastrengthen,
	var_0_0.ExtraUpgrade,
	var_0_0.ExtraNotMaxLv,
	var_0_0.ExtraAwakening,
	var_0_0.ExtraAwakening2,
	var_0_0.ExtraSpecial,
	var_0_0.ExtraProposeSkin
}

if not LOCK_SP_WEAPON then
	table.insert(var_0_0.ExtraIndexs, var_0_0.ExtraUniqueSpWeapon)
end

table.insert(var_0_0.ExtraIndexs, var_0_0.DRESSED)
table.insert(var_0_0.ExtraIndexs, var_0_0.ExtraMarry)

var_0_0.ExtraAll = IndexConst.BitAll(var_0_0.ExtraIndexs)

table.insert(var_0_0.ExtraIndexs, 1, var_0_0.ExtraAll)

var_0_0.ExtraNames = {
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
	var_0_0.ExtraNames[11] = "index_spweapon"
end

table.insert(var_0_0.ExtraNames, "index_dressed")
table.insert(var_0_0.ExtraNames, "index_marry")

function var_0_0.filterByExtra(arg_33_0, arg_33_1)
	if not arg_33_1 or arg_33_1 == var_0_0.ExtraAll then
		return true
	end

	if arg_33_1 == var_0_0.ExtraSkin then
		return arg_33_0:hasAvailiableSkin()
	elseif arg_33_1 == var_0_0.ExtraRemould then
		return arg_33_0:isRemouldable() and not arg_33_0:isAllRemouldFinish()
	elseif arg_33_1 == var_0_0.Extrastrengthen then
		return not arg_33_0:isMetaShip() and not arg_33_0:isIntensifyMax()
	elseif arg_33_1 == var_0_0.ExtraUpgrade then
		return arg_33_0:canUpgrade()
	elseif arg_33_1 == var_0_0.ExtraNotMaxLv then
		return arg_33_0:notMaxLevelForFilter()
	elseif arg_33_1 == var_0_0.ExtraAwakening then
		return arg_33_0:isAwakening()
	elseif arg_33_1 == var_0_0.ExtraAwakening2 then
		return arg_33_0:isAwakening2()
	elseif arg_33_1 == var_0_0.ExtraSpecial then
		return arg_33_0:isSpecialFilter()
	elseif arg_33_1 == var_0_0.ExtraProposeSkin then
		return arg_33_0:hasProposeSkin()
	elseif arg_33_1 == var_0_0.ExtraUniqueSpWeapon then
		return arg_33_0:HasUniqueSpWeapon()
	elseif arg_33_1 == var_0_0.DRESSED then
		return not arg_33_0:IsDefaultSkin() and arg_33_0:getRemouldSkinId() ~= arg_33_0:getSkinId()
	elseif arg_33_1 == var_0_0.ExtraMarry then
		return arg_33_0.propose
	end

	return false
end

var_0_0.CollExtraSpecial = bit.lshift(1, 0)
var_0_0.CollExtraNotObtained = bit.lshift(1, 1)
var_0_0.CollExtraIndexs = {
	var_0_0.CollExtraSpecial,
	var_0_0.CollExtraNotObtained
}
var_0_0.CollExtraAll = IndexConst.BitAll(var_0_0.CollExtraIndexs)

table.insert(var_0_0.CollExtraIndexs, 1, var_0_0.CollExtraAll)

var_0_0.CollExtraNames = {
	"index_no_limit",
	"index_special",
	"index_not_obtained"
}

function var_0_0.filterByCollExtra(arg_34_0, arg_34_1)
	if not arg_34_1 or arg_34_1 == var_0_0.CollExtraAll then
		return true
	end

	if arg_34_1 == var_0_0.CollExtraSpecial then
		return arg_34_0:isSpecialFilter()
	end

	if arg_34_1 == var_0_0.CollExtraNotObtained then
		local var_34_0 = arg_34_0:getGroupId()

		if ShipGroup.getState(var_34_0, getProxy(CollectionProxy):getShipGroup(var_34_0), (arg_34_0:isRemoulded())) ~= ShipGroup.STATE_UNLOCK then
			return true
		end
	end

	return false
end

return var_0_0
