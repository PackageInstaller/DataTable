local DrawAwardActivity = class("DrawAwardActivity", import("model.vo.Activity"))

function DrawAwardActivity:Ctor(arg_1_1)
	DrawAwardActivity.super.Ctor(self, arg_1_1)

	self.countDic = self.data1KeyValueList[1]
	self.storeDic = {}
	self.rarityDic = {}

	for iter_1_0, iter_1_1 in ipairs(self:GetDrawConfig("reward_list")) do
		local var_1_0, var_1_1 = unpack(iter_1_1)

		self.storeDic[var_1_0] = var_1_1
		self.rarityDic[pg.island_draw_reward[var_1_0].rarity] = self.rarityDic[pg.island_draw_reward[var_1_0].rarity] or {}

		table.insert(self.rarityDic[pg.island_draw_reward[var_1_0].rarity], var_1_0)
	end

	return
end

function DrawAwardActivity:GetDrawConfig(arg_2_1)
	assert(pg.island_draw[self.configId], "without config in pg.island_draw:" .. self.configId)

	return pg.island_draw[self.configId][arg_2_1]
end

function DrawAwardActivity:GetDrawTimes()
	return self.data1
end

function DrawAwardActivity:GetDrawCount()
	return self.data2
end

function DrawAwardActivity:SetList(arg_5_1)
	self.data1_list = underscore.to_array(arg_5_1)

	return
end

function DrawAwardActivity:GetList()
	local var_6_0 = {}
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(self.data1_list) do
		var_6_1[iter_6_1] = defaultValue(var_6_1[iter_6_1], 0) + 1

		table.insert(var_6_0, {
			iter_6_1,
			true
		})
	end

	for iter_6_2, iter_6_3 in ipairs(self.rarityDic[4] or {}) do
		for iter_6_4 = defaultValue(self.storeDic[iter_6_3], 0), defaultValue(var_6_1[iter_6_3], 0) + 1, -1 do
			table.insert(var_6_0, {
				iter_6_3,
				iter_6_4 > defaultValue(var_6_1[iter_6_3], 0) + defaultValue(self.countDic[iter_6_3], 0)
			})
		end
	end

	return var_6_0
end

function DrawAwardActivity:CheckList(arg_7_1)
	local var_7_0 = {}
	local var_7_1 = 0

	for iter_7_0, iter_7_1 in ipairs(self.rarityDic[4]) do
		var_7_0[iter_7_1] = defaultValue(self.storeDic[iter_7_1], 0) - defaultValue(self.countDic[iter_7_1], 0)
		var_7_1 = var_7_1 + var_7_0[iter_7_1]
	end

	if #arg_7_1 ~= var_7_1 then
		return false
	end

	for iter_7_2, iter_7_3 in ipairs(arg_7_1) do
		var_7_0[iter_7_3] = defaultValue(var_7_0[iter_7_3], 0) - 1

		if var_7_0[iter_7_3] < 0 then
			return false
		end
	end

	return true
end

function DrawAwardActivity:GetCountAwardsRecord()
	return self.data2_list
end

function DrawAwardActivity:GetRarityIds(arg_9_1)
	return self.rarityDic[switch(arg_9_1, {
		S = function()
			return 4
		end,
		A = function()
			return 3
		end,
		B = function()
			return 2
		end,
		C = function()
			return 1
		end
	})]
end

function DrawAwardActivity:GetRankList(arg_14_1)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(self:GetRarityIds(arg_14_1)) do
		for iter_14_2 = defaultValue(self.storeDic[iter_14_1], 0), 1, -1 do
			table.insert(var_14_0, {
				iter_14_1,
				iter_14_2 > defaultValue(self.countDic[iter_14_1], 0)
			})
		end
	end

	return var_14_0
end

function DrawAwardActivity:GetTimesLeft(arg_15_1)
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in ipairs(arg_15_1 and self:GetRarityIds(arg_15_1) or underscore.map(self:GetDrawConfig("reward_list"), function(arg_16_0)
		return arg_16_0[1]
	end)) do
		var_15_0 = var_15_0 + defaultValue(self.storeDic[iter_15_1], 0) - defaultValue(self.countDic[iter_15_1], 0)
	end

	return var_15_0
end

function DrawAwardActivity:ResultDraw(arg_17_1)
	self.data1 = self.data1 - #arg_17_1
	self.data2 = self.data2 + #arg_17_1

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		self.countDic[iter_17_1] = defaultValue(self.countDic[iter_17_1], 0) + 1

		if pg.island_draw_reward[iter_17_1].rarity == 4 then
			if #self.data1_list == 0 or self.data1_list[1] == iter_17_1 then
				table.remove(self.data1_list, 1)
			else
				assert(false, string.format("error SList drop %d in %s", iter_17_1, PrintTable(self.data1_list)))
			end
		end
	end

	return
end

function DrawAwardActivity:CountAward(arg_18_1)
	table.insert(self.data2_list, arg_18_1)

	return
end

function DrawAwardActivity:GetCountAwards()
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(self.data2_list) do
		var_19_0[iter_19_1] = defaultValue(var_19_0[iter_19_1], 0) + 1
	end

	local var_19_1 = {}

	for iter_19_2, iter_19_3 in ipairs(self:GetDrawConfig("reward_acc")) do
		local var_19_2, var_19_3 = unpack(iter_19_3)

		for iter_19_4 = 1, var_19_3 do
			table.insert(var_19_1, {
				var_19_2,
				iter_19_4 > defaultValue(var_19_0[var_19_2], 0)
			})
		end
	end

	return var_19_1
end

function DrawAwardActivity:GetNextCountAwardTimes()
	return self:GetDrawConfig("acc_count_list")[#self.data2_list + 1]
end

function DrawAwardActivity:CanCountAward(arg_21_1)
	if not arg_21_1 then
		return true
	end

	local var_21_0 = self:GetNextCountAwardTimes()

	if not var_21_0 or var_21_0 > self.data2 then
		return false
	end

	local var_21_1 = 0

	for iter_21_0, iter_21_1 in ipairs(self.data2_list) do
		if iter_21_1 == arg_21_1 then
			var_21_1 = var_21_1 - 1
		end
	end

	for iter_21_2, iter_21_3 in ipairs(self:GetDrawConfig("reward_acc")) do
		local var_21_2, var_21_3 = unpack(iter_21_3)

		if arg_21_1 == var_21_2 then
			var_21_1 = var_21_1 + var_21_3

			if var_21_1 > 0 then
				return true
			end
		end
	end

	return false
end

function DrawAwardActivity:GetShowRankList(arg_22_1)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(self:GetRankList(arg_22_1)) do
		local var_22_1, var_22_2 = unpack(iter_22_1)

		if noEmptyStr(pg.island_draw_reward[var_22_1].show) then
			table.insert(var_22_0, var_22_1)
		end
	end

	return var_22_0
end

function DrawAwardActivity:GetLastItemCount(arg_23_1)
	return defaultValue(self.storeDic[arg_23_1], 0) - defaultValue(self.countDic[arg_23_1], 0)
end

return DrawAwardActivity
