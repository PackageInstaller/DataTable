local var_0_2 = table.concat

local function var_0_3(arg_1_0, arg_1_1)
	return function()
		return arg_1_1(arg_1_0, ...)
	end
end

local ConfigEx = import(".ConfigEx")
local var_0_5 = {
	_cfgCache = {},
	_cfgRef = {},
	__index = function(self, arg_3_1)
		local var_3_0 = arg_3_1
		local var_3_1 = self._cfgRef[arg_3_1]

		if not self._cfgRef[arg_3_1] then
			self._cfgRef[arg_3_1] = setmetatable({}, {
				__index = function(arg_4_0, arg_4_1)
					assert(ConfigEx[arg_4_1], "Invalid function named: " .. tostring(arg_4_1))

					local var_4_0 = g.core.config._cfgCache[var_3_0]

					if not g.core.config._cfgCache[var_3_0] then
						var_4_0 = self:_loadCfg(var_3_0)
						g.core.config._cfgCache[var_3_0] = var_4_0
					end

					return var_0_3(var_4_0, ConfigEx[arg_4_1])
				end
			})
			var_3_1 = self._cfgRef[arg_3_1]
		end

		return var_3_1
	end
}

setmetatable(var_0_5, {
	__index = var_0_5.__index
})

function var_0_5:reset()
	if self._cfgCache.language_info and self._cfgCache.language_info.close then
		self._cfgCache.language_info.close()
	end

	self._cfgCache = {}
	self._cfgRef = {}
end

function var_0_5:load(arg_6_1)
	self._cfgCache[arg_6_1] = self:_loadCfg(arg_6_1)
end

function var_0_5._checkRegionFileName(arg_7_0, arg_7_1)
	if config.DEBUG_VERSION or config.SHOW_DEBUG_BTN then
		local var_7_0 = g.core.common.Storage:load("channelDebug.json", false)

		if var_7_0 and var_7_0.channel then
			local var_7_1 = tonumber(var_7_0.channel)

			if var_7_1 ~= config.PUBLISH_REGION then
				config.PUBLISH_REGION = var_7_1
				arg_7_0._cfgCache = {}
				arg_7_0._cfgRef = {}

				if device.checkRegionConfig then
					device.checkRegionConfig()
				end
			end
		end
	end

	if g.core.const.ConstMgr.PlatformConst.REGION_CONFIG_DICT[arg_7_1] then
		local var_7_2 = g.core.const.ConstMgr.PlatformConst.REGION_SHORT[config.PUBLISH_REGION] or "cn"

		return var_0_2({
			arg_7_1,
			"_",
			var_7_2
		})
	end

	if BATTLE_CONFIG_TYPE.isOs then
		return BATTLE_CONFIG_TYPE.config[arg_7_1] or arg_7_1
	end

	return arg_7_1
end

