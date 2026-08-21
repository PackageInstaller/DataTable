local var_0_0 = class("AttachmentLBDockCell", import("view.level.cell.StaticCellView"))

function var_0_0.GetOrder(arg_1_0)
	return ChapterConst.CellPriorityAttachment
end

function var_0_0.Update(arg_2_0)
	if IsNil(arg_2_0.go) then
		arg_2_0:PrepareBase("dock")
		arg_2_0:GetLoader():GetPrefab("leveluiview/Tpl_Dockyard", "Tpl_Dockyard", function(arg_3_0)
			setParent(arg_3_0, arg_2_0.tf)

			tf(arg_3_0).anchoredPosition3D = Vector3(0, 10, 0)
			arg_2_0.dock = tf(arg_3_0)

			arg_2_0:Update()

			return
		end)
	end

	if arg_2_0.dock then
		local var_2_0 = pg.land_based_template[arg_2_0.info.attachmentId]

		assert(pg.land_based_template[arg_2_0.info.attachmentId], "land_based_template not exist: " .. arg_2_0.info.attachmentId)

		local var_2_1 = arg_2_0.chapter:getRoundNum()
		local var_2_2 = math.ceil(arg_2_0.info.data / 2)

		setActive(arg_2_0.dock:Find("text"), var_2_1 < var_2_2)

		arg_2_0.dock:Find("Slider"):GetComponent(typeof(Slider)).value = math.max(var_2_1 - var_2_2 + var_2_0.function_args[2], 0) / var_2_0.function_args[2]
	end

	setActive(arg_2_0.tf, arg_2_0.info.flag == ChapterConst.CellFlagActive)

	return
end

return var_0_0
