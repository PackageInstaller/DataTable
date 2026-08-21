local var_0_0 = singletonClass("DormMultiFurnitureStructureManager")
local var_0_1 = import("..combineRule.rail")
local var_0_2 = {
	[var_0_1.STATION] = var_0_1
}

function var_0_0.Init(arg_1_0)
	return
end

function var_0_0.Reset(arg_2_0)
	return
end

local function var_0_3(arg_3_0)
	return var_0_2[arg_3_0]
end

function var_0_0.RefreshAllMultiFurnitureStructure(arg_4_0, arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		if not var_4_0[iter_4_1] then
			local var_4_1 = DormUtils.GetEntityData(iter_4_1)
			local var_4_2 = var_4_1.cfgID
			local var_4_3 = var_0_3(var_4_2)

			if var_4_3 then
				local var_4_4 = var_4_3.Match(iter_4_1, var_4_1.connect, var_4_0)

				if var_4_4 then
					for iter_4_2, iter_4_3 in pairs(var_4_4) do
						var_4_0[iter_4_3] = iter_4_1
					end
				end
			end
		end
	end
end

return var_0_0
