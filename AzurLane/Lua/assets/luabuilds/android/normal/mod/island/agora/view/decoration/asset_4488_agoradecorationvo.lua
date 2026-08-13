class = var_0_10000

local var_0_0 = var_0_10000("AgoraDecorationVO")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.list = {}
	arg_1_0.agora = arg_1_2.agora
	arg_1_0.contoller = arg_1_2:GetController()

	return
end

function var_0_0.IsPlaced(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.agora
	local var_2_1

	if not var_2.IsUsing(var_2_0, arg_2_1) and arg_2_0.contoller.selectedData then
		var_2_1 = arg_2_0.contoller.selectedData.id == arg_2_1
	end

	return var_2_1
end

function var_0_0.IsUsing(arg_3_0)
	_ = var_1_10001

	return var_1_10001.all(arg_3_0.list, function(arg_4_0)
		local var_4_0 = arg_3_0

		return var_1.IsPlaced(var_4_0, arg_4_0.id)
	end)
end

function var_0_0.IsNew(arg_5_0)
	_ = var_1_10001

	return var_1_10001.any(arg_5_0.list, function(arg_6_0)
		return arg_6_0:IsNew()
	end)
end

function var_0_0.Read(arg_7_0)
	local var_7_0 = arg_7_0:GetFirstItem()

	return var_1.Read(var_7_0)
end

function var_0_0.GetRarity(arg_8_0)
	local var_8_0 = arg_8_0:GetFirstItem()

	return var_1.GetRarity(var_8_0)
end

function var_0_0.AddItem(arg_9_0, arg_9_1)
	table = var_1_10002

	var_1_10002.insert(arg_9_0.list, arg_9_1)

	return
end

function var_0_0.GetFirstItem(arg_10_0)
	return arg_10_0.list[1]
end

function var_0_0.GetAvailableItem(arg_11_0)
	ipairs = var_1_10001

	for iter_11_0, iter_11_1 in var_1_10001(arg_11_0.list) do
		if not arg_11_0:IsPlaced(iter_11_1.id) then
			return iter_11_1
		end
	end

	return nil
end

function var_0_0.GetAvailableCnt(arg_12_0)
	local var_12_0 = 0

	ipairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(arg_12_0.list) do
		if not arg_12_0:IsPlaced(iter_12_1.id) then
			var_12_0 = var_12_0 + 1
		end
	end

	return var_12_0
end

function var_0_0.GetMaxCnt(arg_13_0)
	return #arg_13_0.list
end

function var_0_0.Contains(arg_14_0, arg_14_1)
	ipairs = var_1_10002

	for iter_14_0, iter_14_1 in var_1_10002(arg_14_0.list) do
		if iter_14_1.id == arg_14_1 then
			return true
		end
	end

	return false
end

function var_0_0.IsSame(arg_15_0, arg_15_1)
	return arg_15_0.id == arg_15_1
end

function var_0_0.IsType(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:GetFirstItem()

	return var_2.GetType(var_16_0) == arg_16_1
end

function var_0_0.IsMatchSearch(arg_17_0, arg_17_1)
	if not arg_17_1 or arg_17_1 == "" then
		return true
	end

	local var_17_0 = arg_17_0:GetFirstItem()

	return var_2.Match(var_17_0, arg_17_1)
end

function var_0_0.GetSortValue(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = 0

	AgoraFurnitureType = var_1_10004

	if arg_18_1 == var_1_10004.SORT_RARITY then
		local var_18_1 = arg_18_0:GetFirstItem()

		var_18_0 = var_4.GetRarity(var_18_1)
	else
		AgoraFurnitureType = var_4

		if arg_18_1 == var_4.SORT_TIME then
			local var_18_2 = arg_18_0:GetFirstItem()

			var_18_0 = var_4.GetTime(var_18_2)
		else
			AgoraFurnitureType = var_4

			if arg_18_1 == var_4.SORT_CAPACITY then
				local var_18_3 = arg_18_0:GetFirstItem()

				var_18_0 = var_4.GetCost(var_18_3)
			else
				var_18_0 = arg_18_0:GetFirstItem().id
			end
		end
	end

	return arg_18_2 == 1 and var_18_0 or -1 * var_18_0
end

function var_0_0.IsOptionalShapeType(arg_19_0)
	local var_19_0 = arg_19_0:GetFirstItem()

	return var_1.IsOptionalShapeType(var_19_0)
end

function var_0_0.IsBuilding(arg_20_0)
	local var_20_0 = arg_20_0:GetFirstItem()

	return var_1.IsBuildingType(var_20_0)
end

function var_0_0.IsFoundation(arg_21_0)
	local var_21_0 = arg_21_0:GetFirstItem()

	return var_1.IsFoundationType(var_21_0)
end

function var_0_0.GetThemeName(arg_22_0)
	local var_22_0 = arg_22_0:GetFirstItem()
	local var_22_1 = arg_22_0.agora
	local var_22_2 = var_2.GetSystemThemes(var_22_1)

	ipairs = var_22_1

	for iter_22_0, iter_22_1 in var_22_1(var_22_2) do
		if iter_22_1:Belong(var_22_0) then
			return iter_22_1.name
		end
	end

	i18n = var_3

	return var_3("agora_belong_theme_none")
end

return var_0_0