function var_0_5:_loadCfg(arg_8_1)
	if arg_8_1 == "language_info" then
		local ConfigLang = require("app.core.config.ConfigLang")

		ConfigLang.__name = arg_8_1

		ConfigLang.init()

		return ConfigLang
	end

	local var_8_1 = require(var_0_2({
		"app.core.config.cfg.",
		(self:_checkRegionFileName(arg_8_1))
	}))

	var_8_1.__name = arg_8_1

	local var_8_2, var_8_3 = debug.getupvalue(var_8_1.hasKey, 1)

	var_8_1.__keyMap = clone(var_8_3)

	if g.core.platform.PlatformProxy:isMajia() then
		if var_8_1.hasKey("count") then
			local var_8_5 = var_8_1.indexOf(1).count
		end

		for iter_8_0 = 1, 3 do
			if var_8_1.hasKey(var_0_2({
				"change",
				iter_8_0
			})) and not var_8_1[var_0_2({
				"__changeInit",
				iter_8_0
			})] then
				for iter_8_1 = 1, var_8_1.getLength() do
					local var_8_6 = var_8_1.indexOf(iter_8_1).toObject()
					local var_8_7 = var_8_1.indexOf(iter_8_1)
					local var_8_8 = var_8_6[var_0_2({
						"change",
						iter_8_0
					})]

					if var_8_6[var_8_8] then
						local var_8_9 = var_0_2({
							tostring(var_8_8),
							"_other"
						})

						if var_8_6[var_8_9] then
							var_8_7._raw[var_8_1.__keyMap[var_8_8]] = var_8_7._raw[var_8_1.__keyMap[var_8_9]]
						end
					end
				end

				var_8_1[var_0_2({
					"__changeInit",
					iter_8_0
				})] = true
			end
		end
	end

	if var_8_1.hasKey("game_type") and not var_8_1.__inited then
		local var_8_10 = 0
		local var_8_11 = {}
		local var_8_12 = {}
		local var_8_13 = tostring(g.core.platform.PlatformProxy:getOpGameId())
		local var_8_14 = tostring(g.core.platform.PlatformProxy:getOpId())

		if var_8_1.hasKey("op_game_id") then
			-- block empty
		end

		for iter_8_2 = 1, var_8_1.getLength() do
			local var_8_15 = var_8_1.indexOf(iter_8_2)
			local var_8_16 = "0"

			if g.core.platform.PlatformProxy:isMajia() then
				if var_8_15.game_type ~= 1 and (var_8_16 == "0" or var_8_16 == var_8_13 or var_8_16 == var_0_2({
					var_8_13,
					"_",
					var_8_14
				})) then
					var_8_10 = var_8_10 + 1
					var_8_11[var_8_10] = iter_8_2
					var_8_12[iter_8_2] = var_8_10
				else
					var_8_12[iter_8_2] = 1
				end
			elseif var_8_15.game_type ~= 2 and (var_8_16 == "0" or var_8_16 == var_8_13 or var_8_16 == var_0_2({
				var_8_13,
				"_",
				var_8_14
			})) then
				var_8_10 = var_8_10 + 1
				var_8_11[var_8_10] = iter_8_2
				var_8_12[iter_8_2] = var_8_10
			else
				var_8_12[iter_8_2] = 1
			end
		end

		local var_8_17 = var_8_1.get_index_data()

		for iter_8_3, iter_8_4 in pairs(var_8_17) do
			var_8_17[iter_8_3] = var_8_12[iter_8_4]
		end

		function var_8_1.getLength()
			return var_8_10
		end

		var_8_1._indexOf = var_8_1.indexOf

		function var_8_1.indexOf(arg_10_0)
			return var_8_1._indexOf(var_8_11[arg_10_0])
		end

		var_8_1.__inited = true
	elseif var_8_1.hasKey("op_game_id") and not var_8_1.__inited then
		local var_8_18 = 0
		local var_8_19 = {}
		local var_8_20 = {}
		local var_8_21 = g.core.platform.PlatformProxy:getOpGameId()
		local var_8_22 = tostring(g.core.platform.PlatformProxy:getOpId())

		if (tonumber(var_8_21) or 0) > 0 then
			for iter_8_5 = 1, var_8_1.getLength() do
				local var_8_23 = var_8_1.indexOf(iter_8_5)

				if true or tostring(var_8_23.op_game_id) == "0" or tostring(var_8_23.op_game_id) == tostring(var_8_21) or tostring(var_8_23.op_game_id) == var_0_2({
					tostring(var_8_21),
					"_",
					var_8_22
				}) then
					var_8_18 = var_8_18 + 1
					var_8_19[var_8_18] = iter_8_5
					var_8_20[iter_8_5] = var_8_18
				else
					var_8_20[iter_8_5] = 1
				end
			end

			local var_8_24 = var_8_1.get_index_data()

			for iter_8_6, iter_8_7 in pairs(var_8_24) do
				var_8_24[iter_8_6] = var_8_20[iter_8_7]
			end

			function var_8_1.getLength()
				return var_8_18
			end

			var_8_1._indexOf = var_8_1.indexOf

			function var_8_1.indexOf(arg_12_0)
				return var_8_1._indexOf(var_8_19[arg_12_0])
			end

			var_8_1.__inited = true
		end
	end

	return var_8_1
end

function var_0_5:checkConfigDataClear(arg_13_1)
	if arg_13_1 then
		g.core.const.ConstMgr.BASE_CONST.CONFIG_CHECK_DATA_DELTA = 0
	end

	if self._cfgCache then
		for iter_13_0, iter_13_1 in pairs(self._cfgCache) do
			if iter_13_1 and iter_13_1.checkDataClear then
				iter_13_1:checkDataClear()
			end
		end
	end

	g.core.const.ConstMgr.BASE_CONST.CONFIG_CHECK_DATA_DELTA = g.core.const.ConstMgr.BASE_CONST.CONFIG_CHECK_DATA_DELTA
end

return var_0_5
