class = var_0_10000

local var_0_0 = var_0_10000("MiniGameTileData")

local function var_0_1(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = {}
	local var_1_2 = {}
	local var_1_3 = 1
	local var_1_4 = "{\n"

	while true do
		var_1_10006 = 0
		pairs = var_1_10007

		for iter_1_0, iter_1_1 in var_1_10007(arg_1_0) do
			var_1_10006 = var_1_10006 + 1
		end

		var_1_10007 = 1
		pairs = var_8

		for iter_1_2, iter_1_3 in var_8(arg_1_0) do
			if var_1_0[arg_1_0] == nil or var_1_0[arg_1_0] <= var_1_10007 then
				string = var_13

				if var_13.find(var_1_4, "}", var_1_4:len()) then
					var_1_4 = var_1_4 .. ",\n"
				else
					string = var_13

					if not var_13.find(var_1_4, "\n", var_1_4:len()) then
						var_1_4 = var_1_4 .. "\n"
					end
				end

				table = var_13

				var_13.insert(var_1_2, var_1_4)

				var_1_4 = ""

				local var_1_5

				type = var_14

				if var_14(iter_1_2) ~= "number" then
					type = var_1_6

					local var_1_6

					if var_1_6(iter_1_2) == "boolean" then
						var_1_6 = "["
						tostring = var_1_10015
						var_1_5 = var_1_6 .. var_1_10015(iter_1_2) .. "]"
					else
						var_1_6 = "['"
						tostring = var_1_10015
						var_1_5 = var_1_6 .. var_1_10015(iter_1_2) .. "']"
					end

					type = var_1_6

					if var_1_6(iter_1_3) ~= "number" then
						type = var_1_7

						local var_1_7, var_1_8

						if var_1_7(iter_1_3) == "boolean" then
							var_1_7 = var_1_4
							string = var_1_10015
							var_1_10015 = var_1_10015.rep("\t", var_1_3)
							var_1_8 = var_1_5

							local var_1_9 = " = "

							tostring = var_1_10018
							var_1_4 = var_1_7 .. var_1_10015 .. var_1_8 .. var_1_9 .. var_1_10018(iter_1_3)
						else
							type = var_1_7

							if var_1_7(iter_1_3) == "table" then
								local var_1_10 = var_1_4

								string = var_1_10015
								var_1_4 = var_1_10 .. var_1_10015.rep("\t", var_1_3) .. var_1_5 .. " = {\n"
								table = var_1_10

								var_1_10.insert(var_1_1, arg_1_0)

								table = var_14

								var_14.insert(var_1_1, iter_1_3)

								var_1_0[arg_1_0] = var_1_10007 + 1

								break
							else
								local var_1_11 = var_1_4

								string = var_1_10015
								var_1_10015 = var_1_10015.rep("\t", var_1_3)
								var_1_8 = var_1_5

								local var_1_12 = " = '"

								tostring = var_1_10018
								var_1_4 = var_1_11 .. var_1_10015 .. var_1_8 .. var_1_12 .. var_1_10018(iter_1_3) .. "'"
							end
						end

						if var_1_10007 == var_1_10006 then
							local var_1_13 = var_1_4

							var_1_10015 = "\n"
							string = var_1_8
							var_1_4 = var_1_13 .. var_1_10015 .. var_1_8.rep("\t", var_1_3 - 1) .. "}"
						else
							var_1_4 = var_1_4 .. ","
						end

						goto label_1_0

						if var_1_10007 == var_1_10006 then
							local var_1_14 = var_1_4
							local var_1_15 = "\n"

							string = var_1_10015
							var_1_4 = var_1_14 .. var_1_15 .. var_1_10015.rep("\t", var_1_3 - 1) .. "}"
						end

						::label_1_0::

						var_1_10007 = var_1_10007 + 1
					end
				end
			end
		end

		if var_1_10006 == 0 then
			local var_1_16 = var_1_4
			local var_1_17 = "\n"

			string = var_10
			var_1_4 = var_1_16 .. var_1_17 .. var_10.rep("\t", var_1_3 - 1) .. "}"
		end

		if #var_1_1 > 0 then
			arg_1_0 = var_1_1[#var_1_1]
			var_1_1[#var_1_1] = nil
			var_1_3 = var_1_0[arg_1_0] == nil and var_1_3 + 1 or var_1_3 - 1
		else
			break
		end
	end

	table = var_1_10006

	var_1_10006.insert(var_1_2, var_1_4)

	table = var_6

	local var_1_18 = var_6.concat(var_1_2)

	print = var_6

	var_6(var_1_18)

	return
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0._data = arg_2_1
	arg_2_0._name = arg_2_1.name
	arg_2_0.tileMaps = arg_2_1.tile_map
	arg_2_0.tileDatas = arg_2_1.tile_data
	arg_2_0.tileMapDic = {}
	arg_2_0.tileDataDic = {}

	arg_2_0:initTile()
	arg_2_0:initData()

	return
end

function var_0_0.loadTile(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = "GameCfg.MiniGameTile." .. arg_3_1 .. "." .. arg_3_2

	pcall = var_4

	local var_3_1, var_3_2 = var_4(function()
		require = var_2_10000

		return var_2_10000(var_3_0)
	end)

	if not var_3_1 then
		errorMsg = var_6

		var_6("不存在地图数据:" .. var_3_0)
	end

	return var_3_1 and var_3_2
end

function var_0_0.initTile(arg_5_0)
	ipairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0.tileMaps) do
		local var_5_0 = arg_5_0:loadTile(arg_5_0._name, iter_5_1).name
		local var_5_1 = var_6.tiles

		arg_5_0.tileMapDic[var_5_0] = arg_5_0:createTile(var_5_1)
	end

	return
end

function var_0_0.getTileDataLayer(arg_6_0, arg_6_1)
	if arg_6_0.tileDataDic[arg_6_1] then
		return arg_6_0.tileDataDic[arg_6_1].layers
	end

	return nil
end

function var_0_0.dumpTileDataLayer(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.tileDataDic[arg_7_1] then
		local var_7_0 = arg_7_0.tileDataDic[arg_7_1].layers

		for iter_7_0 = 1, #var_7_0 do
			local var_7_1 = var_7_0[iter_7_0]

			if not arg_7_2 or arg_7_2 == var_7_1.name then
				print = var_1_10009

				var_1_10009(var_7_1.name .. " = ")
				var_0_1(var_7_1)
			end
		end
	end

	return
end

function var_0_0.initData(arg_8_0)
	ipairs = var_1_10001

	for iter_8_0, iter_8_1 in var_1_10001(arg_8_0.tileDatas) do
		local var_8_0 = arg_8_0:loadTile(arg_8_0._name, iter_8_1)

		arg_8_0.tileDataDic[iter_8_1] = arg_8_0:createMapData(var_8_0, iter_8_1)
	end

	return
end

function var_0_0.createTile(arg_9_0, arg_9_1)
	local var_9_0 = {}
	local var_9_1 = {}

	for iter_9_0 = 1, #arg_9_1 do
		local var_9_2 = arg_9_1[iter_9_0].id
		local var_9_3

		if not var_8.properties then
			var_9_3 = {}
		end

		local var_9_4 = var_8.image
		local var_9_5

		string = var_1_10013

		for iter_9_1 in var_1_10013.gmatch(var_8.image, "[^/]+$") do
			var_9_5 = iter_9_1
		end

		string = var_1_10013

		local var_9_6 = var_1_10013.gsub(var_9_5, ".png", "")

		string = var_1_10013

		local var_9_7 = var_1_10013.gsub(var_9_6, ".jpg", "")

		table = var_1_10013

		var_1_10013.insert(var_9_1, {
			id = var_9_2,
			name = var_9_7,
			properties = var_9_3
		})
	end

	var_9_0.maps = var_9_1

	return var_9_0
end

function var_0_0.createMapData(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_1 then
		return {
			layer = {},
			tilesets = {}
		}
	end

	local var_10_0 = arg_10_1.tilesets
	local var_10_1 = arg_10_1.layers
	local var_10_2 = arg_10_1.width
	local var_10_3 = arg_10_1.height
	local var_10_4 = {}

	ipairs = var_1_10008

	for iter_10_0, iter_10_1 in var_1_10008(var_10_1) do
		local var_10_5 = iter_10_1.name
		local var_10_6 = iter_10_1.data
		local var_10_7 = arg_10_0
		local var_10_8 = arg_10_0.createLayerData(var_10_7, var_10_6, var_10_0, arg_10_2)

		table = var_10_7

		var_10_7.insert(var_10_4, {
			name = var_10_5,
			layer = var_10_8,
			width = var_10_2,
			height = var_10_3
		})
	end

	return {
		layers = var_10_4,
		tilesets = var_10_0
	}
end

function var_0_0.createLayerData(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = {}

	for iter_11_0 = 1, #arg_11_1 do
		local var_11_1 = arg_11_1[iter_11_0]
		local var_11_2 = iter_11_0
		local var_11_3 = arg_11_0

		if arg_11_0.relationTile(var_11_3, var_11_1, arg_11_2, arg_11_3, var_11_2) and var_11_1 ~= 0 then
			table = var_11_3

			var_11_3.insert(var_11_0, var_11)
		end
	end

	return var_11_0
end

function var_0_0.relationTile(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = {}
	local var_12_1 = arg_12_0._name

	MiniGameTile = var_1_10007

	if var_12_1 == var_1_10007.BOOM_GAME then
		-- block empty
	else
		local var_12_2 = arg_12_0._name

		MiniGameTile = var_7

		if var_12_2 == var_7.SPRING23_GAME then
			-- block empty
		else
			var_12_0.id = arg_12_1
		end
	end

	var_12_0.item = nil
	var_12_0.drop = nil
	var_12_0.index = arg_12_4

	for iter_12_0 = 1, #arg_12_2 do
		local var_12_3 = arg_12_2[iter_12_0].firstgid
		local var_12_4 = var_10.name

		if arg_12_0.tileMapDic[var_12_4] then
			var_1_10014 = var_13.maps

			if var_12_3 <= arg_12_1 then
				ipairs = var_1_10015

				for iter_12_1, iter_12_2 in var_1_10015(var_1_10014) do
					if iter_12_2.id + var_12_3 == arg_12_1 then
						local var_12_5 = arg_12_1
						local var_12_6 = iter_12_2.name
						local var_12_7, var_12_8 = arg_12_0:createGridPropData(iter_12_2.properties, iter_12_2.name, arg_12_3)

						var_12_0.item = var_12_6 or nil
						var_12_0.prop = var_12_7 or nil

						return var_12_0
					end
				end
			end
		else
			print = var_1_10014

			var_1_10014("警告 找不到" .. var_12_4 .. "的贴图数据")
		end
	end

	return var_12_0
end

function var_0_0.createGridPropData(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = {}
	local var_13_1
	local var_13_2 = arg_13_0._name

	MiniGameTile = var_1_10007

	local var_13_4

	if var_13_2 == var_1_10007.BOOM_GAME then
		local var_13_3 = arg_13_1.drop_id

		var_13_4 = nil

		if var_13_3 and 0 < var_13_3 then
			MiniGameTile = var_8
			var_13_0.drop = var_8.drops[var_13_3]
		else
			var_13_0.drop = nil
		end

		if arg_13_1.use_attr and arg_13_1.use_attr ~= nil then
			MiniGameTile = var_8

			if var_8.attrs[arg_13_3][arg_13_2] then
				pairs = var_1_10010

				for iter_13_0, iter_13_1 in var_1_10010(var_9) do
					var_13_0[iter_13_0] = iter_13_1
				end
			end
		end
	else
		local var_13_5 = arg_13_0._name

		MiniGameTile = var_13_4

		if var_13_5 == var_13_4.SPRING23_GAME then
			var_13_0 = nil
		end
	end

	return var_13_0
end

function var_0_0.getName(arg_14_0)
	return arg_14_0._name
end

return var_0_0
