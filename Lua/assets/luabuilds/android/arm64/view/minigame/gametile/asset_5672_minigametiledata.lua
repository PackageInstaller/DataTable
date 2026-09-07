local MiniGameTileData = class("MiniGameTileData")

local function var_0_1(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = {}
	local var_1_2 = {}
	local var_1_3 = 1
	local var_1_4 = "{\n"

	while true do
		local var_1_5 = 0

		for iter_1_0, iter_1_1 in pairs(arg_1_0) do
			var_1_5 = var_1_5 + 1
		end

		local var_1_6 = 1

		for iter_1_2, iter_1_3 in pairs(arg_1_0) do
			if var_1_0[arg_1_0] == nil or var_1_6 >= var_1_0[arg_1_0] then
				if string.find(var_1_4, "}", var_1_4:len()) then
					var_1_4 = var_1_4 .. ",\n"
				elseif not string.find(var_1_4, "\n", var_1_4:len()) then
					var_1_4 = var_1_4 .. "\n"
				end

				table.insert(var_1_2, var_1_4)

				var_1_4 = ""

				local var_1_7 = (type(iter_1_2) == "number" or type(iter_1_2) == "boolean") and "[" .. tostring(iter_1_2) .. "]" or "['" .. tostring(iter_1_2) .. "']"

				if type(iter_1_3) == "number" or type(iter_1_3) == "boolean" then
					var_1_4 = var_1_4 .. string.rep("\t", var_1_3) .. var_1_7 .. " = " .. tostring(iter_1_3)
				elseif type(iter_1_3) == "table" then
					var_1_4 = var_1_4 .. string.rep("\t", var_1_3) .. var_1_7 .. " = {\n"

					table.insert(var_1_1, arg_1_0)
					table.insert(var_1_1, iter_1_3)

					var_1_0[arg_1_0] = var_1_6 + 1

					break
				else
					var_1_4 = var_1_4 .. string.rep("\t", var_1_3) .. var_1_7 .. " = '" .. tostring(iter_1_3) .. "'"
				end

				var_1_4 = var_1_6 == var_1_5 and var_1_4 .. "\n" .. string.rep("\t", var_1_3 - 1) .. "}" or var_1_4 .. ","
			elseif var_1_6 == var_1_5 then
				var_1_4 = var_1_4 .. "\n" .. string.rep("\t", var_1_3 - 1) .. "}"
			end

			var_1_6 = var_1_6 + 1
		end

		if var_1_5 == 0 then
			var_1_4 = var_1_4 .. "\n" .. string.rep("\t", var_1_3 - 1) .. "}"
		end

		if #var_1_1 > 0 then
			arg_1_0 = var_1_1[#var_1_1]
			var_1_1[#var_1_1] = nil
			var_1_3 = var_1_0[arg_1_0] == nil and var_1_3 + 1 or var_1_3 - 1
		else
			break
		end
	end

	table.insert(var_1_2, var_1_4)
	print((table.concat(var_1_2)))

	return
end

function MiniGameTileData:Ctor(arg_2_1)
	self._data = arg_2_1
	self._name = arg_2_1.name
	self.tileMaps = arg_2_1.tile_map
	self.tileDatas = arg_2_1.tile_data
	self.tileMapDic = {}
	self.tileDataDic = {}

	self:initTile()
	self:initData()

	return
end

function MiniGameTileData:loadTile(arg_3_1, arg_3_2)
	local var_3_0 = "GameCfg.MiniGameTile." .. arg_3_1 .. "." .. arg_3_2
	local var_3_1, var_3_2 = pcall(function()
		return require(var_3_0)
	end)

	if not var_3_1 then
		errorMsg("不存在地图数据:" .. "GameCfg.MiniGameTile." .. arg_3_1 .. "." .. arg_3_2)
	end

	return var_3_1 and var_3_2
end

function MiniGameTileData:initTile()
	for iter_5_0, iter_5_1 in ipairs(self.tileMaps) do
		local var_5_0 = self:loadTile(self._name, iter_5_1)

		self.tileMapDic[var_5_0.name] = self:createTile(var_5_0.tiles)
	end

	return
end

function MiniGameTileData:getTileDataLayer(arg_6_1)
	if self.tileDataDic[arg_6_1] then
		return self.tileDataDic[arg_6_1].layers
	end

	return nil
end

function MiniGameTileData:dumpTileDataLayer(arg_7_1, arg_7_2)
	if self.tileDataDic[arg_7_1] then
		for iter_7_0 = 1, #self.tileDataDic[arg_7_1].layers do
			if not arg_7_2 or arg_7_2 == self.tileDataDic[arg_7_1].layers[iter_7_0].name then
				print(self.tileDataDic[arg_7_1].layers[iter_7_0].name .. " = ")
				var_0_1(self.tileDataDic[arg_7_1].layers[iter_7_0])
			end
		end
	end

	return
end

function MiniGameTileData:initData()
	for iter_8_0, iter_8_1 in ipairs(self.tileDatas) do
		self.tileDataDic[iter_8_1] = self:createMapData(self:loadTile(self._name, iter_8_1), iter_8_1)
	end

	return
end

function MiniGameTileData:createTile(arg_9_1)
	local var_9_0 = {}
	local var_9_1 = {}

	for iter_9_0 = 1, #arg_9_1 do
		local var_9_2 = arg_9_1[iter_9_0].properties or {}
		local var_9_4

		for iter_9_1 in string.gmatch(arg_9_1[iter_9_0].image, "[^/]+$") do
			var_9_4 = iter_9_1
		end

		table.insert(var_9_1, {
			id = arg_9_1[iter_9_0].id,
			name = string.gsub(string.gsub(var_9_4, ".png", ""), ".jpg", ""),
			properties = var_9_2
		})
	end

	var_9_0.maps = var_9_1

	return var_9_0
end

function MiniGameTileData:createMapData(arg_10_1, arg_10_2)
	if not arg_10_1 then
		return {
			layer = {},
			tilesets = {}
		}
	end

	local var_10_0 = arg_10_1.tilesets
	local var_10_1 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.layers) do
		table.insert(var_10_1, {
			name = iter_10_1.name,
			layer = self:createLayerData(iter_10_1.data, var_10_0, arg_10_2),
			width = arg_10_1.width,
			height = arg_10_1.height
		})
	end

	return {
		layers = var_10_1,
		tilesets = var_10_0
	}
end

function MiniGameTileData:createLayerData(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = {}

	for iter_11_0 = 1, #arg_11_1 do
		local var_11_1 = self:relationTile(arg_11_1[iter_11_0], arg_11_2, arg_11_3, iter_11_0)

		if var_11_1 and arg_11_1[iter_11_0] ~= 0 then
			table.insert(var_11_0, var_11_1)
		end
	end

	return var_11_0
end

function MiniGameTileData:relationTile(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = {}

	if self._name == MiniGameTile.BOOM_GAME then
		-- block empty
	elseif self._name == MiniGameTile.SPRING23_GAME then
		-- block empty
	else
		var_12_0.id = arg_12_1
	end

	var_12_0.item = nil
	var_12_0.drop = nil
	var_12_0.index = arg_12_4

	for iter_12_0 = 1, #arg_12_2 do
		if self.tileMapDic[arg_12_2[iter_12_0].name] then
			if arg_12_2[iter_12_0].firstgid <= arg_12_1 then
				for iter_12_1, iter_12_2 in ipairs(self.tileMapDic[arg_12_2[iter_12_0].name].maps) do
					if iter_12_2.id + arg_12_2[iter_12_0].firstgid == arg_12_1 then
						local var_12_2, var_12_3 = self:createGridPropData(iter_12_2.properties, iter_12_2.name, arg_12_3)

						var_12_0.item = iter_12_2.name or nil
						var_12_0.prop = var_12_2 or nil

						return var_12_0
					end
				end
			end
		else
			print("警告 找不到" .. arg_12_2[iter_12_0].name .. "的贴图数据")
		end
	end

	return var_12_0
end

function MiniGameTileData:createGridPropData(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = {}

	if self._name == MiniGameTile.BOOM_GAME then
		var_13_0.drop = arg_13_1.drop_id and arg_13_1.drop_id > 0 and MiniGameTile.drops[arg_13_1.drop_id] or nil

		if arg_13_1.use_attr and arg_13_1.use_attr ~= nil then
			if MiniGameTile.attrs[arg_13_3][arg_13_2] then
				for iter_13_0, iter_13_1 in pairs(MiniGameTile.attrs[arg_13_3][arg_13_2]) do
					var_13_0[iter_13_0] = iter_13_1
				end
			end
		end
	elseif self._name == MiniGameTile.SPRING23_GAME then
		var_13_0 = nil
	end

	return var_13_0
end

function MiniGameTileData:getName()
	return self._name
end

return MiniGameTileData
