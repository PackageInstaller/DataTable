local string = require("string")
local table = require("table")
local var_0_2 = _G
local var_0_3 = {}

if module then
	ltn12 = var_0_3
end

local var_0_4 = {}
local var_0_5 = {}
local var_0_6 = {}
local var_0_7 = {}

var_0_3.filter = var_0_4
var_0_3.source = var_0_5
var_0_3.sink = var_0_6
var_0_3.pump = var_0_7

local var_0_8 = unpack or table.unpack or table.unpack

var_0_3.BLOCKSIZE = 2048
var_0_3._VERSION = "LTN12 1.0.3"

function var_0_4.cycle(arg_1_0, arg_1_1, arg_1_2)
	var_0_2.assert(arg_1_0)

	return function(arg_2_0)
		local var_2_1, var_2_2 = arg_1_0(arg_1_1, arg_2_0, arg_1_2)

		arg_1_1 = var_2_2

		return var_2_1
	end
end

function var_0_4.chain(...)
	local var_3_0 = {
		...
	}
	local var_3_1 = var_0_2.select("#", ...)
	local var_3_2 = 1
	local var_3_3 = 1
	local var_3_4 = ""

	return function(arg_4_0)
		var_3_4 = arg_4_0 and var_3_4

		while true do
			if var_3_3 == var_3_2 then
				arg_4_0 = var_3_0[var_3_3](arg_4_0)

				if arg_4_0 == "" or var_3_2 == var_3_1 then
					return arg_4_0
				elseif arg_4_0 then
					var_3_3 = var_3_3 + 1
				else
					var_3_2 = var_3_2 + 1
					var_3_3 = var_3_2
				end
			else
				arg_4_0 = var_3_0[var_3_3](arg_4_0 or "")

				if arg_4_0 == "" then
					var_3_3 = var_3_3 - 1
					arg_4_0 = var_3_4
				elseif arg_4_0 then
					if var_3_3 == var_3_1 then
						return arg_4_0
					else
						var_3_3 = var_3_3 + 1
					end
				else
					var_0_2.error("filter returned inappropriate nil")
				end
			end
		end

		return
	end
end

local function var_0_10()
	return nil
end

function var_0_5.empty()
	return var_0_10
end

function var_0_5.error(arg_7_0)
	return function()
		return nil, arg_7_0
	end
end

function var_0_5.file(arg_9_0, arg_9_1)
	if arg_9_0 then
		return function()
			local var_10_0 = arg_9_0:read(var_0_3.BLOCKSIZE)

			if not var_10_0 then
				arg_9_0:close()
			end

			return var_10_0
		end
	else
		return var_0_5.error(arg_9_1 or "unable to open file")
	end

	return
end

function var_0_5.simplify(arg_11_0)
	var_0_2.assert(arg_11_0)

	return function()
		local var_12_0, var_12_1 = arg_11_0()

		arg_11_0 = var_12_1 or arg_11_0

		if not var_12_0 then
			return nil, var_12_1
		else
			return var_12_0
		end

		return
	end
end

function var_0_5.string(arg_13_0)
	if arg_13_0 then
		local var_13_0 = 1

		return function()
			local var_14_0 = string.sub(arg_13_0, var_13_0, var_13_0 + var_0_3.BLOCKSIZE - 1)

			var_13_0 = var_13_0 + var_0_3.BLOCKSIZE

			if var_14_0 ~= "" then
				return var_14_0
			else
				return nil
			end

			return
		end
	else
		return var_0_5.empty()
	end

	return
end

function var_0_5.rewind(arg_15_0)
	var_0_2.assert(arg_15_0)

	local var_15_0 = {}

	return function(arg_16_0)
		if not arg_16_0 then
			arg_16_0 = table.remove(var_15_0)

			if not arg_16_0 then
				return arg_15_0()
			else
				return arg_16_0
			end
		else
			table.insert(var_15_0, arg_16_0)
		end

		return
	end
end

