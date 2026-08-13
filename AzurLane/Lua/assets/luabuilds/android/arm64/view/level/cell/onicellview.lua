import = var_0_10000

local var_0_0 = var_0_10000(".DynamicCellView")

class = var_0_10001

local var_0_1 = var_0_10001("OniCellView", var_0_0)

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0.tf

	arg_1_0.tfShadow = var_2.Find(var_1_0, "shadow")

	local var_1_1 = arg_1_0.tf

	arg_1_0.tfIcon = var_2.Find(var_1_1, "ship/icon")

	return
end

function var_0_1.GetOrder(arg_2_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityLittle
end

function var_0_1.SetActive(arg_3_0, arg_3_1)
	SetActive = var_1_10002

	var_1_10002(arg_3_0.tf, arg_3_1)

	return
end

function var_0_1.UpdateChampionCell(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_2.trait

	ChapterConst = var_1_10005

	if var_4_0 ~= var_1_10005.TraitLurk then
		var_1_10006 = arg_4_1

		if arg_4_1.getChampionVisibility(var_1_10006, arg_4_2) then
			var_1_10006 = arg_4_1
			var_4_0 = arg_4_1.existFleet
			FleetType = var_1_10007
			var_4_0 = not var_4_0(var_1_10006, var_1_10007.Transport, arg_4_2.row, arg_4_2.column)
		end
	else
		var_4_0 = false
	end

	if false then
		var_4_0 = true
	end

	local var_4_1 = 1

	_ = var_1_10006

	var_1_10006.each(arg_4_1.fleets, function(arg_5_0)
		local var_5_0 = arg_4_2

		if var_1.inAlertRange(var_5_0, arg_5_0.line.row, arg_5_0.line.column) then
			var_4_1 = var_4_1 + 1
		end

		return
	end)

	GetImageSpriteFromAtlasAsync = var_6

	var_6("enemies/sp_" .. var_4_1, "", arg_4_0.tfIcon, true)

	local var_4_2 = arg_4_0.tfShadow

	Vector3 = var_1_10007
	var_4_2.localEulerAngles = var_1_10007(arg_4_1.theme.angle, 0, 0)

	arg_4_0:RefreshLinePosition(arg_4_1, arg_4_2)
	arg_4_0:SetActive(var_4_0)

	existCall = var_6

	var_6(arg_4_3)

	return
end

return var_0_1
