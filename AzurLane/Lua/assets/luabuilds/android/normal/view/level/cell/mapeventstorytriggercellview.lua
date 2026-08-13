class = var_0_10000

local var_0_0 = "MapEventStoryTriggerCellView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".StaticCellView"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.chapter = nil
	arg_1_0.triggerUpper = nil

	return
end

function var_0_1.GetOrder(arg_2_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityAttachment
end

function var_0_1.Update(arg_3_0)
	local var_3_0 = arg_3_0.info.flag

	ChapterConst = var_1_10003

	if var_3_0 == var_1_10003.CellFlagTriggerActive then
		local var_3_1 = var_1.trait

		ChapterConst = var_3

		local var_3_2

		if var_3_1 == var_3.TraitLurk then
			var_3_2 = false
		else
			var_3_2 = true
		end

		IsNil = var_3

		local var_3_3

		if var_3(arg_3_0.go) then
			var_3_3 = var_1.row

			local var_3_4 = var_1.column

			var_1_10005 = "story_" .. var_3_3 .. "_" .. var_3_4 .. "_" .. var_1.attachmentId

			arg_3_0:PrepareBase(var_1_10005)

			pg = var_6

			local var_3_5 = var_6.map_event_template[var_1.attachmentId].icon

			IsNil = var_8

			if var_8(arg_3_0.triggerUpper) and var_3_5 and #var_3_5 > 0 then
				checkABExist = var_8

				if var_8("ui/" .. var_3_5 .. "_1shangceng") then
					HaloAttachmentView = var_8
					arg_3_0.triggerUpper = var_8.New(arg_3_0.parent, var_3_3, var_3_4)

					local var_3_6 = arg_3_0.triggerUpper

					var_8.SetLoader(var_3_6, arg_3_0.loader)
				end
			end
		end

		pg = var_3_3

		local var_3_7

		var_3_7 = var_3_3.map_event_template[var_1.attachmentId].icon and #var_4 > 0 and var_4 .. "_1" or nil
		ItemCell = var_1_10005

		local var_3_8 = var_1_10005.TransformItemAsset(arg_3_0.chapter, var_3_7)

		if arg_3_0.assetName ~= var_3_8 then
			if var_3_8 == nil then
				local var_3_9 = arg_3_0:GetLoader()

				var_5.ClearRequest(var_3_9, "ItemAsset")

				arg_3_0.assetName = var_3_8
			else
				local var_3_10 = arg_3_0:GetLoader()

				var_5.GetPrefab(var_3_10, "ui/" .. var_3_8, var_3_8, function(arg_4_0)
					setParent = var_2_10001

					var_2_10001(arg_4_0, arg_3_0.tf)

					local var_4_0 = arg_3_0

					var_1.ResetCanvasOrder(var_4_0)

					arg_3_0.assetName = var_3_8

					return
				end, "ItemAsset")
			end
		end

		setActive = var_5

		var_5(arg_3_0.tf, var_3_2)

		if arg_3_0.triggerUpper then
			arg_3_0.triggerUpper.info = arg_3_0.info

			local var_3_11 = arg_3_0.triggerUpper

			var_5.Update(var_3_11)
		end

		return
	end
end

function var_0_1.DestroyGO(arg_5_0)
	if arg_5_0.triggerUpper then
		local var_5_0 = arg_5_0.triggerUpper

		var_1.Clear(var_5_0)
	end

	arg_5_0.triggerUpper = nil

	var_0_1.super.DestroyGO(arg_5_0)

	return
end

return var_0_1
