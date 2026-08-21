local var_0_0 = class("HaloAttachmentView", import(".StaticCellView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.line = {
		row = arg_1_2,
		column = arg_1_3
	}

	return
end

function var_0_0.GetOrder(arg_2_0)
	return ChapterConst.CellPriorityUpperEffect
end

function var_0_0.Update(arg_3_0)
	local var_3_0 = arg_3_0.info.flag == ChapterConst.CellFlagTriggerActive and arg_3_0.info.trait ~= ChapterConst.TraitLurk

	if IsNil(arg_3_0.go) then
		arg_3_0:PrepareBase("story_" .. arg_3_0.line.row .. "_" .. arg_3_0.line.column .. "_" .. arg_3_0.info.attachmentId .. "_upper")

		if pg.map_event_template[arg_3_0.info.attachmentId].icon and #pg.map_event_template[arg_3_0.info.attachmentId].icon > 0 then
			arg_3_0:GetLoader():GetPrefab("ui/" .. pg.map_event_template[arg_3_0.info.attachmentId].icon .. "_1shangceng", pg.map_event_template[arg_3_0.info.attachmentId].icon .. "_1shangceng", function(arg_4_0)
				tf(arg_4_0):SetParent(arg_3_0.tf, false)
				arg_3_0:ResetCanvasOrder()

				return
			end)
		end
	end

	setActive(arg_3_0.tf, var_3_0)

	return
end

return var_0_0
