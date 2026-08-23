local function var_0_0(arg_1_0, arg_1_1)
	local var_1_0
	local var_1_1 = arg_1_0

	while true do
		if string.byte(arg_1_0, 1) ~= 46 then
			var_1_1 = string.sub(arg_1_0, 1)

			if var_1_0 and #var_1_0 > 0 then
				var_1_1 = table.concat(var_1_0, ".") .. "." .. var_1_1
			end

			break
		end

		if not var_1_0 then
			if not arg_1_1 then
				local var_1_3, var_1_4 = debug.getlocal(3, 1)

				arg_1_1 = var_1_4
			end

			var_1_0 = string.split(arg_1_1, ".")
		end

		table.remove(var_1_0, #var_1_0)
	end

	return require(var_1_1)
end

local var_0_1 = _G.cc or require("cc")
local var_0_2 = var_0_0(".sdk.AbstractDumper")
local var_0_3 = var_0_0(".Cocos2dxNode")
local var_0_4 = var_0_1.Director:getInstance()
local var_0_5 = {}

var_0_5.__index = var_0_5

setmetatable(var_0_5, var_0_2)

function var_0_5.getRoot(arg_2_0)
	local var_2_0 = var_0_4:getWinSize()

	return var_0_3:new(var_0_4:getRunningScene(), var_2_0.width, var_2_0.height)
end

return var_0_5
