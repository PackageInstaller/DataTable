class = var_0_10000

local var_0_0 = "AttachmentLBFogLightBase"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.level.cell.StaticCellView"))

var_0_1.StateLive = 1
var_0_1.StateDead = 2

function var_0_1.GetOrder(arg_1_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityAttachment
end

function var_0_1.Update(arg_2_0)
	local var_2_0 = arg_2_0.info

	IsNil = var_1_10002

	local var_2_1

	if var_1_10002(arg_2_0.go) then
		var_2_1 = arg_2_0

		arg_2_0.PrepareBase(var_2_1, "landbase_" .. var_2_0.attachmentId)
	end

	local var_2_2 = arg_2_0.state
	local var_2_3 = var_2_0.flag

	ChapterConst = var_2_1

	if var_2_3 == var_2_1.CellFlagActive and arg_2_0.state ~= var_0_1.StateLive then
		arg_2_0.state = var_0_1.StateLive
		arg_2_0.dead = nil

		arg_2_0:ClearLoader()

		pg = var_3

		local var_2_4 = var_3.land_based_template[var_2_0.attachmentId]

		assert = var_4

		var_4(var_2_4, "land_based_template not exist: " .. var_2_0.attachmentId)

		local var_2_5 = arg_2_0:GetLoader()

		var_4.GetPrefab(var_2_5, "chapter/" .. var_2_4.prefab, "", function(arg_3_0)
			setParent = var_2_10001

			var_2_10001(arg_3_0, arg_2_0.tf)

			arg_2_0.enemy = arg_3_0

			local var_3_0 = arg_2_0

			var_1.ResetCanvasOrder(var_3_0)

			local var_3_1 = arg_2_0

			var_1.Update(var_3_1)

			return
		end)
	else
		local var_2_6 = var_2_0.flag

		ChapterConst = var_4

		if var_2_6 == var_4.CellFlagDisabled and arg_2_0.state ~= var_0_1.StateDead then
			arg_2_0.state = var_0_1.StateDead
			arg_2_0.enemy = nil

			arg_2_0:ClearLoader()

			pg = var_3

			local var_2_7 = var_3.land_based_template[var_2_0.attachmentId]

			assert = var_4

			var_4(var_2_7, "land_based_template not exist: " .. var_2_0.attachmentId)

			local var_2_8 = arg_2_0:GetLoader()

			var_4.GetPrefab(var_2_8, "chapter/" .. var_2_7.prefab .. "_d_blue", "", function(arg_4_0)
				setParent = var_2_10001

				var_2_10001(arg_4_0, arg_2_0.tf)

				arg_2_0.dead = arg_4_0

				local var_4_0 = arg_2_0

				var_1.ResetCanvasOrder(var_4_0)

				local var_4_1 = arg_2_0

				var_1.Update(var_4_1)

				return
			end)
		end
	end

	return
end

return var_0_1
