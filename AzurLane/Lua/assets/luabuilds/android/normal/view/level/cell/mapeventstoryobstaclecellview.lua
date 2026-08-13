class = var_0_10000

local var_0_0 = "MapEventStoryObstacleCellView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.level.cell.StaticCellView"))

function var_0_1.GetOrder(arg_1_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityAttachment
end

function var_0_1.Update(arg_2_0)
	local var_2_0 = arg_2_0.info

	IsNil = var_1_10002

	local var_2_1

	if var_1_10002(arg_2_0.go) then
		var_2_1 = var_2_0.row

		local var_2_2 = var_2_0.column

		var_1_10004 = "story_" .. var_2_1 .. "_" .. var_2_2 .. "_" .. var_2_0.attachmentId

		arg_2_0:PrepareBase(var_1_10004)
	end

	pg = var_2_1

	local var_2_3

	var_2_3 = var_2_1.map_event_template[var_2_0.attachmentId].icon and #var_3 > 0 and var_3 .. "_2" or nil
	ItemCell = var_1_10004

	local var_2_4 = var_1_10004.TransformItemAsset(arg_2_0.chapter, var_2_3)
	local var_2_5

	if arg_2_0.assetName ~= var_2_4 then
		if var_2_4 == nil then
			var_2_5 = arg_2_0
			var_2_5 = arg_2_0.GetLoader(var_2_5)

			var_4.ClearRequest(var_2_5, "ItemAsset")

			arg_2_0.assetName = var_2_4
		else
			var_2_5 = arg_2_0
			var_2_5 = arg_2_0.GetLoader(var_2_5)

			var_4.GetPrefab(var_2_5, "ui/" .. var_2_4, var_2_4, function(arg_3_0)
				setParent = var_2_10001

				var_2_10001(arg_3_0, arg_2_0.tf)

				local var_3_0 = arg_2_0

				var_1.ResetCanvasOrder(var_3_0)

				arg_2_0.assetName = var_2_4

				return
			end, "ItemAsset")
		end
	end

	local var_2_6 = var_2_0.flag

	ChapterConst = var_2_5

	local var_2_7 = var_2_6 == var_2_5.CellFlagTriggerActive

	pg = var_5

	local var_2_8 = var_5.map_event_template[var_2_0.attachmentId]

	if not var_2_7 and var_2_8 and var_2_8.animation and not arg_2_0.disappearAnim and var_2_8.animation and #var_6 > 0 then
		local var_2_9 = arg_2_0:GetLoader()

		var_7.GetPrefab(var_2_9, "ui/" .. var_6, var_6, function(arg_4_0)
			setParent = var_2_10001

			var_2_10001(arg_4_0.transform, arg_2_0.tf, false)

			local var_4_0 = arg_2_0

			var_1.ResetCanvasOrder(var_4_0)

			local var_4_1 = arg_4_0
			local var_4_2 = arg_4_0.GetComponent

			typeof = var_3
			ParticleSystemEvent = var_4

			local var_4_3 = var_4_2(var_4_1, var_3(var_4))

			IsNil = var_4_1

			if not var_4_1(var_4_3) then
				var_4_3:SetEndEvent(function()
					local var_5_0 = arg_2_0
					local var_5_1 = var_0.GetLoader(var_5_0)

					var_0.ClearRequest(var_5_1, "DisapperAnim")

					arg_2_0.playingAnim = false

					local var_5_2 = arg_2_0

					var_0.Update(var_5_2)

					return
				end)
			end

			return
		end, "DisapperAnim")

		arg_2_0.disappearAnim = true
		arg_2_0.playingAnim = true
	end

	setActive = var_6

	var_6(arg_2_0.tf, var_2_7 or arg_2_0.playingAnim)

	return
end

return var_0_1
