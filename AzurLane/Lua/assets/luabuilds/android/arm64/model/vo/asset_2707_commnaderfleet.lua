class = var_0_10000

local var_0_0 = "CommnaderFleet"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

var_0_1.RENAME_CODE_TIME = 60

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0:Update(arg_1_1)

	return
end

function var_0_1.Update(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id

	local var_2_0

	if not arg_2_1.name then
		i18n = var_2_0
		var_2_0 = var_2_0("commander_prefab_name", arg_2_0.id)
	end

	arg_2_0.name = var_2_0

	local var_2_1

	if not arg_2_1.commanders then
		var_2_1 = {}
	end

	arg_2_0.commanders = var_2_1
	arg_2_0.renameTime = 0

	return
end

function var_0_1.canRename(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.TimeMgr.GetInstance()
	local var_3_1 = var_1.GetServerTime(var_3_0)

	if var_0_1.RENAME_CODE_TIME - (var_3_1 - arg_3_0.renameTime) <= 0 then
		return true
	end

	local var_3_2 = false

	i18n = var_1_10004

	local var_3_3 = var_1_10004("commander_prefab_rename_time", var_2)
end

function var_0_1.updateCommander(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.commanders[arg_4_1] = arg_4_2

	return
end

function var_0_1.getName(arg_5_0)
	return arg_5_0.name
end

function var_0_1.updateName(arg_6_0, arg_6_1)
	arg_6_0.name = arg_6_1
	pg = var_1_10002

	local var_6_0 = var_1_10002.TimeMgr.GetInstance()

	arg_6_0.renameTime = var_2.GetServerTime(var_6_0)

	return
end

function var_0_1.getCommanderByPos(arg_7_0, arg_7_1)
	return arg_7_0.commanders[arg_7_1]
end

function var_0_1.getCommander(arg_8_0)
	return arg_8_0.commanders
end

function var_0_1.updateCommanders(arg_9_0, arg_9_1)
	arg_9_0.commanders = arg_9_1

	return
end

function var_0_1.contains(arg_10_0, arg_10_1)
	pairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.commanders) do
		if iter_10_1.id == arg_10_1 then
			return true
		end
	end

	return false
end

function var_0_1.getCommanderIds(arg_11_0)
	local var_11_0 = {}

	pairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_0.commanders) do
		table = var_1_10007

		var_1_10007.insert(var_11_0, iter_11_1.id)
	end

	return var_11_0
end

function var_0_1.removeCommander(arg_12_0, arg_12_1)
	pairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(arg_12_0.commanders) do
		if iter_12_1.id == arg_12_1 then
			arg_12_0.commanders[iter_12_0] = nil
		end
	end

	return
end

function var_0_1.isEmpty(arg_13_0)
	table = var_1_10001

	return var_1_10001.getCount(arg_13_0.commanders) == 0
end

function var_0_1.isSame(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.commanders[1]
	local var_14_1 = arg_14_1[1]
	local var_14_2 = arg_14_0.commanders[2]
	local var_14_3 = arg_14_1[2]
	local var_14_4 = var_14_0 == nil and var_14_1 == nil or var_14_0 and var_14_1 and var_14_0.id == var_14_1.id
	local var_14_5 = var_14_2 == nil and var_14_3 == nil or var_14_2 and var_14_3 and var_14_2.id == var_14_3.id

	return var_14_4 and var_14_5
end

function var_0_1.isSameId(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.commanders[1]
	local var_15_1 = arg_15_1[1]
	local var_15_2 = arg_15_0.commanders[2]
	local var_15_3 = arg_15_1[2]
	local var_15_4 = var_15_0 == nil and var_15_1 == nil or var_15_0 and var_15_1 and var_15_0.id == var_15_1
	local var_15_5 = var_15_2 == nil and var_15_3 == nil or var_15_2 and var_15_3 and var_15_2.id == var_15_3

	return var_15_4 and var_15_5
end

return var_0_1
