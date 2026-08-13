class = var_0_10000

local var_0_0 = "ItemCell"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.level.cell.LevelCellView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_0.go.transform
	arg_1_0.line = {
		row = arg_1_2,
		column = arg_1_3
	}
	arg_1_0.assetName = nil

	arg_1_0:OverrideCanvas()
	arg_1_0:ResetCanvasOrder()

	return
end

function var_0_1.Init(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return
	end

	CreateShell = var_1_10002
	arg_2_0.info = var_1_10002(arg_2_1)

	return
end

function var_0_1.GetInfo(arg_3_0)
	return arg_3_0.info
end

function var_0_1.GetOriginalInfo(arg_4_0)
	local var_4_0

	if arg_4_0.info then
		getmetatable = var_4_0
		var_4_0 = var_4_0(arg_4_0.info)
	end

	return var_4_0 and var_4_0.__index
end

function var_0_1.Update(arg_5_0)
	local var_5_0 = arg_5_0.info
	local var_5_1 = arg_5_0.loader

	var_2.GetPrefabBYStopLoading(var_5_1, "chapter/" .. var_5_0.item, var_5_0.item, function(arg_6_0)
		local var_6_0 = arg_6_0.transform

		var_6_0.name = var_5_0.item

		var_6_0:SetParent(arg_5_0.go, false)

		var_6_0.anchoredPosition3D = var_5_0.itemOffset

		local var_6_1 = arg_5_0

		var_2.RecordCanvasOrder(var_6_1, var_6_0)

		local var_6_2 = arg_5_0
		local var_6_3 = var_2.AddCanvasOrder
		local var_6_4 = var_6_0
		local var_6_5 = arg_5_0

		var_6_3(var_6_2, var_6_4, var_5.GetCurrentOrder(var_6_5))

		return
	end, "ChapterItem" .. arg_5_0.line.row .. "_" .. arg_5_0.line.column)

	return
end

function var_0_1.UpdateAsset(arg_7_0, arg_7_1)
	if arg_7_0.info and arg_7_1 then
		rawget = var_2

		if arg_7_1 == var_2(arg_7_0.info, "item") then
			return
		end

		arg_7_0.info.item = arg_7_1

		arg_7_0:Update()

		return
	end
end

function var_0_1.ClearLoader(arg_8_0)
	return
end

function var_0_1.Clear(arg_9_0)
	local var_9_0 = arg_9_0.loader

	var_1.ClearRequest(var_9_0, "ChapterItem" .. arg_9_0.line.row .. "_" .. arg_9_0.line.column)
	var_0_1.super.Clear(arg_9_0)

	return
end

function var_0_1.TransformItemAsset(arg_10_0, arg_10_1)
	type = var_1_10002

	if var_1_10002(arg_10_1) ~= "string" then
		return
	end

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.getConfig(var_10_0, "ItemTransformPattern")

	type = var_10_0

	if var_10_0(var_10_1) ~= "table" then
		return arg_10_1
	end

	_ = var_3

	var_3.each(arg_10_0:getExtraFlags(), function(arg_11_0)
		if var_10_1[arg_11_0] and (function()
			if not var_10_1[arg_11_0][3] then
				return true
			end

			math = var_1

			return var_0 >= var_1.random()
		end)() then
			string = var_2
			arg_10_1 = var_2.gsub(arg_10_1, var_10_1[arg_11_0][1], var_10_1[arg_11_0][2])
		end

		return
	end)

	return arg_10_1
end

return var_0_1
