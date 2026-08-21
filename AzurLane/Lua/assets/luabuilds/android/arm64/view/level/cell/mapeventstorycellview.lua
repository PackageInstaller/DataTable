local var_0_0 = class("MapEventStoryCellView", import("view.level.cell.StaticCellView"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.attachTw = nil

	return
end

function var_0_0.GetOrder(arg_2_0)
	return ChapterConst.CellPriorityAttachment
end

function var_0_0.Update(arg_3_0)
	local var_3_2

	if IsNil(arg_3_0.go) then
		local var_3_1 = pg.map_event_template[arg_3_0.info.attachmentId].icon

		arg_3_0:PrepareBase("story_" .. arg_3_0.info.row .. "_" .. arg_3_0.info.column .. "_" .. arg_3_0.info.attachmentId)
		setAnchoredPosition(arg_3_0.tf, Vector2(0, 30))

		arg_3_0.attachTw = LeanTween.moveY(rtf(arg_3_0.go), 40, 1.5):setEase(LeanTweenType.easeInOutSine):setLoopPingPong()

		arg_3_0:GetLoader():GetPrefab("leveluiview/tpl_box", "tpl_box", function(arg_4_0)
			arg_4_0.name = var_3_1

			setParent(arg_4_0, arg_3_0.tf)
			setAnchoredPosition(arg_4_0, Vector2.zero)
			arg_3_0:GetLoader():GetPrefab("boxprefab/" .. var_3_1, var_3_1, function(arg_5_0)
				setParent(arg_5_0, tf(arg_4_0):Find("icon"))

				return
			end)

			return
		end)

		var_3_2 = setActive
	end

	var_3_2(arg_3_0.tf, arg_3_0.info.flag == ChapterConst.CellFlagActive)

	return
end

function var_0_0.DestroyGO(arg_6_0)
	if arg_6_0.attachTw then
		LeanTween.cancel(arg_6_0.attachTw.uniqueId)

		arg_6_0.attachTw = nil
	end

	var_0_0.super.DestroyGO(arg_6_0)

	return
end

return var_0_0
