class = var_0_10000

local var_0_0 = "CourtYardPedestalRoad"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardPedestalStructure"))
local var_0_2 = {
	-920,
	-1080,
	-1230,
	-1230
}

function var_0_1.GetAssetPath(arg_1_0)
	return "furnitrues/base/road_" .. arg_1_0.level
end

function var_0_1.OnLoaded(arg_2_0, arg_2_1)
	setAnchoredPosition = var_1_10002

	local var_2_0 = arg_2_1

	Vector3 = var_1_10005

	var_1_10002(var_2_0, var_1_10005(0, var_0_2[arg_2_0.level], 0))

	if arg_2_0.level ~= 4 then
		onButton = var_2

		local var_2_1 = arg_2_0
		local var_2_2 = arg_2_1.transform
		local var_2_3 = var_5.Find(var_2_2, "warn")

		local function var_2_4()
			CourtYardConst = var_2_10000

			if var_2_10000.MAX_STOREY_LEVEL + 1 == arg_2_0.level then
				return
			end

			local var_3_0 = arg_2_0

			if var_0.IsEditModeOrIsVisit(var_3_0) then
				return
			end

			local var_3_1 = arg_2_0.parent.msgBox

			var_0.ExecuteAction(var_3_1, "Show")

			return
		end

		SFX_PANEL = var_2_2

		var_2(var_2_1, var_2_3, var_2_4, var_2_2)

		onButton = var_2

		local var_2_5 = arg_2_0
		local var_2_6 = arg_2_1

		local function var_2_7()
			CourtYardConst = var_2_10000

			if var_2_10000.MAX_STOREY_LEVEL + 1 == arg_2_0.level then
				return
			end

			local var_4_0 = arg_2_0

			if var_0.IsEditModeOrIsVisit(var_4_0) then
				return
			end

			local var_4_1 = arg_2_0.parent.msgBox

			var_0.ExecuteAction(var_4_1, "Show")

			return
		end

		SFX_PANEL = var_2_2

		var_2(var_2_5, var_2_6, var_2_7, var_2_2)
	end

	tf = var_2

	local var_2_8 = var_2(arg_2_1)

	var_2.SetSiblingIndex(var_2_8, 0)

	return
end

function var_0_1.GetParent(arg_5_0)
	local var_5_0 = arg_5_0.parent._tf

	return var_1.Find(var_5_0, "base")
end

return var_0_1
