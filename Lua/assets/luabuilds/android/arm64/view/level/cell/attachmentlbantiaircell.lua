local var_0_0 = class("AttachmentLBAntiAirCell", import("view.level.cell.StaticCellView"))

function var_0_0.GetOrder(arg_1_0)
	return ChapterConst.CellPriorityAttachment
end

function var_0_0.Update(arg_2_0)
	local var_2_0 = arg_2_0.info

	if IsNil(arg_2_0.go) then
		arg_2_0:PrepareBase("antiAir")
		assert(pg.land_based_template[arg_2_0.info.attachmentId], "land_based_template not exist: " .. arg_2_0.info.attachmentId)
		arg_2_0:GetLoader():GetPrefab("leveluiview/Tpl_AntiAirGun", "Tpl_AntiAirGun", function(arg_3_0)
			setParent(arg_3_0, arg_2_0.tf)

			tf(arg_3_0).anchoredPosition3D = Vector3(0, 10, 0)
			arg_2_0.antiAirGun = arg_3_0

			arg_2_0:Update()

			return
		end)
		arg_2_0:GetLoader():GetPrefab("leveluiview/Tpl_AntiAirGunArea", "Tpl_AntiAirGunArea", function(arg_4_0)
			setParent(arg_4_0, arg_2_0.grid.restrictMap)

			arg_4_0.name = "chapter_cell_mark_" .. var_2_0.row .. "_" .. var_2_0.column .. "#AntiAirGunArea"

			local var_4_0 = arg_2_0.chapter.theme:GetLinePosition(arg_2_0.line.row, arg_2_0.line.column)

			tf(arg_4_0).anchoredPosition = Vector2(var_4_0.x - arg_2_0.grid.restrictMap.anchoredPosition.x, var_4_0.y - arg_2_0.grid.restrictMap.anchoredPosition.y)
			tf(arg_4_0).sizeDelta = Vector2((var_0.function_args[1] * 2 + 1) * arg_2_0.chapter.theme.cellSize.x + var_0.function_args[1] * 2 * arg_2_0.chapter.theme.cellSpace.x, (var_0.function_args[1] * 2 + 1) * arg_2_0.chapter.theme.cellSize.y + var_0.function_args[1] * 2 * arg_2_0.chapter.theme.cellSpace.y)

			return
		end)
	end

	if arg_2_0.antiAirGun and arg_2_0.info.flag ~= ChapterConst.CellFlagDisabled then
		local var_2_1 = math.ceil(arg_2_0.info.data / 2)

		assert(pg.land_based_template[arg_2_0.info.attachmentId], "land_based_template not exist: " .. arg_2_0.info.attachmentId)

		local var_2_2 = pg.land_based_template[arg_2_0.info.attachmentId].function_args[2]
		local var_2_3 = arg_2_0.chapter:getRoundNum()
		local var_2_4 = tf(arg_2_0.antiAirGun)

		setActive(var_2_4:Find("text"), var_2_3 < var_2_1)

		tf(arg_2_0.antiAirGun):Find("Slider"):GetComponent(typeof(Slider)).value = math.max(var_2_3 - var_2_1 + var_2_2, 0) / var_2_2
	end

	setActive(arg_2_0.tf, arg_2_0.info.flag ~= ChapterConst.CellFlagDisabled)

	return
end

return var_0_0
