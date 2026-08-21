local var_0_0 = class("AttachmentLBHarborCell", import("view.level.cell.StaticCellView"))

function var_0_0.GetOrder(arg_1_0)
	return ChapterConst.CellPriorityAttachment
end

function var_0_0.Update(arg_2_0)
	if IsNil(arg_2_0.go) then
		arg_2_0:PrepareBase("box_gangkou")
		arg_2_0:GetLoader():GetPrefab("leveluiview/Tpl_Box", "Tpl_Box", function(arg_3_0)
			setParent(arg_3_0, arg_2_0.tf)

			tf(arg_3_0).anchoredPosition3D = Vector3(0, 30, 0)

			arg_2_0:GetLoader():GetPrefab("boxprefab/gangkou", "gangkou", function(arg_4_0)
				tf(arg_4_0):SetParent(tf(arg_3_0):Find("icon"), false)

				return
			end)

			arg_2_0.box = arg_3_0

			arg_2_0:Update()

			return
		end)
	end

	if arg_2_0.box then
		setActive(findTF(arg_2_0.box, "effect_found"), arg_2_0.info.trait == ChapterConst.TraitVirgin)

		if arg_2_0.info.trait == ChapterConst.TraitVirgin then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WEIGHANCHOR_ENEMY)
		end
	end

	setActive(arg_2_0.tf, arg_2_0.info.flag == ChapterConst.CellFlagActive)

	return
end

return var_0_0
