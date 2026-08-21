local var_0_0 = class("MapEventStoryObstacleCellView", import("view.level.cell.StaticCellView"))

function var_0_0.GetOrder(arg_1_0)
	return ChapterConst.CellPriorityAttachment
end

function var_0_0.Update(arg_2_0)
	if IsNil(arg_2_0.go) then
		arg_2_0:PrepareBase("story_" .. arg_2_0.info.row .. "_" .. arg_2_0.info.column .. "_" .. arg_2_0.info.attachmentId)
	end

	local var_2_0 = pg.map_event_template[arg_2_0.info.attachmentId].icon
	local var_2_1

	var_2_1 = pg.map_event_template[arg_2_0.info.attachmentId].icon and #var_2_0 > 0 and var_2_0 .. "_2" or nil

	local var_2_2 = ItemCell.TransformItemAsset(arg_2_0.chapter, var_2_1)

	if arg_2_0.assetName ~= var_2_2 then
		if var_2_2 == nil then
			arg_2_0:GetLoader():ClearRequest("ItemAsset")

			arg_2_0.assetName = var_2_2
		else
			arg_2_0:GetLoader():GetPrefab("ui/" .. var_2_2, var_2_2, function(arg_3_0)
				setParent(arg_3_0, arg_2_0.tf)
				arg_2_0:ResetCanvasOrder()

				arg_2_0.assetName = var_2_2

				return
			end, "ItemAsset")
		end
	end

	local var_2_3 = arg_2_0.info.flag == ChapterConst.CellFlagTriggerActive
	local var_2_4 = pg.map_event_template[arg_2_0.info.attachmentId]

	if arg_2_0.info.flag ~= ChapterConst.CellFlagTriggerActive and var_2_4 and var_2_4.animation and not arg_2_0.disappearAnim then
		if var_2_4.animation and #var_2_4.animation > 0 then
			arg_2_0:GetLoader():GetPrefab("ui/" .. var_2_4.animation, var_2_4.animation, function(arg_4_0)
				setParent(arg_4_0.transform, arg_2_0.tf, false)
				arg_2_0:ResetCanvasOrder()

				local var_4_0 = arg_4_0:GetComponent(typeof(ParticleSystemEvent))

				if not IsNil(var_4_0) then
					var_4_0:SetEndEvent(function()
						arg_2_0:GetLoader():ClearRequest("DisapperAnim")

						arg_2_0.playingAnim = false

						arg_2_0:Update()

						return
					end)
				end

				return
			end, "DisapperAnim")

			arg_2_0.disappearAnim = true
			arg_2_0.playingAnim = true
		end
	end

	setActive(arg_2_0.tf, var_2_3 or arg_2_0.playingAnim)

	return
end

return var_0_0
