class = var_0_10000

local var_0_0 = "AttachmentTransportTargetCell"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.level.cell.StaticCellView"))

function var_0_1.GetOrder(arg_1_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityAttachment
end

function var_0_1.Update(arg_2_0)
	local var_2_0 = arg_2_0.info

	IsNil = var_1_10002

	if var_1_10002(arg_2_0.go) then
		arg_2_0:PrepareBase("transport_target")

		local var_2_1 = arg_2_0:GetLoader()

		var_2.GetPrefab(var_2_1, "leveluiview/Tpl_TransportTarget", "Tpl_TransportTarget", function(arg_3_0)
			setParent = var_2_10001

			var_2_10001(arg_3_0, arg_2_0.tf)

			tf = var_2_10001

			local var_3_0 = var_2_10001(arg_3_0)

			Vector3 = var_2
			var_3_0.anchoredPosition3D = var_2.zero
			LeanTween = var_3_0

			local var_3_1 = var_3_0.moveY

			tf = var_2

			local var_3_2 = var_3_1(var_2(arg_3_0), 10, 1.5)
			local var_3_3 = var_1.setEase

			LeanTweenType = var_3

			local var_3_4 = var_3_3(var_3_2, var_3.easeInOutSine)
			local var_3_5 = var_1.setLoopPingPong(var_3_4)

			arg_2_0.attachTw = var_3_5.uniqueId

			local var_3_6 = arg_2_0

			var_2.ResetCanvasOrder(var_3_6)

			local var_3_7 = arg_2_0

			var_2.Update(var_3_7)

			return
		end)
	end

	return
end

function var_0_1.RemoveTween(arg_4_0)
	if arg_4_0.attachTw then
		LeanTween = var_1

		var_1.cancel(arg_4_0.attachTw)
	end

	arg_4_0.attachTw = nil

	return
end

function var_0_1.Clear(arg_5_0)
	arg_5_0:RemoveTween()
	var_0_1.super.Clear(arg_5_0)

	return
end

return var_0_1
