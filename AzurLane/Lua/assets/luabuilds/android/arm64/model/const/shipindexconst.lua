class = var_0_10000

local var_0_0 = var_0_10000("ShipIndexConst")

bit = var_0_10001
var_0_0.SortRarity = var_0_10001.lshift(1, 0)
bit = var_1
var_0_0.SortLevel = var_1.lshift(1, 1)
bit = var_1
var_0_0.SortPower = var_1.lshift(1, 2)
bit = var_1
var_0_0.SortAchivedTime = var_1.lshift(1, 3)
bit = var_1
var_0_0.SortIntimacy = var_1.lshift(1, 4)
bit = var_1
var_0_0.SortEnergy = var_1.lshift(1, 13)
bit = var_1
var_0_0.SortProperty_Cannon = var_1.lshift(1, 5)
bit = var_1
var_0_0.SortProperty_Air = var_1.lshift(1, 6)
bit = var_1
var_0_0.SortProperty_Dodge = var_1.lshift(1, 7)
bit = var_1
var_0_0.SortProperty_AntiAircraft = var_1.lshift(1, 8)
bit = var_1
var_0_0.SortProperty_Torpedo = var_1.lshift(1, 9)
bit = var_1
var_0_0.SortProperty_Reload = var_1.lshift(1, 10)
bit = var_1
var_0_0.SortProperty_Durability = var_1.lshift(1, 11)
bit = var_1
var_0_0.SortProperty_Antisub = var_1.lshift(1, 12)
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
IndexConst = var_1
var_0_0.SortPropertyAll = var_1.BitAll(var_0_0.SortPropertyIndexs)
table = var_1

var_1.insert(var_0_0.SortPropertyIndexs, 1, var_0_0.SortPropertyAll)

var_0_0.SortIndexs = {
	var_0_0.SortRarity,
	var_0_0.SortLevel,
	var_0_0.SortPower,
	var_0_0.SortAchivedTime,
	var_0_0.SortIntimacy,
	var_0_0.SortEnergy
}
bit = var_1
var_0_0.SortDefault = var_1.lshift(1, 0)
bit = var_1
var_0_0.SortProgressBar = var_1.lshift(1, 1)
var_0_0.SortRoleStory = {
	var_0_0.SortDefault,
	var_0_0.SortProgressBar
}

function var_0_0.getSortFuncAndName(arg_1_0, arg_1_1)
	local var_1_0 = 1

	ShipIndexCfg = var_1_10003

	for iter_1_0 = var_1_0, #var_1_10003.sort do
		bit = var_1_10006
		var_1_10006 = var_1_10006.lshift(1, iter_1_0 - 1)
		bit = var_1_10007

		if var_1_10007.band(var_1_10006, arg_1_0) > 0 then
			underscore = var_1_10007
			var_1_10007 = var_1_10007.map
			ShipIndexCfg = var_9

			local var_1_1 = var_1_10007(var_9.sort[iter_1_0].sortFuncs, function(arg_2_0)
				return function(arg_3_0)
					return (arg_1_1 and -1 or 1) * arg_2_0(arg_3_0)
				end
			end)

			ShipIndexCfg = var_9

			return var_1_1, var_9.sort[iter_1_0].name
		end
	end

	return
end

function var_0_0.getSortName(arg_4_0)
	local var_4_0 = 1

	ShipIndexConst = var_1_10002

	for iter_4_0 = var_4_0, #var_1_10002.SortRoleStory do
		bit = var_1_10005
		var_1_10005 = var_1_10005.lshift(1, iter_4_0 - 1)
		bit = var_1_10006

		if var_1_10006.band(var_1_10005, arg_4_0) > 0 then
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
			local var_16_0

			if arg_15_0 ~= "rarity" or not arg_16_0:getRarity() then
				var_16_0 = arg_16_0:getConfig(arg_15_0)
			end

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

bit = var_1
var_0_0.TypeFront = var_1.lshift(1, 0)
bit = var_1
var_0_0.TypeBack = var_1.lshift(1, 1)
bit = var_1
var_0_0.TypeQuZhu = var_1.lshift(1, 2)
bit = var_1
var_0_0.TypeQingXun = var_1.lshift(1, 3)
bit = var_1
var_0_0.TypeZhongXun = var_1.lshift(1, 4)
bit = var_1
var_0_0.TypeZhanLie = var_1.lshift(1, 5)
bit = var_1
var_0_0.TypeHangMu = var_1.lshift(1, 6)
bit = var_1
var_0_0.TypeWeiXiu = var_1.lshift(1, 7)
bit = var_1
var_0_0.TypeQianTing = var_1.lshift(1, 8)
bit = var_1
var_0_0.TypeOther = var_1.lshift(1, 9)
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
IndexConst = var_1
var_0_0.TypeAll = var_1.BitAll(var_0_0.TypeIndexs)
table = var_1

