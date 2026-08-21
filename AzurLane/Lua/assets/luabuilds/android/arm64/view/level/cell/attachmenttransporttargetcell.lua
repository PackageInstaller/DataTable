local var_0_0 = class("AttachmentTransportTargetCell", import("view.level.cell.StaticCellView"))

function var_0_0.GetOrder(arg_1_0)
	return ChapterConst.CellPriorityAttachment
end

function var_0_0.Update(arg_2_0)
	if IsNil(arg_2_0.go) then
		arg_2_0:PrepareBase("transport_target")
		arg_2_0:GetLoader():GetPrefab("leveluiview/Tpl_TransportTarget", "Tpl_TransportTarget", function(arg_3_0)
			setParent(arg_3_0, arg_2_0.tf)

			tf(arg_3_0).anchoredPosition3D = Vector3.zero
			arg_2_0.attachTw = LeanTween.moveY(tf(arg_3_0), 10, 1.5):setEase(LeanTweenType.easeInOutSine):setLoopPingPong().uniqueId

			arg_2_0:ResetCanvasOrder()
			arg_2_0:Update()

			return
		end)
	end

	return
end

function var_0_0.RemoveTween(arg_4_0)
	if arg_4_0.attachTw then
		LeanTween.cancel(arg_4_0.attachTw)
	end

	arg_4_0.attachTw = nil

	return
end

function var_0_0.Clear(arg_5_0)
	arg_5_0:RemoveTween()
	var_0_0.super.Clear(arg_5_0)

	return
end

return var_0_0