function var_0_5.chain(arg_17_0, arg_17_1, ...)
	if ... then
		arg_17_1 = var_0_4.chain(arg_17_1, ...)
	end

	var_0_2.assert(arg_17_0 and arg_17_1)

	local var_17_0 = ""
	local var_17_1 = ""
	local var_17_2 = "feeding"
	local var_17_3

	return function()
		if not var_17_1 then
			var_0_2.error("source is empty!", 2)
		end

		while true do
			if var_17_2 == "feeding" then
				var_17_0, var_17_3 = arg_17_0()

				if var_17_3 then
					return nil, var_17_3
				end

				var_17_1 = arg_17_1(var_17_0)

				if not var_17_1 then
					if var_17_0 then
						var_0_2.error("filter returned inappropriate nil")
					else
						return nil
					end
				elseif var_17_1 ~= "" then
					var_17_2 = "eating"

					if var_17_0 then
						var_17_0 = ""
					end

					return var_17_1
				end
			else
				var_17_1 = arg_17_1(var_17_0)

				if var_17_1 == "" then
					if var_17_0 == "" then
						var_17_2 = "feeding"
					else
						var_0_2.error("filter returned \"\"")
					end
				elseif not var_17_1 then
					if var_17_0 then
						var_0_2.error("filter returned inappropriate nil")
					else
						return nil
					end
				else
					return var_17_1
				end
			end
		end

		return
	end
end

function var_0_5.cat(...)
	local var_19_0 = {
		...
	}
	local var_19_1 = table.remove(var_19_0, 1)

	return function()
		while var_19_1 do
			local var_20_0, var_20_1 = var_19_1()

			if var_20_0 then
				return var_20_0
			end

			if var_20_1 then
				return nil, var_20_1
			end

			var_19_1 = table.remove(var_19_0, 1)
		end

		return
	end
end

function var_0_6.table(arg_21_0)
	arg_21_0 = arg_21_0 or {}

	return function(arg_22_0, arg_22_1)
		if arg_22_0 then
			table.insert(arg_21_0, arg_22_0)
		end

		return 1
	end, arg_21_0
end

function var_0_6.simplify(arg_23_0)
	var_0_2.assert(arg_23_0)

	return function(arg_24_0, arg_24_1)
		local var_24_0, var_24_1 = arg_23_0(arg_24_0, arg_24_1)

		if not var_24_0 then
			return nil, var_24_1
		end

		arg_23_0 = var_24_1 or arg_23_0

		return 1
	end
end

function var_0_6.file(arg_25_0, arg_25_1)
	if arg_25_0 then
		return function(arg_26_0, arg_26_1)
			if not arg_26_0 then
				arg_25_0:close()

				return 1
			else
				return arg_25_0:write(arg_26_0)
			end

			return
		end
	else
		return var_0_6.error(arg_25_1 or "unable to open file")
	end

	return
end

local function var_0_11()
	return 1
end

function var_0_6.null()
	return var_0_11
end

function var_0_6.error(arg_29_0)
	return function()
		return nil, arg_29_0
	end
end

function var_0_6.chain(arg_31_0, arg_31_1, ...)
	if ... then
		local var_31_0 = {
			arg_31_0,
			arg_31_1,
			...
		}

		arg_31_1 = table.remove(var_31_0, #var_31_0)
		arg_31_0 = var_0_4.chain(var_0_8(var_31_0))
	end

	var_0_2.assert(arg_31_0 and arg_31_1)

	return function(arg_32_0, arg_32_1)
		if arg_32_0 ~= "" then
			local var_32_0 = arg_31_0(arg_32_0)
			local var_32_1 = arg_32_0 and ""

			while true do
				local var_32_2, var_32_3 = arg_31_1(var_32_0, arg_32_1)

				if not var_32_2 then
					return nil, var_32_3
				end

				if var_32_0 == var_32_1 then
					return 1
				end

				var_32_0 = arg_31_0(var_32_1)
			end
		else
			return 1
		end

		return
	end
end

function var_0_7.step(arg_33_0, arg_33_1)
	local var_33_0, var_33_1 = arg_33_0()
	local var_33_2, var_33_3 = arg_33_1(var_33_0, var_33_1)

	if var_33_0 and var_33_2 then
		return 1
	else
		return nil, var_33_1 or var_33_3
	end

	return
end

function var_0_7.all(arg_34_0, arg_34_1, arg_34_2)
	var_0_2.assert(arg_34_0 and arg_34_1)

	arg_34_2 = arg_34_2 or var_0_7.step

	while true do
		local var_34_0, var_34_1 = var_0_7.step(arg_34_0, arg_34_1)

		if not var_34_0 then
			if var_34_1 then
				return nil, var_34_1
			else
				return 1
			end
		end
	end

	return
end

return var_0_3
