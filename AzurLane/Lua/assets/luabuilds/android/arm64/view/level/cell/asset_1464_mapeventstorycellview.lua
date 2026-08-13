class = var_0_10000

local var_0_0 = "MapEventStoryCellView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.level.cell.StaticCellView"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.attachTw = nil

	return
end

function var_0_1.GetOrder(arg_2_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityAttachment
end

function var_0_1.Update(arg_3_0)
	local var_3_0 = arg_3_0.info

	IsNil = var_1_10002

	if var_1_10002(arg_3_0.go) then
		local var_3_1 = var_3_0.row

		var_1_10003 = var_3_0.column

		local var_3_2 = var_3_0.data

		pg = var_1_10005

		local var_3_3 = var_1_10005.map_event_template[var_3_0.attachmentId].icon
		local var_3_4 = "story_" .. var_3_1 .. "_" .. var_1_10003 .. "_" .. var_3_0.attachmentId

		arg_3_0:PrepareBase(var_3_4)

		setAnchoredPosition = var_8

		local var_3_5 = arg_3_0.tf

		Vector2 = var_11

		var_8(var_3_5, var_11(0, 30))

		LeanTween = var_8

		local var_3_6 = var_8.moveY

		rtf = var_3_5

		local var_3_7 = var_3_6(var_3_5(arg_3_0.go), 40, 1.5)
		local var_3_8 = var_8.setEase

		LeanTweenType = var_11

		local var_3_9 = var_3_8(var_3_7, var_11.easeInOutSine)

		arg_3_0.attachTw = var_8.setLoopPingPong(var_3_9)

		local var_3_10 = arg_3_0:GetLoader()

		var_8.GetPrefab(var_3_10, "leveluiview/tpl_box", "tpl_box", function(arg_4_0)
			arg_4_0.name = var_3_3
			setParent = var_1

			var_1(arg_4_0, arg_3_0.tf)

			setAnchoredPosition = var_1

			local var_4_0 = arg_4_0

			Vector2 = var_4

			var_1(var_4_0, var_4.zero)

			local var_4_1 = arg_3_0
			local var_4_2 = var_1.GetLoader(var_4_1)

			var_1.GetPrefab(var_4_2, "boxprefab/" .. var_3_3, var_3_3, function(arg_5_0)
				setParent = var_3_10001

				local var_5_0 = arg_5_0

				tf = var_3_10004

				local var_5_1 = var_3_10004(arg_4_0)

				var_3_10001(var_5_0, var_4.Find(var_5_1, "icon"))

				return
			end)

			return
		end)
	end

	local var_3_11 = var_3_0.flag

	ChapterConst = var_1_10003

	local var_3_12 = var_3_11 == var_1_10003.CellFlagActive

	setActive = var_3

	var_3(arg_3_0.tf, var_3_12)

	return
end

function var_0_1.DestroyGO(arg_6_0)
	if arg_6_0.attachTw then
		LeanTween = var_1

		var_1.cancel(arg_6_0.attachTw.uniqueId)

		arg_6_0.attachTw = nil
	end

	var_0_1.super.DestroyGO(arg_6_0)

	return
end

return var_0_1