var_1.insert(var_0_0.TypeIndexs, 1, var_0_0.TypeAll)

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

	local var_26_0 = 2

	ShipIndexCfg = var_1_10003

	for iter_26_0 = var_26_0, #var_1_10003.type do
		bit = var_1_10006
		var_1_10006 = var_1_10006.lshift(1, iter_26_0 - 2)
		bit = var_1_10007

		if var_1_10007.band(var_1_10006, arg_26_1) > 0 then
			ShipIndexCfg = var_1_10007
			var_1_10007 = var_1_10007.type[iter_26_0].types

			local var_26_1

			if iter_26_0 < 4 then
				ShipIndexCfg = var_26_1
				var_26_1 = var_26_1.type[iter_26_0].shipTypes
				table = var_9

				if var_9.contains(var_1_10007, arg_26_0:getShipType()) then
					return true
				end

				table = var_9

				if var_9.contains(var_1_10007, arg_26_0:getTeamType()) then
					return true
				end
			else
				table = var_26_1

				if var_26_1.contains(var_1_10007, arg_26_0:getShipType()) then
					return true
				end
			end
		end
	end

	return false
end

bit = var_1
var_0_0.SortUnlockable = var_1.lshift(1, 0)
bit = var_1
var_0_0.SortGotLock = var_1.lshift(1, 1)
bit = var_1
var_0_0.SortNotGet = var_1.lshift(1, 2)
var_0_0.RoleProgress = {
	var_0_0.SortUnlockable,
	var_0_0.SortGotLock,
	var_0_0.SortNotGet
}
IndexConst = var_1
var_0_0.All = var_1.BitAll(var_0_0.RoleProgress)
table = var_1

var_1.insert(var_0_0.RoleProgress, 1, var_0_0.All)

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

	getProxy = var_1_10002
	CollectionProxy = var_1_10004

	local var_27_0 = var_1_10002(var_1_10004)
	local var_27_1 = var_2.getShipGroup(var_27_0, arg_27_0.ship_group)
	local var_27_2 = 2

	RoleIndexCfg = var_27_0

	for iter_27_0 = var_27_2, #var_27_0.progress do
		bit = var_1_10007
		var_1_10007 = var_1_10007.lshift(1, iter_27_0 - 2)
		bit = var_1_10008

		if var_1_10008.band(var_1_10007, arg_27_1) > 0 then
			RoleIndexCfg = var_1_10008

			if #var_1_10008.progress[iter_27_0].types == 0 then
				return true
			end

			ipairs = var_9

			for iter_27_1, iter_27_2 in var_9(var_1_10008) do
				if iter_27_2 == 1 then
					pg = var_1_10014
					var_1_10014 = var_1_10014.memory_template[arg_27_0.memories[1]].story

					if var_27_1 then
						pg = var_15

						local var_27_3 = var_15.NewStoryMgr.GetInstance()

						if not var_15.IsPlayed(var_27_3, var_1_10014) and arg_27_0.id ~= 501 then
							return true
						end
					end
				elseif iter_27_2 == 2 then
					pg = var_1_10014
					var_1_10014 = var_1_10014.memory_template[arg_27_0.memories[1]].story
					pg = var_15

					local var_27_4 = var_15.NewStoryMgr.GetInstance()

					if var_15.IsPlayed(var_27_4, var_1_10014) then
						return true
					end
				elseif iter_27_2 == 3 and not var_27_1 then
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

LOCK_NATION_HNLMS = var_2

if var_2 then
	table = var_2

	var_2.removebyvalue(var_0_1, "CampNL")
end

var_0_0.CampIndexs = {}
ipairs = var_2

for iter_0_0, iter_0_1 in var_2(var_0_1) do
	bit = var_0_10007
	var_0_0[iter_0_1] = var_0_10007.lshift(1, iter_0_0 - 1)
	table = var_0_10007

	var_0_10007.insert(var_0_0.CampIndexs, var_0_0[iter_0_1])
end

IndexConst = var_2
var_0_0.CampAll = var_2.BitAll(var_0_0.CampIndexs)
table = var_2

var_2.insert(var_0_0.CampIndexs, 1, var_0_0.CampAll)

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
LOCK_NATION_HNLMS = var_2

if var_2 then
	table = var_2

	var_2.removebyvalue(var_0_0.CampNames, "word_shipNation_yujinwangguo")
end

