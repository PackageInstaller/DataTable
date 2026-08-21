local var_0_0 = class("LoveLetter", import(".BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.groupId = arg_1_1.group_id
	arg_1_0.configId = arg_1_0.groupId
	arg_1_0.exp = arg_1_1.exp or 0
	arg_1_0.level = arg_1_1.level or 0
	arg_1_0.unlockLetterDic = {}

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.lover_character_template
end

function var_0_0.SetUnlockLetters(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		arg_3_0.unlockLetterDic[iter_3_1] = defaultValue(arg_3_0.unlockLetterDic[iter_3_1], 0) + 1
	end

	return
end

function var_0_0.GetLetterUnlock(arg_4_0, arg_4_1)
	return defaultValue(arg_4_0.unlockLetterDic[arg_4_1], 0) > 0
end

function var_0_0.GetLetterList(arg_5_0)
	local var_5_0 = getProxy(LoveLetterProxy):GetRecordGiftLetters(arg_5_0.groupId)

	for iter_5_0, iter_5_1 in ipairs(pg.lover_letter_content.get_id_list_by_ship_group[arg_5_0.groupId]) do
		if not table.contains(var_5_0, iter_5_1) then
			table.insert(var_5_0, iter_5_1)
		end
	end

	return var_5_0
end

function var_0_0.IsExpMax(arg_6_0)
	return arg_6_0.exp >= arg_6_0:getConfig("exp_upper_limit")
end

function var_0_0.IsLevelMax(arg_7_0)
	return arg_7_0.level >= arg_7_0:GetMaxLevel()
end

function var_0_0.AddExp(arg_8_0, arg_8_1)
	if arg_8_0:IsExpMax() then
		return 0
	end

	arg_8_0.exp = math.min(arg_8_0.exp + arg_8_1, (arg_8_0:getConfig("exp_upper_limit")))
	arg_8_1 = arg_8_0.exp

	return arg_8_0.exp - arg_8_1
end

function var_0_0.AddGiftExp(arg_9_0, arg_9_1)
	arg_9_0.exp = arg_9_0.exp + arg_9_0:getConfig("exp_up") * arg_9_1
	arg_9_0.level = arg_9_0.level + arg_9_1

	return
end

function var_0_0.GetMaxLevel(arg_10_0)
	arg_10_0.maxLevel = arg_10_0.maxLevel or calcFloor(arg_10_0:getConfig("exp_upper_limit") / arg_10_0:getConfig("exp_up"))

	return arg_10_0.maxLevel
end

function var_0_0.CanLevelUp(arg_11_0)
	return arg_11_0.exp >= (arg_11_0.level + 1) * arg_11_0:getConfig("exp_up")
end

function var_0_0.MaxLevelUp(arg_12_0)
	arg_12_0.level = calcFloor(arg_12_0.exp / arg_12_0:getConfig("exp_up"))

	return
end

function var_0_0.CanUnlockLetter(arg_13_0, arg_13_1)
	local var_13_0 = table.indexof(arg_13_0:GetLetterList(), arg_13_1)

	assert(var_13_0)

	return var_13_0 <= arg_13_0.level
end

function var_0_0.GetDisplayLetterList(arg_14_0)
	return underscore.first(arg_14_0:GetLetterList(), arg_14_0.level)
end

function var_0_0.GetDisplayLevel(arg_15_0)
	return math.min(arg_15_0.level, arg_15_0:GetMaxLevel())
end

function var_0_0.GetDisplayRank(arg_16_0)
	return math.floor((arg_16_0:GetDisplayLevel() - 1) / 10) + 1
end

var_0_0.Mark = {
	"I",
	"II",
	"III",
	"IV",
	"V",
	"VI",
	"VII",
	"VIII",
	"IX",
	"X"
}

function var_0_0.GetDisplayLevelMark(arg_17_0)
	return arg_17_0:GetDisplayLevel()
end

function var_0_0.GetDisplayExp(arg_18_0)
	if arg_18_0:IsLevelMax() then
		return 0, 0
	else
		local var_18_0 = arg_18_0:getConfig("exp_up")

		return math.min(arg_18_0.exp - arg_18_0.level * var_18_0, var_18_0), var_18_0
	end

	return
end

function var_0_0.GetPrefabName(arg_19_0)
	return "lovelettermedal/default_" .. arg_19_0:GetDisplayRank()
end

function var_0_0.GetEmptyShipGroup(arg_20_0)
	arg_20_0.shipGroup = arg_20_0.shipGroup or ShipGroup.New({
		id = arg_20_0.configId
	})

	return arg_20_0.shipGroup
end

function var_0_0.GetPainting(arg_21_0)
	return arg_21_0:GetEmptyShipGroup():getPainting()
end

function var_0_0.GetName(arg_22_0)
	return arg_22_0:GetEmptyShipGroup():getName()
end

function var_0_0.GetNation(arg_23_0)
	return arg_23_0:GetEmptyShipGroup():getNation()
end

function var_0_0.GetDisplayInfo(arg_24_0)
	local var_24_0 = pg.ship_skin_template[arg_24_0:GetEmptyShipGroup():getPaintingId()]

	return {
		hand = var_24_0.lover_hand,
		kiss = var_24_0.lover_kiss
	}
end

function var_0_0.GetLetterDataFromId(arg_25_0)
	local var_25_0 = pg.lover_nation[arg_25_0:GetNation()]

	return {
		bg = var_25_0.bg,
		prefab = var_25_0.letter
	}
end

function var_0_0.GetTrophyList(arg_26_0)
	for iter_26_0 = 1, arg_26_0.level, 10 do
		table.insert({}, LoveLetterTrophy.New({
			id = 0 + arg_26_0.groupId * 100 + iter_26_0
		}))
	end

	return {}
end

return var_0_0
