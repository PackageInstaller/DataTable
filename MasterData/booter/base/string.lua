-- chunkname: @booter/base/string.lua

module("booter.base.string", package.seeall)

local string = {}

string._htmlspecialchars_set = {}
string._htmlspecialchars_set["&"] = "&amp;"
string._htmlspecialchars_set["\""] = "&quot;"
string._htmlspecialchars_set["'"] = "&#039;"
string._htmlspecialchars_set["<"] = "&lt;"
string._htmlspecialchars_set[">"] = "&gt;"

function string.nilorempty(input)
	return input == nil or string.len(input) == 0
end

function string.htmlspecialchars(input)
	for k, v in pairs(string._htmlspecialchars_set) do
		input = string.gsub(input, k, v)
	end

	return input
end

function string.restorehtmlspecialchars(input)
	for k, v in pairs(string._htmlspecialchars_set) do
		input = string.gsub(input, v, k)
	end

	return input
end

function string.nl2br(input)
	return string.gsub(input, "\n", "<br />")
end

function string.text2html(input)
	input = string.gsub(input, "\t", "    ")
	input = string.htmlspecialchars(input)
	input = string.gsub(input, " ", "&nbsp;")
	input = string.nl2br(input)

	return input
end

function string.split(input, delimiter)
	input = tostring(input)
	delimiter = tostring(delimiter)

	if delimiter == "" then
		return false
	end

	local pos, arr = 0, {}

	for st, sp in function()
		return string.find(input, delimiter, pos, true)
	end do
		table.insert(arr, string.sub(input, pos, st - 1))

		pos = sp + 1
	end

	table.insert(arr, string.sub(input, pos))

	return arr
end

function string.splitToNumber(input, delimiter)
	local arr = {}

	for i, v in ipairs(string.split(input, delimiter)) do
		arr[i] = tonumber(v)
	end

	return arr
end

function string.splitToVector2(input, delimiter)
	if input == nil or delimiter == nil then
		return nil
	end

	local arr = string.split(input, delimiter)

	if #arr == 2 then
		return Vector2.New(arr[1], arr[2])
	end

	return nil
end

function string.splitToVector3(input, delimiter)
	if input == nil or delimiter == nil then
		return nil
	end

	local arr = string.split(input, delimiter)

	if #arr == 3 then
		return Vector3.New(arr[1], arr[2], arr[3])
	end

	return nil
end

function string.trim(input)
	return (string.gsub(input, "^%s*(.-)%s*$", "%1"))
end

function string.ucfirst(input)
	return string.upper(string.sub(input, 1, 1)) .. string.sub(input, 2)
end

local function urlencodechar(char)
	return "%" .. string.format("%02X", string.byte(char))
end

function string.urlencode(input)
	input = string.gsub(tostring(input), "\n", "\r\n")
	input = string.gsub(input, "([^%w%.%- ])", urlencodechar)

	return string.gsub(input, " ", "+")
end

function string.urldecode(input)
	input = string.gsub(input, "+", " ")
	input = string.gsub(input, "%%(%x%x)", function(h)
		return string.char(checknumber(h, 16))
	end)
	input = string.gsub(input, "\r\n", "\n")

	return input
end

function string.utf8len(input)
	local left = string.len(input)
	local cnt = 0
	local arr = {
		0,
		192,
		224,
		240,
		248,
		252
	}

	while left ~= 0 do
		local tmp = string.byte(input, -left)
		local i = #arr

		while arr[i] do
			if tmp >= arr[i] then
				left = left - i

				break
			end

			i = i - 1
		end

		cnt = cnt + 1
	end

	return cnt
end

function string.formatnumberthousands(num)
	local formatted = tostring(checknumber(num))
	local k

	repeat
		local var_18_0, var_18_1 = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")

		formatted = var_18_0
	until var_18_1 == 0

	return formatted
end

function string.getValueByType(value, type)
	if type == "string" then
		return value
	elseif type == "number" then
		return tonumber(value)
	elseif type == "boolean" then
		return value == "1" or string.lower(value) == "true"
	end
end

function string.getFirstNum(str)
	local len = string.len(str)
	local ans, num

	for i = 1, len do
		local char = string.sub(str, i, i)

		num = tonumber(char)

		if num then
			ans = ans and ans * 10 + num or num
		elseif ans then
			break
		end
	end

	return ans
end

function string.getLastNum(str)
	local len = string.len(str)
	local ans, num
	local pow10 = 1

	for i = len, 1, -1 do
		local char = string.sub(str, i, i)

		num = tonumber(char)

		if num then
			ans = ans and num * pow10 + ans or num
			pow10 = pow10 * 10
		elseif ans then
			break
		end
	end

	return ans
end

setmetatable(string, {
	__index = _G.string
})
setGlobal("string", string)

return string