function var_0_0.filterByCamp(arg_28_0, arg_28_1)
	if not arg_28_1 or arg_28_1 == var_0_0.CampAll then
		return true
	end

	underscore = var_1_10002

	local var_28_0 = var_1_10002.to_array

	ShipIndexCfg = var_1_10004

	local var_28_1 = var_28_0(var_1_10004.camp)

	LOCK_NATION_HNLMS = var_1_10003

	if var_1_10003 then
		underscore = var_1_10003
		var_28_1 = var_1_10003.filter(var_28_1, function(arg_29_0)
			local var_29_1

			if #arg_29_0.types == 1 then
				local var_29_0 = arg_29_0.types[1]

				Nation = var_2_10002

				if var_29_0 == var_2_10002.NL then
					var_29_1 = false

					goto label_29_0
				end
			end

			var_29_1 = true

			::label_29_0::

			return var_29_1
		end)
	end

	for iter_28_0 = 2, #var_28_1 do
		bit = var_1_10007
		var_1_10007 = var_1_10007.lshift(1, iter_28_0 - 2)
		bit = var_1_10008
		var_1_10008 = var_1_10008.band(var_1_10007, arg_28_1)

		if 0 < var_1_10008 then
			var_1_10008 = var_28_1[iter_28_0].types
			ipairs = var_9

			for iter_28_1, iter_28_2 in var_9(var_1_10008) do
				Nation = var_1_10014

				if iter_28_2 == var_1_10014.LINK then
					var_1_10014 = arg_28_0:getNation()
					Nation = var_1_10015

					if var_1_10015.LINK <= var_1_10014 then
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

	underscore = var_1_10002

	local var_30_0 = var_1_10002.to_array

	ShipIndexCfg = var_1_10004

	local var_30_1 = var_30_0(var_1_10004.camp)

	LOCK_NATION_HNLMS = var_1_10003

	if var_1_10003 then
		underscore = var_1_10003
		var_30_1 = var_1_10003.filter(var_30_1, function(arg_31_0)
			local var_31_1

			if #arg_31_0.types == 1 then
				local var_31_0 = arg_31_0.types[1]

				Nation = var_2_10002

				if var_31_0 == var_2_10002.NL then
					var_31_1 = false

					goto label_31_0
				end
			end

			var_31_1 = true

			::label_31_0::

			return var_31_1
		end)
	end

	for iter_30_0 = 2, #var_30_1 do
		bit = var_1_10007
		var_1_10007 = var_1_10007.lshift(1, iter_30_0 - 2)
		bit = var_1_10008
		var_1_10008 = var_1_10008.band(var_1_10007, arg_30_1)

		if 0 < var_1_10008 then
			var_1_10008 = var_30_1[iter_30_0].types
			ipairs = var_9

			for iter_30_1, iter_30_2 in var_9(var_1_10008) do
				Nation = var_1_10014

				if iter_30_2 == var_1_10014.LINK then
					var_1_10014 = arg_30_0.nationality
					Nation = var_1_10015

					if var_1_10015.LINK <= var_1_10014 then
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

bit = var_2
var_0_0.Rarity1 = var_2.lshift(1, 0)
bit = var_2
var_0_0.Rarity2 = var_2.lshift(1, 1)
bit = var_2
var_0_0.Rarity3 = var_2.lshift(1, 2)
bit = var_2
var_0_0.Rarity4 = var_2.lshift(1, 3)
bit = var_2
var_0_0.Rarity5 = var_2.lshift(1, 4)
var_0_0.RarityIndexs = {
	var_0_0.Rarity1,
	var_0_0.Rarity2,
	var_0_0.Rarity3,
	var_0_0.Rarity4,
	var_0_0.Rarity5
}
IndexConst = var_2
var_0_0.RarityAll = var_2.BitAll(var_0_0.RarityIndexs)
table = var_2

var_2.insert(var_0_0.RarityIndexs, 1, var_0_0.RarityAll)

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

	local var_32_0 = 2

	ShipIndexCfg = var_1_10003

	for iter_32_0 = var_32_0, #var_1_10003.rarity do
		bit = var_1_10006
		var_1_10006 = var_1_10006.lshift(1, iter_32_0 - 2)
		bit = var_1_10007
		var_1_10007 = var_1_10007.band(var_1_10006, arg_32_1)

		if 0 < var_1_10007 then
			ShipIndexCfg = var_1_10007
			var_1_10007 = var_1_10007.rarity[iter_32_0].types
			table = var_8

			if var_8.contains(var_1_10007, arg_32_0:getRarity()) then
				return true
			end
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
bit = var_2
var_0_0.MetaExtraRepair = var_2.lshift(1, 0)
bit = var_2
var_0_0.MetaExtraTactics = var_2.lshift(1, 1)
bit = var_2
var_0_0.MetaExtraEnergy = var_2.lshift(1, 2)
var_0_0.MetaExtraIndexs = {
	var_0_0.MetaExtraRepair,
	var_0_0.MetaExtraTactics,
	var_0_0.MetaExtraEnergy
}
IndexConst = var_2
var_0_0.MetaExtraAll = var_2.BitAll(var_0_0.MetaExtraIndexs)
table = var_2

