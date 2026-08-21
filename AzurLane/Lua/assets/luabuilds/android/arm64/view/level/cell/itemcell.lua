local var_0_0 = class("ItemCell", import("view.level.cell.LevelCellView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0)

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

function var_0_0.Init(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return
	end

	arg_2_0.info = CreateShell(arg_2_1)

	return
end

function var_0_0.GetInfo(arg_3_0)
	return arg_3_0.info
end

function var_0_0.GetOriginalInfo(arg_4_0)
	local var_4_0 = arg_4_0.info and getmetatable(arg_4_0.info)

	return var_4_0 and var_4_0.__index
end

function var_0_0.Update(arg_5_0)
	arg_5_0.loader:GetPrefabBYStopLoading("chapter/" .. arg_5_0.info.item, arg_5_0.info.item, function(arg_6_0)
		arg_6_0.transform.name = var_0.item

		arg_6_0.transform:SetParent(arg_5_0.go, false)

		arg_6_0.transform.anchoredPosition3D = var_0.itemOffset

		arg_5_0:RecordCanvasOrder(arg_6_0.transform)
		arg_5_0:AddCanvasOrder(arg_6_0.transform, arg_5_0:GetCurrentOrder())

		return
	end, "ChapterItem" .. arg_5_0.line.row .. "_" .. arg_5_0.line.column)

	return
end

function var_0_0.UpdateAsset(arg_7_0, arg_7_1)
	if not arg_7_0.info or not arg_7_1 or arg_7_1 == rawget(arg_7_0.info, "item") then
		return
	end

	arg_7_0.info.item = arg_7_1

	arg_7_0:Update()

	return
end

function var_0_0.ClearLoader(arg_8_0)
	return
end

function var_0_0.Clear(arg_9_0)
	arg_9_0.loader:ClearRequest("ChapterItem" .. arg_9_0.line.row .. "_" .. arg_9_0.line.column)
	var_0_0.super.Clear(arg_9_0)

	return
end

function var_0_0.TransformItemAsset(arg_10_0, arg_10_1)
	if type(arg_10_1) ~= "string" then
		return
	end

	if type((arg_10_0:getConfig("ItemTransformPattern"))) ~= "table" then
		return arg_10_1
	end

	_.each(arg_10_0:getExtraFlags(), function(arg_11_0)
		if var_0[arg_11_0] and (function()
			local var_12_0 = var_0[arg_11_0][3]

			if not var_0[arg_11_0][3] then
				return true
			end

			return var_12_0 >= math.random()
		end)() then
			arg_10_1 = string.gsub(arg_10_1, var_0[arg_11_0][1], var_0[arg_11_0][2])
		end

		return
	end)

	return arg_10_1
end

return var_0_0
