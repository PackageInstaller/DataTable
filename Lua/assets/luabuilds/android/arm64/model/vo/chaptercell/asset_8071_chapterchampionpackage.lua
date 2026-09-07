local ChapterChampionPackage = class("ChapterChampionPackage")
local var_0_1 = {
	[ChapterConst.AttachOni] = import(".ChapterChampionOni"),
	[ChapterConst.AttachChampion] = import(".ChapterChampionNormal")
}

function ChapterChampionPackage:Ctor(arg_1_1)
	local var_1_0 = self:RebuildData(arg_1_1)

	self.idList = {}

	if arg_1_1.extra_id then
		for iter_1_0, iter_1_1 in ipairs(arg_1_1.extra_id) do
			self.idList[iter_1_0] = iter_1_1
		end
	end

	self.currentChampion = var_0_1[var_1_0.attachment].New(var_1_0)
	self.trait = ChapterConst.TraitNone
	self.rotation = Quaternion.identity

	rawset(self, "_init", true)

	return
end

function ChapterChampionPackage:RebuildData(arg_2_1)
	local var_2_0 = {
		id = arg_2_1.item_id,
		pos = {}
	}

	var_2_0.pos.row = arg_2_1.pos.row
	var_2_0.pos.column = arg_2_1.pos.column
	var_2_0.attachment = arg_2_1.item_type
	var_2_0.flag = arg_2_1.item_flag
	var_2_0.data = arg_2_1.item_data

	return var_2_0
end

function ChapterChampionPackage:__index(arg_3_1)
	local var_3_0 = ChapterChampionPackage[arg_3_1]

	if not ChapterChampionPackage[arg_3_1] then
		local var_3_1 = rawget(self, "currentChampion")

		if var_3_1 then
			var_3_0 = var_3_1[arg_3_1]
		end
	end

	return var_3_0
end

function ChapterChampionPackage:__newindex(arg_4_1, arg_4_2)
	if not rawget(self, "_init") then
		rawset(self, arg_4_1, arg_4_2)

		return
	end

	local var_4_0 = rawget(self, "currentChampion")

	if var_4_0 then
		var_4_0[arg_4_1] = arg_4_2
	end

	return
end

function ChapterChampionPackage:Iter()
	local var_5_0

	if #self.idList <= 0 then
		self.flag = ChapterConst.CellFlagDisabled

		do return end

		var_5_0 = {
			data = 0
		}
	end

	var_5_0.id = table.remove(self.idList, 1)
	var_5_0.pos = self.currentChampion

	local var_5_1 = setmetatable(var_5_0, self.currentChampion)

	self.currentChampion = var_0_1[var_5_1.attachment].New(var_5_1)

	return
end

function ChapterChampionPackage:GetLastID()
	if #self.idList > 0 then
		return self.idList[#self.idList]
	else
		return self.currentChampion.id
	end

	return
end

return ChapterChampionPackage
