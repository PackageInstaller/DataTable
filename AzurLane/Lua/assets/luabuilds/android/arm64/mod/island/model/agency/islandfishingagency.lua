class = var_0_10000

local var_0_0 = "IslandFishingAgency"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseAgency"))

var_0_1.BAIT_UPDATE = "IslandFishingAgency:BAIT_UPDATE"

local var_0_2 = 1501

function var_0_1.OnInit(arg_1_0, arg_1_1)
	arg_1_0.severBaitId = arg_1_1.fish_sys.old_bait

	if arg_1_0.severBaitId == 0 then
		arg_1_0.baitId = var_0_2
	else
		arg_1_0.baitId = arg_1_0.severBaitId
	end

	arg_1_0.fishRodId = arg_1_1.fish_sys.fish_rod
	arg_1_0.fishList = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_1.fish_sys.fish_weight) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_1_0 = arg_1_0.fishList

		IslandFish = var_1_10010

		var_1_10007(var_1_0, var_1_10010.New(iter_1_1))
	end

	return
end

function var_0_1.UpdateFishRodId(arg_2_0, arg_2_1)
	arg_2_0.fishRodId = arg_2_1

	return
end

function var_0_1.NeedUpdateServerBait(arg_3_0)
	return arg_3_0.severBaitId ~= arg_3_0.baitId
end

function var_0_1.UpdateBaitId(arg_4_0, arg_4_1)
	arg_4_0.baitId = arg_4_1
	arg_4_0.severBaitId = arg_4_1

	arg_4_0:DispatchEvent(var_0_1.BAIT_UPDATE, arg_4_1)

	return
end

function var_0_1.GetBaitId(arg_5_0)
	return arg_5_0.baitId
end

function var_0_1.GetFishRodId(arg_6_0)
	return arg_6_0.fishRodId
end

function var_0_1.GetFishList(arg_7_0)
	return arg_7_0.fishList
end

function var_0_1.GetFish(arg_8_0, arg_8_1)
	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.fishList) do
		if iter_8_1.id == arg_8_1 then
			return iter_8_1
		end
	end

	return nil
end

function var_0_1.IsNewFish(arg_9_0, arg_9_1)
	ipairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0.fishList) do
		if iter_9_1.id == arg_9_1 then
			return false
		end
	end

	return true
end

function var_0_1.AddFish(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_0:IsNewFish(arg_10_1) then
		IslandFish = var_4

		local var_10_0 = var_4.New({
			fish_id = arg_10_1,
			max_weight = arg_10_2,
			min_weight = arg_10_2
		})

		var_4.SetCupState(var_10_0, arg_10_3)

		table = var_5

		var_5.insert(arg_10_0.fishList, var_4)
	else
		ipairs = var_4

		for iter_10_0, iter_10_1 in var_4(arg_10_0.fishList) do
			if iter_10_1.id == arg_10_1 then
				iter_10_1:SetWeight(arg_10_2)
				iter_10_1:SetCupState(arg_10_3)
			end
		end
	end

	return
end

function var_0_1.IsNewRecord(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0:IsNewFish(arg_11_1) then
		return false
	end

	ipairs = var_3

	for iter_11_0, iter_11_1 in var_3(arg_11_0.fishList) do
		if iter_11_1.id == arg_11_1 then
			return arg_11_2 > iter_11_1:GetMaxWeight()
		end
	end

	return false
end

return var_0_1
