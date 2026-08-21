local var_0_0 = class("MapEventStoryTriggerCellView", import(".StaticCellView"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.chapter = nil
	arg_1_0.triggerUpper = nil

	return
end

function var_0_0.GetOrder(arg_2_0)
	return ChapterConst.CellPriorityAttachment
end

function var_0_0.Update(arg_3_0)
	local var_3_0 = arg_3_0.info.flag == ChapterConst.CellFlagTriggerActive and arg_3_0.info.trait ~= ChapterConst.TraitLurk

	if IsNil(arg_3_0.go) then
		arg_3_0:PrepareBase("story_" .. arg_3_0.info.row .. "_" .. arg_3_0.info.column .. "_" .. arg_3_0.info.attachmentId)

		if IsNil(arg_3_0.triggerUpper) and pg.map_event_template[arg_3_0.info.attachmentId].icon and #pg.map_event_template[arg_3_0.info.attachmentId].icon > 0 and checkABExist("ui/" .. pg.map_event_template[arg_3_0.info.attachmentId].icon .. "_1shangceng") then
			arg_3_0.triggerUpper = HaloAttachmentView.New(arg_3_0.parent, arg_3_0.info.row, arg_3_0.info.column)

			arg_3_0.triggerUpper:SetLoader(arg_3_0.loader)
		end
	end

	local var_3_1 = pg.map_event_template[arg_3_0.info.attachmentId].icon
	local var_3_2

	var_3_2 = pg.map_event_template[arg_3_0.info.attachmentId].icon and #var_3_1 > 0 and var_3_1 .. "_1" or nil

	local var_3_3 = ItemCell.TransformItemAsset(arg_3_0.chapter, var_3_2)

	if arg_3_0.assetName ~= var_3_3 then
		if var_3_3 == nil then
			arg_3_0:GetLoader():ClearRequest("ItemAsset")

			arg_3_0.assetName = var_3_3
		else
			arg_3_0:GetLoader():GetPrefab("ui/" .. var_3_3, var_3_3, function(arg_4_0)
				setParent(arg_4_0, arg_3_0.tf)
				arg_3_0:ResetCanvasOrder()

				arg_3_0.assetName = var_3_3

				return
			end, "ItemAsset")
		end
	end

	setActive(arg_3_0.tf, var_3_0)

	if arg_3_0.triggerUpper then
		arg_3_0.triggerUpper.info = arg_3_0.info

		arg_3_0.triggerUpper:Update()
	end

	return
end

function var_0_0.DestroyGO(arg_5_0)
	if arg_5_0.triggerUpper then
		arg_5_0.triggerUpper:Clear()
	end

	arg_5_0.triggerUpper = nil

	var_0_0.super.DestroyGO(arg_5_0)

	return
end

return var_0_0
