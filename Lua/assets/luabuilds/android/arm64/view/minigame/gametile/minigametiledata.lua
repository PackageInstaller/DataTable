local var_0_0 = class("MiniGameTileData")

local function var_0_1(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = {}
	local var_1_2 = 1
	local var_1_3 = "{\n"

	while true do
		local var_1_4 = 0

		for iter_1_0, iter_1_1 in pairs(arg_1_0) do
			var_1_4 = var_1_4 + 1
		end

		local var_1_5 = 1

		for iter_1_2, iter_1_3 in pairs(arg_1_0) do
			if ({})[arg_1_0] == nil or var_1_5 >= ({})[arg_1_0] then
				if string.find(var_1_3, "}", var_1_3:len()) then
					var_1_3 = var_1_3 .. ",\n"
				elseif not string.find(var_1_3, "\n", var_1_3:len()) then
					var_1_3 = var_1_3 .. "\n"
				end

				table.insert(var_1_1, var_1_3)

				var_1_3 = ""

				local var_1_6 = (type(iter_1_2) == "number" or type(iter_1_2) == "boolean") and "[" .. tostring(iter_1_2) .. "]" or "['" .. tostring(iter_1_2) .. "']"

				if type(iter_1_3) == "number" or type(iter_1_3) == "boolean" then
					var_1_3 = var_1_3 .. string.rep("\t", var_1_2) .. var_1_6 .. " = " .. tostring(iter_1_3)
				elseif type(iter_1_3) == "table" then
					var_1_3 = var_1_3 .. string.rep("\t", var_1_2) .. var_1_6 .. " = {\n"

					table.insert(var_1_0, arg_1_0)
					table.insert(var_1_0, iter_1_3)

					;({})[arg_1_0] = var_1_5 + 1

					break
				else
					var_1_3 = var_1_3 .. string.rep("\t", var_1_2) .. var_1_6 .. " = '" .. tostring(iter_1_3) .. "'"
				end

				var_1_3 = var_1_5 == var_1_4 and var_1_3 .. "\n" .. string.rep("\t", var_1_2 - 1) .. "}" or var_1_3 .. ","
			elseif var_1_5 == var_1_4 then
				var_1_3 = var_1_3 .. "\n" .. string.rep("\t", var_1_2 - 1) .. "}"
			end

			var_1_5 = var_1_5 + 1
		end

		if var_1_4 == 0 then
			var_1_3 = var_1_3 .. "\n" .. string.rep("\t", var_1_2 - 1) .. "}"
		end

		if #var_1_0 > 0 then
			arg_1_0 = var_1_0[#var_1_0]
			var_1_0[#var_1_0] = nil
			var_1_2 = ({})[arg_1_0] == nil and var_1_2 + 1 or var_1_2 - 1
		else
			break
		end
	end

	table.insert(var_1_1, var_1_3)
	print((table.concat(var_1_1)))

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
	local var_3_1, var_3_2 = pcall(function()
		return require(var_3_0)
	end)

	if not var_3_1 then
		errorMsg("不存在地图数据:" .. "GameCfg.MiniGameTile." .. arg_3_1 .. "." .. arg_3_2)
	end

	return var_3_1 and var_3_2
end

function var_0_0.initTile(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.tileMaps) do
		local var_5_0 = arg_5_0:loadTile(arg_5_0._name, iter_5_1)

		arg_5_0.tileMapDic[var_5_0.name] = arg_5_0:createTile(var_5_0.tiles)
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
		for iter_7_0 = 1, #arg_7_0.tileDataDic[arg_7_1].layers do
			if not arg_7_2 or arg_7_2 == arg_7_0.tileDataDic[arg_7_1].layers[iter_7_0].name then
				print(arg_7_0.tileDataDic[arg_7_1].layers[iter_7_0].name .. " = ")
				var_0_1(arg_7_0.tileDataDic[arg_7_1].layers[iter_7_0])
			end
		end
	end

	return
end

function var_0_0.initData(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.tileDatas) do
		arg_8_0.tileDataDic[iter_8_1] = arg_8_0:createMapData(arg_8_0:loadTile(arg_8_0._name, iter_8_1), iter_8_1)
	end

	return
end

function var_0_0.createTile(arg_9_0, arg_9_1)
	for iter_9_0 = 1, #arg_9_1 do
		local var_9_0 = arg_9_1[iter_9_0].properties or {}
		local var_9_2

		for iter_9_1 in string.gmatch(arg_9_1[iter_9_0].image, "[^/]+$") do
			var_9_2 = iter_9_1
		end

		table.insert({}, {
			id = arg_9_1[iter_9_0].id,
			name = string.gsub(string.gsub(var_9_2, ".png", ""), ".jpg", ""),
			properties = var_9_0
		})
	end

	;({}).maps = {}

	return {}
end

function var_0_0.createMapData(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_1 then
		return {
			layer = {},
			tilesets = {}
		}
	end

	local var_10_0 = arg_10_1.tilesets

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.layers) do
		table.insert({}, {
			name = iter_10_1.name,
			layer = arg_10_0:createLayerData(iter_10_1.data, var_10_0, arg_10_2),
			width = arg_10_1.width,
			height = arg_10_1.height
		})
	end

	return {
		layers = {},
		tilesets = var_10_0
	}
end

function var_0_0.createLayerData(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	for iter_11_0 = 1, #arg_11_1 do
		local var_11_0 = arg_11_0:relationTile(arg_11_1[iter_11_0], arg_11_2, arg_11_3, iter_11_0)

		if var_11_0 and arg_11_1[iter_11_0] ~= 0 then
			table.insert({}, var_11_0)
		end
	end

	return {}
end

function var_0_0.relationTile(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_0._name == MiniGameTile.BOOM_GAME then
		-- block empty
	elseif arg_12_0._name == MiniGameTile.SPRING23_GAME then
		-- block empty
	else
		({}).id = arg_12_1
	end

	;({}).item = nil
	;({}).drop = nil
	;({}).index = arg_12_4

	for iter_12_0 = 1, #arg_12_2 do
		if arg_12_0.tileMapDic[arg_12_2[iter_12_0].name] then
			if arg_12_2[iter_12_0].firstgid <= arg_12_1 then
				for iter_12_1, iter_12_2 in ipairs(arg_12_0.tileMapDic[arg_12_2[iter_12_0].name].maps) do
					if iter_12_2.id + arg_12_2[iter_12_0].firstgid == arg_12_1 then
						local var_12_1, var_12_2 = arg_12_0:createGridPropData(iter_12_2.properties, iter_12_2.name, arg_12_3)

						;({}).item = iter_12_2.name or nil
						;({}).prop = var_12_1 or nil

						return {}
					end
				end
			end
		else
			print("警告 找不到" .. arg_12_2[iter_12_0].name .. "的贴图数据")
		end
	end

	return {}
end

function var_0_0.createGridPropData(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = {}

	if arg_13_0._name == MiniGameTile.BOOM_GAME then
		var_13_0.drop = arg_13_1.drop_id and arg_13_1.drop_id > 0 and MiniGameTile.drops[arg_13_1.drop_id] or nil

		if arg_13_1.use_attr and arg_13_1.use_attr ~= nil then
			if MiniGameTile.attrs[arg_13_3][arg_13_2] then
				for iter_13_0, iter_13_1 in pairs(MiniGameTile.attrs[arg_13_3][arg_13_2]) do
					var_13_0[iter_13_0] = iter_13_1
				end
			end
		end
	elseif arg_13_0._name == MiniGameTile.SPRING23_GAME then
		var_13_0 = nil
	end

	return var_13_0
end

function var_0_0.getName(arg_14_0)
	return arg_14_0._name
end

return var_0_0
