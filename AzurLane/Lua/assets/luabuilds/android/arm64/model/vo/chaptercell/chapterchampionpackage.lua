class = var_0_10000

local var_0_0 = var_0_10000("ChapterChampionPackage")
local var_0_1 = {}

ChapterConst = var_2

local var_0_2 = var_2.AttachOni

import = var_0_10003
var_0_1[var_0_2] = var_0_10003(".ChapterChampionOni")
ChapterConst = var_0_2

local var_0_3 = var_0_2.AttachChampion

import = var_3
var_0_1[var_0_3] = var_3(".ChapterChampionNormal")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:RebuildData(arg_1_1)

	arg_1_0.idList = {}

	if arg_1_1.extra_id then
		ipairs = var_3

		for iter_1_0, iter_1_1 in var_3(arg_1_1.extra_id) do
			arg_1_0.idList[iter_1_0] = iter_1_1
		end
	end

	arg_1_0.currentChampion = var_0_1[var_1_0.attachment].New(var_1_0)
	ChapterConst = var_3
	arg_1_0.trait = var_3.TraitNone
	Quaternion = var_3
	arg_1_0.rotation = var_3.identity
	rawset = var_3

	var_3(arg_1_0, "_init", true)

	return
end

function var_0_0.RebuildData(arg_2_0, arg_2_1)
	({
		id = arg_2_1.item_id,
		pos = {}
	}).pos.row = arg_2_1.pos.row
	var_2.pos.column = arg_2_1.pos.column
	var_2.attachment = arg_2_1.item_type
	var_2.flag = arg_2_1.item_flag
	var_2.data = arg_2_1.item_data

	return var_2
end

function var_0_0.__index(arg_3_0, arg_3_1)
	local var_3_0

	if not var_0_0[arg_3_1] then
		rawget = var_1_10003

		if var_1_10003(arg_3_0, "currentChampion") then
			var_3_0 = var_3[arg_3_1]
		end
	end

	return var_3_0
end

function var_0_0.__newindex(arg_4_0, arg_4_1, arg_4_2)
	rawget = var_1_10003

	if not var_1_10003(arg_4_0, "_init") then
		rawset = var_1_10004

		var_1_10004(arg_4_0, arg_4_1, arg_4_2)

		return
	end

	rawget = var_1_10004

	if var_1_10004(arg_4_0, "currentChampion") then
		var_4[arg_4_1] = arg_4_2
	end

	return
end

function var_0_0.Iter(arg_5_0)
	if #arg_5_0.idList <= 0 then
		ChapterConst = var_1
		arg_5_0.flag = var_1.CellFlagDisabled

		return
	end

	table = var_1

	local var_5_0 = var_1.remove(arg_5_0.idList, 1)

	setmetatable = var_2

	local var_5_1 = var_2({
		data = 0,
		id = var_5_0,
		pos = arg_5_0.currentChampion
	}, arg_5_0.currentChampion)

	arg_5_0.currentChampion = var_0_1[var_5_1.attachment].New(var_5_1)

	return
end

function var_0_0.GetLastID(arg_6_0)
	if #arg_6_0.idList > 0 then
		return arg_6_0.idList[#arg_6_0.idList]
	else
		return arg_6_0.currentChampion.id
	end

	return
end

return var_0_0
