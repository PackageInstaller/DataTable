local var_0_0 = singletonClass("CustomStickerData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}

	for iter_1_0, iter_1_1 in ipairs(ProfileDecorateItemCfg.all) do
		local var_1_0 = ProfileDecorateItemCfg[iter_1_1]

		if var_1_0.item_type == 4 then
			var_0_2[iter_1_1] = {
				lock = true,
				page = 0
			}
		elseif var_1_0.item_type == 5 then
			var_0_1[iter_1_1] = {
				lock = true,
				page = 0
			}
		elseif var_1_0.item_type == 6 then
			var_0_3[iter_1_1] = {
				lock = true,
				page = 0
			}
		end
	end

	var_0_4 = {}
end

function var_0_0.GetAllStickerMap(arg_2_0)
	return var_0_1
end

function var_0_0.GetAllBackgroundMap(arg_3_0)
	return var_0_2
end

function var_0_0.GetAllForegroundMap(arg_4_0)
	return var_0_3
end

function var_0_0.GetAllStickerIDList(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(var_0_1) do
		table.insert(var_5_0, iter_5_0)
	end

	return var_5_0
end

function var_0_0.GetAllBackgroundIDList(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(var_0_2) do
		table.insert(var_6_0, iter_6_0)
	end

	return var_6_0
end

function var_0_0.GetAllForegroundIDList(arg_7_0)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(var_0_3) do
		table.insert(var_7_0, iter_7_0)
	end

	return var_7_0
end

return var_0_0
