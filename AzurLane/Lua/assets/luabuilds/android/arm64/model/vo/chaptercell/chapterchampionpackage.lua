local var_0_0 = class("ChapterChampionPackage")
local var_0_1 = {
	[ChapterConst.AttachOni] = import(".ChapterChampionOni"),
	[ChapterConst.AttachChampion] = import(".ChapterChampionNormal")
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:RebuildData(arg_1_1)

	arg_1_0.idList = {}

	if arg_1_1.extra_id then
		for iter_1_0, iter_1_1 in ipairs(arg_1_1.extra_id) do
			arg_1_0.idList[iter_1_0] = iter_1_1
		end
	end

	arg_1_0.currentChampion = var_0_1[var_1_0.attachment].New(var_1_0)
	arg_1_0.trait = ChapterConst.TraitNone
	arg_1_0.rotation = Quaternion.identity

	rawset(arg_1_0, "_init", true)

	return
end

function var_0_0.RebuildData(arg_2_0, arg_2_1)
	({
		id = arg_2_1.item_id,
		pos = {}
	}).pos.row = arg_2_1.pos.row
	;({
		id = arg_2_1.item_id,
		pos = {}
	}).pos.column = arg_2_1.pos.column
	;({
		id = arg_2_1.item_id,
		pos = {}
	}).attachment = arg_2_1.item_type
	;({
		id = arg_2_1.item_id,
		pos = {}
	}).flag = arg_2_1.item_flag
	;({
		id = arg_2_1.item_id,
		pos = {}
	}).data = arg_2_1.item_data

	return {
		id = arg_2_1.item_id,
		pos = {}
	}
end

function var_0_0.__index(arg_3_0, arg_3_1)
	local var_3_0 = var_0_0[arg_3_1]

	if not var_0_0[arg_3_1] then
		local var_3_1 = rawget(arg_3_0, "currentChampion")

		if var_3_1 then
			var_3_0 = var_3_1[arg_3_1]
		end
	end

	return var_3_0
end

function var_0_0.__newindex(arg_4_0, arg_4_1, arg_4_2)
	if not rawget(arg_4_0, "_init") then
		rawset(arg_4_0, arg_4_1, arg_4_2)

		return
	end

	local var_4_0 = rawget(arg_4_0, "currentChampion")

	if var_4_0 then
		var_4_0[arg_4_1] = arg_4_2
	end

	return
end

function var_0_0.Iter(arg_5_0)
	if #arg_5_0.idList <= 0 then
		arg_5_0.flag = ChapterConst.CellFlagDisabled

		return
	end

	;({
		data = 0
	}).id = table.remove(arg_5_0.idList, 1)
	;({
		data = 0
	}).pos = arg_5_0.currentChampion

	local var_5_0 = setmetatable({
		data = 0
	}, arg_5_0.currentChampion)

	arg_5_0.currentChampion = var_0_1[var_5_0.attachment].New(var_5_0)

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
