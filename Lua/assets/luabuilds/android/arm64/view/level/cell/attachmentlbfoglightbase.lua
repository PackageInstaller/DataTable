local var_0_0 = class("AttachmentLBFogLightBase", import("view.level.cell.StaticCellView"))

var_0_0.StateLive = 1
var_0_0.StateDead = 2

function var_0_0.GetOrder(arg_1_0)
	return ChapterConst.CellPriorityAttachment
end

function var_0_0.Update(arg_2_0)
	if IsNil(arg_2_0.go) then
		arg_2_0:PrepareBase("landbase_" .. arg_2_0.info.attachmentId)
	end

	if arg_2_0.info.flag == ChapterConst.CellFlagActive and arg_2_0.state ~= var_0_0.StateLive then
		arg_2_0.state = var_0_0.StateLive
		arg_2_0.dead = nil

		arg_2_0:ClearLoader()
		assert(pg.land_based_template[arg_2_0.info.attachmentId], "land_based_template not exist: " .. arg_2_0.info.attachmentId)
		arg_2_0:GetLoader():GetPrefab("chapter/" .. pg.land_based_template[arg_2_0.info.attachmentId].prefab, "", function(arg_3_0)
			setParent(arg_3_0, arg_2_0.tf)

			arg_2_0.enemy = arg_3_0

			arg_2_0:ResetCanvasOrder()
			arg_2_0:Update()

			return
		end)
	elseif arg_2_0.info.flag == ChapterConst.CellFlagDisabled and arg_2_0.state ~= var_0_0.StateDead then
		arg_2_0.state = var_0_0.StateDead
		arg_2_0.enemy = nil

		arg_2_0:ClearLoader()
		assert(pg.land_based_template[arg_2_0.info.attachmentId], "land_based_template not exist: " .. arg_2_0.info.attachmentId)
		arg_2_0:GetLoader():GetPrefab("chapter/" .. pg.land_based_template[arg_2_0.info.attachmentId].prefab .. "_d_blue", "", function(arg_4_0)
			setParent(arg_4_0, arg_2_0.tf)

			arg_2_0.dead = arg_4_0

			arg_2_0:ResetCanvasOrder()
			arg_2_0:Update()

			return
		end)
	end

	return
end

return var_0_0
