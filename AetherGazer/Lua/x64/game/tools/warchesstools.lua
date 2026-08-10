local var_0_0 = {}
local var_0_1, var_0_2 = pcall(require, "bit")

if not var_0_1 then
	local var_0_3

	var_0_3, var_0_2 = pcall(require, "bit32")
end

local var_0_4 = 32
local var_0_5 = 1

function var_0_0.DecodeFogInfo(arg_1_0)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
		local var_1_1 = var_0_2.tobit(iter_1_1)

		for iter_1_2 = var_0_4 - 1, 0, -1 do
			local var_1_2 = var_0_2.band(var_0_2.rshift(var_1_1, iter_1_2), var_0_5)

			table.insert(var_1_0, var_1_2 == 1)
		end
	end

	return var_1_0
end

local var_0_6 = {
	GUIDER_1094 = 1
}

function var_0_0.GetGuiderAssetPath(arg_2_0)
	local var_2_0 = WarchessLevelCfg[arg_2_0]

	if var_2_0 then
		for iter_2_0 = 1, #var_2_0.extra_gameplay do
			if var_2_0.extra_gameplay[iter_2_0] == var_0_6.GUIDER_1094 then
				return "Char/6070_tpose"
			end
		end
	end
end

function var_0_0.GetSubPlotViewName(arg_3_0)
	if arg_3_0 == ChessConst.SUBPLOT_TAG.HELLA then
		return "UI/VersionUI/HellaUI/HellaWarChessUI"
	end
end

return var_0_0
