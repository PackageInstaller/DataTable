class = var_0_10000

local var_0_0 = "LoveLetter"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.groupId = arg_1_1.group_id
	arg_1_0.configId = arg_1_0.groupId

	local var_1_0

	if not arg_1_1.exp then
		var_1_0 = 0
	end

	arg_1_0.exp = var_1_0

	local var_1_1

	if not arg_1_1.level then
		var_1_1 = 0
	end

	arg_1_0.level = var_1_1
	arg_1_0.unlockLetterDic = {}

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.lover_character_template
end

function var_0_1.SetUnlockLetters(arg_3_0, arg_3_1)
	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_1) do
		local var_3_0 = arg_3_0.unlockLetterDic

		defaultValue = var_1_10008
		var_3_0[iter_3_1] = var_1_10008(arg_3_0.unlockLetterDic[iter_3_1], 0) + 1
	end

	return
end

function var_0_1.GetLetterUnlock(arg_4_0, arg_4_1)
	defaultValue = var_1_10002

	return var_1_10002(arg_4_0.unlockLetterDic[arg_4_1], 0) > 0
end

function var_0_1.GetLetterList(arg_5_0)
	getProxy = var_1_10001
	LoveLetterProxy = var_1_10003

	local var_5_0 = var_1_10001(var_1_10003)
	local var_5_1 = var_1.GetRecordGiftLetters(var_5_0, arg_5_0.groupId)

	ipairs = var_1_10002
	pg = var_4

	for iter_5_0, iter_5_1 in var_1_10002(var_4.lover_letter_content.get_id_list_by_ship_group[arg_5_0.groupId]) do
		table = var_1_10007

		if not var_1_10007.contains(var_5_1, iter_5_1) then
			table = var_1_10007

			var_1_10007.insert(var_5_1, iter_5_1)
		end
	end

	return var_5_1
end

function var_0_1.IsExpMax(arg_6_0)
	return arg_6_0.exp >= arg_6_0:getConfig("exp_upper_limit")
end

function var_0_1.IsLevelMax(arg_7_0)
	return arg_7_0.level >= arg_7_0:GetMaxLevel()
end

function var_0_1.AddExp(arg_8_0, arg_8_1)
	if arg_8_0:IsExpMax() then
		return 0
	end

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.getConfig(var_8_0, "exp_upper_limit")
	local var_8_2 = arg_8_0.exp

	math = var_8_0
	arg_8_0.exp = var_8_0.min(arg_8_0.exp + arg_8_1, var_8_1)
	arg_8_1 = var_8_2

	return arg_8_0.exp - arg_8_1
end

function var_0_1.AddGiftExp(arg_9_0, arg_9_1)
	arg_9_0.exp = arg_9_0.exp + arg_9_0:getConfig("exp_up") * arg_9_1
	arg_9_0.level = arg_9_0.level + arg_9_1

	return
end

function var_0_1.GetMaxLevel(arg_10_0)
	if not arg_10_0.maxLevel then
		calcFloor = var_1
		arg_10_0.maxLevel = var_1(arg_10_0:getConfig("exp_upper_limit") / arg_10_0:getConfig("exp_up"))
	end

	return arg_10_0.maxLevel
end

function var_0_1.CanLevelUp(arg_11_0)
	return arg_11_0.exp >= (arg_11_0.level + 1) * arg_11_0:getConfig("exp_up")
end

function var_0_1.MaxLevelUp(arg_12_0)
	calcFloor = var_1_10001
	arg_12_0.level = var_1_10001(arg_12_0.exp / arg_12_0:getConfig("exp_up"))

	return
end

function var_0_1.CanUnlockLetter(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.GetLetterList(var_13_0)

	table = var_1_10003

	local var_13_2 = var_1_10003.indexof(var_13_1, arg_13_1)

	assert = var_13_0

	var_13_0(var_13_2)

	return var_13_2 <= arg_13_0.level
end

function var_0_1.GetDisplayLetterList(arg_14_0)
	underscore = var_1_10001

	return var_1_10001.first(arg_14_0:GetLetterList(), arg_14_0.level)
end

function var_0_1.GetDisplayLevel(arg_15_0)
	math = var_1_10001

	return var_1_10001.min(arg_15_0.level, arg_15_0:GetMaxLevel())
end

function var_0_1.GetDisplayRank(arg_16_0)
	math = var_1_10001

	return var_1_10001.floor((arg_16_0:GetDisplayLevel() - 1) / 10) + 1
end

var_0_1.Mark = {
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

function var_0_1.GetDisplayLevelMark(arg_17_0)
	return arg_17_0:GetDisplayLevel()
end

function var_0_1.GetDisplayExp(arg_18_0)
	if arg_18_0:IsLevelMax() then
		return 0, 0
	else
		local var_18_0 = arg_18_0:getConfig("exp_up")

		math = var_1_10002

		return var_1_10002.min(arg_18_0.exp - arg_18_0.level * var_18_0, var_18_0), var_18_0
	end

	return
end

function var_0_1.GetPrefabName(arg_19_0)
	return "lovelettermedal/default_" .. arg_19_0:GetDisplayRank()
end

function var_0_1.GetEmptyShipGroup(arg_20_0)
	if not arg_20_0.shipGroup then
		ShipGroup = var_1
		arg_20_0.shipGroup = var_1.New({
			id = arg_20_0.configId
		})
	end

	return arg_20_0.shipGroup
end

function var_0_1.GetPainting(arg_21_0)
	local var_21_0 = arg_21_0:GetEmptyShipGroup()

	return var_1.getPainting(var_21_0)
end

function var_0_1.GetName(arg_22_0)
	local var_22_0 = arg_22_0:GetEmptyShipGroup()

	return var_1.getName(var_22_0)
end

function var_0_1.GetNation(arg_23_0)
	local var_23_0 = arg_23_0:GetEmptyShipGroup()

	return var_1.getNation(var_23_0)
end

function var_0_1.GetDisplayInfo(arg_24_0)
	local var_24_0 = arg_24_0:GetEmptyShipGroup()
	local var_24_1 = var_1.getPaintingId(var_24_0)

	pg = var_1_10002

	local var_24_2 = var_1_10002.ship_skin_template[var_24_1]

	return {
		hand = var_24_2.lover_hand,
		kiss = var_24_2.lover_kiss
	}
end

function var_0_1.GetLetterDataFromId(arg_25_0)
	pg = var_1_10001

	local var_25_0 = var_1_10001.lover_nation[arg_25_0:GetNation()]

	return {
		bg = var_25_0.bg,
		prefab = var_25_0.letter
	}
end

function var_0_1.GetTrophyList(arg_26_0)
	local var_26_0 = {}

	for iter_26_0 = 1, arg_26_0.level, 10 do
		local var_26_1 = 0 + arg_26_0.groupId * 100 + iter_26_0

		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_26_2 = var_26_0

		LoveLetterTrophy = var_1_10010

		var_1_10007(var_26_2, var_1_10010.New({
			id = var_26_1
		}))
	end

	return var_26_0
end

return var_0_1
