local var_0_0 = singletonClass("ParkourData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}
	var_0_4 = {}
end

function var_0_0.InitParkourCollectData(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.item_list) do
		table.insert(var_2_0, iter_2_1)
	end

	var_0_1[arg_2_1.activity_id] = var_2_0
end

function var_0_0.InitParkourData(arg_3_0, arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.achieve_star) do
		table.insert(var_3_0, iter_3_1)
	end

	local var_3_1 = {}

	for iter_3_2, iter_3_3 in ipairs(arg_3_1.achieve_star_reward) do
		table.insert(var_3_1, iter_3_3)
	end

	var_0_2[arg_3_1.activity_id] = {
		stars = var_3_0,
		rewards = var_3_1
	}
end

function var_0_0.GetParkourEntrustData(arg_4_0, arg_4_1)
	return var_0_2[arg_4_1]
end

function var_0_0.GetParkCollect(arg_5_0, arg_5_1)
	return var_0_1[arg_5_1] or {}
end

function var_0_0.SetParkourEntrustReward(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = var_0_2[arg_6_1]

	if var_6_0 then
		table.insert(var_6_0.rewards, arg_6_2)
	end
end

function var_0_0.GetParkourStarState(arg_7_0, arg_7_1, arg_7_2)
	if var_0_2[arg_7_1] then
		return not not table.indexof(var_0_2[arg_7_1].stars, arg_7_2)
	end

	return false
end

function var_0_0.GetParkourCollectList(arg_8_0)
	return var_0_1
end

function var_0_0.GetStarCount(arg_9_0, arg_9_1)
	local var_9_0 = var_0_2[arg_9_1]

	if var_9_0 then
		if table.indexof(var_9_0.stars, 4) then
			return #var_9_0.stars - 1
		else
			return #var_9_0.stars
		end
	end

	return 0
end

function var_0_0.GetAllStarCount(arg_10_0, arg_10_1)
	local var_10_0 = var_0_2[arg_10_1]

	if var_10_0 then
		return #var_10_0.stars
	end

	return 0
end

function var_0_0.SetRead(arg_11_0, arg_11_1)
	table.insert(var_0_3, arg_11_1)
end

function var_0_0.GetRead(arg_12_0, arg_12_1)
	return table.indexof(var_0_3, arg_12_1)
end

function var_0_0.GetCollectRedList(arg_13_0, arg_13_1)
	if not var_0_4[arg_13_1] then
		var_0_4[arg_13_1] = getData("Parkour", tostring(arg_13_1))
	end

	if type(var_0_4[arg_13_1]) ~= "table" then
		var_0_4[arg_13_1] = {}
	end

	return var_0_4[arg_13_1]
end

function var_0_0.SetParkourCollectRedPoint(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0:GetCollectRedList(arg_14_1)
	local var_14_1 = table.indexof(var_14_0, arg_14_2)

	if var_14_1 then
		table.remove(var_14_0, var_14_1)
		saveData("Parkour", tostring(arg_14_1), var_14_0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PARKOUR_COLLECT, arg_14_1), #var_14_0 > 0 and 1 or 0)
	end
end

return var_0_0
