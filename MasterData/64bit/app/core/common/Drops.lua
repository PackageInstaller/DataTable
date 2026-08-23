local var_0_0 = table.insert
local var_0_1 = table.sort
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.config.drop_info
local var_0_4 = 0

while g.core.config.drop_info.hasKey(table.concat({
	"reward_type_",
	1
})) do
	var_0_4 = var_0_4 + 1
end

local var_0_6 = 0

for iter_0_0, iter_0_1 in g.core.config.drop_info.ipairs() do
	if var_0_6 < iter_0_1.num then
		var_0_6 = iter_0_1.num
	end
end

return {
	MaxNum = var_0_6,
	_mergeGoods = function(arg_1_0, arg_1_1, arg_1_2)
		if not arg_1_2.good then
			return
		end

		local var_1_0 = table.concat({
			arg_1_2.good.type,
			"_",
			arg_1_2.good.value,
			"_",
			arg_1_2.good.size
		})

		if arg_1_1[var_1_0] then
			local var_1_1 = arg_1_1[var_1_0].good or nil

			if var_1_1 then
				var_1_1.size = var_1_1.size + arg_1_2.good.size

				if var_1_1.max_size then
					var_1_1.max_size = var_1_1.max_size + arg_1_2.good.max_size or 0
				elseif arg_1_2.good.max_size then
					var_1_1.max_size = arg_1_2.good.max_size
				end

				goto label_1_0
			end
		end

		arg_1_1[var_1_0] = arg_1_2

		::label_1_0::
	end,
	_getGoodsInternal = function(self, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		local var_2_0 = {}
		local var_2_1 = 1
		local var_2_2 = var_0_3.get(arg_2_1, 1)

		arg_2_3 = arg_2_3 or 1

		repeat
			for iter_2_0 = 1, var_0_4 do
				local var_2_3 = var_2_2[table.concat({
					"reward_type_",
					iter_2_0
				})]
				local var_2_4 = var_2_2[table.concat({
					"reward_value_",
					iter_2_0
				})]

				if var_2_3 ~= 0 then
					if var_2_3 ~= var_0_2.TYPE_DROP then
						local var_2_5 = {
							type = var_2_3,
							value = var_2_4,
							size = var_2_2[table.concat({
								"reward_min_",
								iter_2_0
							})]
						}

						var_2_5.maxSize = not arg_2_2 and var_2_2[table.concat({
							"reward_max_",
							iter_2_0
						})] or nil

						local var_2_6 = var_0_2:convert(var_2_5)

						if arg_2_4 then
							table.insert(var_2_0, {
								good = var_2_6,
								index = arg_2_3
							})
						else
							self:_mergeGoods(var_2_0, {
								good = var_2_6,
								index = arg_2_3
							})
						end

						arg_2_3 = arg_2_3 + 1
					else
						local var_2_7, var_2_8 = self:_getGoodsInternal(var_2_4, arg_2_2, arg_2_3, arg_2_4)

						arg_2_3 = var_2_8

						for iter_2_1, iter_2_2 in pairs(var_2_7) do
							if arg_2_4 then
								table.insert(var_2_0, iter_2_2)
							else
								self:_mergeGoods(var_2_0, iter_2_2)
							end
						end
					end
				end
			end

			var_2_1 = var_2_1 + 1
			var_2_2 = var_0_3.fetch(arg_2_1, var_2_1)
		until not var_2_2

		return var_2_0, arg_2_3
	end,
	CheckLineUp = function(self, arg_3_1, arg_3_2, arg_3_3)
		for iter_3_0, iter_3_1 in ipairs((self:GetBioFastGoodsArrary(arg_3_2))) do
			if iter_3_1.group == arg_3_1 then
				return true
			end
		end

		return false
	end,
	GetBioFastGoodsArrary = function(self, arg_4_1, arg_4_2)
		local var_4_0 = {}

		for iter_4_0, iter_4_1 in pairs((self:_getGoodsInternal(arg_4_1, arg_4_2))) do
			if iter_4_1.good.quality >= 6 then
				var_0_0(var_4_0, iter_4_1)
			end
		end

		var_0_1(var_4_0, function(arg_5_0, arg_5_1)
			return arg_5_0.index < arg_5_1.index
		end)

		local var_4_1 = {}

		for iter_4_2, iter_4_3 in ipairs(var_4_0) do
			var_0_0(var_4_1, iter_4_3.good)
		end

		return var_4_1
	end,
	getGoodsArray = function(self, arg_6_1, arg_6_2, arg_6_3)
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in pairs((self:_getGoodsInternal(arg_6_1, arg_6_2, nil, arg_6_3))) do
			var_0_0(var_6_0, iter_6_1)
		end

		var_0_1(var_6_0, function(arg_7_0, arg_7_1)
			return arg_7_0.index < arg_7_1.index
		end)

		local var_6_1 = {}

		for iter_6_2, iter_6_3 in ipairs(var_6_0) do
			var_0_0(var_6_1, iter_6_3.good)
		end

		return var_6_1
	end,
	getGoodsArrayNoRank = function(self, arg_8_1)
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs((self:_getGoodsInternal(arg_8_1, false, nil, true))) do
			var_0_0(var_8_0, iter_8_1.good)
		end

		return var_8_0
	end,
	getKeyLength = function(arg_9_0)
		return var_0_4
	end
}
