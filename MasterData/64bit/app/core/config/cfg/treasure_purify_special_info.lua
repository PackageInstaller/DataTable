local var_0_0 = {}
local var_0_1 = loadCfg("core.config.cfg.language_info")

var_0_0.id = 0
var_0_0.type = 0
var_0_0.value = 0
var_0_0.size = 0
var_0_0.des = ""
var_0_0.quality_1 = 0
var_0_0.quality_2 = 0
var_0_0.quality_3 = 0
var_0_0.quality_4 = 0

local var_0_2 = {
	_data = {
		{
			0
		},
		{
			2,
			96,
			5
		},
		{
			3,
			97,
			5
		}
	}
}
local var_0_3 = {
	1,
	2,
	3
}
local var_0_4 = {
	id = 1,
	quality_1 = 6,
	quality_2 = 7,
	size = 4,
	quality_4 = 9,
	quality_3 = 8,
	type = 2,
	value = 3,
	des = 5
}
local var_0_5 = {}
local var_0_6 = {
	1,
	3,
	95,
	1,
	"",
	0,
	1,
	2,
	3
}
local var_0_7 = {
	__index = function(self, arg_1_1)
		local KsMath = require("app.core.utils.KsMath")
		local var_1_1 = math.ceil(#var_0_6 / 30)
		local var_1_2 = {}
		local var_1_3 = #var_0_6

		if arg_1_1 ~= "toObject" then
			assert(var_0_4[arg_1_1], "cannot find " .. arg_1_1 .. " in record_treasure_purify_special_info")

			var_1_3 = var_0_4[arg_1_1]
		end

		for iter_1_0 = 1, var_1_3 do
			local var_1_5

			if KsMath.mathBitSignCheck(self._raw[#self._raw - var_1_1 + math.ceil(iter_1_0 / 30)], ((iter_1_0 % 30 == 0 or nil) and 30) - 1) then
				var_1_2[iter_1_0] = 1
				var_1_5 = 1 + 1
			end
		end

		if arg_1_1 == "toObject" then
			return function()
				local var_2_0 = {}
				local var_2_1

				for iter_2_0, iter_2_1 in pairs(var_0_4) do
					if var_1_2[iter_2_1] then
						var_2_0[iter_2_0] = self._raw[var_1_2[iter_2_1]]
						var_2_1 = self._raw[var_1_2[iter_2_1]]
					else
						var_2_0[iter_2_0] = var_0_6[iter_2_1]
						var_2_1 = var_0_6[iter_2_1]
					end

					if var_0_5[iter_2_0] then
						var_2_0[iter_2_0] = var_0_1.get(var_2_1) and var_0_1.get(var_2_1).value or require("app.core.utils.KsMath").TRANS_ERROR_TIP()
					end
				end

				return var_2_0
			end
		end

		local var_1_6
		local var_1_7

		if var_1_2[var_0_4[arg_1_1]] then
			var_1_7 = self._raw[var_1_2[var_0_4[arg_1_1]]]
			var_1_6 = self._raw[var_1_2[var_0_4[arg_1_1]]]
		else
			var_1_7 = var_0_6[var_0_4[arg_1_1]]
			var_1_6 = var_0_6[var_0_4[arg_1_1]]
		end

		if var_0_5[arg_1_1] then
			return var_0_1.get(var_1_6) and var_0_1.get(var_1_6).value or require("app.core.utils.KsMath").TRANS_ERROR_TIP()
		end

		return var_1_7
	end
}

function var_0_2.getLength()
	return #var_0_2._data
end

function var_0_2.hasKey(arg_4_0)
	if var_0_4[arg_4_0] == nil then
		return false
	else
		return true
	end
end

function var_0_2.indexOf(arg_5_0)
	if arg_5_0 == nil or not var_0_2._data[arg_5_0] then
		return nil
	end

	return setmetatable({
		_raw = var_0_2._data[arg_5_0]
	}, var_0_7)
end

function var_0_2.get(arg_6_0)
	return var_0_2.indexOf(var_0_3[arg_6_0])
end

function var_0_2.set(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = var_0_2.get(arg_7_0)

	if var_7_0 then
		local KsMath = require("app.core.utils.KsMath")
		local var_7_2 = math.ceil(#var_0_6 / 30)
		local var_7_3 = {}

		for iter_7_0 = 1, var_0_4[arg_7_1] do
			local var_7_5

			if KsMath.mathBitSignCheck(var_7_0._raw[#var_7_0._raw - var_7_2 + math.ceil(iter_7_0 / 30)], ((iter_7_0 % 30 == 0 or nil) and 30) - 1) then
				var_7_3[iter_7_0] = 1
				var_7_5 = 1 + 1
			end
		end

		if var_7_3[var_0_4[arg_7_1]] then
			var_7_0._raw[var_7_3[var_0_4[arg_7_1]]] = arg_7_2
		end
	end
end

function var_0_2.get_index_data()
	return var_0_3
end

return var_0_2
