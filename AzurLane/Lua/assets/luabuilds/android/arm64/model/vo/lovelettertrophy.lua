class = var_0_10000

local var_0_0 = "LoveLetterTrophy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".Trophy"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_1.id
	arg_1_0.level = arg_1_0.id % 100
	math = var_2
	arg_1_0.groupId = var_2.floor(arg_1_0.id % 0 / 100)
	getProxy = var_2
	LoveLetterProxy = var_4

	local var_1_0 = var_2(var_4)

	arg_1_0.ll = var_2.GetGroupData(var_1_0, arg_1_0.groupId)
	setmetatable = var_2
	arg_1_0.oll = var_2({
		level = arg_1_0.level
	}, {
		__index = arg_1_0.ll
	})

	local var_1_1 = arg_1_0.level + 10
	local var_1_2 = arg_1_0.ll

	arg_1_0.isMax = var_1_1 > var_3.GetMaxLevel(var_1_2)

	local var_1_3 = arg_1_0.ll

	arg_1_0.groupName = var_2.GetName(var_1_3)

	local var_1_4 = arg_1_0.ll

	arg_1_0.paint = var_2.GetPainting(var_1_4)
	arg_1_0.subTrophyList = {}

	arg_1_0:update(arg_1_1)

	return
end

function var_0_1.getConfigTable(arg_2_0)
	if not arg_2_0.configTable then
		local var_2_0 = {}
		local var_2_1

		if arg_2_0.isMax or not (arg_2_0.id + 10) then
			var_2_1 = nil
		end

		var_2_0.next = var_2_1
		arg_2_0.configTable = var_2_0
	end

	return arg_2_0.configTable
end

function var_0_1.update(arg_3_0, arg_3_1)
	arg_3_0.timestamp = 1

	return
end

function var_0_1.isComplexTrophy(arg_4_0)
	return false
end

function var_0_1.getTargetID(arg_5_0)
	return arg_5_0:getConfig("target_id")
end

function var_0_1.getHideType(arg_6_0)
	return arg_6_0:getConfig("hide")
end

function var_0_1.isHide(arg_7_0)
	return false
end

function var_0_1.isMaxLevel(arg_8_0)
	return arg_8_0.isMax
end

function var_0_1.getName(arg_9_0)
	i18n = var_1_10001

	return var_1_10001("loveactivity_ui_14", arg_9_0.groupName)
end

function var_0_1.GetPrefabName(arg_10_0)
	local var_10_0 = arg_10_0.oll

	return var_1.GetPrefabName(var_10_0)
end

function var_0_1.GetPainting(arg_11_0)
	return arg_11_0.paint
end

function var_0_1.GetDisplayLevelMark(arg_12_0)
	local var_12_0 = arg_12_0.oll

	return var_1.GetDisplayLevelMark(var_12_0)
end

return var_0_1
