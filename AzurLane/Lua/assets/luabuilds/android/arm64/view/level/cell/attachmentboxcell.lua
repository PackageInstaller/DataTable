local var_0_0 = class("AttachmentBoxCell", import("view.level.cell.StaticCellView"))

function var_0_0.GetOrder(arg_1_0)
	return ChapterConst.CellPriorityAttachment
end

function var_0_0.Update(arg_2_0)
	if IsNil(arg_2_0.go) then
		assert(pg.box_data_template[arg_2_0.info.attachmentId], "box_data_template not exist: " .. arg_2_0.info.attachmentId)
		arg_2_0:PrepareBase("box_" .. arg_2_0.info.attachmentId)

		local var_2_0
		local var_2_1

		parallelAsync({
			function(arg_3_0)
				arg_2_0:GetLoader():GetPrefab("boxprefab/" .. var_0.icon, var_0.icon, function(arg_4_0)
					var_2_1 = arg_4_0

					arg_3_0()

					return
				end)

				return
			end,
			function(arg_5_0)
				arg_2_0:GetLoader():GetPrefab("leveluiview/tpl_box", "tpl_box", function(arg_6_0)
					var_2_0 = arg_6_0

					setParent(tf(var_2_0), arg_2_0.tf)

					tf(var_2_0).anchoredPosition3D = Vector3(0, 30, 0)

					if var_0.type ~= ChapterConst.BoxTorpedo then
						arg_2_0.attachTw = LeanTween.move(tf(var_2_0), Vector3(0, 40, 0), 1.5):setEase(LeanTweenType.easeInOutSine):setLoopPingPong().uniqueId
					end

					arg_2_0.box = var_2_0

					arg_5_0()

					return
				end)

				return
			end
		}, function()
			setParent(var_2_1, tf(var_2_0):Find("icon"))
			arg_2_0:ResetCanvasOrder()
			arg_2_0:Update()

			return
		end)
	end

	if arg_2_0.box and arg_2_0.info.flag == ChapterConst.CellFlagActive then
		setActive(findTF(arg_2_0.box, "effect_found"), arg_2_0.info.trait == ChapterConst.TraitVirgin)

		if arg_2_0.info.trait == ChapterConst.TraitVirgin then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WEIGHANCHOR_ENEMY)
		end
	end

	setActive(arg_2_0.tf, arg_2_0.info.flag == ChapterConst.CellFlagActive)

	return
end

function var_0_0.RemoveTween(arg_8_0)
	if arg_8_0.attachTw then
		LeanTween.cancel(arg_8_0.attachTw)
	end

	arg_8_0.attachTw = nil

	return
end

function var_0_0.Clear(arg_9_0)
	arg_9_0:RemoveTween()
	var_0_0.super.Clear(arg_9_0)

	return
end

return var_0_0
