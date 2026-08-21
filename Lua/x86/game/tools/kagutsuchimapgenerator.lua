local var_0_0 = import("game.tools.KagutsuchiMap")

return {
	Ctor = function(arg_1_0)
		arg_1_0.dirty_ = true
	end,
	SetMapSize = function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0.width_ == arg_2_1 and arg_2_0.height_ == arg_2_2 then
			return
		end

		arg_2_0.width_ = arg_2_1
		arg_2_0.height_ = arg_2_2
		arg_2_0.dirty_ = true
	end,
	SetMapSeed = function(arg_3_0, arg_3_1)
		if arg_3_0.seed_ == arg_3_1 then
			return
		end

		arg_3_0.seed_ = arg_3_1
		arg_3_0.dirty_ = true
	end,
	SetMapGrids = function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		if arg_4_0.transformList_ == arg_4_1 then
			return
		end

		arg_4_0.transformList_ = arg_4_1

		local var_4_0 = var_0_0.New(arg_4_0.width_, arg_4_0.height_)

		for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
			local var_4_1, var_4_2 = arg_4_3(iter_4_1)
			local var_4_3 = {
				x = var_4_1,
				y = var_4_2,
				transform = iter_4_1,
				idx = iter_4_0
			}

			if var_4_0:IsOverbound(var_4_1, var_4_2) then
				Debug.LogError(string.format("(%d,%d)超出范围", var_4_1, var_4_2))
			end

			local var_4_4 = arg_4_2(var_4_3)

			var_4_0:PutGrid(var_4_1, var_4_2, var_4_4)
		end

		arg_4_0.map_ = var_4_0
		arg_4_0.dirty_ = true
	end,
	GeneratePlaceableGrids = function(arg_5_0, arg_5_1, arg_5_2)
		if not arg_5_0.dirty_ and #arg_5_0.placeableGrids_ == arg_5_1 then
			return arg_5_0.placeableGrids_
		end

		local var_5_0 = arg_5_0.map_:GetGridCount()

		if var_5_0 < arg_5_1 then
			Debug.LogError("超出格子数目")
		end

		local var_5_1 = RandomUtil.GenRandom(arg_5_0.seed_)
		local var_5_2 = {}
		local var_5_3 = 0

		for iter_5_0 = 1, arg_5_1 do
			local var_5_4 = var_5_1:NextInt(var_5_0) + 1

			while not arg_5_0:CheckGrid(var_5_4) do
				var_5_4 = var_5_1:NextInt(var_5_0) + 1
				var_5_3 = var_5_3 + 1

				if var_5_3 > 1000 then
					Debug.LogError("无法生成放置格子")
				end
			end

			local var_5_5 = arg_5_0.map_:GetGridByIndex(var_5_4)
			local var_5_6 = {
				grid = var_5_5,
				index = iter_5_0
			}

			arg_5_2(var_5_6)
			table.insert(var_5_2, var_5_4)
		end

		arg_5_0.placeableGrids_ = var_5_2
		arg_5_0.dirty_ = false

		return var_5_2
	end,
	CheckGrid = function(arg_6_0, arg_6_1)
		local var_6_0, var_6_1 = arg_6_0.map_:GetGridXY(arg_6_1)

		return not arg_6_0:IsGridOccupied(var_6_0, var_6_1) and not arg_6_0:IsGridOccupied(var_6_0 - 1, var_6_1) and not arg_6_0:IsGridOccupied(var_6_0 + 1, var_6_1) and not arg_6_0:IsGridOccupied(var_6_0, var_6_1 - 1) and not arg_6_0:IsGridOccupied(var_6_0, var_6_1 + 1)
	end,
	IsGridOccupied = function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_7_0.map_:GetGrid(arg_7_1, arg_7_2)

		return var_7_0 and var_7_0.playGrid
	end,
	Clear = function(arg_8_0)
		arg_8_0.transformList_ = nil
		arg_8_0.dirty_ = true
	end
}
