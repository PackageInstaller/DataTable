local var_0_0 = class("AgoraDecorationVO")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.list = {}
	arg_1_0.agora = arg_1_2.agora
	arg_1_0.contoller = arg_1_2:GetController()

	return
end

function var_0_0.IsPlaced(arg_2_0, arg_2_1)
	return arg_2_0.agora:IsUsing(arg_2_1) or arg_2_0.contoller.selectedData and arg_2_0.contoller.selectedData.id == arg_2_1
end

function var_0_0.IsUsing(arg_3_0)
	return _.all(arg_3_0.list, function(arg_4_0)
		return arg_3_0:IsPlaced(arg_4_0.id)
	end)
end

function var_0_0.IsNew(arg_5_0)
	return _.any(arg_5_0.list, function(arg_6_0)
		return arg_6_0:IsNew()
	end)
end

function var_0_0.Read(arg_7_0)
	return arg_7_0:GetFirstItem():Read()
end

function var_0_0.GetRarity(arg_8_0)
	return arg_8_0:GetFirstItem():GetRarity()
end

function var_0_0.AddItem(arg_9_0, arg_9_1)
	table.insert(arg_9_0.list, arg_9_1)

	return
end

function var_0_0.GetFirstItem(arg_10_0)
	return arg_10_0.list[1]
end

function var_0_0.GetAvailableItem(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.list) do
		if not arg_11_0:IsPlaced(iter_11_1.id) then
			return iter_11_1
		end
	end

	return nil
end

function var_0_0.GetAvailableCnt(arg_12_0)
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.list) do
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
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.list) do
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

	return var_16_0:GetType() == arg_16_1
end

function var_0_0.IsMatchSearch(arg_17_0, arg_17_1)
	if not arg_17_1 or arg_17_1 == "" then
		return true
	end

	return arg_17_0:GetFirstItem():Match(arg_17_1)
end

function var_0_0.GetSortValue(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = 0

	var_18_0 = arg_18_1 == AgoraFurnitureType.SORT_RARITY and arg_18_0:GetFirstItem():GetRarity() or arg_18_1 == AgoraFurnitureType.SORT_TIME and arg_18_0:GetFirstItem():GetTime() or arg_18_1 == AgoraFurnitureType.SORT_CAPACITY and arg_18_0:GetFirstItem():GetCost() or arg_18_0:GetFirstItem().id

	return arg_18_2 == 1 and var_18_0 or -1 * var_18_0
end

function var_0_0.IsOptionalShapeType(arg_19_0)
	return arg_19_0:GetFirstItem():IsOptionalShapeType()
end

function var_0_0.IsBuilding(arg_20_0)
	return arg_20_0:GetFirstItem():IsBuildingType()
end

function var_0_0.IsFoundation(arg_21_0)
	return arg_21_0:GetFirstItem():IsFoundationType()
end

function var_0_0.GetThemeName(arg_22_0)
	local var_22_0 = arg_22_0:GetFirstItem()

	for iter_22_0, iter_22_1 in ipairs((arg_22_0.agora:GetSystemThemes())) do
		if iter_22_1:Belong(var_22_0) then
			return iter_22_1.name
		end
	end

	return i18n("agora_belong_theme_none")
end

return var_0_0
