module("bootstrap.core.string", package.seeall)

string._htmlspecialchars_set = {}
string._htmlspecialchars_set["&"] = "&amp;"
string._htmlspecialchars_set["\""] = "&quot;"
string._htmlspecialchars_set["'"] = "&#039;"
string._htmlspecialchars_set["<"] = "&lt;"
string._htmlspecialchars_set[">"] = "&gt;"

function string.nilorempty(arg_1_0)
	return arg_1_0 == nil or string.len(arg_1_0) == 0
end

function string.htmlspecialchars(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(string._htmlspecialchars_set) do
		arg_2_0 = string.gsub(arg_2_0, iter_2_0, iter_2_1)
	end

	return arg_2_0
end

function string.restorehtmlspecialchars(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(string._htmlspecialchars_set) do
		arg_3_0 = string.gsub(arg_3_0, iter_3_1, iter_3_0)
	end

	return arg_3_0
end

function string.nl2br(arg_4_0)
	return string.gsub(arg_4_0, "\n", "<br />")
end

function string.text2html(arg_5_0)
	arg_5_0 = string.gsub(arg_5_0, "\t", "    ")
	arg_5_0 = string.htmlspecialchars(arg_5_0)
	arg_5_0 = string.gsub(arg_5_0, " ", "&nbsp;")
	arg_5_0 = string.nl2br(arg_5_0)

	return arg_5_0
end

function string.split(arg_6_0, arg_6_1)
	arg_6_0 = tostring(arg_6_0)
	arg_6_1 = tostring(arg_6_1)

	if arg_6_1 == "" then
		return false
	end

	local var_6_0 = 0
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in function()
		return string.find(arg_6_0, arg_6_1, var_6_0, true)
	end do
		table.insert(var_6_1, string.sub(arg_6_0, var_6_0, iter_6_0 - 1))

		var_6_0 = iter_6_1 + 1
	end

	table.insert(var_6_1, string.sub(arg_6_0, var_6_0))

	return var_6_1
end

local function var_0_0(arg_8_0)
	if not arg_8_0 then
		return 0
	elseif arg_8_0 >= 252 then
		return 6
	elseif arg_8_0 >= 248 then
		return 5
	elseif arg_8_0 >= 240 then
		return 4
	elseif arg_8_0 >= 224 then
		return 3
	elseif arg_8_0 >= 192 then
		return 2
	else
		return 1
	end
end

function string.utf8split(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = 1
	local var_9_2 = string.len(arg_9_0)

	while var_9_1 <= var_9_2 do
		local var_9_3 = string.byte(arg_9_0, var_9_1)
		local var_9_4 = var_0_0(var_9_3)

		if var_9_4 > 0 then
			local var_9_5 = string.sub(arg_9_0, var_9_1, var_9_1 + var_9_4 - 1)

			table.insert(var_9_0, var_9_5)

			var_9_1 = var_9_1 + var_9_4
		else
			var_9_1 = var_9_1 + 1
		end
	end

	return var_9_0
end

function string.splitToNumber(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(string.split(arg_10_0, arg_10_1)) do
		var_10_0[iter_10_0] = tonumber(iter_10_1)
	end

	return var_10_0
end

function string.splitToVector2(arg_11_0, arg_11_1)
	if arg_11_0 == nil or arg_11_1 == nil then
		return nil
	end

	local var_11_0 = string.split(arg_11_0, arg_11_1)

	if #var_11_0 == 2 then
		return Vector2.New(var_11_0[1], var_11_0[2])
	end

	return nil
end

function string.splitToVector3(arg_12_0, arg_12_1)
	if arg_12_0 == nil or arg_12_1 == nil then
		return nil
	end

	local var_12_0 = string.split(arg_12_0, arg_12_1)

	if #var_12_0 == 3 then
		return Vector3.New(var_12_0[1], var_12_0[2], var_12_0[3])
	end

	return nil
end

function string.ltrim(arg_13_0)
	return string.gsub(arg_13_0, "^[ \t\n\r　]+", "")
end

function string.rtrim(arg_14_0)
	return string.gsub(arg_14_0, "[ \t\n\r　]+$", "")
end

function string.trim(arg_15_0)
	arg_15_0 = string.gsub(arg_15_0, "^[ \t\n\r　]+", "")

	return string.gsub(arg_15_0, "[ \t\n\r　]+$", "")
end

function string.ucfirst(arg_16_0)
	return string.upper(string.sub(arg_16_0, 1, 1)) .. string.sub(arg_16_0, 2)
end

local function var_0_1(arg_17_0)
	return "%" .. string.format("%02X", string.byte(arg_17_0))
end

function string.urlencode(arg_18_0)
	arg_18_0 = string.gsub(tostring(arg_18_0), "\n", "\r\n")
	arg_18_0 = string.gsub(arg_18_0, "([^%w%.%- ])", var_0_1)

	return string.gsub(arg_18_0, " ", "+")
end

function string.urldecode(arg_19_0)
	arg_19_0 = string.gsub(arg_19_0, "+", " ")
	arg_19_0 = string.gsub(arg_19_0, "%%(%x%x)", function(arg_20_0)
		return string.char(checknumber(arg_20_0, 16))
	end)
	arg_19_0 = string.gsub(arg_19_0, "\r\n", "\n")

	return arg_19_0
end

function string.utf8len(arg_21_0)
	local var_21_0 = string.len(arg_21_0)
	local var_21_1 = 0
	local var_21_2 = {
		0,
		192,
		224,
		240,
		248,
		252
	}

	while var_21_0 ~= 0 do
		local var_21_3 = string.byte(arg_21_0, -var_21_0)
		local var_21_4 = #var_21_2

		while var_21_2[var_21_4] do
			if var_21_3 >= var_21_2[var_21_4] then
				var_21_0 = var_21_0 - var_21_4

				break
			end

			var_21_4 = var_21_4 - 1
		end

		var_21_1 = var_21_1 + 1
	end

	return var_21_1
end

function string.formatnumberthousands(arg_22_0)
	local var_22_0 = tostring(checknumber(arg_22_0))
	local var_22_1

	repeat
		local var_22_2

		var_22_0, var_22_2 = string.gsub(var_22_0, "^(-?%d+)(%d%d%d)", "%1,%2")
	until var_22_2 == 0

	return var_22_0
end

function string.starts(arg_23_0, arg_23_1)
	return string.sub(arg_23_0, 1, string.len(arg_23_1)) == arg_23_1
end

function string.ends(arg_24_0, arg_24_1)
	return arg_24_1 == "" or string.sub(arg_24_0, -string.len(arg_24_1)) == arg_24_1
end