var_2.insert(var_0_0.MetaExtraIndexs, 1, var_0_0.MetaExtraAll)

var_0_0.MetaExtraNames = {
	"index_no_limit",
	"index_meta_repair",
	"index_meta_tactics",
	"index_meta_energy"
}
bit = var_2
var_0_0.ExtraSkin = var_2.lshift(1, 0)
bit = var_2
var_0_0.ExtraRemould = var_2.lshift(1, 1)
bit = var_2
var_0_0.Extrastrengthen = var_2.lshift(1, 2)
bit = var_2
var_0_0.ExtraUpgrade = var_2.lshift(1, 3)
bit = var_2
var_0_0.ExtraNotMaxLv = var_2.lshift(1, 4)
bit = var_2
var_0_0.ExtraAwakening = var_2.lshift(1, 5)
bit = var_2
var_0_0.ExtraAwakening2 = var_2.lshift(1, 6)
bit = var_2
var_0_0.ExtraSpecial = var_2.lshift(1, 7)
bit = var_2
var_0_0.ExtraProposeSkin = var_2.lshift(1, 8)
LOCK_SP_WEAPON = var_2

if not var_2 then
	bit = var_2
	var_0_0.ExtraUniqueSpWeapon = var_2.lshift(1, 9)
	bit = var_2
	var_0_0.DRESSED = var_2.lshift(1, 10)
	bit = var_2
	var_0_0.ExtraMarry = var_2.lshift(1, 11)
else
	bit = var_2
	var_0_0.DRESSED = var_2.lshift(1, 9)
	bit = var_2
	var_0_0.ExtraMarry = var_2.lshift(1, 10)
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
LOCK_SP_WEAPON = var_2

if not var_2 then
	table = var_2

	var_2.insert(var_0_0.ExtraIndexs, var_0_0.ExtraUniqueSpWeapon)
end

table = var_2

var_2.insert(var_0_0.ExtraIndexs, var_0_0.DRESSED)

table = var_2

var_2.insert(var_0_0.ExtraIndexs, var_0_0.ExtraMarry)

IndexConst = var_2
var_0_0.ExtraAll = var_2.BitAll(var_0_0.ExtraIndexs)
table = var_2

var_2.insert(var_0_0.ExtraIndexs, 1, var_0_0.ExtraAll)

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
LOCK_SP_WEAPON = var_0_2

local var_0_2

if not var_0_2 then
	var_0_2 = var_0_0.ExtraNames
	var_0_2[11] = "index_spweapon"
end

table = var_0_2

var_0_2.insert(var_0_0.ExtraNames, "index_dressed")

table = var_2

var_2.insert(var_0_0.ExtraNames, "index_marry")

function var_0_0.filterByExtra(arg_33_0, arg_33_1)
	if not arg_33_1 or arg_33_1 == var_0_0.ExtraAll then
		return true
	end

	if arg_33_1 == var_0_0.ExtraSkin then
		return arg_33_0:hasAvailiableSkin()
	elseif arg_33_1 == var_0_0.ExtraRemould then
		local var_33_0

		if arg_33_0:isRemouldable() then
			var_33_0 = not arg_33_0:isAllRemouldFinish()
		end

		return var_33_0
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

bit = var_2
var_0_0.CollExtraSpecial = var_2.lshift(1, 0)
bit = var_2
var_0_0.CollExtraNotObtained = var_2.lshift(1, 1)
var_0_0.CollExtraIndexs = {
	var_0_0.CollExtraSpecial,
	var_0_0.CollExtraNotObtained
}
IndexConst = var_2
var_0_0.CollExtraAll = var_2.BitAll(var_0_0.CollExtraIndexs)
table = var_2

var_2.insert(var_0_0.CollExtraIndexs, 1, var_0_0.CollExtraAll)

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
		local var_34_0 = arg_34_0
		local var_34_1 = arg_34_0.getGroupId(var_34_0)
		local var_34_2 = arg_34_0
		local var_34_3 = arg_34_0.isRemoulded(var_34_2)

		getProxy = var_34_0
		CollectionProxy = var_1_10006

		local var_34_4 = var_34_0(var_1_10006)
		local var_34_5 = var_4.getShipGroup(var_34_4, var_34_1)

		ShipGroup = var_34_2

		local var_34_6 = var_34_2.getState(var_34_1, var_34_5, var_34_3)

		ShipGroup = var_34_4

		if var_34_6 ~= var_34_4.STATE_UNLOCK then
			return true
		end
	end

	return false
end

return var_0_0
