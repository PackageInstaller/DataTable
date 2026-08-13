class = var_0_10000

local var_0_0 = "AttachmentBoxCell"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.level.cell.StaticCellView"))

function var_0_1.GetOrder(arg_1_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityAttachment
end

function var_0_1.Update(arg_2_0)
	local var_2_0 = arg_2_0.info

	IsNil = var_1_10002

	local var_2_2

	if var_1_10002(arg_2_0.go) then
		pg = var_2

		local var_2_1 = var_2.box_data_template[var_2_0.attachmentId]

		assert = var_1_10003

		var_1_10003(var_2_1, "box_data_template not exist: " .. var_2_0.attachmentId)

		var_1_10003 = "box_" .. var_2_0.attachmentId
		var_1_10006 = arg_2_0

		arg_2_0.PrepareBase(var_1_10006, var_1_10003)

		var_2_2 = nil

		local var_2_3

		parallelAsync = var_1_10006

		var_1_10006({
			function(arg_3_0)
				local var_3_0 = arg_2_0
				local var_3_1 = var_1.GetLoader(var_3_0)

				var_1.GetPrefab(var_3_1, "boxprefab/" .. var_2_1.icon, var_2_1.icon, function(arg_4_0)
					var_2_3 = arg_4_0

					arg_3_0()

					return
				end)

				return
			end,
			function(arg_5_0)
				local var_5_0 = arg_2_0
				local var_5_1 = var_1.GetLoader(var_5_0)

				var_1.GetPrefab(var_5_1, "leveluiview/tpl_box", "tpl_box", function(arg_6_0)
					var_2_2 = arg_6_0
					setParent = var_3_10001
					tf = var_3_10003

					var_3_10001(var_3_10003(var_2_2), arg_2_0.tf)

					tf = var_3_10001

					local var_6_0 = var_3_10001(var_2_2)

					Vector3 = var_3_10002
					var_6_0.anchoredPosition3D = var_3_10002(0, 30, 0)

					local var_6_1 = var_2_1.type

					ChapterConst = var_2

					if var_6_1 ~= var_2.BoxTorpedo then
						LeanTween = var_6_1

						local var_6_2 = var_6_1.move

						tf = var_3

						local var_6_3 = var_3(var_2_2)

						Vector3 = var_4

						local var_6_4 = var_6_2(var_6_3, var_4(0, 40, 0), 1.5)
						local var_6_5 = var_1.setEase

						LeanTweenType = var_4

						local var_6_6 = var_6_5(var_6_4, var_4.easeInOutSine)
						local var_6_7 = var_1.setLoopPingPong(var_6_6)

						arg_2_0.attachTw = var_6_7.uniqueId
					end

					arg_2_0.box = var_2_2

					arg_5_0()

					return
				end)

				return
			end
		}, function()
			setParent = var_2_10000

			local var_7_0 = var_2_3

			tf = var_2_10003

			local var_7_1 = var_2_10003(var_2_2)

			var_2_10000(var_7_0, var_3.Find(var_7_1, "icon"))

			local var_7_2 = arg_2_0

			var_0.ResetCanvasOrder(var_7_2)

			local var_7_3 = arg_2_0

			var_0.Update(var_7_3)

			return
		end)
	end

	local var_2_4

	if arg_2_0.box then
		var_2_4 = var_2_0.flag
		ChapterConst = var_1_10003

		if var_2_4 == var_1_10003.CellFlagActive then
			setActive = var_2_4
			findTF = var_2_2

			local var_2_5 = var_2_2(arg_2_0.box, "effect_found")
			local var_2_6 = var_2_0.trait

			ChapterConst = var_1_10006

			var_2_4(var_2_5, var_2_6 == var_1_10006.TraitVirgin)

			var_2_4 = var_2_0.trait
			ChapterConst = var_3

			if var_2_4 == var_3.TraitVirgin then
				pg = var_2_4

				local var_2_7 = var_2_4.CriMgr.GetInstance()

				var_2_4 = var_2_4.PlaySoundEffect_V3
				SFX_UI_WEIGHANCHOR_ENEMY = var_5

				var_2_4(var_2_7, var_5)
			end
		end
	end

	setActive = var_2_4

	local var_2_8 = arg_2_0.tf
	local var_2_9 = var_2_0.flag

	ChapterConst = var_1_10006

	var_2_4(var_2_8, var_2_9 == var_1_10006.CellFlagActive)

	return
end

function var_0_1.RemoveTween(arg_8_0)
	if arg_8_0.attachTw then
		LeanTween = var_1

		var_1.cancel(arg_8_0.attachTw)
	end

	arg_8_0.attachTw = nil

	return
end

function var_0_1.Clear(arg_9_0)
	arg_9_0:RemoveTween()
	var_0_1.super.Clear(arg_9_0)

	return
end

return var_0_1
