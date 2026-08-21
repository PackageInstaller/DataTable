local var_0_0 = PlayerPrefs.GetInt("EditorEnableLuaConfigOptimization", 1) == 1
local var_0_1 = PlayerPrefs.GetInt("EditorEnableLuaConfigOptimizationDebug", 0) == 1
local var_0_2 = false
local var_0_3

if var_0_1 then
	var_0_3 = {}
end

local var_0_4 = pairs

function pairs(arg_1_0)
	local var_1_0 = getmetatable(arg_1_0)

	if var_1_0 and var_1_0.__pairs then
		return var_1_0.__pairs(arg_1_0)
	end

	return var_0_4(arg_1_0)
end

local var_0_5 = {}

local function var_0_6(arg_2_0, arg_2_1)
	return arg_2_0:sub(1, #arg_2_1) == arg_2_1
end

local function var_0_7(arg_3_0)
	return StringTableFile.Instance:GetString(arg_3_0)
end

local function var_0_8(arg_4_0)
	return StringTableFile.Instance:GetOrAddString(arg_4_0)
end

local function var_0_9(arg_5_0, arg_5_1)
	local var_5_0 = {}

	if var_0_1 then
		var_0_3[var_5_0] = {
			path = arg_5_1,
			not_found_keys = {}
		}
	end

	local var_5_1 = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0) do
		if type(iter_5_0) ~= "string" or iter_5_0 ~= "all" and not var_0_6(iter_5_0, "get_id_list_by_") then
			var_5_1 = iter_5_1

			break
		end
	end

	local var_5_2 = {
		keys_map = {},
		string_hashed = {}
	}
	local var_5_3 = {}

	for iter_5_2, iter_5_3 in pairs(var_5_1) do
		var_5_2.keys_map[iter_5_2] = table.length(var_5_2.keys_map) + 1
	end

	function var_5_3.__index(arg_6_0, arg_6_1)
		local var_6_0 = var_5_2.keys_map[arg_6_1]

		if not var_6_0 then
			if var_0_1 and not var_0_3[var_5_0].not_found_keys[arg_6_1] then
				printf(var_0_3[var_5_0].path .. " key not found: " .. arg_6_1)

				var_0_3[var_5_0].not_found_keys[arg_6_1] = true
			end

			return nil
		end

		local var_6_1 = rawget(arg_6_0, var_6_0)

		if var_0_2 and var_5_2.string_hashed[var_6_0] and type(var_6_1) == "number" then
			return var_0_7(var_6_1)
		end

		return var_6_1
	end

	function var_5_3.__newindex(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = var_5_2.keys_map[arg_7_1]

		if not var_7_0 then
			var_5_2.keys_map[arg_7_1] = table.length(var_5_2.keys_map) + 1
			var_7_0 = var_5_2.keys_map[arg_7_1]

			if var_0_1 then
				printf(var_0_3[var_5_0].path .. " new key add: " .. arg_7_1)
			end
		end

		if var_0_2 and type(arg_7_2) == "string" then
			var_5_2.string_hashed[var_7_0] = true

			return rawset(arg_7_0, var_7_0, var_0_8(arg_7_2))
		end

		rawset(arg_7_0, var_7_0, arg_7_2)
	end

	function var_5_3.__pairs(arg_8_0)
		return function(arg_9_0, arg_9_1)
			local var_9_0, var_9_1 = next(var_5_2.keys_map, arg_9_1)

			if var_9_0 then
				local var_9_2 = arg_9_0[var_9_0]

				return var_9_0, var_9_2
			end

			return var_9_0, nil
		end, arg_8_0, nil
	end

	for iter_5_4, iter_5_5 in pairs(arg_5_0) do
		local var_5_4
		local var_5_5 = type(iter_5_4) == "string"

		if var_5_5 and iter_5_4 == "all" then
			var_5_4 = iter_5_5
		elseif var_5_5 and var_0_6(iter_5_4, "get_id_list_by_") then
			var_5_4 = iter_5_5
		else
			var_5_4 = {}

			setmetatable(var_5_4, var_5_3)

			for iter_5_6, iter_5_7 in pairs(iter_5_5) do
				if type(iter_5_7) == "table" and table.length(iter_5_7) == 0 then
					var_5_4[iter_5_6] = var_0_5
				else
					var_5_4[iter_5_6] = iter_5_7
				end
			end
		end

		var_5_0[iter_5_4] = var_5_4
	end

	return var_5_0
end

function import_and_optimize_config(arg_10_0)
	local var_10_0 = import(arg_10_0)

	if not var_0_0 then
		return var_10_0
	end

	if var_0_6(arg_10_0, "game.storyConfig.") then
		return var_10_0
	end

	local var_10_1 = var_0_9(var_10_0, arg_10_0)

	package.loaded[arg_10_0] = nil
	package.preload[arg_10_0] = nil

	return var_10_1
end
